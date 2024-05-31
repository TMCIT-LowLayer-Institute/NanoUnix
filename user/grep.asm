
user/_grep:     file format elf64-littleriscv


Disassembly of section .text:

0000000000000000 <matchhere>:
  return 0;
}

// matchhere: search for re at beginning of text
int matchhere(char *re, char *text)
{
   0:	7179                	add	sp,sp,-48
   2:	f022                	sd	s0,32(sp)
   4:	f406                	sd	ra,40(sp)
   6:	e84a                	sd	s2,16(sp)
   8:	1800                	add	s0,sp,48
  if(re[0] == '\0')
   a:	00054903          	lbu	s2,0(a0)
   e:	0a090c63          	beqz	s2,c6 <matchhere+0xc6>
  12:	ec26                	sd	s1,24(sp)
    return 1;
  if(re[1] == '*')
  14:	00154783          	lbu	a5,1(a0)
  18:	02a00613          	li	a2,42
  1c:	84ae                	mv	s1,a1
    return matchstar(re[0], re+2, text);
  if(re[0] == '$' && re[1] == '\0')
  1e:	02400693          	li	a3,36
    return *text == '\0';
  if(*text!='\0' && (re[0]=='.' || re[0]==*text))
  22:	02e00593          	li	a1,46
  if(re[1] == '*')
  26:	02c78163          	beq	a5,a2,48 <matchhere+0x48>
    return *text == '\0';
  2a:	0004c703          	lbu	a4,0(s1)
  if(re[0] == '$' && re[1] == '\0')
  2e:	04d90b63          	beq	s2,a3,84 <matchhere+0x84>
  if(*text!='\0' && (re[0]=='.' || re[0]==*text))
  32:	c33d                	beqz	a4,98 <matchhere+0x98>
  34:	06b91063          	bne	s2,a1,94 <matchhere+0x94>
    return matchhere(re+1, text+1);
  38:	0505                	add	a0,a0,1
  3a:	0485                	add	s1,s1,1
  if(re[0] == '\0')
  3c:	c7ad                	beqz	a5,a6 <matchhere+0xa6>
{
  3e:	893e                	mv	s2,a5
  if(re[1] == '*')
  40:	00154783          	lbu	a5,1(a0)
  44:	fec793e3          	bne	a5,a2,2a <matchhere+0x2a>
  48:	e44e                	sd	s3,8(sp)
  4a:	e052                	sd	s4,0(sp)
    return matchstar(re[0], re+2, text);
  4c:	00250993          	add	s3,a0,2
int matchstar(int c, char *re, char *text)
{
  do{  // a * matches zero or more instances
    if(matchhere(re, text))
      return 1;
  }while(*text!='\0' && (*text++==c || c=='.'));
  50:	02e00a13          	li	s4,46
  54:	a029                	j	5e <matchhere+0x5e>
  56:	01278463          	beq	a5,s2,5e <matchhere+0x5e>
  5a:	01491d63          	bne	s2,s4,74 <matchhere+0x74>
    if(matchhere(re, text))
  5e:	85a6                	mv	a1,s1
  60:	854e                	mv	a0,s3
  62:	00000097          	auipc	ra,0x0
  66:	f9e080e7          	jalr	-98(ra) # 0 <matchhere>
  6a:	e929                	bnez	a0,bc <matchhere+0xbc>
  }while(*text!='\0' && (*text++==c || c=='.'));
  6c:	0004c783          	lbu	a5,0(s1)
  70:	0485                	add	s1,s1,1
  72:	f3f5                	bnez	a5,56 <matchhere+0x56>
}
  74:	70a2                	ld	ra,40(sp)
  76:	7402                	ld	s0,32(sp)
  78:	64e2                	ld	s1,24(sp)
  7a:	69a2                	ld	s3,8(sp)
  7c:	6a02                	ld	s4,0(sp)
  7e:	6942                	ld	s2,16(sp)
  80:	6145                	add	sp,sp,48
  82:	8082                	ret
  if(re[0] == '$' && re[1] == '\0')
  84:	cb85                	beqz	a5,b4 <matchhere+0xb4>
  if(*text!='\0' && (re[0]=='.' || re[0]==*text))
  86:	cb09                	beqz	a4,98 <matchhere+0x98>
  88:	00d71863          	bne	a4,a3,98 <matchhere+0x98>
    return matchhere(re+1, text+1);
  8c:	0505                	add	a0,a0,1
  8e:	0485                	add	s1,s1,1
{
  90:	893e                	mv	s2,a5
  92:	b77d                	j	40 <matchhere+0x40>
  if(*text!='\0' && (re[0]=='.' || re[0]==*text))
  94:	fb2702e3          	beq	a4,s2,38 <matchhere+0x38>
}
  98:	70a2                	ld	ra,40(sp)
  9a:	7402                	ld	s0,32(sp)
  9c:	64e2                	ld	s1,24(sp)
  9e:	6942                	ld	s2,16(sp)
  return 0;
  a0:	4501                	li	a0,0
}
  a2:	6145                	add	sp,sp,48
  a4:	8082                	ret
    return 1;
  a6:	64e2                	ld	s1,24(sp)
  a8:	4505                	li	a0,1
}
  aa:	70a2                	ld	ra,40(sp)
  ac:	7402                	ld	s0,32(sp)
  ae:	6942                	ld	s2,16(sp)
  b0:	6145                	add	sp,sp,48
  b2:	8082                	ret
    return *text == '\0';
  b4:	64e2                	ld	s1,24(sp)
  b6:	00173513          	seqz	a0,a4
  ba:	bfc5                	j	aa <matchhere+0xaa>
  bc:	64e2                	ld	s1,24(sp)
  be:	69a2                	ld	s3,8(sp)
  c0:	6a02                	ld	s4,0(sp)
    return 1;
  c2:	4505                	li	a0,1
  c4:	b7dd                	j	aa <matchhere+0xaa>
  c6:	4505                	li	a0,1
  c8:	b7cd                	j	aa <matchhere+0xaa>

00000000000000ca <match>:
{
  ca:	1101                	add	sp,sp,-32
  cc:	e822                	sd	s0,16(sp)
  ce:	e04a                	sd	s2,0(sp)
  d0:	ec06                	sd	ra,24(sp)
  d2:	1000                	add	s0,sp,32
  if(re[0] == '^')
  d4:	00054703          	lbu	a4,0(a0)
  d8:	05e00793          	li	a5,94
{
  dc:	892a                	mv	s2,a0
  if(re[0] == '^')
  de:	02f70763          	beq	a4,a5,10c <match+0x42>
  e2:	e426                	sd	s1,8(sp)
  e4:	84ae                	mv	s1,a1
  e6:	a021                	j	ee <match+0x24>
  }while(*text++ != '\0');
  e8:	fff4c783          	lbu	a5,-1(s1)
  ec:	cb91                	beqz	a5,100 <match+0x36>
    if(matchhere(re, text))
  ee:	85a6                	mv	a1,s1
  f0:	854a                	mv	a0,s2
  f2:	00000097          	auipc	ra,0x0
  f6:	f0e080e7          	jalr	-242(ra) # 0 <matchhere>
  }while(*text++ != '\0');
  fa:	0485                	add	s1,s1,1
    if(matchhere(re, text))
  fc:	d575                	beqz	a0,e8 <match+0x1e>
      return 1;
  fe:	4505                	li	a0,1
}
 100:	60e2                	ld	ra,24(sp)
 102:	6442                	ld	s0,16(sp)
 104:	64a2                	ld	s1,8(sp)
 106:	6902                	ld	s2,0(sp)
 108:	6105                	add	sp,sp,32
 10a:	8082                	ret
 10c:	6442                	ld	s0,16(sp)
 10e:	60e2                	ld	ra,24(sp)
 110:	6902                	ld	s2,0(sp)
    return matchhere(re+1, text);
 112:	0505                	add	a0,a0,1
}
 114:	6105                	add	sp,sp,32
    return matchhere(re+1, text);
 116:	00000317          	auipc	t1,0x0
 11a:	eea30067          	jr	-278(t1) # 0 <matchhere>

000000000000011e <grep>:
{
 11e:	7159                	add	sp,sp,-112
 120:	f0a2                	sd	s0,96(sp)
 122:	e8ca                	sd	s2,80(sp)
 124:	fc56                	sd	s5,56(sp)
 126:	f45e                	sd	s7,40(sp)
 128:	f062                	sd	s8,32(sp)
 12a:	ec66                	sd	s9,24(sp)
 12c:	e86a                	sd	s10,16(sp)
 12e:	e46e                	sd	s11,8(sp)
 130:	f486                	sd	ra,104(sp)
 132:	eca6                	sd	s1,88(sp)
 134:	e4ce                	sd	s3,72(sp)
 136:	e0d2                	sd	s4,64(sp)
 138:	f85a                	sd	s6,48(sp)
 13a:	1880                	add	s0,sp,112
 13c:	892a                	mv	s2,a0
 13e:	8d2e                	mv	s10,a1
  m = 0;
 140:	4b81                	li	s7,0
 142:	00001c17          	auipc	s8,0x1
 146:	ecec0c13          	add	s8,s8,-306 # 1010 <buf>
  while((n = read(fd, buf+m, sizeof(buf)-m-1)) > 0){
 14a:	3ff00d93          	li	s11,1023
  if(re[0] == '^')
 14e:	05e00a93          	li	s5,94
    return matchhere(re+1, text);
 152:	00150c93          	add	s9,a0,1
  while((n = read(fd, buf+m, sizeof(buf)-m-1)) > 0){
 156:	417d863b          	subw	a2,s11,s7
 15a:	017c05b3          	add	a1,s8,s7
 15e:	856a                	mv	a0,s10
 160:	00000097          	auipc	ra,0x0
 164:	518080e7          	jalr	1304(ra) # 678 <read>
 168:	0aa05663          	blez	a0,214 <grep+0xf6>
    m += n;
 16c:	00ab8bbb          	addw	s7,s7,a0
    buf[m] = '\0';
 170:	017c07b3          	add	a5,s8,s7
    m += n;
 174:	8b5e                	mv	s6,s7
    buf[m] = '\0';
 176:	00078023          	sb	zero,0(a5)
    p = buf;
 17a:	8a62                	mv	s4,s8
    while((q = strchr(p, '\n')) != 0){
 17c:	45a9                	li	a1,10
 17e:	8552                	mv	a0,s4
 180:	00000097          	auipc	ra,0x0
 184:	2ba080e7          	jalr	698(ra) # 43a <strchr>
 188:	89aa                	mv	s3,a0
 18a:	c931                	beqz	a0,1de <grep+0xc0>
      *q = 0;
 18c:	00098023          	sb	zero,0(s3)
  if(re[0] == '^')
 190:	00094783          	lbu	a5,0(s2)
 194:	84d2                	mv	s1,s4
 196:	01579663          	bne	a5,s5,1a2 <grep+0x84>
 19a:	a879                	j	238 <grep+0x11a>
  }while(*text++ != '\0');
 19c:	fff4c783          	lbu	a5,-1(s1)
 1a0:	cbc9                	beqz	a5,232 <grep+0x114>
    if(matchhere(re, text))
 1a2:	85a6                	mv	a1,s1
 1a4:	854a                	mv	a0,s2
 1a6:	00000097          	auipc	ra,0x0
 1aa:	e5a080e7          	jalr	-422(ra) # 0 <matchhere>
  }while(*text++ != '\0');
 1ae:	0485                	add	s1,s1,1
    if(matchhere(re, text))
 1b0:	d575                	beqz	a0,19c <grep+0x7e>
        write(1, p, q+1 - p);
 1b2:	00198493          	add	s1,s3,1
        *q = '\n';
 1b6:	47a9                	li	a5,10
        write(1, p, q+1 - p);
 1b8:	4144863b          	subw	a2,s1,s4
 1bc:	85d2                	mv	a1,s4
        *q = '\n';
 1be:	00f98023          	sb	a5,0(s3)
        write(1, p, q+1 - p);
 1c2:	4505                	li	a0,1
 1c4:	00000097          	auipc	ra,0x0
 1c8:	4bc080e7          	jalr	1212(ra) # 680 <write>
 1cc:	8a26                	mv	s4,s1
    while((q = strchr(p, '\n')) != 0){
 1ce:	45a9                	li	a1,10
 1d0:	8552                	mv	a0,s4
 1d2:	00000097          	auipc	ra,0x0
 1d6:	268080e7          	jalr	616(ra) # 43a <strchr>
 1da:	89aa                	mv	s3,a0
 1dc:	f945                	bnez	a0,18c <grep+0x6e>
    if(m > 0){
 1de:	f7705ce3          	blez	s7,156 <grep+0x38>
      m -= p - buf;
 1e2:	418a0bb3          	sub	s7,s4,s8
 1e6:	417b0bbb          	subw	s7,s6,s7
      memmove(buf, p, m);
 1ea:	865e                	mv	a2,s7
 1ec:	85d2                	mv	a1,s4
 1ee:	00001517          	auipc	a0,0x1
 1f2:	e2250513          	add	a0,a0,-478 # 1010 <buf>
 1f6:	00000097          	auipc	ra,0x0
 1fa:	36a080e7          	jalr	874(ra) # 560 <memmove>
  while((n = read(fd, buf+m, sizeof(buf)-m-1)) > 0){
 1fe:	417d863b          	subw	a2,s11,s7
 202:	017c05b3          	add	a1,s8,s7
 206:	856a                	mv	a0,s10
 208:	00000097          	auipc	ra,0x0
 20c:	470080e7          	jalr	1136(ra) # 678 <read>
 210:	f4a04ee3          	bgtz	a0,16c <grep+0x4e>
}
 214:	70a6                	ld	ra,104(sp)
 216:	7406                	ld	s0,96(sp)
 218:	64e6                	ld	s1,88(sp)
 21a:	6946                	ld	s2,80(sp)
 21c:	69a6                	ld	s3,72(sp)
 21e:	6a06                	ld	s4,64(sp)
 220:	7ae2                	ld	s5,56(sp)
 222:	7b42                	ld	s6,48(sp)
 224:	7ba2                	ld	s7,40(sp)
 226:	7c02                	ld	s8,32(sp)
 228:	6ce2                	ld	s9,24(sp)
 22a:	6d42                	ld	s10,16(sp)
 22c:	6da2                	ld	s11,8(sp)
 22e:	6165                	add	sp,sp,112
 230:	8082                	ret
        write(1, p, q+1 - p);
 232:	00198a13          	add	s4,s3,1
      p = q+1;
 236:	b799                	j	17c <grep+0x5e>
    return matchhere(re+1, text);
 238:	85d2                	mv	a1,s4
 23a:	8566                	mv	a0,s9
 23c:	00000097          	auipc	ra,0x0
 240:	dc4080e7          	jalr	-572(ra) # 0 <matchhere>
        write(1, p, q+1 - p);
 244:	00198493          	add	s1,s3,1
      if(match(pattern, p)){
 248:	f53d                	bnez	a0,1b6 <grep+0x98>
        write(1, p, q+1 - p);
 24a:	8a26                	mv	s4,s1
 24c:	b749                	j	1ce <grep+0xb0>

000000000000024e <matchstar>:
{
 24e:	7179                	add	sp,sp,-48
 250:	f022                	sd	s0,32(sp)
 252:	ec26                	sd	s1,24(sp)
 254:	e84a                	sd	s2,16(sp)
 256:	e44e                	sd	s3,8(sp)
 258:	e052                	sd	s4,0(sp)
 25a:	f406                	sd	ra,40(sp)
 25c:	1800                	add	s0,sp,48
 25e:	892a                	mv	s2,a0
 260:	89ae                	mv	s3,a1
 262:	84b2                	mv	s1,a2
  }while(*text!='\0' && (*text++==c || c=='.'));
 264:	02e00a13          	li	s4,46
    if(matchhere(re, text))
 268:	85a6                	mv	a1,s1
 26a:	854e                	mv	a0,s3
 26c:	00000097          	auipc	ra,0x0
 270:	d94080e7          	jalr	-620(ra) # 0 <matchhere>
 274:	e10d                	bnez	a0,296 <matchstar+0x48>
  }while(*text!='\0' && (*text++==c || c=='.'));
 276:	0004c783          	lbu	a5,0(s1)
 27a:	0485                	add	s1,s1,1
 27c:	c789                	beqz	a5,286 <matchstar+0x38>
 27e:	ff2785e3          	beq	a5,s2,268 <matchstar+0x1a>
 282:	ff4903e3          	beq	s2,s4,268 <matchstar+0x1a>
}
 286:	70a2                	ld	ra,40(sp)
 288:	7402                	ld	s0,32(sp)
 28a:	64e2                	ld	s1,24(sp)
 28c:	6942                	ld	s2,16(sp)
 28e:	69a2                	ld	s3,8(sp)
 290:	6a02                	ld	s4,0(sp)
 292:	6145                	add	sp,sp,48
 294:	8082                	ret
 296:	70a2                	ld	ra,40(sp)
 298:	7402                	ld	s0,32(sp)
 29a:	64e2                	ld	s1,24(sp)
 29c:	6942                	ld	s2,16(sp)
 29e:	69a2                	ld	s3,8(sp)
 2a0:	6a02                	ld	s4,0(sp)
      return 1;
 2a2:	4505                	li	a0,1
}
 2a4:	6145                	add	sp,sp,48
 2a6:	8082                	ret

00000000000002a8 <main>:
{
 2a8:	7139                	add	sp,sp,-64
 2aa:	f822                	sd	s0,48(sp)
 2ac:	fc06                	sd	ra,56(sp)
 2ae:	0080                	add	s0,sp,64
  if(argc <= 1){
 2b0:	4785                	li	a5,1
 2b2:	06a7de63          	bge	a5,a0,32e <main+0x86>
 2b6:	f04a                	sd	s2,32(sp)
 2b8:	ec4e                	sd	s3,24(sp)
 2ba:	e852                	sd	s4,16(sp)
 2bc:	e456                	sd	s5,8(sp)
  if(argc <= 2){
 2be:	4789                	li	a5,2
  pattern = argv[1];
 2c0:	0085ba83          	ld	s5,8(a1)
 2c4:	f426                	sd	s1,40(sp)
 2c6:	8a2a                	mv	s4,a0
  if(argc <= 2){
 2c8:	01058913          	add	s2,a1,16
  for(i = 2; i < argc; i++){
 2cc:	4989                	li	s3,2
  if(argc <= 2){
 2ce:	02f51263          	bne	a0,a5,2f2 <main+0x4a>
 2d2:	a049                	j	354 <main+0xac>
    grep(pattern, fd);
 2d4:	85aa                	mv	a1,a0
 2d6:	8556                	mv	a0,s5
 2d8:	00000097          	auipc	ra,0x0
 2dc:	e46080e7          	jalr	-442(ra) # 11e <grep>
    close(fd);
 2e0:	8526                	mv	a0,s1
  for(i = 2; i < argc; i++){
 2e2:	2985                	addw	s3,s3,1
    close(fd);
 2e4:	00000097          	auipc	ra,0x0
 2e8:	3a4080e7          	jalr	932(ra) # 688 <close>
  for(i = 2; i < argc; i++){
 2ec:	0921                	add	s2,s2,8
 2ee:	0349db63          	bge	s3,s4,324 <main+0x7c>
    if((fd = open(argv[i], 0)) < 0){
 2f2:	00093503          	ld	a0,0(s2)
 2f6:	4581                	li	a1,0
 2f8:	00000097          	auipc	ra,0x0
 2fc:	3a8080e7          	jalr	936(ra) # 6a0 <open>
 300:	84aa                	mv	s1,a0
 302:	fc0559e3          	bgez	a0,2d4 <main+0x2c>
      printf("grep: cannot open %s\n", argv[i]);
 306:	00093583          	ld	a1,0(s2)
 30a:	00001517          	auipc	a0,0x1
 30e:	89650513          	add	a0,a0,-1898 # ba0 <malloc+0x116>
 312:	00000097          	auipc	ra,0x0
 316:	6a8080e7          	jalr	1704(ra) # 9ba <printf>
      exit(1);
 31a:	4505                	li	a0,1
 31c:	00000097          	auipc	ra,0x0
 320:	344080e7          	jalr	836(ra) # 660 <exit>
  exit(0);
 324:	4501                	li	a0,0
 326:	00000097          	auipc	ra,0x0
 32a:	33a080e7          	jalr	826(ra) # 660 <exit>
    fprintf(2, "usage: grep pattern [file ...]\n");
 32e:	4509                	li	a0,2
 330:	00001597          	auipc	a1,0x1
 334:	85058593          	add	a1,a1,-1968 # b80 <malloc+0xf6>
 338:	f426                	sd	s1,40(sp)
 33a:	f04a                	sd	s2,32(sp)
 33c:	ec4e                	sd	s3,24(sp)
 33e:	e852                	sd	s4,16(sp)
 340:	e456                	sd	s5,8(sp)
 342:	00000097          	auipc	ra,0x0
 346:	64a080e7          	jalr	1610(ra) # 98c <fprintf>
    exit(1);
 34a:	4505                	li	a0,1
 34c:	00000097          	auipc	ra,0x0
 350:	314080e7          	jalr	788(ra) # 660 <exit>
    grep(pattern, 0);
 354:	8556                	mv	a0,s5
 356:	4581                	li	a1,0
 358:	00000097          	auipc	ra,0x0
 35c:	dc6080e7          	jalr	-570(ra) # 11e <grep>
    exit(0);
 360:	4501                	li	a0,0
 362:	00000097          	auipc	ra,0x0
 366:	2fe080e7          	jalr	766(ra) # 660 <exit>

000000000000036a <_main>:
//
// wrapper so that it's OK if main() does not call exit().
//
void
_main()
{
 36a:	1141                	add	sp,sp,-16
 36c:	e022                	sd	s0,0(sp)
 36e:	e406                	sd	ra,8(sp)
 370:	0800                	add	s0,sp,16
  extern int main();
  main();
 372:	00000097          	auipc	ra,0x0
 376:	f36080e7          	jalr	-202(ra) # 2a8 <main>
  exit(0);
 37a:	4501                	li	a0,0
 37c:	00000097          	auipc	ra,0x0
 380:	2e4080e7          	jalr	740(ra) # 660 <exit>

0000000000000384 <strcpy>:
}

char*
strcpy(char *s, const char *t)
{
 384:	1141                	add	sp,sp,-16
 386:	e422                	sd	s0,8(sp)
 388:	0800                	add	s0,sp,16
  char *os;

  os = s;
  while((*s++ = *t++) != 0)
 38a:	87aa                	mv	a5,a0
 38c:	0005c703          	lbu	a4,0(a1)
 390:	0785                	add	a5,a5,1
 392:	0585                	add	a1,a1,1
 394:	fee78fa3          	sb	a4,-1(a5)
 398:	fb75                	bnez	a4,38c <strcpy+0x8>
    ;
  return os;
}
 39a:	6422                	ld	s0,8(sp)
 39c:	0141                	add	sp,sp,16
 39e:	8082                	ret

00000000000003a0 <strcmp>:

int
strcmp(const char *p, const char *q)
{
 3a0:	1141                	add	sp,sp,-16
 3a2:	e422                	sd	s0,8(sp)
 3a4:	0800                	add	s0,sp,16
  while(*p && *p == *q)
 3a6:	00054783          	lbu	a5,0(a0)
 3aa:	e791                	bnez	a5,3b6 <strcmp+0x16>
 3ac:	a80d                	j	3de <strcmp+0x3e>
 3ae:	00054783          	lbu	a5,0(a0)
 3b2:	cf99                	beqz	a5,3d0 <strcmp+0x30>
 3b4:	85b6                	mv	a1,a3
 3b6:	0005c703          	lbu	a4,0(a1)
    p++, q++;
 3ba:	0505                	add	a0,a0,1
 3bc:	00158693          	add	a3,a1,1
  while(*p && *p == *q)
 3c0:	fef707e3          	beq	a4,a5,3ae <strcmp+0xe>
  return (uchar)*p - (uchar)*q;
 3c4:	0007851b          	sext.w	a0,a5
}
 3c8:	6422                	ld	s0,8(sp)
 3ca:	9d19                	subw	a0,a0,a4
 3cc:	0141                	add	sp,sp,16
 3ce:	8082                	ret
  return (uchar)*p - (uchar)*q;
 3d0:	0015c703          	lbu	a4,1(a1)
}
 3d4:	6422                	ld	s0,8(sp)
  return (uchar)*p - (uchar)*q;
 3d6:	4501                	li	a0,0
}
 3d8:	9d19                	subw	a0,a0,a4
 3da:	0141                	add	sp,sp,16
 3dc:	8082                	ret
  return (uchar)*p - (uchar)*q;
 3de:	0005c703          	lbu	a4,0(a1)
 3e2:	4501                	li	a0,0
 3e4:	b7d5                	j	3c8 <strcmp+0x28>

00000000000003e6 <strlen>:

uint
strlen(const char *s)
{
 3e6:	1141                	add	sp,sp,-16
 3e8:	e422                	sd	s0,8(sp)
 3ea:	0800                	add	s0,sp,16
  int n;

  for(n = 0; s[n]; n++)
 3ec:	00054783          	lbu	a5,0(a0)
 3f0:	cf91                	beqz	a5,40c <strlen+0x26>
 3f2:	0505                	add	a0,a0,1
 3f4:	87aa                	mv	a5,a0
 3f6:	0007c703          	lbu	a4,0(a5)
 3fa:	86be                	mv	a3,a5
 3fc:	0785                	add	a5,a5,1
 3fe:	ff65                	bnez	a4,3f6 <strlen+0x10>
    ;
  return n;
}
 400:	6422                	ld	s0,8(sp)
 402:	40a6853b          	subw	a0,a3,a0
 406:	2505                	addw	a0,a0,1
 408:	0141                	add	sp,sp,16
 40a:	8082                	ret
 40c:	6422                	ld	s0,8(sp)
  for(n = 0; s[n]; n++)
 40e:	4501                	li	a0,0
}
 410:	0141                	add	sp,sp,16
 412:	8082                	ret

0000000000000414 <memset>:

void*
memset(void *dst, int c, uint n)
{
 414:	1141                	add	sp,sp,-16
 416:	e422                	sd	s0,8(sp)
 418:	0800                	add	s0,sp,16
  char *cdst = (char *) dst;
  int i;
  for(i = 0; i < n; i++){
 41a:	ce09                	beqz	a2,434 <memset+0x20>
 41c:	1602                	sll	a2,a2,0x20
 41e:	9201                	srl	a2,a2,0x20
    cdst[i] = c;
 420:	0ff5f593          	zext.b	a1,a1
 424:	87aa                	mv	a5,a0
 426:	00a60733          	add	a4,a2,a0
 42a:	00b78023          	sb	a1,0(a5)
  for(i = 0; i < n; i++){
 42e:	0785                	add	a5,a5,1
 430:	fee79de3          	bne	a5,a4,42a <memset+0x16>
  }
  return dst;
}
 434:	6422                	ld	s0,8(sp)
 436:	0141                	add	sp,sp,16
 438:	8082                	ret

000000000000043a <strchr>:

char*
strchr(const char *s, char c)
{
 43a:	1141                	add	sp,sp,-16
 43c:	e422                	sd	s0,8(sp)
 43e:	0800                	add	s0,sp,16
  for(; *s; s++)
 440:	00054783          	lbu	a5,0(a0)
 444:	c799                	beqz	a5,452 <strchr+0x18>
    if(*s == c)
 446:	00f58763          	beq	a1,a5,454 <strchr+0x1a>
  for(; *s; s++)
 44a:	00154783          	lbu	a5,1(a0)
 44e:	0505                	add	a0,a0,1
 450:	fbfd                	bnez	a5,446 <strchr+0xc>
      return (char*)s;
  return 0;
 452:	4501                	li	a0,0
}
 454:	6422                	ld	s0,8(sp)
 456:	0141                	add	sp,sp,16
 458:	8082                	ret

000000000000045a <gets>:

char*
gets(char *buf, int max)
{
 45a:	711d                	add	sp,sp,-96
 45c:	e8a2                	sd	s0,80(sp)
 45e:	e4a6                	sd	s1,72(sp)
 460:	e0ca                	sd	s2,64(sp)
 462:	fc4e                	sd	s3,56(sp)
 464:	f852                	sd	s4,48(sp)
 466:	f05a                	sd	s6,32(sp)
 468:	ec5e                	sd	s7,24(sp)
 46a:	ec86                	sd	ra,88(sp)
 46c:	f456                	sd	s5,40(sp)
 46e:	1080                	add	s0,sp,96
 470:	8baa                	mv	s7,a0
 472:	89ae                	mv	s3,a1
 474:	892a                	mv	s2,a0
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
 476:	4481                	li	s1,0
    cc = read(0, &c, 1);
    if(cc < 1)
      break;
    buf[i++] = c;
    if(c == '\n' || c == '\r')
 478:	4a29                	li	s4,10
 47a:	4b35                	li	s6,13
  for(i=0; i+1 < max; ){
 47c:	a005                	j	49c <gets+0x42>
    cc = read(0, &c, 1);
 47e:	00000097          	auipc	ra,0x0
 482:	1fa080e7          	jalr	506(ra) # 678 <read>
    if(cc < 1)
 486:	02a05363          	blez	a0,4ac <gets+0x52>
    buf[i++] = c;
 48a:	faf44783          	lbu	a5,-81(s0)
    if(c == '\n' || c == '\r')
 48e:	0905                	add	s2,s2,1
    buf[i++] = c;
 490:	fef90fa3          	sb	a5,-1(s2)
    if(c == '\n' || c == '\r')
 494:	01478d63          	beq	a5,s4,4ae <gets+0x54>
 498:	01678b63          	beq	a5,s6,4ae <gets+0x54>
  for(i=0; i+1 < max; ){
 49c:	8aa6                	mv	s5,s1
 49e:	2485                	addw	s1,s1,1
    cc = read(0, &c, 1);
 4a0:	4605                	li	a2,1
 4a2:	faf40593          	add	a1,s0,-81
 4a6:	4501                	li	a0,0
  for(i=0; i+1 < max; ){
 4a8:	fd34cbe3          	blt	s1,s3,47e <gets+0x24>
 4ac:	84d6                	mv	s1,s5
      break;
  }
  buf[i] = '\0';
 4ae:	94de                	add	s1,s1,s7
 4b0:	00048023          	sb	zero,0(s1)
  return buf;
}
 4b4:	60e6                	ld	ra,88(sp)
 4b6:	6446                	ld	s0,80(sp)
 4b8:	64a6                	ld	s1,72(sp)
 4ba:	6906                	ld	s2,64(sp)
 4bc:	79e2                	ld	s3,56(sp)
 4be:	7a42                	ld	s4,48(sp)
 4c0:	7aa2                	ld	s5,40(sp)
 4c2:	7b02                	ld	s6,32(sp)
 4c4:	855e                	mv	a0,s7
 4c6:	6be2                	ld	s7,24(sp)
 4c8:	6125                	add	sp,sp,96
 4ca:	8082                	ret

00000000000004cc <stat>:

int
stat(const char *n, struct stat *st)
{
 4cc:	1101                	add	sp,sp,-32
 4ce:	e822                	sd	s0,16(sp)
 4d0:	e04a                	sd	s2,0(sp)
 4d2:	ec06                	sd	ra,24(sp)
 4d4:	e426                	sd	s1,8(sp)
 4d6:	1000                	add	s0,sp,32
 4d8:	892e                	mv	s2,a1
  int fd;
  int r;

  fd = open(n, O_RDONLY);
 4da:	4581                	li	a1,0
 4dc:	00000097          	auipc	ra,0x0
 4e0:	1c4080e7          	jalr	452(ra) # 6a0 <open>
  if(fd < 0)
 4e4:	02054663          	bltz	a0,510 <stat+0x44>
    return -1;
  r = fstat(fd, st);
 4e8:	85ca                	mv	a1,s2
 4ea:	84aa                	mv	s1,a0
 4ec:	00000097          	auipc	ra,0x0
 4f0:	1cc080e7          	jalr	460(ra) # 6b8 <fstat>
 4f4:	87aa                	mv	a5,a0
  close(fd);
 4f6:	8526                	mv	a0,s1
  r = fstat(fd, st);
 4f8:	84be                	mv	s1,a5
  close(fd);
 4fa:	00000097          	auipc	ra,0x0
 4fe:	18e080e7          	jalr	398(ra) # 688 <close>
  return r;
}
 502:	60e2                	ld	ra,24(sp)
 504:	6442                	ld	s0,16(sp)
 506:	6902                	ld	s2,0(sp)
 508:	8526                	mv	a0,s1
 50a:	64a2                	ld	s1,8(sp)
 50c:	6105                	add	sp,sp,32
 50e:	8082                	ret
    return -1;
 510:	54fd                	li	s1,-1
 512:	bfc5                	j	502 <stat+0x36>

0000000000000514 <atoi>:

int
atoi(const char *s)
{
 514:	1141                	add	sp,sp,-16
 516:	e422                	sd	s0,8(sp)
 518:	0800                	add	s0,sp,16
  int n;

  n = 0;
  while('0' <= *s && *s <= '9')
 51a:	00054683          	lbu	a3,0(a0)
 51e:	4625                	li	a2,9
 520:	fd06879b          	addw	a5,a3,-48
 524:	0ff7f793          	zext.b	a5,a5
 528:	02f66863          	bltu	a2,a5,558 <atoi+0x44>
 52c:	872a                	mv	a4,a0
  n = 0;
 52e:	4501                	li	a0,0
    n = n*10 + *s++ - '0';
 530:	0025179b          	sllw	a5,a0,0x2
 534:	9fa9                	addw	a5,a5,a0
 536:	0705                	add	a4,a4,1
 538:	0017979b          	sllw	a5,a5,0x1
 53c:	9fb5                	addw	a5,a5,a3
  while('0' <= *s && *s <= '9')
 53e:	00074683          	lbu	a3,0(a4)
    n = n*10 + *s++ - '0';
 542:	fd07851b          	addw	a0,a5,-48
  while('0' <= *s && *s <= '9')
 546:	fd06879b          	addw	a5,a3,-48
 54a:	0ff7f793          	zext.b	a5,a5
 54e:	fef671e3          	bgeu	a2,a5,530 <atoi+0x1c>
  return n;
}
 552:	6422                	ld	s0,8(sp)
 554:	0141                	add	sp,sp,16
 556:	8082                	ret
 558:	6422                	ld	s0,8(sp)
  n = 0;
 55a:	4501                	li	a0,0
}
 55c:	0141                	add	sp,sp,16
 55e:	8082                	ret

0000000000000560 <memmove>:

void*
memmove(void *vdst, const void *vsrc, int n)
{
 560:	1141                	add	sp,sp,-16
 562:	e422                	sd	s0,8(sp)
 564:	0800                	add	s0,sp,16
  char *dst;
  const char *src;

  dst = vdst;
  src = vsrc;
  if (src > dst) {
 566:	02b57463          	bgeu	a0,a1,58e <memmove+0x2e>
    while(n-- > 0)
 56a:	00c05f63          	blez	a2,588 <memmove+0x28>
 56e:	1602                	sll	a2,a2,0x20
 570:	9201                	srl	a2,a2,0x20
 572:	00c507b3          	add	a5,a0,a2
  dst = vdst;
 576:	872a                	mv	a4,a0
      *dst++ = *src++;
 578:	0005c683          	lbu	a3,0(a1)
 57c:	0705                	add	a4,a4,1
 57e:	0585                	add	a1,a1,1
 580:	fed70fa3          	sb	a3,-1(a4)
    while(n-- > 0)
 584:	fef71ae3          	bne	a4,a5,578 <memmove+0x18>
    src += n;
    while(n-- > 0)
      *--dst = *--src;
  }
  return vdst;
}
 588:	6422                	ld	s0,8(sp)
 58a:	0141                	add	sp,sp,16
 58c:	8082                	ret
    dst += n;
 58e:	00c50733          	add	a4,a0,a2
    src += n;
 592:	95b2                	add	a1,a1,a2
    while(n-- > 0)
 594:	fec05ae3          	blez	a2,588 <memmove+0x28>
 598:	fff6079b          	addw	a5,a2,-1
 59c:	1782                	sll	a5,a5,0x20
 59e:	9381                	srl	a5,a5,0x20
 5a0:	fff7c793          	not	a5,a5
 5a4:	97ae                	add	a5,a5,a1
      *--dst = *--src;
 5a6:	fff5c683          	lbu	a3,-1(a1)
 5aa:	15fd                	add	a1,a1,-1
 5ac:	177d                	add	a4,a4,-1
 5ae:	00d70023          	sb	a3,0(a4)
    while(n-- > 0)
 5b2:	feb79ae3          	bne	a5,a1,5a6 <memmove+0x46>
}
 5b6:	6422                	ld	s0,8(sp)
 5b8:	0141                	add	sp,sp,16
 5ba:	8082                	ret

00000000000005bc <memcmp>:

int
memcmp(const void *s1, const void *s2, uint n)
{
 5bc:	1141                	add	sp,sp,-16
 5be:	e422                	sd	s0,8(sp)
 5c0:	0800                	add	s0,sp,16
  const char *p1 = s1, *p2 = s2;
  while (n-- > 0) {
 5c2:	c61d                	beqz	a2,5f0 <memcmp+0x34>
 5c4:	fff6069b          	addw	a3,a2,-1
 5c8:	1682                	sll	a3,a3,0x20
 5ca:	9281                	srl	a3,a3,0x20
 5cc:	0685                	add	a3,a3,1
 5ce:	96aa                	add	a3,a3,a0
 5d0:	a019                	j	5d6 <memcmp+0x1a>
 5d2:	00a68f63          	beq	a3,a0,5f0 <memcmp+0x34>
    if (*p1 != *p2) {
 5d6:	00054783          	lbu	a5,0(a0)
 5da:	0005c703          	lbu	a4,0(a1)
      return *p1 - *p2;
    }
    p1++;
 5de:	0505                	add	a0,a0,1
    p2++;
 5e0:	0585                	add	a1,a1,1
    if (*p1 != *p2) {
 5e2:	fee788e3          	beq	a5,a4,5d2 <memcmp+0x16>
  }
  return 0;
}
 5e6:	6422                	ld	s0,8(sp)
      return *p1 - *p2;
 5e8:	40e7853b          	subw	a0,a5,a4
}
 5ec:	0141                	add	sp,sp,16
 5ee:	8082                	ret
 5f0:	6422                	ld	s0,8(sp)
  return 0;
 5f2:	4501                	li	a0,0
}
 5f4:	0141                	add	sp,sp,16
 5f6:	8082                	ret

00000000000005f8 <memcpy>:

void *
memcpy(void *dst, const void *src, uint n)
{
 5f8:	1141                	add	sp,sp,-16
 5fa:	e422                	sd	s0,8(sp)
 5fc:	0800                	add	s0,sp,16
  return memmove(dst, src, n);
 5fe:	0006079b          	sext.w	a5,a2
  if (src > dst) {
 602:	02b57463          	bgeu	a0,a1,62a <memcpy+0x32>
    while(n-- > 0)
 606:	00f05f63          	blez	a5,624 <memcpy+0x2c>
 60a:	1602                	sll	a2,a2,0x20
 60c:	9201                	srl	a2,a2,0x20
 60e:	00c587b3          	add	a5,a1,a2
  dst = vdst;
 612:	872a                	mv	a4,a0
      *dst++ = *src++;
 614:	0005c683          	lbu	a3,0(a1)
 618:	0585                	add	a1,a1,1
 61a:	0705                	add	a4,a4,1
 61c:	fed70fa3          	sb	a3,-1(a4)
    while(n-- > 0)
 620:	fef59ae3          	bne	a1,a5,614 <memcpy+0x1c>
}
 624:	6422                	ld	s0,8(sp)
 626:	0141                	add	sp,sp,16
 628:	8082                	ret
    dst += n;
 62a:	00f50733          	add	a4,a0,a5
    src += n;
 62e:	95be                	add	a1,a1,a5
    while(n-- > 0)
 630:	fef05ae3          	blez	a5,624 <memcpy+0x2c>
 634:	fff6079b          	addw	a5,a2,-1
 638:	1782                	sll	a5,a5,0x20
 63a:	9381                	srl	a5,a5,0x20
 63c:	fff7c793          	not	a5,a5
 640:	97ae                	add	a5,a5,a1
      *--dst = *--src;
 642:	fff5c683          	lbu	a3,-1(a1)
 646:	15fd                	add	a1,a1,-1
 648:	177d                	add	a4,a4,-1
 64a:	00d70023          	sb	a3,0(a4)
    while(n-- > 0)
 64e:	fef59ae3          	bne	a1,a5,642 <memcpy+0x4a>
}
 652:	6422                	ld	s0,8(sp)
 654:	0141                	add	sp,sp,16
 656:	8082                	ret

0000000000000658 <fork>:
# generated by usys.pl - do not edit
#include "kern/syscall.h"
.global fork
fork:
 li a7, SYS_fork
 658:	4885                	li	a7,1
 ecall
 65a:	00000073          	ecall
 ret
 65e:	8082                	ret

0000000000000660 <exit>:
.global exit
exit:
 li a7, SYS_exit
 660:	4889                	li	a7,2
 ecall
 662:	00000073          	ecall
 ret
 666:	8082                	ret

0000000000000668 <wait>:
.global wait
wait:
 li a7, SYS_wait
 668:	488d                	li	a7,3
 ecall
 66a:	00000073          	ecall
 ret
 66e:	8082                	ret

0000000000000670 <pipe>:
.global pipe
pipe:
 li a7, SYS_pipe
 670:	4891                	li	a7,4
 ecall
 672:	00000073          	ecall
 ret
 676:	8082                	ret

0000000000000678 <read>:
.global read
read:
 li a7, SYS_read
 678:	4895                	li	a7,5
 ecall
 67a:	00000073          	ecall
 ret
 67e:	8082                	ret

0000000000000680 <write>:
.global write
write:
 li a7, SYS_write
 680:	48c1                	li	a7,16
 ecall
 682:	00000073          	ecall
 ret
 686:	8082                	ret

0000000000000688 <close>:
.global close
close:
 li a7, SYS_close
 688:	48d5                	li	a7,21
 ecall
 68a:	00000073          	ecall
 ret
 68e:	8082                	ret

0000000000000690 <kill>:
.global kill
kill:
 li a7, SYS_kill
 690:	4899                	li	a7,6
 ecall
 692:	00000073          	ecall
 ret
 696:	8082                	ret

0000000000000698 <exec>:
.global exec
exec:
 li a7, SYS_exec
 698:	489d                	li	a7,7
 ecall
 69a:	00000073          	ecall
 ret
 69e:	8082                	ret

00000000000006a0 <open>:
.global open
open:
 li a7, SYS_open
 6a0:	48bd                	li	a7,15
 ecall
 6a2:	00000073          	ecall
 ret
 6a6:	8082                	ret

00000000000006a8 <mknod>:
.global mknod
mknod:
 li a7, SYS_mknod
 6a8:	48c5                	li	a7,17
 ecall
 6aa:	00000073          	ecall
 ret
 6ae:	8082                	ret

00000000000006b0 <unlink>:
.global unlink
unlink:
 li a7, SYS_unlink
 6b0:	48c9                	li	a7,18
 ecall
 6b2:	00000073          	ecall
 ret
 6b6:	8082                	ret

00000000000006b8 <fstat>:
.global fstat
fstat:
 li a7, SYS_fstat
 6b8:	48a1                	li	a7,8
 ecall
 6ba:	00000073          	ecall
 ret
 6be:	8082                	ret

00000000000006c0 <link>:
.global link
link:
 li a7, SYS_link
 6c0:	48cd                	li	a7,19
 ecall
 6c2:	00000073          	ecall
 ret
 6c6:	8082                	ret

00000000000006c8 <mkdir>:
.global mkdir
mkdir:
 li a7, SYS_mkdir
 6c8:	48d1                	li	a7,20
 ecall
 6ca:	00000073          	ecall
 ret
 6ce:	8082                	ret

00000000000006d0 <chdir>:
.global chdir
chdir:
 li a7, SYS_chdir
 6d0:	48a5                	li	a7,9
 ecall
 6d2:	00000073          	ecall
 ret
 6d6:	8082                	ret

00000000000006d8 <dup>:
.global dup
dup:
 li a7, SYS_dup
 6d8:	48a9                	li	a7,10
 ecall
 6da:	00000073          	ecall
 ret
 6de:	8082                	ret

00000000000006e0 <getpid>:
.global getpid
getpid:
 li a7, SYS_getpid
 6e0:	48ad                	li	a7,11
 ecall
 6e2:	00000073          	ecall
 ret
 6e6:	8082                	ret

00000000000006e8 <sbrk>:
.global sbrk
sbrk:
 li a7, SYS_sbrk
 6e8:	48b1                	li	a7,12
 ecall
 6ea:	00000073          	ecall
 ret
 6ee:	8082                	ret

00000000000006f0 <sleep>:
.global sleep
sleep:
 li a7, SYS_sleep
 6f0:	48b5                	li	a7,13
 ecall
 6f2:	00000073          	ecall
 ret
 6f6:	8082                	ret

00000000000006f8 <uptime>:
.global uptime
uptime:
 li a7, SYS_uptime
 6f8:	48b9                	li	a7,14
 ecall
 6fa:	00000073          	ecall
 ret
 6fe:	8082                	ret

0000000000000700 <poweroff>:
.global poweroff
poweroff:
 li a7, SYS_poweroff
 700:	48d9                	li	a7,22
 ecall
 702:	00000073          	ecall
 ret
 706:	8082                	ret

0000000000000708 <printint>:
  write(fd, &c, 1);
}

static void
printint(int fd, int xx, int base, int sgn)
{
 708:	715d                	add	sp,sp,-80
 70a:	e0a2                	sd	s0,64(sp)
 70c:	f84a                	sd	s2,48(sp)
 70e:	e486                	sd	ra,72(sp)
 710:	fc26                	sd	s1,56(sp)
 712:	f44e                	sd	s3,40(sp)
 714:	0880                	add	s0,sp,80
 716:	892a                	mv	s2,a0
  char buf[16];
  int i, neg;
  uint x;

  neg = 0;
  if(sgn && xx < 0){
 718:	c299                	beqz	a3,71e <printint+0x16>
 71a:	0805c263          	bltz	a1,79e <printint+0x96>
    neg = 1;
    x = -xx;
  } else {
    x = xx;
 71e:	2581                	sext.w	a1,a1
  neg = 0;
 720:	4681                	li	a3,0
  }

  i = 0;
  do{
    buf[i++] = digits[x % base];
 722:	2601                	sext.w	a2,a2
 724:	fc040713          	add	a4,s0,-64
  i = 0;
 728:	4501                	li	a0,0
 72a:	00000897          	auipc	a7,0x0
 72e:	4ee88893          	add	a7,a7,1262 # c18 <digits>
    buf[i++] = digits[x % base];
 732:	02c5f7bb          	remuw	a5,a1,a2
  }while((x /= base) != 0);
 736:	0705                	add	a4,a4,1
 738:	0005881b          	sext.w	a6,a1
 73c:	84aa                	mv	s1,a0
    buf[i++] = digits[x % base];
 73e:	2505                	addw	a0,a0,1
 740:	1782                	sll	a5,a5,0x20
 742:	9381                	srl	a5,a5,0x20
 744:	97c6                	add	a5,a5,a7
 746:	0007c783          	lbu	a5,0(a5)
  }while((x /= base) != 0);
 74a:	02c5d5bb          	divuw	a1,a1,a2
    buf[i++] = digits[x % base];
 74e:	fef70fa3          	sb	a5,-1(a4)
  }while((x /= base) != 0);
 752:	fec870e3          	bgeu	a6,a2,732 <printint+0x2a>
  if(neg)
 756:	ca89                	beqz	a3,768 <printint+0x60>
    buf[i++] = '-';
 758:	fd050793          	add	a5,a0,-48
 75c:	97a2                	add	a5,a5,s0
 75e:	02d00713          	li	a4,45
 762:	fee78823          	sb	a4,-16(a5)

  while(--i >= 0)
 766:	84aa                	mv	s1,a0
 768:	fc040793          	add	a5,s0,-64
 76c:	94be                	add	s1,s1,a5
 76e:	fff78993          	add	s3,a5,-1
    putc(fd, buf[i]);
 772:	0004c783          	lbu	a5,0(s1)
  write(fd, &c, 1);
 776:	4605                	li	a2,1
 778:	fbf40593          	add	a1,s0,-65
 77c:	854a                	mv	a0,s2
  while(--i >= 0)
 77e:	14fd                	add	s1,s1,-1
 780:	faf40fa3          	sb	a5,-65(s0)
  write(fd, &c, 1);
 784:	00000097          	auipc	ra,0x0
 788:	efc080e7          	jalr	-260(ra) # 680 <write>
  while(--i >= 0)
 78c:	ff3493e3          	bne	s1,s3,772 <printint+0x6a>
}
 790:	60a6                	ld	ra,72(sp)
 792:	6406                	ld	s0,64(sp)
 794:	74e2                	ld	s1,56(sp)
 796:	7942                	ld	s2,48(sp)
 798:	79a2                	ld	s3,40(sp)
 79a:	6161                	add	sp,sp,80
 79c:	8082                	ret
    x = -xx;
 79e:	40b005bb          	negw	a1,a1
 7a2:	b741                	j	722 <printint+0x1a>

00000000000007a4 <vprintf>:
}

// Print to the given fd. Only understands %d, %x, %p, %s.
void
vprintf(int fd, const char *fmt, va_list ap)
{
 7a4:	7159                	add	sp,sp,-112
 7a6:	f0a2                	sd	s0,96(sp)
 7a8:	f486                	sd	ra,104(sp)
 7aa:	e8ca                	sd	s2,80(sp)
 7ac:	1880                	add	s0,sp,112
  char *s;
  int c, i, state;

  state = 0;
  for(i = 0; fmt[i]; i++){
 7ae:	0005c903          	lbu	s2,0(a1)
 7b2:	04090f63          	beqz	s2,810 <vprintf+0x6c>
 7b6:	eca6                	sd	s1,88(sp)
 7b8:	e4ce                	sd	s3,72(sp)
 7ba:	e0d2                	sd	s4,64(sp)
 7bc:	fc56                	sd	s5,56(sp)
 7be:	f85a                	sd	s6,48(sp)
 7c0:	f45e                	sd	s7,40(sp)
 7c2:	f062                	sd	s8,32(sp)
 7c4:	8a2a                	mv	s4,a0
 7c6:	8c32                	mv	s8,a2
 7c8:	00158493          	add	s1,a1,1
 7cc:	4981                	li	s3,0
      if(c == '%'){
        state = '%';
      } else {
        putc(fd, c);
      }
    } else if(state == '%'){
 7ce:	02500a93          	li	s5,37
 7d2:	4bd5                	li	s7,21
 7d4:	00000b17          	auipc	s6,0x0
 7d8:	3ecb0b13          	add	s6,s6,1004 # bc0 <malloc+0x136>
    if(state == 0){
 7dc:	02099f63          	bnez	s3,81a <vprintf+0x76>
      if(c == '%'){
 7e0:	05590c63          	beq	s2,s5,838 <vprintf+0x94>
  write(fd, &c, 1);
 7e4:	4605                	li	a2,1
 7e6:	f9f40593          	add	a1,s0,-97
 7ea:	8552                	mv	a0,s4
 7ec:	f9240fa3          	sb	s2,-97(s0)
 7f0:	00000097          	auipc	ra,0x0
 7f4:	e90080e7          	jalr	-368(ra) # 680 <write>
  for(i = 0; fmt[i]; i++){
 7f8:	0004c903          	lbu	s2,0(s1)
 7fc:	0485                	add	s1,s1,1
 7fe:	fc091fe3          	bnez	s2,7dc <vprintf+0x38>
 802:	64e6                	ld	s1,88(sp)
 804:	69a6                	ld	s3,72(sp)
 806:	6a06                	ld	s4,64(sp)
 808:	7ae2                	ld	s5,56(sp)
 80a:	7b42                	ld	s6,48(sp)
 80c:	7ba2                	ld	s7,40(sp)
 80e:	7c02                	ld	s8,32(sp)
        putc(fd, c);
      }
      state = 0;
    }
  }
}
 810:	70a6                	ld	ra,104(sp)
 812:	7406                	ld	s0,96(sp)
 814:	6946                	ld	s2,80(sp)
 816:	6165                	add	sp,sp,112
 818:	8082                	ret
    } else if(state == '%'){
 81a:	fd599fe3          	bne	s3,s5,7f8 <vprintf+0x54>
      if(c == 'd'){
 81e:	15590463          	beq	s2,s5,966 <vprintf+0x1c2>
 822:	f9d9079b          	addw	a5,s2,-99
 826:	0ff7f793          	zext.b	a5,a5
 82a:	00fbea63          	bltu	s7,a5,83e <vprintf+0x9a>
 82e:	078a                	sll	a5,a5,0x2
 830:	97da                	add	a5,a5,s6
 832:	439c                	lw	a5,0(a5)
 834:	97da                	add	a5,a5,s6
 836:	8782                	jr	a5
        state = '%';
 838:	02500993          	li	s3,37
 83c:	bf75                	j	7f8 <vprintf+0x54>
  write(fd, &c, 1);
 83e:	f9f40993          	add	s3,s0,-97
 842:	4605                	li	a2,1
 844:	85ce                	mv	a1,s3
 846:	02500793          	li	a5,37
 84a:	8552                	mv	a0,s4
 84c:	f8f40fa3          	sb	a5,-97(s0)
 850:	00000097          	auipc	ra,0x0
 854:	e30080e7          	jalr	-464(ra) # 680 <write>
 858:	4605                	li	a2,1
 85a:	85ce                	mv	a1,s3
 85c:	8552                	mv	a0,s4
 85e:	f9240fa3          	sb	s2,-97(s0)
 862:	00000097          	auipc	ra,0x0
 866:	e1e080e7          	jalr	-482(ra) # 680 <write>
        while(*s != 0){
 86a:	4981                	li	s3,0
 86c:	b771                	j	7f8 <vprintf+0x54>
        putc(fd, va_arg(ap, uint));
 86e:	000c2783          	lw	a5,0(s8)
  write(fd, &c, 1);
 872:	4605                	li	a2,1
 874:	f9f40593          	add	a1,s0,-97
 878:	8552                	mv	a0,s4
        putc(fd, va_arg(ap, uint));
 87a:	f8f40fa3          	sb	a5,-97(s0)
 87e:	0c21                	add	s8,s8,8
  write(fd, &c, 1);
 880:	00000097          	auipc	ra,0x0
 884:	e00080e7          	jalr	-512(ra) # 680 <write>
 888:	4981                	li	s3,0
 88a:	b7bd                	j	7f8 <vprintf+0x54>
        printint(fd, va_arg(ap, int), 10, 1);
 88c:	000c2583          	lw	a1,0(s8)
 890:	4685                	li	a3,1
        printint(fd, va_arg(ap, uint64), 10, 0);
 892:	4629                	li	a2,10
 894:	8552                	mv	a0,s4
 896:	0c21                	add	s8,s8,8
 898:	00000097          	auipc	ra,0x0
 89c:	e70080e7          	jalr	-400(ra) # 708 <printint>
 8a0:	4981                	li	s3,0
 8a2:	bf99                	j	7f8 <vprintf+0x54>
 8a4:	000c2583          	lw	a1,0(s8)
 8a8:	4681                	li	a3,0
 8aa:	b7e5                	j	892 <vprintf+0xee>
  write(fd, &c, 1);
 8ac:	f9f40993          	add	s3,s0,-97
 8b0:	03000793          	li	a5,48
 8b4:	4605                	li	a2,1
 8b6:	85ce                	mv	a1,s3
 8b8:	8552                	mv	a0,s4
 8ba:	ec66                	sd	s9,24(sp)
 8bc:	e86a                	sd	s10,16(sp)
        printptr(fd, va_arg(ap, uint64));
 8be:	f8f40fa3          	sb	a5,-97(s0)
 8c2:	000c3d03          	ld	s10,0(s8)
  write(fd, &c, 1);
 8c6:	00000097          	auipc	ra,0x0
 8ca:	dba080e7          	jalr	-582(ra) # 680 <write>
 8ce:	07800793          	li	a5,120
 8d2:	4605                	li	a2,1
 8d4:	85ce                	mv	a1,s3
 8d6:	8552                	mv	a0,s4
 8d8:	f8f40fa3          	sb	a5,-97(s0)
        printptr(fd, va_arg(ap, uint64));
 8dc:	0c21                	add	s8,s8,8
  write(fd, &c, 1);
 8de:	00000097          	auipc	ra,0x0
 8e2:	da2080e7          	jalr	-606(ra) # 680 <write>
  putc(fd, 'x');
 8e6:	4941                	li	s2,16
 8e8:	00000c97          	auipc	s9,0x0
 8ec:	330c8c93          	add	s9,s9,816 # c18 <digits>
    putc(fd, digits[x >> (sizeof(uint64) * 8 - 4)]);
 8f0:	03cd5793          	srl	a5,s10,0x3c
 8f4:	97e6                	add	a5,a5,s9
 8f6:	0007c783          	lbu	a5,0(a5)
  write(fd, &c, 1);
 8fa:	4605                	li	a2,1
 8fc:	85ce                	mv	a1,s3
 8fe:	8552                	mv	a0,s4
  for (i = 0; i < (sizeof(uint64) * 2); i++, x <<= 4)
 900:	397d                	addw	s2,s2,-1
 902:	f8f40fa3          	sb	a5,-97(s0)
 906:	0d12                	sll	s10,s10,0x4
  write(fd, &c, 1);
 908:	00000097          	auipc	ra,0x0
 90c:	d78080e7          	jalr	-648(ra) # 680 <write>
  for (i = 0; i < (sizeof(uint64) * 2); i++, x <<= 4)
 910:	fe0910e3          	bnez	s2,8f0 <vprintf+0x14c>
 914:	6ce2                	ld	s9,24(sp)
 916:	6d42                	ld	s10,16(sp)
 918:	4981                	li	s3,0
 91a:	bdf9                	j	7f8 <vprintf+0x54>
        s = va_arg(ap, char*);
 91c:	000c3903          	ld	s2,0(s8)
 920:	0c21                	add	s8,s8,8
        if(s == 0)
 922:	04090e63          	beqz	s2,97e <vprintf+0x1da>
        while(*s != 0){
 926:	00094783          	lbu	a5,0(s2)
 92a:	d3a1                	beqz	a5,86a <vprintf+0xc6>
 92c:	f9f40993          	add	s3,s0,-97
  write(fd, &c, 1);
 930:	4605                	li	a2,1
 932:	85ce                	mv	a1,s3
 934:	8552                	mv	a0,s4
 936:	f8f40fa3          	sb	a5,-97(s0)
 93a:	00000097          	auipc	ra,0x0
 93e:	d46080e7          	jalr	-698(ra) # 680 <write>
        while(*s != 0){
 942:	00194783          	lbu	a5,1(s2)
          s++;
 946:	0905                	add	s2,s2,1
        while(*s != 0){
 948:	f7e5                	bnez	a5,930 <vprintf+0x18c>
 94a:	4981                	li	s3,0
 94c:	b575                	j	7f8 <vprintf+0x54>
        printint(fd, va_arg(ap, int), 16, 0);
 94e:	000c2583          	lw	a1,0(s8)
 952:	4681                	li	a3,0
 954:	4641                	li	a2,16
 956:	8552                	mv	a0,s4
 958:	0c21                	add	s8,s8,8
 95a:	00000097          	auipc	ra,0x0
 95e:	dae080e7          	jalr	-594(ra) # 708 <printint>
 962:	4981                	li	s3,0
 964:	bd51                	j	7f8 <vprintf+0x54>
  write(fd, &c, 1);
 966:	4605                	li	a2,1
 968:	f9f40593          	add	a1,s0,-97
 96c:	8552                	mv	a0,s4
 96e:	f9540fa3          	sb	s5,-97(s0)
        while(*s != 0){
 972:	4981                	li	s3,0
  write(fd, &c, 1);
 974:	00000097          	auipc	ra,0x0
 978:	d0c080e7          	jalr	-756(ra) # 680 <write>
 97c:	bdb5                	j	7f8 <vprintf+0x54>
          s = "(null)";
 97e:	00000917          	auipc	s2,0x0
 982:	23a90913          	add	s2,s2,570 # bb8 <malloc+0x12e>
 986:	02800793          	li	a5,40
 98a:	b74d                	j	92c <vprintf+0x188>

000000000000098c <fprintf>:

void
fprintf(int fd, const char *fmt, ...)
{
 98c:	715d                	add	sp,sp,-80
 98e:	e822                	sd	s0,16(sp)
 990:	ec06                	sd	ra,24(sp)
 992:	1000                	add	s0,sp,32
 994:	e010                	sd	a2,0(s0)
  va_list ap;

  va_start(ap, fmt);
  vprintf(fd, fmt, ap);
 996:	8622                	mv	a2,s0
{
 998:	e414                	sd	a3,8(s0)
 99a:	e818                	sd	a4,16(s0)
 99c:	ec1c                	sd	a5,24(s0)
 99e:	03043023          	sd	a6,32(s0)
 9a2:	03143423          	sd	a7,40(s0)
  va_start(ap, fmt);
 9a6:	fe843423          	sd	s0,-24(s0)
  vprintf(fd, fmt, ap);
 9aa:	00000097          	auipc	ra,0x0
 9ae:	dfa080e7          	jalr	-518(ra) # 7a4 <vprintf>
}
 9b2:	60e2                	ld	ra,24(sp)
 9b4:	6442                	ld	s0,16(sp)
 9b6:	6161                	add	sp,sp,80
 9b8:	8082                	ret

00000000000009ba <printf>:

void
printf(const char *fmt, ...)
{
 9ba:	711d                	add	sp,sp,-96
 9bc:	e822                	sd	s0,16(sp)
 9be:	ec06                	sd	ra,24(sp)
 9c0:	1000                	add	s0,sp,32
  va_list ap;

  va_start(ap, fmt);
 9c2:	00840313          	add	t1,s0,8
{
 9c6:	e40c                	sd	a1,8(s0)
 9c8:	e810                	sd	a2,16(s0)
  vprintf(1, fmt, ap);
 9ca:	85aa                	mv	a1,a0
 9cc:	861a                	mv	a2,t1
 9ce:	4505                	li	a0,1
{
 9d0:	ec14                	sd	a3,24(s0)
 9d2:	f018                	sd	a4,32(s0)
 9d4:	f41c                	sd	a5,40(s0)
 9d6:	03043823          	sd	a6,48(s0)
 9da:	03143c23          	sd	a7,56(s0)
  va_start(ap, fmt);
 9de:	fe643423          	sd	t1,-24(s0)
  vprintf(1, fmt, ap);
 9e2:	00000097          	auipc	ra,0x0
 9e6:	dc2080e7          	jalr	-574(ra) # 7a4 <vprintf>
}
 9ea:	60e2                	ld	ra,24(sp)
 9ec:	6442                	ld	s0,16(sp)
 9ee:	6125                	add	sp,sp,96
 9f0:	8082                	ret

00000000000009f2 <free>:
static Header base;
static Header *freep;

void
free(void *ap)
{
 9f2:	1141                	add	sp,sp,-16
 9f4:	e422                	sd	s0,8(sp)
 9f6:	0800                	add	s0,sp,16
  Header *bp, *p;

  bp = (Header*)ap - 1;
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 9f8:	00000597          	auipc	a1,0x0
 9fc:	60858593          	add	a1,a1,1544 # 1000 <freep>
 a00:	619c                	ld	a5,0(a1)
  bp = (Header*)ap - 1;
 a02:	ff050693          	add	a3,a0,-16
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 a06:	6398                	ld	a4,0(a5)
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 a08:	02d7ff63          	bgeu	a5,a3,a46 <free+0x54>
 a0c:	00e6e463          	bltu	a3,a4,a14 <free+0x22>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 a10:	02e7ef63          	bltu	a5,a4,a4e <free+0x5c>
      break;
  if(bp + bp->s.size == p->s.ptr){
 a14:	ff852803          	lw	a6,-8(a0)
 a18:	02081893          	sll	a7,a6,0x20
 a1c:	01c8d613          	srl	a2,a7,0x1c
 a20:	9636                	add	a2,a2,a3
 a22:	02c70863          	beq	a4,a2,a52 <free+0x60>
    bp->s.size += p->s.ptr->s.size;
    bp->s.ptr = p->s.ptr->s.ptr;
  } else
    bp->s.ptr = p->s.ptr;
  if(p + p->s.size == bp){
 a26:	0087a803          	lw	a6,8(a5)
 a2a:	fee53823          	sd	a4,-16(a0)
 a2e:	02081893          	sll	a7,a6,0x20
 a32:	01c8d613          	srl	a2,a7,0x1c
 a36:	963e                	add	a2,a2,a5
 a38:	02c68e63          	beq	a3,a2,a74 <free+0x82>
    p->s.size += bp->s.size;
    p->s.ptr = bp->s.ptr;
  } else
    p->s.ptr = bp;
  freep = p;
}
 a3c:	6422                	ld	s0,8(sp)
 a3e:	e394                	sd	a3,0(a5)
  freep = p;
 a40:	e19c                	sd	a5,0(a1)
}
 a42:	0141                	add	sp,sp,16
 a44:	8082                	ret
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 a46:	00e7e463          	bltu	a5,a4,a4e <free+0x5c>
 a4a:	fce6e5e3          	bltu	a3,a4,a14 <free+0x22>
{
 a4e:	87ba                	mv	a5,a4
 a50:	bf5d                	j	a06 <free+0x14>
    bp->s.size += p->s.ptr->s.size;
 a52:	4710                	lw	a2,8(a4)
    bp->s.ptr = p->s.ptr->s.ptr;
 a54:	6318                	ld	a4,0(a4)
    bp->s.size += p->s.ptr->s.size;
 a56:	0106063b          	addw	a2,a2,a6
 a5a:	fec52c23          	sw	a2,-8(a0)
  if(p + p->s.size == bp){
 a5e:	0087a803          	lw	a6,8(a5)
 a62:	fee53823          	sd	a4,-16(a0)
 a66:	02081893          	sll	a7,a6,0x20
 a6a:	01c8d613          	srl	a2,a7,0x1c
 a6e:	963e                	add	a2,a2,a5
 a70:	fcc696e3          	bne	a3,a2,a3c <free+0x4a>
    p->s.size += bp->s.size;
 a74:	ff852603          	lw	a2,-8(a0)
}
 a78:	6422                	ld	s0,8(sp)
    p->s.ptr = bp->s.ptr;
 a7a:	86ba                	mv	a3,a4
    p->s.size += bp->s.size;
 a7c:	0106073b          	addw	a4,a2,a6
 a80:	c798                	sw	a4,8(a5)
    p->s.ptr = bp->s.ptr;
 a82:	e394                	sd	a3,0(a5)
  freep = p;
 a84:	e19c                	sd	a5,0(a1)
}
 a86:	0141                	add	sp,sp,16
 a88:	8082                	ret

0000000000000a8a <malloc>:
  return freep;
}

void*
malloc(uint nbytes)
{
 a8a:	7139                	add	sp,sp,-64
 a8c:	f822                	sd	s0,48(sp)
 a8e:	f426                	sd	s1,40(sp)
 a90:	f04a                	sd	s2,32(sp)
 a92:	ec4e                	sd	s3,24(sp)
 a94:	fc06                	sd	ra,56(sp)
 a96:	0080                	add	s0,sp,64
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
  if((prevp = freep) == 0){
 a98:	00000917          	auipc	s2,0x0
 a9c:	56890913          	add	s2,s2,1384 # 1000 <freep>
  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
 aa0:	02051493          	sll	s1,a0,0x20
 aa4:	9081                	srl	s1,s1,0x20
  if((prevp = freep) == 0){
 aa6:	00093783          	ld	a5,0(s2)
  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
 aaa:	04bd                	add	s1,s1,15
 aac:	8091                	srl	s1,s1,0x4
 aae:	0014899b          	addw	s3,s1,1
 ab2:	0485                	add	s1,s1,1
  if((prevp = freep) == 0){
 ab4:	c3dd                	beqz	a5,b5a <malloc+0xd0>
    base.s.ptr = freep = prevp = &base;
    base.s.size = 0;
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 ab6:	6388                	ld	a0,0(a5)
    if(p->s.size >= nunits){
 ab8:	4518                	lw	a4,8(a0)
 aba:	06977863          	bgeu	a4,s1,b2a <malloc+0xa0>
 abe:	e852                	sd	s4,16(sp)
 ac0:	e456                	sd	s5,8(sp)
 ac2:	e05a                	sd	s6,0(sp)
  if(nu < 4096)
 ac4:	6785                	lui	a5,0x1
 ac6:	8a4e                	mv	s4,s3
 ac8:	08f4e763          	bltu	s1,a5,b56 <malloc+0xcc>
 acc:	000a0b1b          	sext.w	s6,s4
  if(p == (char*)-1)
 ad0:	5afd                	li	s5,-1
  p = sbrk(nu * sizeof(Header));
 ad2:	004a1a1b          	sllw	s4,s4,0x4
 ad6:	a029                	j	ae0 <malloc+0x56>
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 ad8:	6388                	ld	a0,0(a5)
    if(p->s.size >= nunits){
 ada:	4518                	lw	a4,8(a0)
 adc:	04977463          	bgeu	a4,s1,b24 <malloc+0x9a>
        p->s.size = nunits;
      }
      freep = prevp;
      return (void*)(p + 1);
    }
    if(p == freep)
 ae0:	00093703          	ld	a4,0(s2)
 ae4:	87aa                	mv	a5,a0
 ae6:	fee519e3          	bne	a0,a4,ad8 <malloc+0x4e>
  p = sbrk(nu * sizeof(Header));
 aea:	8552                	mv	a0,s4
 aec:	00000097          	auipc	ra,0x0
 af0:	bfc080e7          	jalr	-1028(ra) # 6e8 <sbrk>
 af4:	87aa                	mv	a5,a0
  free((void*)(hp + 1));
 af6:	0541                	add	a0,a0,16
  if(p == (char*)-1)
 af8:	01578b63          	beq	a5,s5,b0e <malloc+0x84>
  hp->s.size = nu;
 afc:	0167a423          	sw	s6,8(a5) # 1008 <freep+0x8>
  free((void*)(hp + 1));
 b00:	00000097          	auipc	ra,0x0
 b04:	ef2080e7          	jalr	-270(ra) # 9f2 <free>
  return freep;
 b08:	00093783          	ld	a5,0(s2)
      if((p = morecore(nunits)) == 0)
 b0c:	f7f1                	bnez	a5,ad8 <malloc+0x4e>
        return 0;
  }
}
 b0e:	70e2                	ld	ra,56(sp)
 b10:	7442                	ld	s0,48(sp)
        return 0;
 b12:	6a42                	ld	s4,16(sp)
 b14:	6aa2                	ld	s5,8(sp)
 b16:	6b02                	ld	s6,0(sp)
}
 b18:	74a2                	ld	s1,40(sp)
 b1a:	7902                	ld	s2,32(sp)
 b1c:	69e2                	ld	s3,24(sp)
        return 0;
 b1e:	4501                	li	a0,0
}
 b20:	6121                	add	sp,sp,64
 b22:	8082                	ret
 b24:	6a42                	ld	s4,16(sp)
 b26:	6aa2                	ld	s5,8(sp)
 b28:	6b02                	ld	s6,0(sp)
      if(p->s.size == nunits)
 b2a:	04e48763          	beq	s1,a4,b78 <malloc+0xee>
        p->s.size -= nunits;
 b2e:	4137073b          	subw	a4,a4,s3
        p += p->s.size;
 b32:	02071613          	sll	a2,a4,0x20
 b36:	01c65693          	srl	a3,a2,0x1c
        p->s.size -= nunits;
 b3a:	c518                	sw	a4,8(a0)
        p += p->s.size;
 b3c:	9536                	add	a0,a0,a3
        p->s.size = nunits;
 b3e:	01352423          	sw	s3,8(a0)
}
 b42:	70e2                	ld	ra,56(sp)
 b44:	7442                	ld	s0,48(sp)
      freep = prevp;
 b46:	00f93023          	sd	a5,0(s2)
}
 b4a:	74a2                	ld	s1,40(sp)
 b4c:	7902                	ld	s2,32(sp)
 b4e:	69e2                	ld	s3,24(sp)
      return (void*)(p + 1);
 b50:	0541                	add	a0,a0,16
}
 b52:	6121                	add	sp,sp,64
 b54:	8082                	ret
  if(nu < 4096)
 b56:	6a05                	lui	s4,0x1
 b58:	bf95                	j	acc <malloc+0x42>
 b5a:	e852                	sd	s4,16(sp)
 b5c:	e456                	sd	s5,8(sp)
 b5e:	e05a                	sd	s6,0(sp)
    base.s.ptr = freep = prevp = &base;
 b60:	00001517          	auipc	a0,0x1
 b64:	8b050513          	add	a0,a0,-1872 # 1410 <base>
 b68:	00a93023          	sd	a0,0(s2)
 b6c:	e108                	sd	a0,0(a0)
    base.s.size = 0;
 b6e:	00001797          	auipc	a5,0x1
 b72:	8a07a523          	sw	zero,-1878(a5) # 1418 <base+0x8>
    if(p->s.size >= nunits){
 b76:	b7b9                	j	ac4 <malloc+0x3a>
        prevp->s.ptr = p->s.ptr;
 b78:	6118                	ld	a4,0(a0)
 b7a:	e398                	sd	a4,0(a5)
 b7c:	b7d9                	j	b42 <malloc+0xb8>
