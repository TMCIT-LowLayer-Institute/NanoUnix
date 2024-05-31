
user/_forktest:     file format elf64-littleriscv


Disassembly of section .text:

0000000000000000 <main>:
  print("fork test OK\n");
}

int
main(void)
{
   0:	1141                	add	sp,sp,-16
   2:	e022                	sd	s0,0(sp)
   4:	e406                	sd	ra,8(sp)
   6:	0800                	add	s0,sp,16
  forktest();
   8:	00000097          	auipc	ra,0x0
   c:	03e080e7          	jalr	62(ra) # 46 <forktest>
  exit(0);
  10:	4501                	li	a0,0
  12:	00000097          	auipc	ra,0x0
  16:	430080e7          	jalr	1072(ra) # 442 <exit>

000000000000001a <print>:
{
  1a:	1101                	add	sp,sp,-32
  1c:	e822                	sd	s0,16(sp)
  1e:	e426                	sd	s1,8(sp)
  20:	ec06                	sd	ra,24(sp)
  22:	1000                	add	s0,sp,32
  24:	84aa                	mv	s1,a0
  write(1, s, strlen(s));
  26:	00000097          	auipc	ra,0x0
  2a:	1a2080e7          	jalr	418(ra) # 1c8 <strlen>
}
  2e:	6442                	ld	s0,16(sp)
  30:	60e2                	ld	ra,24(sp)
  write(1, s, strlen(s));
  32:	85a6                	mv	a1,s1
}
  34:	64a2                	ld	s1,8(sp)
  write(1, s, strlen(s));
  36:	0005061b          	sext.w	a2,a0
  3a:	4505                	li	a0,1
}
  3c:	6105                	add	sp,sp,32
  write(1, s, strlen(s));
  3e:	00000317          	auipc	t1,0x0
  42:	42430067          	jr	1060(t1) # 462 <write>

0000000000000046 <forktest>:
{
  46:	1101                	add	sp,sp,-32
  48:	ec06                	sd	ra,24(sp)
  4a:	e822                	sd	s0,16(sp)
  4c:	e426                	sd	s1,8(sp)
  4e:	e04a                	sd	s2,0(sp)
  50:	1000                	add	s0,sp,32
  write(1, s, strlen(s));
  52:	00000517          	auipc	a0,0x0
  56:	49e50513          	add	a0,a0,1182 # 4f0 <poweroff+0xe>
  5a:	00000097          	auipc	ra,0x0
  5e:	16e080e7          	jalr	366(ra) # 1c8 <strlen>
  62:	0005061b          	sext.w	a2,a0
  66:	00000597          	auipc	a1,0x0
  6a:	48a58593          	add	a1,a1,1162 # 4f0 <poweroff+0xe>
  6e:	4505                	li	a0,1
  70:	00000097          	auipc	ra,0x0
  74:	3f2080e7          	jalr	1010(ra) # 462 <write>
  for(n=0; n<N; n++){
  78:	4481                	li	s1,0
  7a:	06400913          	li	s2,100
  7e:	a029                	j	88 <forktest+0x42>
    if(pid == 0)
  80:	c941                	beqz	a0,110 <forktest+0xca>
  for(n=0; n<N; n++){
  82:	2485                	addw	s1,s1,1
  84:	0b248763          	beq	s1,s2,132 <forktest+0xec>
    pid = fork();
  88:	00000097          	auipc	ra,0x0
  8c:	3b2080e7          	jalr	946(ra) # 43a <fork>
    if(pid < 0)
  90:	fe0558e3          	bgez	a0,80 <forktest+0x3a>
    if(wait(0) < 0){
  94:	4501                	li	a0,0
  for(; n > 0; n--){
  96:	c891                	beqz	s1,aa <forktest+0x64>
    if(wait(0) < 0){
  98:	00000097          	auipc	ra,0x0
  9c:	3b2080e7          	jalr	946(ra) # 44a <wait>
  a0:	04054463          	bltz	a0,e8 <forktest+0xa2>
  for(; n > 0; n--){
  a4:	34fd                	addw	s1,s1,-1
    if(wait(0) < 0){
  a6:	4501                	li	a0,0
  for(; n > 0; n--){
  a8:	f8e5                	bnez	s1,98 <forktest+0x52>
  if(wait(0) != -1){
  aa:	00000097          	auipc	ra,0x0
  ae:	3a0080e7          	jalr	928(ra) # 44a <wait>
  b2:	57fd                	li	a5,-1
  b4:	06f51263          	bne	a0,a5,118 <forktest+0xd2>
  write(1, s, strlen(s));
  b8:	00000517          	auipc	a0,0x0
  bc:	47850513          	add	a0,a0,1144 # 530 <poweroff+0x4e>
  c0:	00000097          	auipc	ra,0x0
  c4:	108080e7          	jalr	264(ra) # 1c8 <strlen>
}
  c8:	6442                	ld	s0,16(sp)
  ca:	60e2                	ld	ra,24(sp)
  cc:	64a2                	ld	s1,8(sp)
  ce:	6902                	ld	s2,0(sp)
  write(1, s, strlen(s));
  d0:	0005061b          	sext.w	a2,a0
  d4:	00000597          	auipc	a1,0x0
  d8:	45c58593          	add	a1,a1,1116 # 530 <poweroff+0x4e>
  dc:	4505                	li	a0,1
}
  de:	6105                	add	sp,sp,32
  write(1, s, strlen(s));
  e0:	00000317          	auipc	t1,0x0
  e4:	38230067          	jr	898(t1) # 462 <write>
  e8:	00000517          	auipc	a0,0x0
  ec:	41850513          	add	a0,a0,1048 # 500 <poweroff+0x1e>
  f0:	00000097          	auipc	ra,0x0
  f4:	0d8080e7          	jalr	216(ra) # 1c8 <strlen>
  f8:	0005061b          	sext.w	a2,a0
  fc:	00000597          	auipc	a1,0x0
 100:	40458593          	add	a1,a1,1028 # 500 <poweroff+0x1e>
 104:	4505                	li	a0,1
 106:	00000097          	auipc	ra,0x0
 10a:	35c080e7          	jalr	860(ra) # 462 <write>
      exit(1);
 10e:	4505                	li	a0,1
 110:	00000097          	auipc	ra,0x0
 114:	332080e7          	jalr	818(ra) # 442 <exit>
    print("wait got too many\n");
 118:	00000517          	auipc	a0,0x0
 11c:	40050513          	add	a0,a0,1024 # 518 <poweroff+0x36>
 120:	00000097          	auipc	ra,0x0
 124:	efa080e7          	jalr	-262(ra) # 1a <print>
    exit(1);
 128:	4505                	li	a0,1
 12a:	00000097          	auipc	ra,0x0
 12e:	318080e7          	jalr	792(ra) # 442 <exit>
    print("fork claimed to work N times!\n");
 132:	00000517          	auipc	a0,0x0
 136:	40e50513          	add	a0,a0,1038 # 540 <poweroff+0x5e>
 13a:	00000097          	auipc	ra,0x0
 13e:	ee0080e7          	jalr	-288(ra) # 1a <print>
    exit(1);
 142:	4505                	li	a0,1
 144:	00000097          	auipc	ra,0x0
 148:	2fe080e7          	jalr	766(ra) # 442 <exit>

000000000000014c <_main>:
//
// wrapper so that it's OK if main() does not call exit().
//
void
_main()
{
 14c:	1141                	add	sp,sp,-16
 14e:	e022                	sd	s0,0(sp)
 150:	e406                	sd	ra,8(sp)
 152:	0800                	add	s0,sp,16
  extern int main();
  main();
 154:	00000097          	auipc	ra,0x0
 158:	eac080e7          	jalr	-340(ra) # 0 <main>
  exit(0);
 15c:	4501                	li	a0,0
 15e:	00000097          	auipc	ra,0x0
 162:	2e4080e7          	jalr	740(ra) # 442 <exit>

0000000000000166 <strcpy>:
}

char*
strcpy(char *s, const char *t)
{
 166:	1141                	add	sp,sp,-16
 168:	e422                	sd	s0,8(sp)
 16a:	0800                	add	s0,sp,16
  char *os;

  os = s;
  while((*s++ = *t++) != 0)
 16c:	87aa                	mv	a5,a0
 16e:	0005c703          	lbu	a4,0(a1)
 172:	0785                	add	a5,a5,1
 174:	0585                	add	a1,a1,1
 176:	fee78fa3          	sb	a4,-1(a5)
 17a:	fb75                	bnez	a4,16e <strcpy+0x8>
    ;
  return os;
}
 17c:	6422                	ld	s0,8(sp)
 17e:	0141                	add	sp,sp,16
 180:	8082                	ret

0000000000000182 <strcmp>:

int
strcmp(const char *p, const char *q)
{
 182:	1141                	add	sp,sp,-16
 184:	e422                	sd	s0,8(sp)
 186:	0800                	add	s0,sp,16
  while(*p && *p == *q)
 188:	00054783          	lbu	a5,0(a0)
 18c:	e791                	bnez	a5,198 <strcmp+0x16>
 18e:	a80d                	j	1c0 <strcmp+0x3e>
 190:	00054783          	lbu	a5,0(a0)
 194:	cf99                	beqz	a5,1b2 <strcmp+0x30>
 196:	85b6                	mv	a1,a3
 198:	0005c703          	lbu	a4,0(a1)
    p++, q++;
 19c:	0505                	add	a0,a0,1
 19e:	00158693          	add	a3,a1,1
  while(*p && *p == *q)
 1a2:	fef707e3          	beq	a4,a5,190 <strcmp+0xe>
  return (uchar)*p - (uchar)*q;
 1a6:	0007851b          	sext.w	a0,a5
}
 1aa:	6422                	ld	s0,8(sp)
 1ac:	9d19                	subw	a0,a0,a4
 1ae:	0141                	add	sp,sp,16
 1b0:	8082                	ret
  return (uchar)*p - (uchar)*q;
 1b2:	0015c703          	lbu	a4,1(a1)
}
 1b6:	6422                	ld	s0,8(sp)
  return (uchar)*p - (uchar)*q;
 1b8:	4501                	li	a0,0
}
 1ba:	9d19                	subw	a0,a0,a4
 1bc:	0141                	add	sp,sp,16
 1be:	8082                	ret
  return (uchar)*p - (uchar)*q;
 1c0:	0005c703          	lbu	a4,0(a1)
 1c4:	4501                	li	a0,0
 1c6:	b7d5                	j	1aa <strcmp+0x28>

00000000000001c8 <strlen>:

uint
strlen(const char *s)
{
 1c8:	1141                	add	sp,sp,-16
 1ca:	e422                	sd	s0,8(sp)
 1cc:	0800                	add	s0,sp,16
  int n;

  for(n = 0; s[n]; n++)
 1ce:	00054783          	lbu	a5,0(a0)
 1d2:	cf91                	beqz	a5,1ee <strlen+0x26>
 1d4:	0505                	add	a0,a0,1
 1d6:	87aa                	mv	a5,a0
 1d8:	0007c703          	lbu	a4,0(a5)
 1dc:	86be                	mv	a3,a5
 1de:	0785                	add	a5,a5,1
 1e0:	ff65                	bnez	a4,1d8 <strlen+0x10>
    ;
  return n;
}
 1e2:	6422                	ld	s0,8(sp)
 1e4:	40a6853b          	subw	a0,a3,a0
 1e8:	2505                	addw	a0,a0,1
 1ea:	0141                	add	sp,sp,16
 1ec:	8082                	ret
 1ee:	6422                	ld	s0,8(sp)
  for(n = 0; s[n]; n++)
 1f0:	4501                	li	a0,0
}
 1f2:	0141                	add	sp,sp,16
 1f4:	8082                	ret

00000000000001f6 <memset>:

void*
memset(void *dst, int c, uint n)
{
 1f6:	1141                	add	sp,sp,-16
 1f8:	e422                	sd	s0,8(sp)
 1fa:	0800                	add	s0,sp,16
  char *cdst = (char *) dst;
  int i;
  for(i = 0; i < n; i++){
 1fc:	ce09                	beqz	a2,216 <memset+0x20>
 1fe:	1602                	sll	a2,a2,0x20
 200:	9201                	srl	a2,a2,0x20
    cdst[i] = c;
 202:	0ff5f593          	zext.b	a1,a1
 206:	87aa                	mv	a5,a0
 208:	00a60733          	add	a4,a2,a0
 20c:	00b78023          	sb	a1,0(a5)
  for(i = 0; i < n; i++){
 210:	0785                	add	a5,a5,1
 212:	fee79de3          	bne	a5,a4,20c <memset+0x16>
  }
  return dst;
}
 216:	6422                	ld	s0,8(sp)
 218:	0141                	add	sp,sp,16
 21a:	8082                	ret

000000000000021c <strchr>:

char*
strchr(const char *s, char c)
{
 21c:	1141                	add	sp,sp,-16
 21e:	e422                	sd	s0,8(sp)
 220:	0800                	add	s0,sp,16
  for(; *s; s++)
 222:	00054783          	lbu	a5,0(a0)
 226:	c799                	beqz	a5,234 <strchr+0x18>
    if(*s == c)
 228:	00f58763          	beq	a1,a5,236 <strchr+0x1a>
  for(; *s; s++)
 22c:	00154783          	lbu	a5,1(a0)
 230:	0505                	add	a0,a0,1
 232:	fbfd                	bnez	a5,228 <strchr+0xc>
      return (char*)s;
  return 0;
 234:	4501                	li	a0,0
}
 236:	6422                	ld	s0,8(sp)
 238:	0141                	add	sp,sp,16
 23a:	8082                	ret

000000000000023c <gets>:

char*
gets(char *buf, int max)
{
 23c:	711d                	add	sp,sp,-96
 23e:	e8a2                	sd	s0,80(sp)
 240:	e4a6                	sd	s1,72(sp)
 242:	e0ca                	sd	s2,64(sp)
 244:	fc4e                	sd	s3,56(sp)
 246:	f852                	sd	s4,48(sp)
 248:	f05a                	sd	s6,32(sp)
 24a:	ec5e                	sd	s7,24(sp)
 24c:	ec86                	sd	ra,88(sp)
 24e:	f456                	sd	s5,40(sp)
 250:	1080                	add	s0,sp,96
 252:	8baa                	mv	s7,a0
 254:	89ae                	mv	s3,a1
 256:	892a                	mv	s2,a0
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
 258:	4481                	li	s1,0
    cc = read(0, &c, 1);
    if(cc < 1)
      break;
    buf[i++] = c;
    if(c == '\n' || c == '\r')
 25a:	4a29                	li	s4,10
 25c:	4b35                	li	s6,13
  for(i=0; i+1 < max; ){
 25e:	a005                	j	27e <gets+0x42>
    cc = read(0, &c, 1);
 260:	00000097          	auipc	ra,0x0
 264:	1fa080e7          	jalr	506(ra) # 45a <read>
    if(cc < 1)
 268:	02a05363          	blez	a0,28e <gets+0x52>
    buf[i++] = c;
 26c:	faf44783          	lbu	a5,-81(s0)
    if(c == '\n' || c == '\r')
 270:	0905                	add	s2,s2,1
    buf[i++] = c;
 272:	fef90fa3          	sb	a5,-1(s2)
    if(c == '\n' || c == '\r')
 276:	01478d63          	beq	a5,s4,290 <gets+0x54>
 27a:	01678b63          	beq	a5,s6,290 <gets+0x54>
  for(i=0; i+1 < max; ){
 27e:	8aa6                	mv	s5,s1
 280:	2485                	addw	s1,s1,1
    cc = read(0, &c, 1);
 282:	4605                	li	a2,1
 284:	faf40593          	add	a1,s0,-81
 288:	4501                	li	a0,0
  for(i=0; i+1 < max; ){
 28a:	fd34cbe3          	blt	s1,s3,260 <gets+0x24>
 28e:	84d6                	mv	s1,s5
      break;
  }
  buf[i] = '\0';
 290:	94de                	add	s1,s1,s7
 292:	00048023          	sb	zero,0(s1)
  return buf;
}
 296:	60e6                	ld	ra,88(sp)
 298:	6446                	ld	s0,80(sp)
 29a:	64a6                	ld	s1,72(sp)
 29c:	6906                	ld	s2,64(sp)
 29e:	79e2                	ld	s3,56(sp)
 2a0:	7a42                	ld	s4,48(sp)
 2a2:	7aa2                	ld	s5,40(sp)
 2a4:	7b02                	ld	s6,32(sp)
 2a6:	855e                	mv	a0,s7
 2a8:	6be2                	ld	s7,24(sp)
 2aa:	6125                	add	sp,sp,96
 2ac:	8082                	ret

00000000000002ae <stat>:

int
stat(const char *n, struct stat *st)
{
 2ae:	1101                	add	sp,sp,-32
 2b0:	e822                	sd	s0,16(sp)
 2b2:	e04a                	sd	s2,0(sp)
 2b4:	ec06                	sd	ra,24(sp)
 2b6:	e426                	sd	s1,8(sp)
 2b8:	1000                	add	s0,sp,32
 2ba:	892e                	mv	s2,a1
  int fd;
  int r;

  fd = open(n, O_RDONLY);
 2bc:	4581                	li	a1,0
 2be:	00000097          	auipc	ra,0x0
 2c2:	1c4080e7          	jalr	452(ra) # 482 <open>
  if(fd < 0)
 2c6:	02054663          	bltz	a0,2f2 <stat+0x44>
    return -1;
  r = fstat(fd, st);
 2ca:	85ca                	mv	a1,s2
 2cc:	84aa                	mv	s1,a0
 2ce:	00000097          	auipc	ra,0x0
 2d2:	1cc080e7          	jalr	460(ra) # 49a <fstat>
 2d6:	87aa                	mv	a5,a0
  close(fd);
 2d8:	8526                	mv	a0,s1
  r = fstat(fd, st);
 2da:	84be                	mv	s1,a5
  close(fd);
 2dc:	00000097          	auipc	ra,0x0
 2e0:	18e080e7          	jalr	398(ra) # 46a <close>
  return r;
}
 2e4:	60e2                	ld	ra,24(sp)
 2e6:	6442                	ld	s0,16(sp)
 2e8:	6902                	ld	s2,0(sp)
 2ea:	8526                	mv	a0,s1
 2ec:	64a2                	ld	s1,8(sp)
 2ee:	6105                	add	sp,sp,32
 2f0:	8082                	ret
    return -1;
 2f2:	54fd                	li	s1,-1
 2f4:	bfc5                	j	2e4 <stat+0x36>

00000000000002f6 <atoi>:

int
atoi(const char *s)
{
 2f6:	1141                	add	sp,sp,-16
 2f8:	e422                	sd	s0,8(sp)
 2fa:	0800                	add	s0,sp,16
  int n;

  n = 0;
  while('0' <= *s && *s <= '9')
 2fc:	00054683          	lbu	a3,0(a0)
 300:	4625                	li	a2,9
 302:	fd06879b          	addw	a5,a3,-48
 306:	0ff7f793          	zext.b	a5,a5
 30a:	02f66863          	bltu	a2,a5,33a <atoi+0x44>
 30e:	872a                	mv	a4,a0
  n = 0;
 310:	4501                	li	a0,0
    n = n*10 + *s++ - '0';
 312:	0025179b          	sllw	a5,a0,0x2
 316:	9fa9                	addw	a5,a5,a0
 318:	0705                	add	a4,a4,1
 31a:	0017979b          	sllw	a5,a5,0x1
 31e:	9fb5                	addw	a5,a5,a3
  while('0' <= *s && *s <= '9')
 320:	00074683          	lbu	a3,0(a4)
    n = n*10 + *s++ - '0';
 324:	fd07851b          	addw	a0,a5,-48
  while('0' <= *s && *s <= '9')
 328:	fd06879b          	addw	a5,a3,-48
 32c:	0ff7f793          	zext.b	a5,a5
 330:	fef671e3          	bgeu	a2,a5,312 <atoi+0x1c>
  return n;
}
 334:	6422                	ld	s0,8(sp)
 336:	0141                	add	sp,sp,16
 338:	8082                	ret
 33a:	6422                	ld	s0,8(sp)
  n = 0;
 33c:	4501                	li	a0,0
}
 33e:	0141                	add	sp,sp,16
 340:	8082                	ret

0000000000000342 <memmove>:

void*
memmove(void *vdst, const void *vsrc, int n)
{
 342:	1141                	add	sp,sp,-16
 344:	e422                	sd	s0,8(sp)
 346:	0800                	add	s0,sp,16
  char *dst;
  const char *src;

  dst = vdst;
  src = vsrc;
  if (src > dst) {
 348:	02b57463          	bgeu	a0,a1,370 <memmove+0x2e>
    while(n-- > 0)
 34c:	00c05f63          	blez	a2,36a <memmove+0x28>
 350:	1602                	sll	a2,a2,0x20
 352:	9201                	srl	a2,a2,0x20
 354:	00c507b3          	add	a5,a0,a2
  dst = vdst;
 358:	872a                	mv	a4,a0
      *dst++ = *src++;
 35a:	0005c683          	lbu	a3,0(a1)
 35e:	0705                	add	a4,a4,1
 360:	0585                	add	a1,a1,1
 362:	fed70fa3          	sb	a3,-1(a4)
    while(n-- > 0)
 366:	fef71ae3          	bne	a4,a5,35a <memmove+0x18>
    src += n;
    while(n-- > 0)
      *--dst = *--src;
  }
  return vdst;
}
 36a:	6422                	ld	s0,8(sp)
 36c:	0141                	add	sp,sp,16
 36e:	8082                	ret
    dst += n;
 370:	00c50733          	add	a4,a0,a2
    src += n;
 374:	95b2                	add	a1,a1,a2
    while(n-- > 0)
 376:	fec05ae3          	blez	a2,36a <memmove+0x28>
 37a:	fff6079b          	addw	a5,a2,-1
 37e:	1782                	sll	a5,a5,0x20
 380:	9381                	srl	a5,a5,0x20
 382:	fff7c793          	not	a5,a5
 386:	97ae                	add	a5,a5,a1
      *--dst = *--src;
 388:	fff5c683          	lbu	a3,-1(a1)
 38c:	15fd                	add	a1,a1,-1
 38e:	177d                	add	a4,a4,-1
 390:	00d70023          	sb	a3,0(a4)
    while(n-- > 0)
 394:	feb79ae3          	bne	a5,a1,388 <memmove+0x46>
}
 398:	6422                	ld	s0,8(sp)
 39a:	0141                	add	sp,sp,16
 39c:	8082                	ret

000000000000039e <memcmp>:

int
memcmp(const void *s1, const void *s2, uint n)
{
 39e:	1141                	add	sp,sp,-16
 3a0:	e422                	sd	s0,8(sp)
 3a2:	0800                	add	s0,sp,16
  const char *p1 = s1, *p2 = s2;
  while (n-- > 0) {
 3a4:	c61d                	beqz	a2,3d2 <memcmp+0x34>
 3a6:	fff6069b          	addw	a3,a2,-1
 3aa:	1682                	sll	a3,a3,0x20
 3ac:	9281                	srl	a3,a3,0x20
 3ae:	0685                	add	a3,a3,1
 3b0:	96aa                	add	a3,a3,a0
 3b2:	a019                	j	3b8 <memcmp+0x1a>
 3b4:	00a68f63          	beq	a3,a0,3d2 <memcmp+0x34>
    if (*p1 != *p2) {
 3b8:	00054783          	lbu	a5,0(a0)
 3bc:	0005c703          	lbu	a4,0(a1)
      return *p1 - *p2;
    }
    p1++;
 3c0:	0505                	add	a0,a0,1
    p2++;
 3c2:	0585                	add	a1,a1,1
    if (*p1 != *p2) {
 3c4:	fee788e3          	beq	a5,a4,3b4 <memcmp+0x16>
  }
  return 0;
}
 3c8:	6422                	ld	s0,8(sp)
      return *p1 - *p2;
 3ca:	40e7853b          	subw	a0,a5,a4
}
 3ce:	0141                	add	sp,sp,16
 3d0:	8082                	ret
 3d2:	6422                	ld	s0,8(sp)
  return 0;
 3d4:	4501                	li	a0,0
}
 3d6:	0141                	add	sp,sp,16
 3d8:	8082                	ret

00000000000003da <memcpy>:

void *
memcpy(void *dst, const void *src, uint n)
{
 3da:	1141                	add	sp,sp,-16
 3dc:	e422                	sd	s0,8(sp)
 3de:	0800                	add	s0,sp,16
  return memmove(dst, src, n);
 3e0:	0006079b          	sext.w	a5,a2
  if (src > dst) {
 3e4:	02b57463          	bgeu	a0,a1,40c <memcpy+0x32>
    while(n-- > 0)
 3e8:	00f05f63          	blez	a5,406 <memcpy+0x2c>
 3ec:	1602                	sll	a2,a2,0x20
 3ee:	9201                	srl	a2,a2,0x20
 3f0:	00c587b3          	add	a5,a1,a2
  dst = vdst;
 3f4:	872a                	mv	a4,a0
      *dst++ = *src++;
 3f6:	0005c683          	lbu	a3,0(a1)
 3fa:	0585                	add	a1,a1,1
 3fc:	0705                	add	a4,a4,1
 3fe:	fed70fa3          	sb	a3,-1(a4)
    while(n-- > 0)
 402:	fef59ae3          	bne	a1,a5,3f6 <memcpy+0x1c>
}
 406:	6422                	ld	s0,8(sp)
 408:	0141                	add	sp,sp,16
 40a:	8082                	ret
    dst += n;
 40c:	00f50733          	add	a4,a0,a5
    src += n;
 410:	95be                	add	a1,a1,a5
    while(n-- > 0)
 412:	fef05ae3          	blez	a5,406 <memcpy+0x2c>
 416:	fff6079b          	addw	a5,a2,-1
 41a:	1782                	sll	a5,a5,0x20
 41c:	9381                	srl	a5,a5,0x20
 41e:	fff7c793          	not	a5,a5
 422:	97ae                	add	a5,a5,a1
      *--dst = *--src;
 424:	fff5c683          	lbu	a3,-1(a1)
 428:	15fd                	add	a1,a1,-1
 42a:	177d                	add	a4,a4,-1
 42c:	00d70023          	sb	a3,0(a4)
    while(n-- > 0)
 430:	fef59ae3          	bne	a1,a5,424 <memcpy+0x4a>
}
 434:	6422                	ld	s0,8(sp)
 436:	0141                	add	sp,sp,16
 438:	8082                	ret

000000000000043a <fork>:
# generated by usys.pl - do not edit
#include "kern/syscall.h"
.global fork
fork:
 li a7, SYS_fork
 43a:	4885                	li	a7,1
 ecall
 43c:	00000073          	ecall
 ret
 440:	8082                	ret

0000000000000442 <exit>:
.global exit
exit:
 li a7, SYS_exit
 442:	4889                	li	a7,2
 ecall
 444:	00000073          	ecall
 ret
 448:	8082                	ret

000000000000044a <wait>:
.global wait
wait:
 li a7, SYS_wait
 44a:	488d                	li	a7,3
 ecall
 44c:	00000073          	ecall
 ret
 450:	8082                	ret

0000000000000452 <pipe>:
.global pipe
pipe:
 li a7, SYS_pipe
 452:	4891                	li	a7,4
 ecall
 454:	00000073          	ecall
 ret
 458:	8082                	ret

000000000000045a <read>:
.global read
read:
 li a7, SYS_read
 45a:	4895                	li	a7,5
 ecall
 45c:	00000073          	ecall
 ret
 460:	8082                	ret

0000000000000462 <write>:
.global write
write:
 li a7, SYS_write
 462:	48c1                	li	a7,16
 ecall
 464:	00000073          	ecall
 ret
 468:	8082                	ret

000000000000046a <close>:
.global close
close:
 li a7, SYS_close
 46a:	48d5                	li	a7,21
 ecall
 46c:	00000073          	ecall
 ret
 470:	8082                	ret

0000000000000472 <kill>:
.global kill
kill:
 li a7, SYS_kill
 472:	4899                	li	a7,6
 ecall
 474:	00000073          	ecall
 ret
 478:	8082                	ret

000000000000047a <exec>:
.global exec
exec:
 li a7, SYS_exec
 47a:	489d                	li	a7,7
 ecall
 47c:	00000073          	ecall
 ret
 480:	8082                	ret

0000000000000482 <open>:
.global open
open:
 li a7, SYS_open
 482:	48bd                	li	a7,15
 ecall
 484:	00000073          	ecall
 ret
 488:	8082                	ret

000000000000048a <mknod>:
.global mknod
mknod:
 li a7, SYS_mknod
 48a:	48c5                	li	a7,17
 ecall
 48c:	00000073          	ecall
 ret
 490:	8082                	ret

0000000000000492 <unlink>:
.global unlink
unlink:
 li a7, SYS_unlink
 492:	48c9                	li	a7,18
 ecall
 494:	00000073          	ecall
 ret
 498:	8082                	ret

000000000000049a <fstat>:
.global fstat
fstat:
 li a7, SYS_fstat
 49a:	48a1                	li	a7,8
 ecall
 49c:	00000073          	ecall
 ret
 4a0:	8082                	ret

00000000000004a2 <link>:
.global link
link:
 li a7, SYS_link
 4a2:	48cd                	li	a7,19
 ecall
 4a4:	00000073          	ecall
 ret
 4a8:	8082                	ret

00000000000004aa <mkdir>:
.global mkdir
mkdir:
 li a7, SYS_mkdir
 4aa:	48d1                	li	a7,20
 ecall
 4ac:	00000073          	ecall
 ret
 4b0:	8082                	ret

00000000000004b2 <chdir>:
.global chdir
chdir:
 li a7, SYS_chdir
 4b2:	48a5                	li	a7,9
 ecall
 4b4:	00000073          	ecall
 ret
 4b8:	8082                	ret

00000000000004ba <dup>:
.global dup
dup:
 li a7, SYS_dup
 4ba:	48a9                	li	a7,10
 ecall
 4bc:	00000073          	ecall
 ret
 4c0:	8082                	ret

00000000000004c2 <getpid>:
.global getpid
getpid:
 li a7, SYS_getpid
 4c2:	48ad                	li	a7,11
 ecall
 4c4:	00000073          	ecall
 ret
 4c8:	8082                	ret

00000000000004ca <sbrk>:
.global sbrk
sbrk:
 li a7, SYS_sbrk
 4ca:	48b1                	li	a7,12
 ecall
 4cc:	00000073          	ecall
 ret
 4d0:	8082                	ret

00000000000004d2 <sleep>:
.global sleep
sleep:
 li a7, SYS_sleep
 4d2:	48b5                	li	a7,13
 ecall
 4d4:	00000073          	ecall
 ret
 4d8:	8082                	ret

00000000000004da <uptime>:
.global uptime
uptime:
 li a7, SYS_uptime
 4da:	48b9                	li	a7,14
 ecall
 4dc:	00000073          	ecall
 ret
 4e0:	8082                	ret

00000000000004e2 <poweroff>:
.global poweroff
poweroff:
 li a7, SYS_poweroff
 4e2:	48d9                	li	a7,22
 ecall
 4e4:	00000073          	ecall
 ret
 4e8:	8082                	ret
