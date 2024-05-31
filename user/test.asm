
user/_test:     file format elf64-littleriscv


Disassembly of section .text:

0000000000000000 <main>:
    int a;
    double b;
    char c;
} BigStruct;

int main() {
   0:	1101                	add	sp,sp,-32
   2:	e822                	sd	s0,16(sp)
   4:	ec06                	sd	ra,24(sp)
   6:	1000                	add	s0,sp,32
    // 大きな型のポインタをmallocで確保
    BigStruct* ptr = (BigStruct*)malloc(sizeof(BigStruct));
   8:	4561                	li	a0,24
   a:	00000097          	auipc	ra,0x0
   e:	77a080e7          	jalr	1914(ra) # 784 <malloc>

    if (ptr == NULL) {
  12:	ed11                	bnez	a0,2e <main+0x2e>
        printf("メモリの確保に失敗しました。\n");
  14:	00001517          	auipc	a0,0x1
  18:	86c50513          	add	a0,a0,-1940 # 880 <shutdown+0x8>
  1c:	00000097          	auipc	ra,0x0
  20:	698080e7          	jalr	1688(ra) # 6b4 <printf>
    free(ptr);

    shutdown();

    return 0;
}
  24:	60e2                	ld	ra,24(sp)
  26:	6442                	ld	s0,16(sp)
  28:	4505                	li	a0,1
  2a:	6105                	add	sp,sp,32
  2c:	8082                	ret
    printf("アライメント後のポインタ: %p\n", (void*)ptr);
  2e:	85aa                	mv	a1,a0
  30:	e426                	sd	s1,8(sp)
  32:	84aa                	mv	s1,a0
  34:	00001517          	auipc	a0,0x1
  38:	87c50513          	add	a0,a0,-1924 # 8b0 <shutdown+0x38>
  3c:	00000097          	auipc	ra,0x0
  40:	678080e7          	jalr	1656(ra) # 6b4 <printf>
    memset(ptr, 0, sizeof(BigStruct));
  44:	4661                	li	a2,24
  46:	4581                	li	a1,0
  48:	8526                	mv	a0,s1
  4a:	00000097          	auipc	ra,0x0
  4e:	0c4080e7          	jalr	196(ra) # 10e <memset>
    free(ptr);
  52:	8526                	mv	a0,s1
  54:	00000097          	auipc	ra,0x0
  58:	698080e7          	jalr	1688(ra) # 6ec <free>
    shutdown();
  5c:	00001097          	auipc	ra,0x1
  60:	81c080e7          	jalr	-2020(ra) # 878 <shutdown>

0000000000000064 <_main>:
//
// wrapper so that it's OK if main() does not call exit().
//
void
_main()
{
  64:	1141                	add	sp,sp,-16
  66:	e022                	sd	s0,0(sp)
  68:	e406                	sd	ra,8(sp)
  6a:	0800                	add	s0,sp,16
  extern int main();
  main();
  6c:	00000097          	auipc	ra,0x0
  70:	f94080e7          	jalr	-108(ra) # 0 <main>
  exit(0);
  74:	4501                	li	a0,0
  76:	00000097          	auipc	ra,0x0
  7a:	2e4080e7          	jalr	740(ra) # 35a <exit>

000000000000007e <strcpy>:
}

char*
strcpy(char *s, const char *t)
{
  7e:	1141                	add	sp,sp,-16
  80:	e422                	sd	s0,8(sp)
  82:	0800                	add	s0,sp,16
  char *os;

  os = s;
  while((*s++ = *t++) != 0)
  84:	87aa                	mv	a5,a0
  86:	0005c703          	lbu	a4,0(a1)
  8a:	0785                	add	a5,a5,1
  8c:	0585                	add	a1,a1,1
  8e:	fee78fa3          	sb	a4,-1(a5)
  92:	fb75                	bnez	a4,86 <strcpy+0x8>
    ;
  return os;
}
  94:	6422                	ld	s0,8(sp)
  96:	0141                	add	sp,sp,16
  98:	8082                	ret

000000000000009a <strcmp>:

int
strcmp(const char *p, const char *q)
{
  9a:	1141                	add	sp,sp,-16
  9c:	e422                	sd	s0,8(sp)
  9e:	0800                	add	s0,sp,16
  while(*p && *p == *q)
  a0:	00054783          	lbu	a5,0(a0)
  a4:	e791                	bnez	a5,b0 <strcmp+0x16>
  a6:	a80d                	j	d8 <strcmp+0x3e>
  a8:	00054783          	lbu	a5,0(a0)
  ac:	cf99                	beqz	a5,ca <strcmp+0x30>
  ae:	85b6                	mv	a1,a3
  b0:	0005c703          	lbu	a4,0(a1)
    p++, q++;
  b4:	0505                	add	a0,a0,1
  b6:	00158693          	add	a3,a1,1
  while(*p && *p == *q)
  ba:	fef707e3          	beq	a4,a5,a8 <strcmp+0xe>
  return (uchar)*p - (uchar)*q;
  be:	0007851b          	sext.w	a0,a5
}
  c2:	6422                	ld	s0,8(sp)
  c4:	9d19                	subw	a0,a0,a4
  c6:	0141                	add	sp,sp,16
  c8:	8082                	ret
  return (uchar)*p - (uchar)*q;
  ca:	0015c703          	lbu	a4,1(a1)
}
  ce:	6422                	ld	s0,8(sp)
  return (uchar)*p - (uchar)*q;
  d0:	4501                	li	a0,0
}
  d2:	9d19                	subw	a0,a0,a4
  d4:	0141                	add	sp,sp,16
  d6:	8082                	ret
  return (uchar)*p - (uchar)*q;
  d8:	0005c703          	lbu	a4,0(a1)
  dc:	4501                	li	a0,0
  de:	b7d5                	j	c2 <strcmp+0x28>

00000000000000e0 <strlen>:

uint
strlen(const char *s)
{
  e0:	1141                	add	sp,sp,-16
  e2:	e422                	sd	s0,8(sp)
  e4:	0800                	add	s0,sp,16
  int n;

  for(n = 0; s[n]; n++)
  e6:	00054783          	lbu	a5,0(a0)
  ea:	cf91                	beqz	a5,106 <strlen+0x26>
  ec:	0505                	add	a0,a0,1
  ee:	87aa                	mv	a5,a0
  f0:	0007c703          	lbu	a4,0(a5)
  f4:	86be                	mv	a3,a5
  f6:	0785                	add	a5,a5,1
  f8:	ff65                	bnez	a4,f0 <strlen+0x10>
    ;
  return n;
}
  fa:	6422                	ld	s0,8(sp)
  fc:	40a6853b          	subw	a0,a3,a0
 100:	2505                	addw	a0,a0,1
 102:	0141                	add	sp,sp,16
 104:	8082                	ret
 106:	6422                	ld	s0,8(sp)
  for(n = 0; s[n]; n++)
 108:	4501                	li	a0,0
}
 10a:	0141                	add	sp,sp,16
 10c:	8082                	ret

000000000000010e <memset>:

void*
memset(void *dst, int c, uint n)
{
 10e:	1141                	add	sp,sp,-16
 110:	e422                	sd	s0,8(sp)
 112:	0800                	add	s0,sp,16
  char *cdst = (char *) dst;
  int i;
  for(i = 0; i < n; i++){
 114:	ce09                	beqz	a2,12e <memset+0x20>
 116:	1602                	sll	a2,a2,0x20
 118:	9201                	srl	a2,a2,0x20
    cdst[i] = c;
 11a:	0ff5f593          	zext.b	a1,a1
 11e:	87aa                	mv	a5,a0
 120:	00a60733          	add	a4,a2,a0
 124:	00b78023          	sb	a1,0(a5)
  for(i = 0; i < n; i++){
 128:	0785                	add	a5,a5,1
 12a:	fee79de3          	bne	a5,a4,124 <memset+0x16>
  }
  return dst;
}
 12e:	6422                	ld	s0,8(sp)
 130:	0141                	add	sp,sp,16
 132:	8082                	ret

0000000000000134 <strchr>:

char*
strchr(const char *s, char c)
{
 134:	1141                	add	sp,sp,-16
 136:	e422                	sd	s0,8(sp)
 138:	0800                	add	s0,sp,16
  for(; *s; s++)
 13a:	00054783          	lbu	a5,0(a0)
 13e:	c799                	beqz	a5,14c <strchr+0x18>
    if(*s == c)
 140:	00f58763          	beq	a1,a5,14e <strchr+0x1a>
  for(; *s; s++)
 144:	00154783          	lbu	a5,1(a0)
 148:	0505                	add	a0,a0,1
 14a:	fbfd                	bnez	a5,140 <strchr+0xc>
      return (char*)s;
  return 0;
 14c:	4501                	li	a0,0
}
 14e:	6422                	ld	s0,8(sp)
 150:	0141                	add	sp,sp,16
 152:	8082                	ret

0000000000000154 <gets>:

char*
gets(char *buf, int max)
{
 154:	711d                	add	sp,sp,-96
 156:	e8a2                	sd	s0,80(sp)
 158:	e4a6                	sd	s1,72(sp)
 15a:	e0ca                	sd	s2,64(sp)
 15c:	fc4e                	sd	s3,56(sp)
 15e:	f852                	sd	s4,48(sp)
 160:	f05a                	sd	s6,32(sp)
 162:	ec5e                	sd	s7,24(sp)
 164:	ec86                	sd	ra,88(sp)
 166:	f456                	sd	s5,40(sp)
 168:	1080                	add	s0,sp,96
 16a:	8baa                	mv	s7,a0
 16c:	89ae                	mv	s3,a1
 16e:	892a                	mv	s2,a0
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
 170:	4481                	li	s1,0
    cc = read(0, &c, 1);
    if(cc < 1)
      break;
    buf[i++] = c;
    if(c == '\n' || c == '\r')
 172:	4a29                	li	s4,10
 174:	4b35                	li	s6,13
  for(i=0; i+1 < max; ){
 176:	a005                	j	196 <gets+0x42>
    cc = read(0, &c, 1);
 178:	00000097          	auipc	ra,0x0
 17c:	1fa080e7          	jalr	506(ra) # 372 <read>
    if(cc < 1)
 180:	02a05363          	blez	a0,1a6 <gets+0x52>
    buf[i++] = c;
 184:	faf44783          	lbu	a5,-81(s0)
    if(c == '\n' || c == '\r')
 188:	0905                	add	s2,s2,1
    buf[i++] = c;
 18a:	fef90fa3          	sb	a5,-1(s2)
    if(c == '\n' || c == '\r')
 18e:	01478d63          	beq	a5,s4,1a8 <gets+0x54>
 192:	01678b63          	beq	a5,s6,1a8 <gets+0x54>
  for(i=0; i+1 < max; ){
 196:	8aa6                	mv	s5,s1
 198:	2485                	addw	s1,s1,1
    cc = read(0, &c, 1);
 19a:	4605                	li	a2,1
 19c:	faf40593          	add	a1,s0,-81
 1a0:	4501                	li	a0,0
  for(i=0; i+1 < max; ){
 1a2:	fd34cbe3          	blt	s1,s3,178 <gets+0x24>
 1a6:	84d6                	mv	s1,s5
      break;
  }
  buf[i] = '\0';
 1a8:	94de                	add	s1,s1,s7
 1aa:	00048023          	sb	zero,0(s1)
  return buf;
}
 1ae:	60e6                	ld	ra,88(sp)
 1b0:	6446                	ld	s0,80(sp)
 1b2:	64a6                	ld	s1,72(sp)
 1b4:	6906                	ld	s2,64(sp)
 1b6:	79e2                	ld	s3,56(sp)
 1b8:	7a42                	ld	s4,48(sp)
 1ba:	7aa2                	ld	s5,40(sp)
 1bc:	7b02                	ld	s6,32(sp)
 1be:	855e                	mv	a0,s7
 1c0:	6be2                	ld	s7,24(sp)
 1c2:	6125                	add	sp,sp,96
 1c4:	8082                	ret

00000000000001c6 <stat>:

int
stat(const char *n, struct stat *st)
{
 1c6:	1101                	add	sp,sp,-32
 1c8:	e822                	sd	s0,16(sp)
 1ca:	e04a                	sd	s2,0(sp)
 1cc:	ec06                	sd	ra,24(sp)
 1ce:	e426                	sd	s1,8(sp)
 1d0:	1000                	add	s0,sp,32
 1d2:	892e                	mv	s2,a1
  int fd;
  int r;

  fd = open(n, O_RDONLY);
 1d4:	4581                	li	a1,0
 1d6:	00000097          	auipc	ra,0x0
 1da:	1c4080e7          	jalr	452(ra) # 39a <open>
  if(fd < 0)
 1de:	02054663          	bltz	a0,20a <stat+0x44>
    return -1;
  r = fstat(fd, st);
 1e2:	85ca                	mv	a1,s2
 1e4:	84aa                	mv	s1,a0
 1e6:	00000097          	auipc	ra,0x0
 1ea:	1cc080e7          	jalr	460(ra) # 3b2 <fstat>
 1ee:	87aa                	mv	a5,a0
  close(fd);
 1f0:	8526                	mv	a0,s1
  r = fstat(fd, st);
 1f2:	84be                	mv	s1,a5
  close(fd);
 1f4:	00000097          	auipc	ra,0x0
 1f8:	18e080e7          	jalr	398(ra) # 382 <close>
  return r;
}
 1fc:	60e2                	ld	ra,24(sp)
 1fe:	6442                	ld	s0,16(sp)
 200:	6902                	ld	s2,0(sp)
 202:	8526                	mv	a0,s1
 204:	64a2                	ld	s1,8(sp)
 206:	6105                	add	sp,sp,32
 208:	8082                	ret
    return -1;
 20a:	54fd                	li	s1,-1
 20c:	bfc5                	j	1fc <stat+0x36>

000000000000020e <atoi>:

int
atoi(const char *s)
{
 20e:	1141                	add	sp,sp,-16
 210:	e422                	sd	s0,8(sp)
 212:	0800                	add	s0,sp,16
  int n;

  n = 0;
  while('0' <= *s && *s <= '9')
 214:	00054683          	lbu	a3,0(a0)
 218:	4625                	li	a2,9
 21a:	fd06879b          	addw	a5,a3,-48
 21e:	0ff7f793          	zext.b	a5,a5
 222:	02f66863          	bltu	a2,a5,252 <atoi+0x44>
 226:	872a                	mv	a4,a0
  n = 0;
 228:	4501                	li	a0,0
    n = n*10 + *s++ - '0';
 22a:	0025179b          	sllw	a5,a0,0x2
 22e:	9fa9                	addw	a5,a5,a0
 230:	0705                	add	a4,a4,1
 232:	0017979b          	sllw	a5,a5,0x1
 236:	9fb5                	addw	a5,a5,a3
  while('0' <= *s && *s <= '9')
 238:	00074683          	lbu	a3,0(a4)
    n = n*10 + *s++ - '0';
 23c:	fd07851b          	addw	a0,a5,-48
  while('0' <= *s && *s <= '9')
 240:	fd06879b          	addw	a5,a3,-48
 244:	0ff7f793          	zext.b	a5,a5
 248:	fef671e3          	bgeu	a2,a5,22a <atoi+0x1c>
  return n;
}
 24c:	6422                	ld	s0,8(sp)
 24e:	0141                	add	sp,sp,16
 250:	8082                	ret
 252:	6422                	ld	s0,8(sp)
  n = 0;
 254:	4501                	li	a0,0
}
 256:	0141                	add	sp,sp,16
 258:	8082                	ret

000000000000025a <memmove>:

void*
memmove(void *vdst, const void *vsrc, int n)
{
 25a:	1141                	add	sp,sp,-16
 25c:	e422                	sd	s0,8(sp)
 25e:	0800                	add	s0,sp,16
  char *dst;
  const char *src;

  dst = vdst;
  src = vsrc;
  if (src > dst) {
 260:	02b57463          	bgeu	a0,a1,288 <memmove+0x2e>
    while(n-- > 0)
 264:	00c05f63          	blez	a2,282 <memmove+0x28>
 268:	1602                	sll	a2,a2,0x20
 26a:	9201                	srl	a2,a2,0x20
 26c:	00c507b3          	add	a5,a0,a2
  dst = vdst;
 270:	872a                	mv	a4,a0
      *dst++ = *src++;
 272:	0005c683          	lbu	a3,0(a1)
 276:	0705                	add	a4,a4,1
 278:	0585                	add	a1,a1,1
 27a:	fed70fa3          	sb	a3,-1(a4)
    while(n-- > 0)
 27e:	fef71ae3          	bne	a4,a5,272 <memmove+0x18>
    src += n;
    while(n-- > 0)
      *--dst = *--src;
  }
  return vdst;
}
 282:	6422                	ld	s0,8(sp)
 284:	0141                	add	sp,sp,16
 286:	8082                	ret
    dst += n;
 288:	00c50733          	add	a4,a0,a2
    src += n;
 28c:	95b2                	add	a1,a1,a2
    while(n-- > 0)
 28e:	fec05ae3          	blez	a2,282 <memmove+0x28>
 292:	fff6079b          	addw	a5,a2,-1
 296:	1782                	sll	a5,a5,0x20
 298:	9381                	srl	a5,a5,0x20
 29a:	fff7c793          	not	a5,a5
 29e:	97ae                	add	a5,a5,a1
      *--dst = *--src;
 2a0:	fff5c683          	lbu	a3,-1(a1)
 2a4:	15fd                	add	a1,a1,-1
 2a6:	177d                	add	a4,a4,-1
 2a8:	00d70023          	sb	a3,0(a4)
    while(n-- > 0)
 2ac:	feb79ae3          	bne	a5,a1,2a0 <memmove+0x46>
}
 2b0:	6422                	ld	s0,8(sp)
 2b2:	0141                	add	sp,sp,16
 2b4:	8082                	ret

00000000000002b6 <memcmp>:

int
memcmp(const void *s1, const void *s2, uint n)
{
 2b6:	1141                	add	sp,sp,-16
 2b8:	e422                	sd	s0,8(sp)
 2ba:	0800                	add	s0,sp,16
  const char *p1 = s1, *p2 = s2;
  while (n-- > 0) {
 2bc:	c61d                	beqz	a2,2ea <memcmp+0x34>
 2be:	fff6069b          	addw	a3,a2,-1
 2c2:	1682                	sll	a3,a3,0x20
 2c4:	9281                	srl	a3,a3,0x20
 2c6:	0685                	add	a3,a3,1
 2c8:	96aa                	add	a3,a3,a0
 2ca:	a019                	j	2d0 <memcmp+0x1a>
 2cc:	00a68f63          	beq	a3,a0,2ea <memcmp+0x34>
    if (*p1 != *p2) {
 2d0:	00054783          	lbu	a5,0(a0)
 2d4:	0005c703          	lbu	a4,0(a1)
      return *p1 - *p2;
    }
    p1++;
 2d8:	0505                	add	a0,a0,1
    p2++;
 2da:	0585                	add	a1,a1,1
    if (*p1 != *p2) {
 2dc:	fee788e3          	beq	a5,a4,2cc <memcmp+0x16>
  }
  return 0;
}
 2e0:	6422                	ld	s0,8(sp)
      return *p1 - *p2;
 2e2:	40e7853b          	subw	a0,a5,a4
}
 2e6:	0141                	add	sp,sp,16
 2e8:	8082                	ret
 2ea:	6422                	ld	s0,8(sp)
  return 0;
 2ec:	4501                	li	a0,0
}
 2ee:	0141                	add	sp,sp,16
 2f0:	8082                	ret

00000000000002f2 <memcpy>:

void *
memcpy(void *dst, const void *src, uint n)
{
 2f2:	1141                	add	sp,sp,-16
 2f4:	e422                	sd	s0,8(sp)
 2f6:	0800                	add	s0,sp,16
  return memmove(dst, src, n);
 2f8:	0006079b          	sext.w	a5,a2
  if (src > dst) {
 2fc:	02b57463          	bgeu	a0,a1,324 <memcpy+0x32>
    while(n-- > 0)
 300:	00f05f63          	blez	a5,31e <memcpy+0x2c>
 304:	1602                	sll	a2,a2,0x20
 306:	9201                	srl	a2,a2,0x20
 308:	00c587b3          	add	a5,a1,a2
  dst = vdst;
 30c:	872a                	mv	a4,a0
      *dst++ = *src++;
 30e:	0005c683          	lbu	a3,0(a1)
 312:	0585                	add	a1,a1,1
 314:	0705                	add	a4,a4,1
 316:	fed70fa3          	sb	a3,-1(a4)
    while(n-- > 0)
 31a:	fef59ae3          	bne	a1,a5,30e <memcpy+0x1c>
}
 31e:	6422                	ld	s0,8(sp)
 320:	0141                	add	sp,sp,16
 322:	8082                	ret
    dst += n;
 324:	00f50733          	add	a4,a0,a5
    src += n;
 328:	95be                	add	a1,a1,a5
    while(n-- > 0)
 32a:	fef05ae3          	blez	a5,31e <memcpy+0x2c>
 32e:	fff6079b          	addw	a5,a2,-1
 332:	1782                	sll	a5,a5,0x20
 334:	9381                	srl	a5,a5,0x20
 336:	fff7c793          	not	a5,a5
 33a:	97ae                	add	a5,a5,a1
      *--dst = *--src;
 33c:	fff5c683          	lbu	a3,-1(a1)
 340:	15fd                	add	a1,a1,-1
 342:	177d                	add	a4,a4,-1
 344:	00d70023          	sb	a3,0(a4)
    while(n-- > 0)
 348:	fef59ae3          	bne	a1,a5,33c <memcpy+0x4a>
}
 34c:	6422                	ld	s0,8(sp)
 34e:	0141                	add	sp,sp,16
 350:	8082                	ret

0000000000000352 <fork>:
# generated by usys.pl - do not edit
#include "kern/syscall.h"
.global fork
fork:
 li a7, SYS_fork
 352:	4885                	li	a7,1
 ecall
 354:	00000073          	ecall
 ret
 358:	8082                	ret

000000000000035a <exit>:
.global exit
exit:
 li a7, SYS_exit
 35a:	4889                	li	a7,2
 ecall
 35c:	00000073          	ecall
 ret
 360:	8082                	ret

0000000000000362 <wait>:
.global wait
wait:
 li a7, SYS_wait
 362:	488d                	li	a7,3
 ecall
 364:	00000073          	ecall
 ret
 368:	8082                	ret

000000000000036a <pipe>:
.global pipe
pipe:
 li a7, SYS_pipe
 36a:	4891                	li	a7,4
 ecall
 36c:	00000073          	ecall
 ret
 370:	8082                	ret

0000000000000372 <read>:
.global read
read:
 li a7, SYS_read
 372:	4895                	li	a7,5
 ecall
 374:	00000073          	ecall
 ret
 378:	8082                	ret

000000000000037a <write>:
.global write
write:
 li a7, SYS_write
 37a:	48c1                	li	a7,16
 ecall
 37c:	00000073          	ecall
 ret
 380:	8082                	ret

0000000000000382 <close>:
.global close
close:
 li a7, SYS_close
 382:	48d5                	li	a7,21
 ecall
 384:	00000073          	ecall
 ret
 388:	8082                	ret

000000000000038a <kill>:
.global kill
kill:
 li a7, SYS_kill
 38a:	4899                	li	a7,6
 ecall
 38c:	00000073          	ecall
 ret
 390:	8082                	ret

0000000000000392 <exec>:
.global exec
exec:
 li a7, SYS_exec
 392:	489d                	li	a7,7
 ecall
 394:	00000073          	ecall
 ret
 398:	8082                	ret

000000000000039a <open>:
.global open
open:
 li a7, SYS_open
 39a:	48bd                	li	a7,15
 ecall
 39c:	00000073          	ecall
 ret
 3a0:	8082                	ret

00000000000003a2 <mknod>:
.global mknod
mknod:
 li a7, SYS_mknod
 3a2:	48c5                	li	a7,17
 ecall
 3a4:	00000073          	ecall
 ret
 3a8:	8082                	ret

00000000000003aa <unlink>:
.global unlink
unlink:
 li a7, SYS_unlink
 3aa:	48c9                	li	a7,18
 ecall
 3ac:	00000073          	ecall
 ret
 3b0:	8082                	ret

00000000000003b2 <fstat>:
.global fstat
fstat:
 li a7, SYS_fstat
 3b2:	48a1                	li	a7,8
 ecall
 3b4:	00000073          	ecall
 ret
 3b8:	8082                	ret

00000000000003ba <link>:
.global link
link:
 li a7, SYS_link
 3ba:	48cd                	li	a7,19
 ecall
 3bc:	00000073          	ecall
 ret
 3c0:	8082                	ret

00000000000003c2 <mkdir>:
.global mkdir
mkdir:
 li a7, SYS_mkdir
 3c2:	48d1                	li	a7,20
 ecall
 3c4:	00000073          	ecall
 ret
 3c8:	8082                	ret

00000000000003ca <chdir>:
.global chdir
chdir:
 li a7, SYS_chdir
 3ca:	48a5                	li	a7,9
 ecall
 3cc:	00000073          	ecall
 ret
 3d0:	8082                	ret

00000000000003d2 <dup>:
.global dup
dup:
 li a7, SYS_dup
 3d2:	48a9                	li	a7,10
 ecall
 3d4:	00000073          	ecall
 ret
 3d8:	8082                	ret

00000000000003da <getpid>:
.global getpid
getpid:
 li a7, SYS_getpid
 3da:	48ad                	li	a7,11
 ecall
 3dc:	00000073          	ecall
 ret
 3e0:	8082                	ret

00000000000003e2 <sbrk>:
.global sbrk
sbrk:
 li a7, SYS_sbrk
 3e2:	48b1                	li	a7,12
 ecall
 3e4:	00000073          	ecall
 ret
 3e8:	8082                	ret

00000000000003ea <sleep>:
.global sleep
sleep:
 li a7, SYS_sleep
 3ea:	48b5                	li	a7,13
 ecall
 3ec:	00000073          	ecall
 ret
 3f0:	8082                	ret

00000000000003f2 <uptime>:
.global uptime
uptime:
 li a7, SYS_uptime
 3f2:	48b9                	li	a7,14
 ecall
 3f4:	00000073          	ecall
 ret
 3f8:	8082                	ret

00000000000003fa <poweroff>:
.global poweroff
poweroff:
 li a7, SYS_poweroff
 3fa:	48d9                	li	a7,22
 ecall
 3fc:	00000073          	ecall
 ret
 400:	8082                	ret

0000000000000402 <printint>:
  write(fd, &c, 1);
}

static void
printint(int fd, int xx, int base, int sgn)
{
 402:	715d                	add	sp,sp,-80
 404:	e0a2                	sd	s0,64(sp)
 406:	f84a                	sd	s2,48(sp)
 408:	e486                	sd	ra,72(sp)
 40a:	fc26                	sd	s1,56(sp)
 40c:	f44e                	sd	s3,40(sp)
 40e:	0880                	add	s0,sp,80
 410:	892a                	mv	s2,a0
  char buf[16];
  int i, neg;
  uint x;

  neg = 0;
  if(sgn && xx < 0){
 412:	c299                	beqz	a3,418 <printint+0x16>
 414:	0805c263          	bltz	a1,498 <printint+0x96>
    neg = 1;
    x = -xx;
  } else {
    x = xx;
 418:	2581                	sext.w	a1,a1
  neg = 0;
 41a:	4681                	li	a3,0
  }

  i = 0;
  do{
    buf[i++] = digits[x % base];
 41c:	2601                	sext.w	a2,a2
 41e:	fc040713          	add	a4,s0,-64
  i = 0;
 422:	4501                	li	a0,0
 424:	00000897          	auipc	a7,0x0
 428:	51c88893          	add	a7,a7,1308 # 940 <digits>
    buf[i++] = digits[x % base];
 42c:	02c5f7bb          	remuw	a5,a1,a2
  }while((x /= base) != 0);
 430:	0705                	add	a4,a4,1
 432:	0005881b          	sext.w	a6,a1
 436:	84aa                	mv	s1,a0
    buf[i++] = digits[x % base];
 438:	2505                	addw	a0,a0,1
 43a:	1782                	sll	a5,a5,0x20
 43c:	9381                	srl	a5,a5,0x20
 43e:	97c6                	add	a5,a5,a7
 440:	0007c783          	lbu	a5,0(a5)
  }while((x /= base) != 0);
 444:	02c5d5bb          	divuw	a1,a1,a2
    buf[i++] = digits[x % base];
 448:	fef70fa3          	sb	a5,-1(a4)
  }while((x /= base) != 0);
 44c:	fec870e3          	bgeu	a6,a2,42c <printint+0x2a>
  if(neg)
 450:	ca89                	beqz	a3,462 <printint+0x60>
    buf[i++] = '-';
 452:	fd050793          	add	a5,a0,-48
 456:	97a2                	add	a5,a5,s0
 458:	02d00713          	li	a4,45
 45c:	fee78823          	sb	a4,-16(a5)

  while(--i >= 0)
 460:	84aa                	mv	s1,a0
 462:	fc040793          	add	a5,s0,-64
 466:	94be                	add	s1,s1,a5
 468:	fff78993          	add	s3,a5,-1
    putc(fd, buf[i]);
 46c:	0004c783          	lbu	a5,0(s1)
  write(fd, &c, 1);
 470:	4605                	li	a2,1
 472:	fbf40593          	add	a1,s0,-65
 476:	854a                	mv	a0,s2
  while(--i >= 0)
 478:	14fd                	add	s1,s1,-1
 47a:	faf40fa3          	sb	a5,-65(s0)
  write(fd, &c, 1);
 47e:	00000097          	auipc	ra,0x0
 482:	efc080e7          	jalr	-260(ra) # 37a <write>
  while(--i >= 0)
 486:	ff3493e3          	bne	s1,s3,46c <printint+0x6a>
}
 48a:	60a6                	ld	ra,72(sp)
 48c:	6406                	ld	s0,64(sp)
 48e:	74e2                	ld	s1,56(sp)
 490:	7942                	ld	s2,48(sp)
 492:	79a2                	ld	s3,40(sp)
 494:	6161                	add	sp,sp,80
 496:	8082                	ret
    x = -xx;
 498:	40b005bb          	negw	a1,a1
 49c:	b741                	j	41c <printint+0x1a>

000000000000049e <vprintf>:
}

// Print to the given fd. Only understands %d, %x, %p, %s.
void
vprintf(int fd, const char *fmt, va_list ap)
{
 49e:	7159                	add	sp,sp,-112
 4a0:	f0a2                	sd	s0,96(sp)
 4a2:	f486                	sd	ra,104(sp)
 4a4:	e8ca                	sd	s2,80(sp)
 4a6:	1880                	add	s0,sp,112
  char *s;
  int c, i, state;

  state = 0;
  for(i = 0; fmt[i]; i++){
 4a8:	0005c903          	lbu	s2,0(a1)
 4ac:	04090f63          	beqz	s2,50a <vprintf+0x6c>
 4b0:	eca6                	sd	s1,88(sp)
 4b2:	e4ce                	sd	s3,72(sp)
 4b4:	e0d2                	sd	s4,64(sp)
 4b6:	fc56                	sd	s5,56(sp)
 4b8:	f85a                	sd	s6,48(sp)
 4ba:	f45e                	sd	s7,40(sp)
 4bc:	f062                	sd	s8,32(sp)
 4be:	8a2a                	mv	s4,a0
 4c0:	8c32                	mv	s8,a2
 4c2:	00158493          	add	s1,a1,1
 4c6:	4981                	li	s3,0
      if(c == '%'){
        state = '%';
      } else {
        putc(fd, c);
      }
    } else if(state == '%'){
 4c8:	02500a93          	li	s5,37
 4cc:	4bd5                	li	s7,21
 4ce:	00000b17          	auipc	s6,0x0
 4d2:	41ab0b13          	add	s6,s6,1050 # 8e8 <shutdown+0x70>
    if(state == 0){
 4d6:	02099f63          	bnez	s3,514 <vprintf+0x76>
      if(c == '%'){
 4da:	05590c63          	beq	s2,s5,532 <vprintf+0x94>
  write(fd, &c, 1);
 4de:	4605                	li	a2,1
 4e0:	f9f40593          	add	a1,s0,-97
 4e4:	8552                	mv	a0,s4
 4e6:	f9240fa3          	sb	s2,-97(s0)
 4ea:	00000097          	auipc	ra,0x0
 4ee:	e90080e7          	jalr	-368(ra) # 37a <write>
  for(i = 0; fmt[i]; i++){
 4f2:	0004c903          	lbu	s2,0(s1)
 4f6:	0485                	add	s1,s1,1
 4f8:	fc091fe3          	bnez	s2,4d6 <vprintf+0x38>
 4fc:	64e6                	ld	s1,88(sp)
 4fe:	69a6                	ld	s3,72(sp)
 500:	6a06                	ld	s4,64(sp)
 502:	7ae2                	ld	s5,56(sp)
 504:	7b42                	ld	s6,48(sp)
 506:	7ba2                	ld	s7,40(sp)
 508:	7c02                	ld	s8,32(sp)
        putc(fd, c);
      }
      state = 0;
    }
  }
}
 50a:	70a6                	ld	ra,104(sp)
 50c:	7406                	ld	s0,96(sp)
 50e:	6946                	ld	s2,80(sp)
 510:	6165                	add	sp,sp,112
 512:	8082                	ret
    } else if(state == '%'){
 514:	fd599fe3          	bne	s3,s5,4f2 <vprintf+0x54>
      if(c == 'd'){
 518:	15590463          	beq	s2,s5,660 <vprintf+0x1c2>
 51c:	f9d9079b          	addw	a5,s2,-99
 520:	0ff7f793          	zext.b	a5,a5
 524:	00fbea63          	bltu	s7,a5,538 <vprintf+0x9a>
 528:	078a                	sll	a5,a5,0x2
 52a:	97da                	add	a5,a5,s6
 52c:	439c                	lw	a5,0(a5)
 52e:	97da                	add	a5,a5,s6
 530:	8782                	jr	a5
        state = '%';
 532:	02500993          	li	s3,37
 536:	bf75                	j	4f2 <vprintf+0x54>
  write(fd, &c, 1);
 538:	f9f40993          	add	s3,s0,-97
 53c:	4605                	li	a2,1
 53e:	85ce                	mv	a1,s3
 540:	02500793          	li	a5,37
 544:	8552                	mv	a0,s4
 546:	f8f40fa3          	sb	a5,-97(s0)
 54a:	00000097          	auipc	ra,0x0
 54e:	e30080e7          	jalr	-464(ra) # 37a <write>
 552:	4605                	li	a2,1
 554:	85ce                	mv	a1,s3
 556:	8552                	mv	a0,s4
 558:	f9240fa3          	sb	s2,-97(s0)
 55c:	00000097          	auipc	ra,0x0
 560:	e1e080e7          	jalr	-482(ra) # 37a <write>
        while(*s != 0){
 564:	4981                	li	s3,0
 566:	b771                	j	4f2 <vprintf+0x54>
        putc(fd, va_arg(ap, uint));
 568:	000c2783          	lw	a5,0(s8)
  write(fd, &c, 1);
 56c:	4605                	li	a2,1
 56e:	f9f40593          	add	a1,s0,-97
 572:	8552                	mv	a0,s4
        putc(fd, va_arg(ap, uint));
 574:	f8f40fa3          	sb	a5,-97(s0)
 578:	0c21                	add	s8,s8,8
  write(fd, &c, 1);
 57a:	00000097          	auipc	ra,0x0
 57e:	e00080e7          	jalr	-512(ra) # 37a <write>
 582:	4981                	li	s3,0
 584:	b7bd                	j	4f2 <vprintf+0x54>
        printint(fd, va_arg(ap, int), 10, 1);
 586:	000c2583          	lw	a1,0(s8)
 58a:	4685                	li	a3,1
        printint(fd, va_arg(ap, uint64), 10, 0);
 58c:	4629                	li	a2,10
 58e:	8552                	mv	a0,s4
 590:	0c21                	add	s8,s8,8
 592:	00000097          	auipc	ra,0x0
 596:	e70080e7          	jalr	-400(ra) # 402 <printint>
 59a:	4981                	li	s3,0
 59c:	bf99                	j	4f2 <vprintf+0x54>
 59e:	000c2583          	lw	a1,0(s8)
 5a2:	4681                	li	a3,0
 5a4:	b7e5                	j	58c <vprintf+0xee>
  write(fd, &c, 1);
 5a6:	f9f40993          	add	s3,s0,-97
 5aa:	03000793          	li	a5,48
 5ae:	4605                	li	a2,1
 5b0:	85ce                	mv	a1,s3
 5b2:	8552                	mv	a0,s4
 5b4:	ec66                	sd	s9,24(sp)
 5b6:	e86a                	sd	s10,16(sp)
        printptr(fd, va_arg(ap, uint64));
 5b8:	f8f40fa3          	sb	a5,-97(s0)
 5bc:	000c3d03          	ld	s10,0(s8)
  write(fd, &c, 1);
 5c0:	00000097          	auipc	ra,0x0
 5c4:	dba080e7          	jalr	-582(ra) # 37a <write>
 5c8:	07800793          	li	a5,120
 5cc:	4605                	li	a2,1
 5ce:	85ce                	mv	a1,s3
 5d0:	8552                	mv	a0,s4
 5d2:	f8f40fa3          	sb	a5,-97(s0)
        printptr(fd, va_arg(ap, uint64));
 5d6:	0c21                	add	s8,s8,8
  write(fd, &c, 1);
 5d8:	00000097          	auipc	ra,0x0
 5dc:	da2080e7          	jalr	-606(ra) # 37a <write>
  putc(fd, 'x');
 5e0:	4941                	li	s2,16
 5e2:	00000c97          	auipc	s9,0x0
 5e6:	35ec8c93          	add	s9,s9,862 # 940 <digits>
    putc(fd, digits[x >> (sizeof(uint64) * 8 - 4)]);
 5ea:	03cd5793          	srl	a5,s10,0x3c
 5ee:	97e6                	add	a5,a5,s9
 5f0:	0007c783          	lbu	a5,0(a5)
  write(fd, &c, 1);
 5f4:	4605                	li	a2,1
 5f6:	85ce                	mv	a1,s3
 5f8:	8552                	mv	a0,s4
  for (i = 0; i < (sizeof(uint64) * 2); i++, x <<= 4)
 5fa:	397d                	addw	s2,s2,-1
 5fc:	f8f40fa3          	sb	a5,-97(s0)
 600:	0d12                	sll	s10,s10,0x4
  write(fd, &c, 1);
 602:	00000097          	auipc	ra,0x0
 606:	d78080e7          	jalr	-648(ra) # 37a <write>
  for (i = 0; i < (sizeof(uint64) * 2); i++, x <<= 4)
 60a:	fe0910e3          	bnez	s2,5ea <vprintf+0x14c>
 60e:	6ce2                	ld	s9,24(sp)
 610:	6d42                	ld	s10,16(sp)
 612:	4981                	li	s3,0
 614:	bdf9                	j	4f2 <vprintf+0x54>
        s = va_arg(ap, char*);
 616:	000c3903          	ld	s2,0(s8)
 61a:	0c21                	add	s8,s8,8
        if(s == 0)
 61c:	04090e63          	beqz	s2,678 <vprintf+0x1da>
        while(*s != 0){
 620:	00094783          	lbu	a5,0(s2)
 624:	d3a1                	beqz	a5,564 <vprintf+0xc6>
 626:	f9f40993          	add	s3,s0,-97
  write(fd, &c, 1);
 62a:	4605                	li	a2,1
 62c:	85ce                	mv	a1,s3
 62e:	8552                	mv	a0,s4
 630:	f8f40fa3          	sb	a5,-97(s0)
 634:	00000097          	auipc	ra,0x0
 638:	d46080e7          	jalr	-698(ra) # 37a <write>
        while(*s != 0){
 63c:	00194783          	lbu	a5,1(s2)
          s++;
 640:	0905                	add	s2,s2,1
        while(*s != 0){
 642:	f7e5                	bnez	a5,62a <vprintf+0x18c>
 644:	4981                	li	s3,0
 646:	b575                	j	4f2 <vprintf+0x54>
        printint(fd, va_arg(ap, int), 16, 0);
 648:	000c2583          	lw	a1,0(s8)
 64c:	4681                	li	a3,0
 64e:	4641                	li	a2,16
 650:	8552                	mv	a0,s4
 652:	0c21                	add	s8,s8,8
 654:	00000097          	auipc	ra,0x0
 658:	dae080e7          	jalr	-594(ra) # 402 <printint>
 65c:	4981                	li	s3,0
 65e:	bd51                	j	4f2 <vprintf+0x54>
  write(fd, &c, 1);
 660:	4605                	li	a2,1
 662:	f9f40593          	add	a1,s0,-97
 666:	8552                	mv	a0,s4
 668:	f9540fa3          	sb	s5,-97(s0)
        while(*s != 0){
 66c:	4981                	li	s3,0
  write(fd, &c, 1);
 66e:	00000097          	auipc	ra,0x0
 672:	d0c080e7          	jalr	-756(ra) # 37a <write>
 676:	bdb5                	j	4f2 <vprintf+0x54>
          s = "(null)";
 678:	00000917          	auipc	s2,0x0
 67c:	26890913          	add	s2,s2,616 # 8e0 <shutdown+0x68>
 680:	02800793          	li	a5,40
 684:	b74d                	j	626 <vprintf+0x188>

0000000000000686 <fprintf>:

void
fprintf(int fd, const char *fmt, ...)
{
 686:	715d                	add	sp,sp,-80
 688:	e822                	sd	s0,16(sp)
 68a:	ec06                	sd	ra,24(sp)
 68c:	1000                	add	s0,sp,32
 68e:	e010                	sd	a2,0(s0)
  va_list ap;

  va_start(ap, fmt);
  vprintf(fd, fmt, ap);
 690:	8622                	mv	a2,s0
{
 692:	e414                	sd	a3,8(s0)
 694:	e818                	sd	a4,16(s0)
 696:	ec1c                	sd	a5,24(s0)
 698:	03043023          	sd	a6,32(s0)
 69c:	03143423          	sd	a7,40(s0)
  va_start(ap, fmt);
 6a0:	fe843423          	sd	s0,-24(s0)
  vprintf(fd, fmt, ap);
 6a4:	00000097          	auipc	ra,0x0
 6a8:	dfa080e7          	jalr	-518(ra) # 49e <vprintf>
}
 6ac:	60e2                	ld	ra,24(sp)
 6ae:	6442                	ld	s0,16(sp)
 6b0:	6161                	add	sp,sp,80
 6b2:	8082                	ret

00000000000006b4 <printf>:

void
printf(const char *fmt, ...)
{
 6b4:	711d                	add	sp,sp,-96
 6b6:	e822                	sd	s0,16(sp)
 6b8:	ec06                	sd	ra,24(sp)
 6ba:	1000                	add	s0,sp,32
  va_list ap;

  va_start(ap, fmt);
 6bc:	00840313          	add	t1,s0,8
{
 6c0:	e40c                	sd	a1,8(s0)
 6c2:	e810                	sd	a2,16(s0)
  vprintf(1, fmt, ap);
 6c4:	85aa                	mv	a1,a0
 6c6:	861a                	mv	a2,t1
 6c8:	4505                	li	a0,1
{
 6ca:	ec14                	sd	a3,24(s0)
 6cc:	f018                	sd	a4,32(s0)
 6ce:	f41c                	sd	a5,40(s0)
 6d0:	03043823          	sd	a6,48(s0)
 6d4:	03143c23          	sd	a7,56(s0)
  va_start(ap, fmt);
 6d8:	fe643423          	sd	t1,-24(s0)
  vprintf(1, fmt, ap);
 6dc:	00000097          	auipc	ra,0x0
 6e0:	dc2080e7          	jalr	-574(ra) # 49e <vprintf>
}
 6e4:	60e2                	ld	ra,24(sp)
 6e6:	6442                	ld	s0,16(sp)
 6e8:	6125                	add	sp,sp,96
 6ea:	8082                	ret

00000000000006ec <free>:
static Header base;
static Header *freep;

void
free(void *ap)
{
 6ec:	1141                	add	sp,sp,-16
 6ee:	e422                	sd	s0,8(sp)
 6f0:	0800                	add	s0,sp,16
  Header *bp, *p;

  bp = (Header*)ap - 1;
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 6f2:	00001597          	auipc	a1,0x1
 6f6:	90e58593          	add	a1,a1,-1778 # 1000 <freep>
 6fa:	619c                	ld	a5,0(a1)
  bp = (Header*)ap - 1;
 6fc:	ff050693          	add	a3,a0,-16
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 700:	6398                	ld	a4,0(a5)
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 702:	02d7ff63          	bgeu	a5,a3,740 <free+0x54>
 706:	00e6e463          	bltu	a3,a4,70e <free+0x22>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 70a:	02e7ef63          	bltu	a5,a4,748 <free+0x5c>
      break;
  if(bp + bp->s.size == p->s.ptr){
 70e:	ff852803          	lw	a6,-8(a0)
 712:	02081893          	sll	a7,a6,0x20
 716:	01c8d613          	srl	a2,a7,0x1c
 71a:	9636                	add	a2,a2,a3
 71c:	02c70863          	beq	a4,a2,74c <free+0x60>
    bp->s.size += p->s.ptr->s.size;
    bp->s.ptr = p->s.ptr->s.ptr;
  } else
    bp->s.ptr = p->s.ptr;
  if(p + p->s.size == bp){
 720:	0087a803          	lw	a6,8(a5)
 724:	fee53823          	sd	a4,-16(a0)
 728:	02081893          	sll	a7,a6,0x20
 72c:	01c8d613          	srl	a2,a7,0x1c
 730:	963e                	add	a2,a2,a5
 732:	02c68e63          	beq	a3,a2,76e <free+0x82>
    p->s.size += bp->s.size;
    p->s.ptr = bp->s.ptr;
  } else
    p->s.ptr = bp;
  freep = p;
}
 736:	6422                	ld	s0,8(sp)
 738:	e394                	sd	a3,0(a5)
  freep = p;
 73a:	e19c                	sd	a5,0(a1)
}
 73c:	0141                	add	sp,sp,16
 73e:	8082                	ret
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 740:	00e7e463          	bltu	a5,a4,748 <free+0x5c>
 744:	fce6e5e3          	bltu	a3,a4,70e <free+0x22>
{
 748:	87ba                	mv	a5,a4
 74a:	bf5d                	j	700 <free+0x14>
    bp->s.size += p->s.ptr->s.size;
 74c:	4710                	lw	a2,8(a4)
    bp->s.ptr = p->s.ptr->s.ptr;
 74e:	6318                	ld	a4,0(a4)
    bp->s.size += p->s.ptr->s.size;
 750:	0106063b          	addw	a2,a2,a6
 754:	fec52c23          	sw	a2,-8(a0)
  if(p + p->s.size == bp){
 758:	0087a803          	lw	a6,8(a5)
 75c:	fee53823          	sd	a4,-16(a0)
 760:	02081893          	sll	a7,a6,0x20
 764:	01c8d613          	srl	a2,a7,0x1c
 768:	963e                	add	a2,a2,a5
 76a:	fcc696e3          	bne	a3,a2,736 <free+0x4a>
    p->s.size += bp->s.size;
 76e:	ff852603          	lw	a2,-8(a0)
}
 772:	6422                	ld	s0,8(sp)
    p->s.ptr = bp->s.ptr;
 774:	86ba                	mv	a3,a4
    p->s.size += bp->s.size;
 776:	0106073b          	addw	a4,a2,a6
 77a:	c798                	sw	a4,8(a5)
    p->s.ptr = bp->s.ptr;
 77c:	e394                	sd	a3,0(a5)
  freep = p;
 77e:	e19c                	sd	a5,0(a1)
}
 780:	0141                	add	sp,sp,16
 782:	8082                	ret

0000000000000784 <malloc>:
  return freep;
}

void*
malloc(uint nbytes)
{
 784:	7139                	add	sp,sp,-64
 786:	f822                	sd	s0,48(sp)
 788:	f426                	sd	s1,40(sp)
 78a:	f04a                	sd	s2,32(sp)
 78c:	ec4e                	sd	s3,24(sp)
 78e:	fc06                	sd	ra,56(sp)
 790:	0080                	add	s0,sp,64
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
  if((prevp = freep) == 0){
 792:	00001917          	auipc	s2,0x1
 796:	86e90913          	add	s2,s2,-1938 # 1000 <freep>
  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
 79a:	02051493          	sll	s1,a0,0x20
 79e:	9081                	srl	s1,s1,0x20
  if((prevp = freep) == 0){
 7a0:	00093783          	ld	a5,0(s2)
  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
 7a4:	04bd                	add	s1,s1,15
 7a6:	8091                	srl	s1,s1,0x4
 7a8:	0014899b          	addw	s3,s1,1
 7ac:	0485                	add	s1,s1,1
  if((prevp = freep) == 0){
 7ae:	c3dd                	beqz	a5,854 <malloc+0xd0>
    base.s.ptr = freep = prevp = &base;
    base.s.size = 0;
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 7b0:	6388                	ld	a0,0(a5)
    if(p->s.size >= nunits){
 7b2:	4518                	lw	a4,8(a0)
 7b4:	06977863          	bgeu	a4,s1,824 <malloc+0xa0>
 7b8:	e852                	sd	s4,16(sp)
 7ba:	e456                	sd	s5,8(sp)
 7bc:	e05a                	sd	s6,0(sp)
  if(nu < 4096)
 7be:	6785                	lui	a5,0x1
 7c0:	8a4e                	mv	s4,s3
 7c2:	08f4e763          	bltu	s1,a5,850 <malloc+0xcc>
 7c6:	000a0b1b          	sext.w	s6,s4
  if(p == (char*)-1)
 7ca:	5afd                	li	s5,-1
  p = sbrk(nu * sizeof(Header));
 7cc:	004a1a1b          	sllw	s4,s4,0x4
 7d0:	a029                	j	7da <malloc+0x56>
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 7d2:	6388                	ld	a0,0(a5)
    if(p->s.size >= nunits){
 7d4:	4518                	lw	a4,8(a0)
 7d6:	04977463          	bgeu	a4,s1,81e <malloc+0x9a>
        p->s.size = nunits;
      }
      freep = prevp;
      return (void*)(p + 1);
    }
    if(p == freep)
 7da:	00093703          	ld	a4,0(s2)
 7de:	87aa                	mv	a5,a0
 7e0:	fee519e3          	bne	a0,a4,7d2 <malloc+0x4e>
  p = sbrk(nu * sizeof(Header));
 7e4:	8552                	mv	a0,s4
 7e6:	00000097          	auipc	ra,0x0
 7ea:	bfc080e7          	jalr	-1028(ra) # 3e2 <sbrk>
 7ee:	87aa                	mv	a5,a0
  free((void*)(hp + 1));
 7f0:	0541                	add	a0,a0,16
  if(p == (char*)-1)
 7f2:	01578b63          	beq	a5,s5,808 <malloc+0x84>
  hp->s.size = nu;
 7f6:	0167a423          	sw	s6,8(a5) # 1008 <freep+0x8>
  free((void*)(hp + 1));
 7fa:	00000097          	auipc	ra,0x0
 7fe:	ef2080e7          	jalr	-270(ra) # 6ec <free>
  return freep;
 802:	00093783          	ld	a5,0(s2)
      if((p = morecore(nunits)) == 0)
 806:	f7f1                	bnez	a5,7d2 <malloc+0x4e>
        return 0;
  }
}
 808:	70e2                	ld	ra,56(sp)
 80a:	7442                	ld	s0,48(sp)
        return 0;
 80c:	6a42                	ld	s4,16(sp)
 80e:	6aa2                	ld	s5,8(sp)
 810:	6b02                	ld	s6,0(sp)
}
 812:	74a2                	ld	s1,40(sp)
 814:	7902                	ld	s2,32(sp)
 816:	69e2                	ld	s3,24(sp)
        return 0;
 818:	4501                	li	a0,0
}
 81a:	6121                	add	sp,sp,64
 81c:	8082                	ret
 81e:	6a42                	ld	s4,16(sp)
 820:	6aa2                	ld	s5,8(sp)
 822:	6b02                	ld	s6,0(sp)
      if(p->s.size == nunits)
 824:	04e48763          	beq	s1,a4,872 <malloc+0xee>
        p->s.size -= nunits;
 828:	4137073b          	subw	a4,a4,s3
        p += p->s.size;
 82c:	02071613          	sll	a2,a4,0x20
 830:	01c65693          	srl	a3,a2,0x1c
        p->s.size -= nunits;
 834:	c518                	sw	a4,8(a0)
        p += p->s.size;
 836:	9536                	add	a0,a0,a3
        p->s.size = nunits;
 838:	01352423          	sw	s3,8(a0)
}
 83c:	70e2                	ld	ra,56(sp)
 83e:	7442                	ld	s0,48(sp)
      freep = prevp;
 840:	00f93023          	sd	a5,0(s2)
}
 844:	74a2                	ld	s1,40(sp)
 846:	7902                	ld	s2,32(sp)
 848:	69e2                	ld	s3,24(sp)
      return (void*)(p + 1);
 84a:	0541                	add	a0,a0,16
}
 84c:	6121                	add	sp,sp,64
 84e:	8082                	ret
  if(nu < 4096)
 850:	6a05                	lui	s4,0x1
 852:	bf95                	j	7c6 <malloc+0x42>
 854:	e852                	sd	s4,16(sp)
 856:	e456                	sd	s5,8(sp)
 858:	e05a                	sd	s6,0(sp)
    base.s.ptr = freep = prevp = &base;
 85a:	00000517          	auipc	a0,0x0
 85e:	7b650513          	add	a0,a0,1974 # 1010 <base>
 862:	00a93023          	sd	a0,0(s2)
 866:	e108                	sd	a0,0(a0)
    base.s.size = 0;
 868:	00000797          	auipc	a5,0x0
 86c:	7a07a823          	sw	zero,1968(a5) # 1018 <base+0x8>
    if(p->s.size >= nunits){
 870:	b7b9                	j	7be <malloc+0x3a>
        prevp->s.ptr = p->s.ptr;
 872:	6118                	ld	a4,0(a0)
 874:	e398                	sd	a4,0(a5)
 876:	b7d9                	j	83c <malloc+0xb8>

0000000000000878 <shutdown>:
const user = @cImport({
    @cInclude("user/user.h");
});

pub export fn shutdown() void {
    user.poweroff();
 878:	00000097          	auipc	ra,0x0
 87c:	b82080e7          	jalr	-1150(ra) # 3fa <poweroff>
