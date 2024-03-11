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
 * low-level driver routines for 16550a UART.
 */

#include "types.h"
#include "param.h"
#include "memlayout.h"
#include "riscv.h"
#include "spinlock.h"
#include "proc.h"
#include "defs.h"

/*
 * the UART control registers are memory-mapped
 * at address UART0. this macro returns the
 * address of one of the registers.
 */
#define Reg(reg) ((volatile unsigned char *)(UART0 + reg))

/*
 * the UART control registers.
 * some have different meanings for
 * read vs write.
 * see http://byterunner.com/16550.html
 */
#define RHR 0                 /* receive holding register (for input bytes) */
#define THR 0                 /* transmit holding register (for output bytes) */
#define IER 1                 /* interrupt enable register */
#define IER_RX_ENABLE (1<<0)
#define IER_TX_ENABLE (1<<1)
#define FCR 2                 /* FIFO control register */
#define FCR_FIFO_ENABLE (1<<0)
#define FCR_FIFO_CLEAR (3<<1) /* clear the content of the two FIFOs */
#define ISR 2                 /* interrupt status register */
#define LCR 3                 /* line control register */
#define LCR_EIGHT_BITS (3<<0)
#define LCR_BAUD_LATCH (1<<7) /* special mode to set baud rate */
#define LSR 5                 /* line status register */
#define LSR_RX_READY (1<<0)   /* input is waiting to be read from RHR */
#define LSR_TX_IDLE (1<<5)    /* THR can accept another character to send */

#define ReadReg(reg) (*(Reg(reg)))
#define WriteReg(reg, v) (*(Reg(reg)) = (v))

/* the transmit output buffer. */
struct spinlock uart_tx_lock = {};
#define UART_TX_BUF_SIZE 32
char uart_tx_buf[UART_TX_BUF_SIZE] = {};
uint64 uart_tx_w = 0; /* write next to uart_tx_buf[uart_tx_w % UART_TX_BUF_SIZE] */
uint64 uart_tx_r = 0; /* read next from uart_tx_buf[uart_tx_r % UART_TX_BUF_SIZE] */

extern volatile int panicked; /* from printf.c */

void uartstart();

void
uartinit(void)
{
        /* disable interrupts. */
        WriteReg(IER, 0x00);

        /* special mode to set baud rate. */
        WriteReg(LCR, LCR_BAUD_LATCH);

        /* LSB for baud rate of 38.4K. */
        WriteReg(0, 0x03);

        /* MSB for baud rate of 38.4K. */
        WriteReg(1, 0x00);

        /*
         * leave set-baud mode,
         * and set word length to 8 bits, no parity.
         */
        WriteReg(LCR, LCR_EIGHT_BITS);

        /* reset and enable FIFOs. */
        WriteReg(FCR, FCR_FIFO_ENABLE | FCR_FIFO_CLEAR);

        /* enable transmit and receive interrupts. */
        WriteReg(IER, IER_TX_ENABLE | IER_RX_ENABLE);

        initlock(&uart_tx_lock, "uart");
}

/*
 * add a character to the output buffer and tell the
 * UART to start sending if it isn't already.
 * blocks if the output buffer is full.
 * because it may block, it can't be called
 * from interrupts; it's only suitable for use
 * by write().
 */
void
uartputc(int c)
{
        acquire(&uart_tx_lock);

        if(panicked){
                for(;;)
                        ;
        }
        while(uart_tx_w == uart_tx_r + UART_TX_BUF_SIZE){
                /*
                 * buffer is full.
                 * wait for uartstart() to open up space in the buffer.
                 */
                sleep(&uart_tx_r, &uart_tx_lock);
        }
        uart_tx_buf[uart_tx_w % UART_TX_BUF_SIZE] = c;
        uart_tx_w += 1;
        uartstart();
        release(&uart_tx_lock);
}


/*
 * alternate version of uartputc() that doesn't 
 * use interrupts, for use by kernel printf() and
 * to echo characters. it spins waiting for the uart's
 * output register to be empty.
 */
void
uartputc_sync(int c)
{
        push_off();

        if(panicked){
                for(;;)
                        ;
        }

        /* wait for Transmit Holding Empty to be set in LSR. */
        while((ReadReg(LSR) & LSR_TX_IDLE) == 0)
                ;
        WriteReg(THR, c);

        pop_off();
}

/*
 * if the UART is idle, and a character is waiting
 * in the transmit buffer, send it.
 * caller must hold uart_tx_lock.
 * called from both the top- and bottom-half.
 */
void
uartstart()
{
        while(1){
                if(uart_tx_w == uart_tx_r){
                        /* transmit buffer is empty. */
                        return;
                }

                if((ReadReg(LSR) & LSR_TX_IDLE) == 0){
                        /*
                         * the UART transmit holding register is full,
                         * so we cannot give it another byte.
                         * it will interrupt when it's ready for a new byte.
                         */
                        return;
                }

                int c = uart_tx_buf[uart_tx_r % UART_TX_BUF_SIZE];
                uart_tx_r += 1;

                /* maybe uartputc() is waiting for space in the buffer. */
                wakeup(&uart_tx_r);

                WriteReg(THR, c);
        }
}

/*
 * read one input character from the UART.
 * return -1 if none is waiting.
 */
int
uartgetc(void)
{
        if(ReadReg(LSR) & 0x01){
                /* input data is ready. */
                return ReadReg(RHR);
        } else {
                return -1;
        }
}

/*
 * handle a uart interrupt, raised because input has
 * arrived, or the uart is ready for more output, or
 * both. called from devintr().
 */
void
uartintr(void)
{
        /* read and process incoming characters. */
        while(1){
                int c = uartgetc();
                if(c == -1)
                        break;
                consoleintr(c);
        }

        /* send buffered characters. */
        acquire(&uart_tx_lock);
        uartstart();
        release(&uart_tx_lock);
}
