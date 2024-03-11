/*
 * Copyright (c) 2024 TMCIT-LowLayer-Institute.. All rights reserved.
 *
 * Redistribution and use in source and binary forms, with or without modification,
 * are permitted provided that the following conditions are met:
 *
 * 1. Redistributions of source code must retain the above copyright notice,
 *    this list of conditions and the following disclaimer.
 * 2. Redistributions in binary form must reproduce the above copyright notice,
 *    this list of conditions and the following disclaimer in the documentation
 *    and/or other materials provided with the distribution.
 * 3. All advertising materials mentioning features or use of this software
 *    must display the following acknowledgement:
 *    This product includes software developed by the organization.
 * 4. Neither the name of the copyright holder nor the names the copyright holder
 *    nor the names of its contributors may be used to endorse or promote products
 *    derived from this software without specific prior written permission.
 *
 * THIS SOFTWARE IS PROVIDED BY COPYRIGHT HOLDER "AS IS" AND ANY EXPRESS OR IMPLIED
 * WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED WARRANTIES OF MERCHANTABILITY
 * AND FITNESS FOR A PARTICULAR PURPOSE ARE DISCLAIMED. IN NO EVENT SHALL COPYRIGHT HOLDER
 * BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL
 * DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES;
 * LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY
 * THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING NEGLIGENCE
 * OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS SOFTWARE, EVEN IF ADVISED OF
 * THE POSSIBILITY OF SUCH DAMAGE.
 */

/*
 * Console input and output, to the uart.
 * Reads are line at a time.
 * Implements special input characters:
 * newline -- end of line
 * control-h -- backspace
 * control-u -- kill line
 * control-d -- end of file
 * control-p -- print process list
 */

#include "types.h"
#include "param.h"
#include "spinlock.h"
#include "sleeplock.h"
#include "fs.h"
#include "file.h"
#include "memlayout.h"
#include "riscv.h"
#include "defs.h"
#include "proc.h"

constexpr auto BACKSPACE = 0x100;
#define C(x)  ((x)-'@')  /* Control-x */

/*
 * send one character to the uart.
 * called by printf(), and to echo input characters,
 * but not from write().
 */
void
consputc(int const c)
{
        if(c == BACKSPACE){
                /* if the user typed backspace, overwrite with a space. */
                uartputc_sync('\b'); uartputc_sync(' '); uartputc_sync('\b');
        } else {
                uartputc_sync(c);
        }
}

/* input */
constexpr uint INPUT_BUF_SIZE = 128;

struct cons{
        struct spinlock lock;

        char buf[INPUT_BUF_SIZE];
        uint r;  /* Read index */
        uint w;  /* Write index */
        uint e;  /* Edit index */
};

struct cons cons = {};

/*
 * user write()s to the console go here.
 */
int
consolewrite(int const user_src, uint64 const src, int const n)
{
        int i = 0;
        for(i = 0; i < n; i++){
                char c;
                if(either_copyin(&c, user_src, src+i, 1) == -1)
                        break;
                uartputc(c);
        }

        return i;
}

/*
 * user read()s from the console go here.
 * copy (up to) a whole input line to dst.
 * user_dist indicates whether dst is a user
 * or kernel address.
 */
int
consoleread(int const user_dst, uint64 dst, int n)
{
        uint target = undefined;
        int c = undefined;
        char cbuf = undefined;

        target = n;
        acquire(&cons.lock);
        while(n > 0){
                /*
                 * wait until interrupt handler has put some
                 * input into cons.buffer.
                 */
                while(cons.r == cons.w){
                        if(killed(myproc())){
                                release(&cons.lock);
                                return -1;
                        }
                        sleep(&cons.r, &cons.lock);
                }

                c = cons.buf[cons.r++ % INPUT_BUF_SIZE];

                if(c == C('D')){  /* end-of-file */
                        if(n < target){
                                /*
                                 * Save ^D for next time, to make sure
                                 * caller gets a 0-byte result.
                                 */
                                cons.r--;
                        }
                        break;
                }

                /* copy the input byte to the user-space buffer. */
                cbuf = c;
                if(either_copyout(user_dst, dst, &cbuf, 1) == -1)
                        break;

                dst++;
                --n;

                if(c == '\n'){
                        /*
                         * a whole line has arrived, return to
                         * the user-level read().
                         */
                        break;
                }
        }
        release(&cons.lock);

        return target - n;
}

/*
 * the console input interrupt handler.
 * uartintr() calls this for input character.
 * do erase/kill processing, append to cons.buf,
 * wake up consoleread() if a whole line has arrived.
 */
void
consoleintr(int c)
{
        acquire(&cons.lock);

        switch(c){
                case C('P'):  /* Print process list. */
                        procdump();
                        break;
                case C('U'):  /* Kill line. */
                        while(cons.e != cons.w &&
                                        cons.buf[(cons.e-1) % INPUT_BUF_SIZE] != '\n'){
                                cons.e--;
                                consputc(BACKSPACE);
                        }
                        break;
                case C('H'): /* Backspace */
                case '\x7f': /* Delete key */
                        if(cons.e != cons.w){
                                cons.e--;
                                consputc(BACKSPACE);
                        }
                        break;
                default:
                        if(c != 0 && cons.e-cons.r < INPUT_BUF_SIZE){
                                c = (c == '\r') ? '\n' : c;

                                /* echo back to the user. */
                                consputc(c);

                                /* store for consumption by consoleread(). */
                                cons.buf[cons.e++ % INPUT_BUF_SIZE] = c;

                                if(c == '\n' || c == C('D') || cons.e-cons.r == INPUT_BUF_SIZE){
                                        /*
                                         * wake up consoleread() if a whole line (or end-of-file)
                                         * has arrived.
                                         */
                                        cons.w = cons.e;
                                        wakeup(&cons.r);
                                }
                        }
                        break;
        }

        release(&cons.lock);
}

void
consoleinit(void)
{
        initlock(&cons.lock, "cons");

        uartinit();

        /*
         * connect read and write system calls
         * to consoleread and consolewrite.
         */
        devsw[CONSOLE].read = consoleread;
        devsw[CONSOLE].write = consolewrite;
}
