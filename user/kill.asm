
user/_kill:     file format elf64-littleriscv


Disassembly of section .text:

0000000000000000 <main>:
#include <kern/stat.h>
#include "user/user.h"

int
main(int argc, char **argv)
{
   0:	1101                	add	sp,sp,-32
   2:	e822                	sd	s0,16(sp)
   4:	ec06                	sd	ra,24(sp)
   6:	1000                	add	s0,sp,32
  int i;

  if(argc < 2){
   8:	4785                	li	a5,1
   a:	e426                	sd	s1,8(sp)
   c:	e04a                	sd	s2,0(sp)
   e:	02a7de63          	bge	a5,a0,4a <main+0x4a>
  12:	ffe5091b          	addw	s2,a0,-2
  16:	02091793          	sll	a5,s2,0x20
  1a:	01d7d913          	srl	s2,a5,0x1d
  1e:	01058793          	add	a5,a1,16
  22:	00858493          	add	s1,a1,8
  26:	993e                	add	s2,s2,a5
    fprintf(2, "usage: kill pid...\n");
    exit(1);
  }
  for(i=1; i<argc; i++)
    kill(atoi(argv[i]));
  28:	6088                	ld	a0,0(s1)
  for(i=1; i<argc; i++)
  2a:	04a1                	add	s1,s1,8
    kill(atoi(argv[i]));
  2c:	00000097          	auipc	ra,0x0
  30:	1e4080e7          	jalr	484(ra) # 210 <atoi>
  34:	00000097          	auipc	ra,0x0
  38:	358080e7          	jalr	856(ra) # 38c <kill>
  for(i=1; i<argc; i++)
  3c:	ff2496e3          	bne	s1,s2,28 <main+0x28>
  exit(0);
  40:	4501                	li	a0,0
  42:	00000097          	auipc	ra,0x0
  46:	31a080e7          	jalr	794(ra) # 35c <exit>
    fprintf(2, "usage: kill pid...\n");
  4a:	4509                	li	a0,2
  4c:	00001597          	auipc	a1,0x1
  50:	83458593          	add	a1,a1,-1996 # 880 <malloc+0xfa>
  54:	00000097          	auipc	ra,0x0
  58:	634080e7          	jalr	1588(ra) # 688 <fprintf>
    exit(1);
  5c:	4505                	li	a0,1
  5e:	00000097          	auipc	ra,0x0
  62:	2fe080e7          	jalr	766(ra) # 35c <exit>

0000000000000066 <_main>:
//
// wrapper so that it's OK if main() does not call exit().
//
void
_main()
{
  66:	1141                	add	sp,sp,-16
  68:	e022                	sd	s0,0(sp)
  6a:	e406                	sd	ra,8(sp)
  6c:	0800                	add	s0,sp,16
  extern int main();
  main();
  6e:	00000097          	auipc	ra,0x0
  72:	f92080e7          	jalr	-110(ra) # 0 <main>
  exit(0);
  76:	4501                	li	a0,0
  78:	00000097          	auipc	ra,0x0
  7c:	2e4080e7          	jalr	740(ra) # 35c <exit>

0000000000000080 <strcpy>:
}

char*
strcpy(char *s, const char *t)
{
  80:	1141                	add	sp,sp,-16
  82:	e422                	sd	s0,8(sp)
  84:	0800                	add	s0,sp,16
  char *os;

  os = s;
  while((*s++ = *t++) != 0)
  86:	87aa                	mv	a5,a0
  88:	0005c703          	lbu	a4,0(a1)
  8c:	0785                	add	a5,a5,1
  8e:	0585                	add	a1,a1,1
  90:	fee78fa3          	sb	a4,-1(a5)
  94:	fb75                	bnez	a4,88 <strcpy+0x8>
    ;
  return os;
}
  96:	6422                	ld	s0,8(sp)
  98:	0141                	add	sp,sp,16
  9a:	8082                	ret

000000000000009c <strcmp>:

int
strcmp(const char *p, const char *q)
{
  9c:	1141                	add	sp,sp,-16
  9e:	e422                	sd	s0,8(sp)
  a0:	0800                	add	s0,sp,16
  while(*p && *p == *q)
  a2:	00054783          	lbu	a5,0(a0)
  a6:	e791                	bnez	a5,b2 <strcmp+0x16>
  a8:	a80d                	j	da <strcmp+0x3e>
  aa:	00054783          	lbu	a5,0(a0)
  ae:	cf99                	beqz	a5,cc <strcmp+0x30>
  b0:	85b6                	mv	a1,a3
  b2:	0005c703          	lbu	a4,0(a1)
    p++, q++;
  b6:	0505                	add	a0,a0,1
  b8:	00158693          	add	a3,a1,1
  while(*p && *p == *q)
  bc:	fef707e3          	beq	a4,a5,aa <strcmp+0xe>
  return (uchar)*p - (uchar)*q;
  c0:	0007851b          	sext.w	a0,a5
}
  c4:	6422                	ld	s0,8(sp)
  c6:	9d19                	subw	a0,a0,a4
  c8:	0141                	add	sp,sp,16
  ca:	8082                	ret
  return (uchar)*p - (uchar)*q;
  cc:	0015c703          	lbu	a4,1(a1)
}
  d0:	6422                	ld	s0,8(sp)
  return (uchar)*p - (uchar)*q;
  d2:	4501                	li	a0,0
}
  d4:	9d19                	subw	a0,a0,a4
  d6:	0141                	add	sp,sp,16
  d8:	8082                	ret
  return (uchar)*p - (uchar)*q;
  da:	0005c703          	lbu	a4,0(a1)
  de:	4501                	li	a0,0
  e0:	b7d5                	j	c4 <strcmp+0x28>

00000000000000e2 <strlen>:

uint
strlen(const char *s)
{
  e2:	1141                	add	sp,sp,-16
  e4:	e422                	sd	s0,8(sp)
  e6:	0800                	add	s0,sp,16
  int n;

  for(n = 0; s[n]; n++)
  e8:	00054783          	lbu	a5,0(a0)
  ec:	cf91                	beqz	a5,108 <strlen+0x26>
  ee:	0505                	add	a0,a0,1
  f0:	87aa                	mv	a5,a0
  f2:	0007c703          	lbu	a4,0(a5)
  f6:	86be                	mv	a3,a5
  f8:	0785                	add	a5,a5,1
  fa:	ff65                	bnez	a4,f2 <strlen+0x10>
    ;
  return n;
}
  fc:	6422                	ld	s0,8(sp)
  fe:	40a6853b          	subw	a0,a3,a0
 102:	2505                	addw	a0,a0,1
 104:	0141                	add	sp,sp,16
 106:	8082                	ret
 108:	6422                	ld	s0,8(sp)
  for(n = 0; s[n]; n++)
 10a:	4501                	li	a0,0
}
 10c:	0141                	add	sp,sp,16
 10e:	8082                	ret

0000000000000110 <memset>:

void*
memset(void *dst, int c, uint n)
{
 110:	1141                	add	sp,sp,-16
 112:	e422                	sd	s0,8(sp)
 114:	0800                	add	s0,sp,16
  char *cdst = (char *) dst;
  int i;
  for(i = 0; i < n; i++){
 116:	ce09                	beqz	a2,130 <memset+0x20>
 118:	1602                	sll	a2,a2,0x20
 11a:	9201                	srl	a2,a2,0x20
    cdst[i] = c;
 11c:	0ff5f593          	zext.b	a1,a1
 120:	87aa                	mv	a5,a0
 122:	00a60733          	add	a4,a2,a0
 126:	00b78023          	sb	a1,0(a5)
  for(i = 0; i < n; i++){
 12a:	0785                	add	a5,a5,1
 12c:	fee79de3          	bne	a5,a4,126 <memset+0x16>
  }
  return dst;
}
 130:	6422                	ld	s0,8(sp)
 132:	0141                	add	sp,sp,16
 134:	8082                	ret

0000000000000136 <strchr>:

char*
strchr(const char *s, char c)
{
 136:	1141                	add	sp,sp,-16
 138:	e422                	sd	s0,8(sp)
 13a:	0800                	add	s0,sp,16
  for(; *s; s++)
 13c:	00054783          	lbu	a5,0(a0)
 140:	c799                	beqz	a5,14e <strchr+0x18>
    if(*s == c)
 142:	00f58763          	beq	a1,a5,150 <strchr+0x1a>
  for(; *s; s++)
 146:	00154783          	lbu	a5,1(a0)
 14a:	0505                	add	a0,a0,1
 14c:	fbfd                	bnez	a5,142 <strchr+0xc>
      return (char*)s;
  return 0;
 14e:	4501                	li	a0,0
}
 150:	6422                	ld	s0,8(sp)
 152:	0141                	add	sp,sp,16
 154:	8082                	ret

0000000000000156 <gets>:

char*
gets(char *buf, int max)
{
 156:	711d                	add	sp,sp,-96
 158:	e8a2                	sd	s0,80(sp)
 15a:	e4a6                	sd	s1,72(sp)
 15c:	e0ca                	sd	s2,64(sp)
 15e:	fc4e                	sd	s3,56(sp)
 160:	f852                	sd	s4,48(sp)
 162:	f05a                	sd	s6,32(sp)
 164:	ec5e                	sd	s7,24(sp)
 166:	ec86                	sd	ra,88(sp)
 168:	f456                	sd	s5,40(sp)
 16a:	1080                	add	s0,sp,96
 16c:	8baa                	mv	s7,a0
 16e:	89ae                	mv	s3,a1
 170:	892a                	mv	s2,a0
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
 172:	4481                	li	s1,0
    cc = read(0, &c, 1);
    if(cc < 1)
      break;
    buf[i++] = c;
    if(c == '\n' || c == '\r')
 174:	4a29                	li	s4,10
 176:	4b35                	li	s6,13
  for(i=0; i+1 < max; ){
 178:	a005                	j	198 <gets+0x42>
    cc = read(0, &c, 1);
 17a:	00000097          	auipc	ra,0x0
 17e:	1fa080e7          	jalr	506(ra) # 374 <read>
    if(cc < 1)
 182:	02a05363          	blez	a0,1a8 <gets+0x52>
    buf[i++] = c;
 186:	faf44783          	lbu	a5,-81(s0)
    if(c == '\n' || c == '\r')
 18a:	0905                	add	s2,s2,1
    buf[i++] = c;
 18c:	fef90fa3          	sb	a5,-1(s2)
    if(c == '\n' || c == '\r')
 190:	01478d63          	beq	a5,s4,1aa <gets+0x54>
 194:	01678b63          	beq	a5,s6,1aa <gets+0x54>
  for(i=0; i+1 < max; ){
 198:	8aa6                	mv	s5,s1
 19a:	2485                	addw	s1,s1,1
    cc = read(0, &c, 1);
 19c:	4605                	li	a2,1
 19e:	faf40593          	add	a1,s0,-81
 1a2:	4501                	li	a0,0
  for(i=0; i+1 < max; ){
 1a4:	fd34cbe3          	blt	s1,s3,17a <gets+0x24>
 1a8:	84d6                	mv	s1,s5
      break;
  }
  buf[i] = '\0';
 1aa:	94de                	add	s1,s1,s7
 1ac:	00048023          	sb	zero,0(s1)
  return buf;
}
 1b0:	60e6                	ld	ra,88(sp)
 1b2:	6446                	ld	s0,80(sp)
 1b4:	64a6                	ld	s1,72(sp)
 1b6:	6906                	ld	s2,64(sp)
 1b8:	79e2                	ld	s3,56(sp)
 1ba:	7a42                	ld	s4,48(sp)
 1bc:	7aa2                	ld	s5,40(sp)
 1be:	7b02                	ld	s6,32(sp)
 1c0:	855e                	mv	a0,s7
 1c2:	6be2                	ld	s7,24(sp)
 1c4:	6125                	add	sp,sp,96
 1c6:	8082                	ret

00000000000001c8 <stat>:

int
stat(const char *n, struct stat *st)
{
 1c8:	1101                	add	sp,sp,-32
 1ca:	e822                	sd	s0,16(sp)
 1cc:	e04a                	sd	s2,0(sp)
 1ce:	ec06                	sd	ra,24(sp)
 1d0:	e426                	sd	s1,8(sp)
 1d2:	1000                	add	s0,sp,32
 1d4:	892e                	mv	s2,a1
  int fd;
  int r;

  fd = open(n, O_RDONLY);
 1d6:	4581                	li	a1,0
 1d8:	00000097          	auipc	ra,0x0
 1dc:	1c4080e7          	jalr	452(ra) # 39c <open>
  if(fd < 0)
 1e0:	02054663          	bltz	a0,20c <stat+0x44>
    return -1;
  r = fstat(fd, st);
 1e4:	85ca                	mv	a1,s2
 1e6:	84aa                	mv	s1,a0
 1e8:	00000097          	auipc	ra,0x0
 1ec:	1cc080e7          	jalr	460(ra) # 3b4 <fstat>
 1f0:	87aa                	mv	a5,a0
  close(fd);
 1f2:	8526                	mv	a0,s1
  r = fstat(fd, st);
 1f4:	84be                	mv	s1,a5
  close(fd);
 1f6:	00000097          	auipc	ra,0x0
 1fa:	18e080e7          	jalr	398(ra) # 384 <close>
  return r;
}
 1fe:	60e2                	ld	ra,24(sp)
 200:	6442                	ld	s0,16(sp)
 202:	6902                	ld	s2,0(sp)
 204:	8526                	mv	a0,s1
 206:	64a2                	ld	s1,8(sp)
 208:	6105                	add	sp,sp,32
 20a:	8082                	ret
    return -1;
 20c:	54fd                	li	s1,-1
 20e:	bfc5                	j	1fe <stat+0x36>

0000000000000210 <atoi>:

int
atoi(const char *s)
{
 210:	1141                	add	sp,sp,-16
 212:	e422                	sd	s0,8(sp)
 214:	0800                	add	s0,sp,16
  int n;

  n = 0;
  while('0' <= *s && *s <= '9')
 216:	00054683          	lbu	a3,0(a0)
 21a:	4625                	li	a2,9
 21c:	fd06879b          	addw	a5,a3,-48
 220:	0ff7f793          	zext.b	a5,a5
 224:	02f66863          	bltu	a2,a5,254 <atoi+0x44>
 228:	872a                	mv	a4,a0
  n = 0;
 22a:	4501                	li	a0,0
    n = n*10 + *s++ - '0';
 22c:	0025179b          	sllw	a5,a0,0x2
 230:	9fa9                	addw	a5,a5,a0
 232:	0705                	add	a4,a4,1
 234:	0017979b          	sllw	a5,a5,0x1
 238:	9fb5                	addw	a5,a5,a3
  while('0' <= *s && *s <= '9')
 23a:	00074683          	lbu	a3,0(a4)
    n = n*10 + *s++ - '0';
 23e:	fd07851b          	addw	a0,a5,-48
  while('0' <= *s && *s <= '9')
 242:	fd06879b          	addw	a5,a3,-48
 246:	0ff7f793          	zext.b	a5,a5
 24a:	fef671e3          	bgeu	a2,a5,22c <atoi+0x1c>
  return n;
}
 24e:	6422                	ld	s0,8(sp)
 250:	0141                	add	sp,sp,16
 252:	8082                	ret
 254:	6422                	ld	s0,8(sp)
  n = 0;
 256:	4501                	li	a0,0
}
 258:	0141                	add	sp,sp,16
 25a:	8082                	ret

000000000000025c <memmove>:

void*
memmove(void *vdst, const void *vsrc, int n)
{
 25c:	1141                	add	sp,sp,-16
 25e:	e422                	sd	s0,8(sp)
 260:	0800                	add	s0,sp,16
  char *dst;
  const char *src;

  dst = vdst;
  src = vsrc;
  if (src > dst) {
 262:	02b57463          	bgeu	a0,a1,28a <memmove+0x2e>
    while(n-- > 0)
 266:	00c05f63          	blez	a2,284 <memmove+0x28>
 26a:	1602                	sll	a2,a2,0x20
 26c:	9201                	srl	a2,a2,0x20
 26e:	00c507b3          	add	a5,a0,a2
  dst = vdst;
 272:	872a                	mv	a4,a0
      *dst++ = *src++;
 274:	0005c683          	lbu	a3,0(a1)
 278:	0705                	add	a4,a4,1
 27a:	0585                	add	a1,a1,1
 27c:	fed70fa3          	sb	a3,-1(a4)
    while(n-- > 0)
 280:	fef71ae3          	bne	a4,a5,274 <memmove+0x18>
    src += n;
    while(n-- > 0)
      *--dst = *--src;
  }
  return vdst;
}
 284:	6422                	ld	s0,8(sp)
 286:	0141                	add	sp,sp,16
 288:	8082                	ret
    dst += n;
 28a:	00c50733          	add	a4,a0,a2
    src += n;
 28e:	95b2                	add	a1,a1,a2
    while(n-- > 0)
 290:	fec05ae3          	blez	a2,284 <memmove+0x28>
 294:	fff6079b          	addw	a5,a2,-1
 298:	1782                	sll	a5,a5,0x20
 29a:	9381                	srl	a5,a5,0x20
 29c:	fff7c793          	not	a5,a5
 2a0:	97ae                	add	a5,a5,a1
      *--dst = *--src;
 2a2:	fff5c683          	lbu	a3,-1(a1)
 2a6:	15fd                	add	a1,a1,-1
 2a8:	177d                	add	a4,a4,-1
 2aa:	00d70023          	sb	a3,0(a4)
    while(n-- > 0)
 2ae:	feb79ae3          	bne	a5,a1,2a2 <memmove+0x46>
}
 2b2:	6422                	ld	s0,8(sp)
 2b4:	0141                	add	sp,sp,16
 2b6:	8082                	ret

00000000000002b8 <memcmp>:

int
memcmp(const void *s1, const void *s2, uint n)
{
 2b8:	1141                	add	sp,sp,-16
 2ba:	e422                	sd	s0,8(sp)
 2bc:	0800                	add	s0,sp,16
  const char *p1 = s1, *p2 = s2;
  while (n-- > 0) {
 2be:	c61d                	beqz	a2,2ec <memcmp+0x34>
 2c0:	fff6069b          	addw	a3,a2,-1
 2c4:	1682                	sll	a3,a3,0x20
 2c6:	9281                	srl	a3,a3,0x20
 2c8:	0685                	add	a3,a3,1
 2ca:	96aa                	add	a3,a3,a0
 2cc:	a019                	j	2d2 <memcmp+0x1a>
 2ce:	00a68f63          	beq	a3,a0,2ec <memcmp+0x34>
    if (*p1 != *p2) {
 2d2:	00054783          	lbu	a5,0(a0)
 2d6:	0005c703          	lbu	a4,0(a1)
      return *p1 - *p2;
    }
    p1++;
 2da:	0505                	add	a0,a0,1
    p2++;
 2dc:	0585                	add	a1,a1,1
    if (*p1 != *p2) {
 2de:	fee788e3          	beq	a5,a4,2ce <memcmp+0x16>
  }
  return 0;
}
 2e2:	6422                	ld	s0,8(sp)
      return *p1 - *p2;
 2e4:	40e7853b          	subw	a0,a5,a4
}
 2e8:	0141                	add	sp,sp,16
 2ea:	8082                	ret
 2ec:	6422                	ld	s0,8(sp)
  return 0;
 2ee:	4501                	li	a0,0
}
 2f0:	0141                	add	sp,sp,16
 2f2:	8082                	ret

00000000000002f4 <memcpy>:

void *
memcpy(void *dst, const void *src, uint n)
{
 2f4:	1141                	add	sp,sp,-16
 2f6:	e422                	sd	s0,8(sp)
 2f8:	0800                	add	s0,sp,16
  return memmove(dst, src, n);
 2fa:	0006079b          	sext.w	a5,a2
  if (src > dst) {
 2fe:	02b57463          	bgeu	a0,a1,326 <memcpy+0x32>
    while(n-- > 0)
 302:	00f05f63          	blez	a5,320 <memcpy+0x2c>
 306:	1602                	sll	a2,a2,0x20
 308:	9201                	srl	a2,a2,0x20
 30a:	00c587b3          	add	a5,a1,a2
  dst = vdst;
 30e:	872a                	mv	a4,a0
      *dst++ = *src++;
 310:	0005c683          	lbu	a3,0(a1)
 314:	0585                	add	a1,a1,1
 316:	0705                	add	a4,a4,1
 318:	fed70fa3          	sb	a3,-1(a4)
    while(n-- > 0)
 31c:	fef59ae3          	bne	a1,a5,310 <memcpy+0x1c>
}
 320:	6422                	ld	s0,8(sp)
 322:	0141                	add	sp,sp,16
 324:	8082                	ret
    dst += n;
 326:	00f50733          	add	a4,a0,a5
    src += n;
 32a:	95be                	add	a1,a1,a5
    while(n-- > 0)
 32c:	fef05ae3          	blez	a5,320 <memcpy+0x2c>
 330:	fff6079b          	addw	a5,a2,-1
 334:	1782                	sll	a5,a5,0x20
 336:	9381                	srl	a5,a5,0x20
 338:	fff7c793          	not	a5,a5
 33c:	97ae                	add	a5,a5,a1
      *--dst = *--src;
 33e:	fff5c683          	lbu	a3,-1(a1)
 342:	15fd                	add	a1,a1,-1
 344:	177d                	add	a4,a4,-1
 346:	00d70023          	sb	a3,0(a4)
    while(n-- > 0)
 34a:	fef59ae3          	bne	a1,a5,33e <memcpy+0x4a>
}
 34e:	6422                	ld	s0,8(sp)
 350:	0141                	add	sp,sp,16
 352:	8082                	ret

0000000000000354 <fork>:
# generated by usys.pl - do not edit
#include "kern/syscall.h"
.global fork
fork:
 li a7, SYS_fork
 354:	4885                	li	a7,1
 ecall
 356:	00000073          	ecall
 ret
 35a:	8082                	ret

000000000000035c <exit>:
.global exit
exit:
 li a7, SYS_exit
 35c:	4889                	li	a7,2
 ecall
 35e:	00000073          	ecall
 ret
 362:	8082                	ret

0000000000000364 <wait>:
.global wait
wait:
 li a7, SYS_wait
 364:	488d                	li	a7,3
 ecall
 366:	00000073          	ecall
 ret
 36a:	8082                	ret

000000000000036c <pipe>:
.global pipe
pipe:
 li a7, SYS_pipe
 36c:	4891                	li	a7,4
 ecall
 36e:	00000073          	ecall
 ret
 372:	8082                	ret

0000000000000374 <read>:
.global read
read:
 li a7, SYS_read
 374:	4895                	li	a7,5
 ecall
 376:	00000073          	ecall
 ret
 37a:	8082                	ret

000000000000037c <write>:
.global write
write:
 li a7, SYS_write
 37c:	48c1                	li	a7,16
 ecall
 37e:	00000073          	ecall
 ret
 382:	8082                	ret

0000000000000384 <close>:
.global close
close:
 li a7, SYS_close
 384:	48d5                	li	a7,21
 ecall
 386:	00000073          	ecall
 ret
 38a:	8082                	ret

000000000000038c <kill>:
.global kill
kill:
 li a7, SYS_kill
 38c:	4899                	li	a7,6
 ecall
 38e:	00000073          	ecall
 ret
 392:	8082                	ret

0000000000000394 <exec>:
.global exec
exec:
 li a7, SYS_exec
 394:	489d                	li	a7,7
 ecall
 396:	00000073          	ecall
 ret
 39a:	8082                	ret

000000000000039c <open>:
.global open
open:
 li a7, SYS_open
 39c:	48bd                	li	a7,15
 ecall
 39e:	00000073          	ecall
 ret
 3a2:	8082                	ret

00000000000003a4 <mknod>:
.global mknod
mknod:
 li a7, SYS_mknod
 3a4:	48c5                	li	a7,17
 ecall
 3a6:	00000073          	ecall
 ret
 3aa:	8082                	ret

00000000000003ac <unlink>:
.global unlink
unlink:
 li a7, SYS_unlink
 3ac:	48c9                	li	a7,18
 ecall
 3ae:	00000073          	ecall
 ret
 3b2:	8082                	ret

00000000000003b4 <fstat>:
.global fstat
fstat:
 li a7, SYS_fstat
 3b4:	48a1                	li	a7,8
 ecall
 3b6:	00000073          	ecall
 ret
 3ba:	8082                	ret

00000000000003bc <link>:
.global link
link:
 li a7, SYS_link
 3bc:	48cd                	li	a7,19
 ecall
 3be:	00000073          	ecall
 ret
 3c2:	8082                	ret

00000000000003c4 <mkdir>:
.global mkdir
mkdir:
 li a7, SYS_mkdir
 3c4:	48d1                	li	a7,20
 ecall
 3c6:	00000073          	ecall
 ret
 3ca:	8082                	ret

00000000000003cc <chdir>:
.global chdir
chdir:
 li a7, SYS_chdir
 3cc:	48a5                	li	a7,9
 ecall
 3ce:	00000073          	ecall
 ret
 3d2:	8082                	ret

00000000000003d4 <dup>:
.global dup
dup:
 li a7, SYS_dup
 3d4:	48a9                	li	a7,10
 ecall
 3d6:	00000073          	ecall
 ret
 3da:	8082                	ret

00000000000003dc <getpid>:
.global getpid
getpid:
 li a7, SYS_getpid
 3dc:	48ad                	li	a7,11
 ecall
 3de:	00000073          	ecall
 ret
 3e2:	8082                	ret

00000000000003e4 <sbrk>:
.global sbrk
sbrk:
 li a7, SYS_sbrk
 3e4:	48b1                	li	a7,12
 ecall
 3e6:	00000073          	ecall
 ret
 3ea:	8082                	ret

00000000000003ec <sleep>:
.global sleep
sleep:
 li a7, SYS_sleep
 3ec:	48b5                	li	a7,13
 ecall
 3ee:	00000073          	ecall
 ret
 3f2:	8082                	ret

00000000000003f4 <uptime>:
.global uptime
uptime:
 li a7, SYS_uptime
 3f4:	48b9                	li	a7,14
 ecall
 3f6:	00000073          	ecall
 ret
 3fa:	8082                	ret

00000000000003fc <poweroff>:
.global poweroff
poweroff:
 li a7, SYS_poweroff
 3fc:	48d9                	li	a7,22
 ecall
 3fe:	00000073          	ecall
 ret
 402:	8082                	ret

0000000000000404 <printint>:
  write(fd, &c, 1);
}

static void
printint(int fd, int xx, int base, int sgn)
{
 404:	715d                	add	sp,sp,-80
 406:	e0a2                	sd	s0,64(sp)
 408:	f84a                	sd	s2,48(sp)
 40a:	e486                	sd	ra,72(sp)
 40c:	fc26                	sd	s1,56(sp)
 40e:	f44e                	sd	s3,40(sp)
 410:	0880                	add	s0,sp,80
 412:	892a                	mv	s2,a0
  char buf[16];
  int i, neg;
  uint x;

  neg = 0;
  if(sgn && xx < 0){
 414:	c299                	beqz	a3,41a <printint+0x16>
 416:	0805c263          	bltz	a1,49a <printint+0x96>
    neg = 1;
    x = -xx;
  } else {
    x = xx;
 41a:	2581                	sext.w	a1,a1
  neg = 0;
 41c:	4681                	li	a3,0
  }

  i = 0;
  do{
    buf[i++] = digits[x % base];
 41e:	2601                	sext.w	a2,a2
 420:	fc040713          	add	a4,s0,-64
  i = 0;
 424:	4501                	li	a0,0
 426:	00000897          	auipc	a7,0x0
 42a:	4d288893          	add	a7,a7,1234 # 8f8 <digits>
    buf[i++] = digits[x % base];
 42e:	02c5f7bb          	remuw	a5,a1,a2
  }while((x /= base) != 0);
 432:	0705                	add	a4,a4,1
 434:	0005881b          	sext.w	a6,a1
 438:	84aa                	mv	s1,a0
    buf[i++] = digits[x % base];
 43a:	2505                	addw	a0,a0,1
 43c:	1782                	sll	a5,a5,0x20
 43e:	9381                	srl	a5,a5,0x20
 440:	97c6                	add	a5,a5,a7
 442:	0007c783          	lbu	a5,0(a5)
  }while((x /= base) != 0);
 446:	02c5d5bb          	divuw	a1,a1,a2
    buf[i++] = digits[x % base];
 44a:	fef70fa3          	sb	a5,-1(a4)
  }while((x /= base) != 0);
 44e:	fec870e3          	bgeu	a6,a2,42e <printint+0x2a>
  if(neg)
 452:	ca89                	beqz	a3,464 <printint+0x60>
    buf[i++] = '-';
 454:	fd050793          	add	a5,a0,-48
 458:	97a2                	add	a5,a5,s0
 45a:	02d00713          	li	a4,45
 45e:	fee78823          	sb	a4,-16(a5)

  while(--i >= 0)
 462:	84aa                	mv	s1,a0
 464:	fc040793          	add	a5,s0,-64
 468:	94be                	add	s1,s1,a5
 46a:	fff78993          	add	s3,a5,-1
    putc(fd, buf[i]);
 46e:	0004c783          	lbu	a5,0(s1)
  write(fd, &c, 1);
 472:	4605                	li	a2,1
 474:	fbf40593          	add	a1,s0,-65
 478:	854a                	mv	a0,s2
  while(--i >= 0)
 47a:	14fd                	add	s1,s1,-1
 47c:	faf40fa3          	sb	a5,-65(s0)
  write(fd, &c, 1);
 480:	00000097          	auipc	ra,0x0
 484:	efc080e7          	jalr	-260(ra) # 37c <write>
  while(--i >= 0)
 488:	ff3493e3          	bne	s1,s3,46e <printint+0x6a>
}
 48c:	60a6                	ld	ra,72(sp)
 48e:	6406                	ld	s0,64(sp)
 490:	74e2                	ld	s1,56(sp)
 492:	7942                	ld	s2,48(sp)
 494:	79a2                	ld	s3,40(sp)
 496:	6161                	add	sp,sp,80
 498:	8082                	ret
    x = -xx;
 49a:	40b005bb          	negw	a1,a1
 49e:	b741                	j	41e <printint+0x1a>

00000000000004a0 <vprintf>:
}

// Print to the given fd. Only understands %d, %x, %p, %s.
void
vprintf(int fd, const char *fmt, va_list ap)
{
 4a0:	7159                	add	sp,sp,-112
 4a2:	f0a2                	sd	s0,96(sp)
 4a4:	f486                	sd	ra,104(sp)
 4a6:	e8ca                	sd	s2,80(sp)
 4a8:	1880                	add	s0,sp,112
  char *s;
  int c, i, state;

  state = 0;
  for(i = 0; fmt[i]; i++){
 4aa:	0005c903          	lbu	s2,0(a1)
 4ae:	04090f63          	beqz	s2,50c <vprintf+0x6c>
 4b2:	eca6                	sd	s1,88(sp)
 4b4:	e4ce                	sd	s3,72(sp)
 4b6:	e0d2                	sd	s4,64(sp)
 4b8:	fc56                	sd	s5,56(sp)
 4ba:	f85a                	sd	s6,48(sp)
 4bc:	f45e                	sd	s7,40(sp)
 4be:	f062                	sd	s8,32(sp)
 4c0:	8a2a                	mv	s4,a0
 4c2:	8c32                	mv	s8,a2
 4c4:	00158493          	add	s1,a1,1
 4c8:	4981                	li	s3,0
      if(c == '%'){
        state = '%';
      } else {
        putc(fd, c);
      }
    } else if(state == '%'){
 4ca:	02500a93          	li	s5,37
 4ce:	4bd5                	li	s7,21
 4d0:	00000b17          	auipc	s6,0x0
 4d4:	3d0b0b13          	add	s6,s6,976 # 8a0 <malloc+0x11a>
    if(state == 0){
 4d8:	02099f63          	bnez	s3,516 <vprintf+0x76>
      if(c == '%'){
 4dc:	05590c63          	beq	s2,s5,534 <vprintf+0x94>
  write(fd, &c, 1);
 4e0:	4605                	li	a2,1
 4e2:	f9f40593          	add	a1,s0,-97
 4e6:	8552                	mv	a0,s4
 4e8:	f9240fa3          	sb	s2,-97(s0)
 4ec:	00000097          	auipc	ra,0x0
 4f0:	e90080e7          	jalr	-368(ra) # 37c <write>
  for(i = 0; fmt[i]; i++){
 4f4:	0004c903          	lbu	s2,0(s1)
 4f8:	0485                	add	s1,s1,1
 4fa:	fc091fe3          	bnez	s2,4d8 <vprintf+0x38>
 4fe:	64e6                	ld	s1,88(sp)
 500:	69a6                	ld	s3,72(sp)
 502:	6a06                	ld	s4,64(sp)
 504:	7ae2                	ld	s5,56(sp)
 506:	7b42                	ld	s6,48(sp)
 508:	7ba2                	ld	s7,40(sp)
 50a:	7c02                	ld	s8,32(sp)
        putc(fd, c);
      }
      state = 0;
    }
  }
}
 50c:	70a6                	ld	ra,104(sp)
 50e:	7406                	ld	s0,96(sp)
 510:	6946                	ld	s2,80(sp)
 512:	6165                	add	sp,sp,112
 514:	8082                	ret
    } else if(state == '%'){
 516:	fd599fe3          	bne	s3,s5,4f4 <vprintf+0x54>
      if(c == 'd'){
 51a:	15590463          	beq	s2,s5,662 <vprintf+0x1c2>
 51e:	f9d9079b          	addw	a5,s2,-99
 522:	0ff7f793          	zext.b	a5,a5
 526:	00fbea63          	bltu	s7,a5,53a <vprintf+0x9a>
 52a:	078a                	sll	a5,a5,0x2
 52c:	97da                	add	a5,a5,s6
 52e:	439c                	lw	a5,0(a5)
 530:	97da                	add	a5,a5,s6
 532:	8782                	jr	a5
        state = '%';
 534:	02500993          	li	s3,37
 538:	bf75                	j	4f4 <vprintf+0x54>
  write(fd, &c, 1);
 53a:	f9f40993          	add	s3,s0,-97
 53e:	4605                	li	a2,1
 540:	85ce                	mv	a1,s3
 542:	02500793          	li	a5,37
 546:	8552                	mv	a0,s4
 548:	f8f40fa3          	sb	a5,-97(s0)
 54c:	00000097          	auipc	ra,0x0
 550:	e30080e7          	jalr	-464(ra) # 37c <write>
 554:	4605                	li	a2,1
 556:	85ce                	mv	a1,s3
 558:	8552                	mv	a0,s4
 55a:	f9240fa3          	sb	s2,-97(s0)
 55e:	00000097          	auipc	ra,0x0
 562:	e1e080e7          	jalr	-482(ra) # 37c <write>
        while(*s != 0){
 566:	4981                	li	s3,0
 568:	b771                	j	4f4 <vprintf+0x54>
        putc(fd, va_arg(ap, uint));
 56a:	000c2783          	lw	a5,0(s8)
  write(fd, &c, 1);
 56e:	4605                	li	a2,1
 570:	f9f40593          	add	a1,s0,-97
 574:	8552                	mv	a0,s4
        putc(fd, va_arg(ap, uint));
 576:	f8f40fa3          	sb	a5,-97(s0)
 57a:	0c21                	add	s8,s8,8
  write(fd, &c, 1);
 57c:	00000097          	auipc	ra,0x0
 580:	e00080e7          	jalr	-512(ra) # 37c <write>
 584:	4981                	li	s3,0
 586:	b7bd                	j	4f4 <vprintf+0x54>
        printint(fd, va_arg(ap, int), 10, 1);
 588:	000c2583          	lw	a1,0(s8)
 58c:	4685                	li	a3,1
        printint(fd, va_arg(ap, uint64), 10, 0);
 58e:	4629                	li	a2,10
 590:	8552                	mv	a0,s4
 592:	0c21                	add	s8,s8,8
 594:	00000097          	auipc	ra,0x0
 598:	e70080e7          	jalr	-400(ra) # 404 <printint>
 59c:	4981                	li	s3,0
 59e:	bf99                	j	4f4 <vprintf+0x54>
 5a0:	000c2583          	lw	a1,0(s8)
 5a4:	4681                	li	a3,0
 5a6:	b7e5                	j	58e <vprintf+0xee>
  write(fd, &c, 1);
 5a8:	f9f40993          	add	s3,s0,-97
 5ac:	03000793          	li	a5,48
 5b0:	4605                	li	a2,1
 5b2:	85ce                	mv	a1,s3
 5b4:	8552                	mv	a0,s4
 5b6:	ec66                	sd	s9,24(sp)
 5b8:	e86a                	sd	s10,16(sp)
        printptr(fd, va_arg(ap, uint64));
 5ba:	f8f40fa3          	sb	a5,-97(s0)
 5be:	000c3d03          	ld	s10,0(s8)
  write(fd, &c, 1);
 5c2:	00000097          	auipc	ra,0x0
 5c6:	dba080e7          	jalr	-582(ra) # 37c <write>
 5ca:	07800793          	li	a5,120
 5ce:	4605                	li	a2,1
 5d0:	85ce                	mv	a1,s3
 5d2:	8552                	mv	a0,s4
 5d4:	f8f40fa3          	sb	a5,-97(s0)
        printptr(fd, va_arg(ap, uint64));
 5d8:	0c21                	add	s8,s8,8
  write(fd, &c, 1);
 5da:	00000097          	auipc	ra,0x0
 5de:	da2080e7          	jalr	-606(ra) # 37c <write>
  putc(fd, 'x');
 5e2:	4941                	li	s2,16
 5e4:	00000c97          	auipc	s9,0x0
 5e8:	314c8c93          	add	s9,s9,788 # 8f8 <digits>
    putc(fd, digits[x >> (sizeof(uint64) * 8 - 4)]);
 5ec:	03cd5793          	srl	a5,s10,0x3c
 5f0:	97e6                	add	a5,a5,s9
 5f2:	0007c783          	lbu	a5,0(a5)
  write(fd, &c, 1);
 5f6:	4605                	li	a2,1
 5f8:	85ce                	mv	a1,s3
 5fa:	8552                	mv	a0,s4
  for (i = 0; i < (sizeof(uint64) * 2); i++, x <<= 4)
 5fc:	397d                	addw	s2,s2,-1
 5fe:	f8f40fa3          	sb	a5,-97(s0)
 602:	0d12                	sll	s10,s10,0x4
  write(fd, &c, 1);
 604:	00000097          	auipc	ra,0x0
 608:	d78080e7          	jalr	-648(ra) # 37c <write>
  for (i = 0; i < (sizeof(uint64) * 2); i++, x <<= 4)
 60c:	fe0910e3          	bnez	s2,5ec <vprintf+0x14c>
 610:	6ce2                	ld	s9,24(sp)
 612:	6d42                	ld	s10,16(sp)
 614:	4981                	li	s3,0
 616:	bdf9                	j	4f4 <vprintf+0x54>
        s = va_arg(ap, char*);
 618:	000c3903          	ld	s2,0(s8)
 61c:	0c21                	add	s8,s8,8
        if(s == 0)
 61e:	04090e63          	beqz	s2,67a <vprintf+0x1da>
        while(*s != 0){
 622:	00094783          	lbu	a5,0(s2)
 626:	d3a1                	beqz	a5,566 <vprintf+0xc6>
 628:	f9f40993          	add	s3,s0,-97
  write(fd, &c, 1);
 62c:	4605                	li	a2,1
 62e:	85ce                	mv	a1,s3
 630:	8552                	mv	a0,s4
 632:	f8f40fa3          	sb	a5,-97(s0)
 636:	00000097          	auipc	ra,0x0
 63a:	d46080e7          	jalr	-698(ra) # 37c <write>
        while(*s != 0){
 63e:	00194783          	lbu	a5,1(s2)
          s++;
 642:	0905                	add	s2,s2,1
        while(*s != 0){
 644:	f7e5                	bnez	a5,62c <vprintf+0x18c>
 646:	4981                	li	s3,0
 648:	b575                	j	4f4 <vprintf+0x54>
        printint(fd, va_arg(ap, int), 16, 0);
 64a:	000c2583          	lw	a1,0(s8)
 64e:	4681                	li	a3,0
 650:	4641                	li	a2,16
 652:	8552                	mv	a0,s4
 654:	0c21                	add	s8,s8,8
 656:	00000097          	auipc	ra,0x0
 65a:	dae080e7          	jalr	-594(ra) # 404 <printint>
 65e:	4981                	li	s3,0
 660:	bd51                	j	4f4 <vprintf+0x54>
  write(fd, &c, 1);
 662:	4605                	li	a2,1
 664:	f9f40593          	add	a1,s0,-97
 668:	8552                	mv	a0,s4
 66a:	f9540fa3          	sb	s5,-97(s0)
        while(*s != 0){
 66e:	4981                	li	s3,0
  write(fd, &c, 1);
 670:	00000097          	auipc	ra,0x0
 674:	d0c080e7          	jalr	-756(ra) # 37c <write>
 678:	bdb5                	j	4f4 <vprintf+0x54>
          s = "(null)";
 67a:	00000917          	auipc	s2,0x0
 67e:	21e90913          	add	s2,s2,542 # 898 <malloc+0x112>
 682:	02800793          	li	a5,40
 686:	b74d                	j	628 <vprintf+0x188>

0000000000000688 <fprintf>:

void
fprintf(int fd, const char *fmt, ...)
{
 688:	715d                	add	sp,sp,-80
 68a:	e822                	sd	s0,16(sp)
 68c:	ec06                	sd	ra,24(sp)
 68e:	1000                	add	s0,sp,32
 690:	e010                	sd	a2,0(s0)
  va_list ap;

  va_start(ap, fmt);
  vprintf(fd, fmt, ap);
 692:	8622                	mv	a2,s0
{
 694:	e414                	sd	a3,8(s0)
 696:	e818                	sd	a4,16(s0)
 698:	ec1c                	sd	a5,24(s0)
 69a:	03043023          	sd	a6,32(s0)
 69e:	03143423          	sd	a7,40(s0)
  va_start(ap, fmt);
 6a2:	fe843423          	sd	s0,-24(s0)
  vprintf(fd, fmt, ap);
 6a6:	00000097          	auipc	ra,0x0
 6aa:	dfa080e7          	jalr	-518(ra) # 4a0 <vprintf>
}
 6ae:	60e2                	ld	ra,24(sp)
 6b0:	6442                	ld	s0,16(sp)
 6b2:	6161                	add	sp,sp,80
 6b4:	8082                	ret

00000000000006b6 <printf>:

void
printf(const char *fmt, ...)
{
 6b6:	711d                	add	sp,sp,-96
 6b8:	e822                	sd	s0,16(sp)
 6ba:	ec06                	sd	ra,24(sp)
 6bc:	1000                	add	s0,sp,32
  va_list ap;

  va_start(ap, fmt);
 6be:	00840313          	add	t1,s0,8
{
 6c2:	e40c                	sd	a1,8(s0)
 6c4:	e810                	sd	a2,16(s0)
  vprintf(1, fmt, ap);
 6c6:	85aa                	mv	a1,a0
 6c8:	861a                	mv	a2,t1
 6ca:	4505                	li	a0,1
{
 6cc:	ec14                	sd	a3,24(s0)
 6ce:	f018                	sd	a4,32(s0)
 6d0:	f41c                	sd	a5,40(s0)
 6d2:	03043823          	sd	a6,48(s0)
 6d6:	03143c23          	sd	a7,56(s0)
  va_start(ap, fmt);
 6da:	fe643423          	sd	t1,-24(s0)
  vprintf(1, fmt, ap);
 6de:	00000097          	auipc	ra,0x0
 6e2:	dc2080e7          	jalr	-574(ra) # 4a0 <vprintf>
}
 6e6:	60e2                	ld	ra,24(sp)
 6e8:	6442                	ld	s0,16(sp)
 6ea:	6125                	add	sp,sp,96
 6ec:	8082                	ret

00000000000006ee <free>:
static Header base;
static Header *freep;

void
free(void *ap)
{
 6ee:	1141                	add	sp,sp,-16
 6f0:	e422                	sd	s0,8(sp)
 6f2:	0800                	add	s0,sp,16
  Header *bp, *p;

  bp = (Header*)ap - 1;
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 6f4:	00001597          	auipc	a1,0x1
 6f8:	90c58593          	add	a1,a1,-1780 # 1000 <freep>
 6fc:	619c                	ld	a5,0(a1)
  bp = (Header*)ap - 1;
 6fe:	ff050693          	add	a3,a0,-16
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 702:	6398                	ld	a4,0(a5)
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 704:	02d7ff63          	bgeu	a5,a3,742 <free+0x54>
 708:	00e6e463          	bltu	a3,a4,710 <free+0x22>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 70c:	02e7ef63          	bltu	a5,a4,74a <free+0x5c>
      break;
  if(bp + bp->s.size == p->s.ptr){
 710:	ff852803          	lw	a6,-8(a0)
 714:	02081893          	sll	a7,a6,0x20
 718:	01c8d613          	srl	a2,a7,0x1c
 71c:	9636                	add	a2,a2,a3
 71e:	02c70863          	beq	a4,a2,74e <free+0x60>
    bp->s.size += p->s.ptr->s.size;
    bp->s.ptr = p->s.ptr->s.ptr;
  } else
    bp->s.ptr = p->s.ptr;
  if(p + p->s.size == bp){
 722:	0087a803          	lw	a6,8(a5)
 726:	fee53823          	sd	a4,-16(a0)
 72a:	02081893          	sll	a7,a6,0x20
 72e:	01c8d613          	srl	a2,a7,0x1c
 732:	963e                	add	a2,a2,a5
 734:	02c68e63          	beq	a3,a2,770 <free+0x82>
    p->s.size += bp->s.size;
    p->s.ptr = bp->s.ptr;
  } else
    p->s.ptr = bp;
  freep = p;
}
 738:	6422                	ld	s0,8(sp)
 73a:	e394                	sd	a3,0(a5)
  freep = p;
 73c:	e19c                	sd	a5,0(a1)
}
 73e:	0141                	add	sp,sp,16
 740:	8082                	ret
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 742:	00e7e463          	bltu	a5,a4,74a <free+0x5c>
 746:	fce6e5e3          	bltu	a3,a4,710 <free+0x22>
{
 74a:	87ba                	mv	a5,a4
 74c:	bf5d                	j	702 <free+0x14>
    bp->s.size += p->s.ptr->s.size;
 74e:	4710                	lw	a2,8(a4)
    bp->s.ptr = p->s.ptr->s.ptr;
 750:	6318                	ld	a4,0(a4)
    bp->s.size += p->s.ptr->s.size;
 752:	0106063b          	addw	a2,a2,a6
 756:	fec52c23          	sw	a2,-8(a0)
  if(p + p->s.size == bp){
 75a:	0087a803          	lw	a6,8(a5)
 75e:	fee53823          	sd	a4,-16(a0)
 762:	02081893          	sll	a7,a6,0x20
 766:	01c8d613          	srl	a2,a7,0x1c
 76a:	963e                	add	a2,a2,a5
 76c:	fcc696e3          	bne	a3,a2,738 <free+0x4a>
    p->s.size += bp->s.size;
 770:	ff852603          	lw	a2,-8(a0)
}
 774:	6422                	ld	s0,8(sp)
    p->s.ptr = bp->s.ptr;
 776:	86ba                	mv	a3,a4
    p->s.size += bp->s.size;
 778:	0106073b          	addw	a4,a2,a6
 77c:	c798                	sw	a4,8(a5)
    p->s.ptr = bp->s.ptr;
 77e:	e394                	sd	a3,0(a5)
  freep = p;
 780:	e19c                	sd	a5,0(a1)
}
 782:	0141                	add	sp,sp,16
 784:	8082                	ret

0000000000000786 <malloc>:
  return freep;
}

void*
malloc(uint nbytes)
{
 786:	7139                	add	sp,sp,-64
 788:	f822                	sd	s0,48(sp)
 78a:	f426                	sd	s1,40(sp)
 78c:	f04a                	sd	s2,32(sp)
 78e:	ec4e                	sd	s3,24(sp)
 790:	fc06                	sd	ra,56(sp)
 792:	0080                	add	s0,sp,64
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
  if((prevp = freep) == 0){
 794:	00001917          	auipc	s2,0x1
 798:	86c90913          	add	s2,s2,-1940 # 1000 <freep>
  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
 79c:	02051493          	sll	s1,a0,0x20
 7a0:	9081                	srl	s1,s1,0x20
  if((prevp = freep) == 0){
 7a2:	00093783          	ld	a5,0(s2)
  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
 7a6:	04bd                	add	s1,s1,15
 7a8:	8091                	srl	s1,s1,0x4
 7aa:	0014899b          	addw	s3,s1,1
 7ae:	0485                	add	s1,s1,1
  if((prevp = freep) == 0){
 7b0:	c3dd                	beqz	a5,856 <malloc+0xd0>
    base.s.ptr = freep = prevp = &base;
    base.s.size = 0;
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 7b2:	6388                	ld	a0,0(a5)
    if(p->s.size >= nunits){
 7b4:	4518                	lw	a4,8(a0)
 7b6:	06977863          	bgeu	a4,s1,826 <malloc+0xa0>
 7ba:	e852                	sd	s4,16(sp)
 7bc:	e456                	sd	s5,8(sp)
 7be:	e05a                	sd	s6,0(sp)
  if(nu < 4096)
 7c0:	6785                	lui	a5,0x1
 7c2:	8a4e                	mv	s4,s3
 7c4:	08f4e763          	bltu	s1,a5,852 <malloc+0xcc>
 7c8:	000a0b1b          	sext.w	s6,s4
  if(p == (char*)-1)
 7cc:	5afd                	li	s5,-1
  p = sbrk(nu * sizeof(Header));
 7ce:	004a1a1b          	sllw	s4,s4,0x4
 7d2:	a029                	j	7dc <malloc+0x56>
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 7d4:	6388                	ld	a0,0(a5)
    if(p->s.size >= nunits){
 7d6:	4518                	lw	a4,8(a0)
 7d8:	04977463          	bgeu	a4,s1,820 <malloc+0x9a>
        p->s.size = nunits;
      }
      freep = prevp;
      return (void*)(p + 1);
    }
    if(p == freep)
 7dc:	00093703          	ld	a4,0(s2)
 7e0:	87aa                	mv	a5,a0
 7e2:	fee519e3          	bne	a0,a4,7d4 <malloc+0x4e>
  p = sbrk(nu * sizeof(Header));
 7e6:	8552                	mv	a0,s4
 7e8:	00000097          	auipc	ra,0x0
 7ec:	bfc080e7          	jalr	-1028(ra) # 3e4 <sbrk>
 7f0:	87aa                	mv	a5,a0
  free((void*)(hp + 1));
 7f2:	0541                	add	a0,a0,16
  if(p == (char*)-1)
 7f4:	01578b63          	beq	a5,s5,80a <malloc+0x84>
  hp->s.size = nu;
 7f8:	0167a423          	sw	s6,8(a5) # 1008 <freep+0x8>
  free((void*)(hp + 1));
 7fc:	00000097          	auipc	ra,0x0
 800:	ef2080e7          	jalr	-270(ra) # 6ee <free>
  return freep;
 804:	00093783          	ld	a5,0(s2)
      if((p = morecore(nunits)) == 0)
 808:	f7f1                	bnez	a5,7d4 <malloc+0x4e>
        return 0;
  }
}
 80a:	70e2                	ld	ra,56(sp)
 80c:	7442                	ld	s0,48(sp)
        return 0;
 80e:	6a42                	ld	s4,16(sp)
 810:	6aa2                	ld	s5,8(sp)
 812:	6b02                	ld	s6,0(sp)
}
 814:	74a2                	ld	s1,40(sp)
 816:	7902                	ld	s2,32(sp)
 818:	69e2                	ld	s3,24(sp)
        return 0;
 81a:	4501                	li	a0,0
}
 81c:	6121                	add	sp,sp,64
 81e:	8082                	ret
 820:	6a42                	ld	s4,16(sp)
 822:	6aa2                	ld	s5,8(sp)
 824:	6b02                	ld	s6,0(sp)
      if(p->s.size == nunits)
 826:	04e48763          	beq	s1,a4,874 <malloc+0xee>
        p->s.size -= nunits;
 82a:	4137073b          	subw	a4,a4,s3
        p += p->s.size;
 82e:	02071613          	sll	a2,a4,0x20
 832:	01c65693          	srl	a3,a2,0x1c
        p->s.size -= nunits;
 836:	c518                	sw	a4,8(a0)
        p += p->s.size;
 838:	9536                	add	a0,a0,a3
        p->s.size = nunits;
 83a:	01352423          	sw	s3,8(a0)
}
 83e:	70e2                	ld	ra,56(sp)
 840:	7442                	ld	s0,48(sp)
      freep = prevp;
 842:	00f93023          	sd	a5,0(s2)
}
 846:	74a2                	ld	s1,40(sp)
 848:	7902                	ld	s2,32(sp)
 84a:	69e2                	ld	s3,24(sp)
      return (void*)(p + 1);
 84c:	0541                	add	a0,a0,16
}
 84e:	6121                	add	sp,sp,64
 850:	8082                	ret
  if(nu < 4096)
 852:	6a05                	lui	s4,0x1
 854:	bf95                	j	7c8 <malloc+0x42>
 856:	e852                	sd	s4,16(sp)
 858:	e456                	sd	s5,8(sp)
 85a:	e05a                	sd	s6,0(sp)
    base.s.ptr = freep = prevp = &base;
 85c:	00000517          	auipc	a0,0x0
 860:	7b450513          	add	a0,a0,1972 # 1010 <base>
 864:	00a93023          	sd	a0,0(s2)
 868:	e108                	sd	a0,0(a0)
    base.s.size = 0;
 86a:	00000797          	auipc	a5,0x0
 86e:	7a07a723          	sw	zero,1966(a5) # 1018 <base+0x8>
    if(p->s.size >= nunits){
 872:	b7b9                	j	7c0 <malloc+0x3a>
        prevp->s.ptr = p->s.ptr;
 874:	6118                	ld	a4,0(a0)
 876:	e398                	sd	a4,0(a5)
 878:	b7d9                	j	83e <malloc+0xb8>
