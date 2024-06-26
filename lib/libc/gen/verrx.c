/*	$OpenBSD: verrx.c,v 1.11 2016/03/13 18:34:20 guenther Exp $ */
/*-
 * Copyright (c) 1993
 *	The Regents of the University of California.  All rights reserved.
 *
 * Redistribution and use in source and binary forms, with or without
 * modification, are permitted provided that the following conditions
 * are met:
 * 1. Redistributions of source code must retain the above copyright
 *    notice, this list of conditions and the following disclaimer.
 * 2. Redistributions in binary form must reproduce the above copyright
 *    notice, this list of conditions and the following disclaimer in the
 *    documentation and/or other materials provided with the distribution.
 * 3. Neither the name of the University nor the names of its contributors
 *    may be used to endorse or promote products derived from this software
 *    without specific prior written permission.
 *
 * THIS SOFTWARE IS PROVIDED BY THE REGENTS AND CONTRIBUTORS ``AS IS'' AND
 * ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE
 * IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE
 * ARE DISCLAIMED.  IN NO EVENT SHALL THE REGENTS OR CONTRIBUTORS BE LIABLE
 * FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL
 * DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS
 * OR SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION)
 * HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT
 * LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY
 * OUT OF THE USE OF THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF
 * SUCH DAMAGE.
 */

#include <C/err.h>
#include <C/stdlib.h>
#include <C/stdarg.h>

#include "user/user.h"

__dead void
verrx(int eval, const char *fmt, va_list ap)
{
	const char	*p;
	char		 c;
	char		*s;
	int		 d;

	if (fmt != NULL) {
		for (p = fmt; (c = *p) != '\0'; p++) {
			if (c != '%') {
				(void)fprintf(1, "%c", c);
				continue;
			}
			switch (*++p) {
			case 's':
				s = va_arg(ap, char *);
				(void)fprintf(1, "%s", s);
				break;
			case 'd':
				d = va_arg(ap, int);
				(void)fprintf(1, "%d", d);
				break;
			/* 他の書式指定子も同様に処理 */
			default:
				(void)fprintf(1, "%%");
				break;
			}
		}
	}
	(void)fprintf(1, "\n");
	exit(eval);
}
