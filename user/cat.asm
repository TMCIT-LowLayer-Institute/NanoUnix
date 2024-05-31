
user/_cat:     file format elf64-littleriscv


Disassembly of section .text:

0000000000000000 <cat>:

char buf[512];

void
cat(int fd)
{
   0:	7179                	add	sp,sp,-48
   2:	f022                	sd	s0,32(sp)
   4:	e84a                	sd	s2,16(sp)
   6:	e44e                	sd	s3,8(sp)
   8:	f406                	sd	ra,40(sp)
   a:	ec26                	sd	s1,24(sp)
   c:	1800                	add	s0,sp,48
   e:	89aa                	mv	s3,a0
  int n = undefined;

  while((n = read(fd, buf, sizeof(buf))) > 0) {
  10:	00001917          	auipc	s2,0x1
  14:	00090913          	mv	s2,s2
  18:	a811                	j	2c <cat+0x2c>
    if (write(1, buf, n) != n) {
  1a:	8626                	mv	a2,s1
  1c:	85ca                	mv	a1,s2
  1e:	4505                	li	a0,1
  20:	00000097          	auipc	ra,0x0
  24:	416080e7          	jalr	1046(ra) # 436 <write>
  28:	02951563          	bne	a0,s1,52 <cat+0x52>
  while((n = read(fd, buf, sizeof(buf))) > 0) {
  2c:	20000613          	li	a2,512
  30:	85ca                	mv	a1,s2
  32:	854e                	mv	a0,s3
  34:	00000097          	auipc	ra,0x0
  38:	3fa080e7          	jalr	1018(ra) # 42e <read>
  3c:	84aa                	mv	s1,a0
  3e:	fca04ee3          	bgtz	a0,1a <cat+0x1a>
      fprintf(2, "cat: write error\n");
      exit(1);
    }
  }
  if(n < 0){
  42:	e515                	bnez	a0,6e <cat+0x6e>
    fprintf(2, "cat: read error\n");
    exit(1);
  }
}
  44:	70a2                	ld	ra,40(sp)
  46:	7402                	ld	s0,32(sp)
  48:	64e2                	ld	s1,24(sp)
  4a:	6942                	ld	s2,16(sp)
  4c:	69a2                	ld	s3,8(sp)
  4e:	6145                	add	sp,sp,48
  50:	8082                	ret
      fprintf(2, "cat: write error\n");
  52:	4509                	li	a0,2
  54:	00001597          	auipc	a1,0x1
  58:	8ec58593          	add	a1,a1,-1812 # 940 <malloc+0x100>
  5c:	00000097          	auipc	ra,0x0
  60:	6e6080e7          	jalr	1766(ra) # 742 <fprintf>
      exit(1);
  64:	4505                	li	a0,1
  66:	00000097          	auipc	ra,0x0
  6a:	3b0080e7          	jalr	944(ra) # 416 <exit>
    fprintf(2, "cat: read error\n");
  6e:	4509                	li	a0,2
  70:	00001597          	auipc	a1,0x1
  74:	8e858593          	add	a1,a1,-1816 # 958 <malloc+0x118>
  78:	00000097          	auipc	ra,0x0
  7c:	6ca080e7          	jalr	1738(ra) # 742 <fprintf>
    exit(1);
  80:	4505                	li	a0,1
  82:	00000097          	auipc	ra,0x0
  86:	394080e7          	jalr	916(ra) # 416 <exit>

000000000000008a <main>:

int
main(int argc, char *argv[])
{
  8a:	7179                	add	sp,sp,-48
  8c:	f022                	sd	s0,32(sp)
  8e:	f406                	sd	ra,40(sp)
  90:	1800                	add	s0,sp,48
  int fd, i;

  if(argc <= 1){
  92:	4785                	li	a5,1
  94:	ec26                	sd	s1,24(sp)
  96:	e84a                	sd	s2,16(sp)
  98:	e44e                	sd	s3,8(sp)
  9a:	06a7d963          	bge	a5,a0,10c <main+0x82>
  9e:	ffe5099b          	addw	s3,a0,-2
  a2:	02099793          	sll	a5,s3,0x20
  a6:	01d7d993          	srl	s3,a5,0x1d
  aa:	01058793          	add	a5,a1,16
  ae:	00858913          	add	s2,a1,8
  b2:	99be                	add	s3,s3,a5
  b4:	a829                	j	ce <main+0x44>
  for(i = 1; i < argc; i++){
    if((fd = open(argv[i], 0)) < 0){
      fprintf(2, "cat: cannot open %s\n", argv[i]);
      exit(1);
    }
    cat(fd);
  b6:	00000097          	auipc	ra,0x0
  ba:	f4a080e7          	jalr	-182(ra) # 0 <cat>
    close(fd);
  be:	8526                	mv	a0,s1
  for(i = 1; i < argc; i++){
  c0:	0921                	add	s2,s2,8 # 1018 <buf+0x8>
    close(fd);
  c2:	00000097          	auipc	ra,0x0
  c6:	37c080e7          	jalr	892(ra) # 43e <close>
  for(i = 1; i < argc; i++){
  ca:	03390c63          	beq	s2,s3,102 <main+0x78>
    if((fd = open(argv[i], 0)) < 0){
  ce:	00093503          	ld	a0,0(s2)
  d2:	4581                	li	a1,0
  d4:	00000097          	auipc	ra,0x0
  d8:	382080e7          	jalr	898(ra) # 456 <open>
  dc:	84aa                	mv	s1,a0
  de:	fc055ce3          	bgez	a0,b6 <main+0x2c>
      fprintf(2, "cat: cannot open %s\n", argv[i]);
  e2:	00093603          	ld	a2,0(s2)
  e6:	4509                	li	a0,2
  e8:	00001597          	auipc	a1,0x1
  ec:	88858593          	add	a1,a1,-1912 # 970 <malloc+0x130>
  f0:	00000097          	auipc	ra,0x0
  f4:	652080e7          	jalr	1618(ra) # 742 <fprintf>
      exit(1);
  f8:	4505                	li	a0,1
  fa:	00000097          	auipc	ra,0x0
  fe:	31c080e7          	jalr	796(ra) # 416 <exit>
  }
  exit(0);
 102:	4501                	li	a0,0
 104:	00000097          	auipc	ra,0x0
 108:	312080e7          	jalr	786(ra) # 416 <exit>
    cat(0);
 10c:	4501                	li	a0,0
 10e:	00000097          	auipc	ra,0x0
 112:	ef2080e7          	jalr	-270(ra) # 0 <cat>
    exit(0);
 116:	4501                	li	a0,0
 118:	00000097          	auipc	ra,0x0
 11c:	2fe080e7          	jalr	766(ra) # 416 <exit>

0000000000000120 <_main>:
//
// wrapper so that it's OK if main() does not call exit().
//
void
_main()
{
 120:	1141                	add	sp,sp,-16
 122:	e022                	sd	s0,0(sp)
 124:	e406                	sd	ra,8(sp)
 126:	0800                	add	s0,sp,16
  extern int main();
  main();
 128:	00000097          	auipc	ra,0x0
 12c:	f62080e7          	jalr	-158(ra) # 8a <main>
  exit(0);
 130:	4501                	li	a0,0
 132:	00000097          	auipc	ra,0x0
 136:	2e4080e7          	jalr	740(ra) # 416 <exit>

000000000000013a <strcpy>:
}

char*
strcpy(char *s, const char *t)
{
 13a:	1141                	add	sp,sp,-16
 13c:	e422                	sd	s0,8(sp)
 13e:	0800                	add	s0,sp,16
  char *os;

  os = s;
  while((*s++ = *t++) != 0)
 140:	87aa                	mv	a5,a0
 142:	0005c703          	lbu	a4,0(a1)
 146:	0785                	add	a5,a5,1
 148:	0585                	add	a1,a1,1
 14a:	fee78fa3          	sb	a4,-1(a5)
 14e:	fb75                	bnez	a4,142 <strcpy+0x8>
    ;
  return os;
}
 150:	6422                	ld	s0,8(sp)
 152:	0141                	add	sp,sp,16
 154:	8082                	ret

0000000000000156 <strcmp>:

int
strcmp(const char *p, const char *q)
{
 156:	1141                	add	sp,sp,-16
 158:	e422                	sd	s0,8(sp)
 15a:	0800                	add	s0,sp,16
  while(*p && *p == *q)
 15c:	00054783          	lbu	a5,0(a0)
 160:	e791                	bnez	a5,16c <strcmp+0x16>
 162:	a80d                	j	194 <strcmp+0x3e>
 164:	00054783          	lbu	a5,0(a0)
 168:	cf99                	beqz	a5,186 <strcmp+0x30>
 16a:	85b6                	mv	a1,a3
 16c:	0005c703          	lbu	a4,0(a1)
    p++, q++;
 170:	0505                	add	a0,a0,1
 172:	00158693          	add	a3,a1,1
  while(*p && *p == *q)
 176:	fef707e3          	beq	a4,a5,164 <strcmp+0xe>
  return (uchar)*p - (uchar)*q;
 17a:	0007851b          	sext.w	a0,a5
}
 17e:	6422                	ld	s0,8(sp)
 180:	9d19                	subw	a0,a0,a4
 182:	0141                	add	sp,sp,16
 184:	8082                	ret
  return (uchar)*p - (uchar)*q;
 186:	0015c703          	lbu	a4,1(a1)
}
 18a:	6422                	ld	s0,8(sp)
  return (uchar)*p - (uchar)*q;
 18c:	4501                	li	a0,0
}
 18e:	9d19                	subw	a0,a0,a4
 190:	0141                	add	sp,sp,16
 192:	8082                	ret
  return (uchar)*p - (uchar)*q;
 194:	0005c703          	lbu	a4,0(a1)
 198:	4501                	li	a0,0
 19a:	b7d5                	j	17e <strcmp+0x28>

000000000000019c <strlen>:

uint
strlen(const char *s)
{
 19c:	1141                	add	sp,sp,-16
 19e:	e422                	sd	s0,8(sp)
 1a0:	0800                	add	s0,sp,16
  int n;

  for(n = 0; s[n]; n++)
 1a2:	00054783          	lbu	a5,0(a0)
 1a6:	cf91                	beqz	a5,1c2 <strlen+0x26>
 1a8:	0505                	add	a0,a0,1
 1aa:	87aa                	mv	a5,a0
 1ac:	0007c703          	lbu	a4,0(a5)
 1b0:	86be                	mv	a3,a5
 1b2:	0785                	add	a5,a5,1
 1b4:	ff65                	bnez	a4,1ac <strlen+0x10>
    ;
  return n;
}
 1b6:	6422                	ld	s0,8(sp)
 1b8:	40a6853b          	subw	a0,a3,a0
 1bc:	2505                	addw	a0,a0,1
 1be:	0141                	add	sp,sp,16
 1c0:	8082                	ret
 1c2:	6422                	ld	s0,8(sp)
  for(n = 0; s[n]; n++)
 1c4:	4501                	li	a0,0
}
 1c6:	0141                	add	sp,sp,16
 1c8:	8082                	ret

00000000000001ca <memset>:

void*
memset(void *dst, int c, uint n)
{
 1ca:	1141                	add	sp,sp,-16
 1cc:	e422                	sd	s0,8(sp)
 1ce:	0800                	add	s0,sp,16
  char *cdst = (char *) dst;
  int i;
  for(i = 0; i < n; i++){
 1d0:	ce09                	beqz	a2,1ea <memset+0x20>
 1d2:	1602                	sll	a2,a2,0x20
 1d4:	9201                	srl	a2,a2,0x20
    cdst[i] = c;
 1d6:	0ff5f593          	zext.b	a1,a1
 1da:	87aa                	mv	a5,a0
 1dc:	00a60733          	add	a4,a2,a0
 1e0:	00b78023          	sb	a1,0(a5)
  for(i = 0; i < n; i++){
 1e4:	0785                	add	a5,a5,1
 1e6:	fee79de3          	bne	a5,a4,1e0 <memset+0x16>
  }
  return dst;
}
 1ea:	6422                	ld	s0,8(sp)
 1ec:	0141                	add	sp,sp,16
 1ee:	8082                	ret

00000000000001f0 <strchr>:

char*
strchr(const char *s, char c)
{
 1f0:	1141                	add	sp,sp,-16
 1f2:	e422                	sd	s0,8(sp)
 1f4:	0800                	add	s0,sp,16
  for(; *s; s++)
 1f6:	00054783          	lbu	a5,0(a0)
 1fa:	c799                	beqz	a5,208 <strchr+0x18>
    if(*s == c)
 1fc:	00f58763          	beq	a1,a5,20a <strchr+0x1a>
  for(; *s; s++)
 200:	00154783          	lbu	a5,1(a0)
 204:	0505                	add	a0,a0,1
 206:	fbfd                	bnez	a5,1fc <strchr+0xc>
      return (char*)s;
  return 0;
 208:	4501                	li	a0,0
}
 20a:	6422                	ld	s0,8(sp)
 20c:	0141                	add	sp,sp,16
 20e:	8082                	ret

0000000000000210 <gets>:

char*
gets(char *buf, int max)
{
 210:	711d                	add	sp,sp,-96
 212:	e8a2                	sd	s0,80(sp)
 214:	e4a6                	sd	s1,72(sp)
 216:	e0ca                	sd	s2,64(sp)
 218:	fc4e                	sd	s3,56(sp)
 21a:	f852                	sd	s4,48(sp)
 21c:	f05a                	sd	s6,32(sp)
 21e:	ec5e                	sd	s7,24(sp)
 220:	ec86                	sd	ra,88(sp)
 222:	f456                	sd	s5,40(sp)
 224:	1080                	add	s0,sp,96
 226:	8baa                	mv	s7,a0
 228:	89ae                	mv	s3,a1
 22a:	892a                	mv	s2,a0
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
 22c:	4481                	li	s1,0
    cc = read(0, &c, 1);
    if(cc < 1)
      break;
    buf[i++] = c;
    if(c == '\n' || c == '\r')
 22e:	4a29                	li	s4,10
 230:	4b35                	li	s6,13
  for(i=0; i+1 < max; ){
 232:	a005                	j	252 <gets+0x42>
    cc = read(0, &c, 1);
 234:	00000097          	auipc	ra,0x0
 238:	1fa080e7          	jalr	506(ra) # 42e <read>
    if(cc < 1)
 23c:	02a05363          	blez	a0,262 <gets+0x52>
    buf[i++] = c;
 240:	faf44783          	lbu	a5,-81(s0)
    if(c == '\n' || c == '\r')
 244:	0905                	add	s2,s2,1
    buf[i++] = c;
 246:	fef90fa3          	sb	a5,-1(s2)
    if(c == '\n' || c == '\r')
 24a:	01478d63          	beq	a5,s4,264 <gets+0x54>
 24e:	01678b63          	beq	a5,s6,264 <gets+0x54>
  for(i=0; i+1 < max; ){
 252:	8aa6                	mv	s5,s1
 254:	2485                	addw	s1,s1,1
    cc = read(0, &c, 1);
 256:	4605                	li	a2,1
 258:	faf40593          	add	a1,s0,-81
 25c:	4501                	li	a0,0
  for(i=0; i+1 < max; ){
 25e:	fd34cbe3          	blt	s1,s3,234 <gets+0x24>
 262:	84d6                	mv	s1,s5
      break;
  }
  buf[i] = '\0';
 264:	94de                	add	s1,s1,s7
 266:	00048023          	sb	zero,0(s1)
  return buf;
}
 26a:	60e6                	ld	ra,88(sp)
 26c:	6446                	ld	s0,80(sp)
 26e:	64a6                	ld	s1,72(sp)
 270:	6906                	ld	s2,64(sp)
 272:	79e2                	ld	s3,56(sp)
 274:	7a42                	ld	s4,48(sp)
 276:	7aa2                	ld	s5,40(sp)
 278:	7b02                	ld	s6,32(sp)
 27a:	855e                	mv	a0,s7
 27c:	6be2                	ld	s7,24(sp)
 27e:	6125                	add	sp,sp,96
 280:	8082                	ret

0000000000000282 <stat>:

int
stat(const char *n, struct stat *st)
{
 282:	1101                	add	sp,sp,-32
 284:	e822                	sd	s0,16(sp)
 286:	e04a                	sd	s2,0(sp)
 288:	ec06                	sd	ra,24(sp)
 28a:	e426                	sd	s1,8(sp)
 28c:	1000                	add	s0,sp,32
 28e:	892e                	mv	s2,a1
  int fd;
  int r;

  fd = open(n, O_RDONLY);
 290:	4581                	li	a1,0
 292:	00000097          	auipc	ra,0x0
 296:	1c4080e7          	jalr	452(ra) # 456 <open>
  if(fd < 0)
 29a:	02054663          	bltz	a0,2c6 <stat+0x44>
    return -1;
  r = fstat(fd, st);
 29e:	85ca                	mv	a1,s2
 2a0:	84aa                	mv	s1,a0
 2a2:	00000097          	auipc	ra,0x0
 2a6:	1cc080e7          	jalr	460(ra) # 46e <fstat>
 2aa:	87aa                	mv	a5,a0
  close(fd);
 2ac:	8526                	mv	a0,s1
  r = fstat(fd, st);
 2ae:	84be                	mv	s1,a5
  close(fd);
 2b0:	00000097          	auipc	ra,0x0
 2b4:	18e080e7          	jalr	398(ra) # 43e <close>
  return r;
}
 2b8:	60e2                	ld	ra,24(sp)
 2ba:	6442                	ld	s0,16(sp)
 2bc:	6902                	ld	s2,0(sp)
 2be:	8526                	mv	a0,s1
 2c0:	64a2                	ld	s1,8(sp)
 2c2:	6105                	add	sp,sp,32
 2c4:	8082                	ret
    return -1;
 2c6:	54fd                	li	s1,-1
 2c8:	bfc5                	j	2b8 <stat+0x36>

00000000000002ca <atoi>:

int
atoi(const char *s)
{
 2ca:	1141                	add	sp,sp,-16
 2cc:	e422                	sd	s0,8(sp)
 2ce:	0800                	add	s0,sp,16
  int n;

  n = 0;
  while('0' <= *s && *s <= '9')
 2d0:	00054683          	lbu	a3,0(a0)
 2d4:	4625                	li	a2,9
 2d6:	fd06879b          	addw	a5,a3,-48
 2da:	0ff7f793          	zext.b	a5,a5
 2de:	02f66863          	bltu	a2,a5,30e <atoi+0x44>
 2e2:	872a                	mv	a4,a0
  n = 0;
 2e4:	4501                	li	a0,0
    n = n*10 + *s++ - '0';
 2e6:	0025179b          	sllw	a5,a0,0x2
 2ea:	9fa9                	addw	a5,a5,a0
 2ec:	0705                	add	a4,a4,1
 2ee:	0017979b          	sllw	a5,a5,0x1
 2f2:	9fb5                	addw	a5,a5,a3
  while('0' <= *s && *s <= '9')
 2f4:	00074683          	lbu	a3,0(a4)
    n = n*10 + *s++ - '0';
 2f8:	fd07851b          	addw	a0,a5,-48
  while('0' <= *s && *s <= '9')
 2fc:	fd06879b          	addw	a5,a3,-48
 300:	0ff7f793          	zext.b	a5,a5
 304:	fef671e3          	bgeu	a2,a5,2e6 <atoi+0x1c>
  return n;
}
 308:	6422                	ld	s0,8(sp)
 30a:	0141                	add	sp,sp,16
 30c:	8082                	ret
 30e:	6422                	ld	s0,8(sp)
  n = 0;
 310:	4501                	li	a0,0
}
 312:	0141                	add	sp,sp,16
 314:	8082                	ret

0000000000000316 <memmove>:

void*
memmove(void *vdst, const void *vsrc, int n)
{
 316:	1141                	add	sp,sp,-16
 318:	e422                	sd	s0,8(sp)
 31a:	0800                	add	s0,sp,16
  char *dst;
  const char *src;

  dst = vdst;
  src = vsrc;
  if (src > dst) {
 31c:	02b57463          	bgeu	a0,a1,344 <memmove+0x2e>
    while(n-- > 0)
 320:	00c05f63          	blez	a2,33e <memmove+0x28>
 324:	1602                	sll	a2,a2,0x20
 326:	9201                	srl	a2,a2,0x20
 328:	00c507b3          	add	a5,a0,a2
  dst = vdst;
 32c:	872a                	mv	a4,a0
      *dst++ = *src++;
 32e:	0005c683          	lbu	a3,0(a1)
 332:	0705                	add	a4,a4,1
 334:	0585                	add	a1,a1,1
 336:	fed70fa3          	sb	a3,-1(a4)
    while(n-- > 0)
 33a:	fef71ae3          	bne	a4,a5,32e <memmove+0x18>
    src += n;
    while(n-- > 0)
      *--dst = *--src;
  }
  return vdst;
}
 33e:	6422                	ld	s0,8(sp)
 340:	0141                	add	sp,sp,16
 342:	8082                	ret
    dst += n;
 344:	00c50733          	add	a4,a0,a2
    src += n;
 348:	95b2                	add	a1,a1,a2
    while(n-- > 0)
 34a:	fec05ae3          	blez	a2,33e <memmove+0x28>
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
 368:	feb79ae3          	bne	a5,a1,35c <memmove+0x46>
}
 36c:	6422                	ld	s0,8(sp)
 36e:	0141                	add	sp,sp,16
 370:	8082                	ret

0000000000000372 <memcmp>:

int
memcmp(const void *s1, const void *s2, uint n)
{
 372:	1141                	add	sp,sp,-16
 374:	e422                	sd	s0,8(sp)
 376:	0800                	add	s0,sp,16
  const char *p1 = s1, *p2 = s2;
  while (n-- > 0) {
 378:	c61d                	beqz	a2,3a6 <memcmp+0x34>
 37a:	fff6069b          	addw	a3,a2,-1
 37e:	1682                	sll	a3,a3,0x20
 380:	9281                	srl	a3,a3,0x20
 382:	0685                	add	a3,a3,1
 384:	96aa                	add	a3,a3,a0
 386:	a019                	j	38c <memcmp+0x1a>
 388:	00a68f63          	beq	a3,a0,3a6 <memcmp+0x34>
    if (*p1 != *p2) {
 38c:	00054783          	lbu	a5,0(a0)
 390:	0005c703          	lbu	a4,0(a1)
      return *p1 - *p2;
    }
    p1++;
 394:	0505                	add	a0,a0,1
    p2++;
 396:	0585                	add	a1,a1,1
    if (*p1 != *p2) {
 398:	fee788e3          	beq	a5,a4,388 <memcmp+0x16>
  }
  return 0;
}
 39c:	6422                	ld	s0,8(sp)
      return *p1 - *p2;
 39e:	40e7853b          	subw	a0,a5,a4
}
 3a2:	0141                	add	sp,sp,16
 3a4:	8082                	ret
 3a6:	6422                	ld	s0,8(sp)
  return 0;
 3a8:	4501                	li	a0,0
}
 3aa:	0141                	add	sp,sp,16
 3ac:	8082                	ret

00000000000003ae <memcpy>:

void *
memcpy(void *dst, const void *src, uint n)
{
 3ae:	1141                	add	sp,sp,-16
 3b0:	e422                	sd	s0,8(sp)
 3b2:	0800                	add	s0,sp,16
  return memmove(dst, src, n);
 3b4:	0006079b          	sext.w	a5,a2
  if (src > dst) {
 3b8:	02b57463          	bgeu	a0,a1,3e0 <memcpy+0x32>
    while(n-- > 0)
 3bc:	00f05f63          	blez	a5,3da <memcpy+0x2c>
 3c0:	1602                	sll	a2,a2,0x20
 3c2:	9201                	srl	a2,a2,0x20
 3c4:	00c587b3          	add	a5,a1,a2
  dst = vdst;
 3c8:	872a                	mv	a4,a0
      *dst++ = *src++;
 3ca:	0005c683          	lbu	a3,0(a1)
 3ce:	0585                	add	a1,a1,1
 3d0:	0705                	add	a4,a4,1
 3d2:	fed70fa3          	sb	a3,-1(a4)
    while(n-- > 0)
 3d6:	fef59ae3          	bne	a1,a5,3ca <memcpy+0x1c>
}
 3da:	6422                	ld	s0,8(sp)
 3dc:	0141                	add	sp,sp,16
 3de:	8082                	ret
    dst += n;
 3e0:	00f50733          	add	a4,a0,a5
    src += n;
 3e4:	95be                	add	a1,a1,a5
    while(n-- > 0)
 3e6:	fef05ae3          	blez	a5,3da <memcpy+0x2c>
 3ea:	fff6079b          	addw	a5,a2,-1
 3ee:	1782                	sll	a5,a5,0x20
 3f0:	9381                	srl	a5,a5,0x20
 3f2:	fff7c793          	not	a5,a5
 3f6:	97ae                	add	a5,a5,a1
      *--dst = *--src;
 3f8:	fff5c683          	lbu	a3,-1(a1)
 3fc:	15fd                	add	a1,a1,-1
 3fe:	177d                	add	a4,a4,-1
 400:	00d70023          	sb	a3,0(a4)
    while(n-- > 0)
 404:	fef59ae3          	bne	a1,a5,3f8 <memcpy+0x4a>
}
 408:	6422                	ld	s0,8(sp)
 40a:	0141                	add	sp,sp,16
 40c:	8082                	ret

000000000000040e <fork>:
# generated by usys.pl - do not edit
#include "kern/syscall.h"
.global fork
fork:
 li a7, SYS_fork
 40e:	4885                	li	a7,1
 ecall
 410:	00000073          	ecall
 ret
 414:	8082                	ret

0000000000000416 <exit>:
.global exit
exit:
 li a7, SYS_exit
 416:	4889                	li	a7,2
 ecall
 418:	00000073          	ecall
 ret
 41c:	8082                	ret

000000000000041e <wait>:
.global wait
wait:
 li a7, SYS_wait
 41e:	488d                	li	a7,3
 ecall
 420:	00000073          	ecall
 ret
 424:	8082                	ret

0000000000000426 <pipe>:
.global pipe
pipe:
 li a7, SYS_pipe
 426:	4891                	li	a7,4
 ecall
 428:	00000073          	ecall
 ret
 42c:	8082                	ret

000000000000042e <read>:
.global read
read:
 li a7, SYS_read
 42e:	4895                	li	a7,5
 ecall
 430:	00000073          	ecall
 ret
 434:	8082                	ret

0000000000000436 <write>:
.global write
write:
 li a7, SYS_write
 436:	48c1                	li	a7,16
 ecall
 438:	00000073          	ecall
 ret
 43c:	8082                	ret

000000000000043e <close>:
.global close
close:
 li a7, SYS_close
 43e:	48d5                	li	a7,21
 ecall
 440:	00000073          	ecall
 ret
 444:	8082                	ret

0000000000000446 <kill>:
.global kill
kill:
 li a7, SYS_kill
 446:	4899                	li	a7,6
 ecall
 448:	00000073          	ecall
 ret
 44c:	8082                	ret

000000000000044e <exec>:
.global exec
exec:
 li a7, SYS_exec
 44e:	489d                	li	a7,7
 ecall
 450:	00000073          	ecall
 ret
 454:	8082                	ret

0000000000000456 <open>:
.global open
open:
 li a7, SYS_open
 456:	48bd                	li	a7,15
 ecall
 458:	00000073          	ecall
 ret
 45c:	8082                	ret

000000000000045e <mknod>:
.global mknod
mknod:
 li a7, SYS_mknod
 45e:	48c5                	li	a7,17
 ecall
 460:	00000073          	ecall
 ret
 464:	8082                	ret

0000000000000466 <unlink>:
.global unlink
unlink:
 li a7, SYS_unlink
 466:	48c9                	li	a7,18
 ecall
 468:	00000073          	ecall
 ret
 46c:	8082                	ret

000000000000046e <fstat>:
.global fstat
fstat:
 li a7, SYS_fstat
 46e:	48a1                	li	a7,8
 ecall
 470:	00000073          	ecall
 ret
 474:	8082                	ret

0000000000000476 <link>:
.global link
link:
 li a7, SYS_link
 476:	48cd                	li	a7,19
 ecall
 478:	00000073          	ecall
 ret
 47c:	8082                	ret

000000000000047e <mkdir>:
.global mkdir
mkdir:
 li a7, SYS_mkdir
 47e:	48d1                	li	a7,20
 ecall
 480:	00000073          	ecall
 ret
 484:	8082                	ret

0000000000000486 <chdir>:
.global chdir
chdir:
 li a7, SYS_chdir
 486:	48a5                	li	a7,9
 ecall
 488:	00000073          	ecall
 ret
 48c:	8082                	ret

000000000000048e <dup>:
.global dup
dup:
 li a7, SYS_dup
 48e:	48a9                	li	a7,10
 ecall
 490:	00000073          	ecall
 ret
 494:	8082                	ret

0000000000000496 <getpid>:
.global getpid
getpid:
 li a7, SYS_getpid
 496:	48ad                	li	a7,11
 ecall
 498:	00000073          	ecall
 ret
 49c:	8082                	ret

000000000000049e <sbrk>:
.global sbrk
sbrk:
 li a7, SYS_sbrk
 49e:	48b1                	li	a7,12
 ecall
 4a0:	00000073          	ecall
 ret
 4a4:	8082                	ret

00000000000004a6 <sleep>:
.global sleep
sleep:
 li a7, SYS_sleep
 4a6:	48b5                	li	a7,13
 ecall
 4a8:	00000073          	ecall
 ret
 4ac:	8082                	ret

00000000000004ae <uptime>:
.global uptime
uptime:
 li a7, SYS_uptime
 4ae:	48b9                	li	a7,14
 ecall
 4b0:	00000073          	ecall
 ret
 4b4:	8082                	ret

00000000000004b6 <poweroff>:
.global poweroff
poweroff:
 li a7, SYS_poweroff
 4b6:	48d9                	li	a7,22
 ecall
 4b8:	00000073          	ecall
 ret
 4bc:	8082                	ret

00000000000004be <printint>:
  write(fd, &c, 1);
}

static void
printint(int fd, int xx, int base, int sgn)
{
 4be:	715d                	add	sp,sp,-80
 4c0:	e0a2                	sd	s0,64(sp)
 4c2:	f84a                	sd	s2,48(sp)
 4c4:	e486                	sd	ra,72(sp)
 4c6:	fc26                	sd	s1,56(sp)
 4c8:	f44e                	sd	s3,40(sp)
 4ca:	0880                	add	s0,sp,80
 4cc:	892a                	mv	s2,a0
  char buf[16];
  int i, neg;
  uint x;

  neg = 0;
  if(sgn && xx < 0){
 4ce:	c299                	beqz	a3,4d4 <printint+0x16>
 4d0:	0805c263          	bltz	a1,554 <printint+0x96>
    neg = 1;
    x = -xx;
  } else {
    x = xx;
 4d4:	2581                	sext.w	a1,a1
  neg = 0;
 4d6:	4681                	li	a3,0
  }

  i = 0;
  do{
    buf[i++] = digits[x % base];
 4d8:	2601                	sext.w	a2,a2
 4da:	fc040713          	add	a4,s0,-64
  i = 0;
 4de:	4501                	li	a0,0
 4e0:	00000897          	auipc	a7,0x0
 4e4:	50888893          	add	a7,a7,1288 # 9e8 <digits>
    buf[i++] = digits[x % base];
 4e8:	02c5f7bb          	remuw	a5,a1,a2
  }while((x /= base) != 0);
 4ec:	0705                	add	a4,a4,1
 4ee:	0005881b          	sext.w	a6,a1
 4f2:	84aa                	mv	s1,a0
    buf[i++] = digits[x % base];
 4f4:	2505                	addw	a0,a0,1
 4f6:	1782                	sll	a5,a5,0x20
 4f8:	9381                	srl	a5,a5,0x20
 4fa:	97c6                	add	a5,a5,a7
 4fc:	0007c783          	lbu	a5,0(a5)
  }while((x /= base) != 0);
 500:	02c5d5bb          	divuw	a1,a1,a2
    buf[i++] = digits[x % base];
 504:	fef70fa3          	sb	a5,-1(a4)
  }while((x /= base) != 0);
 508:	fec870e3          	bgeu	a6,a2,4e8 <printint+0x2a>
  if(neg)
 50c:	ca89                	beqz	a3,51e <printint+0x60>
    buf[i++] = '-';
 50e:	fd050793          	add	a5,a0,-48
 512:	97a2                	add	a5,a5,s0
 514:	02d00713          	li	a4,45
 518:	fee78823          	sb	a4,-16(a5)

  while(--i >= 0)
 51c:	84aa                	mv	s1,a0
 51e:	fc040793          	add	a5,s0,-64
 522:	94be                	add	s1,s1,a5
 524:	fff78993          	add	s3,a5,-1
    putc(fd, buf[i]);
 528:	0004c783          	lbu	a5,0(s1)
  write(fd, &c, 1);
 52c:	4605                	li	a2,1
 52e:	fbf40593          	add	a1,s0,-65
 532:	854a                	mv	a0,s2
  while(--i >= 0)
 534:	14fd                	add	s1,s1,-1
 536:	faf40fa3          	sb	a5,-65(s0)
  write(fd, &c, 1);
 53a:	00000097          	auipc	ra,0x0
 53e:	efc080e7          	jalr	-260(ra) # 436 <write>
  while(--i >= 0)
 542:	ff3493e3          	bne	s1,s3,528 <printint+0x6a>
}
 546:	60a6                	ld	ra,72(sp)
 548:	6406                	ld	s0,64(sp)
 54a:	74e2                	ld	s1,56(sp)
 54c:	7942                	ld	s2,48(sp)
 54e:	79a2                	ld	s3,40(sp)
 550:	6161                	add	sp,sp,80
 552:	8082                	ret
    x = -xx;
 554:	40b005bb          	negw	a1,a1
 558:	b741                	j	4d8 <printint+0x1a>

000000000000055a <vprintf>:
}

// Print to the given fd. Only understands %d, %x, %p, %s.
void
vprintf(int fd, const char *fmt, va_list ap)
{
 55a:	7159                	add	sp,sp,-112
 55c:	f0a2                	sd	s0,96(sp)
 55e:	f486                	sd	ra,104(sp)
 560:	e8ca                	sd	s2,80(sp)
 562:	1880                	add	s0,sp,112
  char *s;
  int c, i, state;

  state = 0;
  for(i = 0; fmt[i]; i++){
 564:	0005c903          	lbu	s2,0(a1)
 568:	04090f63          	beqz	s2,5c6 <vprintf+0x6c>
 56c:	eca6                	sd	s1,88(sp)
 56e:	e4ce                	sd	s3,72(sp)
 570:	e0d2                	sd	s4,64(sp)
 572:	fc56                	sd	s5,56(sp)
 574:	f85a                	sd	s6,48(sp)
 576:	f45e                	sd	s7,40(sp)
 578:	f062                	sd	s8,32(sp)
 57a:	8a2a                	mv	s4,a0
 57c:	8c32                	mv	s8,a2
 57e:	00158493          	add	s1,a1,1
 582:	4981                	li	s3,0
      if(c == '%'){
        state = '%';
      } else {
        putc(fd, c);
      }
    } else if(state == '%'){
 584:	02500a93          	li	s5,37
 588:	4bd5                	li	s7,21
 58a:	00000b17          	auipc	s6,0x0
 58e:	406b0b13          	add	s6,s6,1030 # 990 <malloc+0x150>
    if(state == 0){
 592:	02099f63          	bnez	s3,5d0 <vprintf+0x76>
      if(c == '%'){
 596:	05590c63          	beq	s2,s5,5ee <vprintf+0x94>
  write(fd, &c, 1);
 59a:	4605                	li	a2,1
 59c:	f9f40593          	add	a1,s0,-97
 5a0:	8552                	mv	a0,s4
 5a2:	f9240fa3          	sb	s2,-97(s0)
 5a6:	00000097          	auipc	ra,0x0
 5aa:	e90080e7          	jalr	-368(ra) # 436 <write>
  for(i = 0; fmt[i]; i++){
 5ae:	0004c903          	lbu	s2,0(s1)
 5b2:	0485                	add	s1,s1,1
 5b4:	fc091fe3          	bnez	s2,592 <vprintf+0x38>
 5b8:	64e6                	ld	s1,88(sp)
 5ba:	69a6                	ld	s3,72(sp)
 5bc:	6a06                	ld	s4,64(sp)
 5be:	7ae2                	ld	s5,56(sp)
 5c0:	7b42                	ld	s6,48(sp)
 5c2:	7ba2                	ld	s7,40(sp)
 5c4:	7c02                	ld	s8,32(sp)
        putc(fd, c);
      }
      state = 0;
    }
  }
}
 5c6:	70a6                	ld	ra,104(sp)
 5c8:	7406                	ld	s0,96(sp)
 5ca:	6946                	ld	s2,80(sp)
 5cc:	6165                	add	sp,sp,112
 5ce:	8082                	ret
    } else if(state == '%'){
 5d0:	fd599fe3          	bne	s3,s5,5ae <vprintf+0x54>
      if(c == 'd'){
 5d4:	15590463          	beq	s2,s5,71c <vprintf+0x1c2>
 5d8:	f9d9079b          	addw	a5,s2,-99
 5dc:	0ff7f793          	zext.b	a5,a5
 5e0:	00fbea63          	bltu	s7,a5,5f4 <vprintf+0x9a>
 5e4:	078a                	sll	a5,a5,0x2
 5e6:	97da                	add	a5,a5,s6
 5e8:	439c                	lw	a5,0(a5)
 5ea:	97da                	add	a5,a5,s6
 5ec:	8782                	jr	a5
        state = '%';
 5ee:	02500993          	li	s3,37
 5f2:	bf75                	j	5ae <vprintf+0x54>
  write(fd, &c, 1);
 5f4:	f9f40993          	add	s3,s0,-97
 5f8:	4605                	li	a2,1
 5fa:	85ce                	mv	a1,s3
 5fc:	02500793          	li	a5,37
 600:	8552                	mv	a0,s4
 602:	f8f40fa3          	sb	a5,-97(s0)
 606:	00000097          	auipc	ra,0x0
 60a:	e30080e7          	jalr	-464(ra) # 436 <write>
 60e:	4605                	li	a2,1
 610:	85ce                	mv	a1,s3
 612:	8552                	mv	a0,s4
 614:	f9240fa3          	sb	s2,-97(s0)
 618:	00000097          	auipc	ra,0x0
 61c:	e1e080e7          	jalr	-482(ra) # 436 <write>
        while(*s != 0){
 620:	4981                	li	s3,0
 622:	b771                	j	5ae <vprintf+0x54>
        putc(fd, va_arg(ap, uint));
 624:	000c2783          	lw	a5,0(s8)
  write(fd, &c, 1);
 628:	4605                	li	a2,1
 62a:	f9f40593          	add	a1,s0,-97
 62e:	8552                	mv	a0,s4
        putc(fd, va_arg(ap, uint));
 630:	f8f40fa3          	sb	a5,-97(s0)
 634:	0c21                	add	s8,s8,8
  write(fd, &c, 1);
 636:	00000097          	auipc	ra,0x0
 63a:	e00080e7          	jalr	-512(ra) # 436 <write>
 63e:	4981                	li	s3,0
 640:	b7bd                	j	5ae <vprintf+0x54>
        printint(fd, va_arg(ap, int), 10, 1);
 642:	000c2583          	lw	a1,0(s8)
 646:	4685                	li	a3,1
        printint(fd, va_arg(ap, uint64), 10, 0);
 648:	4629                	li	a2,10
 64a:	8552                	mv	a0,s4
 64c:	0c21                	add	s8,s8,8
 64e:	00000097          	auipc	ra,0x0
 652:	e70080e7          	jalr	-400(ra) # 4be <printint>
 656:	4981                	li	s3,0
 658:	bf99                	j	5ae <vprintf+0x54>
 65a:	000c2583          	lw	a1,0(s8)
 65e:	4681                	li	a3,0
 660:	b7e5                	j	648 <vprintf+0xee>
  write(fd, &c, 1);
 662:	f9f40993          	add	s3,s0,-97
 666:	03000793          	li	a5,48
 66a:	4605                	li	a2,1
 66c:	85ce                	mv	a1,s3
 66e:	8552                	mv	a0,s4
 670:	ec66                	sd	s9,24(sp)
 672:	e86a                	sd	s10,16(sp)
        printptr(fd, va_arg(ap, uint64));
 674:	f8f40fa3          	sb	a5,-97(s0)
 678:	000c3d03          	ld	s10,0(s8)
  write(fd, &c, 1);
 67c:	00000097          	auipc	ra,0x0
 680:	dba080e7          	jalr	-582(ra) # 436 <write>
 684:	07800793          	li	a5,120
 688:	4605                	li	a2,1
 68a:	85ce                	mv	a1,s3
 68c:	8552                	mv	a0,s4
 68e:	f8f40fa3          	sb	a5,-97(s0)
        printptr(fd, va_arg(ap, uint64));
 692:	0c21                	add	s8,s8,8
  write(fd, &c, 1);
 694:	00000097          	auipc	ra,0x0
 698:	da2080e7          	jalr	-606(ra) # 436 <write>
  putc(fd, 'x');
 69c:	4941                	li	s2,16
 69e:	00000c97          	auipc	s9,0x0
 6a2:	34ac8c93          	add	s9,s9,842 # 9e8 <digits>
    putc(fd, digits[x >> (sizeof(uint64) * 8 - 4)]);
 6a6:	03cd5793          	srl	a5,s10,0x3c
 6aa:	97e6                	add	a5,a5,s9
 6ac:	0007c783          	lbu	a5,0(a5)
  write(fd, &c, 1);
 6b0:	4605                	li	a2,1
 6b2:	85ce                	mv	a1,s3
 6b4:	8552                	mv	a0,s4
  for (i = 0; i < (sizeof(uint64) * 2); i++, x <<= 4)
 6b6:	397d                	addw	s2,s2,-1
 6b8:	f8f40fa3          	sb	a5,-97(s0)
 6bc:	0d12                	sll	s10,s10,0x4
  write(fd, &c, 1);
 6be:	00000097          	auipc	ra,0x0
 6c2:	d78080e7          	jalr	-648(ra) # 436 <write>
  for (i = 0; i < (sizeof(uint64) * 2); i++, x <<= 4)
 6c6:	fe0910e3          	bnez	s2,6a6 <vprintf+0x14c>
 6ca:	6ce2                	ld	s9,24(sp)
 6cc:	6d42                	ld	s10,16(sp)
 6ce:	4981                	li	s3,0
 6d0:	bdf9                	j	5ae <vprintf+0x54>
        s = va_arg(ap, char*);
 6d2:	000c3903          	ld	s2,0(s8)
 6d6:	0c21                	add	s8,s8,8
        if(s == 0)
 6d8:	04090e63          	beqz	s2,734 <vprintf+0x1da>
        while(*s != 0){
 6dc:	00094783          	lbu	a5,0(s2)
 6e0:	d3a1                	beqz	a5,620 <vprintf+0xc6>
 6e2:	f9f40993          	add	s3,s0,-97
  write(fd, &c, 1);
 6e6:	4605                	li	a2,1
 6e8:	85ce                	mv	a1,s3
 6ea:	8552                	mv	a0,s4
 6ec:	f8f40fa3          	sb	a5,-97(s0)
 6f0:	00000097          	auipc	ra,0x0
 6f4:	d46080e7          	jalr	-698(ra) # 436 <write>
        while(*s != 0){
 6f8:	00194783          	lbu	a5,1(s2)
          s++;
 6fc:	0905                	add	s2,s2,1
        while(*s != 0){
 6fe:	f7e5                	bnez	a5,6e6 <vprintf+0x18c>
 700:	4981                	li	s3,0
 702:	b575                	j	5ae <vprintf+0x54>
        printint(fd, va_arg(ap, int), 16, 0);
 704:	000c2583          	lw	a1,0(s8)
 708:	4681                	li	a3,0
 70a:	4641                	li	a2,16
 70c:	8552                	mv	a0,s4
 70e:	0c21                	add	s8,s8,8
 710:	00000097          	auipc	ra,0x0
 714:	dae080e7          	jalr	-594(ra) # 4be <printint>
 718:	4981                	li	s3,0
 71a:	bd51                	j	5ae <vprintf+0x54>
  write(fd, &c, 1);
 71c:	4605                	li	a2,1
 71e:	f9f40593          	add	a1,s0,-97
 722:	8552                	mv	a0,s4
 724:	f9540fa3          	sb	s5,-97(s0)
        while(*s != 0){
 728:	4981                	li	s3,0
  write(fd, &c, 1);
 72a:	00000097          	auipc	ra,0x0
 72e:	d0c080e7          	jalr	-756(ra) # 436 <write>
 732:	bdb5                	j	5ae <vprintf+0x54>
          s = "(null)";
 734:	00000917          	auipc	s2,0x0
 738:	25490913          	add	s2,s2,596 # 988 <malloc+0x148>
 73c:	02800793          	li	a5,40
 740:	b74d                	j	6e2 <vprintf+0x188>

0000000000000742 <fprintf>:

void
fprintf(int fd, const char *fmt, ...)
{
 742:	715d                	add	sp,sp,-80
 744:	e822                	sd	s0,16(sp)
 746:	ec06                	sd	ra,24(sp)
 748:	1000                	add	s0,sp,32
 74a:	e010                	sd	a2,0(s0)
  va_list ap;

  va_start(ap, fmt);
  vprintf(fd, fmt, ap);
 74c:	8622                	mv	a2,s0
{
 74e:	e414                	sd	a3,8(s0)
 750:	e818                	sd	a4,16(s0)
 752:	ec1c                	sd	a5,24(s0)
 754:	03043023          	sd	a6,32(s0)
 758:	03143423          	sd	a7,40(s0)
  va_start(ap, fmt);
 75c:	fe843423          	sd	s0,-24(s0)
  vprintf(fd, fmt, ap);
 760:	00000097          	auipc	ra,0x0
 764:	dfa080e7          	jalr	-518(ra) # 55a <vprintf>
}
 768:	60e2                	ld	ra,24(sp)
 76a:	6442                	ld	s0,16(sp)
 76c:	6161                	add	sp,sp,80
 76e:	8082                	ret

0000000000000770 <printf>:

void
printf(const char *fmt, ...)
{
 770:	711d                	add	sp,sp,-96
 772:	e822                	sd	s0,16(sp)
 774:	ec06                	sd	ra,24(sp)
 776:	1000                	add	s0,sp,32
  va_list ap;

  va_start(ap, fmt);
 778:	00840313          	add	t1,s0,8
{
 77c:	e40c                	sd	a1,8(s0)
 77e:	e810                	sd	a2,16(s0)
  vprintf(1, fmt, ap);
 780:	85aa                	mv	a1,a0
 782:	861a                	mv	a2,t1
 784:	4505                	li	a0,1
{
 786:	ec14                	sd	a3,24(s0)
 788:	f018                	sd	a4,32(s0)
 78a:	f41c                	sd	a5,40(s0)
 78c:	03043823          	sd	a6,48(s0)
 790:	03143c23          	sd	a7,56(s0)
  va_start(ap, fmt);
 794:	fe643423          	sd	t1,-24(s0)
  vprintf(1, fmt, ap);
 798:	00000097          	auipc	ra,0x0
 79c:	dc2080e7          	jalr	-574(ra) # 55a <vprintf>
}
 7a0:	60e2                	ld	ra,24(sp)
 7a2:	6442                	ld	s0,16(sp)
 7a4:	6125                	add	sp,sp,96
 7a6:	8082                	ret

00000000000007a8 <free>:
static Header base;
static Header *freep;

void
free(void *ap)
{
 7a8:	1141                	add	sp,sp,-16
 7aa:	e422                	sd	s0,8(sp)
 7ac:	0800                	add	s0,sp,16
  Header *bp, *p;

  bp = (Header*)ap - 1;
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 7ae:	00001597          	auipc	a1,0x1
 7b2:	85258593          	add	a1,a1,-1966 # 1000 <freep>
 7b6:	619c                	ld	a5,0(a1)
  bp = (Header*)ap - 1;
 7b8:	ff050693          	add	a3,a0,-16
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 7bc:	6398                	ld	a4,0(a5)
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 7be:	02d7ff63          	bgeu	a5,a3,7fc <free+0x54>
 7c2:	00e6e463          	bltu	a3,a4,7ca <free+0x22>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 7c6:	02e7ef63          	bltu	a5,a4,804 <free+0x5c>
      break;
  if(bp + bp->s.size == p->s.ptr){
 7ca:	ff852803          	lw	a6,-8(a0)
 7ce:	02081893          	sll	a7,a6,0x20
 7d2:	01c8d613          	srl	a2,a7,0x1c
 7d6:	9636                	add	a2,a2,a3
 7d8:	02c70863          	beq	a4,a2,808 <free+0x60>
    bp->s.size += p->s.ptr->s.size;
    bp->s.ptr = p->s.ptr->s.ptr;
  } else
    bp->s.ptr = p->s.ptr;
  if(p + p->s.size == bp){
 7dc:	0087a803          	lw	a6,8(a5)
 7e0:	fee53823          	sd	a4,-16(a0)
 7e4:	02081893          	sll	a7,a6,0x20
 7e8:	01c8d613          	srl	a2,a7,0x1c
 7ec:	963e                	add	a2,a2,a5
 7ee:	02c68e63          	beq	a3,a2,82a <free+0x82>
    p->s.size += bp->s.size;
    p->s.ptr = bp->s.ptr;
  } else
    p->s.ptr = bp;
  freep = p;
}
 7f2:	6422                	ld	s0,8(sp)
 7f4:	e394                	sd	a3,0(a5)
  freep = p;
 7f6:	e19c                	sd	a5,0(a1)
}
 7f8:	0141                	add	sp,sp,16
 7fa:	8082                	ret
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 7fc:	00e7e463          	bltu	a5,a4,804 <free+0x5c>
 800:	fce6e5e3          	bltu	a3,a4,7ca <free+0x22>
{
 804:	87ba                	mv	a5,a4
 806:	bf5d                	j	7bc <free+0x14>
    bp->s.size += p->s.ptr->s.size;
 808:	4710                	lw	a2,8(a4)
    bp->s.ptr = p->s.ptr->s.ptr;
 80a:	6318                	ld	a4,0(a4)
    bp->s.size += p->s.ptr->s.size;
 80c:	0106063b          	addw	a2,a2,a6
 810:	fec52c23          	sw	a2,-8(a0)
  if(p + p->s.size == bp){
 814:	0087a803          	lw	a6,8(a5)
 818:	fee53823          	sd	a4,-16(a0)
 81c:	02081893          	sll	a7,a6,0x20
 820:	01c8d613          	srl	a2,a7,0x1c
 824:	963e                	add	a2,a2,a5
 826:	fcc696e3          	bne	a3,a2,7f2 <free+0x4a>
    p->s.size += bp->s.size;
 82a:	ff852603          	lw	a2,-8(a0)
}
 82e:	6422                	ld	s0,8(sp)
    p->s.ptr = bp->s.ptr;
 830:	86ba                	mv	a3,a4
    p->s.size += bp->s.size;
 832:	0106073b          	addw	a4,a2,a6
 836:	c798                	sw	a4,8(a5)
    p->s.ptr = bp->s.ptr;
 838:	e394                	sd	a3,0(a5)
  freep = p;
 83a:	e19c                	sd	a5,0(a1)
}
 83c:	0141                	add	sp,sp,16
 83e:	8082                	ret

0000000000000840 <malloc>:
  return freep;
}

void*
malloc(uint nbytes)
{
 840:	7139                	add	sp,sp,-64
 842:	f822                	sd	s0,48(sp)
 844:	f426                	sd	s1,40(sp)
 846:	f04a                	sd	s2,32(sp)
 848:	ec4e                	sd	s3,24(sp)
 84a:	fc06                	sd	ra,56(sp)
 84c:	0080                	add	s0,sp,64
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
  if((prevp = freep) == 0){
 84e:	00000917          	auipc	s2,0x0
 852:	7b290913          	add	s2,s2,1970 # 1000 <freep>
  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
 856:	02051493          	sll	s1,a0,0x20
 85a:	9081                	srl	s1,s1,0x20
  if((prevp = freep) == 0){
 85c:	00093783          	ld	a5,0(s2)
  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
 860:	04bd                	add	s1,s1,15
 862:	8091                	srl	s1,s1,0x4
 864:	0014899b          	addw	s3,s1,1
 868:	0485                	add	s1,s1,1
  if((prevp = freep) == 0){
 86a:	c3dd                	beqz	a5,910 <malloc+0xd0>
    base.s.ptr = freep = prevp = &base;
    base.s.size = 0;
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 86c:	6388                	ld	a0,0(a5)
    if(p->s.size >= nunits){
 86e:	4518                	lw	a4,8(a0)
 870:	06977863          	bgeu	a4,s1,8e0 <malloc+0xa0>
 874:	e852                	sd	s4,16(sp)
 876:	e456                	sd	s5,8(sp)
 878:	e05a                	sd	s6,0(sp)
  if(nu < 4096)
 87a:	6785                	lui	a5,0x1
 87c:	8a4e                	mv	s4,s3
 87e:	08f4e763          	bltu	s1,a5,90c <malloc+0xcc>
 882:	000a0b1b          	sext.w	s6,s4
  if(p == (char*)-1)
 886:	5afd                	li	s5,-1
  p = sbrk(nu * sizeof(Header));
 888:	004a1a1b          	sllw	s4,s4,0x4
 88c:	a029                	j	896 <malloc+0x56>
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 88e:	6388                	ld	a0,0(a5)
    if(p->s.size >= nunits){
 890:	4518                	lw	a4,8(a0)
 892:	04977463          	bgeu	a4,s1,8da <malloc+0x9a>
        p->s.size = nunits;
      }
      freep = prevp;
      return (void*)(p + 1);
    }
    if(p == freep)
 896:	00093703          	ld	a4,0(s2)
 89a:	87aa                	mv	a5,a0
 89c:	fee519e3          	bne	a0,a4,88e <malloc+0x4e>
  p = sbrk(nu * sizeof(Header));
 8a0:	8552                	mv	a0,s4
 8a2:	00000097          	auipc	ra,0x0
 8a6:	bfc080e7          	jalr	-1028(ra) # 49e <sbrk>
 8aa:	87aa                	mv	a5,a0
  free((void*)(hp + 1));
 8ac:	0541                	add	a0,a0,16
  if(p == (char*)-1)
 8ae:	01578b63          	beq	a5,s5,8c4 <malloc+0x84>
  hp->s.size = nu;
 8b2:	0167a423          	sw	s6,8(a5) # 1008 <freep+0x8>
  free((void*)(hp + 1));
 8b6:	00000097          	auipc	ra,0x0
 8ba:	ef2080e7          	jalr	-270(ra) # 7a8 <free>
  return freep;
 8be:	00093783          	ld	a5,0(s2)
      if((p = morecore(nunits)) == 0)
 8c2:	f7f1                	bnez	a5,88e <malloc+0x4e>
        return 0;
  }
}
 8c4:	70e2                	ld	ra,56(sp)
 8c6:	7442                	ld	s0,48(sp)
        return 0;
 8c8:	6a42                	ld	s4,16(sp)
 8ca:	6aa2                	ld	s5,8(sp)
 8cc:	6b02                	ld	s6,0(sp)
}
 8ce:	74a2                	ld	s1,40(sp)
 8d0:	7902                	ld	s2,32(sp)
 8d2:	69e2                	ld	s3,24(sp)
        return 0;
 8d4:	4501                	li	a0,0
}
 8d6:	6121                	add	sp,sp,64
 8d8:	8082                	ret
 8da:	6a42                	ld	s4,16(sp)
 8dc:	6aa2                	ld	s5,8(sp)
 8de:	6b02                	ld	s6,0(sp)
      if(p->s.size == nunits)
 8e0:	04e48763          	beq	s1,a4,92e <malloc+0xee>
        p->s.size -= nunits;
 8e4:	4137073b          	subw	a4,a4,s3
        p += p->s.size;
 8e8:	02071613          	sll	a2,a4,0x20
 8ec:	01c65693          	srl	a3,a2,0x1c
        p->s.size -= nunits;
 8f0:	c518                	sw	a4,8(a0)
        p += p->s.size;
 8f2:	9536                	add	a0,a0,a3
        p->s.size = nunits;
 8f4:	01352423          	sw	s3,8(a0)
}
 8f8:	70e2                	ld	ra,56(sp)
 8fa:	7442                	ld	s0,48(sp)
      freep = prevp;
 8fc:	00f93023          	sd	a5,0(s2)
}
 900:	74a2                	ld	s1,40(sp)
 902:	7902                	ld	s2,32(sp)
 904:	69e2                	ld	s3,24(sp)
      return (void*)(p + 1);
 906:	0541                	add	a0,a0,16
}
 908:	6121                	add	sp,sp,64
 90a:	8082                	ret
  if(nu < 4096)
 90c:	6a05                	lui	s4,0x1
 90e:	bf95                	j	882 <malloc+0x42>
 910:	e852                	sd	s4,16(sp)
 912:	e456                	sd	s5,8(sp)
 914:	e05a                	sd	s6,0(sp)
    base.s.ptr = freep = prevp = &base;
 916:	00001517          	auipc	a0,0x1
 91a:	8fa50513          	add	a0,a0,-1798 # 1210 <base>
 91e:	00a93023          	sd	a0,0(s2)
 922:	e108                	sd	a0,0(a0)
    base.s.size = 0;
 924:	00001797          	auipc	a5,0x1
 928:	8e07aa23          	sw	zero,-1804(a5) # 1218 <base+0x8>
    if(p->s.size >= nunits){
 92c:	b7b9                	j	87a <malloc+0x3a>
        prevp->s.ptr = p->s.ptr;
 92e:	6118                	ld	a4,0(a0)
 930:	e398                	sd	a4,0(a5)
 932:	b7d9                	j	8f8 <malloc+0xb8>
