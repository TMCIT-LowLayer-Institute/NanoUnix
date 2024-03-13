/*
 * Copyright (c) 2024 TMCIT-LowLayer-Institute. All rights reserved.
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
typedef unsigned int uint ;

constexpr uint NPROC = 64;       /* maximum number of processes */
constexpr uint NCPU = 8;         /* maximum number of CPUs */
constexpr uint NOFILE = 16;      /* open files per process */
constexpr uint NFILE = 100;      /* open files per system */
constexpr uint NINODE = 50;      /* maximum number of active i-nodes */
constexpr uint NDEV = 10;        /* maximum major device number */
constexpr uint ROOTDEV = 1;      /* device number of file system root disk */
constexpr uint MAXARG = 32;      /* max exec arguments */
constexpr uint MAXOPBLOCKS = 10;         /* max # of blocks any FS op writes */
constexpr uint LOGSIZE = MAXOPBLOCKS * 3;        /* max data blocks in on-disk log */
constexpr uint NBUF = MAXOPBLOCKS * 3;   /* size of disk block cache */
constexpr uint FSSIZE = 2000;    /* size of file system in blocks */
constexpr uint MAXPATH = 128;    /* maximum file path name */
