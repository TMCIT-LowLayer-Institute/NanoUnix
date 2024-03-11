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

#include "types.h"
#include "riscv.h"
#include "defs.h"
#include "param.h"
#include "memlayout.h"
#include "spinlock.h"
#include "proc.h"

uint64
sys_exit(void)
{
        int n = undefined;
        argint(0, &n);
        exit(n);
        return 0;  /* not reached */
}

uint64
sys_getpid(void)
{
        return myproc()->pid;
}

uint64
sys_fork(void)
{
        return fork();
}

uint64
sys_wait(void)
{
        uint64 p = undefined;
        argaddr(0, &p);
        return wait(p);
}

uint64
sys_sbrk(void)
{
        uint64 addr = undefined;
        int n = undefined;

        argint(0, &n);
        addr = myproc()->sz;
        if(growproc(n) < 0)
                return -1;
        return addr;
}

uint64
sys_sleep(void)
{
        int n = undefined;
        uint ticks0 = undefined;

        argint(0, &n);
        acquire(&tickslock);
        ticks0 = ticks;
        while(ticks - ticks0 < n){
                if(killed(myproc())){
                        release(&tickslock);
                        return -1;
                }
                sleep(&ticks, &tickslock);
        }
        release(&tickslock);
        return 0;
}

uint64
sys_kill(void)
{
        int pid = undefined;

        argint(0, &pid);
        return kill(pid);
}

/*
 * return how many clock tick interrupts have occurred
 * since start.
 */
uint64
sys_uptime(void)
{
        uint xticks = undefined;

        acquire(&tickslock);
        xticks = ticks;
        release(&tickslock);
        return xticks;
}
