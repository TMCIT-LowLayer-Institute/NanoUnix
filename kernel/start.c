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
#include "param.h"
#include "memlayout.h"
#include "riscv.h"
#include "defs.h"

void main();
void timerinit();

/* entry.S needs one stack per CPU. */
__attribute__ ((aligned (16))) char stack0[4096 * NCPU] = {};

/* a scratch area per CPU for machine-mode timer interrupts. */
uint64 timer_scratch[NCPU][5] = {};

/* assembly code in kernelvec.S for machine-mode timer interrupt. */
extern void timervec();

/* entry.S jumps here in machine mode on stack0. */
void
start()
{
        /* set M Previous Privilege mode to Supervisor, for mret. */
        unsigned long x = r_mstatus();
        x &= ~MSTATUS_MPP_MASK;
        x |= MSTATUS_MPP_S;
        w_mstatus(x);

        /*
         * set M Exception Program Counter to main, for mret.
         * requires gcc -mcmodel=medany
         */
        w_mepc((uint64)main);

        /* disable paging for now. */
        w_satp(0);

        /* delegate all interrupts and exceptions to supervisor mode. */
        w_medeleg(0xffff);
        w_mideleg(0xffff);
        w_sie(r_sie() | SIE_SEIE | SIE_STIE | SIE_SSIE);

        /*
         * configure Physical Memory Protection to give supervisor mode
         * access to all of physical memory.
         */
        w_pmpaddr0(0x3fffffffffffffull);
        w_pmpcfg0(0xf);

        /* ask for clock interrupts. */
        timerinit();

        /* keep each CPU's hartid in its tp register, for cpuid(). */
        int id = r_mhartid();
        w_tp(id);

        /* switch to supervisor mode and jump to main(). */
        __asm__ __volatile__("mret");
}

/*
 * arrange to receive timer interrupts.
 * they will arrive in machine mode at
 * at timervec in kernelvec.S,
 * which turns them into software interrupts for
 * devintr() in trap.c.
 */
void
timerinit()
{
        /* each CPU has a separate source of timer interrupts. */
        int id = r_mhartid();

        /* ask the CLINT for a timer interrupt. */
        int interval = 1000000; // cycles; about 1/10th second in qemu.
        *(uint64*)CLINT_MTIMECMP(id) = *(uint64*)CLINT_MTIME + interval;

        /*
         * prepare information in scratch[] for timervec.
         * scratch[0..2] : space for timervec to save registers.
         * scratch[3] : address of CLINT MTIMECMP register.
         * scratch[4] : desired interval (in cycles) between timer interrupts.
         */
        uint64 *scratch = &timer_scratch[id][0];
        scratch[3] = CLINT_MTIMECMP(id);
        scratch[4] = interval;
        w_mscratch((uint64)scratch);

        /* set the machine-mode trap handler. */
        w_mtvec((uint64)timervec);

        /* enable machine-mode interrupts. */
        w_mstatus(r_mstatus() | MSTATUS_MIE);

        /* enable machine-mode timer interrupts. */
        w_mie(r_mie() | MIE_MTIE);
}
