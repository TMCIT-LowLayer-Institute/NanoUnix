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
 * Support functions for system
 * calls that involve file descriptors.
 */

#include "types.h"
#include "riscv.h"
#include "defs.h"
#include "param.h"
#include "fs.h"
#include "spinlock.h"
#include "sleeplock.h"
#include "file.h"
#include "stat.h"
#include "proc.h"

struct devsw devsw[NDEV] = {};

struct {
	struct spinlock lock;
	struct file file[NFILE];
}      ftable;

void
fileinit(void)
{
	initlock(&ftable.lock, "ftable");
}

/* 
 * Allocate a file structure. 
 */
struct file *
filealloc(void)
{
	struct file *f = nullptr;

	acquire(&ftable.lock);
	for (f = ftable.file; f < ftable.file + NFILE; f++) {
		if (f->ref == 0) {
			f->ref = 1;
			release(&ftable.lock);
			return f;
		}
	}
	release(&ftable.lock);
	return 0;
}

/*
 * Increment ref count for filef. 
 */
struct file *
filedup(struct file *f)
{
	acquire(&ftable.lock);
	if (f->ref < 1)
		panic("filedup");
	f->ref++;
	release(&ftable.lock);
	return f;
}

/* 
 * Close file f.(Decrement ref count, close when reaches 0.) 
 */
void
fileclose(struct file *f)
{
	struct file ff = {};

	acquire(&ftable.lock);
	if (f->ref < 1)
		panic("fileclose");
	if (--f->ref > 0) {
		release(&ftable.lock);
		return;
	}
	ff = *f;
	f->ref = 0;
	f->type = FD_NONE;
	release(&ftable.lock);

	if (ff.type == FD_PIPE) {
		pipeclose(ff.pipe, ff.writable);
	} else if (ff.type == FD_INODE || ff.type == FD_DEVICE) {
		begin_op();
		iput(ff.ip);
		end_op();
	}
}

/*
 * Get metadata about file f.
 * addr is a user virtual address, pointing to a struct stat.
 */
int
filestat(struct file *f, uint64 addr)
{
	struct proc *p = myproc();
	struct stat st = {};

	if (f->type == FD_INODE || f->type == FD_DEVICE) {
		ilock(f->ip);
		stati(f->ip, &st);
		iunlock(f->ip);
		if (copyout(p->pagetable, addr, (char *)&st, sizeof(st)) < 0)
			return -1;
		return 0;
	}
	return -1;
}

/*
 * Read from file f.
 * addr is a user virtual address.
 */
int
fileread(struct file *f, uint64 addr, int n)
{
	int r = 0;

	if (f->readable == 0)
		return -1;

	if (f->type == FD_PIPE) {
		r = piperead(f->pipe, addr, n);
	} else if (f->type == FD_DEVICE) {
		if (f->major < 0 || f->major >= NDEV || !devsw[f->major].read)
			return -1;
		r = devsw[f->major].read(1, addr, n);
	} else if (f->type == FD_INODE) {
		ilock(f->ip);
		if ((r = readi(f->ip, 1, addr, f->off, n)) > 0)
			f->off += r;
		iunlock(f->ip);
	} else {
		panic("fileread");
	}

	return r;
}

/*
 * Write to file f.
 * addr is a user virtual address.
 */
int
filewrite(struct file *f, uint64 addr, int n)
{
	int r = undefined, ret = 0;

	if (f->writable == 0)
		return -1;

	if (f->type == FD_PIPE) {
		ret = pipewrite(f->pipe, addr, n);
	} else if (f->type == FD_DEVICE) {
		if (f->major < 0 || f->major >= NDEV || !devsw[f->major].write)
			return -1;
		ret = devsw[f->major].write(1, addr, n);
	} else if (f->type == FD_INODE) {
		/*
                 * write a few blocks at a time to avoid exceeding
                 * the maximum log transaction size, including
                 * i - node, indirect block, allocation blocks,
                 * and 2 blocks of slop for non-aligned writes.
                 * this really belongs lower down, since writei()
                 * might be writing a device like the console.
                 */
		int max = ((MAXOPBLOCKS - 1 - 1 - 2) / 2) * BSIZE;
		int i = 0;
		while (i < n) {
			int n1 = n - i;
			if (n1 > max)
				n1 = max;

			begin_op();
			ilock(f->ip);
			if ((r = writei(f->ip, 1, addr + i, f->off, n1)) > 0)
				f->off += r;
			iunlock(f->ip);
			end_op();

			if (r != n1) {
				//error from writei
				    break;
			}
			i += r;
		}
		ret = (i == n ? n : -1);
	} else {
		panic("filewrite");
	}

	return ret;
}
