
user/_rm:     file format elf64-littleriscv


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
  int i;

  if(argc < 2){
   8:	4785                	li	a5,1
   a:	e426                	sd	s1,8(sp)
   c:	e04a                	sd	s2,0(sp)
   e:	04a7d763          	bge	a5,a0,5c <main+0x5c>
  12:	ffe5091b          	addw	s2,a0,-2
  16:	02091793          	sll	a5,s2,0x20
  1a:	01d7d913          	srl	s2,a5,0x1d
  1e:	01058793          	add	a5,a1,16
  22:	00858493          	add	s1,a1,8
  26:	993e                	add	s2,s2,a5
  28:	a021                	j	30 <main+0x30>
    fprintf(2, "Usage: rm files...\n");
    exit(1);
  }

  for(i = 1; i < argc; i++){
  2a:	04a1                	add	s1,s1,8
  2c:	03248363          	beq	s1,s2,52 <main+0x52>
    if(unlink(argv[i]) < 0){
  30:	6088                	ld	a0,0(s1)
  32:	00000097          	auipc	ra,0x0
  36:	38c080e7          	jalr	908(ra) # 3be <unlink>
  3a:	fe0558e3          	bgez	a0,2a <main+0x2a>
      fprintf(2, "rm: %s failed to delete\n", argv[i]);
  3e:	6090                	ld	a2,0(s1)
  40:	00001597          	auipc	a1,0x1
  44:	86858593          	add	a1,a1,-1944 # 8a8 <malloc+0x110>
  48:	4509                	li	a0,2
  4a:	00000097          	auipc	ra,0x0
  4e:	650080e7          	jalr	1616(ra) # 69a <fprintf>
      break;
    }
  }

  exit(0);
  52:	4501                	li	a0,0
  54:	00000097          	auipc	ra,0x0
  58:	31a080e7          	jalr	794(ra) # 36e <exit>
    fprintf(2, "Usage: rm files...\n");
  5c:	4509                	li	a0,2
  5e:	00001597          	auipc	a1,0x1
  62:	83258593          	add	a1,a1,-1998 # 890 <malloc+0xf8>
  66:	00000097          	auipc	ra,0x0
  6a:	634080e7          	jalr	1588(ra) # 69a <fprintf>
    exit(1);
  6e:	4505                	li	a0,1
  70:	00000097          	auipc	ra,0x0
  74:	2fe080e7          	jalr	766(ra) # 36e <exit>

0000000000000078 <_main>:
//
// wrapper so that it's OK if main() does not call exit().
//
void
_main()
{
  78:	1141                	add	sp,sp,-16
  7a:	e022                	sd	s0,0(sp)
  7c:	e406                	sd	ra,8(sp)
  7e:	0800                	add	s0,sp,16
  extern int main();
  main();
  80:	00000097          	auipc	ra,0x0
  84:	f80080e7          	jalr	-128(ra) # 0 <main>
  exit(0);
  88:	4501                	li	a0,0
  8a:	00000097          	auipc	ra,0x0
  8e:	2e4080e7          	jalr	740(ra) # 36e <exit>

0000000000000092 <strcpy>:
}

char*
strcpy(char *s, const char *t)
{
  92:	1141                	add	sp,sp,-16
  94:	e422                	sd	s0,8(sp)
  96:	0800                	add	s0,sp,16
  char *os;

  os = s;
  while((*s++ = *t++) != 0)
  98:	87aa                	mv	a5,a0
  9a:	0005c703          	lbu	a4,0(a1)
  9e:	0785                	add	a5,a5,1
  a0:	0585                	add	a1,a1,1
  a2:	fee78fa3          	sb	a4,-1(a5)
  a6:	fb75                	bnez	a4,9a <strcpy+0x8>
    ;
  return os;
}
  a8:	6422                	ld	s0,8(sp)
  aa:	0141                	add	sp,sp,16
  ac:	8082                	ret

00000000000000ae <strcmp>:

int
strcmp(const char *p, const char *q)
{
  ae:	1141                	add	sp,sp,-16
  b0:	e422                	sd	s0,8(sp)
  b2:	0800                	add	s0,sp,16
  while(*p && *p == *q)
  b4:	00054783          	lbu	a5,0(a0)
  b8:	e791                	bnez	a5,c4 <strcmp+0x16>
  ba:	a80d                	j	ec <strcmp+0x3e>
  bc:	00054783          	lbu	a5,0(a0)
  c0:	cf99                	beqz	a5,de <strcmp+0x30>
  c2:	85b6                	mv	a1,a3
  c4:	0005c703          	lbu	a4,0(a1)
    p++, q++;
  c8:	0505                	add	a0,a0,1
  ca:	00158693          	add	a3,a1,1
  while(*p && *p == *q)
  ce:	fef707e3          	beq	a4,a5,bc <strcmp+0xe>
  return (uchar)*p - (uchar)*q;
  d2:	0007851b          	sext.w	a0,a5
}
  d6:	6422                	ld	s0,8(sp)
  d8:	9d19                	subw	a0,a0,a4
  da:	0141                	add	sp,sp,16
  dc:	8082                	ret
  return (uchar)*p - (uchar)*q;
  de:	0015c703          	lbu	a4,1(a1)
}
  e2:	6422                	ld	s0,8(sp)
  return (uchar)*p - (uchar)*q;
  e4:	4501                	li	a0,0
}
  e6:	9d19                	subw	a0,a0,a4
  e8:	0141                	add	sp,sp,16
  ea:	8082                	ret
  return (uchar)*p - (uchar)*q;
  ec:	0005c703          	lbu	a4,0(a1)
  f0:	4501                	li	a0,0
  f2:	b7d5                	j	d6 <strcmp+0x28>

00000000000000f4 <strlen>:

uint
strlen(const char *s)
{
  f4:	1141                	add	sp,sp,-16
  f6:	e422                	sd	s0,8(sp)
  f8:	0800                	add	s0,sp,16
  int n;

  for(n = 0; s[n]; n++)
  fa:	00054783          	lbu	a5,0(a0)
  fe:	cf91                	beqz	a5,11a <strlen+0x26>
 100:	0505                	add	a0,a0,1
 102:	87aa                	mv	a5,a0
 104:	0007c703          	lbu	a4,0(a5)
 108:	86be                	mv	a3,a5
 10a:	0785                	add	a5,a5,1
 10c:	ff65                	bnez	a4,104 <strlen+0x10>
    ;
  return n;
}
 10e:	6422                	ld	s0,8(sp)
 110:	40a6853b          	subw	a0,a3,a0
 114:	2505                	addw	a0,a0,1
 116:	0141                	add	sp,sp,16
 118:	8082                	ret
 11a:	6422                	ld	s0,8(sp)
  for(n = 0; s[n]; n++)
 11c:	4501                	li	a0,0
}
 11e:	0141                	add	sp,sp,16
 120:	8082                	ret

0000000000000122 <memset>:

void*
memset(void *dst, int c, uint n)
{
 122:	1141                	add	sp,sp,-16
 124:	e422                	sd	s0,8(sp)
 126:	0800                	add	s0,sp,16
  char *cdst = (char *) dst;
  int i;
  for(i = 0; i < n; i++){
 128:	ce09                	beqz	a2,142 <memset+0x20>
 12a:	1602                	sll	a2,a2,0x20
 12c:	9201                	srl	a2,a2,0x20
    cdst[i] = c;
 12e:	0ff5f593          	zext.b	a1,a1
 132:	87aa                	mv	a5,a0
 134:	00a60733          	add	a4,a2,a0
 138:	00b78023          	sb	a1,0(a5)
  for(i = 0; i < n; i++){
 13c:	0785                	add	a5,a5,1
 13e:	fee79de3          	bne	a5,a4,138 <memset+0x16>
  }
  return dst;
}
 142:	6422                	ld	s0,8(sp)
 144:	0141                	add	sp,sp,16
 146:	8082                	ret

0000000000000148 <strchr>:

char*
strchr(const char *s, char c)
{
 148:	1141                	add	sp,sp,-16
 14a:	e422                	sd	s0,8(sp)
 14c:	0800                	add	s0,sp,16
  for(; *s; s++)
 14e:	00054783          	lbu	a5,0(a0)
 152:	c799                	beqz	a5,160 <strchr+0x18>
    if(*s == c)
 154:	00f58763          	beq	a1,a5,162 <strchr+0x1a>
  for(; *s; s++)
 158:	00154783          	lbu	a5,1(a0)
 15c:	0505                	add	a0,a0,1
 15e:	fbfd                	bnez	a5,154 <strchr+0xc>
      return (char*)s;
  return 0;
 160:	4501                	li	a0,0
}
 162:	6422                	ld	s0,8(sp)
 164:	0141                	add	sp,sp,16
 166:	8082                	ret

0000000000000168 <gets>:

char*
gets(char *buf, int max)
{
 168:	711d                	add	sp,sp,-96
 16a:	e8a2                	sd	s0,80(sp)
 16c:	e4a6                	sd	s1,72(sp)
 16e:	e0ca                	sd	s2,64(sp)
 170:	fc4e                	sd	s3,56(sp)
 172:	f852                	sd	s4,48(sp)
 174:	f05a                	sd	s6,32(sp)
 176:	ec5e                	sd	s7,24(sp)
 178:	ec86                	sd	ra,88(sp)
 17a:	f456                	sd	s5,40(sp)
 17c:	1080                	add	s0,sp,96
 17e:	8baa                	mv	s7,a0
 180:	89ae                	mv	s3,a1
 182:	892a                	mv	s2,a0
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
 184:	4481                	li	s1,0
    cc = read(0, &c, 1);
    if(cc < 1)
      break;
    buf[i++] = c;
    if(c == '\n' || c == '\r')
 186:	4a29                	li	s4,10
 188:	4b35                	li	s6,13
  for(i=0; i+1 < max; ){
 18a:	a005                	j	1aa <gets+0x42>
    cc = read(0, &c, 1);
 18c:	00000097          	auipc	ra,0x0
 190:	1fa080e7          	jalr	506(ra) # 386 <read>
    if(cc < 1)
 194:	02a05363          	blez	a0,1ba <gets+0x52>
    buf[i++] = c;
 198:	faf44783          	lbu	a5,-81(s0)
    if(c == '\n' || c == '\r')
 19c:	0905                	add	s2,s2,1
    buf[i++] = c;
 19e:	fef90fa3          	sb	a5,-1(s2)
    if(c == '\n' || c == '\r')
 1a2:	01478d63          	beq	a5,s4,1bc <gets+0x54>
 1a6:	01678b63          	beq	a5,s6,1bc <gets+0x54>
  for(i=0; i+1 < max; ){
 1aa:	8aa6                	mv	s5,s1
 1ac:	2485                	addw	s1,s1,1
    cc = read(0, &c, 1);
 1ae:	4605                	li	a2,1
 1b0:	faf40593          	add	a1,s0,-81
 1b4:	4501                	li	a0,0
  for(i=0; i+1 < max; ){
 1b6:	fd34cbe3          	blt	s1,s3,18c <gets+0x24>
 1ba:	84d6                	mv	s1,s5
      break;
  }
  buf[i] = '\0';
 1bc:	94de                	add	s1,s1,s7
 1be:	00048023          	sb	zero,0(s1)
  return buf;
}
 1c2:	60e6                	ld	ra,88(sp)
 1c4:	6446                	ld	s0,80(sp)
 1c6:	64a6                	ld	s1,72(sp)
 1c8:	6906                	ld	s2,64(sp)
 1ca:	79e2                	ld	s3,56(sp)
 1cc:	7a42                	ld	s4,48(sp)
 1ce:	7aa2                	ld	s5,40(sp)
 1d0:	7b02                	ld	s6,32(sp)
 1d2:	855e                	mv	a0,s7
 1d4:	6be2                	ld	s7,24(sp)
 1d6:	6125                	add	sp,sp,96
 1d8:	8082                	ret

00000000000001da <stat>:

int
stat(const char *n, struct stat *st)
{
 1da:	1101                	add	sp,sp,-32
 1dc:	e822                	sd	s0,16(sp)
 1de:	e04a                	sd	s2,0(sp)
 1e0:	ec06                	sd	ra,24(sp)
 1e2:	e426                	sd	s1,8(sp)
 1e4:	1000                	add	s0,sp,32
 1e6:	892e                	mv	s2,a1
  int fd;
  int r;

  fd = open(n, O_RDONLY);
 1e8:	4581                	li	a1,0
 1ea:	00000097          	auipc	ra,0x0
 1ee:	1c4080e7          	jalr	452(ra) # 3ae <open>
  if(fd < 0)
 1f2:	02054663          	bltz	a0,21e <stat+0x44>
    return -1;
  r = fstat(fd, st);
 1f6:	85ca                	mv	a1,s2
 1f8:	84aa                	mv	s1,a0
 1fa:	00000097          	auipc	ra,0x0
 1fe:	1cc080e7          	jalr	460(ra) # 3c6 <fstat>
 202:	87aa                	mv	a5,a0
  close(fd);
 204:	8526                	mv	a0,s1
  r = fstat(fd, st);
 206:	84be                	mv	s1,a5
  close(fd);
 208:	00000097          	auipc	ra,0x0
 20c:	18e080e7          	jalr	398(ra) # 396 <close>
  return r;
}
 210:	60e2                	ld	ra,24(sp)
 212:	6442                	ld	s0,16(sp)
 214:	6902                	ld	s2,0(sp)
 216:	8526                	mv	a0,s1
 218:	64a2                	ld	s1,8(sp)
 21a:	6105                	add	sp,sp,32
 21c:	8082                	ret
    return -1;
 21e:	54fd                	li	s1,-1
 220:	bfc5                	j	210 <stat+0x36>

0000000000000222 <atoi>:

int
atoi(const char *s)
{
 222:	1141                	add	sp,sp,-16
 224:	e422                	sd	s0,8(sp)
 226:	0800                	add	s0,sp,16
  int n;

  n = 0;
  while('0' <= *s && *s <= '9')
 228:	00054683          	lbu	a3,0(a0)
 22c:	4625                	li	a2,9
 22e:	fd06879b          	addw	a5,a3,-48
 232:	0ff7f793          	zext.b	a5,a5
 236:	02f66863          	bltu	a2,a5,266 <atoi+0x44>
 23a:	872a                	mv	a4,a0
  n = 0;
 23c:	4501                	li	a0,0
    n = n*10 + *s++ - '0';
 23e:	0025179b          	sllw	a5,a0,0x2
 242:	9fa9                	addw	a5,a5,a0
 244:	0705                	add	a4,a4,1
 246:	0017979b          	sllw	a5,a5,0x1
 24a:	9fb5                	addw	a5,a5,a3
  while('0' <= *s && *s <= '9')
 24c:	00074683          	lbu	a3,0(a4)
    n = n*10 + *s++ - '0';
 250:	fd07851b          	addw	a0,a5,-48
  while('0' <= *s && *s <= '9')
 254:	fd06879b          	addw	a5,a3,-48
 258:	0ff7f793          	zext.b	a5,a5
 25c:	fef671e3          	bgeu	a2,a5,23e <atoi+0x1c>
  return n;
}
 260:	6422                	ld	s0,8(sp)
 262:	0141                	add	sp,sp,16
 264:	8082                	ret
 266:	6422                	ld	s0,8(sp)
  n = 0;
 268:	4501                	li	a0,0
}
 26a:	0141                	add	sp,sp,16
 26c:	8082                	ret

000000000000026e <memmove>:

void*
memmove(void *vdst, const void *vsrc, int n)
{
 26e:	1141                	add	sp,sp,-16
 270:	e422                	sd	s0,8(sp)
 272:	0800                	add	s0,sp,16
  char *dst;
  const char *src;

  dst = vdst;
  src = vsrc;
  if (src > dst) {
 274:	02b57463          	bgeu	a0,a1,29c <memmove+0x2e>
    while(n-- > 0)
 278:	00c05f63          	blez	a2,296 <memmove+0x28>
 27c:	1602                	sll	a2,a2,0x20
 27e:	9201                	srl	a2,a2,0x20
 280:	00c507b3          	add	a5,a0,a2
  dst = vdst;
 284:	872a                	mv	a4,a0
      *dst++ = *src++;
 286:	0005c683          	lbu	a3,0(a1)
 28a:	0705                	add	a4,a4,1
 28c:	0585                	add	a1,a1,1
 28e:	fed70fa3          	sb	a3,-1(a4)
    while(n-- > 0)
 292:	fef71ae3          	bne	a4,a5,286 <memmove+0x18>
    src += n;
    while(n-- > 0)
      *--dst = *--src;
  }
  return vdst;
}
 296:	6422                	ld	s0,8(sp)
 298:	0141                	add	sp,sp,16
 29a:	8082                	ret
    dst += n;
 29c:	00c50733          	add	a4,a0,a2
    src += n;
 2a0:	95b2                	add	a1,a1,a2
    while(n-- > 0)
 2a2:	fec05ae3          	blez	a2,296 <memmove+0x28>
 2a6:	fff6079b          	addw	a5,a2,-1
 2aa:	1782                	sll	a5,a5,0x20
 2ac:	9381                	srl	a5,a5,0x20
 2ae:	fff7c793          	not	a5,a5
 2b2:	97ae                	add	a5,a5,a1
      *--dst = *--src;
 2b4:	fff5c683          	lbu	a3,-1(a1)
 2b8:	15fd                	add	a1,a1,-1
 2ba:	177d                	add	a4,a4,-1
 2bc:	00d70023          	sb	a3,0(a4)
    while(n-- > 0)
 2c0:	feb79ae3          	bne	a5,a1,2b4 <memmove+0x46>
}
 2c4:	6422                	ld	s0,8(sp)
 2c6:	0141                	add	sp,sp,16
 2c8:	8082                	ret

00000000000002ca <memcmp>:

int
memcmp(const void *s1, const void *s2, uint n)
{
 2ca:	1141                	add	sp,sp,-16
 2cc:	e422                	sd	s0,8(sp)
 2ce:	0800                	add	s0,sp,16
  const char *p1 = s1, *p2 = s2;
  while (n-- > 0) {
 2d0:	c61d                	beqz	a2,2fe <memcmp+0x34>
 2d2:	fff6069b          	addw	a3,a2,-1
 2d6:	1682                	sll	a3,a3,0x20
 2d8:	9281                	srl	a3,a3,0x20
 2da:	0685                	add	a3,a3,1
 2dc:	96aa                	add	a3,a3,a0
 2de:	a019                	j	2e4 <memcmp+0x1a>
 2e0:	00a68f63          	beq	a3,a0,2fe <memcmp+0x34>
    if (*p1 != *p2) {
 2e4:	00054783          	lbu	a5,0(a0)
 2e8:	0005c703          	lbu	a4,0(a1)
      return *p1 - *p2;
    }
    p1++;
 2ec:	0505                	add	a0,a0,1
    p2++;
 2ee:	0585                	add	a1,a1,1
    if (*p1 != *p2) {
 2f0:	fee788e3          	beq	a5,a4,2e0 <memcmp+0x16>
  }
  return 0;
}
 2f4:	6422                	ld	s0,8(sp)
      return *p1 - *p2;
 2f6:	40e7853b          	subw	a0,a5,a4
}
 2fa:	0141                	add	sp,sp,16
 2fc:	8082                	ret
 2fe:	6422                	ld	s0,8(sp)
  return 0;
 300:	4501                	li	a0,0
}
 302:	0141                	add	sp,sp,16
 304:	8082                	ret

0000000000000306 <memcpy>:

void *
memcpy(void *dst, const void *src, uint n)
{
 306:	1141                	add	sp,sp,-16
 308:	e422                	sd	s0,8(sp)
 30a:	0800                	add	s0,sp,16
  return memmove(dst, src, n);
 30c:	0006079b          	sext.w	a5,a2
  if (src > dst) {
 310:	02b57463          	bgeu	a0,a1,338 <memcpy+0x32>
    while(n-- > 0)
 314:	00f05f63          	blez	a5,332 <memcpy+0x2c>
 318:	1602                	sll	a2,a2,0x20
 31a:	9201                	srl	a2,a2,0x20
 31c:	00c587b3          	add	a5,a1,a2
  dst = vdst;
 320:	872a                	mv	a4,a0
      *dst++ = *src++;
 322:	0005c683          	lbu	a3,0(a1)
 326:	0585                	add	a1,a1,1
 328:	0705                	add	a4,a4,1
 32a:	fed70fa3          	sb	a3,-1(a4)
    while(n-- > 0)
 32e:	fef59ae3          	bne	a1,a5,322 <memcpy+0x1c>
}
 332:	6422                	ld	s0,8(sp)
 334:	0141                	add	sp,sp,16
 336:	8082                	ret
    dst += n;
 338:	00f50733          	add	a4,a0,a5
    src += n;
 33c:	95be                	add	a1,a1,a5
    while(n-- > 0)
 33e:	fef05ae3          	blez	a5,332 <memcpy+0x2c>
 342:	fff6079b          	addw	a5,a2,-1
 346:	1782                	sll	a5,a5,0x20
 348:	9381                	srl	a5,a5,0x20
 34a:	fff7c793          	not	a5,a5
 34e:	97ae                	add	a5,a5,a1
      *--dst = *--src;
 350:	fff5c683          	lbu	a3,-1(a1)
 354:	15fd                	add	a1,a1,-1
 356:	177d                	add	a4,a4,-1
 358:	00d70023          	sb	a3,0(a4)
    while(n-- > 0)
 35c:	fef59ae3          	bne	a1,a5,350 <memcpy+0x4a>
}
 360:	6422                	ld	s0,8(sp)
 362:	0141                	add	sp,sp,16
 364:	8082                	ret

0000000000000366 <fork>:
# generated by usys.pl - do not edit
#include "kern/syscall.h"
.global fork
fork:
 li a7, SYS_fork
 366:	4885                	li	a7,1
 ecall
 368:	00000073          	ecall
 ret
 36c:	8082                	ret

000000000000036e <exit>:
.global exit
exit:
 li a7, SYS_exit
 36e:	4889                	li	a7,2
 ecall
 370:	00000073          	ecall
 ret
 374:	8082                	ret

0000000000000376 <wait>:
.global wait
wait:
 li a7, SYS_wait
 376:	488d                	li	a7,3
 ecall
 378:	00000073          	ecall
 ret
 37c:	8082                	ret

000000000000037e <pipe>:
.global pipe
pipe:
 li a7, SYS_pipe
 37e:	4891                	li	a7,4
 ecall
 380:	00000073          	ecall
 ret
 384:	8082                	ret

0000000000000386 <read>:
.global read
read:
 li a7, SYS_read
 386:	4895                	li	a7,5
 ecall
 388:	00000073          	ecall
 ret
 38c:	8082                	ret

000000000000038e <write>:
.global write
write:
 li a7, SYS_write
 38e:	48c1                	li	a7,16
 ecall
 390:	00000073          	ecall
 ret
 394:	8082                	ret

0000000000000396 <close>:
.global close
close:
 li a7, SYS_close
 396:	48d5                	li	a7,21
 ecall
 398:	00000073          	ecall
 ret
 39c:	8082                	ret

000000000000039e <kill>:
.global kill
kill:
 li a7, SYS_kill
 39e:	4899                	li	a7,6
 ecall
 3a0:	00000073          	ecall
 ret
 3a4:	8082                	ret

00000000000003a6 <exec>:
.global exec
exec:
 li a7, SYS_exec
 3a6:	489d                	li	a7,7
 ecall
 3a8:	00000073          	ecall
 ret
 3ac:	8082                	ret

00000000000003ae <open>:
.global open
open:
 li a7, SYS_open
 3ae:	48bd                	li	a7,15
 ecall
 3b0:	00000073          	ecall
 ret
 3b4:	8082                	ret

00000000000003b6 <mknod>:
.global mknod
mknod:
 li a7, SYS_mknod
 3b6:	48c5                	li	a7,17
 ecall
 3b8:	00000073          	ecall
 ret
 3bc:	8082                	ret

00000000000003be <unlink>:
.global unlink
unlink:
 li a7, SYS_unlink
 3be:	48c9                	li	a7,18
 ecall
 3c0:	00000073          	ecall
 ret
 3c4:	8082                	ret

00000000000003c6 <fstat>:
.global fstat
fstat:
 li a7, SYS_fstat
 3c6:	48a1                	li	a7,8
 ecall
 3c8:	00000073          	ecall
 ret
 3cc:	8082                	ret

00000000000003ce <link>:
.global link
link:
 li a7, SYS_link
 3ce:	48cd                	li	a7,19
 ecall
 3d0:	00000073          	ecall
 ret
 3d4:	8082                	ret

00000000000003d6 <mkdir>:
.global mkdir
mkdir:
 li a7, SYS_mkdir
 3d6:	48d1                	li	a7,20
 ecall
 3d8:	00000073          	ecall
 ret
 3dc:	8082                	ret

00000000000003de <chdir>:
.global chdir
chdir:
 li a7, SYS_chdir
 3de:	48a5                	li	a7,9
 ecall
 3e0:	00000073          	ecall
 ret
 3e4:	8082                	ret

00000000000003e6 <dup>:
.global dup
dup:
 li a7, SYS_dup
 3e6:	48a9                	li	a7,10
 ecall
 3e8:	00000073          	ecall
 ret
 3ec:	8082                	ret

00000000000003ee <getpid>:
.global getpid
getpid:
 li a7, SYS_getpid
 3ee:	48ad                	li	a7,11
 ecall
 3f0:	00000073          	ecall
 ret
 3f4:	8082                	ret

00000000000003f6 <sbrk>:
.global sbrk
sbrk:
 li a7, SYS_sbrk
 3f6:	48b1                	li	a7,12
 ecall
 3f8:	00000073          	ecall
 ret
 3fc:	8082                	ret

00000000000003fe <sleep>:
.global sleep
sleep:
 li a7, SYS_sleep
 3fe:	48b5                	li	a7,13
 ecall
 400:	00000073          	ecall
 ret
 404:	8082                	ret

0000000000000406 <uptime>:
.global uptime
uptime:
 li a7, SYS_uptime
 406:	48b9                	li	a7,14
 ecall
 408:	00000073          	ecall
 ret
 40c:	8082                	ret

000000000000040e <poweroff>:
.global poweroff
poweroff:
 li a7, SYS_poweroff
 40e:	48d9                	li	a7,22
 ecall
 410:	00000073          	ecall
 ret
 414:	8082                	ret

0000000000000416 <printint>:
  write(fd, &c, 1);
}

static void
printint(int fd, int xx, int base, int sgn)
{
 416:	715d                	add	sp,sp,-80
 418:	e0a2                	sd	s0,64(sp)
 41a:	f84a                	sd	s2,48(sp)
 41c:	e486                	sd	ra,72(sp)
 41e:	fc26                	sd	s1,56(sp)
 420:	f44e                	sd	s3,40(sp)
 422:	0880                	add	s0,sp,80
 424:	892a                	mv	s2,a0
  char buf[16];
  int i, neg;
  uint x;

  neg = 0;
  if(sgn && xx < 0){
 426:	c299                	beqz	a3,42c <printint+0x16>
 428:	0805c263          	bltz	a1,4ac <printint+0x96>
    neg = 1;
    x = -xx;
  } else {
    x = xx;
 42c:	2581                	sext.w	a1,a1
  neg = 0;
 42e:	4681                	li	a3,0
  }

  i = 0;
  do{
    buf[i++] = digits[x % base];
 430:	2601                	sext.w	a2,a2
 432:	fc040713          	add	a4,s0,-64
  i = 0;
 436:	4501                	li	a0,0
 438:	00000897          	auipc	a7,0x0
 43c:	4f088893          	add	a7,a7,1264 # 928 <digits>
    buf[i++] = digits[x % base];
 440:	02c5f7bb          	remuw	a5,a1,a2
  }while((x /= base) != 0);
 444:	0705                	add	a4,a4,1
 446:	0005881b          	sext.w	a6,a1
 44a:	84aa                	mv	s1,a0
    buf[i++] = digits[x % base];
 44c:	2505                	addw	a0,a0,1
 44e:	1782                	sll	a5,a5,0x20
 450:	9381                	srl	a5,a5,0x20
 452:	97c6                	add	a5,a5,a7
 454:	0007c783          	lbu	a5,0(a5)
  }while((x /= base) != 0);
 458:	02c5d5bb          	divuw	a1,a1,a2
    buf[i++] = digits[x % base];
 45c:	fef70fa3          	sb	a5,-1(a4)
  }while((x /= base) != 0);
 460:	fec870e3          	bgeu	a6,a2,440 <printint+0x2a>
  if(neg)
 464:	ca89                	beqz	a3,476 <printint+0x60>
    buf[i++] = '-';
 466:	fd050793          	add	a5,a0,-48
 46a:	97a2                	add	a5,a5,s0
 46c:	02d00713          	li	a4,45
 470:	fee78823          	sb	a4,-16(a5)

  while(--i >= 0)
 474:	84aa                	mv	s1,a0
 476:	fc040793          	add	a5,s0,-64
 47a:	94be                	add	s1,s1,a5
 47c:	fff78993          	add	s3,a5,-1
    putc(fd, buf[i]);
 480:	0004c783          	lbu	a5,0(s1)
  write(fd, &c, 1);
 484:	4605                	li	a2,1
 486:	fbf40593          	add	a1,s0,-65
 48a:	854a                	mv	a0,s2
  while(--i >= 0)
 48c:	14fd                	add	s1,s1,-1
 48e:	faf40fa3          	sb	a5,-65(s0)
  write(fd, &c, 1);
 492:	00000097          	auipc	ra,0x0
 496:	efc080e7          	jalr	-260(ra) # 38e <write>
  while(--i >= 0)
 49a:	ff3493e3          	bne	s1,s3,480 <printint+0x6a>
}
 49e:	60a6                	ld	ra,72(sp)
 4a0:	6406                	ld	s0,64(sp)
 4a2:	74e2                	ld	s1,56(sp)
 4a4:	7942                	ld	s2,48(sp)
 4a6:	79a2                	ld	s3,40(sp)
 4a8:	6161                	add	sp,sp,80
 4aa:	8082                	ret
    x = -xx;
 4ac:	40b005bb          	negw	a1,a1
 4b0:	b741                	j	430 <printint+0x1a>

00000000000004b2 <vprintf>:
}

// Print to the given fd. Only understands %d, %x, %p, %s.
void
vprintf(int fd, const char *fmt, va_list ap)
{
 4b2:	7159                	add	sp,sp,-112
 4b4:	f0a2                	sd	s0,96(sp)
 4b6:	f486                	sd	ra,104(sp)
 4b8:	e8ca                	sd	s2,80(sp)
 4ba:	1880                	add	s0,sp,112
  char *s;
  int c, i, state;

  state = 0;
  for(i = 0; fmt[i]; i++){
 4bc:	0005c903          	lbu	s2,0(a1)
 4c0:	04090f63          	beqz	s2,51e <vprintf+0x6c>
 4c4:	eca6                	sd	s1,88(sp)
 4c6:	e4ce                	sd	s3,72(sp)
 4c8:	e0d2                	sd	s4,64(sp)
 4ca:	fc56                	sd	s5,56(sp)
 4cc:	f85a                	sd	s6,48(sp)
 4ce:	f45e                	sd	s7,40(sp)
 4d0:	f062                	sd	s8,32(sp)
 4d2:	8a2a                	mv	s4,a0
 4d4:	8c32                	mv	s8,a2
 4d6:	00158493          	add	s1,a1,1
 4da:	4981                	li	s3,0
      if(c == '%'){
        state = '%';
      } else {
        putc(fd, c);
      }
    } else if(state == '%'){
 4dc:	02500a93          	li	s5,37
 4e0:	4bd5                	li	s7,21
 4e2:	00000b17          	auipc	s6,0x0
 4e6:	3eeb0b13          	add	s6,s6,1006 # 8d0 <malloc+0x138>
    if(state == 0){
 4ea:	02099f63          	bnez	s3,528 <vprintf+0x76>
      if(c == '%'){
 4ee:	05590c63          	beq	s2,s5,546 <vprintf+0x94>
  write(fd, &c, 1);
 4f2:	4605                	li	a2,1
 4f4:	f9f40593          	add	a1,s0,-97
 4f8:	8552                	mv	a0,s4
 4fa:	f9240fa3          	sb	s2,-97(s0)
 4fe:	00000097          	auipc	ra,0x0
 502:	e90080e7          	jalr	-368(ra) # 38e <write>
  for(i = 0; fmt[i]; i++){
 506:	0004c903          	lbu	s2,0(s1)
 50a:	0485                	add	s1,s1,1
 50c:	fc091fe3          	bnez	s2,4ea <vprintf+0x38>
 510:	64e6                	ld	s1,88(sp)
 512:	69a6                	ld	s3,72(sp)
 514:	6a06                	ld	s4,64(sp)
 516:	7ae2                	ld	s5,56(sp)
 518:	7b42                	ld	s6,48(sp)
 51a:	7ba2                	ld	s7,40(sp)
 51c:	7c02                	ld	s8,32(sp)
        putc(fd, c);
      }
      state = 0;
    }
  }
}
 51e:	70a6                	ld	ra,104(sp)
 520:	7406                	ld	s0,96(sp)
 522:	6946                	ld	s2,80(sp)
 524:	6165                	add	sp,sp,112
 526:	8082                	ret
    } else if(state == '%'){
 528:	fd599fe3          	bne	s3,s5,506 <vprintf+0x54>
      if(c == 'd'){
 52c:	15590463          	beq	s2,s5,674 <vprintf+0x1c2>
 530:	f9d9079b          	addw	a5,s2,-99
 534:	0ff7f793          	zext.b	a5,a5
 538:	00fbea63          	bltu	s7,a5,54c <vprintf+0x9a>
 53c:	078a                	sll	a5,a5,0x2
 53e:	97da                	add	a5,a5,s6
 540:	439c                	lw	a5,0(a5)
 542:	97da                	add	a5,a5,s6
 544:	8782                	jr	a5
        state = '%';
 546:	02500993          	li	s3,37
 54a:	bf75                	j	506 <vprintf+0x54>
  write(fd, &c, 1);
 54c:	f9f40993          	add	s3,s0,-97
 550:	4605                	li	a2,1
 552:	85ce                	mv	a1,s3
 554:	02500793          	li	a5,37
 558:	8552                	mv	a0,s4
 55a:	f8f40fa3          	sb	a5,-97(s0)
 55e:	00000097          	auipc	ra,0x0
 562:	e30080e7          	jalr	-464(ra) # 38e <write>
 566:	4605                	li	a2,1
 568:	85ce                	mv	a1,s3
 56a:	8552                	mv	a0,s4
 56c:	f9240fa3          	sb	s2,-97(s0)
 570:	00000097          	auipc	ra,0x0
 574:	e1e080e7          	jalr	-482(ra) # 38e <write>
        while(*s != 0){
 578:	4981                	li	s3,0
 57a:	b771                	j	506 <vprintf+0x54>
        putc(fd, va_arg(ap, uint));
 57c:	000c2783          	lw	a5,0(s8)
  write(fd, &c, 1);
 580:	4605                	li	a2,1
 582:	f9f40593          	add	a1,s0,-97
 586:	8552                	mv	a0,s4
        putc(fd, va_arg(ap, uint));
 588:	f8f40fa3          	sb	a5,-97(s0)
 58c:	0c21                	add	s8,s8,8
  write(fd, &c, 1);
 58e:	00000097          	auipc	ra,0x0
 592:	e00080e7          	jalr	-512(ra) # 38e <write>
 596:	4981                	li	s3,0
 598:	b7bd                	j	506 <vprintf+0x54>
        printint(fd, va_arg(ap, int), 10, 1);
 59a:	000c2583          	lw	a1,0(s8)
 59e:	4685                	li	a3,1
        printint(fd, va_arg(ap, uint64), 10, 0);
 5a0:	4629                	li	a2,10
 5a2:	8552                	mv	a0,s4
 5a4:	0c21                	add	s8,s8,8
 5a6:	00000097          	auipc	ra,0x0
 5aa:	e70080e7          	jalr	-400(ra) # 416 <printint>
 5ae:	4981                	li	s3,0
 5b0:	bf99                	j	506 <vprintf+0x54>
 5b2:	000c2583          	lw	a1,0(s8)
 5b6:	4681                	li	a3,0
 5b8:	b7e5                	j	5a0 <vprintf+0xee>
  write(fd, &c, 1);
 5ba:	f9f40993          	add	s3,s0,-97
 5be:	03000793          	li	a5,48
 5c2:	4605                	li	a2,1
 5c4:	85ce                	mv	a1,s3
 5c6:	8552                	mv	a0,s4
 5c8:	ec66                	sd	s9,24(sp)
 5ca:	e86a                	sd	s10,16(sp)
        printptr(fd, va_arg(ap, uint64));
 5cc:	f8f40fa3          	sb	a5,-97(s0)
 5d0:	000c3d03          	ld	s10,0(s8)
  write(fd, &c, 1);
 5d4:	00000097          	auipc	ra,0x0
 5d8:	dba080e7          	jalr	-582(ra) # 38e <write>
 5dc:	07800793          	li	a5,120
 5e0:	4605                	li	a2,1
 5e2:	85ce                	mv	a1,s3
 5e4:	8552                	mv	a0,s4
 5e6:	f8f40fa3          	sb	a5,-97(s0)
        printptr(fd, va_arg(ap, uint64));
 5ea:	0c21                	add	s8,s8,8
  write(fd, &c, 1);
 5ec:	00000097          	auipc	ra,0x0
 5f0:	da2080e7          	jalr	-606(ra) # 38e <write>
  putc(fd, 'x');
 5f4:	4941                	li	s2,16
 5f6:	00000c97          	auipc	s9,0x0
 5fa:	332c8c93          	add	s9,s9,818 # 928 <digits>
    putc(fd, digits[x >> (sizeof(uint64) * 8 - 4)]);
 5fe:	03cd5793          	srl	a5,s10,0x3c
 602:	97e6                	add	a5,a5,s9
 604:	0007c783          	lbu	a5,0(a5)
  write(fd, &c, 1);
 608:	4605                	li	a2,1
 60a:	85ce                	mv	a1,s3
 60c:	8552                	mv	a0,s4
  for (i = 0; i < (sizeof(uint64) * 2); i++, x <<= 4)
 60e:	397d                	addw	s2,s2,-1
 610:	f8f40fa3          	sb	a5,-97(s0)
 614:	0d12                	sll	s10,s10,0x4
  write(fd, &c, 1);
 616:	00000097          	auipc	ra,0x0
 61a:	d78080e7          	jalr	-648(ra) # 38e <write>
  for (i = 0; i < (sizeof(uint64) * 2); i++, x <<= 4)
 61e:	fe0910e3          	bnez	s2,5fe <vprintf+0x14c>
 622:	6ce2                	ld	s9,24(sp)
 624:	6d42                	ld	s10,16(sp)
 626:	4981                	li	s3,0
 628:	bdf9                	j	506 <vprintf+0x54>
        s = va_arg(ap, char*);
 62a:	000c3903          	ld	s2,0(s8)
 62e:	0c21                	add	s8,s8,8
        if(s == 0)
 630:	04090e63          	beqz	s2,68c <vprintf+0x1da>
        while(*s != 0){
 634:	00094783          	lbu	a5,0(s2)
 638:	d3a1                	beqz	a5,578 <vprintf+0xc6>
 63a:	f9f40993          	add	s3,s0,-97
  write(fd, &c, 1);
 63e:	4605                	li	a2,1
 640:	85ce                	mv	a1,s3
 642:	8552                	mv	a0,s4
 644:	f8f40fa3          	sb	a5,-97(s0)
 648:	00000097          	auipc	ra,0x0
 64c:	d46080e7          	jalr	-698(ra) # 38e <write>
        while(*s != 0){
 650:	00194783          	lbu	a5,1(s2)
          s++;
 654:	0905                	add	s2,s2,1
        while(*s != 0){
 656:	f7e5                	bnez	a5,63e <vprintf+0x18c>
 658:	4981                	li	s3,0
 65a:	b575                	j	506 <vprintf+0x54>
        printint(fd, va_arg(ap, int), 16, 0);
 65c:	000c2583          	lw	a1,0(s8)
 660:	4681                	li	a3,0
 662:	4641                	li	a2,16
 664:	8552                	mv	a0,s4
 666:	0c21                	add	s8,s8,8
 668:	00000097          	auipc	ra,0x0
 66c:	dae080e7          	jalr	-594(ra) # 416 <printint>
 670:	4981                	li	s3,0
 672:	bd51                	j	506 <vprintf+0x54>
  write(fd, &c, 1);
 674:	4605                	li	a2,1
 676:	f9f40593          	add	a1,s0,-97
 67a:	8552                	mv	a0,s4
 67c:	f9540fa3          	sb	s5,-97(s0)
        while(*s != 0){
 680:	4981                	li	s3,0
  write(fd, &c, 1);
 682:	00000097          	auipc	ra,0x0
 686:	d0c080e7          	jalr	-756(ra) # 38e <write>
 68a:	bdb5                	j	506 <vprintf+0x54>
          s = "(null)";
 68c:	00000917          	auipc	s2,0x0
 690:	23c90913          	add	s2,s2,572 # 8c8 <malloc+0x130>
 694:	02800793          	li	a5,40
 698:	b74d                	j	63a <vprintf+0x188>

000000000000069a <fprintf>:

void
fprintf(int fd, const char *fmt, ...)
{
 69a:	715d                	add	sp,sp,-80
 69c:	e822                	sd	s0,16(sp)
 69e:	ec06                	sd	ra,24(sp)
 6a0:	1000                	add	s0,sp,32
 6a2:	e010                	sd	a2,0(s0)
  va_list ap;

  va_start(ap, fmt);
  vprintf(fd, fmt, ap);
 6a4:	8622                	mv	a2,s0
{
 6a6:	e414                	sd	a3,8(s0)
 6a8:	e818                	sd	a4,16(s0)
 6aa:	ec1c                	sd	a5,24(s0)
 6ac:	03043023          	sd	a6,32(s0)
 6b0:	03143423          	sd	a7,40(s0)
  va_start(ap, fmt);
 6b4:	fe843423          	sd	s0,-24(s0)
  vprintf(fd, fmt, ap);
 6b8:	00000097          	auipc	ra,0x0
 6bc:	dfa080e7          	jalr	-518(ra) # 4b2 <vprintf>
}
 6c0:	60e2                	ld	ra,24(sp)
 6c2:	6442                	ld	s0,16(sp)
 6c4:	6161                	add	sp,sp,80
 6c6:	8082                	ret

00000000000006c8 <printf>:

void
printf(const char *fmt, ...)
{
 6c8:	711d                	add	sp,sp,-96
 6ca:	e822                	sd	s0,16(sp)
 6cc:	ec06                	sd	ra,24(sp)
 6ce:	1000                	add	s0,sp,32
  va_list ap;

  va_start(ap, fmt);
 6d0:	00840313          	add	t1,s0,8
{
 6d4:	e40c                	sd	a1,8(s0)
 6d6:	e810                	sd	a2,16(s0)
  vprintf(1, fmt, ap);
 6d8:	85aa                	mv	a1,a0
 6da:	861a                	mv	a2,t1
 6dc:	4505                	li	a0,1
{
 6de:	ec14                	sd	a3,24(s0)
 6e0:	f018                	sd	a4,32(s0)
 6e2:	f41c                	sd	a5,40(s0)
 6e4:	03043823          	sd	a6,48(s0)
 6e8:	03143c23          	sd	a7,56(s0)
  va_start(ap, fmt);
 6ec:	fe643423          	sd	t1,-24(s0)
  vprintf(1, fmt, ap);
 6f0:	00000097          	auipc	ra,0x0
 6f4:	dc2080e7          	jalr	-574(ra) # 4b2 <vprintf>
}
 6f8:	60e2                	ld	ra,24(sp)
 6fa:	6442                	ld	s0,16(sp)
 6fc:	6125                	add	sp,sp,96
 6fe:	8082                	ret

0000000000000700 <free>:
static Header base;
static Header *freep;

void
free(void *ap)
{
 700:	1141                	add	sp,sp,-16
 702:	e422                	sd	s0,8(sp)
 704:	0800                	add	s0,sp,16
  Header *bp, *p;

  bp = (Header*)ap - 1;
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 706:	00001597          	auipc	a1,0x1
 70a:	8fa58593          	add	a1,a1,-1798 # 1000 <freep>
 70e:	619c                	ld	a5,0(a1)
  bp = (Header*)ap - 1;
 710:	ff050693          	add	a3,a0,-16
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 714:	6398                	ld	a4,0(a5)
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 716:	02d7ff63          	bgeu	a5,a3,754 <free+0x54>
 71a:	00e6e463          	bltu	a3,a4,722 <free+0x22>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 71e:	02e7ef63          	bltu	a5,a4,75c <free+0x5c>
      break;
  if(bp + bp->s.size == p->s.ptr){
 722:	ff852803          	lw	a6,-8(a0)
 726:	02081893          	sll	a7,a6,0x20
 72a:	01c8d613          	srl	a2,a7,0x1c
 72e:	9636                	add	a2,a2,a3
 730:	02c70863          	beq	a4,a2,760 <free+0x60>
    bp->s.size += p->s.ptr->s.size;
    bp->s.ptr = p->s.ptr->s.ptr;
  } else
    bp->s.ptr = p->s.ptr;
  if(p + p->s.size == bp){
 734:	0087a803          	lw	a6,8(a5)
 738:	fee53823          	sd	a4,-16(a0)
 73c:	02081893          	sll	a7,a6,0x20
 740:	01c8d613          	srl	a2,a7,0x1c
 744:	963e                	add	a2,a2,a5
 746:	02c68e63          	beq	a3,a2,782 <free+0x82>
    p->s.size += bp->s.size;
    p->s.ptr = bp->s.ptr;
  } else
    p->s.ptr = bp;
  freep = p;
}
 74a:	6422                	ld	s0,8(sp)
 74c:	e394                	sd	a3,0(a5)
  freep = p;
 74e:	e19c                	sd	a5,0(a1)
}
 750:	0141                	add	sp,sp,16
 752:	8082                	ret
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 754:	00e7e463          	bltu	a5,a4,75c <free+0x5c>
 758:	fce6e5e3          	bltu	a3,a4,722 <free+0x22>
{
 75c:	87ba                	mv	a5,a4
 75e:	bf5d                	j	714 <free+0x14>
    bp->s.size += p->s.ptr->s.size;
 760:	4710                	lw	a2,8(a4)
    bp->s.ptr = p->s.ptr->s.ptr;
 762:	6318                	ld	a4,0(a4)
    bp->s.size += p->s.ptr->s.size;
 764:	0106063b          	addw	a2,a2,a6
 768:	fec52c23          	sw	a2,-8(a0)
  if(p + p->s.size == bp){
 76c:	0087a803          	lw	a6,8(a5)
 770:	fee53823          	sd	a4,-16(a0)
 774:	02081893          	sll	a7,a6,0x20
 778:	01c8d613          	srl	a2,a7,0x1c
 77c:	963e                	add	a2,a2,a5
 77e:	fcc696e3          	bne	a3,a2,74a <free+0x4a>
    p->s.size += bp->s.size;
 782:	ff852603          	lw	a2,-8(a0)
}
 786:	6422                	ld	s0,8(sp)
    p->s.ptr = bp->s.ptr;
 788:	86ba                	mv	a3,a4
    p->s.size += bp->s.size;
 78a:	0106073b          	addw	a4,a2,a6
 78e:	c798                	sw	a4,8(a5)
    p->s.ptr = bp->s.ptr;
 790:	e394                	sd	a3,0(a5)
  freep = p;
 792:	e19c                	sd	a5,0(a1)
}
 794:	0141                	add	sp,sp,16
 796:	8082                	ret

0000000000000798 <malloc>:
  return freep;
}

void*
malloc(uint nbytes)
{
 798:	7139                	add	sp,sp,-64
 79a:	f822                	sd	s0,48(sp)
 79c:	f426                	sd	s1,40(sp)
 79e:	f04a                	sd	s2,32(sp)
 7a0:	ec4e                	sd	s3,24(sp)
 7a2:	fc06                	sd	ra,56(sp)
 7a4:	0080                	add	s0,sp,64
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
  if((prevp = freep) == 0){
 7a6:	00001917          	auipc	s2,0x1
 7aa:	85a90913          	add	s2,s2,-1958 # 1000 <freep>
  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
 7ae:	02051493          	sll	s1,a0,0x20
 7b2:	9081                	srl	s1,s1,0x20
  if((prevp = freep) == 0){
 7b4:	00093783          	ld	a5,0(s2)
  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
 7b8:	04bd                	add	s1,s1,15
 7ba:	8091                	srl	s1,s1,0x4
 7bc:	0014899b          	addw	s3,s1,1
 7c0:	0485                	add	s1,s1,1
  if((prevp = freep) == 0){
 7c2:	c3dd                	beqz	a5,868 <malloc+0xd0>
    base.s.ptr = freep = prevp = &base;
    base.s.size = 0;
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 7c4:	6388                	ld	a0,0(a5)
    if(p->s.size >= nunits){
 7c6:	4518                	lw	a4,8(a0)
 7c8:	06977863          	bgeu	a4,s1,838 <malloc+0xa0>
 7cc:	e852                	sd	s4,16(sp)
 7ce:	e456                	sd	s5,8(sp)
 7d0:	e05a                	sd	s6,0(sp)
  if(nu < 4096)
 7d2:	6785                	lui	a5,0x1
 7d4:	8a4e                	mv	s4,s3
 7d6:	08f4e763          	bltu	s1,a5,864 <malloc+0xcc>
 7da:	000a0b1b          	sext.w	s6,s4
  if(p == (char*)-1)
 7de:	5afd                	li	s5,-1
  p = sbrk(nu * sizeof(Header));
 7e0:	004a1a1b          	sllw	s4,s4,0x4
 7e4:	a029                	j	7ee <malloc+0x56>
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 7e6:	6388                	ld	a0,0(a5)
    if(p->s.size >= nunits){
 7e8:	4518                	lw	a4,8(a0)
 7ea:	04977463          	bgeu	a4,s1,832 <malloc+0x9a>
        p->s.size = nunits;
      }
      freep = prevp;
      return (void*)(p + 1);
    }
    if(p == freep)
 7ee:	00093703          	ld	a4,0(s2)
 7f2:	87aa                	mv	a5,a0
 7f4:	fee519e3          	bne	a0,a4,7e6 <malloc+0x4e>
  p = sbrk(nu * sizeof(Header));
 7f8:	8552                	mv	a0,s4
 7fa:	00000097          	auipc	ra,0x0
 7fe:	bfc080e7          	jalr	-1028(ra) # 3f6 <sbrk>
 802:	87aa                	mv	a5,a0
  free((void*)(hp + 1));
 804:	0541                	add	a0,a0,16
  if(p == (char*)-1)
 806:	01578b63          	beq	a5,s5,81c <malloc+0x84>
  hp->s.size = nu;
 80a:	0167a423          	sw	s6,8(a5) # 1008 <freep+0x8>
  free((void*)(hp + 1));
 80e:	00000097          	auipc	ra,0x0
 812:	ef2080e7          	jalr	-270(ra) # 700 <free>
  return freep;
 816:	00093783          	ld	a5,0(s2)
      if((p = morecore(nunits)) == 0)
 81a:	f7f1                	bnez	a5,7e6 <malloc+0x4e>
        return 0;
  }
}
 81c:	70e2                	ld	ra,56(sp)
 81e:	7442                	ld	s0,48(sp)
        return 0;
 820:	6a42                	ld	s4,16(sp)
 822:	6aa2                	ld	s5,8(sp)
 824:	6b02                	ld	s6,0(sp)
}
 826:	74a2                	ld	s1,40(sp)
 828:	7902                	ld	s2,32(sp)
 82a:	69e2                	ld	s3,24(sp)
        return 0;
 82c:	4501                	li	a0,0
}
 82e:	6121                	add	sp,sp,64
 830:	8082                	ret
 832:	6a42                	ld	s4,16(sp)
 834:	6aa2                	ld	s5,8(sp)
 836:	6b02                	ld	s6,0(sp)
      if(p->s.size == nunits)
 838:	04e48763          	beq	s1,a4,886 <malloc+0xee>
        p->s.size -= nunits;
 83c:	4137073b          	subw	a4,a4,s3
        p += p->s.size;
 840:	02071613          	sll	a2,a4,0x20
 844:	01c65693          	srl	a3,a2,0x1c
        p->s.size -= nunits;
 848:	c518                	sw	a4,8(a0)
        p += p->s.size;
 84a:	9536                	add	a0,a0,a3
        p->s.size = nunits;
 84c:	01352423          	sw	s3,8(a0)
}
 850:	70e2                	ld	ra,56(sp)
 852:	7442                	ld	s0,48(sp)
      freep = prevp;
 854:	00f93023          	sd	a5,0(s2)
}
 858:	74a2                	ld	s1,40(sp)
 85a:	7902                	ld	s2,32(sp)
 85c:	69e2                	ld	s3,24(sp)
      return (void*)(p + 1);
 85e:	0541                	add	a0,a0,16
}
 860:	6121                	add	sp,sp,64
 862:	8082                	ret
  if(nu < 4096)
 864:	6a05                	lui	s4,0x1
 866:	bf95                	j	7da <malloc+0x42>
 868:	e852                	sd	s4,16(sp)
 86a:	e456                	sd	s5,8(sp)
 86c:	e05a                	sd	s6,0(sp)
    base.s.ptr = freep = prevp = &base;
 86e:	00000517          	auipc	a0,0x0
 872:	7a250513          	add	a0,a0,1954 # 1010 <base>
 876:	00a93023          	sd	a0,0(s2)
 87a:	e108                	sd	a0,0(a0)
    base.s.size = 0;
 87c:	00000797          	auipc	a5,0x0
 880:	7807ae23          	sw	zero,1948(a5) # 1018 <base+0x8>
    if(p->s.size >= nunits){
 884:	b7b9                	j	7d2 <malloc+0x3a>
        prevp->s.ptr = p->s.ptr;
 886:	6118                	ld	a4,0(a0)
 888:	e398                	sd	a4,0(a5)
 88a:	b7d9                	j	850 <malloc+0xb8>
