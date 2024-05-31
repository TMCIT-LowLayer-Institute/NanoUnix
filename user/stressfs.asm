
user/_stressfs:     file format elf64-littleriscv


Disassembly of section .text:

0000000000000000 <main>:

#include <C/string.h>

int
main(int argc, char *argv[])
{
   0:	dd010113          	add	sp,sp,-560
   4:	22113423          	sd	ra,552(sp)
   8:	22813023          	sd	s0,544(sp)
   c:	20913c23          	sd	s1,536(sp)
  10:	1c00                	add	s0,sp,560
  12:	21213823          	sd	s2,528(sp)
  int fd, i;
  char path[] = "stressfs0";
  16:	00001797          	auipc	a5,0x1
  1a:	93a78793          	add	a5,a5,-1734 # 950 <malloc+0x124>
  1e:	6398                	ld	a4,0(a5)
  20:	0087d783          	lhu	a5,8(a5)
  char data[512];

  printf("stressfs starting\n");
  24:	00001517          	auipc	a0,0x1
  28:	8fc50513          	add	a0,a0,-1796 # 920 <malloc+0xf4>
  char path[] = "stressfs0";
  2c:	dce43823          	sd	a4,-560(s0)
  30:	dcf41c23          	sh	a5,-552(s0)
  printf("stressfs starting\n");
  34:	00000097          	auipc	ra,0x0
  38:	728080e7          	jalr	1832(ra) # 75c <printf>
  memset(data, 'a', sizeof(data));
  3c:	20000613          	li	a2,512
  40:	06100593          	li	a1,97
  44:	de040513          	add	a0,s0,-544
  48:	00000097          	auipc	ra,0x0
  4c:	16e080e7          	jalr	366(ra) # 1b6 <memset>

  for(i = 0; i < 4; i++)
  50:	4481                	li	s1,0
  52:	4911                	li	s2,4
    if(fork() > 0)
  54:	00000097          	auipc	ra,0x0
  58:	3a6080e7          	jalr	934(ra) # 3fa <fork>
  5c:	00a04563          	bgtz	a0,66 <main+0x66>
  for(i = 0; i < 4; i++)
  60:	2485                	addw	s1,s1,1
  62:	ff2499e3          	bne	s1,s2,54 <main+0x54>
      break;

  printf("write %d\n", i);
  66:	85a6                	mv	a1,s1
  68:	00001517          	auipc	a0,0x1
  6c:	8d050513          	add	a0,a0,-1840 # 938 <malloc+0x10c>
  70:	00000097          	auipc	ra,0x0
  74:	6ec080e7          	jalr	1772(ra) # 75c <printf>

  path[8] += i;
  78:	dd844783          	lbu	a5,-552(s0)
  fd = open(path, O_CREATE | O_RDWR);
  7c:	20200593          	li	a1,514
  80:	dd040513          	add	a0,s0,-560
  path[8] += i;
  84:	9fa5                	addw	a5,a5,s1
  86:	dcf40c23          	sb	a5,-552(s0)
  fd = open(path, O_CREATE | O_RDWR);
  8a:	00000097          	auipc	ra,0x0
  8e:	3b8080e7          	jalr	952(ra) # 442 <open>
  92:	892a                	mv	s2,a0
  94:	44d1                	li	s1,20
  for(i = 0; i < 20; i++)
//    printf(fd, "%d\n", i);
    write(fd, data, sizeof(data));
  96:	20000613          	li	a2,512
  9a:	de040593          	add	a1,s0,-544
  9e:	854a                	mv	a0,s2
  for(i = 0; i < 20; i++)
  a0:	34fd                	addw	s1,s1,-1
    write(fd, data, sizeof(data));
  a2:	00000097          	auipc	ra,0x0
  a6:	380080e7          	jalr	896(ra) # 422 <write>
  for(i = 0; i < 20; i++)
  aa:	f4f5                	bnez	s1,96 <main+0x96>
  close(fd);
  ac:	854a                	mv	a0,s2
  ae:	00000097          	auipc	ra,0x0
  b2:	37c080e7          	jalr	892(ra) # 42a <close>

  printf("read\n");
  b6:	00001517          	auipc	a0,0x1
  ba:	89250513          	add	a0,a0,-1902 # 948 <malloc+0x11c>
  be:	00000097          	auipc	ra,0x0
  c2:	69e080e7          	jalr	1694(ra) # 75c <printf>

  fd = open(path, O_RDONLY);
  c6:	4581                	li	a1,0
  c8:	dd040513          	add	a0,s0,-560
  cc:	00000097          	auipc	ra,0x0
  d0:	376080e7          	jalr	886(ra) # 442 <open>
  d4:	892a                	mv	s2,a0
  d6:	44d1                	li	s1,20
  for (i = 0; i < 20; i++)
    read(fd, data, sizeof(data));
  d8:	20000613          	li	a2,512
  dc:	de040593          	add	a1,s0,-544
  e0:	854a                	mv	a0,s2
  for (i = 0; i < 20; i++)
  e2:	34fd                	addw	s1,s1,-1
    read(fd, data, sizeof(data));
  e4:	00000097          	auipc	ra,0x0
  e8:	336080e7          	jalr	822(ra) # 41a <read>
  for (i = 0; i < 20; i++)
  ec:	f4f5                	bnez	s1,d8 <main+0xd8>
  close(fd);
  ee:	854a                	mv	a0,s2
  f0:	00000097          	auipc	ra,0x0
  f4:	33a080e7          	jalr	826(ra) # 42a <close>

  wait(0);
  f8:	4501                	li	a0,0
  fa:	00000097          	auipc	ra,0x0
  fe:	310080e7          	jalr	784(ra) # 40a <wait>

  exit(0);
 102:	4501                	li	a0,0
 104:	00000097          	auipc	ra,0x0
 108:	2fe080e7          	jalr	766(ra) # 402 <exit>

000000000000010c <_main>:
//
// wrapper so that it's OK if main() does not call exit().
//
void
_main()
{
 10c:	1141                	add	sp,sp,-16
 10e:	e022                	sd	s0,0(sp)
 110:	e406                	sd	ra,8(sp)
 112:	0800                	add	s0,sp,16
  extern int main();
  main();
 114:	00000097          	auipc	ra,0x0
 118:	eec080e7          	jalr	-276(ra) # 0 <main>
  exit(0);
 11c:	4501                	li	a0,0
 11e:	00000097          	auipc	ra,0x0
 122:	2e4080e7          	jalr	740(ra) # 402 <exit>

0000000000000126 <strcpy>:
}

char*
strcpy(char *s, const char *t)
{
 126:	1141                	add	sp,sp,-16
 128:	e422                	sd	s0,8(sp)
 12a:	0800                	add	s0,sp,16
  char *os;

  os = s;
  while((*s++ = *t++) != 0)
 12c:	87aa                	mv	a5,a0
 12e:	0005c703          	lbu	a4,0(a1)
 132:	0785                	add	a5,a5,1
 134:	0585                	add	a1,a1,1
 136:	fee78fa3          	sb	a4,-1(a5)
 13a:	fb75                	bnez	a4,12e <strcpy+0x8>
    ;
  return os;
}
 13c:	6422                	ld	s0,8(sp)
 13e:	0141                	add	sp,sp,16
 140:	8082                	ret

0000000000000142 <strcmp>:

int
strcmp(const char *p, const char *q)
{
 142:	1141                	add	sp,sp,-16
 144:	e422                	sd	s0,8(sp)
 146:	0800                	add	s0,sp,16
  while(*p && *p == *q)
 148:	00054783          	lbu	a5,0(a0)
 14c:	e791                	bnez	a5,158 <strcmp+0x16>
 14e:	a80d                	j	180 <strcmp+0x3e>
 150:	00054783          	lbu	a5,0(a0)
 154:	cf99                	beqz	a5,172 <strcmp+0x30>
 156:	85b6                	mv	a1,a3
 158:	0005c703          	lbu	a4,0(a1)
    p++, q++;
 15c:	0505                	add	a0,a0,1
 15e:	00158693          	add	a3,a1,1
  while(*p && *p == *q)
 162:	fef707e3          	beq	a4,a5,150 <strcmp+0xe>
  return (uchar)*p - (uchar)*q;
 166:	0007851b          	sext.w	a0,a5
}
 16a:	6422                	ld	s0,8(sp)
 16c:	9d19                	subw	a0,a0,a4
 16e:	0141                	add	sp,sp,16
 170:	8082                	ret
  return (uchar)*p - (uchar)*q;
 172:	0015c703          	lbu	a4,1(a1)
}
 176:	6422                	ld	s0,8(sp)
  return (uchar)*p - (uchar)*q;
 178:	4501                	li	a0,0
}
 17a:	9d19                	subw	a0,a0,a4
 17c:	0141                	add	sp,sp,16
 17e:	8082                	ret
  return (uchar)*p - (uchar)*q;
 180:	0005c703          	lbu	a4,0(a1)
 184:	4501                	li	a0,0
 186:	b7d5                	j	16a <strcmp+0x28>

0000000000000188 <strlen>:

uint
strlen(const char *s)
{
 188:	1141                	add	sp,sp,-16
 18a:	e422                	sd	s0,8(sp)
 18c:	0800                	add	s0,sp,16
  int n;

  for(n = 0; s[n]; n++)
 18e:	00054783          	lbu	a5,0(a0)
 192:	cf91                	beqz	a5,1ae <strlen+0x26>
 194:	0505                	add	a0,a0,1
 196:	87aa                	mv	a5,a0
 198:	0007c703          	lbu	a4,0(a5)
 19c:	86be                	mv	a3,a5
 19e:	0785                	add	a5,a5,1
 1a0:	ff65                	bnez	a4,198 <strlen+0x10>
    ;
  return n;
}
 1a2:	6422                	ld	s0,8(sp)
 1a4:	40a6853b          	subw	a0,a3,a0
 1a8:	2505                	addw	a0,a0,1
 1aa:	0141                	add	sp,sp,16
 1ac:	8082                	ret
 1ae:	6422                	ld	s0,8(sp)
  for(n = 0; s[n]; n++)
 1b0:	4501                	li	a0,0
}
 1b2:	0141                	add	sp,sp,16
 1b4:	8082                	ret

00000000000001b6 <memset>:

void*
memset(void *dst, int c, uint n)
{
 1b6:	1141                	add	sp,sp,-16
 1b8:	e422                	sd	s0,8(sp)
 1ba:	0800                	add	s0,sp,16
  char *cdst = (char *) dst;
  int i;
  for(i = 0; i < n; i++){
 1bc:	ce09                	beqz	a2,1d6 <memset+0x20>
 1be:	1602                	sll	a2,a2,0x20
 1c0:	9201                	srl	a2,a2,0x20
    cdst[i] = c;
 1c2:	0ff5f593          	zext.b	a1,a1
 1c6:	87aa                	mv	a5,a0
 1c8:	00a60733          	add	a4,a2,a0
 1cc:	00b78023          	sb	a1,0(a5)
  for(i = 0; i < n; i++){
 1d0:	0785                	add	a5,a5,1
 1d2:	fee79de3          	bne	a5,a4,1cc <memset+0x16>
  }
  return dst;
}
 1d6:	6422                	ld	s0,8(sp)
 1d8:	0141                	add	sp,sp,16
 1da:	8082                	ret

00000000000001dc <strchr>:

char*
strchr(const char *s, char c)
{
 1dc:	1141                	add	sp,sp,-16
 1de:	e422                	sd	s0,8(sp)
 1e0:	0800                	add	s0,sp,16
  for(; *s; s++)
 1e2:	00054783          	lbu	a5,0(a0)
 1e6:	c799                	beqz	a5,1f4 <strchr+0x18>
    if(*s == c)
 1e8:	00f58763          	beq	a1,a5,1f6 <strchr+0x1a>
  for(; *s; s++)
 1ec:	00154783          	lbu	a5,1(a0)
 1f0:	0505                	add	a0,a0,1
 1f2:	fbfd                	bnez	a5,1e8 <strchr+0xc>
      return (char*)s;
  return 0;
 1f4:	4501                	li	a0,0
}
 1f6:	6422                	ld	s0,8(sp)
 1f8:	0141                	add	sp,sp,16
 1fa:	8082                	ret

00000000000001fc <gets>:

char*
gets(char *buf, int max)
{
 1fc:	711d                	add	sp,sp,-96
 1fe:	e8a2                	sd	s0,80(sp)
 200:	e4a6                	sd	s1,72(sp)
 202:	e0ca                	sd	s2,64(sp)
 204:	fc4e                	sd	s3,56(sp)
 206:	f852                	sd	s4,48(sp)
 208:	f05a                	sd	s6,32(sp)
 20a:	ec5e                	sd	s7,24(sp)
 20c:	ec86                	sd	ra,88(sp)
 20e:	f456                	sd	s5,40(sp)
 210:	1080                	add	s0,sp,96
 212:	8baa                	mv	s7,a0
 214:	89ae                	mv	s3,a1
 216:	892a                	mv	s2,a0
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
 218:	4481                	li	s1,0
    cc = read(0, &c, 1);
    if(cc < 1)
      break;
    buf[i++] = c;
    if(c == '\n' || c == '\r')
 21a:	4a29                	li	s4,10
 21c:	4b35                	li	s6,13
  for(i=0; i+1 < max; ){
 21e:	a005                	j	23e <gets+0x42>
    cc = read(0, &c, 1);
 220:	00000097          	auipc	ra,0x0
 224:	1fa080e7          	jalr	506(ra) # 41a <read>
    if(cc < 1)
 228:	02a05363          	blez	a0,24e <gets+0x52>
    buf[i++] = c;
 22c:	faf44783          	lbu	a5,-81(s0)
    if(c == '\n' || c == '\r')
 230:	0905                	add	s2,s2,1
    buf[i++] = c;
 232:	fef90fa3          	sb	a5,-1(s2)
    if(c == '\n' || c == '\r')
 236:	01478d63          	beq	a5,s4,250 <gets+0x54>
 23a:	01678b63          	beq	a5,s6,250 <gets+0x54>
  for(i=0; i+1 < max; ){
 23e:	8aa6                	mv	s5,s1
 240:	2485                	addw	s1,s1,1
    cc = read(0, &c, 1);
 242:	4605                	li	a2,1
 244:	faf40593          	add	a1,s0,-81
 248:	4501                	li	a0,0
  for(i=0; i+1 < max; ){
 24a:	fd34cbe3          	blt	s1,s3,220 <gets+0x24>
 24e:	84d6                	mv	s1,s5
      break;
  }
  buf[i] = '\0';
 250:	94de                	add	s1,s1,s7
 252:	00048023          	sb	zero,0(s1)
  return buf;
}
 256:	60e6                	ld	ra,88(sp)
 258:	6446                	ld	s0,80(sp)
 25a:	64a6                	ld	s1,72(sp)
 25c:	6906                	ld	s2,64(sp)
 25e:	79e2                	ld	s3,56(sp)
 260:	7a42                	ld	s4,48(sp)
 262:	7aa2                	ld	s5,40(sp)
 264:	7b02                	ld	s6,32(sp)
 266:	855e                	mv	a0,s7
 268:	6be2                	ld	s7,24(sp)
 26a:	6125                	add	sp,sp,96
 26c:	8082                	ret

000000000000026e <stat>:

int
stat(const char *n, struct stat *st)
{
 26e:	1101                	add	sp,sp,-32
 270:	e822                	sd	s0,16(sp)
 272:	e04a                	sd	s2,0(sp)
 274:	ec06                	sd	ra,24(sp)
 276:	e426                	sd	s1,8(sp)
 278:	1000                	add	s0,sp,32
 27a:	892e                	mv	s2,a1
  int fd;
  int r;

  fd = open(n, O_RDONLY);
 27c:	4581                	li	a1,0
 27e:	00000097          	auipc	ra,0x0
 282:	1c4080e7          	jalr	452(ra) # 442 <open>
  if(fd < 0)
 286:	02054663          	bltz	a0,2b2 <stat+0x44>
    return -1;
  r = fstat(fd, st);
 28a:	85ca                	mv	a1,s2
 28c:	84aa                	mv	s1,a0
 28e:	00000097          	auipc	ra,0x0
 292:	1cc080e7          	jalr	460(ra) # 45a <fstat>
 296:	87aa                	mv	a5,a0
  close(fd);
 298:	8526                	mv	a0,s1
  r = fstat(fd, st);
 29a:	84be                	mv	s1,a5
  close(fd);
 29c:	00000097          	auipc	ra,0x0
 2a0:	18e080e7          	jalr	398(ra) # 42a <close>
  return r;
}
 2a4:	60e2                	ld	ra,24(sp)
 2a6:	6442                	ld	s0,16(sp)
 2a8:	6902                	ld	s2,0(sp)
 2aa:	8526                	mv	a0,s1
 2ac:	64a2                	ld	s1,8(sp)
 2ae:	6105                	add	sp,sp,32
 2b0:	8082                	ret
    return -1;
 2b2:	54fd                	li	s1,-1
 2b4:	bfc5                	j	2a4 <stat+0x36>

00000000000002b6 <atoi>:

int
atoi(const char *s)
{
 2b6:	1141                	add	sp,sp,-16
 2b8:	e422                	sd	s0,8(sp)
 2ba:	0800                	add	s0,sp,16
  int n;

  n = 0;
  while('0' <= *s && *s <= '9')
 2bc:	00054683          	lbu	a3,0(a0)
 2c0:	4625                	li	a2,9
 2c2:	fd06879b          	addw	a5,a3,-48
 2c6:	0ff7f793          	zext.b	a5,a5
 2ca:	02f66863          	bltu	a2,a5,2fa <atoi+0x44>
 2ce:	872a                	mv	a4,a0
  n = 0;
 2d0:	4501                	li	a0,0
    n = n*10 + *s++ - '0';
 2d2:	0025179b          	sllw	a5,a0,0x2
 2d6:	9fa9                	addw	a5,a5,a0
 2d8:	0705                	add	a4,a4,1
 2da:	0017979b          	sllw	a5,a5,0x1
 2de:	9fb5                	addw	a5,a5,a3
  while('0' <= *s && *s <= '9')
 2e0:	00074683          	lbu	a3,0(a4)
    n = n*10 + *s++ - '0';
 2e4:	fd07851b          	addw	a0,a5,-48
  while('0' <= *s && *s <= '9')
 2e8:	fd06879b          	addw	a5,a3,-48
 2ec:	0ff7f793          	zext.b	a5,a5
 2f0:	fef671e3          	bgeu	a2,a5,2d2 <atoi+0x1c>
  return n;
}
 2f4:	6422                	ld	s0,8(sp)
 2f6:	0141                	add	sp,sp,16
 2f8:	8082                	ret
 2fa:	6422                	ld	s0,8(sp)
  n = 0;
 2fc:	4501                	li	a0,0
}
 2fe:	0141                	add	sp,sp,16
 300:	8082                	ret

0000000000000302 <memmove>:

void*
memmove(void *vdst, const void *vsrc, int n)
{
 302:	1141                	add	sp,sp,-16
 304:	e422                	sd	s0,8(sp)
 306:	0800                	add	s0,sp,16
  char *dst;
  const char *src;

  dst = vdst;
  src = vsrc;
  if (src > dst) {
 308:	02b57463          	bgeu	a0,a1,330 <memmove+0x2e>
    while(n-- > 0)
 30c:	00c05f63          	blez	a2,32a <memmove+0x28>
 310:	1602                	sll	a2,a2,0x20
 312:	9201                	srl	a2,a2,0x20
 314:	00c507b3          	add	a5,a0,a2
  dst = vdst;
 318:	872a                	mv	a4,a0
      *dst++ = *src++;
 31a:	0005c683          	lbu	a3,0(a1)
 31e:	0705                	add	a4,a4,1
 320:	0585                	add	a1,a1,1
 322:	fed70fa3          	sb	a3,-1(a4)
    while(n-- > 0)
 326:	fef71ae3          	bne	a4,a5,31a <memmove+0x18>
    src += n;
    while(n-- > 0)
      *--dst = *--src;
  }
  return vdst;
}
 32a:	6422                	ld	s0,8(sp)
 32c:	0141                	add	sp,sp,16
 32e:	8082                	ret
    dst += n;
 330:	00c50733          	add	a4,a0,a2
    src += n;
 334:	95b2                	add	a1,a1,a2
    while(n-- > 0)
 336:	fec05ae3          	blez	a2,32a <memmove+0x28>
 33a:	fff6079b          	addw	a5,a2,-1
 33e:	1782                	sll	a5,a5,0x20
 340:	9381                	srl	a5,a5,0x20
 342:	fff7c793          	not	a5,a5
 346:	97ae                	add	a5,a5,a1
      *--dst = *--src;
 348:	fff5c683          	lbu	a3,-1(a1)
 34c:	15fd                	add	a1,a1,-1
 34e:	177d                	add	a4,a4,-1
 350:	00d70023          	sb	a3,0(a4)
    while(n-- > 0)
 354:	feb79ae3          	bne	a5,a1,348 <memmove+0x46>
}
 358:	6422                	ld	s0,8(sp)
 35a:	0141                	add	sp,sp,16
 35c:	8082                	ret

000000000000035e <memcmp>:

int
memcmp(const void *s1, const void *s2, uint n)
{
 35e:	1141                	add	sp,sp,-16
 360:	e422                	sd	s0,8(sp)
 362:	0800                	add	s0,sp,16
  const char *p1 = s1, *p2 = s2;
  while (n-- > 0) {
 364:	c61d                	beqz	a2,392 <memcmp+0x34>
 366:	fff6069b          	addw	a3,a2,-1
 36a:	1682                	sll	a3,a3,0x20
 36c:	9281                	srl	a3,a3,0x20
 36e:	0685                	add	a3,a3,1
 370:	96aa                	add	a3,a3,a0
 372:	a019                	j	378 <memcmp+0x1a>
 374:	00a68f63          	beq	a3,a0,392 <memcmp+0x34>
    if (*p1 != *p2) {
 378:	00054783          	lbu	a5,0(a0)
 37c:	0005c703          	lbu	a4,0(a1)
      return *p1 - *p2;
    }
    p1++;
 380:	0505                	add	a0,a0,1
    p2++;
 382:	0585                	add	a1,a1,1
    if (*p1 != *p2) {
 384:	fee788e3          	beq	a5,a4,374 <memcmp+0x16>
  }
  return 0;
}
 388:	6422                	ld	s0,8(sp)
      return *p1 - *p2;
 38a:	40e7853b          	subw	a0,a5,a4
}
 38e:	0141                	add	sp,sp,16
 390:	8082                	ret
 392:	6422                	ld	s0,8(sp)
  return 0;
 394:	4501                	li	a0,0
}
 396:	0141                	add	sp,sp,16
 398:	8082                	ret

000000000000039a <memcpy>:

void *
memcpy(void *dst, const void *src, uint n)
{
 39a:	1141                	add	sp,sp,-16
 39c:	e422                	sd	s0,8(sp)
 39e:	0800                	add	s0,sp,16
  return memmove(dst, src, n);
 3a0:	0006079b          	sext.w	a5,a2
  if (src > dst) {
 3a4:	02b57463          	bgeu	a0,a1,3cc <memcpy+0x32>
    while(n-- > 0)
 3a8:	00f05f63          	blez	a5,3c6 <memcpy+0x2c>
 3ac:	1602                	sll	a2,a2,0x20
 3ae:	9201                	srl	a2,a2,0x20
 3b0:	00c587b3          	add	a5,a1,a2
  dst = vdst;
 3b4:	872a                	mv	a4,a0
      *dst++ = *src++;
 3b6:	0005c683          	lbu	a3,0(a1)
 3ba:	0585                	add	a1,a1,1
 3bc:	0705                	add	a4,a4,1
 3be:	fed70fa3          	sb	a3,-1(a4)
    while(n-- > 0)
 3c2:	fef59ae3          	bne	a1,a5,3b6 <memcpy+0x1c>
}
 3c6:	6422                	ld	s0,8(sp)
 3c8:	0141                	add	sp,sp,16
 3ca:	8082                	ret
    dst += n;
 3cc:	00f50733          	add	a4,a0,a5
    src += n;
 3d0:	95be                	add	a1,a1,a5
    while(n-- > 0)
 3d2:	fef05ae3          	blez	a5,3c6 <memcpy+0x2c>
 3d6:	fff6079b          	addw	a5,a2,-1
 3da:	1782                	sll	a5,a5,0x20
 3dc:	9381                	srl	a5,a5,0x20
 3de:	fff7c793          	not	a5,a5
 3e2:	97ae                	add	a5,a5,a1
      *--dst = *--src;
 3e4:	fff5c683          	lbu	a3,-1(a1)
 3e8:	15fd                	add	a1,a1,-1
 3ea:	177d                	add	a4,a4,-1
 3ec:	00d70023          	sb	a3,0(a4)
    while(n-- > 0)
 3f0:	fef59ae3          	bne	a1,a5,3e4 <memcpy+0x4a>
}
 3f4:	6422                	ld	s0,8(sp)
 3f6:	0141                	add	sp,sp,16
 3f8:	8082                	ret

00000000000003fa <fork>:
# generated by usys.pl - do not edit
#include "kern/syscall.h"
.global fork
fork:
 li a7, SYS_fork
 3fa:	4885                	li	a7,1
 ecall
 3fc:	00000073          	ecall
 ret
 400:	8082                	ret

0000000000000402 <exit>:
.global exit
exit:
 li a7, SYS_exit
 402:	4889                	li	a7,2
 ecall
 404:	00000073          	ecall
 ret
 408:	8082                	ret

000000000000040a <wait>:
.global wait
wait:
 li a7, SYS_wait
 40a:	488d                	li	a7,3
 ecall
 40c:	00000073          	ecall
 ret
 410:	8082                	ret

0000000000000412 <pipe>:
.global pipe
pipe:
 li a7, SYS_pipe
 412:	4891                	li	a7,4
 ecall
 414:	00000073          	ecall
 ret
 418:	8082                	ret

000000000000041a <read>:
.global read
read:
 li a7, SYS_read
 41a:	4895                	li	a7,5
 ecall
 41c:	00000073          	ecall
 ret
 420:	8082                	ret

0000000000000422 <write>:
.global write
write:
 li a7, SYS_write
 422:	48c1                	li	a7,16
 ecall
 424:	00000073          	ecall
 ret
 428:	8082                	ret

000000000000042a <close>:
.global close
close:
 li a7, SYS_close
 42a:	48d5                	li	a7,21
 ecall
 42c:	00000073          	ecall
 ret
 430:	8082                	ret

0000000000000432 <kill>:
.global kill
kill:
 li a7, SYS_kill
 432:	4899                	li	a7,6
 ecall
 434:	00000073          	ecall
 ret
 438:	8082                	ret

000000000000043a <exec>:
.global exec
exec:
 li a7, SYS_exec
 43a:	489d                	li	a7,7
 ecall
 43c:	00000073          	ecall
 ret
 440:	8082                	ret

0000000000000442 <open>:
.global open
open:
 li a7, SYS_open
 442:	48bd                	li	a7,15
 ecall
 444:	00000073          	ecall
 ret
 448:	8082                	ret

000000000000044a <mknod>:
.global mknod
mknod:
 li a7, SYS_mknod
 44a:	48c5                	li	a7,17
 ecall
 44c:	00000073          	ecall
 ret
 450:	8082                	ret

0000000000000452 <unlink>:
.global unlink
unlink:
 li a7, SYS_unlink
 452:	48c9                	li	a7,18
 ecall
 454:	00000073          	ecall
 ret
 458:	8082                	ret

000000000000045a <fstat>:
.global fstat
fstat:
 li a7, SYS_fstat
 45a:	48a1                	li	a7,8
 ecall
 45c:	00000073          	ecall
 ret
 460:	8082                	ret

0000000000000462 <link>:
.global link
link:
 li a7, SYS_link
 462:	48cd                	li	a7,19
 ecall
 464:	00000073          	ecall
 ret
 468:	8082                	ret

000000000000046a <mkdir>:
.global mkdir
mkdir:
 li a7, SYS_mkdir
 46a:	48d1                	li	a7,20
 ecall
 46c:	00000073          	ecall
 ret
 470:	8082                	ret

0000000000000472 <chdir>:
.global chdir
chdir:
 li a7, SYS_chdir
 472:	48a5                	li	a7,9
 ecall
 474:	00000073          	ecall
 ret
 478:	8082                	ret

000000000000047a <dup>:
.global dup
dup:
 li a7, SYS_dup
 47a:	48a9                	li	a7,10
 ecall
 47c:	00000073          	ecall
 ret
 480:	8082                	ret

0000000000000482 <getpid>:
.global getpid
getpid:
 li a7, SYS_getpid
 482:	48ad                	li	a7,11
 ecall
 484:	00000073          	ecall
 ret
 488:	8082                	ret

000000000000048a <sbrk>:
.global sbrk
sbrk:
 li a7, SYS_sbrk
 48a:	48b1                	li	a7,12
 ecall
 48c:	00000073          	ecall
 ret
 490:	8082                	ret

0000000000000492 <sleep>:
.global sleep
sleep:
 li a7, SYS_sleep
 492:	48b5                	li	a7,13
 ecall
 494:	00000073          	ecall
 ret
 498:	8082                	ret

000000000000049a <uptime>:
.global uptime
uptime:
 li a7, SYS_uptime
 49a:	48b9                	li	a7,14
 ecall
 49c:	00000073          	ecall
 ret
 4a0:	8082                	ret

00000000000004a2 <poweroff>:
.global poweroff
poweroff:
 li a7, SYS_poweroff
 4a2:	48d9                	li	a7,22
 ecall
 4a4:	00000073          	ecall
 ret
 4a8:	8082                	ret

00000000000004aa <printint>:
  write(fd, &c, 1);
}

static void
printint(int fd, int xx, int base, int sgn)
{
 4aa:	715d                	add	sp,sp,-80
 4ac:	e0a2                	sd	s0,64(sp)
 4ae:	f84a                	sd	s2,48(sp)
 4b0:	e486                	sd	ra,72(sp)
 4b2:	fc26                	sd	s1,56(sp)
 4b4:	f44e                	sd	s3,40(sp)
 4b6:	0880                	add	s0,sp,80
 4b8:	892a                	mv	s2,a0
  char buf[16];
  int i, neg;
  uint x;

  neg = 0;
  if(sgn && xx < 0){
 4ba:	c299                	beqz	a3,4c0 <printint+0x16>
 4bc:	0805c263          	bltz	a1,540 <printint+0x96>
    neg = 1;
    x = -xx;
  } else {
    x = xx;
 4c0:	2581                	sext.w	a1,a1
  neg = 0;
 4c2:	4681                	li	a3,0
  }

  i = 0;
  do{
    buf[i++] = digits[x % base];
 4c4:	2601                	sext.w	a2,a2
 4c6:	fc040713          	add	a4,s0,-64
  i = 0;
 4ca:	4501                	li	a0,0
 4cc:	00000897          	auipc	a7,0x0
 4d0:	4f488893          	add	a7,a7,1268 # 9c0 <digits>
    buf[i++] = digits[x % base];
 4d4:	02c5f7bb          	remuw	a5,a1,a2
  }while((x /= base) != 0);
 4d8:	0705                	add	a4,a4,1
 4da:	0005881b          	sext.w	a6,a1
 4de:	84aa                	mv	s1,a0
    buf[i++] = digits[x % base];
 4e0:	2505                	addw	a0,a0,1
 4e2:	1782                	sll	a5,a5,0x20
 4e4:	9381                	srl	a5,a5,0x20
 4e6:	97c6                	add	a5,a5,a7
 4e8:	0007c783          	lbu	a5,0(a5)
  }while((x /= base) != 0);
 4ec:	02c5d5bb          	divuw	a1,a1,a2
    buf[i++] = digits[x % base];
 4f0:	fef70fa3          	sb	a5,-1(a4)
  }while((x /= base) != 0);
 4f4:	fec870e3          	bgeu	a6,a2,4d4 <printint+0x2a>
  if(neg)
 4f8:	ca89                	beqz	a3,50a <printint+0x60>
    buf[i++] = '-';
 4fa:	fd050793          	add	a5,a0,-48
 4fe:	97a2                	add	a5,a5,s0
 500:	02d00713          	li	a4,45
 504:	fee78823          	sb	a4,-16(a5)

  while(--i >= 0)
 508:	84aa                	mv	s1,a0
 50a:	fc040793          	add	a5,s0,-64
 50e:	94be                	add	s1,s1,a5
 510:	fff78993          	add	s3,a5,-1
    putc(fd, buf[i]);
 514:	0004c783          	lbu	a5,0(s1)
  write(fd, &c, 1);
 518:	4605                	li	a2,1
 51a:	fbf40593          	add	a1,s0,-65
 51e:	854a                	mv	a0,s2
  while(--i >= 0)
 520:	14fd                	add	s1,s1,-1
 522:	faf40fa3          	sb	a5,-65(s0)
  write(fd, &c, 1);
 526:	00000097          	auipc	ra,0x0
 52a:	efc080e7          	jalr	-260(ra) # 422 <write>
  while(--i >= 0)
 52e:	ff3493e3          	bne	s1,s3,514 <printint+0x6a>
}
 532:	60a6                	ld	ra,72(sp)
 534:	6406                	ld	s0,64(sp)
 536:	74e2                	ld	s1,56(sp)
 538:	7942                	ld	s2,48(sp)
 53a:	79a2                	ld	s3,40(sp)
 53c:	6161                	add	sp,sp,80
 53e:	8082                	ret
    x = -xx;
 540:	40b005bb          	negw	a1,a1
 544:	b741                	j	4c4 <printint+0x1a>

0000000000000546 <vprintf>:
}

// Print to the given fd. Only understands %d, %x, %p, %s.
void
vprintf(int fd, const char *fmt, va_list ap)
{
 546:	7159                	add	sp,sp,-112
 548:	f0a2                	sd	s0,96(sp)
 54a:	f486                	sd	ra,104(sp)
 54c:	e8ca                	sd	s2,80(sp)
 54e:	1880                	add	s0,sp,112
  char *s;
  int c, i, state;

  state = 0;
  for(i = 0; fmt[i]; i++){
 550:	0005c903          	lbu	s2,0(a1)
 554:	04090f63          	beqz	s2,5b2 <vprintf+0x6c>
 558:	eca6                	sd	s1,88(sp)
 55a:	e4ce                	sd	s3,72(sp)
 55c:	e0d2                	sd	s4,64(sp)
 55e:	fc56                	sd	s5,56(sp)
 560:	f85a                	sd	s6,48(sp)
 562:	f45e                	sd	s7,40(sp)
 564:	f062                	sd	s8,32(sp)
 566:	8a2a                	mv	s4,a0
 568:	8c32                	mv	s8,a2
 56a:	00158493          	add	s1,a1,1
 56e:	4981                	li	s3,0
      if(c == '%'){
        state = '%';
      } else {
        putc(fd, c);
      }
    } else if(state == '%'){
 570:	02500a93          	li	s5,37
 574:	4bd5                	li	s7,21
 576:	00000b17          	auipc	s6,0x0
 57a:	3f2b0b13          	add	s6,s6,1010 # 968 <malloc+0x13c>
    if(state == 0){
 57e:	02099f63          	bnez	s3,5bc <vprintf+0x76>
      if(c == '%'){
 582:	05590c63          	beq	s2,s5,5da <vprintf+0x94>
  write(fd, &c, 1);
 586:	4605                	li	a2,1
 588:	f9f40593          	add	a1,s0,-97
 58c:	8552                	mv	a0,s4
 58e:	f9240fa3          	sb	s2,-97(s0)
 592:	00000097          	auipc	ra,0x0
 596:	e90080e7          	jalr	-368(ra) # 422 <write>
  for(i = 0; fmt[i]; i++){
 59a:	0004c903          	lbu	s2,0(s1)
 59e:	0485                	add	s1,s1,1
 5a0:	fc091fe3          	bnez	s2,57e <vprintf+0x38>
 5a4:	64e6                	ld	s1,88(sp)
 5a6:	69a6                	ld	s3,72(sp)
 5a8:	6a06                	ld	s4,64(sp)
 5aa:	7ae2                	ld	s5,56(sp)
 5ac:	7b42                	ld	s6,48(sp)
 5ae:	7ba2                	ld	s7,40(sp)
 5b0:	7c02                	ld	s8,32(sp)
        putc(fd, c);
      }
      state = 0;
    }
  }
}
 5b2:	70a6                	ld	ra,104(sp)
 5b4:	7406                	ld	s0,96(sp)
 5b6:	6946                	ld	s2,80(sp)
 5b8:	6165                	add	sp,sp,112
 5ba:	8082                	ret
    } else if(state == '%'){
 5bc:	fd599fe3          	bne	s3,s5,59a <vprintf+0x54>
      if(c == 'd'){
 5c0:	15590463          	beq	s2,s5,708 <vprintf+0x1c2>
 5c4:	f9d9079b          	addw	a5,s2,-99
 5c8:	0ff7f793          	zext.b	a5,a5
 5cc:	00fbea63          	bltu	s7,a5,5e0 <vprintf+0x9a>
 5d0:	078a                	sll	a5,a5,0x2
 5d2:	97da                	add	a5,a5,s6
 5d4:	439c                	lw	a5,0(a5)
 5d6:	97da                	add	a5,a5,s6
 5d8:	8782                	jr	a5
        state = '%';
 5da:	02500993          	li	s3,37
 5de:	bf75                	j	59a <vprintf+0x54>
  write(fd, &c, 1);
 5e0:	f9f40993          	add	s3,s0,-97
 5e4:	4605                	li	a2,1
 5e6:	85ce                	mv	a1,s3
 5e8:	02500793          	li	a5,37
 5ec:	8552                	mv	a0,s4
 5ee:	f8f40fa3          	sb	a5,-97(s0)
 5f2:	00000097          	auipc	ra,0x0
 5f6:	e30080e7          	jalr	-464(ra) # 422 <write>
 5fa:	4605                	li	a2,1
 5fc:	85ce                	mv	a1,s3
 5fe:	8552                	mv	a0,s4
 600:	f9240fa3          	sb	s2,-97(s0)
 604:	00000097          	auipc	ra,0x0
 608:	e1e080e7          	jalr	-482(ra) # 422 <write>
        while(*s != 0){
 60c:	4981                	li	s3,0
 60e:	b771                	j	59a <vprintf+0x54>
        putc(fd, va_arg(ap, uint));
 610:	000c2783          	lw	a5,0(s8)
  write(fd, &c, 1);
 614:	4605                	li	a2,1
 616:	f9f40593          	add	a1,s0,-97
 61a:	8552                	mv	a0,s4
        putc(fd, va_arg(ap, uint));
 61c:	f8f40fa3          	sb	a5,-97(s0)
 620:	0c21                	add	s8,s8,8
  write(fd, &c, 1);
 622:	00000097          	auipc	ra,0x0
 626:	e00080e7          	jalr	-512(ra) # 422 <write>
 62a:	4981                	li	s3,0
 62c:	b7bd                	j	59a <vprintf+0x54>
        printint(fd, va_arg(ap, int), 10, 1);
 62e:	000c2583          	lw	a1,0(s8)
 632:	4685                	li	a3,1
        printint(fd, va_arg(ap, uint64), 10, 0);
 634:	4629                	li	a2,10
 636:	8552                	mv	a0,s4
 638:	0c21                	add	s8,s8,8
 63a:	00000097          	auipc	ra,0x0
 63e:	e70080e7          	jalr	-400(ra) # 4aa <printint>
 642:	4981                	li	s3,0
 644:	bf99                	j	59a <vprintf+0x54>
 646:	000c2583          	lw	a1,0(s8)
 64a:	4681                	li	a3,0
 64c:	b7e5                	j	634 <vprintf+0xee>
  write(fd, &c, 1);
 64e:	f9f40993          	add	s3,s0,-97
 652:	03000793          	li	a5,48
 656:	4605                	li	a2,1
 658:	85ce                	mv	a1,s3
 65a:	8552                	mv	a0,s4
 65c:	ec66                	sd	s9,24(sp)
 65e:	e86a                	sd	s10,16(sp)
        printptr(fd, va_arg(ap, uint64));
 660:	f8f40fa3          	sb	a5,-97(s0)
 664:	000c3d03          	ld	s10,0(s8)
  write(fd, &c, 1);
 668:	00000097          	auipc	ra,0x0
 66c:	dba080e7          	jalr	-582(ra) # 422 <write>
 670:	07800793          	li	a5,120
 674:	4605                	li	a2,1
 676:	85ce                	mv	a1,s3
 678:	8552                	mv	a0,s4
 67a:	f8f40fa3          	sb	a5,-97(s0)
        printptr(fd, va_arg(ap, uint64));
 67e:	0c21                	add	s8,s8,8
  write(fd, &c, 1);
 680:	00000097          	auipc	ra,0x0
 684:	da2080e7          	jalr	-606(ra) # 422 <write>
  putc(fd, 'x');
 688:	4941                	li	s2,16
 68a:	00000c97          	auipc	s9,0x0
 68e:	336c8c93          	add	s9,s9,822 # 9c0 <digits>
    putc(fd, digits[x >> (sizeof(uint64) * 8 - 4)]);
 692:	03cd5793          	srl	a5,s10,0x3c
 696:	97e6                	add	a5,a5,s9
 698:	0007c783          	lbu	a5,0(a5)
  write(fd, &c, 1);
 69c:	4605                	li	a2,1
 69e:	85ce                	mv	a1,s3
 6a0:	8552                	mv	a0,s4
  for (i = 0; i < (sizeof(uint64) * 2); i++, x <<= 4)
 6a2:	397d                	addw	s2,s2,-1
 6a4:	f8f40fa3          	sb	a5,-97(s0)
 6a8:	0d12                	sll	s10,s10,0x4
  write(fd, &c, 1);
 6aa:	00000097          	auipc	ra,0x0
 6ae:	d78080e7          	jalr	-648(ra) # 422 <write>
  for (i = 0; i < (sizeof(uint64) * 2); i++, x <<= 4)
 6b2:	fe0910e3          	bnez	s2,692 <vprintf+0x14c>
 6b6:	6ce2                	ld	s9,24(sp)
 6b8:	6d42                	ld	s10,16(sp)
 6ba:	4981                	li	s3,0
 6bc:	bdf9                	j	59a <vprintf+0x54>
        s = va_arg(ap, char*);
 6be:	000c3903          	ld	s2,0(s8)
 6c2:	0c21                	add	s8,s8,8
        if(s == 0)
 6c4:	04090e63          	beqz	s2,720 <vprintf+0x1da>
        while(*s != 0){
 6c8:	00094783          	lbu	a5,0(s2)
 6cc:	d3a1                	beqz	a5,60c <vprintf+0xc6>
 6ce:	f9f40993          	add	s3,s0,-97
  write(fd, &c, 1);
 6d2:	4605                	li	a2,1
 6d4:	85ce                	mv	a1,s3
 6d6:	8552                	mv	a0,s4
 6d8:	f8f40fa3          	sb	a5,-97(s0)
 6dc:	00000097          	auipc	ra,0x0
 6e0:	d46080e7          	jalr	-698(ra) # 422 <write>
        while(*s != 0){
 6e4:	00194783          	lbu	a5,1(s2)
          s++;
 6e8:	0905                	add	s2,s2,1
        while(*s != 0){
 6ea:	f7e5                	bnez	a5,6d2 <vprintf+0x18c>
 6ec:	4981                	li	s3,0
 6ee:	b575                	j	59a <vprintf+0x54>
        printint(fd, va_arg(ap, int), 16, 0);
 6f0:	000c2583          	lw	a1,0(s8)
 6f4:	4681                	li	a3,0
 6f6:	4641                	li	a2,16
 6f8:	8552                	mv	a0,s4
 6fa:	0c21                	add	s8,s8,8
 6fc:	00000097          	auipc	ra,0x0
 700:	dae080e7          	jalr	-594(ra) # 4aa <printint>
 704:	4981                	li	s3,0
 706:	bd51                	j	59a <vprintf+0x54>
  write(fd, &c, 1);
 708:	4605                	li	a2,1
 70a:	f9f40593          	add	a1,s0,-97
 70e:	8552                	mv	a0,s4
 710:	f9540fa3          	sb	s5,-97(s0)
        while(*s != 0){
 714:	4981                	li	s3,0
  write(fd, &c, 1);
 716:	00000097          	auipc	ra,0x0
 71a:	d0c080e7          	jalr	-756(ra) # 422 <write>
 71e:	bdb5                	j	59a <vprintf+0x54>
          s = "(null)";
 720:	00000917          	auipc	s2,0x0
 724:	24090913          	add	s2,s2,576 # 960 <malloc+0x134>
 728:	02800793          	li	a5,40
 72c:	b74d                	j	6ce <vprintf+0x188>

000000000000072e <fprintf>:

void
fprintf(int fd, const char *fmt, ...)
{
 72e:	715d                	add	sp,sp,-80
 730:	e822                	sd	s0,16(sp)
 732:	ec06                	sd	ra,24(sp)
 734:	1000                	add	s0,sp,32
 736:	e010                	sd	a2,0(s0)
  va_list ap;

  va_start(ap, fmt);
  vprintf(fd, fmt, ap);
 738:	8622                	mv	a2,s0
{
 73a:	e414                	sd	a3,8(s0)
 73c:	e818                	sd	a4,16(s0)
 73e:	ec1c                	sd	a5,24(s0)
 740:	03043023          	sd	a6,32(s0)
 744:	03143423          	sd	a7,40(s0)
  va_start(ap, fmt);
 748:	fe843423          	sd	s0,-24(s0)
  vprintf(fd, fmt, ap);
 74c:	00000097          	auipc	ra,0x0
 750:	dfa080e7          	jalr	-518(ra) # 546 <vprintf>
}
 754:	60e2                	ld	ra,24(sp)
 756:	6442                	ld	s0,16(sp)
 758:	6161                	add	sp,sp,80
 75a:	8082                	ret

000000000000075c <printf>:

void
printf(const char *fmt, ...)
{
 75c:	711d                	add	sp,sp,-96
 75e:	e822                	sd	s0,16(sp)
 760:	ec06                	sd	ra,24(sp)
 762:	1000                	add	s0,sp,32
  va_list ap;

  va_start(ap, fmt);
 764:	00840313          	add	t1,s0,8
{
 768:	e40c                	sd	a1,8(s0)
 76a:	e810                	sd	a2,16(s0)
  vprintf(1, fmt, ap);
 76c:	85aa                	mv	a1,a0
 76e:	861a                	mv	a2,t1
 770:	4505                	li	a0,1
{
 772:	ec14                	sd	a3,24(s0)
 774:	f018                	sd	a4,32(s0)
 776:	f41c                	sd	a5,40(s0)
 778:	03043823          	sd	a6,48(s0)
 77c:	03143c23          	sd	a7,56(s0)
  va_start(ap, fmt);
 780:	fe643423          	sd	t1,-24(s0)
  vprintf(1, fmt, ap);
 784:	00000097          	auipc	ra,0x0
 788:	dc2080e7          	jalr	-574(ra) # 546 <vprintf>
}
 78c:	60e2                	ld	ra,24(sp)
 78e:	6442                	ld	s0,16(sp)
 790:	6125                	add	sp,sp,96
 792:	8082                	ret

0000000000000794 <free>:
static Header base;
static Header *freep;

void
free(void *ap)
{
 794:	1141                	add	sp,sp,-16
 796:	e422                	sd	s0,8(sp)
 798:	0800                	add	s0,sp,16
  Header *bp, *p;

  bp = (Header*)ap - 1;
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 79a:	00001597          	auipc	a1,0x1
 79e:	86658593          	add	a1,a1,-1946 # 1000 <freep>
 7a2:	619c                	ld	a5,0(a1)
  bp = (Header*)ap - 1;
 7a4:	ff050693          	add	a3,a0,-16
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 7a8:	6398                	ld	a4,0(a5)
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 7aa:	02d7ff63          	bgeu	a5,a3,7e8 <free+0x54>
 7ae:	00e6e463          	bltu	a3,a4,7b6 <free+0x22>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 7b2:	02e7ef63          	bltu	a5,a4,7f0 <free+0x5c>
      break;
  if(bp + bp->s.size == p->s.ptr){
 7b6:	ff852803          	lw	a6,-8(a0)
 7ba:	02081893          	sll	a7,a6,0x20
 7be:	01c8d613          	srl	a2,a7,0x1c
 7c2:	9636                	add	a2,a2,a3
 7c4:	02c70863          	beq	a4,a2,7f4 <free+0x60>
    bp->s.size += p->s.ptr->s.size;
    bp->s.ptr = p->s.ptr->s.ptr;
  } else
    bp->s.ptr = p->s.ptr;
  if(p + p->s.size == bp){
 7c8:	0087a803          	lw	a6,8(a5)
 7cc:	fee53823          	sd	a4,-16(a0)
 7d0:	02081893          	sll	a7,a6,0x20
 7d4:	01c8d613          	srl	a2,a7,0x1c
 7d8:	963e                	add	a2,a2,a5
 7da:	02c68e63          	beq	a3,a2,816 <free+0x82>
    p->s.size += bp->s.size;
    p->s.ptr = bp->s.ptr;
  } else
    p->s.ptr = bp;
  freep = p;
}
 7de:	6422                	ld	s0,8(sp)
 7e0:	e394                	sd	a3,0(a5)
  freep = p;
 7e2:	e19c                	sd	a5,0(a1)
}
 7e4:	0141                	add	sp,sp,16
 7e6:	8082                	ret
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 7e8:	00e7e463          	bltu	a5,a4,7f0 <free+0x5c>
 7ec:	fce6e5e3          	bltu	a3,a4,7b6 <free+0x22>
{
 7f0:	87ba                	mv	a5,a4
 7f2:	bf5d                	j	7a8 <free+0x14>
    bp->s.size += p->s.ptr->s.size;
 7f4:	4710                	lw	a2,8(a4)
    bp->s.ptr = p->s.ptr->s.ptr;
 7f6:	6318                	ld	a4,0(a4)
    bp->s.size += p->s.ptr->s.size;
 7f8:	0106063b          	addw	a2,a2,a6
 7fc:	fec52c23          	sw	a2,-8(a0)
  if(p + p->s.size == bp){
 800:	0087a803          	lw	a6,8(a5)
 804:	fee53823          	sd	a4,-16(a0)
 808:	02081893          	sll	a7,a6,0x20
 80c:	01c8d613          	srl	a2,a7,0x1c
 810:	963e                	add	a2,a2,a5
 812:	fcc696e3          	bne	a3,a2,7de <free+0x4a>
    p->s.size += bp->s.size;
 816:	ff852603          	lw	a2,-8(a0)
}
 81a:	6422                	ld	s0,8(sp)
    p->s.ptr = bp->s.ptr;
 81c:	86ba                	mv	a3,a4
    p->s.size += bp->s.size;
 81e:	0106073b          	addw	a4,a2,a6
 822:	c798                	sw	a4,8(a5)
    p->s.ptr = bp->s.ptr;
 824:	e394                	sd	a3,0(a5)
  freep = p;
 826:	e19c                	sd	a5,0(a1)
}
 828:	0141                	add	sp,sp,16
 82a:	8082                	ret

000000000000082c <malloc>:
  return freep;
}

void*
malloc(uint nbytes)
{
 82c:	7139                	add	sp,sp,-64
 82e:	f822                	sd	s0,48(sp)
 830:	f426                	sd	s1,40(sp)
 832:	f04a                	sd	s2,32(sp)
 834:	ec4e                	sd	s3,24(sp)
 836:	fc06                	sd	ra,56(sp)
 838:	0080                	add	s0,sp,64
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
  if((prevp = freep) == 0){
 83a:	00000917          	auipc	s2,0x0
 83e:	7c690913          	add	s2,s2,1990 # 1000 <freep>
  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
 842:	02051493          	sll	s1,a0,0x20
 846:	9081                	srl	s1,s1,0x20
  if((prevp = freep) == 0){
 848:	00093783          	ld	a5,0(s2)
  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
 84c:	04bd                	add	s1,s1,15
 84e:	8091                	srl	s1,s1,0x4
 850:	0014899b          	addw	s3,s1,1
 854:	0485                	add	s1,s1,1
  if((prevp = freep) == 0){
 856:	c3dd                	beqz	a5,8fc <malloc+0xd0>
    base.s.ptr = freep = prevp = &base;
    base.s.size = 0;
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 858:	6388                	ld	a0,0(a5)
    if(p->s.size >= nunits){
 85a:	4518                	lw	a4,8(a0)
 85c:	06977863          	bgeu	a4,s1,8cc <malloc+0xa0>
 860:	e852                	sd	s4,16(sp)
 862:	e456                	sd	s5,8(sp)
 864:	e05a                	sd	s6,0(sp)
  if(nu < 4096)
 866:	6785                	lui	a5,0x1
 868:	8a4e                	mv	s4,s3
 86a:	08f4e763          	bltu	s1,a5,8f8 <malloc+0xcc>
 86e:	000a0b1b          	sext.w	s6,s4
  if(p == (char*)-1)
 872:	5afd                	li	s5,-1
  p = sbrk(nu * sizeof(Header));
 874:	004a1a1b          	sllw	s4,s4,0x4
 878:	a029                	j	882 <malloc+0x56>
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 87a:	6388                	ld	a0,0(a5)
    if(p->s.size >= nunits){
 87c:	4518                	lw	a4,8(a0)
 87e:	04977463          	bgeu	a4,s1,8c6 <malloc+0x9a>
        p->s.size = nunits;
      }
      freep = prevp;
      return (void*)(p + 1);
    }
    if(p == freep)
 882:	00093703          	ld	a4,0(s2)
 886:	87aa                	mv	a5,a0
 888:	fee519e3          	bne	a0,a4,87a <malloc+0x4e>
  p = sbrk(nu * sizeof(Header));
 88c:	8552                	mv	a0,s4
 88e:	00000097          	auipc	ra,0x0
 892:	bfc080e7          	jalr	-1028(ra) # 48a <sbrk>
 896:	87aa                	mv	a5,a0
  free((void*)(hp + 1));
 898:	0541                	add	a0,a0,16
  if(p == (char*)-1)
 89a:	01578b63          	beq	a5,s5,8b0 <malloc+0x84>
  hp->s.size = nu;
 89e:	0167a423          	sw	s6,8(a5) # 1008 <freep+0x8>
  free((void*)(hp + 1));
 8a2:	00000097          	auipc	ra,0x0
 8a6:	ef2080e7          	jalr	-270(ra) # 794 <free>
  return freep;
 8aa:	00093783          	ld	a5,0(s2)
      if((p = morecore(nunits)) == 0)
 8ae:	f7f1                	bnez	a5,87a <malloc+0x4e>
        return 0;
  }
}
 8b0:	70e2                	ld	ra,56(sp)
 8b2:	7442                	ld	s0,48(sp)
        return 0;
 8b4:	6a42                	ld	s4,16(sp)
 8b6:	6aa2                	ld	s5,8(sp)
 8b8:	6b02                	ld	s6,0(sp)
}
 8ba:	74a2                	ld	s1,40(sp)
 8bc:	7902                	ld	s2,32(sp)
 8be:	69e2                	ld	s3,24(sp)
        return 0;
 8c0:	4501                	li	a0,0
}
 8c2:	6121                	add	sp,sp,64
 8c4:	8082                	ret
 8c6:	6a42                	ld	s4,16(sp)
 8c8:	6aa2                	ld	s5,8(sp)
 8ca:	6b02                	ld	s6,0(sp)
      if(p->s.size == nunits)
 8cc:	04e48763          	beq	s1,a4,91a <malloc+0xee>
        p->s.size -= nunits;
 8d0:	4137073b          	subw	a4,a4,s3
        p += p->s.size;
 8d4:	02071613          	sll	a2,a4,0x20
 8d8:	01c65693          	srl	a3,a2,0x1c
        p->s.size -= nunits;
 8dc:	c518                	sw	a4,8(a0)
        p += p->s.size;
 8de:	9536                	add	a0,a0,a3
        p->s.size = nunits;
 8e0:	01352423          	sw	s3,8(a0)
}
 8e4:	70e2                	ld	ra,56(sp)
 8e6:	7442                	ld	s0,48(sp)
      freep = prevp;
 8e8:	00f93023          	sd	a5,0(s2)
}
 8ec:	74a2                	ld	s1,40(sp)
 8ee:	7902                	ld	s2,32(sp)
 8f0:	69e2                	ld	s3,24(sp)
      return (void*)(p + 1);
 8f2:	0541                	add	a0,a0,16
}
 8f4:	6121                	add	sp,sp,64
 8f6:	8082                	ret
  if(nu < 4096)
 8f8:	6a05                	lui	s4,0x1
 8fa:	bf95                	j	86e <malloc+0x42>
 8fc:	e852                	sd	s4,16(sp)
 8fe:	e456                	sd	s5,8(sp)
 900:	e05a                	sd	s6,0(sp)
    base.s.ptr = freep = prevp = &base;
 902:	00000517          	auipc	a0,0x0
 906:	70e50513          	add	a0,a0,1806 # 1010 <base>
 90a:	00a93023          	sd	a0,0(s2)
 90e:	e108                	sd	a0,0(a0)
    base.s.size = 0;
 910:	00000797          	auipc	a5,0x0
 914:	7007a423          	sw	zero,1800(a5) # 1018 <base+0x8>
    if(p->s.size >= nunits){
 918:	b7b9                	j	866 <malloc+0x3a>
        prevp->s.ptr = p->s.ptr;
 91a:	6118                	ld	a4,0(a0)
 91c:	e398                	sd	a4,0(a5)
 91e:	b7d9                	j	8e4 <malloc+0xb8>
