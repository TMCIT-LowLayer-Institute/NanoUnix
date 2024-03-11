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

volatile static int started = 0;

/*
 * start() jumps here in supervisor mode on all CPUs.
 */
int
main(void) 
{
	if (cpuid() == 0) {
		consoleinit();
		printfinit();
		printf("\n");
		printf("xv6 kernel is booting\n");
		printf("    ________  ________ _____ _____      _                   _                                _____          _   _ _         _       \n");
		printf("   |_   _|  \\/  /  __ \\_   _|_   _|    | |                 | |                              |_   _|        | | (_) |       | |      \n");
		printf("     | | | .  . | /  \\/ | |   | |______| |     _____      _| |     __ _ _   _  ___ _ __ ______| | _ __  ___| |_ _| |_ _   _| |_ ___ \n");
		printf("     | | | |\\/| | |     | |   | |______| |    / _ \\ \\ /\\ / / |    / _` | | | |/ _ \\ '__|______| || '_ \\/ __| __| | __| | | | __/ _ \\\n");
		printf("     | | | |  | | \\__/\\_| |_  | |      | |___| (_) \\ V  V /| |___| (_| | |_| |  __/ |        _| || | | \\__ \\ |_| | |_| |_| | ||  __/\n");
		printf("     \\_/ \\_|  |_/\\____/\\___/  \\_/      \\_____/\\___/ \\_/\\_/ \\_____/\\__,_|\\__, |\\___/_|        \\___/_| |_|___/\\__|_|\\__|\\__,_|\\__\\___|\n");
		printf("                                                                         __/ |                                                      \n");
		printf("                                                                        |___/                                                       \n");

                printf("\n");
                kinit();        /* physical page allocator */
                kvminit();      /* create kernel page table */
                kvminithart();  /* turn on paging */
                procinit();     /* process table */
                trapinit();     /* trap vectors */
                trapinithart(); /* install kernel trap vector */
                plicinit();     /* set up interrupt controller */
                plicinithart(); /* ask PLIC for device interrupts */
                binit();        /* buffer cache */
                iinit();        /* inode table */
                fileinit();     /* file table */
                virtio_disk_init();     /* emulated hard disk*/
                userinit();     /* first user process */
                __sync_synchronize();
                started = 1;
	} else {
		while (started == 0)
			;
		__sync_synchronize();
		printf("hart %d starting\n", cpuid());
		kvminithart();  /* turn on paging */
                trapinithart(); /* install kernel trap vector */
                plicinithart(); /* ask PLIC for device interrupts */
        }

		scheduler();
	}
