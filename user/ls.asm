
user/_ls:     file format elf64-littleriscv


Disassembly of section .text:

0000000000000000 <fmtname>:

#include <C/string.h>

char*
fmtname(char *path)
{
   0:	1101                	add	sp,sp,-32
   2:	e822                	sd	s0,16(sp)
   4:	e426                	sd	s1,8(sp)
   6:	e04a                	sd	s2,0(sp)
   8:	ec06                	sd	ra,24(sp)
   a:	1000                	add	s0,sp,32
   c:	892a                	mv	s2,a0
  static char buf[DIRSIZ+1];
  char *p;

  // Find first character after last slash.
  for(p=path+strlen(path); p >= path && *p != '/'; p--)
   e:	00000097          	auipc	ra,0x0
  12:	354080e7          	jalr	852(ra) # 362 <strlen>
  16:	00a904b3          	add	s1,s2,a0
  1a:	02f00693          	li	a3,47
  1e:	0124f663          	bgeu	s1,s2,2a <fmtname+0x2a>
  22:	a811                	j	36 <fmtname+0x36>
  24:	0127ea63          	bltu	a5,s2,38 <fmtname+0x38>
  28:	84be                	mv	s1,a5
  2a:	0004c703          	lbu	a4,0(s1)
  2e:	fff48793          	add	a5,s1,-1
  32:	fed719e3          	bne	a4,a3,24 <fmtname+0x24>
    ;
  p++;
  36:	0485                	add	s1,s1,1

  // Return blank-padded name.
  if(strlen(p) >= DIRSIZ)
  38:	8526                	mv	a0,s1
  3a:	00000097          	auipc	ra,0x0
  3e:	328080e7          	jalr	808(ra) # 362 <strlen>
  42:	47b5                	li	a5,13
  44:	04a7e963          	bltu	a5,a0,96 <fmtname+0x96>
    return p;
  memmove(buf, p, strlen(p));
  48:	8526                	mv	a0,s1
  4a:	00000097          	auipc	ra,0x0
  4e:	318080e7          	jalr	792(ra) # 362 <strlen>
  52:	00001917          	auipc	s2,0x1
  56:	fbe90913          	add	s2,s2,-66 # 1010 <buf.0>
  5a:	862a                	mv	a2,a0
  5c:	85a6                	mv	a1,s1
  5e:	854a                	mv	a0,s2
  60:	00000097          	auipc	ra,0x0
  64:	47c080e7          	jalr	1148(ra) # 4dc <memmove>
  memset(buf+strlen(p), ' ', DIRSIZ-strlen(p));
  68:	8526                	mv	a0,s1
  6a:	00000097          	auipc	ra,0x0
  6e:	2f8080e7          	jalr	760(ra) # 362 <strlen>
  72:	87aa                	mv	a5,a0
  74:	8526                	mv	a0,s1
  76:	84be                	mv	s1,a5
  78:	00000097          	auipc	ra,0x0
  7c:	2ea080e7          	jalr	746(ra) # 362 <strlen>
  80:	4639                	li	a2,14
  82:	8e09                	sub	a2,a2,a0
  84:	02000593          	li	a1,32
  88:	00990533          	add	a0,s2,s1
  8c:	00000097          	auipc	ra,0x0
  90:	304080e7          	jalr	772(ra) # 390 <memset>
  return buf;
  94:	84ca                	mv	s1,s2
}
  96:	60e2                	ld	ra,24(sp)
  98:	6442                	ld	s0,16(sp)
  9a:	6902                	ld	s2,0(sp)
  9c:	8526                	mv	a0,s1
  9e:	64a2                	ld	s1,8(sp)
  a0:	6105                	add	sp,sp,32
  a2:	8082                	ret

00000000000000a4 <ls>:

void
ls(char *path)
{
  a4:	d9010113          	add	sp,sp,-624
  a8:	26813023          	sd	s0,608(sp)
  ac:	25213823          	sd	s2,592(sp)
  b0:	26113423          	sd	ra,616(sp)
  b4:	1c80                	add	s0,sp,624
  char buf[512], *p;
  int fd;
  struct dirent de;
  struct stat st;

  if((fd = open(path, 0)) < 0){
  b6:	4581                	li	a1,0
{
  b8:	892a                	mv	s2,a0
  if((fd = open(path, 0)) < 0){
  ba:	00000097          	auipc	ra,0x0
  be:	562080e7          	jalr	1378(ra) # 61c <open>
  c2:	14054163          	bltz	a0,204 <ls+0x160>
    fprintf(2, "ls: cannot open %s\n", path);
    return;
  }

  if(fstat(fd, &st) < 0){
  c6:	da840593          	add	a1,s0,-600
  ca:	24913c23          	sd	s1,600(sp)
  ce:	84aa                	mv	s1,a0
  d0:	00000097          	auipc	ra,0x0
  d4:	564080e7          	jalr	1380(ra) # 634 <fstat>
  d8:	16054163          	bltz	a0,23a <ls+0x196>
    fprintf(2, "ls: cannot stat %s\n", path);
    close(fd);
    return;
  }

  switch(st.type){
  dc:	db041783          	lh	a5,-592(s0)
  e0:	4705                	li	a4,1
  e2:	04e78b63          	beq	a5,a4,138 <ls+0x94>
  e6:	37f9                	addw	a5,a5,-2
  e8:	17c2                	sll	a5,a5,0x30
  ea:	93c1                	srl	a5,a5,0x30
  ec:	02f76663          	bltu	a4,a5,118 <ls+0x74>
  case T_DEVICE:
  case T_FILE:
    printf("%s %d %d %l\n", fmtname(path), st.type, st.ino, st.size);
  f0:	854a                	mv	a0,s2
  f2:	00000097          	auipc	ra,0x0
  f6:	f0e080e7          	jalr	-242(ra) # 0 <fmtname>
  fa:	db843703          	ld	a4,-584(s0)
  fe:	dac42683          	lw	a3,-596(s0)
 102:	db041603          	lh	a2,-592(s0)
 106:	85aa                	mv	a1,a0
 108:	00001517          	auipc	a0,0x1
 10c:	a2850513          	add	a0,a0,-1496 # b30 <malloc+0x12a>
 110:	00001097          	auipc	ra,0x1
 114:	826080e7          	jalr	-2010(ra) # 936 <printf>
      }
      printf("%s %d %d %d\n", fmtname(buf), st.type, st.ino, st.size);
    }
    break;
  }
  close(fd);
 118:	8526                	mv	a0,s1
 11a:	00000097          	auipc	ra,0x0
 11e:	4ea080e7          	jalr	1258(ra) # 604 <close>
}
 122:	26813083          	ld	ra,616(sp)
 126:	26013403          	ld	s0,608(sp)
 12a:	25813483          	ld	s1,600(sp)
 12e:	25013903          	ld	s2,592(sp)
 132:	27010113          	add	sp,sp,624
 136:	8082                	ret
    if(strlen(path) + 1 + DIRSIZ + 1 > sizeof buf){
 138:	854a                	mv	a0,s2
 13a:	00000097          	auipc	ra,0x0
 13e:	228080e7          	jalr	552(ra) # 362 <strlen>
 142:	0541                	add	a0,a0,16
 144:	20000793          	li	a5,512
 148:	0ea7e063          	bltu	a5,a0,228 <ls+0x184>
    strcpy(buf, path);
 14c:	85ca                	mv	a1,s2
 14e:	dc040513          	add	a0,s0,-576
 152:	25313423          	sd	s3,584(sp)
 156:	25413023          	sd	s4,576(sp)
 15a:	23513c23          	sd	s5,568(sp)
 15e:	00000097          	auipc	ra,0x0
 162:	1a2080e7          	jalr	418(ra) # 300 <strcpy>
    p = buf+strlen(buf);
 166:	dc040513          	add	a0,s0,-576
 16a:	00000097          	auipc	ra,0x0
 16e:	1f8080e7          	jalr	504(ra) # 362 <strlen>
 172:	dc040793          	add	a5,s0,-576
 176:	00a789b3          	add	s3,a5,a0
    *p++ = '/';
 17a:	02f00793          	li	a5,47
 17e:	00198913          	add	s2,s3,1
 182:	00f98023          	sb	a5,0(s3)
      printf("%s %d %d %d\n", fmtname(buf), st.type, st.ino, st.size);
 186:	00001a17          	auipc	s4,0x1
 18a:	9d2a0a13          	add	s4,s4,-1582 # b58 <malloc+0x152>
        printf("ls: cannot stat %s\n", buf);
 18e:	00001a97          	auipc	s5,0x1
 192:	98aa8a93          	add	s5,s5,-1654 # b18 <malloc+0x112>
    while(read(fd, &de, sizeof(de)) == sizeof(de)){
 196:	4641                	li	a2,16
 198:	d9840593          	add	a1,s0,-616
 19c:	8526                	mv	a0,s1
 19e:	00000097          	auipc	ra,0x0
 1a2:	456080e7          	jalr	1110(ra) # 5f4 <read>
 1a6:	872a                	mv	a4,a0
 1a8:	47c1                	li	a5,16
      memmove(p, de.name, DIRSIZ);
 1aa:	4639                	li	a2,14
 1ac:	d9a40593          	add	a1,s0,-614
 1b0:	854a                	mv	a0,s2
    while(read(fd, &de, sizeof(de)) == sizeof(de)){
 1b2:	0cf71563          	bne	a4,a5,27c <ls+0x1d8>
      if(de.inum == 0)
 1b6:	d9845783          	lhu	a5,-616(s0)
 1ba:	dff1                	beqz	a5,196 <ls+0xf2>
      memmove(p, de.name, DIRSIZ);
 1bc:	00000097          	auipc	ra,0x0
 1c0:	320080e7          	jalr	800(ra) # 4dc <memmove>
      if(stat(buf, &st) < 0){
 1c4:	da840593          	add	a1,s0,-600
 1c8:	dc040513          	add	a0,s0,-576
      p[DIRSIZ] = 0;
 1cc:	000987a3          	sb	zero,15(s3)
      if(stat(buf, &st) < 0){
 1d0:	00000097          	auipc	ra,0x0
 1d4:	278080e7          	jalr	632(ra) # 448 <stat>
 1d8:	87aa                	mv	a5,a0
      printf("%s %d %d %d\n", fmtname(buf), st.type, st.ino, st.size);
 1da:	dc040513          	add	a0,s0,-576
      if(stat(buf, &st) < 0){
 1de:	0807c863          	bltz	a5,26e <ls+0x1ca>
      printf("%s %d %d %d\n", fmtname(buf), st.type, st.ino, st.size);
 1e2:	00000097          	auipc	ra,0x0
 1e6:	e1e080e7          	jalr	-482(ra) # 0 <fmtname>
 1ea:	db843703          	ld	a4,-584(s0)
 1ee:	dac42683          	lw	a3,-596(s0)
 1f2:	db041603          	lh	a2,-592(s0)
 1f6:	85aa                	mv	a1,a0
 1f8:	8552                	mv	a0,s4
 1fa:	00000097          	auipc	ra,0x0
 1fe:	73c080e7          	jalr	1852(ra) # 936 <printf>
 202:	bf51                	j	196 <ls+0xf2>
}
 204:	26013403          	ld	s0,608(sp)
 208:	26813083          	ld	ra,616(sp)
    fprintf(2, "ls: cannot open %s\n", path);
 20c:	864a                	mv	a2,s2
}
 20e:	25013903          	ld	s2,592(sp)
    fprintf(2, "ls: cannot open %s\n", path);
 212:	00001597          	auipc	a1,0x1
 216:	8ee58593          	add	a1,a1,-1810 # b00 <malloc+0xfa>
 21a:	4509                	li	a0,2
}
 21c:	27010113          	add	sp,sp,624
    fprintf(2, "ls: cannot open %s\n", path);
 220:	00000317          	auipc	t1,0x0
 224:	6e830067          	jr	1768(t1) # 908 <fprintf>
      printf("ls: path too long\n");
 228:	00001517          	auipc	a0,0x1
 22c:	91850513          	add	a0,a0,-1768 # b40 <malloc+0x13a>
 230:	00000097          	auipc	ra,0x0
 234:	706080e7          	jalr	1798(ra) # 936 <printf>
      break;
 238:	b5c5                	j	118 <ls+0x74>
    fprintf(2, "ls: cannot stat %s\n", path);
 23a:	864a                	mv	a2,s2
 23c:	00001597          	auipc	a1,0x1
 240:	8dc58593          	add	a1,a1,-1828 # b18 <malloc+0x112>
 244:	4509                	li	a0,2
 246:	00000097          	auipc	ra,0x0
 24a:	6c2080e7          	jalr	1730(ra) # 908 <fprintf>
    close(fd);
 24e:	8526                	mv	a0,s1
 250:	00000097          	auipc	ra,0x0
 254:	3b4080e7          	jalr	948(ra) # 604 <close>
}
 258:	26813083          	ld	ra,616(sp)
 25c:	26013403          	ld	s0,608(sp)
 260:	25813483          	ld	s1,600(sp)
 264:	25013903          	ld	s2,592(sp)
 268:	27010113          	add	sp,sp,624
 26c:	8082                	ret
        printf("ls: cannot stat %s\n", buf);
 26e:	85aa                	mv	a1,a0
 270:	8556                	mv	a0,s5
 272:	00000097          	auipc	ra,0x0
 276:	6c4080e7          	jalr	1732(ra) # 936 <printf>
        continue;
 27a:	bf31                	j	196 <ls+0xf2>
 27c:	24813983          	ld	s3,584(sp)
 280:	24013a03          	ld	s4,576(sp)
 284:	23813a83          	ld	s5,568(sp)
 288:	bd41                	j	118 <ls+0x74>

000000000000028a <main>:

int
main(int argc, char *argv[])
{
 28a:	1101                	add	sp,sp,-32
 28c:	e822                	sd	s0,16(sp)
 28e:	ec06                	sd	ra,24(sp)
 290:	1000                	add	s0,sp,32
  int i;

  if(argc < 2){
 292:	4785                	li	a5,1
 294:	e426                	sd	s1,8(sp)
 296:	e04a                	sd	s2,0(sp)
 298:	02a7da63          	bge	a5,a0,2cc <main+0x42>
 29c:	ffe5091b          	addw	s2,a0,-2
 2a0:	02091793          	sll	a5,s2,0x20
 2a4:	01d7d913          	srl	s2,a5,0x1d
 2a8:	01058793          	add	a5,a1,16
 2ac:	00858493          	add	s1,a1,8
 2b0:	993e                	add	s2,s2,a5
    ls(".");
    exit(0);
  }
  for(i=1; i<argc; i++)
    ls(argv[i]);
 2b2:	6088                	ld	a0,0(s1)
  for(i=1; i<argc; i++)
 2b4:	04a1                	add	s1,s1,8
    ls(argv[i]);
 2b6:	00000097          	auipc	ra,0x0
 2ba:	dee080e7          	jalr	-530(ra) # a4 <ls>
  for(i=1; i<argc; i++)
 2be:	ff249ae3          	bne	s1,s2,2b2 <main+0x28>
  exit(0);
 2c2:	4501                	li	a0,0
 2c4:	00000097          	auipc	ra,0x0
 2c8:	318080e7          	jalr	792(ra) # 5dc <exit>
    ls(".");
 2cc:	00001517          	auipc	a0,0x1
 2d0:	89c50513          	add	a0,a0,-1892 # b68 <malloc+0x162>
 2d4:	00000097          	auipc	ra,0x0
 2d8:	dd0080e7          	jalr	-560(ra) # a4 <ls>
    exit(0);
 2dc:	4501                	li	a0,0
 2de:	00000097          	auipc	ra,0x0
 2e2:	2fe080e7          	jalr	766(ra) # 5dc <exit>

00000000000002e6 <_main>:
//
// wrapper so that it's OK if main() does not call exit().
//
void
_main()
{
 2e6:	1141                	add	sp,sp,-16
 2e8:	e022                	sd	s0,0(sp)
 2ea:	e406                	sd	ra,8(sp)
 2ec:	0800                	add	s0,sp,16
  extern int main();
  main();
 2ee:	00000097          	auipc	ra,0x0
 2f2:	f9c080e7          	jalr	-100(ra) # 28a <main>
  exit(0);
 2f6:	4501                	li	a0,0
 2f8:	00000097          	auipc	ra,0x0
 2fc:	2e4080e7          	jalr	740(ra) # 5dc <exit>

0000000000000300 <strcpy>:
}

char*
strcpy(char *s, const char *t)
{
 300:	1141                	add	sp,sp,-16
 302:	e422                	sd	s0,8(sp)
 304:	0800                	add	s0,sp,16
  char *os;

  os = s;
  while((*s++ = *t++) != 0)
 306:	87aa                	mv	a5,a0
 308:	0005c703          	lbu	a4,0(a1)
 30c:	0785                	add	a5,a5,1
 30e:	0585                	add	a1,a1,1
 310:	fee78fa3          	sb	a4,-1(a5)
 314:	fb75                	bnez	a4,308 <strcpy+0x8>
    ;
  return os;
}
 316:	6422                	ld	s0,8(sp)
 318:	0141                	add	sp,sp,16
 31a:	8082                	ret

000000000000031c <strcmp>:

int
strcmp(const char *p, const char *q)
{
 31c:	1141                	add	sp,sp,-16
 31e:	e422                	sd	s0,8(sp)
 320:	0800                	add	s0,sp,16
  while(*p && *p == *q)
 322:	00054783          	lbu	a5,0(a0)
 326:	e791                	bnez	a5,332 <strcmp+0x16>
 328:	a80d                	j	35a <strcmp+0x3e>
 32a:	00054783          	lbu	a5,0(a0)
 32e:	cf99                	beqz	a5,34c <strcmp+0x30>
 330:	85b6                	mv	a1,a3
 332:	0005c703          	lbu	a4,0(a1)
    p++, q++;
 336:	0505                	add	a0,a0,1
 338:	00158693          	add	a3,a1,1
  while(*p && *p == *q)
 33c:	fef707e3          	beq	a4,a5,32a <strcmp+0xe>
  return (uchar)*p - (uchar)*q;
 340:	0007851b          	sext.w	a0,a5
}
 344:	6422                	ld	s0,8(sp)
 346:	9d19                	subw	a0,a0,a4
 348:	0141                	add	sp,sp,16
 34a:	8082                	ret
  return (uchar)*p - (uchar)*q;
 34c:	0015c703          	lbu	a4,1(a1)
}
 350:	6422                	ld	s0,8(sp)
  return (uchar)*p - (uchar)*q;
 352:	4501                	li	a0,0
}
 354:	9d19                	subw	a0,a0,a4
 356:	0141                	add	sp,sp,16
 358:	8082                	ret
  return (uchar)*p - (uchar)*q;
 35a:	0005c703          	lbu	a4,0(a1)
 35e:	4501                	li	a0,0
 360:	b7d5                	j	344 <strcmp+0x28>

0000000000000362 <strlen>:

uint
strlen(const char *s)
{
 362:	1141                	add	sp,sp,-16
 364:	e422                	sd	s0,8(sp)
 366:	0800                	add	s0,sp,16
  int n;

  for(n = 0; s[n]; n++)
 368:	00054783          	lbu	a5,0(a0)
 36c:	cf91                	beqz	a5,388 <strlen+0x26>
 36e:	0505                	add	a0,a0,1
 370:	87aa                	mv	a5,a0
 372:	0007c703          	lbu	a4,0(a5)
 376:	86be                	mv	a3,a5
 378:	0785                	add	a5,a5,1
 37a:	ff65                	bnez	a4,372 <strlen+0x10>
    ;
  return n;
}
 37c:	6422                	ld	s0,8(sp)
 37e:	40a6853b          	subw	a0,a3,a0
 382:	2505                	addw	a0,a0,1
 384:	0141                	add	sp,sp,16
 386:	8082                	ret
 388:	6422                	ld	s0,8(sp)
  for(n = 0; s[n]; n++)
 38a:	4501                	li	a0,0
}
 38c:	0141                	add	sp,sp,16
 38e:	8082                	ret

0000000000000390 <memset>:

void*
memset(void *dst, int c, uint n)
{
 390:	1141                	add	sp,sp,-16
 392:	e422                	sd	s0,8(sp)
 394:	0800                	add	s0,sp,16
  char *cdst = (char *) dst;
  int i;
  for(i = 0; i < n; i++){
 396:	ce09                	beqz	a2,3b0 <memset+0x20>
 398:	1602                	sll	a2,a2,0x20
 39a:	9201                	srl	a2,a2,0x20
    cdst[i] = c;
 39c:	0ff5f593          	zext.b	a1,a1
 3a0:	87aa                	mv	a5,a0
 3a2:	00a60733          	add	a4,a2,a0
 3a6:	00b78023          	sb	a1,0(a5)
  for(i = 0; i < n; i++){
 3aa:	0785                	add	a5,a5,1
 3ac:	fee79de3          	bne	a5,a4,3a6 <memset+0x16>
  }
  return dst;
}
 3b0:	6422                	ld	s0,8(sp)
 3b2:	0141                	add	sp,sp,16
 3b4:	8082                	ret

00000000000003b6 <strchr>:

char*
strchr(const char *s, char c)
{
 3b6:	1141                	add	sp,sp,-16
 3b8:	e422                	sd	s0,8(sp)
 3ba:	0800                	add	s0,sp,16
  for(; *s; s++)
 3bc:	00054783          	lbu	a5,0(a0)
 3c0:	c799                	beqz	a5,3ce <strchr+0x18>
    if(*s == c)
 3c2:	00f58763          	beq	a1,a5,3d0 <strchr+0x1a>
  for(; *s; s++)
 3c6:	00154783          	lbu	a5,1(a0)
 3ca:	0505                	add	a0,a0,1
 3cc:	fbfd                	bnez	a5,3c2 <strchr+0xc>
      return (char*)s;
  return 0;
 3ce:	4501                	li	a0,0
}
 3d0:	6422                	ld	s0,8(sp)
 3d2:	0141                	add	sp,sp,16
 3d4:	8082                	ret

00000000000003d6 <gets>:

char*
gets(char *buf, int max)
{
 3d6:	711d                	add	sp,sp,-96
 3d8:	e8a2                	sd	s0,80(sp)
 3da:	e4a6                	sd	s1,72(sp)
 3dc:	e0ca                	sd	s2,64(sp)
 3de:	fc4e                	sd	s3,56(sp)
 3e0:	f852                	sd	s4,48(sp)
 3e2:	f05a                	sd	s6,32(sp)
 3e4:	ec5e                	sd	s7,24(sp)
 3e6:	ec86                	sd	ra,88(sp)
 3e8:	f456                	sd	s5,40(sp)
 3ea:	1080                	add	s0,sp,96
 3ec:	8baa                	mv	s7,a0
 3ee:	89ae                	mv	s3,a1
 3f0:	892a                	mv	s2,a0
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
 3f2:	4481                	li	s1,0
    cc = read(0, &c, 1);
    if(cc < 1)
      break;
    buf[i++] = c;
    if(c == '\n' || c == '\r')
 3f4:	4a29                	li	s4,10
 3f6:	4b35                	li	s6,13
  for(i=0; i+1 < max; ){
 3f8:	a005                	j	418 <gets+0x42>
    cc = read(0, &c, 1);
 3fa:	00000097          	auipc	ra,0x0
 3fe:	1fa080e7          	jalr	506(ra) # 5f4 <read>
    if(cc < 1)
 402:	02a05363          	blez	a0,428 <gets+0x52>
    buf[i++] = c;
 406:	faf44783          	lbu	a5,-81(s0)
    if(c == '\n' || c == '\r')
 40a:	0905                	add	s2,s2,1
    buf[i++] = c;
 40c:	fef90fa3          	sb	a5,-1(s2)
    if(c == '\n' || c == '\r')
 410:	01478d63          	beq	a5,s4,42a <gets+0x54>
 414:	01678b63          	beq	a5,s6,42a <gets+0x54>
  for(i=0; i+1 < max; ){
 418:	8aa6                	mv	s5,s1
 41a:	2485                	addw	s1,s1,1
    cc = read(0, &c, 1);
 41c:	4605                	li	a2,1
 41e:	faf40593          	add	a1,s0,-81
 422:	4501                	li	a0,0
  for(i=0; i+1 < max; ){
 424:	fd34cbe3          	blt	s1,s3,3fa <gets+0x24>
 428:	84d6                	mv	s1,s5
      break;
  }
  buf[i] = '\0';
 42a:	94de                	add	s1,s1,s7
 42c:	00048023          	sb	zero,0(s1)
  return buf;
}
 430:	60e6                	ld	ra,88(sp)
 432:	6446                	ld	s0,80(sp)
 434:	64a6                	ld	s1,72(sp)
 436:	6906                	ld	s2,64(sp)
 438:	79e2                	ld	s3,56(sp)
 43a:	7a42                	ld	s4,48(sp)
 43c:	7aa2                	ld	s5,40(sp)
 43e:	7b02                	ld	s6,32(sp)
 440:	855e                	mv	a0,s7
 442:	6be2                	ld	s7,24(sp)
 444:	6125                	add	sp,sp,96
 446:	8082                	ret

0000000000000448 <stat>:

int
stat(const char *n, struct stat *st)
{
 448:	1101                	add	sp,sp,-32
 44a:	e822                	sd	s0,16(sp)
 44c:	e04a                	sd	s2,0(sp)
 44e:	ec06                	sd	ra,24(sp)
 450:	e426                	sd	s1,8(sp)
 452:	1000                	add	s0,sp,32
 454:	892e                	mv	s2,a1
  int fd;
  int r;

  fd = open(n, O_RDONLY);
 456:	4581                	li	a1,0
 458:	00000097          	auipc	ra,0x0
 45c:	1c4080e7          	jalr	452(ra) # 61c <open>
  if(fd < 0)
 460:	02054663          	bltz	a0,48c <stat+0x44>
    return -1;
  r = fstat(fd, st);
 464:	85ca                	mv	a1,s2
 466:	84aa                	mv	s1,a0
 468:	00000097          	auipc	ra,0x0
 46c:	1cc080e7          	jalr	460(ra) # 634 <fstat>
 470:	87aa                	mv	a5,a0
  close(fd);
 472:	8526                	mv	a0,s1
  r = fstat(fd, st);
 474:	84be                	mv	s1,a5
  close(fd);
 476:	00000097          	auipc	ra,0x0
 47a:	18e080e7          	jalr	398(ra) # 604 <close>
  return r;
}
 47e:	60e2                	ld	ra,24(sp)
 480:	6442                	ld	s0,16(sp)
 482:	6902                	ld	s2,0(sp)
 484:	8526                	mv	a0,s1
 486:	64a2                	ld	s1,8(sp)
 488:	6105                	add	sp,sp,32
 48a:	8082                	ret
    return -1;
 48c:	54fd                	li	s1,-1
 48e:	bfc5                	j	47e <stat+0x36>

0000000000000490 <atoi>:

int
atoi(const char *s)
{
 490:	1141                	add	sp,sp,-16
 492:	e422                	sd	s0,8(sp)
 494:	0800                	add	s0,sp,16
  int n;

  n = 0;
  while('0' <= *s && *s <= '9')
 496:	00054683          	lbu	a3,0(a0)
 49a:	4625                	li	a2,9
 49c:	fd06879b          	addw	a5,a3,-48
 4a0:	0ff7f793          	zext.b	a5,a5
 4a4:	02f66863          	bltu	a2,a5,4d4 <atoi+0x44>
 4a8:	872a                	mv	a4,a0
  n = 0;
 4aa:	4501                	li	a0,0
    n = n*10 + *s++ - '0';
 4ac:	0025179b          	sllw	a5,a0,0x2
 4b0:	9fa9                	addw	a5,a5,a0
 4b2:	0705                	add	a4,a4,1
 4b4:	0017979b          	sllw	a5,a5,0x1
 4b8:	9fb5                	addw	a5,a5,a3
  while('0' <= *s && *s <= '9')
 4ba:	00074683          	lbu	a3,0(a4)
    n = n*10 + *s++ - '0';
 4be:	fd07851b          	addw	a0,a5,-48
  while('0' <= *s && *s <= '9')
 4c2:	fd06879b          	addw	a5,a3,-48
 4c6:	0ff7f793          	zext.b	a5,a5
 4ca:	fef671e3          	bgeu	a2,a5,4ac <atoi+0x1c>
  return n;
}
 4ce:	6422                	ld	s0,8(sp)
 4d0:	0141                	add	sp,sp,16
 4d2:	8082                	ret
 4d4:	6422                	ld	s0,8(sp)
  n = 0;
 4d6:	4501                	li	a0,0
}
 4d8:	0141                	add	sp,sp,16
 4da:	8082                	ret

00000000000004dc <memmove>:

void*
memmove(void *vdst, const void *vsrc, int n)
{
 4dc:	1141                	add	sp,sp,-16
 4de:	e422                	sd	s0,8(sp)
 4e0:	0800                	add	s0,sp,16
  char *dst;
  const char *src;

  dst = vdst;
  src = vsrc;
  if (src > dst) {
 4e2:	02b57463          	bgeu	a0,a1,50a <memmove+0x2e>
    while(n-- > 0)
 4e6:	00c05f63          	blez	a2,504 <memmove+0x28>
 4ea:	1602                	sll	a2,a2,0x20
 4ec:	9201                	srl	a2,a2,0x20
 4ee:	00c507b3          	add	a5,a0,a2
  dst = vdst;
 4f2:	872a                	mv	a4,a0
      *dst++ = *src++;
 4f4:	0005c683          	lbu	a3,0(a1)
 4f8:	0705                	add	a4,a4,1
 4fa:	0585                	add	a1,a1,1
 4fc:	fed70fa3          	sb	a3,-1(a4)
    while(n-- > 0)
 500:	fef71ae3          	bne	a4,a5,4f4 <memmove+0x18>
    src += n;
    while(n-- > 0)
      *--dst = *--src;
  }
  return vdst;
}
 504:	6422                	ld	s0,8(sp)
 506:	0141                	add	sp,sp,16
 508:	8082                	ret
    dst += n;
 50a:	00c50733          	add	a4,a0,a2
    src += n;
 50e:	95b2                	add	a1,a1,a2
    while(n-- > 0)
 510:	fec05ae3          	blez	a2,504 <memmove+0x28>
 514:	fff6079b          	addw	a5,a2,-1
 518:	1782                	sll	a5,a5,0x20
 51a:	9381                	srl	a5,a5,0x20
 51c:	fff7c793          	not	a5,a5
 520:	97ae                	add	a5,a5,a1
      *--dst = *--src;
 522:	fff5c683          	lbu	a3,-1(a1)
 526:	15fd                	add	a1,a1,-1
 528:	177d                	add	a4,a4,-1
 52a:	00d70023          	sb	a3,0(a4)
    while(n-- > 0)
 52e:	feb79ae3          	bne	a5,a1,522 <memmove+0x46>
}
 532:	6422                	ld	s0,8(sp)
 534:	0141                	add	sp,sp,16
 536:	8082                	ret

0000000000000538 <memcmp>:

int
memcmp(const void *s1, const void *s2, uint n)
{
 538:	1141                	add	sp,sp,-16
 53a:	e422                	sd	s0,8(sp)
 53c:	0800                	add	s0,sp,16
  const char *p1 = s1, *p2 = s2;
  while (n-- > 0) {
 53e:	c61d                	beqz	a2,56c <memcmp+0x34>
 540:	fff6069b          	addw	a3,a2,-1
 544:	1682                	sll	a3,a3,0x20
 546:	9281                	srl	a3,a3,0x20
 548:	0685                	add	a3,a3,1
 54a:	96aa                	add	a3,a3,a0
 54c:	a019                	j	552 <memcmp+0x1a>
 54e:	00a68f63          	beq	a3,a0,56c <memcmp+0x34>
    if (*p1 != *p2) {
 552:	00054783          	lbu	a5,0(a0)
 556:	0005c703          	lbu	a4,0(a1)
      return *p1 - *p2;
    }
    p1++;
 55a:	0505                	add	a0,a0,1
    p2++;
 55c:	0585                	add	a1,a1,1
    if (*p1 != *p2) {
 55e:	fee788e3          	beq	a5,a4,54e <memcmp+0x16>
  }
  return 0;
}
 562:	6422                	ld	s0,8(sp)
      return *p1 - *p2;
 564:	40e7853b          	subw	a0,a5,a4
}
 568:	0141                	add	sp,sp,16
 56a:	8082                	ret
 56c:	6422                	ld	s0,8(sp)
  return 0;
 56e:	4501                	li	a0,0
}
 570:	0141                	add	sp,sp,16
 572:	8082                	ret

0000000000000574 <memcpy>:

void *
memcpy(void *dst, const void *src, uint n)
{
 574:	1141                	add	sp,sp,-16
 576:	e422                	sd	s0,8(sp)
 578:	0800                	add	s0,sp,16
  return memmove(dst, src, n);
 57a:	0006079b          	sext.w	a5,a2
  if (src > dst) {
 57e:	02b57463          	bgeu	a0,a1,5a6 <memcpy+0x32>
    while(n-- > 0)
 582:	00f05f63          	blez	a5,5a0 <memcpy+0x2c>
 586:	1602                	sll	a2,a2,0x20
 588:	9201                	srl	a2,a2,0x20
 58a:	00c587b3          	add	a5,a1,a2
  dst = vdst;
 58e:	872a                	mv	a4,a0
      *dst++ = *src++;
 590:	0005c683          	lbu	a3,0(a1)
 594:	0585                	add	a1,a1,1
 596:	0705                	add	a4,a4,1
 598:	fed70fa3          	sb	a3,-1(a4)
    while(n-- > 0)
 59c:	fef59ae3          	bne	a1,a5,590 <memcpy+0x1c>
}
 5a0:	6422                	ld	s0,8(sp)
 5a2:	0141                	add	sp,sp,16
 5a4:	8082                	ret
    dst += n;
 5a6:	00f50733          	add	a4,a0,a5
    src += n;
 5aa:	95be                	add	a1,a1,a5
    while(n-- > 0)
 5ac:	fef05ae3          	blez	a5,5a0 <memcpy+0x2c>
 5b0:	fff6079b          	addw	a5,a2,-1
 5b4:	1782                	sll	a5,a5,0x20
 5b6:	9381                	srl	a5,a5,0x20
 5b8:	fff7c793          	not	a5,a5
 5bc:	97ae                	add	a5,a5,a1
      *--dst = *--src;
 5be:	fff5c683          	lbu	a3,-1(a1)
 5c2:	15fd                	add	a1,a1,-1
 5c4:	177d                	add	a4,a4,-1
 5c6:	00d70023          	sb	a3,0(a4)
    while(n-- > 0)
 5ca:	fef59ae3          	bne	a1,a5,5be <memcpy+0x4a>
}
 5ce:	6422                	ld	s0,8(sp)
 5d0:	0141                	add	sp,sp,16
 5d2:	8082                	ret

00000000000005d4 <fork>:
# generated by usys.pl - do not edit
#include "kern/syscall.h"
.global fork
fork:
 li a7, SYS_fork
 5d4:	4885                	li	a7,1
 ecall
 5d6:	00000073          	ecall
 ret
 5da:	8082                	ret

00000000000005dc <exit>:
.global exit
exit:
 li a7, SYS_exit
 5dc:	4889                	li	a7,2
 ecall
 5de:	00000073          	ecall
 ret
 5e2:	8082                	ret

00000000000005e4 <wait>:
.global wait
wait:
 li a7, SYS_wait
 5e4:	488d                	li	a7,3
 ecall
 5e6:	00000073          	ecall
 ret
 5ea:	8082                	ret

00000000000005ec <pipe>:
.global pipe
pipe:
 li a7, SYS_pipe
 5ec:	4891                	li	a7,4
 ecall
 5ee:	00000073          	ecall
 ret
 5f2:	8082                	ret

00000000000005f4 <read>:
.global read
read:
 li a7, SYS_read
 5f4:	4895                	li	a7,5
 ecall
 5f6:	00000073          	ecall
 ret
 5fa:	8082                	ret

00000000000005fc <write>:
.global write
write:
 li a7, SYS_write
 5fc:	48c1                	li	a7,16
 ecall
 5fe:	00000073          	ecall
 ret
 602:	8082                	ret

0000000000000604 <close>:
.global close
close:
 li a7, SYS_close
 604:	48d5                	li	a7,21
 ecall
 606:	00000073          	ecall
 ret
 60a:	8082                	ret

000000000000060c <kill>:
.global kill
kill:
 li a7, SYS_kill
 60c:	4899                	li	a7,6
 ecall
 60e:	00000073          	ecall
 ret
 612:	8082                	ret

0000000000000614 <exec>:
.global exec
exec:
 li a7, SYS_exec
 614:	489d                	li	a7,7
 ecall
 616:	00000073          	ecall
 ret
 61a:	8082                	ret

000000000000061c <open>:
.global open
open:
 li a7, SYS_open
 61c:	48bd                	li	a7,15
 ecall
 61e:	00000073          	ecall
 ret
 622:	8082                	ret

0000000000000624 <mknod>:
.global mknod
mknod:
 li a7, SYS_mknod
 624:	48c5                	li	a7,17
 ecall
 626:	00000073          	ecall
 ret
 62a:	8082                	ret

000000000000062c <unlink>:
.global unlink
unlink:
 li a7, SYS_unlink
 62c:	48c9                	li	a7,18
 ecall
 62e:	00000073          	ecall
 ret
 632:	8082                	ret

0000000000000634 <fstat>:
.global fstat
fstat:
 li a7, SYS_fstat
 634:	48a1                	li	a7,8
 ecall
 636:	00000073          	ecall
 ret
 63a:	8082                	ret

000000000000063c <link>:
.global link
link:
 li a7, SYS_link
 63c:	48cd                	li	a7,19
 ecall
 63e:	00000073          	ecall
 ret
 642:	8082                	ret

0000000000000644 <mkdir>:
.global mkdir
mkdir:
 li a7, SYS_mkdir
 644:	48d1                	li	a7,20
 ecall
 646:	00000073          	ecall
 ret
 64a:	8082                	ret

000000000000064c <chdir>:
.global chdir
chdir:
 li a7, SYS_chdir
 64c:	48a5                	li	a7,9
 ecall
 64e:	00000073          	ecall
 ret
 652:	8082                	ret

0000000000000654 <dup>:
.global dup
dup:
 li a7, SYS_dup
 654:	48a9                	li	a7,10
 ecall
 656:	00000073          	ecall
 ret
 65a:	8082                	ret

000000000000065c <getpid>:
.global getpid
getpid:
 li a7, SYS_getpid
 65c:	48ad                	li	a7,11
 ecall
 65e:	00000073          	ecall
 ret
 662:	8082                	ret

0000000000000664 <sbrk>:
.global sbrk
sbrk:
 li a7, SYS_sbrk
 664:	48b1                	li	a7,12
 ecall
 666:	00000073          	ecall
 ret
 66a:	8082                	ret

000000000000066c <sleep>:
.global sleep
sleep:
 li a7, SYS_sleep
 66c:	48b5                	li	a7,13
 ecall
 66e:	00000073          	ecall
 ret
 672:	8082                	ret

0000000000000674 <uptime>:
.global uptime
uptime:
 li a7, SYS_uptime
 674:	48b9                	li	a7,14
 ecall
 676:	00000073          	ecall
 ret
 67a:	8082                	ret

000000000000067c <poweroff>:
.global poweroff
poweroff:
 li a7, SYS_poweroff
 67c:	48d9                	li	a7,22
 ecall
 67e:	00000073          	ecall
 ret
 682:	8082                	ret

0000000000000684 <printint>:
  write(fd, &c, 1);
}

static void
printint(int fd, int xx, int base, int sgn)
{
 684:	715d                	add	sp,sp,-80
 686:	e0a2                	sd	s0,64(sp)
 688:	f84a                	sd	s2,48(sp)
 68a:	e486                	sd	ra,72(sp)
 68c:	fc26                	sd	s1,56(sp)
 68e:	f44e                	sd	s3,40(sp)
 690:	0880                	add	s0,sp,80
 692:	892a                	mv	s2,a0
  char buf[16];
  int i, neg;
  uint x;

  neg = 0;
  if(sgn && xx < 0){
 694:	c299                	beqz	a3,69a <printint+0x16>
 696:	0805c263          	bltz	a1,71a <printint+0x96>
    neg = 1;
    x = -xx;
  } else {
    x = xx;
 69a:	2581                	sext.w	a1,a1
  neg = 0;
 69c:	4681                	li	a3,0
  }

  i = 0;
  do{
    buf[i++] = digits[x % base];
 69e:	2601                	sext.w	a2,a2
 6a0:	fc040713          	add	a4,s0,-64
  i = 0;
 6a4:	4501                	li	a0,0
 6a6:	00000897          	auipc	a7,0x0
 6aa:	52a88893          	add	a7,a7,1322 # bd0 <digits>
    buf[i++] = digits[x % base];
 6ae:	02c5f7bb          	remuw	a5,a1,a2
  }while((x /= base) != 0);
 6b2:	0705                	add	a4,a4,1
 6b4:	0005881b          	sext.w	a6,a1
 6b8:	84aa                	mv	s1,a0
    buf[i++] = digits[x % base];
 6ba:	2505                	addw	a0,a0,1
 6bc:	1782                	sll	a5,a5,0x20
 6be:	9381                	srl	a5,a5,0x20
 6c0:	97c6                	add	a5,a5,a7
 6c2:	0007c783          	lbu	a5,0(a5)
  }while((x /= base) != 0);
 6c6:	02c5d5bb          	divuw	a1,a1,a2
    buf[i++] = digits[x % base];
 6ca:	fef70fa3          	sb	a5,-1(a4)
  }while((x /= base) != 0);
 6ce:	fec870e3          	bgeu	a6,a2,6ae <printint+0x2a>
  if(neg)
 6d2:	ca89                	beqz	a3,6e4 <printint+0x60>
    buf[i++] = '-';
 6d4:	fd050793          	add	a5,a0,-48
 6d8:	97a2                	add	a5,a5,s0
 6da:	02d00713          	li	a4,45
 6de:	fee78823          	sb	a4,-16(a5)

  while(--i >= 0)
 6e2:	84aa                	mv	s1,a0
 6e4:	fc040793          	add	a5,s0,-64
 6e8:	94be                	add	s1,s1,a5
 6ea:	fff78993          	add	s3,a5,-1
    putc(fd, buf[i]);
 6ee:	0004c783          	lbu	a5,0(s1)
  write(fd, &c, 1);
 6f2:	4605                	li	a2,1
 6f4:	fbf40593          	add	a1,s0,-65
 6f8:	854a                	mv	a0,s2
  while(--i >= 0)
 6fa:	14fd                	add	s1,s1,-1
 6fc:	faf40fa3          	sb	a5,-65(s0)
  write(fd, &c, 1);
 700:	00000097          	auipc	ra,0x0
 704:	efc080e7          	jalr	-260(ra) # 5fc <write>
  while(--i >= 0)
 708:	ff3493e3          	bne	s1,s3,6ee <printint+0x6a>
}
 70c:	60a6                	ld	ra,72(sp)
 70e:	6406                	ld	s0,64(sp)
 710:	74e2                	ld	s1,56(sp)
 712:	7942                	ld	s2,48(sp)
 714:	79a2                	ld	s3,40(sp)
 716:	6161                	add	sp,sp,80
 718:	8082                	ret
    x = -xx;
 71a:	40b005bb          	negw	a1,a1
 71e:	b741                	j	69e <printint+0x1a>

0000000000000720 <vprintf>:
}

// Print to the given fd. Only understands %d, %x, %p, %s.
void
vprintf(int fd, const char *fmt, va_list ap)
{
 720:	7159                	add	sp,sp,-112
 722:	f0a2                	sd	s0,96(sp)
 724:	f486                	sd	ra,104(sp)
 726:	e8ca                	sd	s2,80(sp)
 728:	1880                	add	s0,sp,112
  char *s;
  int c, i, state;

  state = 0;
  for(i = 0; fmt[i]; i++){
 72a:	0005c903          	lbu	s2,0(a1)
 72e:	04090f63          	beqz	s2,78c <vprintf+0x6c>
 732:	eca6                	sd	s1,88(sp)
 734:	e4ce                	sd	s3,72(sp)
 736:	e0d2                	sd	s4,64(sp)
 738:	fc56                	sd	s5,56(sp)
 73a:	f85a                	sd	s6,48(sp)
 73c:	f45e                	sd	s7,40(sp)
 73e:	f062                	sd	s8,32(sp)
 740:	8a2a                	mv	s4,a0
 742:	8c32                	mv	s8,a2
 744:	00158493          	add	s1,a1,1
 748:	4981                	li	s3,0
      if(c == '%'){
        state = '%';
      } else {
        putc(fd, c);
      }
    } else if(state == '%'){
 74a:	02500a93          	li	s5,37
 74e:	4bd5                	li	s7,21
 750:	00000b17          	auipc	s6,0x0
 754:	428b0b13          	add	s6,s6,1064 # b78 <malloc+0x172>
    if(state == 0){
 758:	02099f63          	bnez	s3,796 <vprintf+0x76>
      if(c == '%'){
 75c:	05590c63          	beq	s2,s5,7b4 <vprintf+0x94>
  write(fd, &c, 1);
 760:	4605                	li	a2,1
 762:	f9f40593          	add	a1,s0,-97
 766:	8552                	mv	a0,s4
 768:	f9240fa3          	sb	s2,-97(s0)
 76c:	00000097          	auipc	ra,0x0
 770:	e90080e7          	jalr	-368(ra) # 5fc <write>
  for(i = 0; fmt[i]; i++){
 774:	0004c903          	lbu	s2,0(s1)
 778:	0485                	add	s1,s1,1
 77a:	fc091fe3          	bnez	s2,758 <vprintf+0x38>
 77e:	64e6                	ld	s1,88(sp)
 780:	69a6                	ld	s3,72(sp)
 782:	6a06                	ld	s4,64(sp)
 784:	7ae2                	ld	s5,56(sp)
 786:	7b42                	ld	s6,48(sp)
 788:	7ba2                	ld	s7,40(sp)
 78a:	7c02                	ld	s8,32(sp)
        putc(fd, c);
      }
      state = 0;
    }
  }
}
 78c:	70a6                	ld	ra,104(sp)
 78e:	7406                	ld	s0,96(sp)
 790:	6946                	ld	s2,80(sp)
 792:	6165                	add	sp,sp,112
 794:	8082                	ret
    } else if(state == '%'){
 796:	fd599fe3          	bne	s3,s5,774 <vprintf+0x54>
      if(c == 'd'){
 79a:	15590463          	beq	s2,s5,8e2 <vprintf+0x1c2>
 79e:	f9d9079b          	addw	a5,s2,-99
 7a2:	0ff7f793          	zext.b	a5,a5
 7a6:	00fbea63          	bltu	s7,a5,7ba <vprintf+0x9a>
 7aa:	078a                	sll	a5,a5,0x2
 7ac:	97da                	add	a5,a5,s6
 7ae:	439c                	lw	a5,0(a5)
 7b0:	97da                	add	a5,a5,s6
 7b2:	8782                	jr	a5
        state = '%';
 7b4:	02500993          	li	s3,37
 7b8:	bf75                	j	774 <vprintf+0x54>
  write(fd, &c, 1);
 7ba:	f9f40993          	add	s3,s0,-97
 7be:	4605                	li	a2,1
 7c0:	85ce                	mv	a1,s3
 7c2:	02500793          	li	a5,37
 7c6:	8552                	mv	a0,s4
 7c8:	f8f40fa3          	sb	a5,-97(s0)
 7cc:	00000097          	auipc	ra,0x0
 7d0:	e30080e7          	jalr	-464(ra) # 5fc <write>
 7d4:	4605                	li	a2,1
 7d6:	85ce                	mv	a1,s3
 7d8:	8552                	mv	a0,s4
 7da:	f9240fa3          	sb	s2,-97(s0)
 7de:	00000097          	auipc	ra,0x0
 7e2:	e1e080e7          	jalr	-482(ra) # 5fc <write>
        while(*s != 0){
 7e6:	4981                	li	s3,0
 7e8:	b771                	j	774 <vprintf+0x54>
        putc(fd, va_arg(ap, uint));
 7ea:	000c2783          	lw	a5,0(s8)
  write(fd, &c, 1);
 7ee:	4605                	li	a2,1
 7f0:	f9f40593          	add	a1,s0,-97
 7f4:	8552                	mv	a0,s4
        putc(fd, va_arg(ap, uint));
 7f6:	f8f40fa3          	sb	a5,-97(s0)
 7fa:	0c21                	add	s8,s8,8
  write(fd, &c, 1);
 7fc:	00000097          	auipc	ra,0x0
 800:	e00080e7          	jalr	-512(ra) # 5fc <write>
 804:	4981                	li	s3,0
 806:	b7bd                	j	774 <vprintf+0x54>
        printint(fd, va_arg(ap, int), 10, 1);
 808:	000c2583          	lw	a1,0(s8)
 80c:	4685                	li	a3,1
        printint(fd, va_arg(ap, uint64), 10, 0);
 80e:	4629                	li	a2,10
 810:	8552                	mv	a0,s4
 812:	0c21                	add	s8,s8,8
 814:	00000097          	auipc	ra,0x0
 818:	e70080e7          	jalr	-400(ra) # 684 <printint>
 81c:	4981                	li	s3,0
 81e:	bf99                	j	774 <vprintf+0x54>
 820:	000c2583          	lw	a1,0(s8)
 824:	4681                	li	a3,0
 826:	b7e5                	j	80e <vprintf+0xee>
  write(fd, &c, 1);
 828:	f9f40993          	add	s3,s0,-97
 82c:	03000793          	li	a5,48
 830:	4605                	li	a2,1
 832:	85ce                	mv	a1,s3
 834:	8552                	mv	a0,s4
 836:	ec66                	sd	s9,24(sp)
 838:	e86a                	sd	s10,16(sp)
        printptr(fd, va_arg(ap, uint64));
 83a:	f8f40fa3          	sb	a5,-97(s0)
 83e:	000c3d03          	ld	s10,0(s8)
  write(fd, &c, 1);
 842:	00000097          	auipc	ra,0x0
 846:	dba080e7          	jalr	-582(ra) # 5fc <write>
 84a:	07800793          	li	a5,120
 84e:	4605                	li	a2,1
 850:	85ce                	mv	a1,s3
 852:	8552                	mv	a0,s4
 854:	f8f40fa3          	sb	a5,-97(s0)
        printptr(fd, va_arg(ap, uint64));
 858:	0c21                	add	s8,s8,8
  write(fd, &c, 1);
 85a:	00000097          	auipc	ra,0x0
 85e:	da2080e7          	jalr	-606(ra) # 5fc <write>
  putc(fd, 'x');
 862:	4941                	li	s2,16
 864:	00000c97          	auipc	s9,0x0
 868:	36cc8c93          	add	s9,s9,876 # bd0 <digits>
    putc(fd, digits[x >> (sizeof(uint64) * 8 - 4)]);
 86c:	03cd5793          	srl	a5,s10,0x3c
 870:	97e6                	add	a5,a5,s9
 872:	0007c783          	lbu	a5,0(a5)
  write(fd, &c, 1);
 876:	4605                	li	a2,1
 878:	85ce                	mv	a1,s3
 87a:	8552                	mv	a0,s4
  for (i = 0; i < (sizeof(uint64) * 2); i++, x <<= 4)
 87c:	397d                	addw	s2,s2,-1
 87e:	f8f40fa3          	sb	a5,-97(s0)
 882:	0d12                	sll	s10,s10,0x4
  write(fd, &c, 1);
 884:	00000097          	auipc	ra,0x0
 888:	d78080e7          	jalr	-648(ra) # 5fc <write>
  for (i = 0; i < (sizeof(uint64) * 2); i++, x <<= 4)
 88c:	fe0910e3          	bnez	s2,86c <vprintf+0x14c>
 890:	6ce2                	ld	s9,24(sp)
 892:	6d42                	ld	s10,16(sp)
 894:	4981                	li	s3,0
 896:	bdf9                	j	774 <vprintf+0x54>
        s = va_arg(ap, char*);
 898:	000c3903          	ld	s2,0(s8)
 89c:	0c21                	add	s8,s8,8
        if(s == 0)
 89e:	04090e63          	beqz	s2,8fa <vprintf+0x1da>
        while(*s != 0){
 8a2:	00094783          	lbu	a5,0(s2)
 8a6:	d3a1                	beqz	a5,7e6 <vprintf+0xc6>
 8a8:	f9f40993          	add	s3,s0,-97
  write(fd, &c, 1);
 8ac:	4605                	li	a2,1
 8ae:	85ce                	mv	a1,s3
 8b0:	8552                	mv	a0,s4
 8b2:	f8f40fa3          	sb	a5,-97(s0)
 8b6:	00000097          	auipc	ra,0x0
 8ba:	d46080e7          	jalr	-698(ra) # 5fc <write>
        while(*s != 0){
 8be:	00194783          	lbu	a5,1(s2)
          s++;
 8c2:	0905                	add	s2,s2,1
        while(*s != 0){
 8c4:	f7e5                	bnez	a5,8ac <vprintf+0x18c>
 8c6:	4981                	li	s3,0
 8c8:	b575                	j	774 <vprintf+0x54>
        printint(fd, va_arg(ap, int), 16, 0);
 8ca:	000c2583          	lw	a1,0(s8)
 8ce:	4681                	li	a3,0
 8d0:	4641                	li	a2,16
 8d2:	8552                	mv	a0,s4
 8d4:	0c21                	add	s8,s8,8
 8d6:	00000097          	auipc	ra,0x0
 8da:	dae080e7          	jalr	-594(ra) # 684 <printint>
 8de:	4981                	li	s3,0
 8e0:	bd51                	j	774 <vprintf+0x54>
  write(fd, &c, 1);
 8e2:	4605                	li	a2,1
 8e4:	f9f40593          	add	a1,s0,-97
 8e8:	8552                	mv	a0,s4
 8ea:	f9540fa3          	sb	s5,-97(s0)
        while(*s != 0){
 8ee:	4981                	li	s3,0
  write(fd, &c, 1);
 8f0:	00000097          	auipc	ra,0x0
 8f4:	d0c080e7          	jalr	-756(ra) # 5fc <write>
 8f8:	bdb5                	j	774 <vprintf+0x54>
          s = "(null)";
 8fa:	00000917          	auipc	s2,0x0
 8fe:	27690913          	add	s2,s2,630 # b70 <malloc+0x16a>
 902:	02800793          	li	a5,40
 906:	b74d                	j	8a8 <vprintf+0x188>

0000000000000908 <fprintf>:

void
fprintf(int fd, const char *fmt, ...)
{
 908:	715d                	add	sp,sp,-80
 90a:	e822                	sd	s0,16(sp)
 90c:	ec06                	sd	ra,24(sp)
 90e:	1000                	add	s0,sp,32
 910:	e010                	sd	a2,0(s0)
  va_list ap;

  va_start(ap, fmt);
  vprintf(fd, fmt, ap);
 912:	8622                	mv	a2,s0
{
 914:	e414                	sd	a3,8(s0)
 916:	e818                	sd	a4,16(s0)
 918:	ec1c                	sd	a5,24(s0)
 91a:	03043023          	sd	a6,32(s0)
 91e:	03143423          	sd	a7,40(s0)
  va_start(ap, fmt);
 922:	fe843423          	sd	s0,-24(s0)
  vprintf(fd, fmt, ap);
 926:	00000097          	auipc	ra,0x0
 92a:	dfa080e7          	jalr	-518(ra) # 720 <vprintf>
}
 92e:	60e2                	ld	ra,24(sp)
 930:	6442                	ld	s0,16(sp)
 932:	6161                	add	sp,sp,80
 934:	8082                	ret

0000000000000936 <printf>:

void
printf(const char *fmt, ...)
{
 936:	711d                	add	sp,sp,-96
 938:	e822                	sd	s0,16(sp)
 93a:	ec06                	sd	ra,24(sp)
 93c:	1000                	add	s0,sp,32
  va_list ap;

  va_start(ap, fmt);
 93e:	00840313          	add	t1,s0,8
{
 942:	e40c                	sd	a1,8(s0)
 944:	e810                	sd	a2,16(s0)
  vprintf(1, fmt, ap);
 946:	85aa                	mv	a1,a0
 948:	861a                	mv	a2,t1
 94a:	4505                	li	a0,1
{
 94c:	ec14                	sd	a3,24(s0)
 94e:	f018                	sd	a4,32(s0)
 950:	f41c                	sd	a5,40(s0)
 952:	03043823          	sd	a6,48(s0)
 956:	03143c23          	sd	a7,56(s0)
  va_start(ap, fmt);
 95a:	fe643423          	sd	t1,-24(s0)
  vprintf(1, fmt, ap);
 95e:	00000097          	auipc	ra,0x0
 962:	dc2080e7          	jalr	-574(ra) # 720 <vprintf>
}
 966:	60e2                	ld	ra,24(sp)
 968:	6442                	ld	s0,16(sp)
 96a:	6125                	add	sp,sp,96
 96c:	8082                	ret

000000000000096e <free>:
static Header base;
static Header *freep;

void
free(void *ap)
{
 96e:	1141                	add	sp,sp,-16
 970:	e422                	sd	s0,8(sp)
 972:	0800                	add	s0,sp,16
  Header *bp, *p;

  bp = (Header*)ap - 1;
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 974:	00000597          	auipc	a1,0x0
 978:	68c58593          	add	a1,a1,1676 # 1000 <freep>
 97c:	619c                	ld	a5,0(a1)
  bp = (Header*)ap - 1;
 97e:	ff050693          	add	a3,a0,-16
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 982:	6398                	ld	a4,0(a5)
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 984:	02d7ff63          	bgeu	a5,a3,9c2 <free+0x54>
 988:	00e6e463          	bltu	a3,a4,990 <free+0x22>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 98c:	02e7ef63          	bltu	a5,a4,9ca <free+0x5c>
      break;
  if(bp + bp->s.size == p->s.ptr){
 990:	ff852803          	lw	a6,-8(a0)
 994:	02081893          	sll	a7,a6,0x20
 998:	01c8d613          	srl	a2,a7,0x1c
 99c:	9636                	add	a2,a2,a3
 99e:	02c70863          	beq	a4,a2,9ce <free+0x60>
    bp->s.size += p->s.ptr->s.size;
    bp->s.ptr = p->s.ptr->s.ptr;
  } else
    bp->s.ptr = p->s.ptr;
  if(p + p->s.size == bp){
 9a2:	0087a803          	lw	a6,8(a5)
 9a6:	fee53823          	sd	a4,-16(a0)
 9aa:	02081893          	sll	a7,a6,0x20
 9ae:	01c8d613          	srl	a2,a7,0x1c
 9b2:	963e                	add	a2,a2,a5
 9b4:	02c68e63          	beq	a3,a2,9f0 <free+0x82>
    p->s.size += bp->s.size;
    p->s.ptr = bp->s.ptr;
  } else
    p->s.ptr = bp;
  freep = p;
}
 9b8:	6422                	ld	s0,8(sp)
 9ba:	e394                	sd	a3,0(a5)
  freep = p;
 9bc:	e19c                	sd	a5,0(a1)
}
 9be:	0141                	add	sp,sp,16
 9c0:	8082                	ret
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 9c2:	00e7e463          	bltu	a5,a4,9ca <free+0x5c>
 9c6:	fce6e5e3          	bltu	a3,a4,990 <free+0x22>
{
 9ca:	87ba                	mv	a5,a4
 9cc:	bf5d                	j	982 <free+0x14>
    bp->s.size += p->s.ptr->s.size;
 9ce:	4710                	lw	a2,8(a4)
    bp->s.ptr = p->s.ptr->s.ptr;
 9d0:	6318                	ld	a4,0(a4)
    bp->s.size += p->s.ptr->s.size;
 9d2:	0106063b          	addw	a2,a2,a6
 9d6:	fec52c23          	sw	a2,-8(a0)
  if(p + p->s.size == bp){
 9da:	0087a803          	lw	a6,8(a5)
 9de:	fee53823          	sd	a4,-16(a0)
 9e2:	02081893          	sll	a7,a6,0x20
 9e6:	01c8d613          	srl	a2,a7,0x1c
 9ea:	963e                	add	a2,a2,a5
 9ec:	fcc696e3          	bne	a3,a2,9b8 <free+0x4a>
    p->s.size += bp->s.size;
 9f0:	ff852603          	lw	a2,-8(a0)
}
 9f4:	6422                	ld	s0,8(sp)
    p->s.ptr = bp->s.ptr;
 9f6:	86ba                	mv	a3,a4
    p->s.size += bp->s.size;
 9f8:	0106073b          	addw	a4,a2,a6
 9fc:	c798                	sw	a4,8(a5)
    p->s.ptr = bp->s.ptr;
 9fe:	e394                	sd	a3,0(a5)
  freep = p;
 a00:	e19c                	sd	a5,0(a1)
}
 a02:	0141                	add	sp,sp,16
 a04:	8082                	ret

0000000000000a06 <malloc>:
  return freep;
}

void*
malloc(uint nbytes)
{
 a06:	7139                	add	sp,sp,-64
 a08:	f822                	sd	s0,48(sp)
 a0a:	f426                	sd	s1,40(sp)
 a0c:	f04a                	sd	s2,32(sp)
 a0e:	ec4e                	sd	s3,24(sp)
 a10:	fc06                	sd	ra,56(sp)
 a12:	0080                	add	s0,sp,64
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
  if((prevp = freep) == 0){
 a14:	00000917          	auipc	s2,0x0
 a18:	5ec90913          	add	s2,s2,1516 # 1000 <freep>
  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
 a1c:	02051493          	sll	s1,a0,0x20
 a20:	9081                	srl	s1,s1,0x20
  if((prevp = freep) == 0){
 a22:	00093783          	ld	a5,0(s2)
  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
 a26:	04bd                	add	s1,s1,15
 a28:	8091                	srl	s1,s1,0x4
 a2a:	0014899b          	addw	s3,s1,1
 a2e:	0485                	add	s1,s1,1
  if((prevp = freep) == 0){
 a30:	c3dd                	beqz	a5,ad6 <malloc+0xd0>
    base.s.ptr = freep = prevp = &base;
    base.s.size = 0;
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 a32:	6388                	ld	a0,0(a5)
    if(p->s.size >= nunits){
 a34:	4518                	lw	a4,8(a0)
 a36:	06977863          	bgeu	a4,s1,aa6 <malloc+0xa0>
 a3a:	e852                	sd	s4,16(sp)
 a3c:	e456                	sd	s5,8(sp)
 a3e:	e05a                	sd	s6,0(sp)
  if(nu < 4096)
 a40:	6785                	lui	a5,0x1
 a42:	8a4e                	mv	s4,s3
 a44:	08f4e763          	bltu	s1,a5,ad2 <malloc+0xcc>
 a48:	000a0b1b          	sext.w	s6,s4
  if(p == (char*)-1)
 a4c:	5afd                	li	s5,-1
  p = sbrk(nu * sizeof(Header));
 a4e:	004a1a1b          	sllw	s4,s4,0x4
 a52:	a029                	j	a5c <malloc+0x56>
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 a54:	6388                	ld	a0,0(a5)
    if(p->s.size >= nunits){
 a56:	4518                	lw	a4,8(a0)
 a58:	04977463          	bgeu	a4,s1,aa0 <malloc+0x9a>
        p->s.size = nunits;
      }
      freep = prevp;
      return (void*)(p + 1);
    }
    if(p == freep)
 a5c:	00093703          	ld	a4,0(s2)
 a60:	87aa                	mv	a5,a0
 a62:	fee519e3          	bne	a0,a4,a54 <malloc+0x4e>
  p = sbrk(nu * sizeof(Header));
 a66:	8552                	mv	a0,s4
 a68:	00000097          	auipc	ra,0x0
 a6c:	bfc080e7          	jalr	-1028(ra) # 664 <sbrk>
 a70:	87aa                	mv	a5,a0
  free((void*)(hp + 1));
 a72:	0541                	add	a0,a0,16
  if(p == (char*)-1)
 a74:	01578b63          	beq	a5,s5,a8a <malloc+0x84>
  hp->s.size = nu;
 a78:	0167a423          	sw	s6,8(a5) # 1008 <freep+0x8>
  free((void*)(hp + 1));
 a7c:	00000097          	auipc	ra,0x0
 a80:	ef2080e7          	jalr	-270(ra) # 96e <free>
  return freep;
 a84:	00093783          	ld	a5,0(s2)
      if((p = morecore(nunits)) == 0)
 a88:	f7f1                	bnez	a5,a54 <malloc+0x4e>
        return 0;
  }
}
 a8a:	70e2                	ld	ra,56(sp)
 a8c:	7442                	ld	s0,48(sp)
        return 0;
 a8e:	6a42                	ld	s4,16(sp)
 a90:	6aa2                	ld	s5,8(sp)
 a92:	6b02                	ld	s6,0(sp)
}
 a94:	74a2                	ld	s1,40(sp)
 a96:	7902                	ld	s2,32(sp)
 a98:	69e2                	ld	s3,24(sp)
        return 0;
 a9a:	4501                	li	a0,0
}
 a9c:	6121                	add	sp,sp,64
 a9e:	8082                	ret
 aa0:	6a42                	ld	s4,16(sp)
 aa2:	6aa2                	ld	s5,8(sp)
 aa4:	6b02                	ld	s6,0(sp)
      if(p->s.size == nunits)
 aa6:	04e48763          	beq	s1,a4,af4 <malloc+0xee>
        p->s.size -= nunits;
 aaa:	4137073b          	subw	a4,a4,s3
        p += p->s.size;
 aae:	02071613          	sll	a2,a4,0x20
 ab2:	01c65693          	srl	a3,a2,0x1c
        p->s.size -= nunits;
 ab6:	c518                	sw	a4,8(a0)
        p += p->s.size;
 ab8:	9536                	add	a0,a0,a3
        p->s.size = nunits;
 aba:	01352423          	sw	s3,8(a0)
}
 abe:	70e2                	ld	ra,56(sp)
 ac0:	7442                	ld	s0,48(sp)
      freep = prevp;
 ac2:	00f93023          	sd	a5,0(s2)
}
 ac6:	74a2                	ld	s1,40(sp)
 ac8:	7902                	ld	s2,32(sp)
 aca:	69e2                	ld	s3,24(sp)
      return (void*)(p + 1);
 acc:	0541                	add	a0,a0,16
}
 ace:	6121                	add	sp,sp,64
 ad0:	8082                	ret
  if(nu < 4096)
 ad2:	6a05                	lui	s4,0x1
 ad4:	bf95                	j	a48 <malloc+0x42>
 ad6:	e852                	sd	s4,16(sp)
 ad8:	e456                	sd	s5,8(sp)
 ada:	e05a                	sd	s6,0(sp)
    base.s.ptr = freep = prevp = &base;
 adc:	00000517          	auipc	a0,0x0
 ae0:	54450513          	add	a0,a0,1348 # 1020 <base>
 ae4:	00a93023          	sd	a0,0(s2)
 ae8:	e108                	sd	a0,0(a0)
    base.s.size = 0;
 aea:	00000797          	auipc	a5,0x0
 aee:	5207af23          	sw	zero,1342(a5) # 1028 <base+0x8>
    if(p->s.size >= nunits){
 af2:	b7b9                	j	a40 <malloc+0x3a>
        prevp->s.ptr = p->s.ptr;
 af4:	6118                	ld	a4,0(a0)
 af6:	e398                	sd	a4,0(a5)
 af8:	b7d9                	j	abe <malloc+0xb8>
