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
 * Buffer cache.
 *
 * The buffer cache is a linked list of buf structures holding
 * cached copies of disk block contents. Caching disk blocks
 * in memory reduces the number of disk reads and also provides
 * a synchronization point for disk blocks used by multiple processes.
 *
 * Interface:
 * * To get a buffer for a particular disk block, call bread.
 * * After changing buffer data, call bwrite to write it to disk.
 * * When done with the buffer, call brelse.
 * * Do not use the buffer after calling brelse.
 * * Only one process at a time can use a buffer,
 *   so do not keep them longer than necessary.
 */

#include "types.h"
#include "param.h"
#include "spinlock.h"
#include "sleeplock.h"
#include "riscv.h"
#include "defs.h"
#include "fs.h"
#include "buf.h"

struct bcache {
	struct spinlock lock;
	struct buf buf[NBUF];

	/* Linked list of all buffers, through prev/next. Sorted by how
	 * recently the buffer was used. head.next is most recent, head.prev
	 * is least. */
	struct buf head;
};

struct bcache bcache = {};

void
binit(void)
{
	struct buf *b = nullptr;

	initlock(&bcache.lock, "bcache");

	/* Create linked list of buffers */
	bcache.head.prev = &bcache.head;
	bcache.head.next = &bcache.head;
	for (b = bcache.buf; b < bcache.buf + NBUF; b++) {
		b->next = bcache.head.next;
		b->prev = &bcache.head;
		initsleeplock(&b->lock, "buffer");
		bcache.head.next->prev = b;
		bcache.head.next = b;
	}
}
/*
 * Look through buffer cache for block on device dev.
 * If not found, allocate a buffer.
 * In either case, return locked buffer.
 */
static struct buf *
bget(uint dev, uint blockno)
{
	struct buf *b = nullptr;

	acquire(&bcache.lock);

	/* Is the block already cached? */
	for (b = bcache.head.next; b != &bcache.head; b = b->next) {
		if (b->dev == dev && b->blockno == blockno) {
			b->refcnt++;
			release(&bcache.lock);
			acquiresleep(&b->lock);
			return b;
		}
	}

	/* Not cached. Recycle the least recently used (LRU) unused buffer. */
	for (b = bcache.head.prev; b != &bcache.head; b = b->prev) {
		if (b->refcnt == 0) {
			b->dev = dev;
			b->blockno = blockno;
			b->valid = 0;
			b->refcnt = 1;
			release(&bcache.lock);
			acquiresleep(&b->lock);
			return b;
		}
	}
	panic("bget: no buffers");
}
/*
 * Return a locked buf with the contents of the indicated block.
 */
struct buf *
bread(uint dev, uint blockno)
{
	struct buf *b = nullptr;

	b = bget(dev, blockno);
	if (!b->valid) {
		virtio_disk_rw(b, 0);
		b->valid = 1;
	}
	return b;
}
/*
 * Write b's contents to disk.  Must be locked.
 */
void
bwrite(struct buf *b)
{
	if (!holdingsleep(&b->lock))
		panic("bwrite");
	virtio_disk_rw(b, 1);
}
/*
 * Release a locked buffer.
 * Move to the head of the most-recently-used list.
 */
void
brelse(struct buf *b)
{
	if (!holdingsleep(&b->lock))
		panic("brelse");

	releasesleep(&b->lock);

	acquire(&bcache.lock);
	b->refcnt--;
	if (b->refcnt == 0) {
		/* no one is waiting for it. */
		b->next->prev = b->prev;
		b->prev->next = b->next;
		b->next = bcache.head.next;
		b->prev = &bcache.head;
		bcache.head.next->prev = b;
		bcache.head.next = b;
	}
	release(&bcache.lock);
}

void
bpin(struct buf *b)
{
	acquire(&bcache.lock);
	b->refcnt++;
	release(&bcache.lock);
}

void
bunpin(struct buf *b)
{
	acquire(&bcache.lock);
	b->refcnt--;
	release(&bcache.lock);
}
