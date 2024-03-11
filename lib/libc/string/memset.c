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
 * 4. Neither the name of the University nor the names of its contributors
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

#include <C/string.h>

#define wsize sizeof(u_long)
#define wmask (wsize - 1)

#define RETURN return (dst0)
#define VAL c0
#define WIDEVAL c

void *
memset(void *dst0, int c0, size_t length)
{
        size_t t = 0;
        u_long c = 0;
        u_char *dst = nullptr;

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
