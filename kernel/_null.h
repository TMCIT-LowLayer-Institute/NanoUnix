/*
 * Written by Unixtech-06 , March 09, 2024
 * Public domain.
 */

#ifndef NULL
#if !defined(__cplusplus)
#define	NULL	((void *)0)
#elif __cplusplus >= 201103L
#define	NULL	nullptr
#elif defined(__GNUG__)
#define	NULL	__null
#else
#define	NULL	0L
#endif
#endif
