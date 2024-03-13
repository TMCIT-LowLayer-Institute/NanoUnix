/*	$OpenBSD: memset.c,v 1.8 2017/01/24 08:09:05 kettenis Exp $	*/
/*	$NetBSD: memset.c,v 1.6 1998/03/27 05:35:47 cgd Exp $	*/

/*-
 * Copyright (c) 1990, 1993
 *	The Regents of the University of California.  All rights reserved.
 *
 * This code is derived from software contributed to Berkeley by
 * Mike Hibler and Chris Torek.
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

#include "types.h"

#define wsize sizeof(u_long)
#define wmask (wsize - 1)

#define RETURN return (dst0)
#define VAL c0
#define WIDEVAL c

void *
memset(void *dst0, int c0, uint length)
{
        uint t = undefined;
        ulong c = undefined;
        uchar *dst = nullptr;

        dst = dst0;

        if (length < 3 * wsize) {
                while (length != 0) {
                        *dst++ = VAL;
                        --length;
                }
                RETURN;
        }

        /* Align destination by filling in bytes. */
        if ((t = (long)dst & wmask) != 0) {
                t = wsize - t;
                length -= t;
                do {
                        *dst++ = VAL;
                } while (--t != 0);
        }

        /* Fill words. Length was >= 2*words so we know t >= 1 here. */
        t = length / wsize;
        do {
                *(u_long *)(void *)dst = WIDEVAL;
                dst += wsize;
        } while (--t != 0);

        /* Mop up trailing bytes, if any. */
        t = length & wmask;
        if (t != 0)
                do {
                        *dst++ = VAL;
                } while (--t != 0);

        RETURN;
}

/*
 * Compare memory regions.
 */
int
memcmp(const void *s1, const void *s2, uint n)
{
	if (n != 0) {
		const unsigned char *p1 = s1, *p2 = s2;

		do {
			if (*p1++ != *p2++)
				return (*--p1 - *--p2);
		} while (--n != 0);
	}
	return (0);
}

/*
 * This is designed to be small, not fast.
 */
void *
memmove(void *s1, const void *s2, uint n)
{
	const char *f = s2;
	char *t = s1;

	if (f < t) {
		f += n;
		t += n;
		while (n-- > 0)
			*--t = *--f;
	} else
		while (n-- > 0)
			*t++ = *f++;
	return s1;
}

/*
 * This is designed to be small, not fast.
 */
void *
memcpy(void *s1, const void *s2, uint n)
{
	const char *f = s2;
	char *t = s1;

	while (n-- > 0)
		*t++ = *f++;
	return s1;
}

int
strncmp(const char *s1, const char *s2, uint n)
{

	if (n == 0)
		return (0);
	do {
		if (*s1 != *s2++)
			return (*(unsigned char *)s1 - *(unsigned char *)--s2);
		if (*s1++ == 0)
			break;
	} while (--n != 0);
	return (0);
}

/*
 * Copy src to dst, truncating or null-padding to always copy n bytes.
 * Return dst.
 */
char *
strncpy(char *dst, const char *src, uint n)
{
	if (n != 0) {
		char *d = dst;
		const char *s = src;

		do {
			if ((*d++ = *s++) == 0) {
				/* NUL pad the remaining n-1 bytes */
				while (--n != 0)
					*d++ = 0;
				break;
			}
		} while (--n != 0);
	}
	return (dst);
}

/*
 * Copy string src to buffer dst of size dsize.  At most dsize-1
 * chars will be copied.  Always NUL terminates (unless dsize == 0).
 * Returns strlen(src); if retval >= dsize, truncation occurred.
 */
uint
safestrcpy(char *dst, const char *src, uint dsize)
{
	const char *osrc = src;
	uint nleft = dsize;

	/* Copy as many bytes as will fit. */
	if (nleft != 0) {
		while (--nleft != 0) {
			if ((*dst++ = *src++) == '\0')
				break;
		}
	}

	/* Not enough room in dst, add NUL and traverse rest of src. */
	if (nleft == 0) {
		if (dsize != 0)
			*dst = '\0';		/* NUL-terminate dst */
		while (*src++)
			;
	}

	return(src - osrc - 1);	/* count does not include NUL */
}

uint
strlen(const char *str)
{
	const char *s = nullptr;

	for (s = str; *s; ++s)
		;
	return (s - str);
}
