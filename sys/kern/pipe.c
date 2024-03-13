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
#include "spinlock.h"
#include "proc.h"
#include "fs.h"
#include "sleeplock.h"
#include "file.h"

constexpr uint PIPESIZE = 512;

struct pipe {
	struct spinlock lock;
	char data[PIPESIZE];
	uint nread;		/* number of bytes read */
	uint nwrite;		/* number of bytes written */
	int readopen;		/* read fd is still open */
	int writeopen;		/* write fd is still open */
};

int
pipealloc(struct file **f0, struct file **f1)
{
	struct pipe *pi = nullptr;

	pi = 0;
	*f0 = *f1 = 0;
	if ((*f0 = filealloc()) == 0 || (*f1 = filealloc()) == 0)
		goto bad;
	if ((pi = (struct pipe *)kalloc()) == 0)
		goto bad;
	pi->readopen = 1;
	pi->writeopen = 1;
	pi->nwrite = 0;
	pi->nread = 0;
	initlock(&pi->lock, "pipe");
	(*f0)->type = FD_PIPE;
	(*f0)->readable = 1;
	(*f0)->writable = 0;
	(*f0)->pipe = pi;
	(*f1)->type = FD_PIPE;
	(*f1)->readable = 0;
	(*f1)->writable = 1;
	(*f1)->pipe = pi;
	return 0;

bad:
	if (pi)
		kfree((char *)pi);
	if (*f0)
		fileclose(*f0);
	if (*f1)
		fileclose(*f1);
	return -1;
}

void
pipeclose(struct pipe *pi, int writable)
{
	acquire(&pi->lock);
	if (writable) {
		pi->writeopen = 0;
		wakeup(&pi->nread);
	} else {
		pi->readopen = 0;
		wakeup(&pi->nwrite);
	}
	if (pi->readopen == 0 && pi->writeopen == 0) {
		release(&pi->lock);
		kfree((char *)pi);
	} else
		release(&pi->lock);
}

int
pipewrite(struct pipe *pi, uint64 addr, int n)
{
	int i = 0;
	struct proc *pr = myproc();

	acquire(&pi->lock);
	while (i < n) {
		if (pi->readopen == 0 || killed(pr)) {
			release(&pi->lock);
			return -1;
		}
		if (pi->nwrite == pi->nread + PIPESIZE) { /* DOC:		pipewrite - full */
			    wakeup(&pi->nread);
			sleep(&pi->nwrite, &pi->lock);
		} else {
			char ch;
			if (copyin(pr->pagetable, &ch, addr + i, 1) == -1)
				break;
			pi->data[pi->nwrite++ % PIPESIZE] = ch;
			i++;
		}
	}
	wakeup(&pi->nread);
	release(&pi->lock);

	return i;
}

int
piperead(struct pipe *pi, uint64 addr, int n)
{
	int i = undefined;
	struct proc *pr = myproc();
	char ch = undefined;

	acquire(&pi->lock);
	while (pi->nread == pi->nwrite && pi->writeopen) { /*DOC:		pipe - empty */
		    if (killed(pr)) {
			release(&pi->lock);
			return -1;
		}
		sleep(&pi->nread, &pi->lock); /* DOC:		piperead - sleep */
	}
	for (i = 0; i < n; i++) { /* DOC:		piperead - copy */
		    if (pi->nread == pi->nwrite)
			break;
		ch = pi->data[pi->nread++ % PIPESIZE];
		if (copyout(pr->pagetable, addr + i, &ch, 1) == -1)
			break;
	}
	wakeup(&pi->nwrite); /* DOC:	piperead - wakeup */
	    release(&pi->lock);
	return i;
}
