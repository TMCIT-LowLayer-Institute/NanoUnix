
user/_zombie:     file format elf64-littleriscv


Disassembly of section .text:

0000000000000000 <main>:
#include "kern/stat.h"
#include "user/user.h"

int
main(void)
{
   0:	1141                	add	sp,sp,-16
   2:	e022                	sd	s0,0(sp)
   4:	e406                	sd	ra,8(sp)
   6:	0800                	add	s0,sp,16
  if(fork() > 0)
   8:	00000097          	auipc	ra,0x0
   c:	30e080e7          	jalr	782(ra) # 316 <fork>
  10:	00a05763          	blez	a0,1e <main+0x1e>
    sleep(5);  // Let child exit before parent.
  14:	4515                	li	a0,5
  16:	00000097          	auipc	ra,0x0
  1a:	398080e7          	jalr	920(ra) # 3ae <sleep>
  exit(0);
  1e:	4501                	li	a0,0
  20:	00000097          	auipc	ra,0x0
  24:	2fe080e7          	jalr	766(ra) # 31e <exit>

0000000000000028 <_main>:
//
// wrapper so that it's OK if main() does not call exit().
//
void
_main()
{
  28:	1141                	add	sp,sp,-16
  2a:	e022                	sd	s0,0(sp)
  2c:	e406                	sd	ra,8(sp)
  2e:	0800                	add	s0,sp,16
  extern int main();
  main();
  30:	00000097          	auipc	ra,0x0
  34:	fd0080e7          	jalr	-48(ra) # 0 <main>
  exit(0);
  38:	4501                	li	a0,0
  3a:	00000097          	auipc	ra,0x0
  3e:	2e4080e7          	jalr	740(ra) # 31e <exit>

0000000000000042 <strcpy>:
}

char*
strcpy(char *s, const char *t)
{
  42:	1141                	add	sp,sp,-16
  44:	e422                	sd	s0,8(sp)
  46:	0800                	add	s0,sp,16
  char *os;

  os = s;
  while((*s++ = *t++) != 0)
  48:	87aa                	mv	a5,a0
  4a:	0005c703          	lbu	a4,0(a1)
  4e:	0785                	add	a5,a5,1
  50:	0585                	add	a1,a1,1
  52:	fee78fa3          	sb	a4,-1(a5)
  56:	fb75                	bnez	a4,4a <strcpy+0x8>
    ;
  return os;
}
  58:	6422                	ld	s0,8(sp)
  5a:	0141                	add	sp,sp,16
  5c:	8082                	ret

000000000000005e <strcmp>:

int
strcmp(const char *p, const char *q)
{
  5e:	1141                	add	sp,sp,-16
  60:	e422                	sd	s0,8(sp)
  62:	0800                	add	s0,sp,16
  while(*p && *p == *q)
  64:	00054783          	lbu	a5,0(a0)
  68:	e791                	bnez	a5,74 <strcmp+0x16>
  6a:	a80d                	j	9c <strcmp+0x3e>
  6c:	00054783          	lbu	a5,0(a0)
  70:	cf99                	beqz	a5,8e <strcmp+0x30>
  72:	85b6                	mv	a1,a3
  74:	0005c703          	lbu	a4,0(a1)
    p++, q++;
  78:	0505                	add	a0,a0,1
  7a:	00158693          	add	a3,a1,1
  while(*p && *p == *q)
  7e:	fef707e3          	beq	a4,a5,6c <strcmp+0xe>
  return (uchar)*p - (uchar)*q;
  82:	0007851b          	sext.w	a0,a5
}
  86:	6422                	ld	s0,8(sp)
  88:	9d19                	subw	a0,a0,a4
  8a:	0141                	add	sp,sp,16
  8c:	8082                	ret
  return (uchar)*p - (uchar)*q;
  8e:	0015c703          	lbu	a4,1(a1)
}
  92:	6422                	ld	s0,8(sp)
  return (uchar)*p - (uchar)*q;
  94:	4501                	li	a0,0
}
  96:	9d19                	subw	a0,a0,a4
  98:	0141                	add	sp,sp,16
  9a:	8082                	ret
  return (uchar)*p - (uchar)*q;
  9c:	0005c703          	lbu	a4,0(a1)
  a0:	4501                	li	a0,0
  a2:	b7d5                	j	86 <strcmp+0x28>

00000000000000a4 <strlen>:

uint
strlen(const char *s)
{
  a4:	1141                	add	sp,sp,-16
  a6:	e422                	sd	s0,8(sp)
  a8:	0800                	add	s0,sp,16
  int n;

  for(n = 0; s[n]; n++)
  aa:	00054783          	lbu	a5,0(a0)
  ae:	cf91                	beqz	a5,ca <strlen+0x26>
  b0:	0505                	add	a0,a0,1
  b2:	87aa                	mv	a5,a0
  b4:	0007c703          	lbu	a4,0(a5)
  b8:	86be                	mv	a3,a5
  ba:	0785                	add	a5,a5,1
  bc:	ff65                	bnez	a4,b4 <strlen+0x10>
    ;
  return n;
}
  be:	6422                	ld	s0,8(sp)
  c0:	40a6853b          	subw	a0,a3,a0
  c4:	2505                	addw	a0,a0,1
  c6:	0141                	add	sp,sp,16
  c8:	8082                	ret
  ca:	6422                	ld	s0,8(sp)
  for(n = 0; s[n]; n++)
  cc:	4501                	li	a0,0
}
  ce:	0141                	add	sp,sp,16
  d0:	8082                	ret

00000000000000d2 <memset>:

void*
memset(void *dst, int c, uint n)
{
  d2:	1141                	add	sp,sp,-16
  d4:	e422                	sd	s0,8(sp)
  d6:	0800                	add	s0,sp,16
  char *cdst = (char *) dst;
  int i;
  for(i = 0; i < n; i++){
  d8:	ce09                	beqz	a2,f2 <memset+0x20>
  da:	1602                	sll	a2,a2,0x20
  dc:	9201                	srl	a2,a2,0x20
    cdst[i] = c;
  de:	0ff5f593          	zext.b	a1,a1
  e2:	87aa                	mv	a5,a0
  e4:	00a60733          	add	a4,a2,a0
  e8:	00b78023          	sb	a1,0(a5)
  for(i = 0; i < n; i++){
  ec:	0785                	add	a5,a5,1
  ee:	fee79de3          	bne	a5,a4,e8 <memset+0x16>
  }
  return dst;
}
  f2:	6422                	ld	s0,8(sp)
  f4:	0141                	add	sp,sp,16
  f6:	8082                	ret

00000000000000f8 <strchr>:

char*
strchr(const char *s, char c)
{
  f8:	1141                	add	sp,sp,-16
  fa:	e422                	sd	s0,8(sp)
  fc:	0800                	add	s0,sp,16
  for(; *s; s++)
  fe:	00054783          	lbu	a5,0(a0)
 102:	c799                	beqz	a5,110 <strchr+0x18>
    if(*s == c)
 104:	00f58763          	beq	a1,a5,112 <strchr+0x1a>
  for(; *s; s++)
 108:	00154783          	lbu	a5,1(a0)
 10c:	0505                	add	a0,a0,1
 10e:	fbfd                	bnez	a5,104 <strchr+0xc>
      return (char*)s;
  return 0;
 110:	4501                	li	a0,0
}
 112:	6422                	ld	s0,8(sp)
 114:	0141                	add	sp,sp,16
 116:	8082                	ret

0000000000000118 <gets>:

char*
gets(char *buf, int max)
{
 118:	711d                	add	sp,sp,-96
 11a:	e8a2                	sd	s0,80(sp)
 11c:	e4a6                	sd	s1,72(sp)
 11e:	e0ca                	sd	s2,64(sp)
 120:	fc4e                	sd	s3,56(sp)
 122:	f852                	sd	s4,48(sp)
 124:	f05a                	sd	s6,32(sp)
 126:	ec5e                	sd	s7,24(sp)
 128:	ec86                	sd	ra,88(sp)
 12a:	f456                	sd	s5,40(sp)
 12c:	1080                	add	s0,sp,96
 12e:	8baa                	mv	s7,a0
 130:	89ae                	mv	s3,a1
 132:	892a                	mv	s2,a0
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
 134:	4481                	li	s1,0
    cc = read(0, &c, 1);
    if(cc < 1)
      break;
    buf[i++] = c;
    if(c == '\n' || c == '\r')
 136:	4a29                	li	s4,10
 138:	4b35                	li	s6,13
  for(i=0; i+1 < max; ){
 13a:	a005                	j	15a <gets+0x42>
    cc = read(0, &c, 1);
 13c:	00000097          	auipc	ra,0x0
 140:	1fa080e7          	jalr	506(ra) # 336 <read>
    if(cc < 1)
 144:	02a05363          	blez	a0,16a <gets+0x52>
    buf[i++] = c;
 148:	faf44783          	lbu	a5,-81(s0)
    if(c == '\n' || c == '\r')
 14c:	0905                	add	s2,s2,1
    buf[i++] = c;
 14e:	fef90fa3          	sb	a5,-1(s2)
    if(c == '\n' || c == '\r')
 152:	01478d63          	beq	a5,s4,16c <gets+0x54>
 156:	01678b63          	beq	a5,s6,16c <gets+0x54>
  for(i=0; i+1 < max; ){
 15a:	8aa6                	mv	s5,s1
 15c:	2485                	addw	s1,s1,1
    cc = read(0, &c, 1);
 15e:	4605                	li	a2,1
 160:	faf40593          	add	a1,s0,-81
 164:	4501                	li	a0,0
  for(i=0; i+1 < max; ){
 166:	fd34cbe3          	blt	s1,s3,13c <gets+0x24>
 16a:	84d6                	mv	s1,s5
      break;
  }
  buf[i] = '\0';
 16c:	94de                	add	s1,s1,s7
 16e:	00048023          	sb	zero,0(s1)
  return buf;
}
 172:	60e6                	ld	ra,88(sp)
 174:	6446                	ld	s0,80(sp)
 176:	64a6                	ld	s1,72(sp)
 178:	6906                	ld	s2,64(sp)
 17a:	79e2                	ld	s3,56(sp)
 17c:	7a42                	ld	s4,48(sp)
 17e:	7aa2                	ld	s5,40(sp)
 180:	7b02                	ld	s6,32(sp)
 182:	855e                	mv	a0,s7
 184:	6be2                	ld	s7,24(sp)
 186:	6125                	add	sp,sp,96
 188:	8082                	ret

000000000000018a <stat>:

int
stat(const char *n, struct stat *st)
{
 18a:	1101                	add	sp,sp,-32
 18c:	e822                	sd	s0,16(sp)
 18e:	e04a                	sd	s2,0(sp)
 190:	ec06                	sd	ra,24(sp)
 192:	e426                	sd	s1,8(sp)
 194:	1000                	add	s0,sp,32
 196:	892e                	mv	s2,a1
  int fd;
  int r;

  fd = open(n, O_RDONLY);
 198:	4581                	li	a1,0
 19a:	00000097          	auipc	ra,0x0
 19e:	1c4080e7          	jalr	452(ra) # 35e <open>
  if(fd < 0)
 1a2:	02054663          	bltz	a0,1ce <stat+0x44>
    return -1;
  r = fstat(fd, st);
 1a6:	85ca                	mv	a1,s2
 1a8:	84aa                	mv	s1,a0
 1aa:	00000097          	auipc	ra,0x0
 1ae:	1cc080e7          	jalr	460(ra) # 376 <fstat>
 1b2:	87aa                	mv	a5,a0
  close(fd);
 1b4:	8526                	mv	a0,s1
  r = fstat(fd, st);
 1b6:	84be                	mv	s1,a5
  close(fd);
 1b8:	00000097          	auipc	ra,0x0
 1bc:	18e080e7          	jalr	398(ra) # 346 <close>
  return r;
}
 1c0:	60e2                	ld	ra,24(sp)
 1c2:	6442                	ld	s0,16(sp)
 1c4:	6902                	ld	s2,0(sp)
 1c6:	8526                	mv	a0,s1
 1c8:	64a2                	ld	s1,8(sp)
 1ca:	6105                	add	sp,sp,32
 1cc:	8082                	ret
    return -1;
 1ce:	54fd                	li	s1,-1
 1d0:	bfc5                	j	1c0 <stat+0x36>

00000000000001d2 <atoi>:

int
atoi(const char *s)
{
 1d2:	1141                	add	sp,sp,-16
 1d4:	e422                	sd	s0,8(sp)
 1d6:	0800                	add	s0,sp,16
  int n;

  n = 0;
  while('0' <= *s && *s <= '9')
 1d8:	00054683          	lbu	a3,0(a0)
 1dc:	4625                	li	a2,9
 1de:	fd06879b          	addw	a5,a3,-48
 1e2:	0ff7f793          	zext.b	a5,a5
 1e6:	02f66863          	bltu	a2,a5,216 <atoi+0x44>
 1ea:	872a                	mv	a4,a0
  n = 0;
 1ec:	4501                	li	a0,0
    n = n*10 + *s++ - '0';
 1ee:	0025179b          	sllw	a5,a0,0x2
 1f2:	9fa9                	addw	a5,a5,a0
 1f4:	0705                	add	a4,a4,1
 1f6:	0017979b          	sllw	a5,a5,0x1
 1fa:	9fb5                	addw	a5,a5,a3
  while('0' <= *s && *s <= '9')
 1fc:	00074683          	lbu	a3,0(a4)
    n = n*10 + *s++ - '0';
 200:	fd07851b          	addw	a0,a5,-48
  while('0' <= *s && *s <= '9')
 204:	fd06879b          	addw	a5,a3,-48
 208:	0ff7f793          	zext.b	a5,a5
 20c:	fef671e3          	bgeu	a2,a5,1ee <atoi+0x1c>
  return n;
}
 210:	6422                	ld	s0,8(sp)
 212:	0141                	add	sp,sp,16
 214:	8082                	ret
 216:	6422                	ld	s0,8(sp)
  n = 0;
 218:	4501                	li	a0,0
}
 21a:	0141                	add	sp,sp,16
 21c:	8082                	ret

000000000000021e <memmove>:

void*
memmove(void *vdst, const void *vsrc, int n)
{
 21e:	1141                	add	sp,sp,-16
 220:	e422                	sd	s0,8(sp)
 222:	0800                	add	s0,sp,16
  char *dst;
  const char *src;

  dst = vdst;
  src = vsrc;
  if (src > dst) {
 224:	02b57463          	bgeu	a0,a1,24c <memmove+0x2e>
    while(n-- > 0)
 228:	00c05f63          	blez	a2,246 <memmove+0x28>
 22c:	1602                	sll	a2,a2,0x20
 22e:	9201                	srl	a2,a2,0x20
 230:	00c507b3          	add	a5,a0,a2
  dst = vdst;
 234:	872a                	mv	a4,a0
      *dst++ = *src++;
 236:	0005c683          	lbu	a3,0(a1)
 23a:	0705                	add	a4,a4,1
 23c:	0585                	add	a1,a1,1
 23e:	fed70fa3          	sb	a3,-1(a4)
    while(n-- > 0)
 242:	fef71ae3          	bne	a4,a5,236 <memmove+0x18>
    src += n;
    while(n-- > 0)
      *--dst = *--src;
  }
  return vdst;
}
 246:	6422                	ld	s0,8(sp)
 248:	0141                	add	sp,sp,16
 24a:	8082                	ret
    dst += n;
 24c:	00c50733          	add	a4,a0,a2
    src += n;
 250:	95b2                	add	a1,a1,a2
    while(n-- > 0)
 252:	fec05ae3          	blez	a2,246 <memmove+0x28>
 256:	fff6079b          	addw	a5,a2,-1
 25a:	1782                	sll	a5,a5,0x20
 25c:	9381                	srl	a5,a5,0x20
 25e:	fff7c793          	not	a5,a5
 262:	97ae                	add	a5,a5,a1
      *--dst = *--src;
 264:	fff5c683          	lbu	a3,-1(a1)
 268:	15fd                	add	a1,a1,-1
 26a:	177d                	add	a4,a4,-1
 26c:	00d70023          	sb	a3,0(a4)
    while(n-- > 0)
 270:	feb79ae3          	bne	a5,a1,264 <memmove+0x46>
}
 274:	6422                	ld	s0,8(sp)
 276:	0141                	add	sp,sp,16
 278:	8082                	ret

000000000000027a <memcmp>:

int
memcmp(const void *s1, const void *s2, uint n)
{
 27a:	1141                	add	sp,sp,-16
 27c:	e422                	sd	s0,8(sp)
 27e:	0800                	add	s0,sp,16
  const char *p1 = s1, *p2 = s2;
  while (n-- > 0) {
 280:	c61d                	beqz	a2,2ae <memcmp+0x34>
 282:	fff6069b          	addw	a3,a2,-1
 286:	1682                	sll	a3,a3,0x20
 288:	9281                	srl	a3,a3,0x20
 28a:	0685                	add	a3,a3,1
 28c:	96aa                	add	a3,a3,a0
 28e:	a019                	j	294 <memcmp+0x1a>
 290:	00a68f63          	beq	a3,a0,2ae <memcmp+0x34>
    if (*p1 != *p2) {
 294:	00054783          	lbu	a5,0(a0)
 298:	0005c703          	lbu	a4,0(a1)
      return *p1 - *p2;
    }
    p1++;
 29c:	0505                	add	a0,a0,1
    p2++;
 29e:	0585                	add	a1,a1,1
    if (*p1 != *p2) {
 2a0:	fee788e3          	beq	a5,a4,290 <memcmp+0x16>
  }
  return 0;
}
 2a4:	6422                	ld	s0,8(sp)
      return *p1 - *p2;
 2a6:	40e7853b          	subw	a0,a5,a4
}
 2aa:	0141                	add	sp,sp,16
 2ac:	8082                	ret
 2ae:	6422                	ld	s0,8(sp)
  return 0;
 2b0:	4501                	li	a0,0
}
 2b2:	0141                	add	sp,sp,16
 2b4:	8082                	ret

00000000000002b6 <memcpy>:

void *
memcpy(void *dst, const void *src, uint n)
{
 2b6:	1141                	add	sp,sp,-16
 2b8:	e422                	sd	s0,8(sp)
 2ba:	0800                	add	s0,sp,16
  return memmove(dst, src, n);
 2bc:	0006079b          	sext.w	a5,a2
  if (src > dst) {
 2c0:	02b57463          	bgeu	a0,a1,2e8 <memcpy+0x32>
    while(n-- > 0)
 2c4:	00f05f63          	blez	a5,2e2 <memcpy+0x2c>
 2c8:	1602                	sll	a2,a2,0x20
 2ca:	9201                	srl	a2,a2,0x20
 2cc:	00c587b3          	add	a5,a1,a2
  dst = vdst;
 2d0:	872a                	mv	a4,a0
      *dst++ = *src++;
 2d2:	0005c683          	lbu	a3,0(a1)
 2d6:	0585                	add	a1,a1,1
 2d8:	0705                	add	a4,a4,1
 2da:	fed70fa3          	sb	a3,-1(a4)
    while(n-- > 0)
 2de:	fef59ae3          	bne	a1,a5,2d2 <memcpy+0x1c>
}
 2e2:	6422                	ld	s0,8(sp)
 2e4:	0141                	add	sp,sp,16
 2e6:	8082                	ret
    dst += n;
 2e8:	00f50733          	add	a4,a0,a5
    src += n;
 2ec:	95be                	add	a1,a1,a5
    while(n-- > 0)
 2ee:	fef05ae3          	blez	a5,2e2 <memcpy+0x2c>
 2f2:	fff6079b          	addw	a5,a2,-1
 2f6:	1782                	sll	a5,a5,0x20
 2f8:	9381                	srl	a5,a5,0x20
 2fa:	fff7c793          	not	a5,a5
 2fe:	97ae                	add	a5,a5,a1
      *--dst = *--src;
 300:	fff5c683          	lbu	a3,-1(a1)
 304:	15fd                	add	a1,a1,-1
 306:	177d                	add	a4,a4,-1
 308:	00d70023          	sb	a3,0(a4)
    while(n-- > 0)
 30c:	fef59ae3          	bne	a1,a5,300 <memcpy+0x4a>
}
 310:	6422                	ld	s0,8(sp)
 312:	0141                	add	sp,sp,16
 314:	8082                	ret

0000000000000316 <fork>:
# generated by usys.pl - do not edit
#include "kern/syscall.h"
.global fork
fork:
 li a7, SYS_fork
 316:	4885                	li	a7,1
 ecall
 318:	00000073          	ecall
 ret
 31c:	8082                	ret

000000000000031e <exit>:
.global exit
exit:
 li a7, SYS_exit
 31e:	4889                	li	a7,2
 ecall
 320:	00000073          	ecall
 ret
 324:	8082                	ret

0000000000000326 <wait>:
.global wait
wait:
 li a7, SYS_wait
 326:	488d                	li	a7,3
 ecall
 328:	00000073          	ecall
 ret
 32c:	8082                	ret

000000000000032e <pipe>:
.global pipe
pipe:
 li a7, SYS_pipe
 32e:	4891                	li	a7,4
 ecall
 330:	00000073          	ecall
 ret
 334:	8082                	ret

0000000000000336 <read>:
.global read
read:
 li a7, SYS_read
 336:	4895                	li	a7,5
 ecall
 338:	00000073          	ecall
 ret
 33c:	8082                	ret

000000000000033e <write>:
.global write
write:
 li a7, SYS_write
 33e:	48c1                	li	a7,16
 ecall
 340:	00000073          	ecall
 ret
 344:	8082                	ret

0000000000000346 <close>:
.global close
close:
 li a7, SYS_close
 346:	48d5                	li	a7,21
 ecall
 348:	00000073          	ecall
 ret
 34c:	8082                	ret

000000000000034e <kill>:
.global kill
kill:
 li a7, SYS_kill
 34e:	4899                	li	a7,6
 ecall
 350:	00000073          	ecall
 ret
 354:	8082                	ret

0000000000000356 <exec>:
.global exec
exec:
 li a7, SYS_exec
 356:	489d                	li	a7,7
 ecall
 358:	00000073          	ecall
 ret
 35c:	8082                	ret

000000000000035e <open>:
.global open
open:
 li a7, SYS_open
 35e:	48bd                	li	a7,15
 ecall
 360:	00000073          	ecall
 ret
 364:	8082                	ret

0000000000000366 <mknod>:
.global mknod
mknod:
 li a7, SYS_mknod
 366:	48c5                	li	a7,17
 ecall
 368:	00000073          	ecall
 ret
 36c:	8082                	ret

000000000000036e <unlink>:
.global unlink
unlink:
 li a7, SYS_unlink
 36e:	48c9                	li	a7,18
 ecall
 370:	00000073          	ecall
 ret
 374:	8082                	ret

0000000000000376 <fstat>:
.global fstat
fstat:
 li a7, SYS_fstat
 376:	48a1                	li	a7,8
 ecall
 378:	00000073          	ecall
 ret
 37c:	8082                	ret

000000000000037e <link>:
.global link
link:
 li a7, SYS_link
 37e:	48cd                	li	a7,19
 ecall
 380:	00000073          	ecall
 ret
 384:	8082                	ret

0000000000000386 <mkdir>:
.global mkdir
mkdir:
 li a7, SYS_mkdir
 386:	48d1                	li	a7,20
 ecall
 388:	00000073          	ecall
 ret
 38c:	8082                	ret

000000000000038e <chdir>:
.global chdir
chdir:
 li a7, SYS_chdir
 38e:	48a5                	li	a7,9
 ecall
 390:	00000073          	ecall
 ret
 394:	8082                	ret

0000000000000396 <dup>:
.global dup
dup:
 li a7, SYS_dup
 396:	48a9                	li	a7,10
 ecall
 398:	00000073          	ecall
 ret
 39c:	8082                	ret

000000000000039e <getpid>:
.global getpid
getpid:
 li a7, SYS_getpid
 39e:	48ad                	li	a7,11
 ecall
 3a0:	00000073          	ecall
 ret
 3a4:	8082                	ret

00000000000003a6 <sbrk>:
.global sbrk
sbrk:
 li a7, SYS_sbrk
 3a6:	48b1                	li	a7,12
 ecall
 3a8:	00000073          	ecall
 ret
 3ac:	8082                	ret

00000000000003ae <sleep>:
.global sleep
sleep:
 li a7, SYS_sleep
 3ae:	48b5                	li	a7,13
 ecall
 3b0:	00000073          	ecall
 ret
 3b4:	8082                	ret

00000000000003b6 <uptime>:
.global uptime
uptime:
 li a7, SYS_uptime
 3b6:	48b9                	li	a7,14
 ecall
 3b8:	00000073          	ecall
 ret
 3bc:	8082                	ret

00000000000003be <poweroff>:
.global poweroff
poweroff:
 li a7, SYS_poweroff
 3be:	48d9                	li	a7,22
 ecall
 3c0:	00000073          	ecall
 ret
 3c4:	8082                	ret

00000000000003c6 <printint>:
  write(fd, &c, 1);
}

static void
printint(int fd, int xx, int base, int sgn)
{
 3c6:	715d                	add	sp,sp,-80
 3c8:	e0a2                	sd	s0,64(sp)
 3ca:	f84a                	sd	s2,48(sp)
 3cc:	e486                	sd	ra,72(sp)
 3ce:	fc26                	sd	s1,56(sp)
 3d0:	f44e                	sd	s3,40(sp)
 3d2:	0880                	add	s0,sp,80
 3d4:	892a                	mv	s2,a0
  char buf[16];
  int i, neg;
  uint x;

  neg = 0;
  if(sgn && xx < 0){
 3d6:	c299                	beqz	a3,3dc <printint+0x16>
 3d8:	0805c263          	bltz	a1,45c <printint+0x96>
    neg = 1;
    x = -xx;
  } else {
    x = xx;
 3dc:	2581                	sext.w	a1,a1
  neg = 0;
 3de:	4681                	li	a3,0
  }

  i = 0;
  do{
    buf[i++] = digits[x % base];
 3e0:	2601                	sext.w	a2,a2
 3e2:	fc040713          	add	a4,s0,-64
  i = 0;
 3e6:	4501                	li	a0,0
 3e8:	00000897          	auipc	a7,0x0
 3ec:	4b888893          	add	a7,a7,1208 # 8a0 <digits>
    buf[i++] = digits[x % base];
 3f0:	02c5f7bb          	remuw	a5,a1,a2
  }while((x /= base) != 0);
 3f4:	0705                	add	a4,a4,1
 3f6:	0005881b          	sext.w	a6,a1
 3fa:	84aa                	mv	s1,a0
    buf[i++] = digits[x % base];
 3fc:	2505                	addw	a0,a0,1
 3fe:	1782                	sll	a5,a5,0x20
 400:	9381                	srl	a5,a5,0x20
 402:	97c6                	add	a5,a5,a7
 404:	0007c783          	lbu	a5,0(a5)
  }while((x /= base) != 0);
 408:	02c5d5bb          	divuw	a1,a1,a2
    buf[i++] = digits[x % base];
 40c:	fef70fa3          	sb	a5,-1(a4)
  }while((x /= base) != 0);
 410:	fec870e3          	bgeu	a6,a2,3f0 <printint+0x2a>
  if(neg)
 414:	ca89                	beqz	a3,426 <printint+0x60>
    buf[i++] = '-';
 416:	fd050793          	add	a5,a0,-48
 41a:	97a2                	add	a5,a5,s0
 41c:	02d00713          	li	a4,45
 420:	fee78823          	sb	a4,-16(a5)

  while(--i >= 0)
 424:	84aa                	mv	s1,a0
 426:	fc040793          	add	a5,s0,-64
 42a:	94be                	add	s1,s1,a5
 42c:	fff78993          	add	s3,a5,-1
    putc(fd, buf[i]);
 430:	0004c783          	lbu	a5,0(s1)
  write(fd, &c, 1);
 434:	4605                	li	a2,1
 436:	fbf40593          	add	a1,s0,-65
 43a:	854a                	mv	a0,s2
  while(--i >= 0)
 43c:	14fd                	add	s1,s1,-1
 43e:	faf40fa3          	sb	a5,-65(s0)
  write(fd, &c, 1);
 442:	00000097          	auipc	ra,0x0
 446:	efc080e7          	jalr	-260(ra) # 33e <write>
  while(--i >= 0)
 44a:	ff3493e3          	bne	s1,s3,430 <printint+0x6a>
}
 44e:	60a6                	ld	ra,72(sp)
 450:	6406                	ld	s0,64(sp)
 452:	74e2                	ld	s1,56(sp)
 454:	7942                	ld	s2,48(sp)
 456:	79a2                	ld	s3,40(sp)
 458:	6161                	add	sp,sp,80
 45a:	8082                	ret
    x = -xx;
 45c:	40b005bb          	negw	a1,a1
 460:	b741                	j	3e0 <printint+0x1a>

0000000000000462 <vprintf>:
}

// Print to the given fd. Only understands %d, %x, %p, %s.
void
vprintf(int fd, const char *fmt, va_list ap)
{
 462:	7159                	add	sp,sp,-112
 464:	f0a2                	sd	s0,96(sp)
 466:	f486                	sd	ra,104(sp)
 468:	e8ca                	sd	s2,80(sp)
 46a:	1880                	add	s0,sp,112
  char *s;
  int c, i, state;

  state = 0;
  for(i = 0; fmt[i]; i++){
 46c:	0005c903          	lbu	s2,0(a1)
 470:	04090f63          	beqz	s2,4ce <vprintf+0x6c>
 474:	eca6                	sd	s1,88(sp)
 476:	e4ce                	sd	s3,72(sp)
 478:	e0d2                	sd	s4,64(sp)
 47a:	fc56                	sd	s5,56(sp)
 47c:	f85a                	sd	s6,48(sp)
 47e:	f45e                	sd	s7,40(sp)
 480:	f062                	sd	s8,32(sp)
 482:	8a2a                	mv	s4,a0
 484:	8c32                	mv	s8,a2
 486:	00158493          	add	s1,a1,1
 48a:	4981                	li	s3,0
      if(c == '%'){
        state = '%';
      } else {
        putc(fd, c);
      }
    } else if(state == '%'){
 48c:	02500a93          	li	s5,37
 490:	4bd5                	li	s7,21
 492:	00000b17          	auipc	s6,0x0
 496:	3b6b0b13          	add	s6,s6,950 # 848 <malloc+0x100>
    if(state == 0){
 49a:	02099f63          	bnez	s3,4d8 <vprintf+0x76>
      if(c == '%'){
 49e:	05590c63          	beq	s2,s5,4f6 <vprintf+0x94>
  write(fd, &c, 1);
 4a2:	4605                	li	a2,1
 4a4:	f9f40593          	add	a1,s0,-97
 4a8:	8552                	mv	a0,s4
 4aa:	f9240fa3          	sb	s2,-97(s0)
 4ae:	00000097          	auipc	ra,0x0
 4b2:	e90080e7          	jalr	-368(ra) # 33e <write>
  for(i = 0; fmt[i]; i++){
 4b6:	0004c903          	lbu	s2,0(s1)
 4ba:	0485                	add	s1,s1,1
 4bc:	fc091fe3          	bnez	s2,49a <vprintf+0x38>
 4c0:	64e6                	ld	s1,88(sp)
 4c2:	69a6                	ld	s3,72(sp)
 4c4:	6a06                	ld	s4,64(sp)
 4c6:	7ae2                	ld	s5,56(sp)
 4c8:	7b42                	ld	s6,48(sp)
 4ca:	7ba2                	ld	s7,40(sp)
 4cc:	7c02                	ld	s8,32(sp)
        putc(fd, c);
      }
      state = 0;
    }
  }
}
 4ce:	70a6                	ld	ra,104(sp)
 4d0:	7406                	ld	s0,96(sp)
 4d2:	6946                	ld	s2,80(sp)
 4d4:	6165                	add	sp,sp,112
 4d6:	8082                	ret
    } else if(state == '%'){
 4d8:	fd599fe3          	bne	s3,s5,4b6 <vprintf+0x54>
      if(c == 'd'){
 4dc:	15590463          	beq	s2,s5,624 <vprintf+0x1c2>
 4e0:	f9d9079b          	addw	a5,s2,-99
 4e4:	0ff7f793          	zext.b	a5,a5
 4e8:	00fbea63          	bltu	s7,a5,4fc <vprintf+0x9a>
 4ec:	078a                	sll	a5,a5,0x2
 4ee:	97da                	add	a5,a5,s6
 4f0:	439c                	lw	a5,0(a5)
 4f2:	97da                	add	a5,a5,s6
 4f4:	8782                	jr	a5
        state = '%';
 4f6:	02500993          	li	s3,37
 4fa:	bf75                	j	4b6 <vprintf+0x54>
  write(fd, &c, 1);
 4fc:	f9f40993          	add	s3,s0,-97
 500:	4605                	li	a2,1
 502:	85ce                	mv	a1,s3
 504:	02500793          	li	a5,37
 508:	8552                	mv	a0,s4
 50a:	f8f40fa3          	sb	a5,-97(s0)
 50e:	00000097          	auipc	ra,0x0
 512:	e30080e7          	jalr	-464(ra) # 33e <write>
 516:	4605                	li	a2,1
 518:	85ce                	mv	a1,s3
 51a:	8552                	mv	a0,s4
 51c:	f9240fa3          	sb	s2,-97(s0)
 520:	00000097          	auipc	ra,0x0
 524:	e1e080e7          	jalr	-482(ra) # 33e <write>
        while(*s != 0){
 528:	4981                	li	s3,0
 52a:	b771                	j	4b6 <vprintf+0x54>
        putc(fd, va_arg(ap, uint));
 52c:	000c2783          	lw	a5,0(s8)
  write(fd, &c, 1);
 530:	4605                	li	a2,1
 532:	f9f40593          	add	a1,s0,-97
 536:	8552                	mv	a0,s4
        putc(fd, va_arg(ap, uint));
 538:	f8f40fa3          	sb	a5,-97(s0)
 53c:	0c21                	add	s8,s8,8
  write(fd, &c, 1);
 53e:	00000097          	auipc	ra,0x0
 542:	e00080e7          	jalr	-512(ra) # 33e <write>
 546:	4981                	li	s3,0
 548:	b7bd                	j	4b6 <vprintf+0x54>
        printint(fd, va_arg(ap, int), 10, 1);
 54a:	000c2583          	lw	a1,0(s8)
 54e:	4685                	li	a3,1
        printint(fd, va_arg(ap, uint64), 10, 0);
 550:	4629                	li	a2,10
 552:	8552                	mv	a0,s4
 554:	0c21                	add	s8,s8,8
 556:	00000097          	auipc	ra,0x0
 55a:	e70080e7          	jalr	-400(ra) # 3c6 <printint>
 55e:	4981                	li	s3,0
 560:	bf99                	j	4b6 <vprintf+0x54>
 562:	000c2583          	lw	a1,0(s8)
 566:	4681                	li	a3,0
 568:	b7e5                	j	550 <vprintf+0xee>
  write(fd, &c, 1);
 56a:	f9f40993          	add	s3,s0,-97
 56e:	03000793          	li	a5,48
 572:	4605                	li	a2,1
 574:	85ce                	mv	a1,s3
 576:	8552                	mv	a0,s4
 578:	ec66                	sd	s9,24(sp)
 57a:	e86a                	sd	s10,16(sp)
        printptr(fd, va_arg(ap, uint64));
 57c:	f8f40fa3          	sb	a5,-97(s0)
 580:	000c3d03          	ld	s10,0(s8)
  write(fd, &c, 1);
 584:	00000097          	auipc	ra,0x0
 588:	dba080e7          	jalr	-582(ra) # 33e <write>
 58c:	07800793          	li	a5,120
 590:	4605                	li	a2,1
 592:	85ce                	mv	a1,s3
 594:	8552                	mv	a0,s4
 596:	f8f40fa3          	sb	a5,-97(s0)
        printptr(fd, va_arg(ap, uint64));
 59a:	0c21                	add	s8,s8,8
  write(fd, &c, 1);
 59c:	00000097          	auipc	ra,0x0
 5a0:	da2080e7          	jalr	-606(ra) # 33e <write>
  putc(fd, 'x');
 5a4:	4941                	li	s2,16
 5a6:	00000c97          	auipc	s9,0x0
 5aa:	2fac8c93          	add	s9,s9,762 # 8a0 <digits>
    putc(fd, digits[x >> (sizeof(uint64) * 8 - 4)]);
 5ae:	03cd5793          	srl	a5,s10,0x3c
 5b2:	97e6                	add	a5,a5,s9
 5b4:	0007c783          	lbu	a5,0(a5)
  write(fd, &c, 1);
 5b8:	4605                	li	a2,1
 5ba:	85ce                	mv	a1,s3
 5bc:	8552                	mv	a0,s4
  for (i = 0; i < (sizeof(uint64) * 2); i++, x <<= 4)
 5be:	397d                	addw	s2,s2,-1
 5c0:	f8f40fa3          	sb	a5,-97(s0)
 5c4:	0d12                	sll	s10,s10,0x4
  write(fd, &c, 1);
 5c6:	00000097          	auipc	ra,0x0
 5ca:	d78080e7          	jalr	-648(ra) # 33e <write>
  for (i = 0; i < (sizeof(uint64) * 2); i++, x <<= 4)
 5ce:	fe0910e3          	bnez	s2,5ae <vprintf+0x14c>
 5d2:	6ce2                	ld	s9,24(sp)
 5d4:	6d42                	ld	s10,16(sp)
 5d6:	4981                	li	s3,0
 5d8:	bdf9                	j	4b6 <vprintf+0x54>
        s = va_arg(ap, char*);
 5da:	000c3903          	ld	s2,0(s8)
 5de:	0c21                	add	s8,s8,8
        if(s == 0)
 5e0:	04090e63          	beqz	s2,63c <vprintf+0x1da>
        while(*s != 0){
 5e4:	00094783          	lbu	a5,0(s2)
 5e8:	d3a1                	beqz	a5,528 <vprintf+0xc6>
 5ea:	f9f40993          	add	s3,s0,-97
  write(fd, &c, 1);
 5ee:	4605                	li	a2,1
 5f0:	85ce                	mv	a1,s3
 5f2:	8552                	mv	a0,s4
 5f4:	f8f40fa3          	sb	a5,-97(s0)
 5f8:	00000097          	auipc	ra,0x0
 5fc:	d46080e7          	jalr	-698(ra) # 33e <write>
        while(*s != 0){
 600:	00194783          	lbu	a5,1(s2)
          s++;
 604:	0905                	add	s2,s2,1
        while(*s != 0){
 606:	f7e5                	bnez	a5,5ee <vprintf+0x18c>
 608:	4981                	li	s3,0
 60a:	b575                	j	4b6 <vprintf+0x54>
        printint(fd, va_arg(ap, int), 16, 0);
 60c:	000c2583          	lw	a1,0(s8)
 610:	4681                	li	a3,0
 612:	4641                	li	a2,16
 614:	8552                	mv	a0,s4
 616:	0c21                	add	s8,s8,8
 618:	00000097          	auipc	ra,0x0
 61c:	dae080e7          	jalr	-594(ra) # 3c6 <printint>
 620:	4981                	li	s3,0
 622:	bd51                	j	4b6 <vprintf+0x54>
  write(fd, &c, 1);
 624:	4605                	li	a2,1
 626:	f9f40593          	add	a1,s0,-97
 62a:	8552                	mv	a0,s4
 62c:	f9540fa3          	sb	s5,-97(s0)
        while(*s != 0){
 630:	4981                	li	s3,0
  write(fd, &c, 1);
 632:	00000097          	auipc	ra,0x0
 636:	d0c080e7          	jalr	-756(ra) # 33e <write>
 63a:	bdb5                	j	4b6 <vprintf+0x54>
          s = "(null)";
 63c:	00000917          	auipc	s2,0x0
 640:	20490913          	add	s2,s2,516 # 840 <malloc+0xf8>
 644:	02800793          	li	a5,40
 648:	b74d                	j	5ea <vprintf+0x188>

000000000000064a <fprintf>:

void
fprintf(int fd, const char *fmt, ...)
{
 64a:	715d                	add	sp,sp,-80
 64c:	e822                	sd	s0,16(sp)
 64e:	ec06                	sd	ra,24(sp)
 650:	1000                	add	s0,sp,32
 652:	e010                	sd	a2,0(s0)
  va_list ap;

  va_start(ap, fmt);
  vprintf(fd, fmt, ap);
 654:	8622                	mv	a2,s0
{
 656:	e414                	sd	a3,8(s0)
 658:	e818                	sd	a4,16(s0)
 65a:	ec1c                	sd	a5,24(s0)
 65c:	03043023          	sd	a6,32(s0)
 660:	03143423          	sd	a7,40(s0)
  va_start(ap, fmt);
 664:	fe843423          	sd	s0,-24(s0)
  vprintf(fd, fmt, ap);
 668:	00000097          	auipc	ra,0x0
 66c:	dfa080e7          	jalr	-518(ra) # 462 <vprintf>
}
 670:	60e2                	ld	ra,24(sp)
 672:	6442                	ld	s0,16(sp)
 674:	6161                	add	sp,sp,80
 676:	8082                	ret

0000000000000678 <printf>:

void
printf(const char *fmt, ...)
{
 678:	711d                	add	sp,sp,-96
 67a:	e822                	sd	s0,16(sp)
 67c:	ec06                	sd	ra,24(sp)
 67e:	1000                	add	s0,sp,32
  va_list ap;

  va_start(ap, fmt);
 680:	00840313          	add	t1,s0,8
{
 684:	e40c                	sd	a1,8(s0)
 686:	e810                	sd	a2,16(s0)
  vprintf(1, fmt, ap);
 688:	85aa                	mv	a1,a0
 68a:	861a                	mv	a2,t1
 68c:	4505                	li	a0,1
{
 68e:	ec14                	sd	a3,24(s0)
 690:	f018                	sd	a4,32(s0)
 692:	f41c                	sd	a5,40(s0)
 694:	03043823          	sd	a6,48(s0)
 698:	03143c23          	sd	a7,56(s0)
  va_start(ap, fmt);
 69c:	fe643423          	sd	t1,-24(s0)
  vprintf(1, fmt, ap);
 6a0:	00000097          	auipc	ra,0x0
 6a4:	dc2080e7          	jalr	-574(ra) # 462 <vprintf>
}
 6a8:	60e2                	ld	ra,24(sp)
 6aa:	6442                	ld	s0,16(sp)
 6ac:	6125                	add	sp,sp,96
 6ae:	8082                	ret

00000000000006b0 <free>:
static Header base;
static Header *freep;

void
free(void *ap)
{
 6b0:	1141                	add	sp,sp,-16
 6b2:	e422                	sd	s0,8(sp)
 6b4:	0800                	add	s0,sp,16
  Header *bp, *p;

  bp = (Header*)ap - 1;
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 6b6:	00001597          	auipc	a1,0x1
 6ba:	94a58593          	add	a1,a1,-1718 # 1000 <freep>
 6be:	619c                	ld	a5,0(a1)
  bp = (Header*)ap - 1;
 6c0:	ff050693          	add	a3,a0,-16
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 6c4:	6398                	ld	a4,0(a5)
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 6c6:	02d7ff63          	bgeu	a5,a3,704 <free+0x54>
 6ca:	00e6e463          	bltu	a3,a4,6d2 <free+0x22>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 6ce:	02e7ef63          	bltu	a5,a4,70c <free+0x5c>
      break;
  if(bp + bp->s.size == p->s.ptr){
 6d2:	ff852803          	lw	a6,-8(a0)
 6d6:	02081893          	sll	a7,a6,0x20
 6da:	01c8d613          	srl	a2,a7,0x1c
 6de:	9636                	add	a2,a2,a3
 6e0:	02c70863          	beq	a4,a2,710 <free+0x60>
    bp->s.size += p->s.ptr->s.size;
    bp->s.ptr = p->s.ptr->s.ptr;
  } else
    bp->s.ptr = p->s.ptr;
  if(p + p->s.size == bp){
 6e4:	0087a803          	lw	a6,8(a5)
 6e8:	fee53823          	sd	a4,-16(a0)
 6ec:	02081893          	sll	a7,a6,0x20
 6f0:	01c8d613          	srl	a2,a7,0x1c
 6f4:	963e                	add	a2,a2,a5
 6f6:	02c68e63          	beq	a3,a2,732 <free+0x82>
    p->s.size += bp->s.size;
    p->s.ptr = bp->s.ptr;
  } else
    p->s.ptr = bp;
  freep = p;
}
 6fa:	6422                	ld	s0,8(sp)
 6fc:	e394                	sd	a3,0(a5)
  freep = p;
 6fe:	e19c                	sd	a5,0(a1)
}
 700:	0141                	add	sp,sp,16
 702:	8082                	ret
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 704:	00e7e463          	bltu	a5,a4,70c <free+0x5c>
 708:	fce6e5e3          	bltu	a3,a4,6d2 <free+0x22>
{
 70c:	87ba                	mv	a5,a4
 70e:	bf5d                	j	6c4 <free+0x14>
    bp->s.size += p->s.ptr->s.size;
 710:	4710                	lw	a2,8(a4)
    bp->s.ptr = p->s.ptr->s.ptr;
 712:	6318                	ld	a4,0(a4)
    bp->s.size += p->s.ptr->s.size;
 714:	0106063b          	addw	a2,a2,a6
 718:	fec52c23          	sw	a2,-8(a0)
  if(p + p->s.size == bp){
 71c:	0087a803          	lw	a6,8(a5)
 720:	fee53823          	sd	a4,-16(a0)
 724:	02081893          	sll	a7,a6,0x20
 728:	01c8d613          	srl	a2,a7,0x1c
 72c:	963e                	add	a2,a2,a5
 72e:	fcc696e3          	bne	a3,a2,6fa <free+0x4a>
    p->s.size += bp->s.size;
 732:	ff852603          	lw	a2,-8(a0)
}
 736:	6422                	ld	s0,8(sp)
    p->s.ptr = bp->s.ptr;
 738:	86ba                	mv	a3,a4
    p->s.size += bp->s.size;
 73a:	0106073b          	addw	a4,a2,a6
 73e:	c798                	sw	a4,8(a5)
    p->s.ptr = bp->s.ptr;
 740:	e394                	sd	a3,0(a5)
  freep = p;
 742:	e19c                	sd	a5,0(a1)
}
 744:	0141                	add	sp,sp,16
 746:	8082                	ret

0000000000000748 <malloc>:
  return freep;
}

void*
malloc(uint nbytes)
{
 748:	7139                	add	sp,sp,-64
 74a:	f822                	sd	s0,48(sp)
 74c:	f426                	sd	s1,40(sp)
 74e:	f04a                	sd	s2,32(sp)
 750:	ec4e                	sd	s3,24(sp)
 752:	fc06                	sd	ra,56(sp)
 754:	0080                	add	s0,sp,64
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
  if((prevp = freep) == 0){
 756:	00001917          	auipc	s2,0x1
 75a:	8aa90913          	add	s2,s2,-1878 # 1000 <freep>
  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
 75e:	02051493          	sll	s1,a0,0x20
 762:	9081                	srl	s1,s1,0x20
  if((prevp = freep) == 0){
 764:	00093783          	ld	a5,0(s2)
  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
 768:	04bd                	add	s1,s1,15
 76a:	8091                	srl	s1,s1,0x4
 76c:	0014899b          	addw	s3,s1,1
 770:	0485                	add	s1,s1,1
  if((prevp = freep) == 0){
 772:	c3dd                	beqz	a5,818 <malloc+0xd0>
    base.s.ptr = freep = prevp = &base;
    base.s.size = 0;
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 774:	6388                	ld	a0,0(a5)
    if(p->s.size >= nunits){
 776:	4518                	lw	a4,8(a0)
 778:	06977863          	bgeu	a4,s1,7e8 <malloc+0xa0>
 77c:	e852                	sd	s4,16(sp)
 77e:	e456                	sd	s5,8(sp)
 780:	e05a                	sd	s6,0(sp)
  if(nu < 4096)
 782:	6785                	lui	a5,0x1
 784:	8a4e                	mv	s4,s3
 786:	08f4e763          	bltu	s1,a5,814 <malloc+0xcc>
 78a:	000a0b1b          	sext.w	s6,s4
  if(p == (char*)-1)
 78e:	5afd                	li	s5,-1
  p = sbrk(nu * sizeof(Header));
 790:	004a1a1b          	sllw	s4,s4,0x4
 794:	a029                	j	79e <malloc+0x56>
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 796:	6388                	ld	a0,0(a5)
    if(p->s.size >= nunits){
 798:	4518                	lw	a4,8(a0)
 79a:	04977463          	bgeu	a4,s1,7e2 <malloc+0x9a>
        p->s.size = nunits;
      }
      freep = prevp;
      return (void*)(p + 1);
    }
    if(p == freep)
 79e:	00093703          	ld	a4,0(s2)
 7a2:	87aa                	mv	a5,a0
 7a4:	fee519e3          	bne	a0,a4,796 <malloc+0x4e>
  p = sbrk(nu * sizeof(Header));
 7a8:	8552                	mv	a0,s4
 7aa:	00000097          	auipc	ra,0x0
 7ae:	bfc080e7          	jalr	-1028(ra) # 3a6 <sbrk>
 7b2:	87aa                	mv	a5,a0
  free((void*)(hp + 1));
 7b4:	0541                	add	a0,a0,16
  if(p == (char*)-1)
 7b6:	01578b63          	beq	a5,s5,7cc <malloc+0x84>
  hp->s.size = nu;
 7ba:	0167a423          	sw	s6,8(a5) # 1008 <freep+0x8>
  free((void*)(hp + 1));
 7be:	00000097          	auipc	ra,0x0
 7c2:	ef2080e7          	jalr	-270(ra) # 6b0 <free>
  return freep;
 7c6:	00093783          	ld	a5,0(s2)
      if((p = morecore(nunits)) == 0)
 7ca:	f7f1                	bnez	a5,796 <malloc+0x4e>
        return 0;
  }
}
 7cc:	70e2                	ld	ra,56(sp)
 7ce:	7442                	ld	s0,48(sp)
        return 0;
 7d0:	6a42                	ld	s4,16(sp)
 7d2:	6aa2                	ld	s5,8(sp)
 7d4:	6b02                	ld	s6,0(sp)
}
 7d6:	74a2                	ld	s1,40(sp)
 7d8:	7902                	ld	s2,32(sp)
 7da:	69e2                	ld	s3,24(sp)
        return 0;
 7dc:	4501                	li	a0,0
}
 7de:	6121                	add	sp,sp,64
 7e0:	8082                	ret
 7e2:	6a42                	ld	s4,16(sp)
 7e4:	6aa2                	ld	s5,8(sp)
 7e6:	6b02                	ld	s6,0(sp)
      if(p->s.size == nunits)
 7e8:	04e48763          	beq	s1,a4,836 <malloc+0xee>
        p->s.size -= nunits;
 7ec:	4137073b          	subw	a4,a4,s3
        p += p->s.size;
 7f0:	02071613          	sll	a2,a4,0x20
 7f4:	01c65693          	srl	a3,a2,0x1c
        p->s.size -= nunits;
 7f8:	c518                	sw	a4,8(a0)
        p += p->s.size;
 7fa:	9536                	add	a0,a0,a3
        p->s.size = nunits;
 7fc:	01352423          	sw	s3,8(a0)
}
 800:	70e2                	ld	ra,56(sp)
 802:	7442                	ld	s0,48(sp)
      freep = prevp;
 804:	00f93023          	sd	a5,0(s2)
}
 808:	74a2                	ld	s1,40(sp)
 80a:	7902                	ld	s2,32(sp)
 80c:	69e2                	ld	s3,24(sp)
      return (void*)(p + 1);
 80e:	0541                	add	a0,a0,16
}
 810:	6121                	add	sp,sp,64
 812:	8082                	ret
  if(nu < 4096)
 814:	6a05                	lui	s4,0x1
 816:	bf95                	j	78a <malloc+0x42>
 818:	e852                	sd	s4,16(sp)
 81a:	e456                	sd	s5,8(sp)
 81c:	e05a                	sd	s6,0(sp)
    base.s.ptr = freep = prevp = &base;
 81e:	00000517          	auipc	a0,0x0
 822:	7f250513          	add	a0,a0,2034 # 1010 <base>
 826:	00a93023          	sd	a0,0(s2)
 82a:	e108                	sd	a0,0(a0)
    base.s.size = 0;
 82c:	00000797          	auipc	a5,0x0
 830:	7e07a623          	sw	zero,2028(a5) # 1018 <base+0x8>
    if(p->s.size >= nunits){
 834:	b7b9                	j	782 <malloc+0x3a>
        prevp->s.ptr = p->s.ptr;
 836:	6118                	ld	a4,0(a0)
 838:	e398                	sd	a4,0(a5)
 83a:	b7d9                	j	800 <malloc+0xb8>
