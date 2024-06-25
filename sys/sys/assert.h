/*
 * Copyright (c) 2000-2016 Apple Inc. All rights reserved.
 *
 * @APPLE_OSREFERENCE_LICENSE_HEADER_START@
 *
 * This file contains Original Code and/or Modifications of Original Code
 * as defined in and that are subject to the Apple Public Source License
 * Version 2.0 (the 'License'). You may not use this file except in
 * compliance with the License. The rights granted to you under the License
 * may not be used to create, or enable the creation or redistribution of,
 * unlawful or unlicensed copies of an Apple operating system, or to
 * circumvent, violate, or enable the circumvention or violation of, any
 * terms of an Apple operating system software license agreement.
 *
 * Please obtain a copy of the License at
 * http://www.opensource.apple.com/apsl/ and read it before using this file.
 *
 * The Original Code and all software distributed under the License are
 * distributed on an 'AS IS' basis, WITHOUT WARRANTY OF ANY KIND, EITHER
 * EXPRESS OR IMPLIED, AND APPLE HEREBY DISCLAIMS ALL SUCH WARRANTIES,
 * INCLUDING WITHOUT LIMITATION, ANY WARRANTIES OF MERCHANTABILITY,
 * FITNESS FOR A PARTICULAR PURPOSE, QUIET ENJOYMENT OR NON-INFRINGEMENT.
 * Please see the License for the specific language governing rights and
 * limitations under the License.
 *
 * @APPLE_OSREFERENCE_LICENSE_HEADER_END@
 */
/*
 * @OSF_COPYRIGHT@
 */
/*
 * Mach Operating System
 * Copyright (c) 1991,1990,1989,1988,1987 Carnegie Mellon University
 * All Rights Reserved.
 *
 * Permission to use, copy, modify and distribute this software and its
 * documentation is hereby granted, provided that both the copyright
 * notice and this permission notice appear in all copies of the
 * software, derivative works or modified versions, and any portions
 * thereof, and that both notices appear in supporting documentation.
 *
 * CARNEGIE MELLON ALLOWS FREE USE OF THIS SOFTWARE IN ITS "AS IS"
 * CONDITION.  CARNEGIE MELLON DISCLAIMS ANY LIABILITY OF ANY KIND FOR
 * ANY DAMAGES WHATSOEVER RESULTING FROM THE USE OF THIS SOFTWARE.
 *
 * Carnegie Mellon requests users of this software to return to
 *
 *  Software Distribution Coordinator  or  Software.Distribution@CS.CMU.EDU
 *  School of Computer Science
 *  Carnegie Mellon University
 *  Pittsburgh PA 15213-3890
 *
 * any improvements or extensions that they make and grant Carnegie Mellon
 * the rights to redistribute these changes.
 */
/*
 */

#ifndef _KERN_ASSERT_H_
#define _KERN_ASSERT_H_

#include <kern/defs.h>

#include <sys/types.h>

/* Define likely and unlikely macros */
#define likely(x)   __builtin_expect(!!(x), 1)
#define unlikely(x) __builtin_expect(!!(x), 0)

/* Assert function declaration and implementation */
#ifndef NDEBUG
__attribute__((noinline, noreturn))
void __assert_func(const char *file, int line, const char *func, const char *expr)
{
    panic("Assertion failed: %s, function %s, file %s, line %d.\n",
          expr, func, file, line);
    __builtin_unreachable();
}
#endif

/* Define __FILE_NAME__ if not already defined */
#ifndef __FILE_NAME__
#define __FILE_NAME__ __FILE__
#endif

/* Assertion macros */
#ifndef NDEBUG
#define assert(ex) \
    ((void)(likely(ex) ? 0 : (__assert_func(__FILE_NAME__, __LINE__, __func__, #ex), 0)))

#define assertf(ex, fmt, ...) \
    ((void)(likely(ex) ? 0 : (panic("%s:%d Assertion failed: %s : " fmt, \
        __FILE_NAME__, __LINE__, #ex, ##__VA_ARGS__), 0)))

#define assert3u(a, op, b) do { \
    const uint64_t __a = (a); \
    const uint64_t __b = (b); \
    if (unlikely(!(__a op __b))) { \
        panic("%s:%d Assertion failed: %s (0x%llx %s 0x%llx)", \
            __FILE_NAME__, __LINE__, #a " " #op " " #b, __a, #op, __b); \
    } \
} while (0)

#define assert3s(a, op, b) do { \
    const int64_t __a = (a); \
    const int64_t __b = (b); \
    if (unlikely(!(__a op __b))) { \
        panic("%s:%d Assertion failed: %s (0x%llx %s 0x%llx)", \
            __FILE_NAME__, __LINE__, #a " " #op " " #b, __a, #op, __b); \
    } \
} while (0)

#define assert3p(a, op, b) do { \
    const void *__a = (a); \
    const void *__b = (b); \
    if (unlikely(!(__a op __b))) { \
        panic("%s:%d Assertion failed: %s (0x%p %s 0x%p)", \
            __FILE_NAME__, __LINE__, #a " " #op " " #b, __a, #op, __b); \
    } \
} while (0)

#define __assert_only

#else /* NDEBUG */

#define assert(ex) ((void)0)
#define assertf(ex, fmt, ...) ((void)0)
#define assert3u(a, op, b) ((void)0)
#define assert3s(a, op, b) ((void)0)
#define assert3p(a, op, b) ((void)0)
#define __assert_only __attribute__((unused))

#endif /* NDEBUG */

/* Static assert implementation */
#if defined(__STDC_VERSION__) && __STDC_VERSION__ >= 201112L
#define static_assert _Static_assert
#else
#define static_assert(ex, msg) \
    typedef char __static_assert_failure[(ex) ? 1 : -1] __attribute__((unused))
#endif

#endif /* _KERN_ASSERT_H_ */
