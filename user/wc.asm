
user/_wc:     file format elf64-littleriscv


Disassembly of section .text:

0000000000000000 <wc>:

char buf[512];

void
wc(int fd, char *name)
{
   0:	7119                	add	sp,sp,-128
   2:	f8a2                	sd	s0,112(sp)
   4:	f4a6                	sd	s1,104(sp)
   6:	ecce                	sd	s3,88(sp)
   8:	e8d2                	sd	s4,80(sp)
   a:	e4d6                	sd	s5,72(sp)
   c:	e0da                	sd	s6,64(sp)
   e:	fc5e                	sd	s7,56(sp)
  10:	f862                	sd	s8,48(sp)
  12:	f466                	sd	s9,40(sp)
  14:	f06a                	sd	s10,32(sp)
  16:	0100                	add	s0,sp,128
  18:	fc86                	sd	ra,120(sp)
  1a:	f0ca                	sd	s2,96(sp)
  1c:	ec6e                	sd	s11,24(sp)
  1e:	8d2a                	mv	s10,a0
  20:	00001c97          	auipc	s9,0x1
  24:	ff0c8c93          	add	s9,s9,-16 # 1010 <buf>
  28:	f8b43423          	sd	a1,-120(s0)
  int i, n;
  int l, w, c, inword;

  l = w = c = 0;
  inword = 0;
  while((n = read(fd, buf, sizeof(buf))) > 0){
  2c:	20000613          	li	a2,512
  30:	85e6                	mv	a1,s9
  32:	856a                	mv	a0,s10
  34:	00000097          	auipc	ra,0x0
  38:	46a080e7          	jalr	1130(ra) # 49e <read>
  inword = 0;
  3c:	4481                	li	s1,0
  l = w = c = 0;
  3e:	4c01                	li	s8,0
  40:	4b81                	li	s7,0
  42:	4b01                	li	s6,0
    for(i=0; i<n; i++){
      c++;
      if(buf[i] == '\n')
  44:	4a29                	li	s4,10
        l++;
      if(strchr(" \r\t\n\v", buf[i]))
  46:	00001997          	auipc	s3,0x1
  4a:	96a98993          	add	s3,s3,-1686 # 9b0 <malloc+0x100>
  while((n = read(fd, buf, sizeof(buf))) > 0){
  4e:	8aaa                	mv	s5,a0
  50:	04a05b63          	blez	a0,a6 <wc+0xa6>
    for(i=0; i<n; i++){
  54:	00001d97          	auipc	s11,0x1
  58:	fbcd8d93          	add	s11,s11,-68 # 1010 <buf>
  5c:	00ac8933          	add	s2,s9,a0
  60:	a029                	j	6a <wc+0x6a>
        inword = 0;
  62:	4481                	li	s1,0
    for(i=0; i<n; i++){
  64:	0d85                	add	s11,s11,1
  66:	032d8363          	beq	s11,s2,8c <wc+0x8c>
      if(buf[i] == '\n')
  6a:	000dc583          	lbu	a1,0(s11)
  6e:	01459363          	bne	a1,s4,74 <wc+0x74>
        l++;
  72:	2b05                	addw	s6,s6,1
      if(strchr(" \r\t\n\v", buf[i]))
  74:	854e                	mv	a0,s3
  76:	00000097          	auipc	ra,0x0
  7a:	1ea080e7          	jalr	490(ra) # 260 <strchr>
  7e:	f175                	bnez	a0,62 <wc+0x62>
      else if(!inword){
  80:	f0f5                	bnez	s1,64 <wc+0x64>
    for(i=0; i<n; i++){
  82:	0d85                	add	s11,s11,1
        w++;
  84:	2b85                	addw	s7,s7,1
        inword = 1;
  86:	4485                	li	s1,1
    for(i=0; i<n; i++){
  88:	ff2d91e3          	bne	s11,s2,6a <wc+0x6a>
  while((n = read(fd, buf, sizeof(buf))) > 0){
  8c:	20000613          	li	a2,512
  90:	85e6                	mv	a1,s9
  92:	856a                	mv	a0,s10
  94:	00000097          	auipc	ra,0x0
  98:	40a080e7          	jalr	1034(ra) # 49e <read>
  9c:	018a8c3b          	addw	s8,s5,s8
  a0:	8aaa                	mv	s5,a0
  a2:	faa049e3          	bgtz	a0,54 <wc+0x54>
      }
    }
  }
  if(n < 0){
  a6:	ed05                	bnez	a0,de <wc+0xde>
    printf("wc: read error\n");
    exit(1);
  }
  printf("%d %d %d %s\n", l, w, c, name);
  a8:	f8843703          	ld	a4,-120(s0)
}
  ac:	7446                	ld	s0,112(sp)
  ae:	70e6                	ld	ra,120(sp)
  b0:	74a6                	ld	s1,104(sp)
  b2:	7906                	ld	s2,96(sp)
  b4:	69e6                	ld	s3,88(sp)
  b6:	6a46                	ld	s4,80(sp)
  b8:	6aa6                	ld	s5,72(sp)
  ba:	7ca2                	ld	s9,40(sp)
  bc:	7d02                	ld	s10,32(sp)
  be:	6de2                	ld	s11,24(sp)
  printf("%d %d %d %s\n", l, w, c, name);
  c0:	86e2                	mv	a3,s8
  c2:	865e                	mv	a2,s7
}
  c4:	7c42                	ld	s8,48(sp)
  c6:	7be2                	ld	s7,56(sp)
  printf("%d %d %d %s\n", l, w, c, name);
  c8:	85da                	mv	a1,s6
}
  ca:	6b06                	ld	s6,64(sp)
  printf("%d %d %d %s\n", l, w, c, name);
  cc:	00001517          	auipc	a0,0x1
  d0:	90450513          	add	a0,a0,-1788 # 9d0 <malloc+0x120>
}
  d4:	6109                	add	sp,sp,128
  printf("%d %d %d %s\n", l, w, c, name);
  d6:	00000317          	auipc	t1,0x0
  da:	70a30067          	jr	1802(t1) # 7e0 <printf>
    printf("wc: read error\n");
  de:	00001517          	auipc	a0,0x1
  e2:	8e250513          	add	a0,a0,-1822 # 9c0 <malloc+0x110>
  e6:	00000097          	auipc	ra,0x0
  ea:	6fa080e7          	jalr	1786(ra) # 7e0 <printf>
    exit(1);
  ee:	4505                	li	a0,1
  f0:	00000097          	auipc	ra,0x0
  f4:	396080e7          	jalr	918(ra) # 486 <exit>

00000000000000f8 <main>:

int
main(int argc, char *argv[])
{
  f8:	7179                	add	sp,sp,-48
  fa:	f022                	sd	s0,32(sp)
  fc:	f406                	sd	ra,40(sp)
  fe:	1800                	add	s0,sp,48
  int fd, i;

  if(argc <= 1){
 100:	4785                	li	a5,1
 102:	ec26                	sd	s1,24(sp)
 104:	e84a                	sd	s2,16(sp)
 106:	e44e                	sd	s3,8(sp)
 108:	06a7d663          	bge	a5,a0,174 <main+0x7c>
 10c:	ffe5099b          	addw	s3,a0,-2
 110:	02099793          	sll	a5,s3,0x20
 114:	01d7d993          	srl	s3,a5,0x1d
 118:	01058793          	add	a5,a1,16
 11c:	00858493          	add	s1,a1,8
 120:	99be                	add	s3,s3,a5
 122:	a829                	j	13c <main+0x44>
  for(i = 1; i < argc; i++){
    if((fd = open(argv[i], 0)) < 0){
      printf("wc: cannot open %s\n", argv[i]);
      exit(1);
    }
    wc(fd, argv[i]);
 124:	00000097          	auipc	ra,0x0
 128:	edc080e7          	jalr	-292(ra) # 0 <wc>
    close(fd);
 12c:	854a                	mv	a0,s2
  for(i = 1; i < argc; i++){
 12e:	04a1                	add	s1,s1,8
    close(fd);
 130:	00000097          	auipc	ra,0x0
 134:	37e080e7          	jalr	894(ra) # 4ae <close>
  for(i = 1; i < argc; i++){
 138:	03348963          	beq	s1,s3,16a <main+0x72>
    if((fd = open(argv[i], 0)) < 0){
 13c:	6088                	ld	a0,0(s1)
 13e:	4581                	li	a1,0
 140:	00000097          	auipc	ra,0x0
 144:	386080e7          	jalr	902(ra) # 4c6 <open>
      printf("wc: cannot open %s\n", argv[i]);
 148:	608c                	ld	a1,0(s1)
    if((fd = open(argv[i], 0)) < 0){
 14a:	892a                	mv	s2,a0
 14c:	fc055ce3          	bgez	a0,124 <main+0x2c>
      printf("wc: cannot open %s\n", argv[i]);
 150:	00001517          	auipc	a0,0x1
 154:	89050513          	add	a0,a0,-1904 # 9e0 <malloc+0x130>
 158:	00000097          	auipc	ra,0x0
 15c:	688080e7          	jalr	1672(ra) # 7e0 <printf>
      exit(1);
 160:	4505                	li	a0,1
 162:	00000097          	auipc	ra,0x0
 166:	324080e7          	jalr	804(ra) # 486 <exit>
  }
  exit(0);
 16a:	4501                	li	a0,0
 16c:	00000097          	auipc	ra,0x0
 170:	31a080e7          	jalr	794(ra) # 486 <exit>
    wc(0, "");
 174:	4501                	li	a0,0
 176:	00001597          	auipc	a1,0x1
 17a:	84258593          	add	a1,a1,-1982 # 9b8 <malloc+0x108>
 17e:	00000097          	auipc	ra,0x0
 182:	e82080e7          	jalr	-382(ra) # 0 <wc>
    exit(0);
 186:	4501                	li	a0,0
 188:	00000097          	auipc	ra,0x0
 18c:	2fe080e7          	jalr	766(ra) # 486 <exit>

0000000000000190 <_main>:
//
// wrapper so that it's OK if main() does not call exit().
//
void
_main()
{
 190:	1141                	add	sp,sp,-16
 192:	e022                	sd	s0,0(sp)
 194:	e406                	sd	ra,8(sp)
 196:	0800                	add	s0,sp,16
  extern int main();
  main();
 198:	00000097          	auipc	ra,0x0
 19c:	f60080e7          	jalr	-160(ra) # f8 <main>
  exit(0);
 1a0:	4501                	li	a0,0
 1a2:	00000097          	auipc	ra,0x0
 1a6:	2e4080e7          	jalr	740(ra) # 486 <exit>

00000000000001aa <strcpy>:
}

char*
strcpy(char *s, const char *t)
{
 1aa:	1141                	add	sp,sp,-16
 1ac:	e422                	sd	s0,8(sp)
 1ae:	0800                	add	s0,sp,16
  char *os;

  os = s;
  while((*s++ = *t++) != 0)
 1b0:	87aa                	mv	a5,a0
 1b2:	0005c703          	lbu	a4,0(a1)
 1b6:	0785                	add	a5,a5,1
 1b8:	0585                	add	a1,a1,1
 1ba:	fee78fa3          	sb	a4,-1(a5)
 1be:	fb75                	bnez	a4,1b2 <strcpy+0x8>
    ;
  return os;
}
 1c0:	6422                	ld	s0,8(sp)
 1c2:	0141                	add	sp,sp,16
 1c4:	8082                	ret

00000000000001c6 <strcmp>:

int
strcmp(const char *p, const char *q)
{
 1c6:	1141                	add	sp,sp,-16
 1c8:	e422                	sd	s0,8(sp)
 1ca:	0800                	add	s0,sp,16
  while(*p && *p == *q)
 1cc:	00054783          	lbu	a5,0(a0)
 1d0:	e791                	bnez	a5,1dc <strcmp+0x16>
 1d2:	a80d                	j	204 <strcmp+0x3e>
 1d4:	00054783          	lbu	a5,0(a0)
 1d8:	cf99                	beqz	a5,1f6 <strcmp+0x30>
 1da:	85b6                	mv	a1,a3
 1dc:	0005c703          	lbu	a4,0(a1)
    p++, q++;
 1e0:	0505                	add	a0,a0,1
 1e2:	00158693          	add	a3,a1,1
  while(*p && *p == *q)
 1e6:	fef707e3          	beq	a4,a5,1d4 <strcmp+0xe>
  return (uchar)*p - (uchar)*q;
 1ea:	0007851b          	sext.w	a0,a5
}
 1ee:	6422                	ld	s0,8(sp)
 1f0:	9d19                	subw	a0,a0,a4
 1f2:	0141                	add	sp,sp,16
 1f4:	8082                	ret
  return (uchar)*p - (uchar)*q;
 1f6:	0015c703          	lbu	a4,1(a1)
}
 1fa:	6422                	ld	s0,8(sp)
  return (uchar)*p - (uchar)*q;
 1fc:	4501                	li	a0,0
}
 1fe:	9d19                	subw	a0,a0,a4
 200:	0141                	add	sp,sp,16
 202:	8082                	ret
  return (uchar)*p - (uchar)*q;
 204:	0005c703          	lbu	a4,0(a1)
 208:	4501                	li	a0,0
 20a:	b7d5                	j	1ee <strcmp+0x28>

000000000000020c <strlen>:

uint
strlen(const char *s)
{
 20c:	1141                	add	sp,sp,-16
 20e:	e422                	sd	s0,8(sp)
 210:	0800                	add	s0,sp,16
  int n;

  for(n = 0; s[n]; n++)
 212:	00054783          	lbu	a5,0(a0)
 216:	cf91                	beqz	a5,232 <strlen+0x26>
 218:	0505                	add	a0,a0,1
 21a:	87aa                	mv	a5,a0
 21c:	0007c703          	lbu	a4,0(a5)
 220:	86be                	mv	a3,a5
 222:	0785                	add	a5,a5,1
 224:	ff65                	bnez	a4,21c <strlen+0x10>
    ;
  return n;
}
 226:	6422                	ld	s0,8(sp)
 228:	40a6853b          	subw	a0,a3,a0
 22c:	2505                	addw	a0,a0,1
 22e:	0141                	add	sp,sp,16
 230:	8082                	ret
 232:	6422                	ld	s0,8(sp)
  for(n = 0; s[n]; n++)
 234:	4501                	li	a0,0
}
 236:	0141                	add	sp,sp,16
 238:	8082                	ret

000000000000023a <memset>:

void*
memset(void *dst, int c, uint n)
{
 23a:	1141                	add	sp,sp,-16
 23c:	e422                	sd	s0,8(sp)
 23e:	0800                	add	s0,sp,16
  char *cdst = (char *) dst;
  int i;
  for(i = 0; i < n; i++){
 240:	ce09                	beqz	a2,25a <memset+0x20>
 242:	1602                	sll	a2,a2,0x20
 244:	9201                	srl	a2,a2,0x20
    cdst[i] = c;
 246:	0ff5f593          	zext.b	a1,a1
 24a:	87aa                	mv	a5,a0
 24c:	00a60733          	add	a4,a2,a0
 250:	00b78023          	sb	a1,0(a5)
  for(i = 0; i < n; i++){
 254:	0785                	add	a5,a5,1
 256:	fee79de3          	bne	a5,a4,250 <memset+0x16>
  }
  return dst;
}
 25a:	6422                	ld	s0,8(sp)
 25c:	0141                	add	sp,sp,16
 25e:	8082                	ret

0000000000000260 <strchr>:

char*
strchr(const char *s, char c)
{
 260:	1141                	add	sp,sp,-16
 262:	e422                	sd	s0,8(sp)
 264:	0800                	add	s0,sp,16
  for(; *s; s++)
 266:	00054783          	lbu	a5,0(a0)
 26a:	c799                	beqz	a5,278 <strchr+0x18>
    if(*s == c)
 26c:	00f58763          	beq	a1,a5,27a <strchr+0x1a>
  for(; *s; s++)
 270:	00154783          	lbu	a5,1(a0)
 274:	0505                	add	a0,a0,1
 276:	fbfd                	bnez	a5,26c <strchr+0xc>
      return (char*)s;
  return 0;
 278:	4501                	li	a0,0
}
 27a:	6422                	ld	s0,8(sp)
 27c:	0141                	add	sp,sp,16
 27e:	8082                	ret

0000000000000280 <gets>:

char*
gets(char *buf, int max)
{
 280:	711d                	add	sp,sp,-96
 282:	e8a2                	sd	s0,80(sp)
 284:	e4a6                	sd	s1,72(sp)
 286:	e0ca                	sd	s2,64(sp)
 288:	fc4e                	sd	s3,56(sp)
 28a:	f852                	sd	s4,48(sp)
 28c:	f05a                	sd	s6,32(sp)
 28e:	ec5e                	sd	s7,24(sp)
 290:	ec86                	sd	ra,88(sp)
 292:	f456                	sd	s5,40(sp)
 294:	1080                	add	s0,sp,96
 296:	8baa                	mv	s7,a0
 298:	89ae                	mv	s3,a1
 29a:	892a                	mv	s2,a0
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
 29c:	4481                	li	s1,0
    cc = read(0, &c, 1);
    if(cc < 1)
      break;
    buf[i++] = c;
    if(c == '\n' || c == '\r')
 29e:	4a29                	li	s4,10
 2a0:	4b35                	li	s6,13
  for(i=0; i+1 < max; ){
 2a2:	a005                	j	2c2 <gets+0x42>
    cc = read(0, &c, 1);
 2a4:	00000097          	auipc	ra,0x0
 2a8:	1fa080e7          	jalr	506(ra) # 49e <read>
    if(cc < 1)
 2ac:	02a05363          	blez	a0,2d2 <gets+0x52>
    buf[i++] = c;
 2b0:	faf44783          	lbu	a5,-81(s0)
    if(c == '\n' || c == '\r')
 2b4:	0905                	add	s2,s2,1
    buf[i++] = c;
 2b6:	fef90fa3          	sb	a5,-1(s2)
    if(c == '\n' || c == '\r')
 2ba:	01478d63          	beq	a5,s4,2d4 <gets+0x54>
 2be:	01678b63          	beq	a5,s6,2d4 <gets+0x54>
  for(i=0; i+1 < max; ){
 2c2:	8aa6                	mv	s5,s1
 2c4:	2485                	addw	s1,s1,1
    cc = read(0, &c, 1);
 2c6:	4605                	li	a2,1
 2c8:	faf40593          	add	a1,s0,-81
 2cc:	4501                	li	a0,0
  for(i=0; i+1 < max; ){
 2ce:	fd34cbe3          	blt	s1,s3,2a4 <gets+0x24>
 2d2:	84d6                	mv	s1,s5
      break;
  }
  buf[i] = '\0';
 2d4:	94de                	add	s1,s1,s7
 2d6:	00048023          	sb	zero,0(s1)
  return buf;
}
 2da:	60e6                	ld	ra,88(sp)
 2dc:	6446                	ld	s0,80(sp)
 2de:	64a6                	ld	s1,72(sp)
 2e0:	6906                	ld	s2,64(sp)
 2e2:	79e2                	ld	s3,56(sp)
 2e4:	7a42                	ld	s4,48(sp)
 2e6:	7aa2                	ld	s5,40(sp)
 2e8:	7b02                	ld	s6,32(sp)
 2ea:	855e                	mv	a0,s7
 2ec:	6be2                	ld	s7,24(sp)
 2ee:	6125                	add	sp,sp,96
 2f0:	8082                	ret

00000000000002f2 <stat>:

int
stat(const char *n, struct stat *st)
{
 2f2:	1101                	add	sp,sp,-32
 2f4:	e822                	sd	s0,16(sp)
 2f6:	e04a                	sd	s2,0(sp)
 2f8:	ec06                	sd	ra,24(sp)
 2fa:	e426                	sd	s1,8(sp)
 2fc:	1000                	add	s0,sp,32
 2fe:	892e                	mv	s2,a1
  int fd;
  int r;

  fd = open(n, O_RDONLY);
 300:	4581                	li	a1,0
 302:	00000097          	auipc	ra,0x0
 306:	1c4080e7          	jalr	452(ra) # 4c6 <open>
  if(fd < 0)
 30a:	02054663          	bltz	a0,336 <stat+0x44>
    return -1;
  r = fstat(fd, st);
 30e:	85ca                	mv	a1,s2
 310:	84aa                	mv	s1,a0
 312:	00000097          	auipc	ra,0x0
 316:	1cc080e7          	jalr	460(ra) # 4de <fstat>
 31a:	87aa                	mv	a5,a0
  close(fd);
 31c:	8526                	mv	a0,s1
  r = fstat(fd, st);
 31e:	84be                	mv	s1,a5
  close(fd);
 320:	00000097          	auipc	ra,0x0
 324:	18e080e7          	jalr	398(ra) # 4ae <close>
  return r;
}
 328:	60e2                	ld	ra,24(sp)
 32a:	6442                	ld	s0,16(sp)
 32c:	6902                	ld	s2,0(sp)
 32e:	8526                	mv	a0,s1
 330:	64a2                	ld	s1,8(sp)
 332:	6105                	add	sp,sp,32
 334:	8082                	ret
    return -1;
 336:	54fd                	li	s1,-1
 338:	bfc5                	j	328 <stat+0x36>

000000000000033a <atoi>:

int
atoi(const char *s)
{
 33a:	1141                	add	sp,sp,-16
 33c:	e422                	sd	s0,8(sp)
 33e:	0800                	add	s0,sp,16
  int n;

  n = 0;
  while('0' <= *s && *s <= '9')
 340:	00054683          	lbu	a3,0(a0)
 344:	4625                	li	a2,9
 346:	fd06879b          	addw	a5,a3,-48
 34a:	0ff7f793          	zext.b	a5,a5
 34e:	02f66863          	bltu	a2,a5,37e <atoi+0x44>
 352:	872a                	mv	a4,a0
  n = 0;
 354:	4501                	li	a0,0
    n = n*10 + *s++ - '0';
 356:	0025179b          	sllw	a5,a0,0x2
 35a:	9fa9                	addw	a5,a5,a0
 35c:	0705                	add	a4,a4,1
 35e:	0017979b          	sllw	a5,a5,0x1
 362:	9fb5                	addw	a5,a5,a3
  while('0' <= *s && *s <= '9')
 364:	00074683          	lbu	a3,0(a4)
    n = n*10 + *s++ - '0';
 368:	fd07851b          	addw	a0,a5,-48
  while('0' <= *s && *s <= '9')
 36c:	fd06879b          	addw	a5,a3,-48
 370:	0ff7f793          	zext.b	a5,a5
 374:	fef671e3          	bgeu	a2,a5,356 <atoi+0x1c>
  return n;
}
 378:	6422                	ld	s0,8(sp)
 37a:	0141                	add	sp,sp,16
 37c:	8082                	ret
 37e:	6422                	ld	s0,8(sp)
  n = 0;
 380:	4501                	li	a0,0
}
 382:	0141                	add	sp,sp,16
 384:	8082                	ret

0000000000000386 <memmove>:

void*
memmove(void *vdst, const void *vsrc, int n)
{
 386:	1141                	add	sp,sp,-16
 388:	e422                	sd	s0,8(sp)
 38a:	0800                	add	s0,sp,16
  char *dst;
  const char *src;

  dst = vdst;
  src = vsrc;
  if (src > dst) {
 38c:	02b57463          	bgeu	a0,a1,3b4 <memmove+0x2e>
    while(n-- > 0)
 390:	00c05f63          	blez	a2,3ae <memmove+0x28>
 394:	1602                	sll	a2,a2,0x20
 396:	9201                	srl	a2,a2,0x20
 398:	00c507b3          	add	a5,a0,a2
  dst = vdst;
 39c:	872a                	mv	a4,a0
      *dst++ = *src++;
 39e:	0005c683          	lbu	a3,0(a1)
 3a2:	0705                	add	a4,a4,1
 3a4:	0585                	add	a1,a1,1
 3a6:	fed70fa3          	sb	a3,-1(a4)
    while(n-- > 0)
 3aa:	fef71ae3          	bne	a4,a5,39e <memmove+0x18>
    src += n;
    while(n-- > 0)
      *--dst = *--src;
  }
  return vdst;
}
 3ae:	6422                	ld	s0,8(sp)
 3b0:	0141                	add	sp,sp,16
 3b2:	8082                	ret
    dst += n;
 3b4:	00c50733          	add	a4,a0,a2
    src += n;
 3b8:	95b2                	add	a1,a1,a2
    while(n-- > 0)
 3ba:	fec05ae3          	blez	a2,3ae <memmove+0x28>
 3be:	fff6079b          	addw	a5,a2,-1
 3c2:	1782                	sll	a5,a5,0x20
 3c4:	9381                	srl	a5,a5,0x20
 3c6:	fff7c793          	not	a5,a5
 3ca:	97ae                	add	a5,a5,a1
      *--dst = *--src;
 3cc:	fff5c683          	lbu	a3,-1(a1)
 3d0:	15fd                	add	a1,a1,-1
 3d2:	177d                	add	a4,a4,-1
 3d4:	00d70023          	sb	a3,0(a4)
    while(n-- > 0)
 3d8:	feb79ae3          	bne	a5,a1,3cc <memmove+0x46>
}
 3dc:	6422                	ld	s0,8(sp)
 3de:	0141                	add	sp,sp,16
 3e0:	8082                	ret

00000000000003e2 <memcmp>:

int
memcmp(const void *s1, const void *s2, uint n)
{
 3e2:	1141                	add	sp,sp,-16
 3e4:	e422                	sd	s0,8(sp)
 3e6:	0800                	add	s0,sp,16
  const char *p1 = s1, *p2 = s2;
  while (n-- > 0) {
 3e8:	c61d                	beqz	a2,416 <memcmp+0x34>
 3ea:	fff6069b          	addw	a3,a2,-1
 3ee:	1682                	sll	a3,a3,0x20
 3f0:	9281                	srl	a3,a3,0x20
 3f2:	0685                	add	a3,a3,1
 3f4:	96aa                	add	a3,a3,a0
 3f6:	a019                	j	3fc <memcmp+0x1a>
 3f8:	00a68f63          	beq	a3,a0,416 <memcmp+0x34>
    if (*p1 != *p2) {
 3fc:	00054783          	lbu	a5,0(a0)
 400:	0005c703          	lbu	a4,0(a1)
      return *p1 - *p2;
    }
    p1++;
 404:	0505                	add	a0,a0,1
    p2++;
 406:	0585                	add	a1,a1,1
    if (*p1 != *p2) {
 408:	fee788e3          	beq	a5,a4,3f8 <memcmp+0x16>
  }
  return 0;
}
 40c:	6422                	ld	s0,8(sp)
      return *p1 - *p2;
 40e:	40e7853b          	subw	a0,a5,a4
}
 412:	0141                	add	sp,sp,16
 414:	8082                	ret
 416:	6422                	ld	s0,8(sp)
  return 0;
 418:	4501                	li	a0,0
}
 41a:	0141                	add	sp,sp,16
 41c:	8082                	ret

000000000000041e <memcpy>:

void *
memcpy(void *dst, const void *src, uint n)
{
 41e:	1141                	add	sp,sp,-16
 420:	e422                	sd	s0,8(sp)
 422:	0800                	add	s0,sp,16
  return memmove(dst, src, n);
 424:	0006079b          	sext.w	a5,a2
  if (src > dst) {
 428:	02b57463          	bgeu	a0,a1,450 <memcpy+0x32>
    while(n-- > 0)
 42c:	00f05f63          	blez	a5,44a <memcpy+0x2c>
 430:	1602                	sll	a2,a2,0x20
 432:	9201                	srl	a2,a2,0x20
 434:	00c587b3          	add	a5,a1,a2
  dst = vdst;
 438:	872a                	mv	a4,a0
      *dst++ = *src++;
 43a:	0005c683          	lbu	a3,0(a1)
 43e:	0585                	add	a1,a1,1
 440:	0705                	add	a4,a4,1
 442:	fed70fa3          	sb	a3,-1(a4)
    while(n-- > 0)
 446:	fef59ae3          	bne	a1,a5,43a <memcpy+0x1c>
}
 44a:	6422                	ld	s0,8(sp)
 44c:	0141                	add	sp,sp,16
 44e:	8082                	ret
    dst += n;
 450:	00f50733          	add	a4,a0,a5
    src += n;
 454:	95be                	add	a1,a1,a5
    while(n-- > 0)
 456:	fef05ae3          	blez	a5,44a <memcpy+0x2c>
 45a:	fff6079b          	addw	a5,a2,-1
 45e:	1782                	sll	a5,a5,0x20
 460:	9381                	srl	a5,a5,0x20
 462:	fff7c793          	not	a5,a5
 466:	97ae                	add	a5,a5,a1
      *--dst = *--src;
 468:	fff5c683          	lbu	a3,-1(a1)
 46c:	15fd                	add	a1,a1,-1
 46e:	177d                	add	a4,a4,-1
 470:	00d70023          	sb	a3,0(a4)
    while(n-- > 0)
 474:	fef59ae3          	bne	a1,a5,468 <memcpy+0x4a>
}
 478:	6422                	ld	s0,8(sp)
 47a:	0141                	add	sp,sp,16
 47c:	8082                	ret

000000000000047e <fork>:
# generated by usys.pl - do not edit
#include "kern/syscall.h"
.global fork
fork:
 li a7, SYS_fork
 47e:	4885                	li	a7,1
 ecall
 480:	00000073          	ecall
 ret
 484:	8082                	ret

0000000000000486 <exit>:
.global exit
exit:
 li a7, SYS_exit
 486:	4889                	li	a7,2
 ecall
 488:	00000073          	ecall
 ret
 48c:	8082                	ret

000000000000048e <wait>:
.global wait
wait:
 li a7, SYS_wait
 48e:	488d                	li	a7,3
 ecall
 490:	00000073          	ecall
 ret
 494:	8082                	ret

0000000000000496 <pipe>:
.global pipe
pipe:
 li a7, SYS_pipe
 496:	4891                	li	a7,4
 ecall
 498:	00000073          	ecall
 ret
 49c:	8082                	ret

000000000000049e <read>:
.global read
read:
 li a7, SYS_read
 49e:	4895                	li	a7,5
 ecall
 4a0:	00000073          	ecall
 ret
 4a4:	8082                	ret

00000000000004a6 <write>:
.global write
write:
 li a7, SYS_write
 4a6:	48c1                	li	a7,16
 ecall
 4a8:	00000073          	ecall
 ret
 4ac:	8082                	ret

00000000000004ae <close>:
.global close
close:
 li a7, SYS_close
 4ae:	48d5                	li	a7,21
 ecall
 4b0:	00000073          	ecall
 ret
 4b4:	8082                	ret

00000000000004b6 <kill>:
.global kill
kill:
 li a7, SYS_kill
 4b6:	4899                	li	a7,6
 ecall
 4b8:	00000073          	ecall
 ret
 4bc:	8082                	ret

00000000000004be <exec>:
.global exec
exec:
 li a7, SYS_exec
 4be:	489d                	li	a7,7
 ecall
 4c0:	00000073          	ecall
 ret
 4c4:	8082                	ret

00000000000004c6 <open>:
.global open
open:
 li a7, SYS_open
 4c6:	48bd                	li	a7,15
 ecall
 4c8:	00000073          	ecall
 ret
 4cc:	8082                	ret

00000000000004ce <mknod>:
.global mknod
mknod:
 li a7, SYS_mknod
 4ce:	48c5                	li	a7,17
 ecall
 4d0:	00000073          	ecall
 ret
 4d4:	8082                	ret

00000000000004d6 <unlink>:
.global unlink
unlink:
 li a7, SYS_unlink
 4d6:	48c9                	li	a7,18
 ecall
 4d8:	00000073          	ecall
 ret
 4dc:	8082                	ret

00000000000004de <fstat>:
.global fstat
fstat:
 li a7, SYS_fstat
 4de:	48a1                	li	a7,8
 ecall
 4e0:	00000073          	ecall
 ret
 4e4:	8082                	ret

00000000000004e6 <link>:
.global link
link:
 li a7, SYS_link
 4e6:	48cd                	li	a7,19
 ecall
 4e8:	00000073          	ecall
 ret
 4ec:	8082                	ret

00000000000004ee <mkdir>:
.global mkdir
mkdir:
 li a7, SYS_mkdir
 4ee:	48d1                	li	a7,20
 ecall
 4f0:	00000073          	ecall
 ret
 4f4:	8082                	ret

00000000000004f6 <chdir>:
.global chdir
chdir:
 li a7, SYS_chdir
 4f6:	48a5                	li	a7,9
 ecall
 4f8:	00000073          	ecall
 ret
 4fc:	8082                	ret

00000000000004fe <dup>:
.global dup
dup:
 li a7, SYS_dup
 4fe:	48a9                	li	a7,10
 ecall
 500:	00000073          	ecall
 ret
 504:	8082                	ret

0000000000000506 <getpid>:
.global getpid
getpid:
 li a7, SYS_getpid
 506:	48ad                	li	a7,11
 ecall
 508:	00000073          	ecall
 ret
 50c:	8082                	ret

000000000000050e <sbrk>:
.global sbrk
sbrk:
 li a7, SYS_sbrk
 50e:	48b1                	li	a7,12
 ecall
 510:	00000073          	ecall
 ret
 514:	8082                	ret

0000000000000516 <sleep>:
.global sleep
sleep:
 li a7, SYS_sleep
 516:	48b5                	li	a7,13
 ecall
 518:	00000073          	ecall
 ret
 51c:	8082                	ret

000000000000051e <uptime>:
.global uptime
uptime:
 li a7, SYS_uptime
 51e:	48b9                	li	a7,14
 ecall
 520:	00000073          	ecall
 ret
 524:	8082                	ret

0000000000000526 <poweroff>:
.global poweroff
poweroff:
 li a7, SYS_poweroff
 526:	48d9                	li	a7,22
 ecall
 528:	00000073          	ecall
 ret
 52c:	8082                	ret

000000000000052e <printint>:
  write(fd, &c, 1);
}

static void
printint(int fd, int xx, int base, int sgn)
{
 52e:	715d                	add	sp,sp,-80
 530:	e0a2                	sd	s0,64(sp)
 532:	f84a                	sd	s2,48(sp)
 534:	e486                	sd	ra,72(sp)
 536:	fc26                	sd	s1,56(sp)
 538:	f44e                	sd	s3,40(sp)
 53a:	0880                	add	s0,sp,80
 53c:	892a                	mv	s2,a0
  char buf[16];
  int i, neg;
  uint x;

  neg = 0;
  if(sgn && xx < 0){
 53e:	c299                	beqz	a3,544 <printint+0x16>
 540:	0805c263          	bltz	a1,5c4 <printint+0x96>
    neg = 1;
    x = -xx;
  } else {
    x = xx;
 544:	2581                	sext.w	a1,a1
  neg = 0;
 546:	4681                	li	a3,0
  }

  i = 0;
  do{
    buf[i++] = digits[x % base];
 548:	2601                	sext.w	a2,a2
 54a:	fc040713          	add	a4,s0,-64
  i = 0;
 54e:	4501                	li	a0,0
 550:	00000897          	auipc	a7,0x0
 554:	50888893          	add	a7,a7,1288 # a58 <digits>
    buf[i++] = digits[x % base];
 558:	02c5f7bb          	remuw	a5,a1,a2
  }while((x /= base) != 0);
 55c:	0705                	add	a4,a4,1
 55e:	0005881b          	sext.w	a6,a1
 562:	84aa                	mv	s1,a0
    buf[i++] = digits[x % base];
 564:	2505                	addw	a0,a0,1
 566:	1782                	sll	a5,a5,0x20
 568:	9381                	srl	a5,a5,0x20
 56a:	97c6                	add	a5,a5,a7
 56c:	0007c783          	lbu	a5,0(a5)
  }while((x /= base) != 0);
 570:	02c5d5bb          	divuw	a1,a1,a2
    buf[i++] = digits[x % base];
 574:	fef70fa3          	sb	a5,-1(a4)
  }while((x /= base) != 0);
 578:	fec870e3          	bgeu	a6,a2,558 <printint+0x2a>
  if(neg)
 57c:	ca89                	beqz	a3,58e <printint+0x60>
    buf[i++] = '-';
 57e:	fd050793          	add	a5,a0,-48
 582:	97a2                	add	a5,a5,s0
 584:	02d00713          	li	a4,45
 588:	fee78823          	sb	a4,-16(a5)

  while(--i >= 0)
 58c:	84aa                	mv	s1,a0
 58e:	fc040793          	add	a5,s0,-64
 592:	94be                	add	s1,s1,a5
 594:	fff78993          	add	s3,a5,-1
    putc(fd, buf[i]);
 598:	0004c783          	lbu	a5,0(s1)
  write(fd, &c, 1);
 59c:	4605                	li	a2,1
 59e:	fbf40593          	add	a1,s0,-65
 5a2:	854a                	mv	a0,s2
  while(--i >= 0)
 5a4:	14fd                	add	s1,s1,-1
 5a6:	faf40fa3          	sb	a5,-65(s0)
  write(fd, &c, 1);
 5aa:	00000097          	auipc	ra,0x0
 5ae:	efc080e7          	jalr	-260(ra) # 4a6 <write>
  while(--i >= 0)
 5b2:	ff3493e3          	bne	s1,s3,598 <printint+0x6a>
}
 5b6:	60a6                	ld	ra,72(sp)
 5b8:	6406                	ld	s0,64(sp)
 5ba:	74e2                	ld	s1,56(sp)
 5bc:	7942                	ld	s2,48(sp)
 5be:	79a2                	ld	s3,40(sp)
 5c0:	6161                	add	sp,sp,80
 5c2:	8082                	ret
    x = -xx;
 5c4:	40b005bb          	negw	a1,a1
 5c8:	b741                	j	548 <printint+0x1a>

00000000000005ca <vprintf>:
}

// Print to the given fd. Only understands %d, %x, %p, %s.
void
vprintf(int fd, const char *fmt, va_list ap)
{
 5ca:	7159                	add	sp,sp,-112
 5cc:	f0a2                	sd	s0,96(sp)
 5ce:	f486                	sd	ra,104(sp)
 5d0:	e8ca                	sd	s2,80(sp)
 5d2:	1880                	add	s0,sp,112
  char *s;
  int c, i, state;

  state = 0;
  for(i = 0; fmt[i]; i++){
 5d4:	0005c903          	lbu	s2,0(a1)
 5d8:	04090f63          	beqz	s2,636 <vprintf+0x6c>
 5dc:	eca6                	sd	s1,88(sp)
 5de:	e4ce                	sd	s3,72(sp)
 5e0:	e0d2                	sd	s4,64(sp)
 5e2:	fc56                	sd	s5,56(sp)
 5e4:	f85a                	sd	s6,48(sp)
 5e6:	f45e                	sd	s7,40(sp)
 5e8:	f062                	sd	s8,32(sp)
 5ea:	8a2a                	mv	s4,a0
 5ec:	8c32                	mv	s8,a2
 5ee:	00158493          	add	s1,a1,1
 5f2:	4981                	li	s3,0
      if(c == '%'){
        state = '%';
      } else {
        putc(fd, c);
      }
    } else if(state == '%'){
 5f4:	02500a93          	li	s5,37
 5f8:	4bd5                	li	s7,21
 5fa:	00000b17          	auipc	s6,0x0
 5fe:	406b0b13          	add	s6,s6,1030 # a00 <malloc+0x150>
    if(state == 0){
 602:	02099f63          	bnez	s3,640 <vprintf+0x76>
      if(c == '%'){
 606:	05590c63          	beq	s2,s5,65e <vprintf+0x94>
  write(fd, &c, 1);
 60a:	4605                	li	a2,1
 60c:	f9f40593          	add	a1,s0,-97
 610:	8552                	mv	a0,s4
 612:	f9240fa3          	sb	s2,-97(s0)
 616:	00000097          	auipc	ra,0x0
 61a:	e90080e7          	jalr	-368(ra) # 4a6 <write>
  for(i = 0; fmt[i]; i++){
 61e:	0004c903          	lbu	s2,0(s1)
 622:	0485                	add	s1,s1,1
 624:	fc091fe3          	bnez	s2,602 <vprintf+0x38>
 628:	64e6                	ld	s1,88(sp)
 62a:	69a6                	ld	s3,72(sp)
 62c:	6a06                	ld	s4,64(sp)
 62e:	7ae2                	ld	s5,56(sp)
 630:	7b42                	ld	s6,48(sp)
 632:	7ba2                	ld	s7,40(sp)
 634:	7c02                	ld	s8,32(sp)
        putc(fd, c);
      }
      state = 0;
    }
  }
}
 636:	70a6                	ld	ra,104(sp)
 638:	7406                	ld	s0,96(sp)
 63a:	6946                	ld	s2,80(sp)
 63c:	6165                	add	sp,sp,112
 63e:	8082                	ret
    } else if(state == '%'){
 640:	fd599fe3          	bne	s3,s5,61e <vprintf+0x54>
      if(c == 'd'){
 644:	15590463          	beq	s2,s5,78c <vprintf+0x1c2>
 648:	f9d9079b          	addw	a5,s2,-99
 64c:	0ff7f793          	zext.b	a5,a5
 650:	00fbea63          	bltu	s7,a5,664 <vprintf+0x9a>
 654:	078a                	sll	a5,a5,0x2
 656:	97da                	add	a5,a5,s6
 658:	439c                	lw	a5,0(a5)
 65a:	97da                	add	a5,a5,s6
 65c:	8782                	jr	a5
        state = '%';
 65e:	02500993          	li	s3,37
 662:	bf75                	j	61e <vprintf+0x54>
  write(fd, &c, 1);
 664:	f9f40993          	add	s3,s0,-97
 668:	4605                	li	a2,1
 66a:	85ce                	mv	a1,s3
 66c:	02500793          	li	a5,37
 670:	8552                	mv	a0,s4
 672:	f8f40fa3          	sb	a5,-97(s0)
 676:	00000097          	auipc	ra,0x0
 67a:	e30080e7          	jalr	-464(ra) # 4a6 <write>
 67e:	4605                	li	a2,1
 680:	85ce                	mv	a1,s3
 682:	8552                	mv	a0,s4
 684:	f9240fa3          	sb	s2,-97(s0)
 688:	00000097          	auipc	ra,0x0
 68c:	e1e080e7          	jalr	-482(ra) # 4a6 <write>
        while(*s != 0){
 690:	4981                	li	s3,0
 692:	b771                	j	61e <vprintf+0x54>
        putc(fd, va_arg(ap, uint));
 694:	000c2783          	lw	a5,0(s8)
  write(fd, &c, 1);
 698:	4605                	li	a2,1
 69a:	f9f40593          	add	a1,s0,-97
 69e:	8552                	mv	a0,s4
        putc(fd, va_arg(ap, uint));
 6a0:	f8f40fa3          	sb	a5,-97(s0)
 6a4:	0c21                	add	s8,s8,8
  write(fd, &c, 1);
 6a6:	00000097          	auipc	ra,0x0
 6aa:	e00080e7          	jalr	-512(ra) # 4a6 <write>
 6ae:	4981                	li	s3,0
 6b0:	b7bd                	j	61e <vprintf+0x54>
        printint(fd, va_arg(ap, int), 10, 1);
 6b2:	000c2583          	lw	a1,0(s8)
 6b6:	4685                	li	a3,1
        printint(fd, va_arg(ap, uint64), 10, 0);
 6b8:	4629                	li	a2,10
 6ba:	8552                	mv	a0,s4
 6bc:	0c21                	add	s8,s8,8
 6be:	00000097          	auipc	ra,0x0
 6c2:	e70080e7          	jalr	-400(ra) # 52e <printint>
 6c6:	4981                	li	s3,0
 6c8:	bf99                	j	61e <vprintf+0x54>
 6ca:	000c2583          	lw	a1,0(s8)
 6ce:	4681                	li	a3,0
 6d0:	b7e5                	j	6b8 <vprintf+0xee>
  write(fd, &c, 1);
 6d2:	f9f40993          	add	s3,s0,-97
 6d6:	03000793          	li	a5,48
 6da:	4605                	li	a2,1
 6dc:	85ce                	mv	a1,s3
 6de:	8552                	mv	a0,s4
 6e0:	ec66                	sd	s9,24(sp)
 6e2:	e86a                	sd	s10,16(sp)
        printptr(fd, va_arg(ap, uint64));
 6e4:	f8f40fa3          	sb	a5,-97(s0)
 6e8:	000c3d03          	ld	s10,0(s8)
  write(fd, &c, 1);
 6ec:	00000097          	auipc	ra,0x0
 6f0:	dba080e7          	jalr	-582(ra) # 4a6 <write>
 6f4:	07800793          	li	a5,120
 6f8:	4605                	li	a2,1
 6fa:	85ce                	mv	a1,s3
 6fc:	8552                	mv	a0,s4
 6fe:	f8f40fa3          	sb	a5,-97(s0)
        printptr(fd, va_arg(ap, uint64));
 702:	0c21                	add	s8,s8,8
  write(fd, &c, 1);
 704:	00000097          	auipc	ra,0x0
 708:	da2080e7          	jalr	-606(ra) # 4a6 <write>
  putc(fd, 'x');
 70c:	4941                	li	s2,16
 70e:	00000c97          	auipc	s9,0x0
 712:	34ac8c93          	add	s9,s9,842 # a58 <digits>
    putc(fd, digits[x >> (sizeof(uint64) * 8 - 4)]);
 716:	03cd5793          	srl	a5,s10,0x3c
 71a:	97e6                	add	a5,a5,s9
 71c:	0007c783          	lbu	a5,0(a5)
  write(fd, &c, 1);
 720:	4605                	li	a2,1
 722:	85ce                	mv	a1,s3
 724:	8552                	mv	a0,s4
  for (i = 0; i < (sizeof(uint64) * 2); i++, x <<= 4)
 726:	397d                	addw	s2,s2,-1
 728:	f8f40fa3          	sb	a5,-97(s0)
 72c:	0d12                	sll	s10,s10,0x4
  write(fd, &c, 1);
 72e:	00000097          	auipc	ra,0x0
 732:	d78080e7          	jalr	-648(ra) # 4a6 <write>
  for (i = 0; i < (sizeof(uint64) * 2); i++, x <<= 4)
 736:	fe0910e3          	bnez	s2,716 <vprintf+0x14c>
 73a:	6ce2                	ld	s9,24(sp)
 73c:	6d42                	ld	s10,16(sp)
 73e:	4981                	li	s3,0
 740:	bdf9                	j	61e <vprintf+0x54>
        s = va_arg(ap, char*);
 742:	000c3903          	ld	s2,0(s8)
 746:	0c21                	add	s8,s8,8
        if(s == 0)
 748:	04090e63          	beqz	s2,7a4 <vprintf+0x1da>
        while(*s != 0){
 74c:	00094783          	lbu	a5,0(s2)
 750:	d3a1                	beqz	a5,690 <vprintf+0xc6>
 752:	f9f40993          	add	s3,s0,-97
  write(fd, &c, 1);
 756:	4605                	li	a2,1
 758:	85ce                	mv	a1,s3
 75a:	8552                	mv	a0,s4
 75c:	f8f40fa3          	sb	a5,-97(s0)
 760:	00000097          	auipc	ra,0x0
 764:	d46080e7          	jalr	-698(ra) # 4a6 <write>
        while(*s != 0){
 768:	00194783          	lbu	a5,1(s2)
          s++;
 76c:	0905                	add	s2,s2,1
        while(*s != 0){
 76e:	f7e5                	bnez	a5,756 <vprintf+0x18c>
 770:	4981                	li	s3,0
 772:	b575                	j	61e <vprintf+0x54>
        printint(fd, va_arg(ap, int), 16, 0);
 774:	000c2583          	lw	a1,0(s8)
 778:	4681                	li	a3,0
 77a:	4641                	li	a2,16
 77c:	8552                	mv	a0,s4
 77e:	0c21                	add	s8,s8,8
 780:	00000097          	auipc	ra,0x0
 784:	dae080e7          	jalr	-594(ra) # 52e <printint>
 788:	4981                	li	s3,0
 78a:	bd51                	j	61e <vprintf+0x54>
  write(fd, &c, 1);
 78c:	4605                	li	a2,1
 78e:	f9f40593          	add	a1,s0,-97
 792:	8552                	mv	a0,s4
 794:	f9540fa3          	sb	s5,-97(s0)
        while(*s != 0){
 798:	4981                	li	s3,0
  write(fd, &c, 1);
 79a:	00000097          	auipc	ra,0x0
 79e:	d0c080e7          	jalr	-756(ra) # 4a6 <write>
 7a2:	bdb5                	j	61e <vprintf+0x54>
          s = "(null)";
 7a4:	00000917          	auipc	s2,0x0
 7a8:	25490913          	add	s2,s2,596 # 9f8 <malloc+0x148>
 7ac:	02800793          	li	a5,40
 7b0:	b74d                	j	752 <vprintf+0x188>

00000000000007b2 <fprintf>:

void
fprintf(int fd, const char *fmt, ...)
{
 7b2:	715d                	add	sp,sp,-80
 7b4:	e822                	sd	s0,16(sp)
 7b6:	ec06                	sd	ra,24(sp)
 7b8:	1000                	add	s0,sp,32
 7ba:	e010                	sd	a2,0(s0)
  va_list ap;

  va_start(ap, fmt);
  vprintf(fd, fmt, ap);
 7bc:	8622                	mv	a2,s0
{
 7be:	e414                	sd	a3,8(s0)
 7c0:	e818                	sd	a4,16(s0)
 7c2:	ec1c                	sd	a5,24(s0)
 7c4:	03043023          	sd	a6,32(s0)
 7c8:	03143423          	sd	a7,40(s0)
  va_start(ap, fmt);
 7cc:	fe843423          	sd	s0,-24(s0)
  vprintf(fd, fmt, ap);
 7d0:	00000097          	auipc	ra,0x0
 7d4:	dfa080e7          	jalr	-518(ra) # 5ca <vprintf>
}
 7d8:	60e2                	ld	ra,24(sp)
 7da:	6442                	ld	s0,16(sp)
 7dc:	6161                	add	sp,sp,80
 7de:	8082                	ret

00000000000007e0 <printf>:

void
printf(const char *fmt, ...)
{
 7e0:	711d                	add	sp,sp,-96
 7e2:	e822                	sd	s0,16(sp)
 7e4:	ec06                	sd	ra,24(sp)
 7e6:	1000                	add	s0,sp,32
  va_list ap;

  va_start(ap, fmt);
 7e8:	00840313          	add	t1,s0,8
{
 7ec:	e40c                	sd	a1,8(s0)
 7ee:	e810                	sd	a2,16(s0)
  vprintf(1, fmt, ap);
 7f0:	85aa                	mv	a1,a0
 7f2:	861a                	mv	a2,t1
 7f4:	4505                	li	a0,1
{
 7f6:	ec14                	sd	a3,24(s0)
 7f8:	f018                	sd	a4,32(s0)
 7fa:	f41c                	sd	a5,40(s0)
 7fc:	03043823          	sd	a6,48(s0)
 800:	03143c23          	sd	a7,56(s0)
  va_start(ap, fmt);
 804:	fe643423          	sd	t1,-24(s0)
  vprintf(1, fmt, ap);
 808:	00000097          	auipc	ra,0x0
 80c:	dc2080e7          	jalr	-574(ra) # 5ca <vprintf>
}
 810:	60e2                	ld	ra,24(sp)
 812:	6442                	ld	s0,16(sp)
 814:	6125                	add	sp,sp,96
 816:	8082                	ret

0000000000000818 <free>:
static Header base;
static Header *freep;

void
free(void *ap)
{
 818:	1141                	add	sp,sp,-16
 81a:	e422                	sd	s0,8(sp)
 81c:	0800                	add	s0,sp,16
  Header *bp, *p;

  bp = (Header*)ap - 1;
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 81e:	00000597          	auipc	a1,0x0
 822:	7e258593          	add	a1,a1,2018 # 1000 <freep>
 826:	619c                	ld	a5,0(a1)
  bp = (Header*)ap - 1;
 828:	ff050693          	add	a3,a0,-16
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 82c:	6398                	ld	a4,0(a5)
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 82e:	02d7ff63          	bgeu	a5,a3,86c <free+0x54>
 832:	00e6e463          	bltu	a3,a4,83a <free+0x22>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 836:	02e7ef63          	bltu	a5,a4,874 <free+0x5c>
      break;
  if(bp + bp->s.size == p->s.ptr){
 83a:	ff852803          	lw	a6,-8(a0)
 83e:	02081893          	sll	a7,a6,0x20
 842:	01c8d613          	srl	a2,a7,0x1c
 846:	9636                	add	a2,a2,a3
 848:	02c70863          	beq	a4,a2,878 <free+0x60>
    bp->s.size += p->s.ptr->s.size;
    bp->s.ptr = p->s.ptr->s.ptr;
  } else
    bp->s.ptr = p->s.ptr;
  if(p + p->s.size == bp){
 84c:	0087a803          	lw	a6,8(a5)
 850:	fee53823          	sd	a4,-16(a0)
 854:	02081893          	sll	a7,a6,0x20
 858:	01c8d613          	srl	a2,a7,0x1c
 85c:	963e                	add	a2,a2,a5
 85e:	02c68e63          	beq	a3,a2,89a <free+0x82>
    p->s.size += bp->s.size;
    p->s.ptr = bp->s.ptr;
  } else
    p->s.ptr = bp;
  freep = p;
}
 862:	6422                	ld	s0,8(sp)
 864:	e394                	sd	a3,0(a5)
  freep = p;
 866:	e19c                	sd	a5,0(a1)
}
 868:	0141                	add	sp,sp,16
 86a:	8082                	ret
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 86c:	00e7e463          	bltu	a5,a4,874 <free+0x5c>
 870:	fce6e5e3          	bltu	a3,a4,83a <free+0x22>
{
 874:	87ba                	mv	a5,a4
 876:	bf5d                	j	82c <free+0x14>
    bp->s.size += p->s.ptr->s.size;
 878:	4710                	lw	a2,8(a4)
    bp->s.ptr = p->s.ptr->s.ptr;
 87a:	6318                	ld	a4,0(a4)
    bp->s.size += p->s.ptr->s.size;
 87c:	0106063b          	addw	a2,a2,a6
 880:	fec52c23          	sw	a2,-8(a0)
  if(p + p->s.size == bp){
 884:	0087a803          	lw	a6,8(a5)
 888:	fee53823          	sd	a4,-16(a0)
 88c:	02081893          	sll	a7,a6,0x20
 890:	01c8d613          	srl	a2,a7,0x1c
 894:	963e                	add	a2,a2,a5
 896:	fcc696e3          	bne	a3,a2,862 <free+0x4a>
    p->s.size += bp->s.size;
 89a:	ff852603          	lw	a2,-8(a0)
}
 89e:	6422                	ld	s0,8(sp)
    p->s.ptr = bp->s.ptr;
 8a0:	86ba                	mv	a3,a4
    p->s.size += bp->s.size;
 8a2:	0106073b          	addw	a4,a2,a6
 8a6:	c798                	sw	a4,8(a5)
    p->s.ptr = bp->s.ptr;
 8a8:	e394                	sd	a3,0(a5)
  freep = p;
 8aa:	e19c                	sd	a5,0(a1)
}
 8ac:	0141                	add	sp,sp,16
 8ae:	8082                	ret

00000000000008b0 <malloc>:
  return freep;
}

void*
malloc(uint nbytes)
{
 8b0:	7139                	add	sp,sp,-64
 8b2:	f822                	sd	s0,48(sp)
 8b4:	f426                	sd	s1,40(sp)
 8b6:	f04a                	sd	s2,32(sp)
 8b8:	ec4e                	sd	s3,24(sp)
 8ba:	fc06                	sd	ra,56(sp)
 8bc:	0080                	add	s0,sp,64
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
  if((prevp = freep) == 0){
 8be:	00000917          	auipc	s2,0x0
 8c2:	74290913          	add	s2,s2,1858 # 1000 <freep>
  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
 8c6:	02051493          	sll	s1,a0,0x20
 8ca:	9081                	srl	s1,s1,0x20
  if((prevp = freep) == 0){
 8cc:	00093783          	ld	a5,0(s2)
  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
 8d0:	04bd                	add	s1,s1,15
 8d2:	8091                	srl	s1,s1,0x4
 8d4:	0014899b          	addw	s3,s1,1
 8d8:	0485                	add	s1,s1,1
  if((prevp = freep) == 0){
 8da:	c3dd                	beqz	a5,980 <malloc+0xd0>
    base.s.ptr = freep = prevp = &base;
    base.s.size = 0;
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 8dc:	6388                	ld	a0,0(a5)
    if(p->s.size >= nunits){
 8de:	4518                	lw	a4,8(a0)
 8e0:	06977863          	bgeu	a4,s1,950 <malloc+0xa0>
 8e4:	e852                	sd	s4,16(sp)
 8e6:	e456                	sd	s5,8(sp)
 8e8:	e05a                	sd	s6,0(sp)
  if(nu < 4096)
 8ea:	6785                	lui	a5,0x1
 8ec:	8a4e                	mv	s4,s3
 8ee:	08f4e763          	bltu	s1,a5,97c <malloc+0xcc>
 8f2:	000a0b1b          	sext.w	s6,s4
  if(p == (char*)-1)
 8f6:	5afd                	li	s5,-1
  p = sbrk(nu * sizeof(Header));
 8f8:	004a1a1b          	sllw	s4,s4,0x4
 8fc:	a029                	j	906 <malloc+0x56>
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 8fe:	6388                	ld	a0,0(a5)
    if(p->s.size >= nunits){
 900:	4518                	lw	a4,8(a0)
 902:	04977463          	bgeu	a4,s1,94a <malloc+0x9a>
        p->s.size = nunits;
      }
      freep = prevp;
      return (void*)(p + 1);
    }
    if(p == freep)
 906:	00093703          	ld	a4,0(s2)
 90a:	87aa                	mv	a5,a0
 90c:	fee519e3          	bne	a0,a4,8fe <malloc+0x4e>
  p = sbrk(nu * sizeof(Header));
 910:	8552                	mv	a0,s4
 912:	00000097          	auipc	ra,0x0
 916:	bfc080e7          	jalr	-1028(ra) # 50e <sbrk>
 91a:	87aa                	mv	a5,a0
  free((void*)(hp + 1));
 91c:	0541                	add	a0,a0,16
  if(p == (char*)-1)
 91e:	01578b63          	beq	a5,s5,934 <malloc+0x84>
  hp->s.size = nu;
 922:	0167a423          	sw	s6,8(a5) # 1008 <freep+0x8>
  free((void*)(hp + 1));
 926:	00000097          	auipc	ra,0x0
 92a:	ef2080e7          	jalr	-270(ra) # 818 <free>
  return freep;
 92e:	00093783          	ld	a5,0(s2)
      if((p = morecore(nunits)) == 0)
 932:	f7f1                	bnez	a5,8fe <malloc+0x4e>
        return 0;
  }
}
 934:	70e2                	ld	ra,56(sp)
 936:	7442                	ld	s0,48(sp)
        return 0;
 938:	6a42                	ld	s4,16(sp)
 93a:	6aa2                	ld	s5,8(sp)
 93c:	6b02                	ld	s6,0(sp)
}
 93e:	74a2                	ld	s1,40(sp)
 940:	7902                	ld	s2,32(sp)
 942:	69e2                	ld	s3,24(sp)
        return 0;
 944:	4501                	li	a0,0
}
 946:	6121                	add	sp,sp,64
 948:	8082                	ret
 94a:	6a42                	ld	s4,16(sp)
 94c:	6aa2                	ld	s5,8(sp)
 94e:	6b02                	ld	s6,0(sp)
      if(p->s.size == nunits)
 950:	04e48763          	beq	s1,a4,99e <malloc+0xee>
        p->s.size -= nunits;
 954:	4137073b          	subw	a4,a4,s3
        p += p->s.size;
 958:	02071613          	sll	a2,a4,0x20
 95c:	01c65693          	srl	a3,a2,0x1c
        p->s.size -= nunits;
 960:	c518                	sw	a4,8(a0)
        p += p->s.size;
 962:	9536                	add	a0,a0,a3
        p->s.size = nunits;
 964:	01352423          	sw	s3,8(a0)
}
 968:	70e2                	ld	ra,56(sp)
 96a:	7442                	ld	s0,48(sp)
      freep = prevp;
 96c:	00f93023          	sd	a5,0(s2)
}
 970:	74a2                	ld	s1,40(sp)
 972:	7902                	ld	s2,32(sp)
 974:	69e2                	ld	s3,24(sp)
      return (void*)(p + 1);
 976:	0541                	add	a0,a0,16
}
 978:	6121                	add	sp,sp,64
 97a:	8082                	ret
  if(nu < 4096)
 97c:	6a05                	lui	s4,0x1
 97e:	bf95                	j	8f2 <malloc+0x42>
 980:	e852                	sd	s4,16(sp)
 982:	e456                	sd	s5,8(sp)
 984:	e05a                	sd	s6,0(sp)
    base.s.ptr = freep = prevp = &base;
 986:	00001517          	auipc	a0,0x1
 98a:	88a50513          	add	a0,a0,-1910 # 1210 <base>
 98e:	00a93023          	sd	a0,0(s2)
 992:	e108                	sd	a0,0(a0)
    base.s.size = 0;
 994:	00001797          	auipc	a5,0x1
 998:	8807a223          	sw	zero,-1916(a5) # 1218 <base+0x8>
    if(p->s.size >= nunits){
 99c:	b7b9                	j	8ea <malloc+0x3a>
        prevp->s.ptr = p->s.ptr;
 99e:	6118                	ld	a4,0(a0)
 9a0:	e398                	sd	a4,0(a5)
 9a2:	b7d9                	j	968 <malloc+0xb8>
