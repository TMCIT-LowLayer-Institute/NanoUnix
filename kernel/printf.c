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
 * formatted console output -- printf, panic.
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

#include "../include/C/stdarg.h"

volatile int panicked = 0;

/*
 * lock to avoid interleaving concurrent printf's.
 */
static struct {
	struct spinlock lock;
	int locking;
}      pr;

static char digits[] = "0123456789abcdef";

static void
printint(int xx, int base, int sign)
{
	char buf[16] = {};
	int i = undefined;
	uint x = undefined;

	if (sign && (sign = xx < 0))
		x = -xx;
	else
		x = xx;

	i = 0;
	do {
		buf[i++] = digits[x % base];
	} while ((x /= base) != 0);

	if (sign)
		buf[i++] = '-';

	while (--i >= 0)
		consputc(buf[i]);
}

static void
printptr(uint64 x)
{
	int i = 0;
	consputc('0');
	consputc('x');
	for (i = 0; i < (sizeof(uint64) * 2); i++, x <<= 4)
		consputc(digits[x >> (sizeof(uint64) * 8 - 4)]);
}
/*
 * Print to the console. only understands %d, %x, %p, %s.
 */
void
printf(char *fmt,...)
{
	va_list ap = nullptr;
	int i = undefined, c = undefined, locking = undefined;
	char *s = nullptr;

	locking = pr.locking;
	if (locking)
		acquire(&pr.lock);

	if (fmt == 0)
		panic("null fmt");

	va_start(ap, fmt);
	for (i = 0; (c = fmt[i] & 0xff) != 0; i++) {
		if (c != '%') {
			consputc(c);
			continue;
		}
		c = fmt[++i] & 0xff;
		if (c == 0)
			break;
		switch (c) {
		case 'd':
			printint(va_arg(ap, int), 10, 1);
			break;
		case 'x':
			printint(va_arg(ap, int), 16, 1);
			break;
		case 'p':
			printptr(va_arg(ap, uint64));
			break;
		case 's':
			if ((s = va_arg(ap, char *)) == 0)
				s = "(null)";
			for (; *s; s++)
				consputc(*s);
			break;
		case '%':
			consputc('%');
			break;
		default:
			/* Print unknown % sequence to draw attention. */
			consputc('%');
			consputc(c);
			break;
		}
	}
	va_end(ap);

	if (locking)
		release(&pr.lock);
}

void
panic(char *s)
{
	pr.locking = 0;
	printf("panic: ");
	printf(s);
	printf("\n");
	panicked = 1;		/* freeze uart output from other CPUs */
	for (;;)
		;
}

void
printfinit(void)
{
	initlock(&pr.lock, "pr");
	pr.locking = 1;
}
