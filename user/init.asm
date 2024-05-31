
user/_init:     file format elf64-littleriscv


Disassembly of section .text:

0000000000000000 <main>:

char *argv[] = { "sh", 0 };

int
main(void)
{
   0:	1101                	add	sp,sp,-32
   2:	e822                	sd	s0,16(sp)
   4:	ec06                	sd	ra,24(sp)
   6:	e426                	sd	s1,8(sp)
   8:	e04a                	sd	s2,0(sp)
   a:	1000                	add	s0,sp,32
  int pid, wpid;

  if(open("console", O_RDWR) < 0){
   c:	4589                	li	a1,2
   e:	00001517          	auipc	a0,0x1
  12:	90250513          	add	a0,a0,-1790 # 910 <malloc+0xf8>
  16:	00000097          	auipc	ra,0x0
  1a:	418080e7          	jalr	1048(ra) # 42e <open>
  1e:	06054363          	bltz	a0,84 <main+0x84>
    mknod("console", CONSOLE, 0);
    open("console", O_RDWR);
  }
  dup(0);  // stdout
  22:	4501                	li	a0,0
  24:	00000097          	auipc	ra,0x0
  28:	442080e7          	jalr	1090(ra) # 466 <dup>
  dup(0);  // stderr
  2c:	4501                	li	a0,0
  2e:	00000097          	auipc	ra,0x0
  32:	438080e7          	jalr	1080(ra) # 466 <dup>

  for(;;){
    printf("init: starting sh\n");
  36:	00001917          	auipc	s2,0x1
  3a:	8e290913          	add	s2,s2,-1822 # 918 <malloc+0x100>
  3e:	854a                	mv	a0,s2
  40:	00000097          	auipc	ra,0x0
  44:	708080e7          	jalr	1800(ra) # 748 <printf>
    pid = fork();
  48:	00000097          	auipc	ra,0x0
  4c:	39e080e7          	jalr	926(ra) # 3e6 <fork>
  50:	84aa                	mv	s1,a0
    if(pid < 0){
  52:	04054d63          	bltz	a0,ac <main+0xac>
      printf("init: fork failed\n");
      exit(1);
    }
    if(pid == 0){
  56:	c925                	beqz	a0,c6 <main+0xc6>
    }

    for(;;){
      // this call to wait() returns if the shell exits,
      // or if a parentless process exits.
      wpid = wait((int *) 0);
  58:	4501                	li	a0,0
  5a:	00000097          	auipc	ra,0x0
  5e:	39c080e7          	jalr	924(ra) # 3f6 <wait>
      if(wpid == pid){
  62:	fca48ee3          	beq	s1,a0,3e <main+0x3e>
        // the shell exited; restart it.
        break;
      } else if(wpid < 0){
  66:	fe0559e3          	bgez	a0,58 <main+0x58>
        printf("init: wait returned an error\n");
  6a:	00001517          	auipc	a0,0x1
  6e:	8fe50513          	add	a0,a0,-1794 # 968 <malloc+0x150>
  72:	00000097          	auipc	ra,0x0
  76:	6d6080e7          	jalr	1750(ra) # 748 <printf>
        exit(1);
  7a:	4505                	li	a0,1
  7c:	00000097          	auipc	ra,0x0
  80:	372080e7          	jalr	882(ra) # 3ee <exit>
    mknod("console", CONSOLE, 0);
  84:	4601                	li	a2,0
  86:	4585                	li	a1,1
  88:	00001517          	auipc	a0,0x1
  8c:	88850513          	add	a0,a0,-1912 # 910 <malloc+0xf8>
  90:	00000097          	auipc	ra,0x0
  94:	3a6080e7          	jalr	934(ra) # 436 <mknod>
    open("console", O_RDWR);
  98:	4589                	li	a1,2
  9a:	00001517          	auipc	a0,0x1
  9e:	87650513          	add	a0,a0,-1930 # 910 <malloc+0xf8>
  a2:	00000097          	auipc	ra,0x0
  a6:	38c080e7          	jalr	908(ra) # 42e <open>
  aa:	bfa5                	j	22 <main+0x22>
      printf("init: fork failed\n");
  ac:	00001517          	auipc	a0,0x1
  b0:	88450513          	add	a0,a0,-1916 # 930 <malloc+0x118>
  b4:	00000097          	auipc	ra,0x0
  b8:	694080e7          	jalr	1684(ra) # 748 <printf>
      exit(1);
  bc:	4505                	li	a0,1
  be:	00000097          	auipc	ra,0x0
  c2:	330080e7          	jalr	816(ra) # 3ee <exit>
      exec("sh", argv);
  c6:	00001597          	auipc	a1,0x1
  ca:	f3a58593          	add	a1,a1,-198 # 1000 <argv>
  ce:	00001517          	auipc	a0,0x1
  d2:	87a50513          	add	a0,a0,-1926 # 948 <malloc+0x130>
  d6:	00000097          	auipc	ra,0x0
  da:	350080e7          	jalr	848(ra) # 426 <exec>
      printf("init: exec sh failed\n");
  de:	00001517          	auipc	a0,0x1
  e2:	87250513          	add	a0,a0,-1934 # 950 <malloc+0x138>
  e6:	00000097          	auipc	ra,0x0
  ea:	662080e7          	jalr	1634(ra) # 748 <printf>
      exit(1);
  ee:	4505                	li	a0,1
  f0:	00000097          	auipc	ra,0x0
  f4:	2fe080e7          	jalr	766(ra) # 3ee <exit>

00000000000000f8 <_main>:
//
// wrapper so that it's OK if main() does not call exit().
//
void
_main()
{
  f8:	1141                	add	sp,sp,-16
  fa:	e022                	sd	s0,0(sp)
  fc:	e406                	sd	ra,8(sp)
  fe:	0800                	add	s0,sp,16
  extern int main();
  main();
 100:	00000097          	auipc	ra,0x0
 104:	f00080e7          	jalr	-256(ra) # 0 <main>
  exit(0);
 108:	4501                	li	a0,0
 10a:	00000097          	auipc	ra,0x0
 10e:	2e4080e7          	jalr	740(ra) # 3ee <exit>

0000000000000112 <strcpy>:
}

char*
strcpy(char *s, const char *t)
{
 112:	1141                	add	sp,sp,-16
 114:	e422                	sd	s0,8(sp)
 116:	0800                	add	s0,sp,16
  char *os;

  os = s;
  while((*s++ = *t++) != 0)
 118:	87aa                	mv	a5,a0
 11a:	0005c703          	lbu	a4,0(a1)
 11e:	0785                	add	a5,a5,1
 120:	0585                	add	a1,a1,1
 122:	fee78fa3          	sb	a4,-1(a5)
 126:	fb75                	bnez	a4,11a <strcpy+0x8>
    ;
  return os;
}
 128:	6422                	ld	s0,8(sp)
 12a:	0141                	add	sp,sp,16
 12c:	8082                	ret

000000000000012e <strcmp>:

int
strcmp(const char *p, const char *q)
{
 12e:	1141                	add	sp,sp,-16
 130:	e422                	sd	s0,8(sp)
 132:	0800                	add	s0,sp,16
  while(*p && *p == *q)
 134:	00054783          	lbu	a5,0(a0)
 138:	e791                	bnez	a5,144 <strcmp+0x16>
 13a:	a80d                	j	16c <strcmp+0x3e>
 13c:	00054783          	lbu	a5,0(a0)
 140:	cf99                	beqz	a5,15e <strcmp+0x30>
 142:	85b6                	mv	a1,a3
 144:	0005c703          	lbu	a4,0(a1)
    p++, q++;
 148:	0505                	add	a0,a0,1
 14a:	00158693          	add	a3,a1,1
  while(*p && *p == *q)
 14e:	fef707e3          	beq	a4,a5,13c <strcmp+0xe>
  return (uchar)*p - (uchar)*q;
 152:	0007851b          	sext.w	a0,a5
}
 156:	6422                	ld	s0,8(sp)
 158:	9d19                	subw	a0,a0,a4
 15a:	0141                	add	sp,sp,16
 15c:	8082                	ret
  return (uchar)*p - (uchar)*q;
 15e:	0015c703          	lbu	a4,1(a1)
}
 162:	6422                	ld	s0,8(sp)
  return (uchar)*p - (uchar)*q;
 164:	4501                	li	a0,0
}
 166:	9d19                	subw	a0,a0,a4
 168:	0141                	add	sp,sp,16
 16a:	8082                	ret
  return (uchar)*p - (uchar)*q;
 16c:	0005c703          	lbu	a4,0(a1)
 170:	4501                	li	a0,0
 172:	b7d5                	j	156 <strcmp+0x28>

0000000000000174 <strlen>:

uint
strlen(const char *s)
{
 174:	1141                	add	sp,sp,-16
 176:	e422                	sd	s0,8(sp)
 178:	0800                	add	s0,sp,16
  int n;

  for(n = 0; s[n]; n++)
 17a:	00054783          	lbu	a5,0(a0)
 17e:	cf91                	beqz	a5,19a <strlen+0x26>
 180:	0505                	add	a0,a0,1
 182:	87aa                	mv	a5,a0
 184:	0007c703          	lbu	a4,0(a5)
 188:	86be                	mv	a3,a5
 18a:	0785                	add	a5,a5,1
 18c:	ff65                	bnez	a4,184 <strlen+0x10>
    ;
  return n;
}
 18e:	6422                	ld	s0,8(sp)
 190:	40a6853b          	subw	a0,a3,a0
 194:	2505                	addw	a0,a0,1
 196:	0141                	add	sp,sp,16
 198:	8082                	ret
 19a:	6422                	ld	s0,8(sp)
  for(n = 0; s[n]; n++)
 19c:	4501                	li	a0,0
}
 19e:	0141                	add	sp,sp,16
 1a0:	8082                	ret

00000000000001a2 <memset>:

void*
memset(void *dst, int c, uint n)
{
 1a2:	1141                	add	sp,sp,-16
 1a4:	e422                	sd	s0,8(sp)
 1a6:	0800                	add	s0,sp,16
  char *cdst = (char *) dst;
  int i;
  for(i = 0; i < n; i++){
 1a8:	ce09                	beqz	a2,1c2 <memset+0x20>
 1aa:	1602                	sll	a2,a2,0x20
 1ac:	9201                	srl	a2,a2,0x20
    cdst[i] = c;
 1ae:	0ff5f593          	zext.b	a1,a1
 1b2:	87aa                	mv	a5,a0
 1b4:	00a60733          	add	a4,a2,a0
 1b8:	00b78023          	sb	a1,0(a5)
  for(i = 0; i < n; i++){
 1bc:	0785                	add	a5,a5,1
 1be:	fee79de3          	bne	a5,a4,1b8 <memset+0x16>
  }
  return dst;
}
 1c2:	6422                	ld	s0,8(sp)
 1c4:	0141                	add	sp,sp,16
 1c6:	8082                	ret

00000000000001c8 <strchr>:

char*
strchr(const char *s, char c)
{
 1c8:	1141                	add	sp,sp,-16
 1ca:	e422                	sd	s0,8(sp)
 1cc:	0800                	add	s0,sp,16
  for(; *s; s++)
 1ce:	00054783          	lbu	a5,0(a0)
 1d2:	c799                	beqz	a5,1e0 <strchr+0x18>
    if(*s == c)
 1d4:	00f58763          	beq	a1,a5,1e2 <strchr+0x1a>
  for(; *s; s++)
 1d8:	00154783          	lbu	a5,1(a0)
 1dc:	0505                	add	a0,a0,1
 1de:	fbfd                	bnez	a5,1d4 <strchr+0xc>
      return (char*)s;
  return 0;
 1e0:	4501                	li	a0,0
}
 1e2:	6422                	ld	s0,8(sp)
 1e4:	0141                	add	sp,sp,16
 1e6:	8082                	ret

00000000000001e8 <gets>:

char*
gets(char *buf, int max)
{
 1e8:	711d                	add	sp,sp,-96
 1ea:	e8a2                	sd	s0,80(sp)
 1ec:	e4a6                	sd	s1,72(sp)
 1ee:	e0ca                	sd	s2,64(sp)
 1f0:	fc4e                	sd	s3,56(sp)
 1f2:	f852                	sd	s4,48(sp)
 1f4:	f05a                	sd	s6,32(sp)
 1f6:	ec5e                	sd	s7,24(sp)
 1f8:	ec86                	sd	ra,88(sp)
 1fa:	f456                	sd	s5,40(sp)
 1fc:	1080                	add	s0,sp,96
 1fe:	8baa                	mv	s7,a0
 200:	89ae                	mv	s3,a1
 202:	892a                	mv	s2,a0
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
 204:	4481                	li	s1,0
    cc = read(0, &c, 1);
    if(cc < 1)
      break;
    buf[i++] = c;
    if(c == '\n' || c == '\r')
 206:	4a29                	li	s4,10
 208:	4b35                	li	s6,13
  for(i=0; i+1 < max; ){
 20a:	a005                	j	22a <gets+0x42>
    cc = read(0, &c, 1);
 20c:	00000097          	auipc	ra,0x0
 210:	1fa080e7          	jalr	506(ra) # 406 <read>
    if(cc < 1)
 214:	02a05363          	blez	a0,23a <gets+0x52>
    buf[i++] = c;
 218:	faf44783          	lbu	a5,-81(s0)
    if(c == '\n' || c == '\r')
 21c:	0905                	add	s2,s2,1
    buf[i++] = c;
 21e:	fef90fa3          	sb	a5,-1(s2)
    if(c == '\n' || c == '\r')
 222:	01478d63          	beq	a5,s4,23c <gets+0x54>
 226:	01678b63          	beq	a5,s6,23c <gets+0x54>
  for(i=0; i+1 < max; ){
 22a:	8aa6                	mv	s5,s1
 22c:	2485                	addw	s1,s1,1
    cc = read(0, &c, 1);
 22e:	4605                	li	a2,1
 230:	faf40593          	add	a1,s0,-81
 234:	4501                	li	a0,0
  for(i=0; i+1 < max; ){
 236:	fd34cbe3          	blt	s1,s3,20c <gets+0x24>
 23a:	84d6                	mv	s1,s5
      break;
  }
  buf[i] = '\0';
 23c:	94de                	add	s1,s1,s7
 23e:	00048023          	sb	zero,0(s1)
  return buf;
}
 242:	60e6                	ld	ra,88(sp)
 244:	6446                	ld	s0,80(sp)
 246:	64a6                	ld	s1,72(sp)
 248:	6906                	ld	s2,64(sp)
 24a:	79e2                	ld	s3,56(sp)
 24c:	7a42                	ld	s4,48(sp)
 24e:	7aa2                	ld	s5,40(sp)
 250:	7b02                	ld	s6,32(sp)
 252:	855e                	mv	a0,s7
 254:	6be2                	ld	s7,24(sp)
 256:	6125                	add	sp,sp,96
 258:	8082                	ret

000000000000025a <stat>:

int
stat(const char *n, struct stat *st)
{
 25a:	1101                	add	sp,sp,-32
 25c:	e822                	sd	s0,16(sp)
 25e:	e04a                	sd	s2,0(sp)
 260:	ec06                	sd	ra,24(sp)
 262:	e426                	sd	s1,8(sp)
 264:	1000                	add	s0,sp,32
 266:	892e                	mv	s2,a1
  int fd;
  int r;

  fd = open(n, O_RDONLY);
 268:	4581                	li	a1,0
 26a:	00000097          	auipc	ra,0x0
 26e:	1c4080e7          	jalr	452(ra) # 42e <open>
  if(fd < 0)
 272:	02054663          	bltz	a0,29e <stat+0x44>
    return -1;
  r = fstat(fd, st);
 276:	85ca                	mv	a1,s2
 278:	84aa                	mv	s1,a0
 27a:	00000097          	auipc	ra,0x0
 27e:	1cc080e7          	jalr	460(ra) # 446 <fstat>
 282:	87aa                	mv	a5,a0
  close(fd);
 284:	8526                	mv	a0,s1
  r = fstat(fd, st);
 286:	84be                	mv	s1,a5
  close(fd);
 288:	00000097          	auipc	ra,0x0
 28c:	18e080e7          	jalr	398(ra) # 416 <close>
  return r;
}
 290:	60e2                	ld	ra,24(sp)
 292:	6442                	ld	s0,16(sp)
 294:	6902                	ld	s2,0(sp)
 296:	8526                	mv	a0,s1
 298:	64a2                	ld	s1,8(sp)
 29a:	6105                	add	sp,sp,32
 29c:	8082                	ret
    return -1;
 29e:	54fd                	li	s1,-1
 2a0:	bfc5                	j	290 <stat+0x36>

00000000000002a2 <atoi>:

int
atoi(const char *s)
{
 2a2:	1141                	add	sp,sp,-16
 2a4:	e422                	sd	s0,8(sp)
 2a6:	0800                	add	s0,sp,16
  int n;

  n = 0;
  while('0' <= *s && *s <= '9')
 2a8:	00054683          	lbu	a3,0(a0)
 2ac:	4625                	li	a2,9
 2ae:	fd06879b          	addw	a5,a3,-48
 2b2:	0ff7f793          	zext.b	a5,a5
 2b6:	02f66863          	bltu	a2,a5,2e6 <atoi+0x44>
 2ba:	872a                	mv	a4,a0
  n = 0;
 2bc:	4501                	li	a0,0
    n = n*10 + *s++ - '0';
 2be:	0025179b          	sllw	a5,a0,0x2
 2c2:	9fa9                	addw	a5,a5,a0
 2c4:	0705                	add	a4,a4,1
 2c6:	0017979b          	sllw	a5,a5,0x1
 2ca:	9fb5                	addw	a5,a5,a3
  while('0' <= *s && *s <= '9')
 2cc:	00074683          	lbu	a3,0(a4)
    n = n*10 + *s++ - '0';
 2d0:	fd07851b          	addw	a0,a5,-48
  while('0' <= *s && *s <= '9')
 2d4:	fd06879b          	addw	a5,a3,-48
 2d8:	0ff7f793          	zext.b	a5,a5
 2dc:	fef671e3          	bgeu	a2,a5,2be <atoi+0x1c>
  return n;
}
 2e0:	6422                	ld	s0,8(sp)
 2e2:	0141                	add	sp,sp,16
 2e4:	8082                	ret
 2e6:	6422                	ld	s0,8(sp)
  n = 0;
 2e8:	4501                	li	a0,0
}
 2ea:	0141                	add	sp,sp,16
 2ec:	8082                	ret

00000000000002ee <memmove>:

void*
memmove(void *vdst, const void *vsrc, int n)
{
 2ee:	1141                	add	sp,sp,-16
 2f0:	e422                	sd	s0,8(sp)
 2f2:	0800                	add	s0,sp,16
  char *dst;
  const char *src;

  dst = vdst;
  src = vsrc;
  if (src > dst) {
 2f4:	02b57463          	bgeu	a0,a1,31c <memmove+0x2e>
    while(n-- > 0)
 2f8:	00c05f63          	blez	a2,316 <memmove+0x28>
 2fc:	1602                	sll	a2,a2,0x20
 2fe:	9201                	srl	a2,a2,0x20
 300:	00c507b3          	add	a5,a0,a2
  dst = vdst;
 304:	872a                	mv	a4,a0
      *dst++ = *src++;
 306:	0005c683          	lbu	a3,0(a1)
 30a:	0705                	add	a4,a4,1
 30c:	0585                	add	a1,a1,1
 30e:	fed70fa3          	sb	a3,-1(a4)
    while(n-- > 0)
 312:	fef71ae3          	bne	a4,a5,306 <memmove+0x18>
    src += n;
    while(n-- > 0)
      *--dst = *--src;
  }
  return vdst;
}
 316:	6422                	ld	s0,8(sp)
 318:	0141                	add	sp,sp,16
 31a:	8082                	ret
    dst += n;
 31c:	00c50733          	add	a4,a0,a2
    src += n;
 320:	95b2                	add	a1,a1,a2
    while(n-- > 0)
 322:	fec05ae3          	blez	a2,316 <memmove+0x28>
 326:	fff6079b          	addw	a5,a2,-1
 32a:	1782                	sll	a5,a5,0x20
 32c:	9381                	srl	a5,a5,0x20
 32e:	fff7c793          	not	a5,a5
 332:	97ae                	add	a5,a5,a1
      *--dst = *--src;
 334:	fff5c683          	lbu	a3,-1(a1)
 338:	15fd                	add	a1,a1,-1
 33a:	177d                	add	a4,a4,-1
 33c:	00d70023          	sb	a3,0(a4)
    while(n-- > 0)
 340:	feb79ae3          	bne	a5,a1,334 <memmove+0x46>
}
 344:	6422                	ld	s0,8(sp)
 346:	0141                	add	sp,sp,16
 348:	8082                	ret

000000000000034a <memcmp>:

int
memcmp(const void *s1, const void *s2, uint n)
{
 34a:	1141                	add	sp,sp,-16
 34c:	e422                	sd	s0,8(sp)
 34e:	0800                	add	s0,sp,16
  const char *p1 = s1, *p2 = s2;
  while (n-- > 0) {
 350:	c61d                	beqz	a2,37e <memcmp+0x34>
 352:	fff6069b          	addw	a3,a2,-1
 356:	1682                	sll	a3,a3,0x20
 358:	9281                	srl	a3,a3,0x20
 35a:	0685                	add	a3,a3,1
 35c:	96aa                	add	a3,a3,a0
 35e:	a019                	j	364 <memcmp+0x1a>
 360:	00a68f63          	beq	a3,a0,37e <memcmp+0x34>
    if (*p1 != *p2) {
 364:	00054783          	lbu	a5,0(a0)
 368:	0005c703          	lbu	a4,0(a1)
      return *p1 - *p2;
    }
    p1++;
 36c:	0505                	add	a0,a0,1
    p2++;
 36e:	0585                	add	a1,a1,1
    if (*p1 != *p2) {
 370:	fee788e3          	beq	a5,a4,360 <memcmp+0x16>
  }
  return 0;
}
 374:	6422                	ld	s0,8(sp)
      return *p1 - *p2;
 376:	40e7853b          	subw	a0,a5,a4
}
 37a:	0141                	add	sp,sp,16
 37c:	8082                	ret
 37e:	6422                	ld	s0,8(sp)
  return 0;
 380:	4501                	li	a0,0
}
 382:	0141                	add	sp,sp,16
 384:	8082                	ret

0000000000000386 <memcpy>:

void *
memcpy(void *dst, const void *src, uint n)
{
 386:	1141                	add	sp,sp,-16
 388:	e422                	sd	s0,8(sp)
 38a:	0800                	add	s0,sp,16
  return memmove(dst, src, n);
 38c:	0006079b          	sext.w	a5,a2
  if (src > dst) {
 390:	02b57463          	bgeu	a0,a1,3b8 <memcpy+0x32>
    while(n-- > 0)
 394:	00f05f63          	blez	a5,3b2 <memcpy+0x2c>
 398:	1602                	sll	a2,a2,0x20
 39a:	9201                	srl	a2,a2,0x20
 39c:	00c587b3          	add	a5,a1,a2
  dst = vdst;
 3a0:	872a                	mv	a4,a0
      *dst++ = *src++;
 3a2:	0005c683          	lbu	a3,0(a1)
 3a6:	0585                	add	a1,a1,1
 3a8:	0705                	add	a4,a4,1
 3aa:	fed70fa3          	sb	a3,-1(a4)
    while(n-- > 0)
 3ae:	fef59ae3          	bne	a1,a5,3a2 <memcpy+0x1c>
}
 3b2:	6422                	ld	s0,8(sp)
 3b4:	0141                	add	sp,sp,16
 3b6:	8082                	ret
    dst += n;
 3b8:	00f50733          	add	a4,a0,a5
    src += n;
 3bc:	95be                	add	a1,a1,a5
    while(n-- > 0)
 3be:	fef05ae3          	blez	a5,3b2 <memcpy+0x2c>
 3c2:	fff6079b          	addw	a5,a2,-1
 3c6:	1782                	sll	a5,a5,0x20
 3c8:	9381                	srl	a5,a5,0x20
 3ca:	fff7c793          	not	a5,a5
 3ce:	97ae                	add	a5,a5,a1
      *--dst = *--src;
 3d0:	fff5c683          	lbu	a3,-1(a1)
 3d4:	15fd                	add	a1,a1,-1
 3d6:	177d                	add	a4,a4,-1
 3d8:	00d70023          	sb	a3,0(a4)
    while(n-- > 0)
 3dc:	fef59ae3          	bne	a1,a5,3d0 <memcpy+0x4a>
}
 3e0:	6422                	ld	s0,8(sp)
 3e2:	0141                	add	sp,sp,16
 3e4:	8082                	ret

00000000000003e6 <fork>:
# generated by usys.pl - do not edit
#include "kern/syscall.h"
.global fork
fork:
 li a7, SYS_fork
 3e6:	4885                	li	a7,1
 ecall
 3e8:	00000073          	ecall
 ret
 3ec:	8082                	ret

00000000000003ee <exit>:
.global exit
exit:
 li a7, SYS_exit
 3ee:	4889                	li	a7,2
 ecall
 3f0:	00000073          	ecall
 ret
 3f4:	8082                	ret

00000000000003f6 <wait>:
.global wait
wait:
 li a7, SYS_wait
 3f6:	488d                	li	a7,3
 ecall
 3f8:	00000073          	ecall
 ret
 3fc:	8082                	ret

00000000000003fe <pipe>:
.global pipe
pipe:
 li a7, SYS_pipe
 3fe:	4891                	li	a7,4
 ecall
 400:	00000073          	ecall
 ret
 404:	8082                	ret

0000000000000406 <read>:
.global read
read:
 li a7, SYS_read
 406:	4895                	li	a7,5
 ecall
 408:	00000073          	ecall
 ret
 40c:	8082                	ret

000000000000040e <write>:
.global write
write:
 li a7, SYS_write
 40e:	48c1                	li	a7,16
 ecall
 410:	00000073          	ecall
 ret
 414:	8082                	ret

0000000000000416 <close>:
.global close
close:
 li a7, SYS_close
 416:	48d5                	li	a7,21
 ecall
 418:	00000073          	ecall
 ret
 41c:	8082                	ret

000000000000041e <kill>:
.global kill
kill:
 li a7, SYS_kill
 41e:	4899                	li	a7,6
 ecall
 420:	00000073          	ecall
 ret
 424:	8082                	ret

0000000000000426 <exec>:
.global exec
exec:
 li a7, SYS_exec
 426:	489d                	li	a7,7
 ecall
 428:	00000073          	ecall
 ret
 42c:	8082                	ret

000000000000042e <open>:
.global open
open:
 li a7, SYS_open
 42e:	48bd                	li	a7,15
 ecall
 430:	00000073          	ecall
 ret
 434:	8082                	ret

0000000000000436 <mknod>:
.global mknod
mknod:
 li a7, SYS_mknod
 436:	48c5                	li	a7,17
 ecall
 438:	00000073          	ecall
 ret
 43c:	8082                	ret

000000000000043e <unlink>:
.global unlink
unlink:
 li a7, SYS_unlink
 43e:	48c9                	li	a7,18
 ecall
 440:	00000073          	ecall
 ret
 444:	8082                	ret

0000000000000446 <fstat>:
.global fstat
fstat:
 li a7, SYS_fstat
 446:	48a1                	li	a7,8
 ecall
 448:	00000073          	ecall
 ret
 44c:	8082                	ret

000000000000044e <link>:
.global link
link:
 li a7, SYS_link
 44e:	48cd                	li	a7,19
 ecall
 450:	00000073          	ecall
 ret
 454:	8082                	ret

0000000000000456 <mkdir>:
.global mkdir
mkdir:
 li a7, SYS_mkdir
 456:	48d1                	li	a7,20
 ecall
 458:	00000073          	ecall
 ret
 45c:	8082                	ret

000000000000045e <chdir>:
.global chdir
chdir:
 li a7, SYS_chdir
 45e:	48a5                	li	a7,9
 ecall
 460:	00000073          	ecall
 ret
 464:	8082                	ret

0000000000000466 <dup>:
.global dup
dup:
 li a7, SYS_dup
 466:	48a9                	li	a7,10
 ecall
 468:	00000073          	ecall
 ret
 46c:	8082                	ret

000000000000046e <getpid>:
.global getpid
getpid:
 li a7, SYS_getpid
 46e:	48ad                	li	a7,11
 ecall
 470:	00000073          	ecall
 ret
 474:	8082                	ret

0000000000000476 <sbrk>:
.global sbrk
sbrk:
 li a7, SYS_sbrk
 476:	48b1                	li	a7,12
 ecall
 478:	00000073          	ecall
 ret
 47c:	8082                	ret

000000000000047e <sleep>:
.global sleep
sleep:
 li a7, SYS_sleep
 47e:	48b5                	li	a7,13
 ecall
 480:	00000073          	ecall
 ret
 484:	8082                	ret

0000000000000486 <uptime>:
.global uptime
uptime:
 li a7, SYS_uptime
 486:	48b9                	li	a7,14
 ecall
 488:	00000073          	ecall
 ret
 48c:	8082                	ret

000000000000048e <poweroff>:
.global poweroff
poweroff:
 li a7, SYS_poweroff
 48e:	48d9                	li	a7,22
 ecall
 490:	00000073          	ecall
 ret
 494:	8082                	ret

0000000000000496 <printint>:
  write(fd, &c, 1);
}

static void
printint(int fd, int xx, int base, int sgn)
{
 496:	715d                	add	sp,sp,-80
 498:	e0a2                	sd	s0,64(sp)
 49a:	f84a                	sd	s2,48(sp)
 49c:	e486                	sd	ra,72(sp)
 49e:	fc26                	sd	s1,56(sp)
 4a0:	f44e                	sd	s3,40(sp)
 4a2:	0880                	add	s0,sp,80
 4a4:	892a                	mv	s2,a0
  char buf[16];
  int i, neg;
  uint x;

  neg = 0;
  if(sgn && xx < 0){
 4a6:	c299                	beqz	a3,4ac <printint+0x16>
 4a8:	0805c263          	bltz	a1,52c <printint+0x96>
    neg = 1;
    x = -xx;
  } else {
    x = xx;
 4ac:	2581                	sext.w	a1,a1
  neg = 0;
 4ae:	4681                	li	a3,0
  }

  i = 0;
  do{
    buf[i++] = digits[x % base];
 4b0:	2601                	sext.w	a2,a2
 4b2:	fc040713          	add	a4,s0,-64
  i = 0;
 4b6:	4501                	li	a0,0
 4b8:	00000897          	auipc	a7,0x0
 4bc:	53088893          	add	a7,a7,1328 # 9e8 <digits>
    buf[i++] = digits[x % base];
 4c0:	02c5f7bb          	remuw	a5,a1,a2
  }while((x /= base) != 0);
 4c4:	0705                	add	a4,a4,1
 4c6:	0005881b          	sext.w	a6,a1
 4ca:	84aa                	mv	s1,a0
    buf[i++] = digits[x % base];
 4cc:	2505                	addw	a0,a0,1
 4ce:	1782                	sll	a5,a5,0x20
 4d0:	9381                	srl	a5,a5,0x20
 4d2:	97c6                	add	a5,a5,a7
 4d4:	0007c783          	lbu	a5,0(a5)
  }while((x /= base) != 0);
 4d8:	02c5d5bb          	divuw	a1,a1,a2
    buf[i++] = digits[x % base];
 4dc:	fef70fa3          	sb	a5,-1(a4)
  }while((x /= base) != 0);
 4e0:	fec870e3          	bgeu	a6,a2,4c0 <printint+0x2a>
  if(neg)
 4e4:	ca89                	beqz	a3,4f6 <printint+0x60>
    buf[i++] = '-';
 4e6:	fd050793          	add	a5,a0,-48
 4ea:	97a2                	add	a5,a5,s0
 4ec:	02d00713          	li	a4,45
 4f0:	fee78823          	sb	a4,-16(a5)

  while(--i >= 0)
 4f4:	84aa                	mv	s1,a0
 4f6:	fc040793          	add	a5,s0,-64
 4fa:	94be                	add	s1,s1,a5
 4fc:	fff78993          	add	s3,a5,-1
    putc(fd, buf[i]);
 500:	0004c783          	lbu	a5,0(s1)
  write(fd, &c, 1);
 504:	4605                	li	a2,1
 506:	fbf40593          	add	a1,s0,-65
 50a:	854a                	mv	a0,s2
  while(--i >= 0)
 50c:	14fd                	add	s1,s1,-1
 50e:	faf40fa3          	sb	a5,-65(s0)
  write(fd, &c, 1);
 512:	00000097          	auipc	ra,0x0
 516:	efc080e7          	jalr	-260(ra) # 40e <write>
  while(--i >= 0)
 51a:	ff3493e3          	bne	s1,s3,500 <printint+0x6a>
}
 51e:	60a6                	ld	ra,72(sp)
 520:	6406                	ld	s0,64(sp)
 522:	74e2                	ld	s1,56(sp)
 524:	7942                	ld	s2,48(sp)
 526:	79a2                	ld	s3,40(sp)
 528:	6161                	add	sp,sp,80
 52a:	8082                	ret
    x = -xx;
 52c:	40b005bb          	negw	a1,a1
 530:	b741                	j	4b0 <printint+0x1a>

0000000000000532 <vprintf>:
}

// Print to the given fd. Only understands %d, %x, %p, %s.
void
vprintf(int fd, const char *fmt, va_list ap)
{
 532:	7159                	add	sp,sp,-112
 534:	f0a2                	sd	s0,96(sp)
 536:	f486                	sd	ra,104(sp)
 538:	e8ca                	sd	s2,80(sp)
 53a:	1880                	add	s0,sp,112
  char *s;
  int c, i, state;

  state = 0;
  for(i = 0; fmt[i]; i++){
 53c:	0005c903          	lbu	s2,0(a1)
 540:	04090f63          	beqz	s2,59e <vprintf+0x6c>
 544:	eca6                	sd	s1,88(sp)
 546:	e4ce                	sd	s3,72(sp)
 548:	e0d2                	sd	s4,64(sp)
 54a:	fc56                	sd	s5,56(sp)
 54c:	f85a                	sd	s6,48(sp)
 54e:	f45e                	sd	s7,40(sp)
 550:	f062                	sd	s8,32(sp)
 552:	8a2a                	mv	s4,a0
 554:	8c32                	mv	s8,a2
 556:	00158493          	add	s1,a1,1
 55a:	4981                	li	s3,0
      if(c == '%'){
        state = '%';
      } else {
        putc(fd, c);
      }
    } else if(state == '%'){
 55c:	02500a93          	li	s5,37
 560:	4bd5                	li	s7,21
 562:	00000b17          	auipc	s6,0x0
 566:	42eb0b13          	add	s6,s6,1070 # 990 <malloc+0x178>
    if(state == 0){
 56a:	02099f63          	bnez	s3,5a8 <vprintf+0x76>
      if(c == '%'){
 56e:	05590c63          	beq	s2,s5,5c6 <vprintf+0x94>
  write(fd, &c, 1);
 572:	4605                	li	a2,1
 574:	f9f40593          	add	a1,s0,-97
 578:	8552                	mv	a0,s4
 57a:	f9240fa3          	sb	s2,-97(s0)
 57e:	00000097          	auipc	ra,0x0
 582:	e90080e7          	jalr	-368(ra) # 40e <write>
  for(i = 0; fmt[i]; i++){
 586:	0004c903          	lbu	s2,0(s1)
 58a:	0485                	add	s1,s1,1
 58c:	fc091fe3          	bnez	s2,56a <vprintf+0x38>
 590:	64e6                	ld	s1,88(sp)
 592:	69a6                	ld	s3,72(sp)
 594:	6a06                	ld	s4,64(sp)
 596:	7ae2                	ld	s5,56(sp)
 598:	7b42                	ld	s6,48(sp)
 59a:	7ba2                	ld	s7,40(sp)
 59c:	7c02                	ld	s8,32(sp)
        putc(fd, c);
      }
      state = 0;
    }
  }
}
 59e:	70a6                	ld	ra,104(sp)
 5a0:	7406                	ld	s0,96(sp)
 5a2:	6946                	ld	s2,80(sp)
 5a4:	6165                	add	sp,sp,112
 5a6:	8082                	ret
    } else if(state == '%'){
 5a8:	fd599fe3          	bne	s3,s5,586 <vprintf+0x54>
      if(c == 'd'){
 5ac:	15590463          	beq	s2,s5,6f4 <vprintf+0x1c2>
 5b0:	f9d9079b          	addw	a5,s2,-99
 5b4:	0ff7f793          	zext.b	a5,a5
 5b8:	00fbea63          	bltu	s7,a5,5cc <vprintf+0x9a>
 5bc:	078a                	sll	a5,a5,0x2
 5be:	97da                	add	a5,a5,s6
 5c0:	439c                	lw	a5,0(a5)
 5c2:	97da                	add	a5,a5,s6
 5c4:	8782                	jr	a5
        state = '%';
 5c6:	02500993          	li	s3,37
 5ca:	bf75                	j	586 <vprintf+0x54>
  write(fd, &c, 1);
 5cc:	f9f40993          	add	s3,s0,-97
 5d0:	4605                	li	a2,1
 5d2:	85ce                	mv	a1,s3
 5d4:	02500793          	li	a5,37
 5d8:	8552                	mv	a0,s4
 5da:	f8f40fa3          	sb	a5,-97(s0)
 5de:	00000097          	auipc	ra,0x0
 5e2:	e30080e7          	jalr	-464(ra) # 40e <write>
 5e6:	4605                	li	a2,1
 5e8:	85ce                	mv	a1,s3
 5ea:	8552                	mv	a0,s4
 5ec:	f9240fa3          	sb	s2,-97(s0)
 5f0:	00000097          	auipc	ra,0x0
 5f4:	e1e080e7          	jalr	-482(ra) # 40e <write>
        while(*s != 0){
 5f8:	4981                	li	s3,0
 5fa:	b771                	j	586 <vprintf+0x54>
        putc(fd, va_arg(ap, uint));
 5fc:	000c2783          	lw	a5,0(s8)
  write(fd, &c, 1);
 600:	4605                	li	a2,1
 602:	f9f40593          	add	a1,s0,-97
 606:	8552                	mv	a0,s4
        putc(fd, va_arg(ap, uint));
 608:	f8f40fa3          	sb	a5,-97(s0)
 60c:	0c21                	add	s8,s8,8
  write(fd, &c, 1);
 60e:	00000097          	auipc	ra,0x0
 612:	e00080e7          	jalr	-512(ra) # 40e <write>
 616:	4981                	li	s3,0
 618:	b7bd                	j	586 <vprintf+0x54>
        printint(fd, va_arg(ap, int), 10, 1);
 61a:	000c2583          	lw	a1,0(s8)
 61e:	4685                	li	a3,1
        printint(fd, va_arg(ap, uint64), 10, 0);
 620:	4629                	li	a2,10
 622:	8552                	mv	a0,s4
 624:	0c21                	add	s8,s8,8
 626:	00000097          	auipc	ra,0x0
 62a:	e70080e7          	jalr	-400(ra) # 496 <printint>
 62e:	4981                	li	s3,0
 630:	bf99                	j	586 <vprintf+0x54>
 632:	000c2583          	lw	a1,0(s8)
 636:	4681                	li	a3,0
 638:	b7e5                	j	620 <vprintf+0xee>
  write(fd, &c, 1);
 63a:	f9f40993          	add	s3,s0,-97
 63e:	03000793          	li	a5,48
 642:	4605                	li	a2,1
 644:	85ce                	mv	a1,s3
 646:	8552                	mv	a0,s4
 648:	ec66                	sd	s9,24(sp)
 64a:	e86a                	sd	s10,16(sp)
        printptr(fd, va_arg(ap, uint64));
 64c:	f8f40fa3          	sb	a5,-97(s0)
 650:	000c3d03          	ld	s10,0(s8)
  write(fd, &c, 1);
 654:	00000097          	auipc	ra,0x0
 658:	dba080e7          	jalr	-582(ra) # 40e <write>
 65c:	07800793          	li	a5,120
 660:	4605                	li	a2,1
 662:	85ce                	mv	a1,s3
 664:	8552                	mv	a0,s4
 666:	f8f40fa3          	sb	a5,-97(s0)
        printptr(fd, va_arg(ap, uint64));
 66a:	0c21                	add	s8,s8,8
  write(fd, &c, 1);
 66c:	00000097          	auipc	ra,0x0
 670:	da2080e7          	jalr	-606(ra) # 40e <write>
  putc(fd, 'x');
 674:	4941                	li	s2,16
 676:	00000c97          	auipc	s9,0x0
 67a:	372c8c93          	add	s9,s9,882 # 9e8 <digits>
    putc(fd, digits[x >> (sizeof(uint64) * 8 - 4)]);
 67e:	03cd5793          	srl	a5,s10,0x3c
 682:	97e6                	add	a5,a5,s9
 684:	0007c783          	lbu	a5,0(a5)
  write(fd, &c, 1);
 688:	4605                	li	a2,1
 68a:	85ce                	mv	a1,s3
 68c:	8552                	mv	a0,s4
  for (i = 0; i < (sizeof(uint64) * 2); i++, x <<= 4)
 68e:	397d                	addw	s2,s2,-1
 690:	f8f40fa3          	sb	a5,-97(s0)
 694:	0d12                	sll	s10,s10,0x4
  write(fd, &c, 1);
 696:	00000097          	auipc	ra,0x0
 69a:	d78080e7          	jalr	-648(ra) # 40e <write>
  for (i = 0; i < (sizeof(uint64) * 2); i++, x <<= 4)
 69e:	fe0910e3          	bnez	s2,67e <vprintf+0x14c>
 6a2:	6ce2                	ld	s9,24(sp)
 6a4:	6d42                	ld	s10,16(sp)
 6a6:	4981                	li	s3,0
 6a8:	bdf9                	j	586 <vprintf+0x54>
        s = va_arg(ap, char*);
 6aa:	000c3903          	ld	s2,0(s8)
 6ae:	0c21                	add	s8,s8,8
        if(s == 0)
 6b0:	04090e63          	beqz	s2,70c <vprintf+0x1da>
        while(*s != 0){
 6b4:	00094783          	lbu	a5,0(s2)
 6b8:	d3a1                	beqz	a5,5f8 <vprintf+0xc6>
 6ba:	f9f40993          	add	s3,s0,-97
  write(fd, &c, 1);
 6be:	4605                	li	a2,1
 6c0:	85ce                	mv	a1,s3
 6c2:	8552                	mv	a0,s4
 6c4:	f8f40fa3          	sb	a5,-97(s0)
 6c8:	00000097          	auipc	ra,0x0
 6cc:	d46080e7          	jalr	-698(ra) # 40e <write>
        while(*s != 0){
 6d0:	00194783          	lbu	a5,1(s2)
          s++;
 6d4:	0905                	add	s2,s2,1
        while(*s != 0){
 6d6:	f7e5                	bnez	a5,6be <vprintf+0x18c>
 6d8:	4981                	li	s3,0
 6da:	b575                	j	586 <vprintf+0x54>
        printint(fd, va_arg(ap, int), 16, 0);
 6dc:	000c2583          	lw	a1,0(s8)
 6e0:	4681                	li	a3,0
 6e2:	4641                	li	a2,16
 6e4:	8552                	mv	a0,s4
 6e6:	0c21                	add	s8,s8,8
 6e8:	00000097          	auipc	ra,0x0
 6ec:	dae080e7          	jalr	-594(ra) # 496 <printint>
 6f0:	4981                	li	s3,0
 6f2:	bd51                	j	586 <vprintf+0x54>
  write(fd, &c, 1);
 6f4:	4605                	li	a2,1
 6f6:	f9f40593          	add	a1,s0,-97
 6fa:	8552                	mv	a0,s4
 6fc:	f9540fa3          	sb	s5,-97(s0)
        while(*s != 0){
 700:	4981                	li	s3,0
  write(fd, &c, 1);
 702:	00000097          	auipc	ra,0x0
 706:	d0c080e7          	jalr	-756(ra) # 40e <write>
 70a:	bdb5                	j	586 <vprintf+0x54>
          s = "(null)";
 70c:	00000917          	auipc	s2,0x0
 710:	27c90913          	add	s2,s2,636 # 988 <malloc+0x170>
 714:	02800793          	li	a5,40
 718:	b74d                	j	6ba <vprintf+0x188>

000000000000071a <fprintf>:

void
fprintf(int fd, const char *fmt, ...)
{
 71a:	715d                	add	sp,sp,-80
 71c:	e822                	sd	s0,16(sp)
 71e:	ec06                	sd	ra,24(sp)
 720:	1000                	add	s0,sp,32
 722:	e010                	sd	a2,0(s0)
  va_list ap;

  va_start(ap, fmt);
  vprintf(fd, fmt, ap);
 724:	8622                	mv	a2,s0
{
 726:	e414                	sd	a3,8(s0)
 728:	e818                	sd	a4,16(s0)
 72a:	ec1c                	sd	a5,24(s0)
 72c:	03043023          	sd	a6,32(s0)
 730:	03143423          	sd	a7,40(s0)
  va_start(ap, fmt);
 734:	fe843423          	sd	s0,-24(s0)
  vprintf(fd, fmt, ap);
 738:	00000097          	auipc	ra,0x0
 73c:	dfa080e7          	jalr	-518(ra) # 532 <vprintf>
}
 740:	60e2                	ld	ra,24(sp)
 742:	6442                	ld	s0,16(sp)
 744:	6161                	add	sp,sp,80
 746:	8082                	ret

0000000000000748 <printf>:

void
printf(const char *fmt, ...)
{
 748:	711d                	add	sp,sp,-96
 74a:	e822                	sd	s0,16(sp)
 74c:	ec06                	sd	ra,24(sp)
 74e:	1000                	add	s0,sp,32
  va_list ap;

  va_start(ap, fmt);
 750:	00840313          	add	t1,s0,8
{
 754:	e40c                	sd	a1,8(s0)
 756:	e810                	sd	a2,16(s0)
  vprintf(1, fmt, ap);
 758:	85aa                	mv	a1,a0
 75a:	861a                	mv	a2,t1
 75c:	4505                	li	a0,1
{
 75e:	ec14                	sd	a3,24(s0)
 760:	f018                	sd	a4,32(s0)
 762:	f41c                	sd	a5,40(s0)
 764:	03043823          	sd	a6,48(s0)
 768:	03143c23          	sd	a7,56(s0)
  va_start(ap, fmt);
 76c:	fe643423          	sd	t1,-24(s0)
  vprintf(1, fmt, ap);
 770:	00000097          	auipc	ra,0x0
 774:	dc2080e7          	jalr	-574(ra) # 532 <vprintf>
}
 778:	60e2                	ld	ra,24(sp)
 77a:	6442                	ld	s0,16(sp)
 77c:	6125                	add	sp,sp,96
 77e:	8082                	ret

0000000000000780 <free>:
static Header base;
static Header *freep;

void
free(void *ap)
{
 780:	1141                	add	sp,sp,-16
 782:	e422                	sd	s0,8(sp)
 784:	0800                	add	s0,sp,16
  Header *bp, *p;

  bp = (Header*)ap - 1;
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 786:	00001597          	auipc	a1,0x1
 78a:	88a58593          	add	a1,a1,-1910 # 1010 <freep>
 78e:	619c                	ld	a5,0(a1)
  bp = (Header*)ap - 1;
 790:	ff050693          	add	a3,a0,-16
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 794:	6398                	ld	a4,0(a5)
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 796:	02d7ff63          	bgeu	a5,a3,7d4 <free+0x54>
 79a:	00e6e463          	bltu	a3,a4,7a2 <free+0x22>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 79e:	02e7ef63          	bltu	a5,a4,7dc <free+0x5c>
      break;
  if(bp + bp->s.size == p->s.ptr){
 7a2:	ff852803          	lw	a6,-8(a0)
 7a6:	02081893          	sll	a7,a6,0x20
 7aa:	01c8d613          	srl	a2,a7,0x1c
 7ae:	9636                	add	a2,a2,a3
 7b0:	02c70863          	beq	a4,a2,7e0 <free+0x60>
    bp->s.size += p->s.ptr->s.size;
    bp->s.ptr = p->s.ptr->s.ptr;
  } else
    bp->s.ptr = p->s.ptr;
  if(p + p->s.size == bp){
 7b4:	0087a803          	lw	a6,8(a5)
 7b8:	fee53823          	sd	a4,-16(a0)
 7bc:	02081893          	sll	a7,a6,0x20
 7c0:	01c8d613          	srl	a2,a7,0x1c
 7c4:	963e                	add	a2,a2,a5
 7c6:	02c68e63          	beq	a3,a2,802 <free+0x82>
    p->s.size += bp->s.size;
    p->s.ptr = bp->s.ptr;
  } else
    p->s.ptr = bp;
  freep = p;
}
 7ca:	6422                	ld	s0,8(sp)
 7cc:	e394                	sd	a3,0(a5)
  freep = p;
 7ce:	e19c                	sd	a5,0(a1)
}
 7d0:	0141                	add	sp,sp,16
 7d2:	8082                	ret
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 7d4:	00e7e463          	bltu	a5,a4,7dc <free+0x5c>
 7d8:	fce6e5e3          	bltu	a3,a4,7a2 <free+0x22>
{
 7dc:	87ba                	mv	a5,a4
 7de:	bf5d                	j	794 <free+0x14>
    bp->s.size += p->s.ptr->s.size;
 7e0:	4710                	lw	a2,8(a4)
    bp->s.ptr = p->s.ptr->s.ptr;
 7e2:	6318                	ld	a4,0(a4)
    bp->s.size += p->s.ptr->s.size;
 7e4:	0106063b          	addw	a2,a2,a6
 7e8:	fec52c23          	sw	a2,-8(a0)
  if(p + p->s.size == bp){
 7ec:	0087a803          	lw	a6,8(a5)
 7f0:	fee53823          	sd	a4,-16(a0)
 7f4:	02081893          	sll	a7,a6,0x20
 7f8:	01c8d613          	srl	a2,a7,0x1c
 7fc:	963e                	add	a2,a2,a5
 7fe:	fcc696e3          	bne	a3,a2,7ca <free+0x4a>
    p->s.size += bp->s.size;
 802:	ff852603          	lw	a2,-8(a0)
}
 806:	6422                	ld	s0,8(sp)
    p->s.ptr = bp->s.ptr;
 808:	86ba                	mv	a3,a4
    p->s.size += bp->s.size;
 80a:	0106073b          	addw	a4,a2,a6
 80e:	c798                	sw	a4,8(a5)
    p->s.ptr = bp->s.ptr;
 810:	e394                	sd	a3,0(a5)
  freep = p;
 812:	e19c                	sd	a5,0(a1)
}
 814:	0141                	add	sp,sp,16
 816:	8082                	ret

0000000000000818 <malloc>:
  return freep;
}

void*
malloc(uint nbytes)
{
 818:	7139                	add	sp,sp,-64
 81a:	f822                	sd	s0,48(sp)
 81c:	f426                	sd	s1,40(sp)
 81e:	f04a                	sd	s2,32(sp)
 820:	ec4e                	sd	s3,24(sp)
 822:	fc06                	sd	ra,56(sp)
 824:	0080                	add	s0,sp,64
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
  if((prevp = freep) == 0){
 826:	00000917          	auipc	s2,0x0
 82a:	7ea90913          	add	s2,s2,2026 # 1010 <freep>
  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
 82e:	02051493          	sll	s1,a0,0x20
 832:	9081                	srl	s1,s1,0x20
  if((prevp = freep) == 0){
 834:	00093783          	ld	a5,0(s2)
  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
 838:	04bd                	add	s1,s1,15
 83a:	8091                	srl	s1,s1,0x4
 83c:	0014899b          	addw	s3,s1,1
 840:	0485                	add	s1,s1,1
  if((prevp = freep) == 0){
 842:	c3dd                	beqz	a5,8e8 <malloc+0xd0>
    base.s.ptr = freep = prevp = &base;
    base.s.size = 0;
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 844:	6388                	ld	a0,0(a5)
    if(p->s.size >= nunits){
 846:	4518                	lw	a4,8(a0)
 848:	06977863          	bgeu	a4,s1,8b8 <malloc+0xa0>
 84c:	e852                	sd	s4,16(sp)
 84e:	e456                	sd	s5,8(sp)
 850:	e05a                	sd	s6,0(sp)
  if(nu < 4096)
 852:	6785                	lui	a5,0x1
 854:	8a4e                	mv	s4,s3
 856:	08f4e763          	bltu	s1,a5,8e4 <malloc+0xcc>
 85a:	000a0b1b          	sext.w	s6,s4
  if(p == (char*)-1)
 85e:	5afd                	li	s5,-1
  p = sbrk(nu * sizeof(Header));
 860:	004a1a1b          	sllw	s4,s4,0x4
 864:	a029                	j	86e <malloc+0x56>
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 866:	6388                	ld	a0,0(a5)
    if(p->s.size >= nunits){
 868:	4518                	lw	a4,8(a0)
 86a:	04977463          	bgeu	a4,s1,8b2 <malloc+0x9a>
        p->s.size = nunits;
      }
      freep = prevp;
      return (void*)(p + 1);
    }
    if(p == freep)
 86e:	00093703          	ld	a4,0(s2)
 872:	87aa                	mv	a5,a0
 874:	fee519e3          	bne	a0,a4,866 <malloc+0x4e>
  p = sbrk(nu * sizeof(Header));
 878:	8552                	mv	a0,s4
 87a:	00000097          	auipc	ra,0x0
 87e:	bfc080e7          	jalr	-1028(ra) # 476 <sbrk>
 882:	87aa                	mv	a5,a0
  free((void*)(hp + 1));
 884:	0541                	add	a0,a0,16
  if(p == (char*)-1)
 886:	01578b63          	beq	a5,s5,89c <malloc+0x84>
  hp->s.size = nu;
 88a:	0167a423          	sw	s6,8(a5) # 1008 <argv+0x8>
  free((void*)(hp + 1));
 88e:	00000097          	auipc	ra,0x0
 892:	ef2080e7          	jalr	-270(ra) # 780 <free>
  return freep;
 896:	00093783          	ld	a5,0(s2)
      if((p = morecore(nunits)) == 0)
 89a:	f7f1                	bnez	a5,866 <malloc+0x4e>
        return 0;
  }
}
 89c:	70e2                	ld	ra,56(sp)
 89e:	7442                	ld	s0,48(sp)
        return 0;
 8a0:	6a42                	ld	s4,16(sp)
 8a2:	6aa2                	ld	s5,8(sp)
 8a4:	6b02                	ld	s6,0(sp)
}
 8a6:	74a2                	ld	s1,40(sp)
 8a8:	7902                	ld	s2,32(sp)
 8aa:	69e2                	ld	s3,24(sp)
        return 0;
 8ac:	4501                	li	a0,0
}
 8ae:	6121                	add	sp,sp,64
 8b0:	8082                	ret
 8b2:	6a42                	ld	s4,16(sp)
 8b4:	6aa2                	ld	s5,8(sp)
 8b6:	6b02                	ld	s6,0(sp)
      if(p->s.size == nunits)
 8b8:	04e48763          	beq	s1,a4,906 <malloc+0xee>
        p->s.size -= nunits;
 8bc:	4137073b          	subw	a4,a4,s3
        p += p->s.size;
 8c0:	02071613          	sll	a2,a4,0x20
 8c4:	01c65693          	srl	a3,a2,0x1c
        p->s.size -= nunits;
 8c8:	c518                	sw	a4,8(a0)
        p += p->s.size;
 8ca:	9536                	add	a0,a0,a3
        p->s.size = nunits;
 8cc:	01352423          	sw	s3,8(a0)
}
 8d0:	70e2                	ld	ra,56(sp)
 8d2:	7442                	ld	s0,48(sp)
      freep = prevp;
 8d4:	00f93023          	sd	a5,0(s2)
}
 8d8:	74a2                	ld	s1,40(sp)
 8da:	7902                	ld	s2,32(sp)
 8dc:	69e2                	ld	s3,24(sp)
      return (void*)(p + 1);
 8de:	0541                	add	a0,a0,16
}
 8e0:	6121                	add	sp,sp,64
 8e2:	8082                	ret
  if(nu < 4096)
 8e4:	6a05                	lui	s4,0x1
 8e6:	bf95                	j	85a <malloc+0x42>
 8e8:	e852                	sd	s4,16(sp)
 8ea:	e456                	sd	s5,8(sp)
 8ec:	e05a                	sd	s6,0(sp)
    base.s.ptr = freep = prevp = &base;
 8ee:	00000517          	auipc	a0,0x0
 8f2:	73250513          	add	a0,a0,1842 # 1020 <base>
 8f6:	00a93023          	sd	a0,0(s2)
 8fa:	e108                	sd	a0,0(a0)
    base.s.size = 0;
 8fc:	00000797          	auipc	a5,0x0
 900:	7207a623          	sw	zero,1836(a5) # 1028 <base+0x8>
    if(p->s.size >= nunits){
 904:	b7b9                	j	852 <malloc+0x3a>
        prevp->s.ptr = p->s.ptr;
 906:	6118                	ld	a4,0(a0)
 908:	e398                	sd	a4,0(a5)
 90a:	b7d9                	j	8d0 <malloc+0xb8>
