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

/*
 * On - disk file system format.
 * Both the kernel and user programs use this header file.
 */

#include "types.h"

constexpr uint ROOTINO = 1;     /* root i - number */
constexpr uint BSIZE =  1024;   /* block size */

/* 
 * Disk layout:
 * [boot block | super block | log | inode blocks |
 *                                         free bit map | data blocks]
 *
 * mkfs computes the super block and builds an initial file system.The
 * super block describes the disk layout:
 */
struct superblock {
        uint magic;             /* Must be FSMAGIC */
        uint size;              /* Size of file system image(blocks) */
        uint nblocks;           /* Number of data blocks */
        uint ninodes;           /* Number of inodes. */
        uint nlog;              /* Number of log blocks */
        uint logstart;          /* Block number of first log block */
        uint inodestart;        /* Block number of first inode block */
        uint bmapstart;         /* Block number of first free map block */
};

constexpr uint FSMAGIC = 0x10203040;

constexpr uint NDIRECT = 12;
constexpr uint NINDIRECT = BSIZE / sizeof(uint);
constexpr uint MAXFILE = NDIRECT + NINDIRECT;

/*
 * On - disk inode structure
 */
struct dinode {
        short type;                     /* File type */
        short major;                    /* Major device number(T_DEVICE only) */
        short minor;                    /* Minor device number(T_DEVICE only) */
        short nlink;                    /* Number of links to inode in file system */
        uint size;                      /* Size of file(bytes) */
        uint addrs[NDIRECT + 1];        /* Data block addresses */
};

/* Inodes per block. */
constexpr uint IPB = BSIZE / sizeof(struct dinode);

/* Block containing inode i */
#define IBLOCK(i, sb)     ((i) / IPB + sb.inodestart)

/* Bitmap bits per block */
constexpr uint BPB = BSIZE * 8;

/* Block of free map containing bit for block */
#define BBLOCK(b, sb) ((b)/BPB + sb.bmapstart)

/* Directory is a file containing a sequence of dirent structures. */
constexpr uint DIRSIZ = 14;

struct dirent {
        ushort inum;
        char name[DIRSIZ];
};
