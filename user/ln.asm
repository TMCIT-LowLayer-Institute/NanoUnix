
user/_ln:     file format elf64-littleriscv


Disassembly of section .text:

0000000000000000 <main>:
#include <kern/stat.h>
#include "user/user.h"

int
main(int argc, char *argv[])
{
   0:	1101                	add	sp,sp,-32
   2:	e822                	sd	s0,16(sp)
   4:	ec06                	sd	ra,24(sp)
   6:	1000                	add	s0,sp,32
  if(argc != 3){
   8:	478d                	li	a5,3
   a:	e426                	sd	s1,8(sp)
   c:	02f50063          	beq	a0,a5,2c <main+0x2c>
    fprintf(2, "Usage: ln old new\n");
  10:	4509                	li	a0,2
  12:	00001597          	auipc	a1,0x1
  16:	86e58593          	add	a1,a1,-1938 # 880 <malloc+0x100>
  1a:	00000097          	auipc	ra,0x0
  1e:	668080e7          	jalr	1640(ra) # 682 <fprintf>
    exit(1);
  22:	4505                	li	a0,1
  24:	00000097          	auipc	ra,0x0
  28:	332080e7          	jalr	818(ra) # 356 <exit>
  }
  if(link(argv[1], argv[2]) < 0)
  2c:	84ae                	mv	s1,a1
  2e:	6488                	ld	a0,8(s1)
  30:	698c                	ld	a1,16(a1)
  32:	00000097          	auipc	ra,0x0
  36:	384080e7          	jalr	900(ra) # 3b6 <link>
  3a:	00054763          	bltz	a0,48 <main+0x48>
    fprintf(2, "link %s %s: failed\n", argv[1], argv[2]);
  exit(0);
  3e:	4501                	li	a0,0
  40:	00000097          	auipc	ra,0x0
  44:	316080e7          	jalr	790(ra) # 356 <exit>
    fprintf(2, "link %s %s: failed\n", argv[1], argv[2]);
  48:	6894                	ld	a3,16(s1)
  4a:	6490                	ld	a2,8(s1)
  4c:	00001597          	auipc	a1,0x1
  50:	84c58593          	add	a1,a1,-1972 # 898 <malloc+0x118>
  54:	4509                	li	a0,2
  56:	00000097          	auipc	ra,0x0
  5a:	62c080e7          	jalr	1580(ra) # 682 <fprintf>
  5e:	b7c5                	j	3e <main+0x3e>

0000000000000060 <_main>:
//
// wrapper so that it's OK if main() does not call exit().
//
void
_main()
{
  60:	1141                	add	sp,sp,-16
  62:	e022                	sd	s0,0(sp)
  64:	e406                	sd	ra,8(sp)
  66:	0800                	add	s0,sp,16
  extern int main();
  main();
  68:	00000097          	auipc	ra,0x0
  6c:	f98080e7          	jalr	-104(ra) # 0 <main>
  exit(0);
  70:	4501                	li	a0,0
  72:	00000097          	auipc	ra,0x0
  76:	2e4080e7          	jalr	740(ra) # 356 <exit>

000000000000007a <strcpy>:
}

char*
strcpy(char *s, const char *t)
{
  7a:	1141                	add	sp,sp,-16
  7c:	e422                	sd	s0,8(sp)
  7e:	0800                	add	s0,sp,16
  char *os;

  os = s;
  while((*s++ = *t++) != 0)
  80:	87aa                	mv	a5,a0
  82:	0005c703          	lbu	a4,0(a1)
  86:	0785                	add	a5,a5,1
  88:	0585                	add	a1,a1,1
  8a:	fee78fa3          	sb	a4,-1(a5)
  8e:	fb75                	bnez	a4,82 <strcpy+0x8>
    ;
  return os;
}
  90:	6422                	ld	s0,8(sp)
  92:	0141                	add	sp,sp,16
  94:	8082                	ret

0000000000000096 <strcmp>:

int
strcmp(const char *p, const char *q)
{
  96:	1141                	add	sp,sp,-16
  98:	e422                	sd	s0,8(sp)
  9a:	0800                	add	s0,sp,16
  while(*p && *p == *q)
  9c:	00054783          	lbu	a5,0(a0)
  a0:	e791                	bnez	a5,ac <strcmp+0x16>
  a2:	a80d                	j	d4 <strcmp+0x3e>
  a4:	00054783          	lbu	a5,0(a0)
  a8:	cf99                	beqz	a5,c6 <strcmp+0x30>
  aa:	85b6                	mv	a1,a3
  ac:	0005c703          	lbu	a4,0(a1)
    p++, q++;
  b0:	0505                	add	a0,a0,1
  b2:	00158693          	add	a3,a1,1
  while(*p && *p == *q)
  b6:	fef707e3          	beq	a4,a5,a4 <strcmp+0xe>
  return (uchar)*p - (uchar)*q;
  ba:	0007851b          	sext.w	a0,a5
}
  be:	6422                	ld	s0,8(sp)
  c0:	9d19                	subw	a0,a0,a4
  c2:	0141                	add	sp,sp,16
  c4:	8082                	ret
  return (uchar)*p - (uchar)*q;
  c6:	0015c703          	lbu	a4,1(a1)
}
  ca:	6422                	ld	s0,8(sp)
  return (uchar)*p - (uchar)*q;
  cc:	4501                	li	a0,0
}
  ce:	9d19                	subw	a0,a0,a4
  d0:	0141                	add	sp,sp,16
  d2:	8082                	ret
  return (uchar)*p - (uchar)*q;
  d4:	0005c703          	lbu	a4,0(a1)
  d8:	4501                	li	a0,0
  da:	b7d5                	j	be <strcmp+0x28>

00000000000000dc <strlen>:

uint
strlen(const char *s)
{
  dc:	1141                	add	sp,sp,-16
  de:	e422                	sd	s0,8(sp)
  e0:	0800                	add	s0,sp,16
  int n;

  for(n = 0; s[n]; n++)
  e2:	00054783          	lbu	a5,0(a0)
  e6:	cf91                	beqz	a5,102 <strlen+0x26>
  e8:	0505                	add	a0,a0,1
  ea:	87aa                	mv	a5,a0
  ec:	0007c703          	lbu	a4,0(a5)
  f0:	86be                	mv	a3,a5
  f2:	0785                	add	a5,a5,1
  f4:	ff65                	bnez	a4,ec <strlen+0x10>
    ;
  return n;
}
  f6:	6422                	ld	s0,8(sp)
  f8:	40a6853b          	subw	a0,a3,a0
  fc:	2505                	addw	a0,a0,1
  fe:	0141                	add	sp,sp,16
 100:	8082                	ret
 102:	6422                	ld	s0,8(sp)
  for(n = 0; s[n]; n++)
 104:	4501                	li	a0,0
}
 106:	0141                	add	sp,sp,16
 108:	8082                	ret

000000000000010a <memset>:

void*
memset(void *dst, int c, uint n)
{
 10a:	1141                	add	sp,sp,-16
 10c:	e422                	sd	s0,8(sp)
 10e:	0800                	add	s0,sp,16
  char *cdst = (char *) dst;
  int i;
  for(i = 0; i < n; i++){
 110:	ce09                	beqz	a2,12a <memset+0x20>
 112:	1602                	sll	a2,a2,0x20
 114:	9201                	srl	a2,a2,0x20
    cdst[i] = c;
 116:	0ff5f593          	zext.b	a1,a1
 11a:	87aa                	mv	a5,a0
 11c:	00a60733          	add	a4,a2,a0
 120:	00b78023          	sb	a1,0(a5)
  for(i = 0; i < n; i++){
 124:	0785                	add	a5,a5,1
 126:	fee79de3          	bne	a5,a4,120 <memset+0x16>
  }
  return dst;
}
 12a:	6422                	ld	s0,8(sp)
 12c:	0141                	add	sp,sp,16
 12e:	8082                	ret

0000000000000130 <strchr>:

char*
strchr(const char *s, char c)
{
 130:	1141                	add	sp,sp,-16
 132:	e422                	sd	s0,8(sp)
 134:	0800                	add	s0,sp,16
  for(; *s; s++)
 136:	00054783          	lbu	a5,0(a0)
 13a:	c799                	beqz	a5,148 <strchr+0x18>
    if(*s == c)
 13c:	00f58763          	beq	a1,a5,14a <strchr+0x1a>
  for(; *s; s++)
 140:	00154783          	lbu	a5,1(a0)
 144:	0505                	add	a0,a0,1
 146:	fbfd                	bnez	a5,13c <strchr+0xc>
      return (char*)s;
  return 0;
 148:	4501                	li	a0,0
}
 14a:	6422                	ld	s0,8(sp)
 14c:	0141                	add	sp,sp,16
 14e:	8082                	ret

0000000000000150 <gets>:

char*
gets(char *buf, int max)
{
 150:	711d                	add	sp,sp,-96
 152:	e8a2                	sd	s0,80(sp)
 154:	e4a6                	sd	s1,72(sp)
 156:	e0ca                	sd	s2,64(sp)
 158:	fc4e                	sd	s3,56(sp)
 15a:	f852                	sd	s4,48(sp)
 15c:	f05a                	sd	s6,32(sp)
 15e:	ec5e                	sd	s7,24(sp)
 160:	ec86                	sd	ra,88(sp)
 162:	f456                	sd	s5,40(sp)
 164:	1080                	add	s0,sp,96
 166:	8baa                	mv	s7,a0
 168:	89ae                	mv	s3,a1
 16a:	892a                	mv	s2,a0
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
 16c:	4481                	li	s1,0
    cc = read(0, &c, 1);
    if(cc < 1)
      break;
    buf[i++] = c;
    if(c == '\n' || c == '\r')
 16e:	4a29                	li	s4,10
 170:	4b35                	li	s6,13
  for(i=0; i+1 < max; ){
 172:	a005                	j	192 <gets+0x42>
    cc = read(0, &c, 1);
 174:	00000097          	auipc	ra,0x0
 178:	1fa080e7          	jalr	506(ra) # 36e <read>
    if(cc < 1)
 17c:	02a05363          	blez	a0,1a2 <gets+0x52>
    buf[i++] = c;
 180:	faf44783          	lbu	a5,-81(s0)
    if(c == '\n' || c == '\r')
 184:	0905                	add	s2,s2,1
    buf[i++] = c;
 186:	fef90fa3          	sb	a5,-1(s2)
    if(c == '\n' || c == '\r')
 18a:	01478d63          	beq	a5,s4,1a4 <gets+0x54>
 18e:	01678b63          	beq	a5,s6,1a4 <gets+0x54>
  for(i=0; i+1 < max; ){
 192:	8aa6                	mv	s5,s1
 194:	2485                	addw	s1,s1,1
    cc = read(0, &c, 1);
 196:	4605                	li	a2,1
 198:	faf40593          	add	a1,s0,-81
 19c:	4501                	li	a0,0
  for(i=0; i+1 < max; ){
 19e:	fd34cbe3          	blt	s1,s3,174 <gets+0x24>
 1a2:	84d6                	mv	s1,s5
      break;
  }
  buf[i] = '\0';
 1a4:	94de                	add	s1,s1,s7
 1a6:	00048023          	sb	zero,0(s1)
  return buf;
}
 1aa:	60e6                	ld	ra,88(sp)
 1ac:	6446                	ld	s0,80(sp)
 1ae:	64a6                	ld	s1,72(sp)
 1b0:	6906                	ld	s2,64(sp)
 1b2:	79e2                	ld	s3,56(sp)
 1b4:	7a42                	ld	s4,48(sp)
 1b6:	7aa2                	ld	s5,40(sp)
 1b8:	7b02                	ld	s6,32(sp)
 1ba:	855e                	mv	a0,s7
 1bc:	6be2                	ld	s7,24(sp)
 1be:	6125                	add	sp,sp,96
 1c0:	8082                	ret

00000000000001c2 <stat>:

int
stat(const char *n, struct stat *st)
{
 1c2:	1101                	add	sp,sp,-32
 1c4:	e822                	sd	s0,16(sp)
 1c6:	e04a                	sd	s2,0(sp)
 1c8:	ec06                	sd	ra,24(sp)
 1ca:	e426                	sd	s1,8(sp)
 1cc:	1000                	add	s0,sp,32
 1ce:	892e                	mv	s2,a1
  int fd;
  int r;

  fd = open(n, O_RDONLY);
 1d0:	4581                	li	a1,0
 1d2:	00000097          	auipc	ra,0x0
 1d6:	1c4080e7          	jalr	452(ra) # 396 <open>
  if(fd < 0)
 1da:	02054663          	bltz	a0,206 <stat+0x44>
    return -1;
  r = fstat(fd, st);
 1de:	85ca                	mv	a1,s2
 1e0:	84aa                	mv	s1,a0
 1e2:	00000097          	auipc	ra,0x0
 1e6:	1cc080e7          	jalr	460(ra) # 3ae <fstat>
 1ea:	87aa                	mv	a5,a0
  close(fd);
 1ec:	8526                	mv	a0,s1
  r = fstat(fd, st);
 1ee:	84be                	mv	s1,a5
  close(fd);
 1f0:	00000097          	auipc	ra,0x0
 1f4:	18e080e7          	jalr	398(ra) # 37e <close>
  return r;
}
 1f8:	60e2                	ld	ra,24(sp)
 1fa:	6442                	ld	s0,16(sp)
 1fc:	6902                	ld	s2,0(sp)
 1fe:	8526                	mv	a0,s1
 200:	64a2                	ld	s1,8(sp)
 202:	6105                	add	sp,sp,32
 204:	8082                	ret
    return -1;
 206:	54fd                	li	s1,-1
 208:	bfc5                	j	1f8 <stat+0x36>

000000000000020a <atoi>:

int
atoi(const char *s)
{
 20a:	1141                	add	sp,sp,-16
 20c:	e422                	sd	s0,8(sp)
 20e:	0800                	add	s0,sp,16
  int n;

  n = 0;
  while('0' <= *s && *s <= '9')
 210:	00054683          	lbu	a3,0(a0)
 214:	4625                	li	a2,9
 216:	fd06879b          	addw	a5,a3,-48
 21a:	0ff7f793          	zext.b	a5,a5
 21e:	02f66863          	bltu	a2,a5,24e <atoi+0x44>
 222:	872a                	mv	a4,a0
  n = 0;
 224:	4501                	li	a0,0
    n = n*10 + *s++ - '0';
 226:	0025179b          	sllw	a5,a0,0x2
 22a:	9fa9                	addw	a5,a5,a0
 22c:	0705                	add	a4,a4,1
 22e:	0017979b          	sllw	a5,a5,0x1
 232:	9fb5                	addw	a5,a5,a3
  while('0' <= *s && *s <= '9')
 234:	00074683          	lbu	a3,0(a4)
    n = n*10 + *s++ - '0';
 238:	fd07851b          	addw	a0,a5,-48
  while('0' <= *s && *s <= '9')
 23c:	fd06879b          	addw	a5,a3,-48
 240:	0ff7f793          	zext.b	a5,a5
 244:	fef671e3          	bgeu	a2,a5,226 <atoi+0x1c>
  return n;
}
 248:	6422                	ld	s0,8(sp)
 24a:	0141                	add	sp,sp,16
 24c:	8082                	ret
 24e:	6422                	ld	s0,8(sp)
  n = 0;
 250:	4501                	li	a0,0
}
 252:	0141                	add	sp,sp,16
 254:	8082                	ret

0000000000000256 <memmove>:

void*
memmove(void *vdst, const void *vsrc, int n)
{
 256:	1141                	add	sp,sp,-16
 258:	e422                	sd	s0,8(sp)
 25a:	0800                	add	s0,sp,16
  char *dst;
  const char *src;

  dst = vdst;
  src = vsrc;
  if (src > dst) {
 25c:	02b57463          	bgeu	a0,a1,284 <memmove+0x2e>
    while(n-- > 0)
 260:	00c05f63          	blez	a2,27e <memmove+0x28>
 264:	1602                	sll	a2,a2,0x20
 266:	9201                	srl	a2,a2,0x20
 268:	00c507b3          	add	a5,a0,a2
  dst = vdst;
 26c:	872a                	mv	a4,a0
      *dst++ = *src++;
 26e:	0005c683          	lbu	a3,0(a1)
 272:	0705                	add	a4,a4,1
 274:	0585                	add	a1,a1,1
 276:	fed70fa3          	sb	a3,-1(a4)
    while(n-- > 0)
 27a:	fef71ae3          	bne	a4,a5,26e <memmove+0x18>
    src += n;
    while(n-- > 0)
      *--dst = *--src;
  }
  return vdst;
}
 27e:	6422                	ld	s0,8(sp)
 280:	0141                	add	sp,sp,16
 282:	8082                	ret
    dst += n;
 284:	00c50733          	add	a4,a0,a2
    src += n;
 288:	95b2                	add	a1,a1,a2
    while(n-- > 0)
 28a:	fec05ae3          	blez	a2,27e <memmove+0x28>
 28e:	fff6079b          	addw	a5,a2,-1
 292:	1782                	sll	a5,a5,0x20
 294:	9381                	srl	a5,a5,0x20
 296:	fff7c793          	not	a5,a5
 29a:	97ae                	add	a5,a5,a1
      *--dst = *--src;
 29c:	fff5c683          	lbu	a3,-1(a1)
 2a0:	15fd                	add	a1,a1,-1
 2a2:	177d                	add	a4,a4,-1
 2a4:	00d70023          	sb	a3,0(a4)
    while(n-- > 0)
 2a8:	feb79ae3          	bne	a5,a1,29c <memmove+0x46>
}
 2ac:	6422                	ld	s0,8(sp)
 2ae:	0141                	add	sp,sp,16
 2b0:	8082                	ret

00000000000002b2 <memcmp>:

int
memcmp(const void *s1, const void *s2, uint n)
{
 2b2:	1141                	add	sp,sp,-16
 2b4:	e422                	sd	s0,8(sp)
 2b6:	0800                	add	s0,sp,16
  const char *p1 = s1, *p2 = s2;
  while (n-- > 0) {
 2b8:	c61d                	beqz	a2,2e6 <memcmp+0x34>
 2ba:	fff6069b          	addw	a3,a2,-1
 2be:	1682                	sll	a3,a3,0x20
 2c0:	9281                	srl	a3,a3,0x20
 2c2:	0685                	add	a3,a3,1
 2c4:	96aa                	add	a3,a3,a0
 2c6:	a019                	j	2cc <memcmp+0x1a>
 2c8:	00a68f63          	beq	a3,a0,2e6 <memcmp+0x34>
    if (*p1 != *p2) {
 2cc:	00054783          	lbu	a5,0(a0)
 2d0:	0005c703          	lbu	a4,0(a1)
      return *p1 - *p2;
    }
    p1++;
 2d4:	0505                	add	a0,a0,1
    p2++;
 2d6:	0585                	add	a1,a1,1
    if (*p1 != *p2) {
 2d8:	fee788e3          	beq	a5,a4,2c8 <memcmp+0x16>
  }
  return 0;
}
 2dc:	6422                	ld	s0,8(sp)
      return *p1 - *p2;
 2de:	40e7853b          	subw	a0,a5,a4
}
 2e2:	0141                	add	sp,sp,16
 2e4:	8082                	ret
 2e6:	6422                	ld	s0,8(sp)
  return 0;
 2e8:	4501                	li	a0,0
}
 2ea:	0141                	add	sp,sp,16
 2ec:	8082                	ret

00000000000002ee <memcpy>:

void *
memcpy(void *dst, const void *src, uint n)
{
 2ee:	1141                	add	sp,sp,-16
 2f0:	e422                	sd	s0,8(sp)
 2f2:	0800                	add	s0,sp,16
  return memmove(dst, src, n);
 2f4:	0006079b          	sext.w	a5,a2
  if (src > dst) {
 2f8:	02b57463          	bgeu	a0,a1,320 <memcpy+0x32>
    while(n-- > 0)
 2fc:	00f05f63          	blez	a5,31a <memcpy+0x2c>
 300:	1602                	sll	a2,a2,0x20
 302:	9201                	srl	a2,a2,0x20
 304:	00c587b3          	add	a5,a1,a2
  dst = vdst;
 308:	872a                	mv	a4,a0
      *dst++ = *src++;
 30a:	0005c683          	lbu	a3,0(a1)
 30e:	0585                	add	a1,a1,1
 310:	0705                	add	a4,a4,1
 312:	fed70fa3          	sb	a3,-1(a4)
    while(n-- > 0)
 316:	fef59ae3          	bne	a1,a5,30a <memcpy+0x1c>
}
 31a:	6422                	ld	s0,8(sp)
 31c:	0141                	add	sp,sp,16
 31e:	8082                	ret
    dst += n;
 320:	00f50733          	add	a4,a0,a5
    src += n;
 324:	95be                	add	a1,a1,a5
    while(n-- > 0)
 326:	fef05ae3          	blez	a5,31a <memcpy+0x2c>
 32a:	fff6079b          	addw	a5,a2,-1
 32e:	1782                	sll	a5,a5,0x20
 330:	9381                	srl	a5,a5,0x20
 332:	fff7c793          	not	a5,a5
 336:	97ae                	add	a5,a5,a1
      *--dst = *--src;
 338:	fff5c683          	lbu	a3,-1(a1)
 33c:	15fd                	add	a1,a1,-1
 33e:	177d                	add	a4,a4,-1
 340:	00d70023          	sb	a3,0(a4)
    while(n-- > 0)
 344:	fef59ae3          	bne	a1,a5,338 <memcpy+0x4a>
}
 348:	6422                	ld	s0,8(sp)
 34a:	0141                	add	sp,sp,16
 34c:	8082                	ret

000000000000034e <fork>:
# generated by usys.pl - do not edit
#include "kern/syscall.h"
.global fork
fork:
 li a7, SYS_fork
 34e:	4885                	li	a7,1
 ecall
 350:	00000073          	ecall
 ret
 354:	8082                	ret

0000000000000356 <exit>:
.global exit
exit:
 li a7, SYS_exit
 356:	4889                	li	a7,2
 ecall
 358:	00000073          	ecall
 ret
 35c:	8082                	ret

000000000000035e <wait>:
.global wait
wait:
 li a7, SYS_wait
 35e:	488d                	li	a7,3
 ecall
 360:	00000073          	ecall
 ret
 364:	8082                	ret

0000000000000366 <pipe>:
.global pipe
pipe:
 li a7, SYS_pipe
 366:	4891                	li	a7,4
 ecall
 368:	00000073          	ecall
 ret
 36c:	8082                	ret

000000000000036e <read>:
.global read
read:
 li a7, SYS_read
 36e:	4895                	li	a7,5
 ecall
 370:	00000073          	ecall
 ret
 374:	8082                	ret

0000000000000376 <write>:
.global write
write:
 li a7, SYS_write
 376:	48c1                	li	a7,16
 ecall
 378:	00000073          	ecall
 ret
 37c:	8082                	ret

000000000000037e <close>:
.global close
close:
 li a7, SYS_close
 37e:	48d5                	li	a7,21
 ecall
 380:	00000073          	ecall
 ret
 384:	8082                	ret

0000000000000386 <kill>:
.global kill
kill:
 li a7, SYS_kill
 386:	4899                	li	a7,6
 ecall
 388:	00000073          	ecall
 ret
 38c:	8082                	ret

000000000000038e <exec>:
.global exec
exec:
 li a7, SYS_exec
 38e:	489d                	li	a7,7
 ecall
 390:	00000073          	ecall
 ret
 394:	8082                	ret

0000000000000396 <open>:
.global open
open:
 li a7, SYS_open
 396:	48bd                	li	a7,15
 ecall
 398:	00000073          	ecall
 ret
 39c:	8082                	ret

000000000000039e <mknod>:
.global mknod
mknod:
 li a7, SYS_mknod
 39e:	48c5                	li	a7,17
 ecall
 3a0:	00000073          	ecall
 ret
 3a4:	8082                	ret

00000000000003a6 <unlink>:
.global unlink
unlink:
 li a7, SYS_unlink
 3a6:	48c9                	li	a7,18
 ecall
 3a8:	00000073          	ecall
 ret
 3ac:	8082                	ret

00000000000003ae <fstat>:
.global fstat
fstat:
 li a7, SYS_fstat
 3ae:	48a1                	li	a7,8
 ecall
 3b0:	00000073          	ecall
 ret
 3b4:	8082                	ret

00000000000003b6 <link>:
.global link
link:
 li a7, SYS_link
 3b6:	48cd                	li	a7,19
 ecall
 3b8:	00000073          	ecall
 ret
 3bc:	8082                	ret

00000000000003be <mkdir>:
.global mkdir
mkdir:
 li a7, SYS_mkdir
 3be:	48d1                	li	a7,20
 ecall
 3c0:	00000073          	ecall
 ret
 3c4:	8082                	ret

00000000000003c6 <chdir>:
.global chdir
chdir:
 li a7, SYS_chdir
 3c6:	48a5                	li	a7,9
 ecall
 3c8:	00000073          	ecall
 ret
 3cc:	8082                	ret

00000000000003ce <dup>:
.global dup
dup:
 li a7, SYS_dup
 3ce:	48a9                	li	a7,10
 ecall
 3d0:	00000073          	ecall
 ret
 3d4:	8082                	ret

00000000000003d6 <getpid>:
.global getpid
getpid:
 li a7, SYS_getpid
 3d6:	48ad                	li	a7,11
 ecall
 3d8:	00000073          	ecall
 ret
 3dc:	8082                	ret

00000000000003de <sbrk>:
.global sbrk
sbrk:
 li a7, SYS_sbrk
 3de:	48b1                	li	a7,12
 ecall
 3e0:	00000073          	ecall
 ret
 3e4:	8082                	ret

00000000000003e6 <sleep>:
.global sleep
sleep:
 li a7, SYS_sleep
 3e6:	48b5                	li	a7,13
 ecall
 3e8:	00000073          	ecall
 ret
 3ec:	8082                	ret

00000000000003ee <uptime>:
.global uptime
uptime:
 li a7, SYS_uptime
 3ee:	48b9                	li	a7,14
 ecall
 3f0:	00000073          	ecall
 ret
 3f4:	8082                	ret

00000000000003f6 <poweroff>:
.global poweroff
poweroff:
 li a7, SYS_poweroff
 3f6:	48d9                	li	a7,22
 ecall
 3f8:	00000073          	ecall
 ret
 3fc:	8082                	ret

00000000000003fe <printint>:
  write(fd, &c, 1);
}

static void
printint(int fd, int xx, int base, int sgn)
{
 3fe:	715d                	add	sp,sp,-80
 400:	e0a2                	sd	s0,64(sp)
 402:	f84a                	sd	s2,48(sp)
 404:	e486                	sd	ra,72(sp)
 406:	fc26                	sd	s1,56(sp)
 408:	f44e                	sd	s3,40(sp)
 40a:	0880                	add	s0,sp,80
 40c:	892a                	mv	s2,a0
  char buf[16];
  int i, neg;
  uint x;

  neg = 0;
  if(sgn && xx < 0){
 40e:	c299                	beqz	a3,414 <printint+0x16>
 410:	0805c263          	bltz	a1,494 <printint+0x96>
    neg = 1;
    x = -xx;
  } else {
    x = xx;
 414:	2581                	sext.w	a1,a1
  neg = 0;
 416:	4681                	li	a3,0
  }

  i = 0;
  do{
    buf[i++] = digits[x % base];
 418:	2601                	sext.w	a2,a2
 41a:	fc040713          	add	a4,s0,-64
  i = 0;
 41e:	4501                	li	a0,0
 420:	00000897          	auipc	a7,0x0
 424:	4f088893          	add	a7,a7,1264 # 910 <digits>
    buf[i++] = digits[x % base];
 428:	02c5f7bb          	remuw	a5,a1,a2
  }while((x /= base) != 0);
 42c:	0705                	add	a4,a4,1
 42e:	0005881b          	sext.w	a6,a1
 432:	84aa                	mv	s1,a0
    buf[i++] = digits[x % base];
 434:	2505                	addw	a0,a0,1
 436:	1782                	sll	a5,a5,0x20
 438:	9381                	srl	a5,a5,0x20
 43a:	97c6                	add	a5,a5,a7
 43c:	0007c783          	lbu	a5,0(a5)
  }while((x /= base) != 0);
 440:	02c5d5bb          	divuw	a1,a1,a2
    buf[i++] = digits[x % base];
 444:	fef70fa3          	sb	a5,-1(a4)
  }while((x /= base) != 0);
 448:	fec870e3          	bgeu	a6,a2,428 <printint+0x2a>
  if(neg)
 44c:	ca89                	beqz	a3,45e <printint+0x60>
    buf[i++] = '-';
 44e:	fd050793          	add	a5,a0,-48
 452:	97a2                	add	a5,a5,s0
 454:	02d00713          	li	a4,45
 458:	fee78823          	sb	a4,-16(a5)

  while(--i >= 0)
 45c:	84aa                	mv	s1,a0
 45e:	fc040793          	add	a5,s0,-64
 462:	94be                	add	s1,s1,a5
 464:	fff78993          	add	s3,a5,-1
    putc(fd, buf[i]);
 468:	0004c783          	lbu	a5,0(s1)
  write(fd, &c, 1);
 46c:	4605                	li	a2,1
 46e:	fbf40593          	add	a1,s0,-65
 472:	854a                	mv	a0,s2
  while(--i >= 0)
 474:	14fd                	add	s1,s1,-1
 476:	faf40fa3          	sb	a5,-65(s0)
  write(fd, &c, 1);
 47a:	00000097          	auipc	ra,0x0
 47e:	efc080e7          	jalr	-260(ra) # 376 <write>
  while(--i >= 0)
 482:	ff3493e3          	bne	s1,s3,468 <printint+0x6a>
}
 486:	60a6                	ld	ra,72(sp)
 488:	6406                	ld	s0,64(sp)
 48a:	74e2                	ld	s1,56(sp)
 48c:	7942                	ld	s2,48(sp)
 48e:	79a2                	ld	s3,40(sp)
 490:	6161                	add	sp,sp,80
 492:	8082                	ret
    x = -xx;
 494:	40b005bb          	negw	a1,a1
 498:	b741                	j	418 <printint+0x1a>

000000000000049a <vprintf>:
}

// Print to the given fd. Only understands %d, %x, %p, %s.
void
vprintf(int fd, const char *fmt, va_list ap)
{
 49a:	7159                	add	sp,sp,-112
 49c:	f0a2                	sd	s0,96(sp)
 49e:	f486                	sd	ra,104(sp)
 4a0:	e8ca                	sd	s2,80(sp)
 4a2:	1880                	add	s0,sp,112
  char *s;
  int c, i, state;

  state = 0;
  for(i = 0; fmt[i]; i++){
 4a4:	0005c903          	lbu	s2,0(a1)
 4a8:	04090f63          	beqz	s2,506 <vprintf+0x6c>
 4ac:	eca6                	sd	s1,88(sp)
 4ae:	e4ce                	sd	s3,72(sp)
 4b0:	e0d2                	sd	s4,64(sp)
 4b2:	fc56                	sd	s5,56(sp)
 4b4:	f85a                	sd	s6,48(sp)
 4b6:	f45e                	sd	s7,40(sp)
 4b8:	f062                	sd	s8,32(sp)
 4ba:	8a2a                	mv	s4,a0
 4bc:	8c32                	mv	s8,a2
 4be:	00158493          	add	s1,a1,1
 4c2:	4981                	li	s3,0
      if(c == '%'){
        state = '%';
      } else {
        putc(fd, c);
      }
    } else if(state == '%'){
 4c4:	02500a93          	li	s5,37
 4c8:	4bd5                	li	s7,21
 4ca:	00000b17          	auipc	s6,0x0
 4ce:	3eeb0b13          	add	s6,s6,1006 # 8b8 <malloc+0x138>
    if(state == 0){
 4d2:	02099f63          	bnez	s3,510 <vprintf+0x76>
      if(c == '%'){
 4d6:	05590c63          	beq	s2,s5,52e <vprintf+0x94>
  write(fd, &c, 1);
 4da:	4605                	li	a2,1
 4dc:	f9f40593          	add	a1,s0,-97
 4e0:	8552                	mv	a0,s4
 4e2:	f9240fa3          	sb	s2,-97(s0)
 4e6:	00000097          	auipc	ra,0x0
 4ea:	e90080e7          	jalr	-368(ra) # 376 <write>
  for(i = 0; fmt[i]; i++){
 4ee:	0004c903          	lbu	s2,0(s1)
 4f2:	0485                	add	s1,s1,1
 4f4:	fc091fe3          	bnez	s2,4d2 <vprintf+0x38>
 4f8:	64e6                	ld	s1,88(sp)
 4fa:	69a6                	ld	s3,72(sp)
 4fc:	6a06                	ld	s4,64(sp)
 4fe:	7ae2                	ld	s5,56(sp)
 500:	7b42                	ld	s6,48(sp)
 502:	7ba2                	ld	s7,40(sp)
 504:	7c02                	ld	s8,32(sp)
        putc(fd, c);
      }
      state = 0;
    }
  }
}
 506:	70a6                	ld	ra,104(sp)
 508:	7406                	ld	s0,96(sp)
 50a:	6946                	ld	s2,80(sp)
 50c:	6165                	add	sp,sp,112
 50e:	8082                	ret
    } else if(state == '%'){
 510:	fd599fe3          	bne	s3,s5,4ee <vprintf+0x54>
      if(c == 'd'){
 514:	15590463          	beq	s2,s5,65c <vprintf+0x1c2>
 518:	f9d9079b          	addw	a5,s2,-99
 51c:	0ff7f793          	zext.b	a5,a5
 520:	00fbea63          	bltu	s7,a5,534 <vprintf+0x9a>
 524:	078a                	sll	a5,a5,0x2
 526:	97da                	add	a5,a5,s6
 528:	439c                	lw	a5,0(a5)
 52a:	97da                	add	a5,a5,s6
 52c:	8782                	jr	a5
        state = '%';
 52e:	02500993          	li	s3,37
 532:	bf75                	j	4ee <vprintf+0x54>
  write(fd, &c, 1);
 534:	f9f40993          	add	s3,s0,-97
 538:	4605                	li	a2,1
 53a:	85ce                	mv	a1,s3
 53c:	02500793          	li	a5,37
 540:	8552                	mv	a0,s4
 542:	f8f40fa3          	sb	a5,-97(s0)
 546:	00000097          	auipc	ra,0x0
 54a:	e30080e7          	jalr	-464(ra) # 376 <write>
 54e:	4605                	li	a2,1
 550:	85ce                	mv	a1,s3
 552:	8552                	mv	a0,s4
 554:	f9240fa3          	sb	s2,-97(s0)
 558:	00000097          	auipc	ra,0x0
 55c:	e1e080e7          	jalr	-482(ra) # 376 <write>
        while(*s != 0){
 560:	4981                	li	s3,0
 562:	b771                	j	4ee <vprintf+0x54>
        putc(fd, va_arg(ap, uint));
 564:	000c2783          	lw	a5,0(s8)
  write(fd, &c, 1);
 568:	4605                	li	a2,1
 56a:	f9f40593          	add	a1,s0,-97
 56e:	8552                	mv	a0,s4
        putc(fd, va_arg(ap, uint));
 570:	f8f40fa3          	sb	a5,-97(s0)
 574:	0c21                	add	s8,s8,8
  write(fd, &c, 1);
 576:	00000097          	auipc	ra,0x0
 57a:	e00080e7          	jalr	-512(ra) # 376 <write>
 57e:	4981                	li	s3,0
 580:	b7bd                	j	4ee <vprintf+0x54>
        printint(fd, va_arg(ap, int), 10, 1);
 582:	000c2583          	lw	a1,0(s8)
 586:	4685                	li	a3,1
        printint(fd, va_arg(ap, uint64), 10, 0);
 588:	4629                	li	a2,10
 58a:	8552                	mv	a0,s4
 58c:	0c21                	add	s8,s8,8
 58e:	00000097          	auipc	ra,0x0
 592:	e70080e7          	jalr	-400(ra) # 3fe <printint>
 596:	4981                	li	s3,0
 598:	bf99                	j	4ee <vprintf+0x54>
 59a:	000c2583          	lw	a1,0(s8)
 59e:	4681                	li	a3,0
 5a0:	b7e5                	j	588 <vprintf+0xee>
  write(fd, &c, 1);
 5a2:	f9f40993          	add	s3,s0,-97
 5a6:	03000793          	li	a5,48
 5aa:	4605                	li	a2,1
 5ac:	85ce                	mv	a1,s3
 5ae:	8552                	mv	a0,s4
 5b0:	ec66                	sd	s9,24(sp)
 5b2:	e86a                	sd	s10,16(sp)
        printptr(fd, va_arg(ap, uint64));
 5b4:	f8f40fa3          	sb	a5,-97(s0)
 5b8:	000c3d03          	ld	s10,0(s8)
  write(fd, &c, 1);
 5bc:	00000097          	auipc	ra,0x0
 5c0:	dba080e7          	jalr	-582(ra) # 376 <write>
 5c4:	07800793          	li	a5,120
 5c8:	4605                	li	a2,1
 5ca:	85ce                	mv	a1,s3
 5cc:	8552                	mv	a0,s4
 5ce:	f8f40fa3          	sb	a5,-97(s0)
        printptr(fd, va_arg(ap, uint64));
 5d2:	0c21                	add	s8,s8,8
  write(fd, &c, 1);
 5d4:	00000097          	auipc	ra,0x0
 5d8:	da2080e7          	jalr	-606(ra) # 376 <write>
  putc(fd, 'x');
 5dc:	4941                	li	s2,16
 5de:	00000c97          	auipc	s9,0x0
 5e2:	332c8c93          	add	s9,s9,818 # 910 <digits>
    putc(fd, digits[x >> (sizeof(uint64) * 8 - 4)]);
 5e6:	03cd5793          	srl	a5,s10,0x3c
 5ea:	97e6                	add	a5,a5,s9
 5ec:	0007c783          	lbu	a5,0(a5)
  write(fd, &c, 1);
 5f0:	4605                	li	a2,1
 5f2:	85ce                	mv	a1,s3
 5f4:	8552                	mv	a0,s4
  for (i = 0; i < (sizeof(uint64) * 2); i++, x <<= 4)
 5f6:	397d                	addw	s2,s2,-1
 5f8:	f8f40fa3          	sb	a5,-97(s0)
 5fc:	0d12                	sll	s10,s10,0x4
  write(fd, &c, 1);
 5fe:	00000097          	auipc	ra,0x0
 602:	d78080e7          	jalr	-648(ra) # 376 <write>
  for (i = 0; i < (sizeof(uint64) * 2); i++, x <<= 4)
 606:	fe0910e3          	bnez	s2,5e6 <vprintf+0x14c>
 60a:	6ce2                	ld	s9,24(sp)
 60c:	6d42                	ld	s10,16(sp)
 60e:	4981                	li	s3,0
 610:	bdf9                	j	4ee <vprintf+0x54>
        s = va_arg(ap, char*);
 612:	000c3903          	ld	s2,0(s8)
 616:	0c21                	add	s8,s8,8
        if(s == 0)
 618:	04090e63          	beqz	s2,674 <vprintf+0x1da>
        while(*s != 0){
 61c:	00094783          	lbu	a5,0(s2)
 620:	d3a1                	beqz	a5,560 <vprintf+0xc6>
 622:	f9f40993          	add	s3,s0,-97
  write(fd, &c, 1);
 626:	4605                	li	a2,1
 628:	85ce                	mv	a1,s3
 62a:	8552                	mv	a0,s4
 62c:	f8f40fa3          	sb	a5,-97(s0)
 630:	00000097          	auipc	ra,0x0
 634:	d46080e7          	jalr	-698(ra) # 376 <write>
        while(*s != 0){
 638:	00194783          	lbu	a5,1(s2)
          s++;
 63c:	0905                	add	s2,s2,1
        while(*s != 0){
 63e:	f7e5                	bnez	a5,626 <vprintf+0x18c>
 640:	4981                	li	s3,0
 642:	b575                	j	4ee <vprintf+0x54>
        printint(fd, va_arg(ap, int), 16, 0);
 644:	000c2583          	lw	a1,0(s8)
 648:	4681                	li	a3,0
 64a:	4641                	li	a2,16
 64c:	8552                	mv	a0,s4
 64e:	0c21                	add	s8,s8,8
 650:	00000097          	auipc	ra,0x0
 654:	dae080e7          	jalr	-594(ra) # 3fe <printint>
 658:	4981                	li	s3,0
 65a:	bd51                	j	4ee <vprintf+0x54>
  write(fd, &c, 1);
 65c:	4605                	li	a2,1
 65e:	f9f40593          	add	a1,s0,-97
 662:	8552                	mv	a0,s4
 664:	f9540fa3          	sb	s5,-97(s0)
        while(*s != 0){
 668:	4981                	li	s3,0
  write(fd, &c, 1);
 66a:	00000097          	auipc	ra,0x0
 66e:	d0c080e7          	jalr	-756(ra) # 376 <write>
 672:	bdb5                	j	4ee <vprintf+0x54>
          s = "(null)";
 674:	00000917          	auipc	s2,0x0
 678:	23c90913          	add	s2,s2,572 # 8b0 <malloc+0x130>
 67c:	02800793          	li	a5,40
 680:	b74d                	j	622 <vprintf+0x188>

0000000000000682 <fprintf>:

void
fprintf(int fd, const char *fmt, ...)
{
 682:	715d                	add	sp,sp,-80
 684:	e822                	sd	s0,16(sp)
 686:	ec06                	sd	ra,24(sp)
 688:	1000                	add	s0,sp,32
 68a:	e010                	sd	a2,0(s0)
  va_list ap;

  va_start(ap, fmt);
  vprintf(fd, fmt, ap);
 68c:	8622                	mv	a2,s0
{
 68e:	e414                	sd	a3,8(s0)
 690:	e818                	sd	a4,16(s0)
 692:	ec1c                	sd	a5,24(s0)
 694:	03043023          	sd	a6,32(s0)
 698:	03143423          	sd	a7,40(s0)
  va_start(ap, fmt);
 69c:	fe843423          	sd	s0,-24(s0)
  vprintf(fd, fmt, ap);
 6a0:	00000097          	auipc	ra,0x0
 6a4:	dfa080e7          	jalr	-518(ra) # 49a <vprintf>
}
 6a8:	60e2                	ld	ra,24(sp)
 6aa:	6442                	ld	s0,16(sp)
 6ac:	6161                	add	sp,sp,80
 6ae:	8082                	ret

00000000000006b0 <printf>:

void
printf(const char *fmt, ...)
{
 6b0:	711d                	add	sp,sp,-96
 6b2:	e822                	sd	s0,16(sp)
 6b4:	ec06                	sd	ra,24(sp)
 6b6:	1000                	add	s0,sp,32
  va_list ap;

  va_start(ap, fmt);
 6b8:	00840313          	add	t1,s0,8
{
 6bc:	e40c                	sd	a1,8(s0)
 6be:	e810                	sd	a2,16(s0)
  vprintf(1, fmt, ap);
 6c0:	85aa                	mv	a1,a0
 6c2:	861a                	mv	a2,t1
 6c4:	4505                	li	a0,1
{
 6c6:	ec14                	sd	a3,24(s0)
 6c8:	f018                	sd	a4,32(s0)
 6ca:	f41c                	sd	a5,40(s0)
 6cc:	03043823          	sd	a6,48(s0)
 6d0:	03143c23          	sd	a7,56(s0)
  va_start(ap, fmt);
 6d4:	fe643423          	sd	t1,-24(s0)
  vprintf(1, fmt, ap);
 6d8:	00000097          	auipc	ra,0x0
 6dc:	dc2080e7          	jalr	-574(ra) # 49a <vprintf>
}
 6e0:	60e2                	ld	ra,24(sp)
 6e2:	6442                	ld	s0,16(sp)
 6e4:	6125                	add	sp,sp,96
 6e6:	8082                	ret

00000000000006e8 <free>:
static Header base;
static Header *freep;

void
free(void *ap)
{
 6e8:	1141                	add	sp,sp,-16
 6ea:	e422                	sd	s0,8(sp)
 6ec:	0800                	add	s0,sp,16
  Header *bp, *p;

  bp = (Header*)ap - 1;
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 6ee:	00001597          	auipc	a1,0x1
 6f2:	91258593          	add	a1,a1,-1774 # 1000 <freep>
 6f6:	619c                	ld	a5,0(a1)
  bp = (Header*)ap - 1;
 6f8:	ff050693          	add	a3,a0,-16
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 6fc:	6398                	ld	a4,0(a5)
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 6fe:	02d7ff63          	bgeu	a5,a3,73c <free+0x54>
 702:	00e6e463          	bltu	a3,a4,70a <free+0x22>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 706:	02e7ef63          	bltu	a5,a4,744 <free+0x5c>
      break;
  if(bp + bp->s.size == p->s.ptr){
 70a:	ff852803          	lw	a6,-8(a0)
 70e:	02081893          	sll	a7,a6,0x20
 712:	01c8d613          	srl	a2,a7,0x1c
 716:	9636                	add	a2,a2,a3
 718:	02c70863          	beq	a4,a2,748 <free+0x60>
    bp->s.size += p->s.ptr->s.size;
    bp->s.ptr = p->s.ptr->s.ptr;
  } else
    bp->s.ptr = p->s.ptr;
  if(p + p->s.size == bp){
 71c:	0087a803          	lw	a6,8(a5)
 720:	fee53823          	sd	a4,-16(a0)
 724:	02081893          	sll	a7,a6,0x20
 728:	01c8d613          	srl	a2,a7,0x1c
 72c:	963e                	add	a2,a2,a5
 72e:	02c68e63          	beq	a3,a2,76a <free+0x82>
    p->s.size += bp->s.size;
    p->s.ptr = bp->s.ptr;
  } else
    p->s.ptr = bp;
  freep = p;
}
 732:	6422                	ld	s0,8(sp)
 734:	e394                	sd	a3,0(a5)
  freep = p;
 736:	e19c                	sd	a5,0(a1)
}
 738:	0141                	add	sp,sp,16
 73a:	8082                	ret
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 73c:	00e7e463          	bltu	a5,a4,744 <free+0x5c>
 740:	fce6e5e3          	bltu	a3,a4,70a <free+0x22>
{
 744:	87ba                	mv	a5,a4
 746:	bf5d                	j	6fc <free+0x14>
    bp->s.size += p->s.ptr->s.size;
 748:	4710                	lw	a2,8(a4)
    bp->s.ptr = p->s.ptr->s.ptr;
 74a:	6318                	ld	a4,0(a4)
    bp->s.size += p->s.ptr->s.size;
 74c:	0106063b          	addw	a2,a2,a6
 750:	fec52c23          	sw	a2,-8(a0)
  if(p + p->s.size == bp){
 754:	0087a803          	lw	a6,8(a5)
 758:	fee53823          	sd	a4,-16(a0)
 75c:	02081893          	sll	a7,a6,0x20
 760:	01c8d613          	srl	a2,a7,0x1c
 764:	963e                	add	a2,a2,a5
 766:	fcc696e3          	bne	a3,a2,732 <free+0x4a>
    p->s.size += bp->s.size;
 76a:	ff852603          	lw	a2,-8(a0)
}
 76e:	6422                	ld	s0,8(sp)
    p->s.ptr = bp->s.ptr;
 770:	86ba                	mv	a3,a4
    p->s.size += bp->s.size;
 772:	0106073b          	addw	a4,a2,a6
 776:	c798                	sw	a4,8(a5)
    p->s.ptr = bp->s.ptr;
 778:	e394                	sd	a3,0(a5)
  freep = p;
 77a:	e19c                	sd	a5,0(a1)
}
 77c:	0141                	add	sp,sp,16
 77e:	8082                	ret

0000000000000780 <malloc>:
  return freep;
}

void*
malloc(uint nbytes)
{
 780:	7139                	add	sp,sp,-64
 782:	f822                	sd	s0,48(sp)
 784:	f426                	sd	s1,40(sp)
 786:	f04a                	sd	s2,32(sp)
 788:	ec4e                	sd	s3,24(sp)
 78a:	fc06                	sd	ra,56(sp)
 78c:	0080                	add	s0,sp,64
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
  if((prevp = freep) == 0){
 78e:	00001917          	auipc	s2,0x1
 792:	87290913          	add	s2,s2,-1934 # 1000 <freep>
  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
 796:	02051493          	sll	s1,a0,0x20
 79a:	9081                	srl	s1,s1,0x20
  if((prevp = freep) == 0){
 79c:	00093783          	ld	a5,0(s2)
  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
 7a0:	04bd                	add	s1,s1,15
 7a2:	8091                	srl	s1,s1,0x4
 7a4:	0014899b          	addw	s3,s1,1
 7a8:	0485                	add	s1,s1,1
  if((prevp = freep) == 0){
 7aa:	c3dd                	beqz	a5,850 <malloc+0xd0>
    base.s.ptr = freep = prevp = &base;
    base.s.size = 0;
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 7ac:	6388                	ld	a0,0(a5)
    if(p->s.size >= nunits){
 7ae:	4518                	lw	a4,8(a0)
 7b0:	06977863          	bgeu	a4,s1,820 <malloc+0xa0>
 7b4:	e852                	sd	s4,16(sp)
 7b6:	e456                	sd	s5,8(sp)
 7b8:	e05a                	sd	s6,0(sp)
  if(nu < 4096)
 7ba:	6785                	lui	a5,0x1
 7bc:	8a4e                	mv	s4,s3
 7be:	08f4e763          	bltu	s1,a5,84c <malloc+0xcc>
 7c2:	000a0b1b          	sext.w	s6,s4
  if(p == (char*)-1)
 7c6:	5afd                	li	s5,-1
  p = sbrk(nu * sizeof(Header));
 7c8:	004a1a1b          	sllw	s4,s4,0x4
 7cc:	a029                	j	7d6 <malloc+0x56>
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 7ce:	6388                	ld	a0,0(a5)
    if(p->s.size >= nunits){
 7d0:	4518                	lw	a4,8(a0)
 7d2:	04977463          	bgeu	a4,s1,81a <malloc+0x9a>
        p->s.size = nunits;
      }
      freep = prevp;
      return (void*)(p + 1);
    }
    if(p == freep)
 7d6:	00093703          	ld	a4,0(s2)
 7da:	87aa                	mv	a5,a0
 7dc:	fee519e3          	bne	a0,a4,7ce <malloc+0x4e>
  p = sbrk(nu * sizeof(Header));
 7e0:	8552                	mv	a0,s4
 7e2:	00000097          	auipc	ra,0x0
 7e6:	bfc080e7          	jalr	-1028(ra) # 3de <sbrk>
 7ea:	87aa                	mv	a5,a0
  free((void*)(hp + 1));
 7ec:	0541                	add	a0,a0,16
  if(p == (char*)-1)
 7ee:	01578b63          	beq	a5,s5,804 <malloc+0x84>
  hp->s.size = nu;
 7f2:	0167a423          	sw	s6,8(a5) # 1008 <freep+0x8>
  free((void*)(hp + 1));
 7f6:	00000097          	auipc	ra,0x0
 7fa:	ef2080e7          	jalr	-270(ra) # 6e8 <free>
  return freep;
 7fe:	00093783          	ld	a5,0(s2)
      if((p = morecore(nunits)) == 0)
 802:	f7f1                	bnez	a5,7ce <malloc+0x4e>
        return 0;
  }
}
 804:	70e2                	ld	ra,56(sp)
 806:	7442                	ld	s0,48(sp)
        return 0;
 808:	6a42                	ld	s4,16(sp)
 80a:	6aa2                	ld	s5,8(sp)
 80c:	6b02                	ld	s6,0(sp)
}
 80e:	74a2                	ld	s1,40(sp)
 810:	7902                	ld	s2,32(sp)
 812:	69e2                	ld	s3,24(sp)
        return 0;
 814:	4501                	li	a0,0
}
 816:	6121                	add	sp,sp,64
 818:	8082                	ret
 81a:	6a42                	ld	s4,16(sp)
 81c:	6aa2                	ld	s5,8(sp)
 81e:	6b02                	ld	s6,0(sp)
      if(p->s.size == nunits)
 820:	04e48763          	beq	s1,a4,86e <malloc+0xee>
        p->s.size -= nunits;
 824:	4137073b          	subw	a4,a4,s3
        p += p->s.size;
 828:	02071613          	sll	a2,a4,0x20
 82c:	01c65693          	srl	a3,a2,0x1c
        p->s.size -= nunits;
 830:	c518                	sw	a4,8(a0)
        p += p->s.size;
 832:	9536                	add	a0,a0,a3
        p->s.size = nunits;
 834:	01352423          	sw	s3,8(a0)
}
 838:	70e2                	ld	ra,56(sp)
 83a:	7442                	ld	s0,48(sp)
      freep = prevp;
 83c:	00f93023          	sd	a5,0(s2)
}
 840:	74a2                	ld	s1,40(sp)
 842:	7902                	ld	s2,32(sp)
 844:	69e2                	ld	s3,24(sp)
      return (void*)(p + 1);
 846:	0541                	add	a0,a0,16
}
 848:	6121                	add	sp,sp,64
 84a:	8082                	ret
  if(nu < 4096)
 84c:	6a05                	lui	s4,0x1
 84e:	bf95                	j	7c2 <malloc+0x42>
 850:	e852                	sd	s4,16(sp)
 852:	e456                	sd	s5,8(sp)
 854:	e05a                	sd	s6,0(sp)
    base.s.ptr = freep = prevp = &base;
 856:	00000517          	auipc	a0,0x0
 85a:	7ba50513          	add	a0,a0,1978 # 1010 <base>
 85e:	00a93023          	sd	a0,0(s2)
 862:	e108                	sd	a0,0(a0)
    base.s.size = 0;
 864:	00000797          	auipc	a5,0x0
 868:	7a07aa23          	sw	zero,1972(a5) # 1018 <base+0x8>
    if(p->s.size >= nunits){
 86c:	b7b9                	j	7ba <malloc+0x3a>
        prevp->s.ptr = p->s.ptr;
 86e:	6118                	ld	a4,0(a0)
 870:	e398                	sd	a4,0(a5)
 872:	b7d9                	j	838 <malloc+0xb8>
