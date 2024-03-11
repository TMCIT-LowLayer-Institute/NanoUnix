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

/* Mutual exclusion spin locks. */

#include "types.h"
#include "param.h"
#include "memlayout.h"
#include "spinlock.h"
#include "riscv.h"
#include "proc.h"
#include "defs.h"

void
initlock(struct spinlock *lk, char *name)
{
	lk->name = name;
	lk->locked = 0;
	lk->cpu = 0;
}
/*
 * Acquire the lock.
 * Loops (spins) until the lock is acquired.
 */
void
acquire(struct spinlock *lk)
{
	push_off();		/* disable interrupts to avoid deadlock. */
	if (holding(lk))
		panic("acquire");

	/* On RISC-V, sync_lock_test_and_set turns into an atomic swap: a5 = 1
	 * s1 = &lk->locked amoswap.w.aq a5, a5, (s1) */
	while (__sync_lock_test_and_set(&lk->locked, 1) != 0)
		;

	/* Tell the C compiler and the processor to not move loads or stores
	 * past this point, to ensure that the critical section's memory
	 * references happen strictly after the lock is acquired. On RISC-V,
	 * this emits a fence instruction. */
	__sync_synchronize();

	/* Record info about lock acquisition for holding() and debugging. */
	lk->cpu = mycpu();
}
/*
 * Release the lock.
 */
void
release(struct spinlock *lk)
{
	if (!holding(lk))
		panic("release");

	lk->cpu = 0;

	/* Tell the C compiler and the CPU to not move loads or stores past
	 * this point, to ensure that all the stores in the critical section
	 * are visible to other CPUs before the lock is released, and that
	 * loads in the critical section occur strictly before the lock is
	 * released. On RISC-V, this emits a fence instruction. */
	__sync_synchronize();

	/* Release the lock, equivalent to lk->locked = 0. This code doesn't
	 * use a C assignment, since the C standard implies that an assignment
	 * might be implemented with multiple store instructions. On RISC-V,
	 * sync_lock_release turns into an atomic swap: s1 = &lk->locked
	 * amoswap.w zero, zero, (s1) */
	__sync_lock_release(&lk->locked);

	pop_off();
}
/*
 * Check whether this cpu is holding the lock.
 * Interrupts must be off.
 */
int
holding(struct spinlock *lk)
{
	int r = undefined;
	r = (lk->locked && lk->cpu == mycpu());
	return r;
}
/*
 * push_off/pop_off are like intr_off()/intr_on() except that they are matched:
 * it takes two pop_off()s to undo two push_off()s.  Also, if interrupts
 * are initially off, then push_off, pop_off leaves them off.
 */
void
push_off(void)
{
	int old = intr_get();

	intr_off();
	if (mycpu()->noff == 0)
		mycpu()->intena = old;
	mycpu()->noff += 1;
}

void
pop_off(void)
{
	struct cpu *c = mycpu();
	if (intr_get())
		panic("pop_off - interruptible");
	if (c->noff < 1)
		panic("pop_off");
	c->noff -= 1;
	if (c->noff == 0 && c->intena)
		intr_on();
}
