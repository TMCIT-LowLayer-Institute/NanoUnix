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
 * Physical memory allocator, for user processes,
 * kernel stacks, page - table pages,
 * and pipe buffers.Allocates whole 4096 - byte pages.
 */

#include "types.h"
#include "param.h"
#include "memlayout.h"
#include "spinlock.h"
#include "riscv.h"
#include "defs.h"

void freerange(void *pa_start, void *pa_end);

/* 
 * first address after kernel.
 * defined by kernel.ld.
 */
extern char end[];

struct run {
	struct run *next;
};

struct kmem{
	struct spinlock lock;
	struct run *freelist;
};

struct kmem kmem = {};

void
kinit()
{
	initlock(&kmem.lock, "kmem");
	freerange(end, (void *)PHYSTOP);
}

void
freerange(void *pa_start, void *pa_end)
{
	char *p = nullptr;
	p = (char *)PGROUNDUP((uint64) pa_start);
	for (; p + PGSIZE <= (char *)pa_end; p += PGSIZE)
	kfree(p);
}

/*
 * Free the page of physical memory pointed at by pa,
 * which normally should have been returned by a
 * call to kalloc().(The exception is when
 * initializing the allocator; see kinit above.)
 */
void
kfree(void *pa)
{
	struct run *r = nullptr;

	if (((uint64) pa % PGSIZE) != 0 || (char *)pa < end || (uint64) pa >= PHYSTOP)
		panic("kfree");

	/* Fill with junk to catch dangling refs. */
	memset(pa, 1, PGSIZE);

	r = (struct run *)pa;

	acquire(&kmem.lock);
	r->next = kmem.freelist;
	kmem.freelist = r;
	release(&kmem.lock);
}

/*
 * Allocate one 4096 - byte page of physical memory.
 * Returns a pointer that the kernel can use.
 * Returns 0 if the memory cannot be allocated.
 */
void *
kalloc(void)
{
        struct run *r = nullptr;

	acquire(&kmem.lock);
	r = kmem.freelist;
	if (r)
		kmem.freelist = r->next;
	release(&kmem.lock);

	if (r)
		memset((char *)r, 5, PGSIZE);   /* fill with junk */
	return (void *)r;
}
