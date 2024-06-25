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

#include <sys/stdint.h>
#include "param.h"
#include "spinlock.h"
#include "sleeplock.h"
#include "fs.h"
#include "file.h"
#include "memlayout.h"
#include "riscv.h"
#include "defs.h"
#include "proc.h"

#include <C/stdarg.h>

volatile int panicked;

/* Lock to avoid interleaving concurrent printf's. */
static struct {
	struct spinlock	lock;
	int		locking;
} pr;

static char digits[] = "0123456789abcdef";

static void	printint(long long, int, int);
static void	printptr(unsigned long long);
static void	vprintf(const char *, va_list);

static void
printint(long long xx, int base, int sign)
{
	char	buf[16];
	int	i;
	unsigned long long x;

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
printptr(unsigned long long x)
{
	int	i;

	consputc('0');
	consputc('x');
	for (i = 0; i < (sizeof(unsigned long long) * 2); i++, x <<= 4)
		consputc(digits[x >> (sizeof(unsigned long long) * 8 - 4)]);
}

void
printf(const char *fmt, ...)
{
	va_list	ap;

	va_start(ap, fmt);
	vprintf(fmt, ap);
	va_end(ap);
}

static void
vprintf(const char *fmt, va_list ap)
{
	char		*s;
	int		c, locking;
	unsigned long	num;

	locking = pr.locking;
	if (locking)
		acquire(&pr.lock);

	if (fmt == 0)
		panic("null fmt");

	for (; (c = *fmt) != 0; fmt++) {
		if (c != '%') {
			consputc(c);
			continue;
		}
		c = *++fmt;
		if (c == 0)
			break;
		switch (c) {
		case 'd':
			num = va_arg(ap, int);
			printint(num, 10, 1);
			break;
		case 'x':
			num = va_arg(ap, unsigned int);
			printint(num, 16, 0);
			break;
		case 'p':
			num = va_arg(ap, unsigned long);
			printptr(num);
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

	if (locking)
		release(&pr.lock);
}

void
panic(const char *fmt, ...)
{
	va_list	ap;

	pr.locking = 0;
	printf("panic: ");

	va_start(ap, fmt);
	vprintf(fmt, ap);
	va_end(ap);

	printf("\n");
	panicked = 1;	/* Freeze output from other CPUs */
	for (;;)
		;
}

void
printfinit(void)
{
	initlock(&pr.lock, "pr");
	pr.locking = 1;
}
