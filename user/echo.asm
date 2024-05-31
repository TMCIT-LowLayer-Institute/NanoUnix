
user/_echo:     file format elf64-littleriscv


Disassembly of section .text:

0000000000000000 <main>:

#include <C/string.h>

int
main(int argc, char *argv[])
{
   0:	7179                	add	sp,sp,-48
   2:	f022                	sd	s0,32(sp)
   4:	f406                	sd	ra,40(sp)
   6:	ec26                	sd	s1,24(sp)
   8:	e84a                	sd	s2,16(sp)
   a:	e44e                	sd	s3,8(sp)
   c:	e052                	sd	s4,0(sp)
   e:	1800                	add	s0,sp,48
  int i;

  for(i = 1; i < argc; i++){
  10:	4785                	li	a5,1
  12:	06a7d463          	bge	a5,a0,7a <main+0x7a>
  16:	ffe5099b          	addw	s3,a0,-2
  1a:	02099793          	sll	a5,s3,0x20
  1e:	01d7d993          	srl	s3,a5,0x1d
  22:	01058793          	add	a5,a1,16
  26:	00858493          	add	s1,a1,8
  2a:	99be                	add	s3,s3,a5
    write(1, argv[i], strlen(argv[i]));
    if(i + 1 < argc){
      write(1, " ", 1);
  2c:	00001a17          	auipc	s4,0x1
  30:	874a0a13          	add	s4,s4,-1932 # 8a0 <malloc+0xfc>
  34:	a039                	j	42 <main+0x42>
  36:	85d2                	mv	a1,s4
  38:	4505                	li	a0,1
  3a:	00000097          	auipc	ra,0x0
  3e:	360080e7          	jalr	864(ra) # 39a <write>
    write(1, argv[i], strlen(argv[i]));
  42:	0004b903          	ld	s2,0(s1)
    if(i + 1 < argc){
  46:	04a1                	add	s1,s1,8
    write(1, argv[i], strlen(argv[i]));
  48:	854a                	mv	a0,s2
  4a:	00000097          	auipc	ra,0x0
  4e:	0b6080e7          	jalr	182(ra) # 100 <strlen>
  52:	0005061b          	sext.w	a2,a0
  56:	85ca                	mv	a1,s2
  58:	4505                	li	a0,1
  5a:	00000097          	auipc	ra,0x0
  5e:	340080e7          	jalr	832(ra) # 39a <write>
      write(1, " ", 1);
  62:	4605                	li	a2,1
    if(i + 1 < argc){
  64:	fd3499e3          	bne	s1,s3,36 <main+0x36>
    } else {
      write(1, "\n", 1);
  68:	00001597          	auipc	a1,0x1
  6c:	84058593          	add	a1,a1,-1984 # 8a8 <malloc+0x104>
  70:	4505                	li	a0,1
  72:	00000097          	auipc	ra,0x0
  76:	328080e7          	jalr	808(ra) # 39a <write>
    }
  }
  exit(0);
  7a:	4501                	li	a0,0
  7c:	00000097          	auipc	ra,0x0
  80:	2fe080e7          	jalr	766(ra) # 37a <exit>

0000000000000084 <_main>:
//
// wrapper so that it's OK if main() does not call exit().
//
void
_main()
{
  84:	1141                	add	sp,sp,-16
  86:	e022                	sd	s0,0(sp)
  88:	e406                	sd	ra,8(sp)
  8a:	0800                	add	s0,sp,16
  extern int main();
  main();
  8c:	00000097          	auipc	ra,0x0
  90:	f74080e7          	jalr	-140(ra) # 0 <main>
  exit(0);
  94:	4501                	li	a0,0
  96:	00000097          	auipc	ra,0x0
  9a:	2e4080e7          	jalr	740(ra) # 37a <exit>

000000000000009e <strcpy>:
}

char*
strcpy(char *s, const char *t)
{
  9e:	1141                	add	sp,sp,-16
  a0:	e422                	sd	s0,8(sp)
  a2:	0800                	add	s0,sp,16
  char *os;

  os = s;
  while((*s++ = *t++) != 0)
  a4:	87aa                	mv	a5,a0
  a6:	0005c703          	lbu	a4,0(a1)
  aa:	0785                	add	a5,a5,1
  ac:	0585                	add	a1,a1,1
  ae:	fee78fa3          	sb	a4,-1(a5)
  b2:	fb75                	bnez	a4,a6 <strcpy+0x8>
    ;
  return os;
}
  b4:	6422                	ld	s0,8(sp)
  b6:	0141                	add	sp,sp,16
  b8:	8082                	ret

00000000000000ba <strcmp>:

int
strcmp(const char *p, const char *q)
{
  ba:	1141                	add	sp,sp,-16
  bc:	e422                	sd	s0,8(sp)
  be:	0800                	add	s0,sp,16
  while(*p && *p == *q)
  c0:	00054783          	lbu	a5,0(a0)
  c4:	e791                	bnez	a5,d0 <strcmp+0x16>
  c6:	a80d                	j	f8 <strcmp+0x3e>
  c8:	00054783          	lbu	a5,0(a0)
  cc:	cf99                	beqz	a5,ea <strcmp+0x30>
  ce:	85b6                	mv	a1,a3
  d0:	0005c703          	lbu	a4,0(a1)
    p++, q++;
  d4:	0505                	add	a0,a0,1
  d6:	00158693          	add	a3,a1,1
  while(*p && *p == *q)
  da:	fef707e3          	beq	a4,a5,c8 <strcmp+0xe>
  return (uchar)*p - (uchar)*q;
  de:	0007851b          	sext.w	a0,a5
}
  e2:	6422                	ld	s0,8(sp)
  e4:	9d19                	subw	a0,a0,a4
  e6:	0141                	add	sp,sp,16
  e8:	8082                	ret
  return (uchar)*p - (uchar)*q;
  ea:	0015c703          	lbu	a4,1(a1)
}
  ee:	6422                	ld	s0,8(sp)
  return (uchar)*p - (uchar)*q;
  f0:	4501                	li	a0,0
}
  f2:	9d19                	subw	a0,a0,a4
  f4:	0141                	add	sp,sp,16
  f6:	8082                	ret
  return (uchar)*p - (uchar)*q;
  f8:	0005c703          	lbu	a4,0(a1)
  fc:	4501                	li	a0,0
  fe:	b7d5                	j	e2 <strcmp+0x28>

0000000000000100 <strlen>:

uint
strlen(const char *s)
{
 100:	1141                	add	sp,sp,-16
 102:	e422                	sd	s0,8(sp)
 104:	0800                	add	s0,sp,16
  int n;

  for(n = 0; s[n]; n++)
 106:	00054783          	lbu	a5,0(a0)
 10a:	cf91                	beqz	a5,126 <strlen+0x26>
 10c:	0505                	add	a0,a0,1
 10e:	87aa                	mv	a5,a0
 110:	0007c703          	lbu	a4,0(a5)
 114:	86be                	mv	a3,a5
 116:	0785                	add	a5,a5,1
 118:	ff65                	bnez	a4,110 <strlen+0x10>
    ;
  return n;
}
 11a:	6422                	ld	s0,8(sp)
 11c:	40a6853b          	subw	a0,a3,a0
 120:	2505                	addw	a0,a0,1
 122:	0141                	add	sp,sp,16
 124:	8082                	ret
 126:	6422                	ld	s0,8(sp)
  for(n = 0; s[n]; n++)
 128:	4501                	li	a0,0
}
 12a:	0141                	add	sp,sp,16
 12c:	8082                	ret

000000000000012e <memset>:

void*
memset(void *dst, int c, uint n)
{
 12e:	1141                	add	sp,sp,-16
 130:	e422                	sd	s0,8(sp)
 132:	0800                	add	s0,sp,16
  char *cdst = (char *) dst;
  int i;
  for(i = 0; i < n; i++){
 134:	ce09                	beqz	a2,14e <memset+0x20>
 136:	1602                	sll	a2,a2,0x20
 138:	9201                	srl	a2,a2,0x20
    cdst[i] = c;
 13a:	0ff5f593          	zext.b	a1,a1
 13e:	87aa                	mv	a5,a0
 140:	00a60733          	add	a4,a2,a0
 144:	00b78023          	sb	a1,0(a5)
  for(i = 0; i < n; i++){
 148:	0785                	add	a5,a5,1
 14a:	fee79de3          	bne	a5,a4,144 <memset+0x16>
  }
  return dst;
}
 14e:	6422                	ld	s0,8(sp)
 150:	0141                	add	sp,sp,16
 152:	8082                	ret

0000000000000154 <strchr>:

char*
strchr(const char *s, char c)
{
 154:	1141                	add	sp,sp,-16
 156:	e422                	sd	s0,8(sp)
 158:	0800                	add	s0,sp,16
  for(; *s; s++)
 15a:	00054783          	lbu	a5,0(a0)
 15e:	c799                	beqz	a5,16c <strchr+0x18>
    if(*s == c)
 160:	00f58763          	beq	a1,a5,16e <strchr+0x1a>
  for(; *s; s++)
 164:	00154783          	lbu	a5,1(a0)
 168:	0505                	add	a0,a0,1
 16a:	fbfd                	bnez	a5,160 <strchr+0xc>
      return (char*)s;
  return 0;
 16c:	4501                	li	a0,0
}
 16e:	6422                	ld	s0,8(sp)
 170:	0141                	add	sp,sp,16
 172:	8082                	ret

0000000000000174 <gets>:

char*
gets(char *buf, int max)
{
 174:	711d                	add	sp,sp,-96
 176:	e8a2                	sd	s0,80(sp)
 178:	e4a6                	sd	s1,72(sp)
 17a:	e0ca                	sd	s2,64(sp)
 17c:	fc4e                	sd	s3,56(sp)
 17e:	f852                	sd	s4,48(sp)
 180:	f05a                	sd	s6,32(sp)
 182:	ec5e                	sd	s7,24(sp)
 184:	ec86                	sd	ra,88(sp)
 186:	f456                	sd	s5,40(sp)
 188:	1080                	add	s0,sp,96
 18a:	8baa                	mv	s7,a0
 18c:	89ae                	mv	s3,a1
 18e:	892a                	mv	s2,a0
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
 190:	4481                	li	s1,0
    cc = read(0, &c, 1);
    if(cc < 1)
      break;
    buf[i++] = c;
    if(c == '\n' || c == '\r')
 192:	4a29                	li	s4,10
 194:	4b35                	li	s6,13
  for(i=0; i+1 < max; ){
 196:	a005                	j	1b6 <gets+0x42>
    cc = read(0, &c, 1);
 198:	00000097          	auipc	ra,0x0
 19c:	1fa080e7          	jalr	506(ra) # 392 <read>
    if(cc < 1)
 1a0:	02a05363          	blez	a0,1c6 <gets+0x52>
    buf[i++] = c;
 1a4:	faf44783          	lbu	a5,-81(s0)
    if(c == '\n' || c == '\r')
 1a8:	0905                	add	s2,s2,1
    buf[i++] = c;
 1aa:	fef90fa3          	sb	a5,-1(s2)
    if(c == '\n' || c == '\r')
 1ae:	01478d63          	beq	a5,s4,1c8 <gets+0x54>
 1b2:	01678b63          	beq	a5,s6,1c8 <gets+0x54>
  for(i=0; i+1 < max; ){
 1b6:	8aa6                	mv	s5,s1
 1b8:	2485                	addw	s1,s1,1
    cc = read(0, &c, 1);
 1ba:	4605                	li	a2,1
 1bc:	faf40593          	add	a1,s0,-81
 1c0:	4501                	li	a0,0
  for(i=0; i+1 < max; ){
 1c2:	fd34cbe3          	blt	s1,s3,198 <gets+0x24>
 1c6:	84d6                	mv	s1,s5
      break;
  }
  buf[i] = '\0';
 1c8:	94de                	add	s1,s1,s7
 1ca:	00048023          	sb	zero,0(s1)
  return buf;
}
 1ce:	60e6                	ld	ra,88(sp)
 1d0:	6446                	ld	s0,80(sp)
 1d2:	64a6                	ld	s1,72(sp)
 1d4:	6906                	ld	s2,64(sp)
 1d6:	79e2                	ld	s3,56(sp)
 1d8:	7a42                	ld	s4,48(sp)
 1da:	7aa2                	ld	s5,40(sp)
 1dc:	7b02                	ld	s6,32(sp)
 1de:	855e                	mv	a0,s7
 1e0:	6be2                	ld	s7,24(sp)
 1e2:	6125                	add	sp,sp,96
 1e4:	8082                	ret

00000000000001e6 <stat>:

int
stat(const char *n, struct stat *st)
{
 1e6:	1101                	add	sp,sp,-32
 1e8:	e822                	sd	s0,16(sp)
 1ea:	e04a                	sd	s2,0(sp)
 1ec:	ec06                	sd	ra,24(sp)
 1ee:	e426                	sd	s1,8(sp)
 1f0:	1000                	add	s0,sp,32
 1f2:	892e                	mv	s2,a1
  int fd;
  int r;

  fd = open(n, O_RDONLY);
 1f4:	4581                	li	a1,0
 1f6:	00000097          	auipc	ra,0x0
 1fa:	1c4080e7          	jalr	452(ra) # 3ba <open>
  if(fd < 0)
 1fe:	02054663          	bltz	a0,22a <stat+0x44>
    return -1;
  r = fstat(fd, st);
 202:	85ca                	mv	a1,s2
 204:	84aa                	mv	s1,a0
 206:	00000097          	auipc	ra,0x0
 20a:	1cc080e7          	jalr	460(ra) # 3d2 <fstat>
 20e:	87aa                	mv	a5,a0
  close(fd);
 210:	8526                	mv	a0,s1
  r = fstat(fd, st);
 212:	84be                	mv	s1,a5
  close(fd);
 214:	00000097          	auipc	ra,0x0
 218:	18e080e7          	jalr	398(ra) # 3a2 <close>
  return r;
}
 21c:	60e2                	ld	ra,24(sp)
 21e:	6442                	ld	s0,16(sp)
 220:	6902                	ld	s2,0(sp)
 222:	8526                	mv	a0,s1
 224:	64a2                	ld	s1,8(sp)
 226:	6105                	add	sp,sp,32
 228:	8082                	ret
    return -1;
 22a:	54fd                	li	s1,-1
 22c:	bfc5                	j	21c <stat+0x36>

000000000000022e <atoi>:

int
atoi(const char *s)
{
 22e:	1141                	add	sp,sp,-16
 230:	e422                	sd	s0,8(sp)
 232:	0800                	add	s0,sp,16
  int n;

  n = 0;
  while('0' <= *s && *s <= '9')
 234:	00054683          	lbu	a3,0(a0)
 238:	4625                	li	a2,9
 23a:	fd06879b          	addw	a5,a3,-48
 23e:	0ff7f793          	zext.b	a5,a5
 242:	02f66863          	bltu	a2,a5,272 <atoi+0x44>
 246:	872a                	mv	a4,a0
  n = 0;
 248:	4501                	li	a0,0
    n = n*10 + *s++ - '0';
 24a:	0025179b          	sllw	a5,a0,0x2
 24e:	9fa9                	addw	a5,a5,a0
 250:	0705                	add	a4,a4,1
 252:	0017979b          	sllw	a5,a5,0x1
 256:	9fb5                	addw	a5,a5,a3
  while('0' <= *s && *s <= '9')
 258:	00074683          	lbu	a3,0(a4)
    n = n*10 + *s++ - '0';
 25c:	fd07851b          	addw	a0,a5,-48
  while('0' <= *s && *s <= '9')
 260:	fd06879b          	addw	a5,a3,-48
 264:	0ff7f793          	zext.b	a5,a5
 268:	fef671e3          	bgeu	a2,a5,24a <atoi+0x1c>
  return n;
}
 26c:	6422                	ld	s0,8(sp)
 26e:	0141                	add	sp,sp,16
 270:	8082                	ret
 272:	6422                	ld	s0,8(sp)
  n = 0;
 274:	4501                	li	a0,0
}
 276:	0141                	add	sp,sp,16
 278:	8082                	ret

000000000000027a <memmove>:

void*
memmove(void *vdst, const void *vsrc, int n)
{
 27a:	1141                	add	sp,sp,-16
 27c:	e422                	sd	s0,8(sp)
 27e:	0800                	add	s0,sp,16
  char *dst;
  const char *src;

  dst = vdst;
  src = vsrc;
  if (src > dst) {
 280:	02b57463          	bgeu	a0,a1,2a8 <memmove+0x2e>
    while(n-- > 0)
 284:	00c05f63          	blez	a2,2a2 <memmove+0x28>
 288:	1602                	sll	a2,a2,0x20
 28a:	9201                	srl	a2,a2,0x20
 28c:	00c507b3          	add	a5,a0,a2
  dst = vdst;
 290:	872a                	mv	a4,a0
      *dst++ = *src++;
 292:	0005c683          	lbu	a3,0(a1)
 296:	0705                	add	a4,a4,1
 298:	0585                	add	a1,a1,1
 29a:	fed70fa3          	sb	a3,-1(a4)
    while(n-- > 0)
 29e:	fef71ae3          	bne	a4,a5,292 <memmove+0x18>
    src += n;
    while(n-- > 0)
      *--dst = *--src;
  }
  return vdst;
}
 2a2:	6422                	ld	s0,8(sp)
 2a4:	0141                	add	sp,sp,16
 2a6:	8082                	ret
    dst += n;
 2a8:	00c50733          	add	a4,a0,a2
    src += n;
 2ac:	95b2                	add	a1,a1,a2
    while(n-- > 0)
 2ae:	fec05ae3          	blez	a2,2a2 <memmove+0x28>
 2b2:	fff6079b          	addw	a5,a2,-1
 2b6:	1782                	sll	a5,a5,0x20
 2b8:	9381                	srl	a5,a5,0x20
 2ba:	fff7c793          	not	a5,a5
 2be:	97ae                	add	a5,a5,a1
      *--dst = *--src;
 2c0:	fff5c683          	lbu	a3,-1(a1)
 2c4:	15fd                	add	a1,a1,-1
 2c6:	177d                	add	a4,a4,-1
 2c8:	00d70023          	sb	a3,0(a4)
    while(n-- > 0)
 2cc:	feb79ae3          	bne	a5,a1,2c0 <memmove+0x46>
}
 2d0:	6422                	ld	s0,8(sp)
 2d2:	0141                	add	sp,sp,16
 2d4:	8082                	ret

00000000000002d6 <memcmp>:

int
memcmp(const void *s1, const void *s2, uint n)
{
 2d6:	1141                	add	sp,sp,-16
 2d8:	e422                	sd	s0,8(sp)
 2da:	0800                	add	s0,sp,16
  const char *p1 = s1, *p2 = s2;
  while (n-- > 0) {
 2dc:	c61d                	beqz	a2,30a <memcmp+0x34>
 2de:	fff6069b          	addw	a3,a2,-1
 2e2:	1682                	sll	a3,a3,0x20
 2e4:	9281                	srl	a3,a3,0x20
 2e6:	0685                	add	a3,a3,1
 2e8:	96aa                	add	a3,a3,a0
 2ea:	a019                	j	2f0 <memcmp+0x1a>
 2ec:	00a68f63          	beq	a3,a0,30a <memcmp+0x34>
    if (*p1 != *p2) {
 2f0:	00054783          	lbu	a5,0(a0)
 2f4:	0005c703          	lbu	a4,0(a1)
      return *p1 - *p2;
    }
    p1++;
 2f8:	0505                	add	a0,a0,1
    p2++;
 2fa:	0585                	add	a1,a1,1
    if (*p1 != *p2) {
 2fc:	fee788e3          	beq	a5,a4,2ec <memcmp+0x16>
  }
  return 0;
}
 300:	6422                	ld	s0,8(sp)
      return *p1 - *p2;
 302:	40e7853b          	subw	a0,a5,a4
}
 306:	0141                	add	sp,sp,16
 308:	8082                	ret
 30a:	6422                	ld	s0,8(sp)
  return 0;
 30c:	4501                	li	a0,0
}
 30e:	0141                	add	sp,sp,16
 310:	8082                	ret

0000000000000312 <memcpy>:

void *
memcpy(void *dst, const void *src, uint n)
{
 312:	1141                	add	sp,sp,-16
 314:	e422                	sd	s0,8(sp)
 316:	0800                	add	s0,sp,16
  return memmove(dst, src, n);
 318:	0006079b          	sext.w	a5,a2
  if (src > dst) {
 31c:	02b57463          	bgeu	a0,a1,344 <memcpy+0x32>
    while(n-- > 0)
 320:	00f05f63          	blez	a5,33e <memcpy+0x2c>
 324:	1602                	sll	a2,a2,0x20
 326:	9201                	srl	a2,a2,0x20
 328:	00c587b3          	add	a5,a1,a2
  dst = vdst;
 32c:	872a                	mv	a4,a0
      *dst++ = *src++;
 32e:	0005c683          	lbu	a3,0(a1)
 332:	0585                	add	a1,a1,1
 334:	0705                	add	a4,a4,1
 336:	fed70fa3          	sb	a3,-1(a4)
    while(n-- > 0)
 33a:	fef59ae3          	bne	a1,a5,32e <memcpy+0x1c>
}
 33e:	6422                	ld	s0,8(sp)
 340:	0141                	add	sp,sp,16
 342:	8082                	ret
    dst += n;
 344:	00f50733          	add	a4,a0,a5
    src += n;
 348:	95be                	add	a1,a1,a5
    while(n-- > 0)
 34a:	fef05ae3          	blez	a5,33e <memcpy+0x2c>
 34e:	fff6079b          	addw	a5,a2,-1
 352:	1782                	sll	a5,a5,0x20
 354:	9381                	srl	a5,a5,0x20
 356:	fff7c793          	not	a5,a5
 35a:	97ae                	add	a5,a5,a1
      *--dst = *--src;
 35c:	fff5c683          	lbu	a3,-1(a1)
 360:	15fd                	add	a1,a1,-1
 362:	177d                	add	a4,a4,-1
 364:	00d70023          	sb	a3,0(a4)
    while(n-- > 0)
 368:	fef59ae3          	bne	a1,a5,35c <memcpy+0x4a>
}
 36c:	6422                	ld	s0,8(sp)
 36e:	0141                	add	sp,sp,16
 370:	8082                	ret

0000000000000372 <fork>:
# generated by usys.pl - do not edit
#include "kern/syscall.h"
.global fork
fork:
 li a7, SYS_fork
 372:	4885                	li	a7,1
 ecall
 374:	00000073          	ecall
 ret
 378:	8082                	ret

000000000000037a <exit>:
.global exit
exit:
 li a7, SYS_exit
 37a:	4889                	li	a7,2
 ecall
 37c:	00000073          	ecall
 ret
 380:	8082                	ret

0000000000000382 <wait>:
.global wait
wait:
 li a7, SYS_wait
 382:	488d                	li	a7,3
 ecall
 384:	00000073          	ecall
 ret
 388:	8082                	ret

000000000000038a <pipe>:
.global pipe
pipe:
 li a7, SYS_pipe
 38a:	4891                	li	a7,4
 ecall
 38c:	00000073          	ecall
 ret
 390:	8082                	ret

0000000000000392 <read>:
.global read
read:
 li a7, SYS_read
 392:	4895                	li	a7,5
 ecall
 394:	00000073          	ecall
 ret
 398:	8082                	ret

000000000000039a <write>:
.global write
write:
 li a7, SYS_write
 39a:	48c1                	li	a7,16
 ecall
 39c:	00000073          	ecall
 ret
 3a0:	8082                	ret

00000000000003a2 <close>:
.global close
close:
 li a7, SYS_close
 3a2:	48d5                	li	a7,21
 ecall
 3a4:	00000073          	ecall
 ret
 3a8:	8082                	ret

00000000000003aa <kill>:
.global kill
kill:
 li a7, SYS_kill
 3aa:	4899                	li	a7,6
 ecall
 3ac:	00000073          	ecall
 ret
 3b0:	8082                	ret

00000000000003b2 <exec>:
.global exec
exec:
 li a7, SYS_exec
 3b2:	489d                	li	a7,7
 ecall
 3b4:	00000073          	ecall
 ret
 3b8:	8082                	ret

00000000000003ba <open>:
.global open
open:
 li a7, SYS_open
 3ba:	48bd                	li	a7,15
 ecall
 3bc:	00000073          	ecall
 ret
 3c0:	8082                	ret

00000000000003c2 <mknod>:
.global mknod
mknod:
 li a7, SYS_mknod
 3c2:	48c5                	li	a7,17
 ecall
 3c4:	00000073          	ecall
 ret
 3c8:	8082                	ret

00000000000003ca <unlink>:
.global unlink
unlink:
 li a7, SYS_unlink
 3ca:	48c9                	li	a7,18
 ecall
 3cc:	00000073          	ecall
 ret
 3d0:	8082                	ret

00000000000003d2 <fstat>:
.global fstat
fstat:
 li a7, SYS_fstat
 3d2:	48a1                	li	a7,8
 ecall
 3d4:	00000073          	ecall
 ret
 3d8:	8082                	ret

00000000000003da <link>:
.global link
link:
 li a7, SYS_link
 3da:	48cd                	li	a7,19
 ecall
 3dc:	00000073          	ecall
 ret
 3e0:	8082                	ret

00000000000003e2 <mkdir>:
.global mkdir
mkdir:
 li a7, SYS_mkdir
 3e2:	48d1                	li	a7,20
 ecall
 3e4:	00000073          	ecall
 ret
 3e8:	8082                	ret

00000000000003ea <chdir>:
.global chdir
chdir:
 li a7, SYS_chdir
 3ea:	48a5                	li	a7,9
 ecall
 3ec:	00000073          	ecall
 ret
 3f0:	8082                	ret

00000000000003f2 <dup>:
.global dup
dup:
 li a7, SYS_dup
 3f2:	48a9                	li	a7,10
 ecall
 3f4:	00000073          	ecall
 ret
 3f8:	8082                	ret

00000000000003fa <getpid>:
.global getpid
getpid:
 li a7, SYS_getpid
 3fa:	48ad                	li	a7,11
 ecall
 3fc:	00000073          	ecall
 ret
 400:	8082                	ret

0000000000000402 <sbrk>:
.global sbrk
sbrk:
 li a7, SYS_sbrk
 402:	48b1                	li	a7,12
 ecall
 404:	00000073          	ecall
 ret
 408:	8082                	ret

000000000000040a <sleep>:
.global sleep
sleep:
 li a7, SYS_sleep
 40a:	48b5                	li	a7,13
 ecall
 40c:	00000073          	ecall
 ret
 410:	8082                	ret

0000000000000412 <uptime>:
.global uptime
uptime:
 li a7, SYS_uptime
 412:	48b9                	li	a7,14
 ecall
 414:	00000073          	ecall
 ret
 418:	8082                	ret

000000000000041a <poweroff>:
.global poweroff
poweroff:
 li a7, SYS_poweroff
 41a:	48d9                	li	a7,22
 ecall
 41c:	00000073          	ecall
 ret
 420:	8082                	ret

0000000000000422 <printint>:
  write(fd, &c, 1);
}

static void
printint(int fd, int xx, int base, int sgn)
{
 422:	715d                	add	sp,sp,-80
 424:	e0a2                	sd	s0,64(sp)
 426:	f84a                	sd	s2,48(sp)
 428:	e486                	sd	ra,72(sp)
 42a:	fc26                	sd	s1,56(sp)
 42c:	f44e                	sd	s3,40(sp)
 42e:	0880                	add	s0,sp,80
 430:	892a                	mv	s2,a0
  char buf[16];
  int i, neg;
  uint x;

  neg = 0;
  if(sgn && xx < 0){
 432:	c299                	beqz	a3,438 <printint+0x16>
 434:	0805c263          	bltz	a1,4b8 <printint+0x96>
    neg = 1;
    x = -xx;
  } else {
    x = xx;
 438:	2581                	sext.w	a1,a1
  neg = 0;
 43a:	4681                	li	a3,0
  }

  i = 0;
  do{
    buf[i++] = digits[x % base];
 43c:	2601                	sext.w	a2,a2
 43e:	fc040713          	add	a4,s0,-64
  i = 0;
 442:	4501                	li	a0,0
 444:	00000897          	auipc	a7,0x0
 448:	4cc88893          	add	a7,a7,1228 # 910 <digits>
    buf[i++] = digits[x % base];
 44c:	02c5f7bb          	remuw	a5,a1,a2
  }while((x /= base) != 0);
 450:	0705                	add	a4,a4,1
 452:	0005881b          	sext.w	a6,a1
 456:	84aa                	mv	s1,a0
    buf[i++] = digits[x % base];
 458:	2505                	addw	a0,a0,1
 45a:	1782                	sll	a5,a5,0x20
 45c:	9381                	srl	a5,a5,0x20
 45e:	97c6                	add	a5,a5,a7
 460:	0007c783          	lbu	a5,0(a5)
  }while((x /= base) != 0);
 464:	02c5d5bb          	divuw	a1,a1,a2
    buf[i++] = digits[x % base];
 468:	fef70fa3          	sb	a5,-1(a4)
  }while((x /= base) != 0);
 46c:	fec870e3          	bgeu	a6,a2,44c <printint+0x2a>
  if(neg)
 470:	ca89                	beqz	a3,482 <printint+0x60>
    buf[i++] = '-';
 472:	fd050793          	add	a5,a0,-48
 476:	97a2                	add	a5,a5,s0
 478:	02d00713          	li	a4,45
 47c:	fee78823          	sb	a4,-16(a5)

  while(--i >= 0)
 480:	84aa                	mv	s1,a0
 482:	fc040793          	add	a5,s0,-64
 486:	94be                	add	s1,s1,a5
 488:	fff78993          	add	s3,a5,-1
    putc(fd, buf[i]);
 48c:	0004c783          	lbu	a5,0(s1)
  write(fd, &c, 1);
 490:	4605                	li	a2,1
 492:	fbf40593          	add	a1,s0,-65
 496:	854a                	mv	a0,s2
  while(--i >= 0)
 498:	14fd                	add	s1,s1,-1
 49a:	faf40fa3          	sb	a5,-65(s0)
  write(fd, &c, 1);
 49e:	00000097          	auipc	ra,0x0
 4a2:	efc080e7          	jalr	-260(ra) # 39a <write>
  while(--i >= 0)
 4a6:	ff3493e3          	bne	s1,s3,48c <printint+0x6a>
}
 4aa:	60a6                	ld	ra,72(sp)
 4ac:	6406                	ld	s0,64(sp)
 4ae:	74e2                	ld	s1,56(sp)
 4b0:	7942                	ld	s2,48(sp)
 4b2:	79a2                	ld	s3,40(sp)
 4b4:	6161                	add	sp,sp,80
 4b6:	8082                	ret
    x = -xx;
 4b8:	40b005bb          	negw	a1,a1
 4bc:	b741                	j	43c <printint+0x1a>

00000000000004be <vprintf>:
}

// Print to the given fd. Only understands %d, %x, %p, %s.
void
vprintf(int fd, const char *fmt, va_list ap)
{
 4be:	7159                	add	sp,sp,-112
 4c0:	f0a2                	sd	s0,96(sp)
 4c2:	f486                	sd	ra,104(sp)
 4c4:	e8ca                	sd	s2,80(sp)
 4c6:	1880                	add	s0,sp,112
  char *s;
  int c, i, state;

  state = 0;
  for(i = 0; fmt[i]; i++){
 4c8:	0005c903          	lbu	s2,0(a1)
 4cc:	04090f63          	beqz	s2,52a <vprintf+0x6c>
 4d0:	eca6                	sd	s1,88(sp)
 4d2:	e4ce                	sd	s3,72(sp)
 4d4:	e0d2                	sd	s4,64(sp)
 4d6:	fc56                	sd	s5,56(sp)
 4d8:	f85a                	sd	s6,48(sp)
 4da:	f45e                	sd	s7,40(sp)
 4dc:	f062                	sd	s8,32(sp)
 4de:	8a2a                	mv	s4,a0
 4e0:	8c32                	mv	s8,a2
 4e2:	00158493          	add	s1,a1,1
 4e6:	4981                	li	s3,0
      if(c == '%'){
        state = '%';
      } else {
        putc(fd, c);
      }
    } else if(state == '%'){
 4e8:	02500a93          	li	s5,37
 4ec:	4bd5                	li	s7,21
 4ee:	00000b17          	auipc	s6,0x0
 4f2:	3cab0b13          	add	s6,s6,970 # 8b8 <malloc+0x114>
    if(state == 0){
 4f6:	02099f63          	bnez	s3,534 <vprintf+0x76>
      if(c == '%'){
 4fa:	05590c63          	beq	s2,s5,552 <vprintf+0x94>
  write(fd, &c, 1);
 4fe:	4605                	li	a2,1
 500:	f9f40593          	add	a1,s0,-97
 504:	8552                	mv	a0,s4
 506:	f9240fa3          	sb	s2,-97(s0)
 50a:	00000097          	auipc	ra,0x0
 50e:	e90080e7          	jalr	-368(ra) # 39a <write>
  for(i = 0; fmt[i]; i++){
 512:	0004c903          	lbu	s2,0(s1)
 516:	0485                	add	s1,s1,1
 518:	fc091fe3          	bnez	s2,4f6 <vprintf+0x38>
 51c:	64e6                	ld	s1,88(sp)
 51e:	69a6                	ld	s3,72(sp)
 520:	6a06                	ld	s4,64(sp)
 522:	7ae2                	ld	s5,56(sp)
 524:	7b42                	ld	s6,48(sp)
 526:	7ba2                	ld	s7,40(sp)
 528:	7c02                	ld	s8,32(sp)
        putc(fd, c);
      }
      state = 0;
    }
  }
}
 52a:	70a6                	ld	ra,104(sp)
 52c:	7406                	ld	s0,96(sp)
 52e:	6946                	ld	s2,80(sp)
 530:	6165                	add	sp,sp,112
 532:	8082                	ret
    } else if(state == '%'){
 534:	fd599fe3          	bne	s3,s5,512 <vprintf+0x54>
      if(c == 'd'){
 538:	15590463          	beq	s2,s5,680 <vprintf+0x1c2>
 53c:	f9d9079b          	addw	a5,s2,-99
 540:	0ff7f793          	zext.b	a5,a5
 544:	00fbea63          	bltu	s7,a5,558 <vprintf+0x9a>
 548:	078a                	sll	a5,a5,0x2
 54a:	97da                	add	a5,a5,s6
 54c:	439c                	lw	a5,0(a5)
 54e:	97da                	add	a5,a5,s6
 550:	8782                	jr	a5
        state = '%';
 552:	02500993          	li	s3,37
 556:	bf75                	j	512 <vprintf+0x54>
  write(fd, &c, 1);
 558:	f9f40993          	add	s3,s0,-97
 55c:	4605                	li	a2,1
 55e:	85ce                	mv	a1,s3
 560:	02500793          	li	a5,37
 564:	8552                	mv	a0,s4
 566:	f8f40fa3          	sb	a5,-97(s0)
 56a:	00000097          	auipc	ra,0x0
 56e:	e30080e7          	jalr	-464(ra) # 39a <write>
 572:	4605                	li	a2,1
 574:	85ce                	mv	a1,s3
 576:	8552                	mv	a0,s4
 578:	f9240fa3          	sb	s2,-97(s0)
 57c:	00000097          	auipc	ra,0x0
 580:	e1e080e7          	jalr	-482(ra) # 39a <write>
        while(*s != 0){
 584:	4981                	li	s3,0
 586:	b771                	j	512 <vprintf+0x54>
        putc(fd, va_arg(ap, uint));
 588:	000c2783          	lw	a5,0(s8)
  write(fd, &c, 1);
 58c:	4605                	li	a2,1
 58e:	f9f40593          	add	a1,s0,-97
 592:	8552                	mv	a0,s4
        putc(fd, va_arg(ap, uint));
 594:	f8f40fa3          	sb	a5,-97(s0)
 598:	0c21                	add	s8,s8,8
  write(fd, &c, 1);
 59a:	00000097          	auipc	ra,0x0
 59e:	e00080e7          	jalr	-512(ra) # 39a <write>
 5a2:	4981                	li	s3,0
 5a4:	b7bd                	j	512 <vprintf+0x54>
        printint(fd, va_arg(ap, int), 10, 1);
 5a6:	000c2583          	lw	a1,0(s8)
 5aa:	4685                	li	a3,1
        printint(fd, va_arg(ap, uint64), 10, 0);
 5ac:	4629                	li	a2,10
 5ae:	8552                	mv	a0,s4
 5b0:	0c21                	add	s8,s8,8
 5b2:	00000097          	auipc	ra,0x0
 5b6:	e70080e7          	jalr	-400(ra) # 422 <printint>
 5ba:	4981                	li	s3,0
 5bc:	bf99                	j	512 <vprintf+0x54>
 5be:	000c2583          	lw	a1,0(s8)
 5c2:	4681                	li	a3,0
 5c4:	b7e5                	j	5ac <vprintf+0xee>
  write(fd, &c, 1);
 5c6:	f9f40993          	add	s3,s0,-97
 5ca:	03000793          	li	a5,48
 5ce:	4605                	li	a2,1
 5d0:	85ce                	mv	a1,s3
 5d2:	8552                	mv	a0,s4
 5d4:	ec66                	sd	s9,24(sp)
 5d6:	e86a                	sd	s10,16(sp)
        printptr(fd, va_arg(ap, uint64));
 5d8:	f8f40fa3          	sb	a5,-97(s0)
 5dc:	000c3d03          	ld	s10,0(s8)
  write(fd, &c, 1);
 5e0:	00000097          	auipc	ra,0x0
 5e4:	dba080e7          	jalr	-582(ra) # 39a <write>
 5e8:	07800793          	li	a5,120
 5ec:	4605                	li	a2,1
 5ee:	85ce                	mv	a1,s3
 5f0:	8552                	mv	a0,s4
 5f2:	f8f40fa3          	sb	a5,-97(s0)
        printptr(fd, va_arg(ap, uint64));
 5f6:	0c21                	add	s8,s8,8
  write(fd, &c, 1);
 5f8:	00000097          	auipc	ra,0x0
 5fc:	da2080e7          	jalr	-606(ra) # 39a <write>
  putc(fd, 'x');
 600:	4941                	li	s2,16
 602:	00000c97          	auipc	s9,0x0
 606:	30ec8c93          	add	s9,s9,782 # 910 <digits>
    putc(fd, digits[x >> (sizeof(uint64) * 8 - 4)]);
 60a:	03cd5793          	srl	a5,s10,0x3c
 60e:	97e6                	add	a5,a5,s9
 610:	0007c783          	lbu	a5,0(a5)
  write(fd, &c, 1);
 614:	4605                	li	a2,1
 616:	85ce                	mv	a1,s3
 618:	8552                	mv	a0,s4
  for (i = 0; i < (sizeof(uint64) * 2); i++, x <<= 4)
 61a:	397d                	addw	s2,s2,-1
 61c:	f8f40fa3          	sb	a5,-97(s0)
 620:	0d12                	sll	s10,s10,0x4
  write(fd, &c, 1);
 622:	00000097          	auipc	ra,0x0
 626:	d78080e7          	jalr	-648(ra) # 39a <write>
  for (i = 0; i < (sizeof(uint64) * 2); i++, x <<= 4)
 62a:	fe0910e3          	bnez	s2,60a <vprintf+0x14c>
 62e:	6ce2                	ld	s9,24(sp)
 630:	6d42                	ld	s10,16(sp)
 632:	4981                	li	s3,0
 634:	bdf9                	j	512 <vprintf+0x54>
        s = va_arg(ap, char*);
 636:	000c3903          	ld	s2,0(s8)
 63a:	0c21                	add	s8,s8,8
        if(s == 0)
 63c:	04090e63          	beqz	s2,698 <vprintf+0x1da>
        while(*s != 0){
 640:	00094783          	lbu	a5,0(s2)
 644:	d3a1                	beqz	a5,584 <vprintf+0xc6>
 646:	f9f40993          	add	s3,s0,-97
  write(fd, &c, 1);
 64a:	4605                	li	a2,1
 64c:	85ce                	mv	a1,s3
 64e:	8552                	mv	a0,s4
 650:	f8f40fa3          	sb	a5,-97(s0)
 654:	00000097          	auipc	ra,0x0
 658:	d46080e7          	jalr	-698(ra) # 39a <write>
        while(*s != 0){
 65c:	00194783          	lbu	a5,1(s2)
          s++;
 660:	0905                	add	s2,s2,1
        while(*s != 0){
 662:	f7e5                	bnez	a5,64a <vprintf+0x18c>
 664:	4981                	li	s3,0
 666:	b575                	j	512 <vprintf+0x54>
        printint(fd, va_arg(ap, int), 16, 0);
 668:	000c2583          	lw	a1,0(s8)
 66c:	4681                	li	a3,0
 66e:	4641                	li	a2,16
 670:	8552                	mv	a0,s4
 672:	0c21                	add	s8,s8,8
 674:	00000097          	auipc	ra,0x0
 678:	dae080e7          	jalr	-594(ra) # 422 <printint>
 67c:	4981                	li	s3,0
 67e:	bd51                	j	512 <vprintf+0x54>
  write(fd, &c, 1);
 680:	4605                	li	a2,1
 682:	f9f40593          	add	a1,s0,-97
 686:	8552                	mv	a0,s4
 688:	f9540fa3          	sb	s5,-97(s0)
        while(*s != 0){
 68c:	4981                	li	s3,0
  write(fd, &c, 1);
 68e:	00000097          	auipc	ra,0x0
 692:	d0c080e7          	jalr	-756(ra) # 39a <write>
 696:	bdb5                	j	512 <vprintf+0x54>
          s = "(null)";
 698:	00000917          	auipc	s2,0x0
 69c:	21890913          	add	s2,s2,536 # 8b0 <malloc+0x10c>
 6a0:	02800793          	li	a5,40
 6a4:	b74d                	j	646 <vprintf+0x188>

00000000000006a6 <fprintf>:

void
fprintf(int fd, const char *fmt, ...)
{
 6a6:	715d                	add	sp,sp,-80
 6a8:	e822                	sd	s0,16(sp)
 6aa:	ec06                	sd	ra,24(sp)
 6ac:	1000                	add	s0,sp,32
 6ae:	e010                	sd	a2,0(s0)
  va_list ap;

  va_start(ap, fmt);
  vprintf(fd, fmt, ap);
 6b0:	8622                	mv	a2,s0
{
 6b2:	e414                	sd	a3,8(s0)
 6b4:	e818                	sd	a4,16(s0)
 6b6:	ec1c                	sd	a5,24(s0)
 6b8:	03043023          	sd	a6,32(s0)
 6bc:	03143423          	sd	a7,40(s0)
  va_start(ap, fmt);
 6c0:	fe843423          	sd	s0,-24(s0)
  vprintf(fd, fmt, ap);
 6c4:	00000097          	auipc	ra,0x0
 6c8:	dfa080e7          	jalr	-518(ra) # 4be <vprintf>
}
 6cc:	60e2                	ld	ra,24(sp)
 6ce:	6442                	ld	s0,16(sp)
 6d0:	6161                	add	sp,sp,80
 6d2:	8082                	ret

00000000000006d4 <printf>:

void
printf(const char *fmt, ...)
{
 6d4:	711d                	add	sp,sp,-96
 6d6:	e822                	sd	s0,16(sp)
 6d8:	ec06                	sd	ra,24(sp)
 6da:	1000                	add	s0,sp,32
  va_list ap;

  va_start(ap, fmt);
 6dc:	00840313          	add	t1,s0,8
{
 6e0:	e40c                	sd	a1,8(s0)
 6e2:	e810                	sd	a2,16(s0)
  vprintf(1, fmt, ap);
 6e4:	85aa                	mv	a1,a0
 6e6:	861a                	mv	a2,t1
 6e8:	4505                	li	a0,1
{
 6ea:	ec14                	sd	a3,24(s0)
 6ec:	f018                	sd	a4,32(s0)
 6ee:	f41c                	sd	a5,40(s0)
 6f0:	03043823          	sd	a6,48(s0)
 6f4:	03143c23          	sd	a7,56(s0)
  va_start(ap, fmt);
 6f8:	fe643423          	sd	t1,-24(s0)
  vprintf(1, fmt, ap);
 6fc:	00000097          	auipc	ra,0x0
 700:	dc2080e7          	jalr	-574(ra) # 4be <vprintf>
}
 704:	60e2                	ld	ra,24(sp)
 706:	6442                	ld	s0,16(sp)
 708:	6125                	add	sp,sp,96
 70a:	8082                	ret

000000000000070c <free>:
static Header base;
static Header *freep;

void
free(void *ap)
{
 70c:	1141                	add	sp,sp,-16
 70e:	e422                	sd	s0,8(sp)
 710:	0800                	add	s0,sp,16
  Header *bp, *p;

  bp = (Header*)ap - 1;
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 712:	00001597          	auipc	a1,0x1
 716:	8ee58593          	add	a1,a1,-1810 # 1000 <freep>
 71a:	619c                	ld	a5,0(a1)
  bp = (Header*)ap - 1;
 71c:	ff050693          	add	a3,a0,-16
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 720:	6398                	ld	a4,0(a5)
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 722:	02d7ff63          	bgeu	a5,a3,760 <free+0x54>
 726:	00e6e463          	bltu	a3,a4,72e <free+0x22>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 72a:	02e7ef63          	bltu	a5,a4,768 <free+0x5c>
      break;
  if(bp + bp->s.size == p->s.ptr){
 72e:	ff852803          	lw	a6,-8(a0)
 732:	02081893          	sll	a7,a6,0x20
 736:	01c8d613          	srl	a2,a7,0x1c
 73a:	9636                	add	a2,a2,a3
 73c:	02c70863          	beq	a4,a2,76c <free+0x60>
    bp->s.size += p->s.ptr->s.size;
    bp->s.ptr = p->s.ptr->s.ptr;
  } else
    bp->s.ptr = p->s.ptr;
  if(p + p->s.size == bp){
 740:	0087a803          	lw	a6,8(a5)
 744:	fee53823          	sd	a4,-16(a0)
 748:	02081893          	sll	a7,a6,0x20
 74c:	01c8d613          	srl	a2,a7,0x1c
 750:	963e                	add	a2,a2,a5
 752:	02c68e63          	beq	a3,a2,78e <free+0x82>
    p->s.size += bp->s.size;
    p->s.ptr = bp->s.ptr;
  } else
    p->s.ptr = bp;
  freep = p;
}
 756:	6422                	ld	s0,8(sp)
 758:	e394                	sd	a3,0(a5)
  freep = p;
 75a:	e19c                	sd	a5,0(a1)
}
 75c:	0141                	add	sp,sp,16
 75e:	8082                	ret
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 760:	00e7e463          	bltu	a5,a4,768 <free+0x5c>
 764:	fce6e5e3          	bltu	a3,a4,72e <free+0x22>
{
 768:	87ba                	mv	a5,a4
 76a:	bf5d                	j	720 <free+0x14>
    bp->s.size += p->s.ptr->s.size;
 76c:	4710                	lw	a2,8(a4)
    bp->s.ptr = p->s.ptr->s.ptr;
 76e:	6318                	ld	a4,0(a4)
    bp->s.size += p->s.ptr->s.size;
 770:	0106063b          	addw	a2,a2,a6
 774:	fec52c23          	sw	a2,-8(a0)
  if(p + p->s.size == bp){
 778:	0087a803          	lw	a6,8(a5)
 77c:	fee53823          	sd	a4,-16(a0)
 780:	02081893          	sll	a7,a6,0x20
 784:	01c8d613          	srl	a2,a7,0x1c
 788:	963e                	add	a2,a2,a5
 78a:	fcc696e3          	bne	a3,a2,756 <free+0x4a>
    p->s.size += bp->s.size;
 78e:	ff852603          	lw	a2,-8(a0)
}
 792:	6422                	ld	s0,8(sp)
    p->s.ptr = bp->s.ptr;
 794:	86ba                	mv	a3,a4
    p->s.size += bp->s.size;
 796:	0106073b          	addw	a4,a2,a6
 79a:	c798                	sw	a4,8(a5)
    p->s.ptr = bp->s.ptr;
 79c:	e394                	sd	a3,0(a5)
  freep = p;
 79e:	e19c                	sd	a5,0(a1)
}
 7a0:	0141                	add	sp,sp,16
 7a2:	8082                	ret

00000000000007a4 <malloc>:
  return freep;
}

void*
malloc(uint nbytes)
{
 7a4:	7139                	add	sp,sp,-64
 7a6:	f822                	sd	s0,48(sp)
 7a8:	f426                	sd	s1,40(sp)
 7aa:	f04a                	sd	s2,32(sp)
 7ac:	ec4e                	sd	s3,24(sp)
 7ae:	fc06                	sd	ra,56(sp)
 7b0:	0080                	add	s0,sp,64
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
  if((prevp = freep) == 0){
 7b2:	00001917          	auipc	s2,0x1
 7b6:	84e90913          	add	s2,s2,-1970 # 1000 <freep>
  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
 7ba:	02051493          	sll	s1,a0,0x20
 7be:	9081                	srl	s1,s1,0x20
  if((prevp = freep) == 0){
 7c0:	00093783          	ld	a5,0(s2)
  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
 7c4:	04bd                	add	s1,s1,15
 7c6:	8091                	srl	s1,s1,0x4
 7c8:	0014899b          	addw	s3,s1,1
 7cc:	0485                	add	s1,s1,1
  if((prevp = freep) == 0){
 7ce:	c3dd                	beqz	a5,874 <malloc+0xd0>
    base.s.ptr = freep = prevp = &base;
    base.s.size = 0;
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 7d0:	6388                	ld	a0,0(a5)
    if(p->s.size >= nunits){
 7d2:	4518                	lw	a4,8(a0)
 7d4:	06977863          	bgeu	a4,s1,844 <malloc+0xa0>
 7d8:	e852                	sd	s4,16(sp)
 7da:	e456                	sd	s5,8(sp)
 7dc:	e05a                	sd	s6,0(sp)
  if(nu < 4096)
 7de:	6785                	lui	a5,0x1
 7e0:	8a4e                	mv	s4,s3
 7e2:	08f4e763          	bltu	s1,a5,870 <malloc+0xcc>
 7e6:	000a0b1b          	sext.w	s6,s4
  if(p == (char*)-1)
 7ea:	5afd                	li	s5,-1
  p = sbrk(nu * sizeof(Header));
 7ec:	004a1a1b          	sllw	s4,s4,0x4
 7f0:	a029                	j	7fa <malloc+0x56>
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 7f2:	6388                	ld	a0,0(a5)
    if(p->s.size >= nunits){
 7f4:	4518                	lw	a4,8(a0)
 7f6:	04977463          	bgeu	a4,s1,83e <malloc+0x9a>
        p->s.size = nunits;
      }
      freep = prevp;
      return (void*)(p + 1);
    }
    if(p == freep)
 7fa:	00093703          	ld	a4,0(s2)
 7fe:	87aa                	mv	a5,a0
 800:	fee519e3          	bne	a0,a4,7f2 <malloc+0x4e>
  p = sbrk(nu * sizeof(Header));
 804:	8552                	mv	a0,s4
 806:	00000097          	auipc	ra,0x0
 80a:	bfc080e7          	jalr	-1028(ra) # 402 <sbrk>
 80e:	87aa                	mv	a5,a0
  free((void*)(hp + 1));
 810:	0541                	add	a0,a0,16
  if(p == (char*)-1)
 812:	01578b63          	beq	a5,s5,828 <malloc+0x84>
  hp->s.size = nu;
 816:	0167a423          	sw	s6,8(a5) # 1008 <freep+0x8>
  free((void*)(hp + 1));
 81a:	00000097          	auipc	ra,0x0
 81e:	ef2080e7          	jalr	-270(ra) # 70c <free>
  return freep;
 822:	00093783          	ld	a5,0(s2)
      if((p = morecore(nunits)) == 0)
 826:	f7f1                	bnez	a5,7f2 <malloc+0x4e>
        return 0;
  }
}
 828:	70e2                	ld	ra,56(sp)
 82a:	7442                	ld	s0,48(sp)
        return 0;
 82c:	6a42                	ld	s4,16(sp)
 82e:	6aa2                	ld	s5,8(sp)
 830:	6b02                	ld	s6,0(sp)
}
 832:	74a2                	ld	s1,40(sp)
 834:	7902                	ld	s2,32(sp)
 836:	69e2                	ld	s3,24(sp)
        return 0;
 838:	4501                	li	a0,0
}
 83a:	6121                	add	sp,sp,64
 83c:	8082                	ret
 83e:	6a42                	ld	s4,16(sp)
 840:	6aa2                	ld	s5,8(sp)
 842:	6b02                	ld	s6,0(sp)
      if(p->s.size == nunits)
 844:	04e48763          	beq	s1,a4,892 <malloc+0xee>
        p->s.size -= nunits;
 848:	4137073b          	subw	a4,a4,s3
        p += p->s.size;
 84c:	02071613          	sll	a2,a4,0x20
 850:	01c65693          	srl	a3,a2,0x1c
        p->s.size -= nunits;
 854:	c518                	sw	a4,8(a0)
        p += p->s.size;
 856:	9536                	add	a0,a0,a3
        p->s.size = nunits;
 858:	01352423          	sw	s3,8(a0)
}
 85c:	70e2                	ld	ra,56(sp)
 85e:	7442                	ld	s0,48(sp)
      freep = prevp;
 860:	00f93023          	sd	a5,0(s2)
}
 864:	74a2                	ld	s1,40(sp)
 866:	7902                	ld	s2,32(sp)
 868:	69e2                	ld	s3,24(sp)
      return (void*)(p + 1);
 86a:	0541                	add	a0,a0,16
}
 86c:	6121                	add	sp,sp,64
 86e:	8082                	ret
  if(nu < 4096)
 870:	6a05                	lui	s4,0x1
 872:	bf95                	j	7e6 <malloc+0x42>
 874:	e852                	sd	s4,16(sp)
 876:	e456                	sd	s5,8(sp)
 878:	e05a                	sd	s6,0(sp)
    base.s.ptr = freep = prevp = &base;
 87a:	00000517          	auipc	a0,0x0
 87e:	79650513          	add	a0,a0,1942 # 1010 <base>
 882:	00a93023          	sd	a0,0(s2)
 886:	e108                	sd	a0,0(a0)
    base.s.size = 0;
 888:	00000797          	auipc	a5,0x0
 88c:	7807a823          	sw	zero,1936(a5) # 1018 <base+0x8>
    if(p->s.size >= nunits){
 890:	b7b9                	j	7de <malloc+0x3a>
        prevp->s.ptr = p->s.ptr;
 892:	6118                	ld	a4,0(a0)
 894:	e398                	sd	a4,0(a5)
 896:	b7d9                	j	85c <malloc+0xb8>
