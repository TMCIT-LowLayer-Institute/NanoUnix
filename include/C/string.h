/*
 * Copyright 2024 TMCIT-LowLayer-Institute. All rights reserved.
 */
/*	$OpenBSD: string.h,v 1.32 2017/09/05 03:16:13 schwarze Exp $	*/
/*	$NetBSD: string.h,v 1.6 1994/10/26 00:56:30 cgd Exp $	*/

/*-
 * Copyright (c) 1990 The Regents of the University of California.
 * All rights reserved.
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
 *
 *	@(#)string.h	5.10 (Berkeley) 3/9/91
 */

/*
 * CDDL HEADER START
 *
 * The contents of this file are subject to the terms of the
 * Common Development and Distribution License, Version 1.0 only
 * (the "License").  You may not use this file except in compliance
 * with the License.
 *
 * You can obtain a copy of the license at usr/src/OPENSOLARIS.LICENSE
 * or http://www.opensolaris.org/os/licensing.
 * See the License for the specific language governing permissions
 * and limitations under the License.
 *
 * When distributing Covered Code, include this CDDL HEADER in each
 * file and include the License file at usr/src/OPENSOLARIS.LICENSE.
 * If applicable, add the following below this CDDL HEADER, with the
 * fields enclosed by brackets "[]" replaced with your own identifying
 * information: Portions Copyright [yyyy] [name of copyright owner]
 *
 * CDDL HEADER END
 */

/*
 * Copyright 2024 TMCIT-LowLayer-Institute. All rights reserved.
 */

#ifndef _STRING_H_
#define	_STRING_H_

#include <kernel/_null.h>

#include <sys/types.h>
#include <sys/cdefs.h>

#include "assert.h"
#include "strings.h"

#ifndef	_SIZE_T_DEFINED_
#define	_SIZE_T_DEFINED_
typedef	__size_t	size_t;
#endif

#ifndef _LOCALE_T_DEFINED_
#define _LOCALE_T_DEFINED_
typedef void	*locale_t;
#endif

__BEGIN_DECLS
void	*memchr(void const* const, int, size_t);
int	 memcmp(void const* const s1, void const* const s2, size_t n);
void	*memcpy(void *__restrict const, void const*__restrict const, size_t)
		__attribute__ ((__bounded__(__buffer__,1,3)))
		__attribute__ ((__bounded__(__buffer__,2,3)));
void	 bcopy(const void *, void *, size_t)
		__attribute__ ((__bounded__(__buffer__,1,3)))
		__attribute__ ((__bounded__(__buffer__,2,3)));
void	*memmove(void *, const void *, size_t)
		__attribute__ ((__bounded__(__buffer__,1,3)))
		__attribute__ ((__bounded__(__buffer__,2,3)));
void	*memset(void *, int, size_t)
		__attribute__ ((__bounded__(__buffer__,1,3)));
char	*strcat(char *__restrict, const char *__restrict);
extern char *strchr(char const* sp, int c);
int	 strcmp(const char *, const char *);
int	 strcoll(const char *, const char *);
char	*strcpy(char *__restrict, const char *__restrict);
size_t	 strcspn(const char *, const char *);
char	*strerror(int);
size_t	 strlen(char const* const str);
char	*strncat(char *__restrict, const char *__restrict, size_t)
		__attribute__ ((__bounded__(__string__,1,3)));
int	 strncmp(const char *, const char *, size_t);
char	*strncpy(char *__restrict, const char *__restrict, size_t)
		__attribute__ ((__bounded__(__string__,1,3)));
char	*strpbrk(const char *, const char *);
char	*strrchr(const char *, int);
size_t	 strspn(const char *, const char *);
char	*strstr(const char *, const char *);
char	*strtok(char *__restrict, const char *__restrict);
char	*strtok_r(char *__restrict, const char *__restrict, char **__restrict);
size_t	 strxfrm(char *__restrict, const char *__restrict, size_t)
		__attribute__ ((__bounded__(__string__,1,3)));

#if __XPG_VISIBLE
void	*memccpy(void * const __restrict dst, void const* const __restrict src, int const c, size_t n)
        __attribute__ ((__bounded__(__buffer__,1,4)));
#endif

int	 strerror_r(int, char *, size_t)
	    __attribute__ ((__bounded__(__string__,2,3)));

#if __XPG_VISIBLE >= 420 || __POSIX_VISIBLE >= 200809
char	*strdup(const char *);
#endif

#if __POSIX_VISIBLE >= 200809
char	*stpcpy(char *__restrict, char const*__restrict);
char	*stpncpy(char *__restrict, char const*__restrict const, size_t);
int	 strcoll_l(const char *, const char *, locale_t);
char	*strerror_l(int, locale_t);
char	*strndup(const char *, size_t);
size_t	 strnlen(const char *, size_t);
char	*strsignal(int);
size_t	 strxfrm_l(char *__restrict, const char *__restrict, size_t, locale_t)
		__attribute__ ((__bounded__(__string__,1,3)));
#endif

#if __BSD_VISIBLE
void	 explicit_bzero(void *, size_t)
		__attribute__ ((__bounded__(__buffer__,1,2)));
void	*memmem(const void *, size_t, const void *, size_t);
void	*memrchr(void const* const, int const, size_t);
char	*strcasestr(char const* const, char const* const);
size_t	 strlcat(char *, char const*, size_t)
		__attribute__ ((__bounded__(__string__,1,3)));
size_t	 strlcpy(char *dst, char const* src, size_t dsize)
		__attribute__ ((__bounded__(__string__,1,3)));
void	 strmode(int, char *);
char	*strsep(char **, const char *);
int	 timingsafe_bcmp(const void *, const void *, size_t);
int	 timingsafe_memcmp(const void *, const void *, size_t);
#endif

//extern char *index(char const* sp, int c);
//extern char *strchr(char const* sp, int c);
__END_DECLS

#endif /* _STRING_H_ */
