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

#ifndef TYPES_H
#define TYPES_H

#include "_null.h"


typedef unsigned int   uint;
typedef unsigned short ushort;
typedef unsigned char  uchar;

typedef unsigned char uint8;
typedef unsigned short uint16;
typedef unsigned int  uint32;
typedef unsigned long uint64;

typedef	unsigned char	u_char;         /* BSD compatibility */
typedef	unsigned short	u_short;        /* BSD compatibility */
typedef	unsigned int	u_int;          /* BSD compatibility */
typedef	unsigned long	u_long;         /* BSD compatibility */

typedef unsigned char	unchar;		/* Sys V compatibility */
typedef	unsigned short	ushort;		/* Sys V compatibility */
typedef	unsigned int	uint;		/* Sys V compatibility */
typedef unsigned long	ulong;		/* Sys V compatibility */

typedef uint64 pde_t;

constexpr uint undefined = 0;

#ifdef KERNEL

#include "_types.h"

/*	$OpenBSD: stdint.h,v 1.11 2019/01/25 00:19:26 millert Exp $	*/

/*
 * Copyright (c) 1997, 2005 Todd C. Miller <millert@openbsd.org>
 *
 * Permission to use, copy, modify, and distribute this software for any
 * purpose with or without fee is hereby granted, provided that the above
 * copyright notice and this permission notice appear in all copies.
 *
 * THE SOFTWARE IS PROVIDED "AS IS" AND THE AUTHOR DISCLAIMS ALL WARRANTIES
 * WITH REGARD TO THIS SOFTWARE INCLUDING ALL IMPLIED WARRANTIES OF
 * MERCHANTABILITY AND FITNESS. IN NO EVENT SHALL THE AUTHOR BE LIABLE FOR
 * ANY SPECIAL, DIRECT, INDIRECT, OR CONSEQUENTIAL DAMAGES OR ANY DAMAGES
 * WHATSOEVER RESULTING FROM LOSS OF USE, DATA OR PROFITS, WHETHER IN AN
 * ACTION OF CONTRACT, NEGLIGENCE OR OTHER TORTIOUS ACTION, ARISING OUT OF
 * OR IN CONNECTION WITH THE USE OR PERFORMANCE OF THIS SOFTWARE.
 */

/* 7.18.1.2 Minimum-width integer types */
typedef	__int_least8_t		int_least8_t;
typedef	__uint_least8_t		uint_least8_t;
typedef	__int_least16_t		int_least16_t;
typedef	__uint_least16_t	uint_least16_t;
typedef	__int_least32_t		int_least32_t;
typedef	__uint_least32_t	uint_least32_t;
typedef	__int_least64_t		int_least64_t;
typedef	__uint_least64_t	uint_least64_t;

/* 7.18.1.3 Fastest minimum-width integer types */
typedef	__int_fast8_t		int_fast8_t;
typedef	__uint_fast8_t		uint_fast8_t;
typedef	__int_fast16_t		int_fast16_t;
typedef	__uint_fast16_t		uint_fast16_t;
typedef	__int_fast32_t		int_fast32_t;
typedef	__uint_fast32_t		uint_fast32_t;
typedef	__int_fast64_t		int_fast64_t;
typedef	__uint_fast64_t		uint_fast64_t;

/* 7.18.2.1 Limits of exact-width integer types */
#define	INT8_MIN		(-0x7f - 1)
#define	INT16_MIN		(-0x7fff - 1)
#define	INT32_MIN		(-0x7fffffff - 1)
#define	INT64_MIN		(-0x7fffffffffffffffLL - 1)

#define	INT8_MAX		0x7f
#define	INT16_MAX		0x7fff
#define	INT32_MAX		0x7fffffff
#define	INT64_MAX		0x7fffffffffffffffLL

#define	UINT8_MAX		0xff
#define	UINT16_MAX		0xffff
#define	UINT32_MAX		0xffffffffU
#define	UINT64_MAX		0xffffffffffffffffULL

/* 7.18.2.2 Limits of minimum-width integer types */
#define	INT_LEAST8_MIN		INT8_MIN
#define	INT_LEAST16_MIN		INT16_MIN
#define	INT_LEAST32_MIN		INT32_MIN
#define	INT_LEAST64_MIN		INT64_MIN

#define	INT_LEAST8_MAX		INT8_MAX
#define	INT_LEAST16_MAX		INT16_MAX
#define	INT_LEAST32_MAX		INT32_MAX
#define	INT_LEAST64_MAX		INT64_MAX

#define	UINT_LEAST8_MAX		UINT8_MAX
#define	UINT_LEAST16_MAX	UINT16_MAX
#define	UINT_LEAST32_MAX	UINT32_MAX
#define	UINT_LEAST64_MAX	UINT64_MAX

/* 7.18.2.3 Limits of fastest minimum-width integer types */
#define	INT_FAST8_MIN		__INT_FAST8_MIN
#define	INT_FAST16_MIN		__INT_FAST16_MIN
#define	INT_FAST32_MIN		__INT_FAST32_MIN
#define	INT_FAST64_MIN		__INT_FAST64_MIN

#define	INT_FAST8_MAX		__INT_FAST8_MAX
#define	INT_FAST16_MAX		__INT_FAST16_MAX
#define	INT_FAST32_MAX		__INT_FAST32_MAX
#define	INT_FAST64_MAX		__INT_FAST64_MAX

#define	UINT_FAST8_MAX		__UINT_FAST8_MAX
#define	UINT_FAST16_MAX		__UINT_FAST16_MAX
#define	UINT_FAST32_MAX		__UINT_FAST32_MAX
#define	UINT_FAST64_MAX		__UINT_FAST64_MAX

/* 7.18.2.5 Limits of greatest-width integer types */
#define	INTMAX_MIN		INT64_MIN
#define	INTMAX_MAX		INT64_MAX
#define	UINTMAX_MAX		UINT64_MAX

/*
 * 7.18.3 Limits of other integer types.
 *
 * The following object-like macros specify the minimum and maximum limits
 * of integer types corresponding to types specified in other standard
 * header files.
 */

/* Limits of ptrdiff_t */
#define	PTRDIFF_MIN		INTPTR_MIN
#define	PTRDIFF_MAX		INTPTR_MAX

/* Limits of sig_atomic_t */
#define	SIG_ATOMIC_MIN		INT32_MIN
#define	SIG_ATOMIC_MAX		INT32_MAX

/* Limit of size_t */
#ifndef	SIZE_MAX
#define	SIZE_MAX		UINTPTR_MAX
#endif

/* Limits of wchar_t */
#ifndef	WCHAR_MIN
#define	WCHAR_MIN		INT32_MIN
#endif
#ifndef	WCHAR_MAX
#define	WCHAR_MAX		INT32_MAX
#endif

/* Limits of wint_t */
#define	WINT_MIN		INT32_MIN
#define	WINT_MAX		INT32_MAX

/*
 * 7.18.4 Macros for integer constants.
 *
 * The following function-like macros expand to integer constants
 * suitable for initializing objects that have integer types corresponding
 * to types defined in <stdint.h>.  The argument in any instance of
 * these macros shall be a decimal, octal, or hexadecimal constant with
 * a value that does not exceed the limits for the corresponding type.
 */

/* 7.18.4.1 Macros for minimum-width integer constants. */
#define	INT8_C(_c)		(_c)
#define	INT16_C(_c)		(_c)
#define	INT32_C(_c)		(_c)
#define	INT64_C(_c)		__CONCAT(_c, LL)

#define	UINT8_C(_c)		(_c)
#define	UINT16_C(_c)		(_c)
#define	UINT32_C(_c)		__CONCAT(_c, U)
#define	UINT64_C(_c)		__CONCAT(_c, ULL)

#endif /* KERNEL */

#endif /* TYPES_H */
