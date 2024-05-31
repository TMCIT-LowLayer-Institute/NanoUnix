
user/_usertests:     file format elf64-littleriscv


Disassembly of section .text:

0000000000000000 <copyinstr1>:
}

// what if you pass ridiculous string pointers to system calls?
void
copyinstr1(char *s)
{
       0:	1141                	add	sp,sp,-16
       2:	e022                	sd	s0,0(sp)
       4:	e406                	sd	ra,8(sp)
       6:	0800                	add	s0,sp,16
  uint64 addrs[] = { 0x80000000LL, 0xffffffffffffffff };

  for(int ai = 0; ai < 2; ai++){
    uint64 addr = addrs[ai];

    int fd = open((char *)addr, O_CREATE|O_WRONLY);
       8:	4505                	li	a0,1
       a:	20100593          	li	a1,513
       e:	057e                	sll	a0,a0,0x1f
      10:	00006097          	auipc	ra,0x6
      14:	a4a080e7          	jalr	-1462(ra) # 5a5a <open>
    if(fd >= 0){
      18:	00055f63          	bgez	a0,36 <copyinstr1+0x36>
    int fd = open((char *)addr, O_CREATE|O_WRONLY);
      1c:	20100593          	li	a1,513
      20:	557d                	li	a0,-1
      22:	00006097          	auipc	ra,0x6
      26:	a38080e7          	jalr	-1480(ra) # 5a5a <open>
    if(fd >= 0){
      2a:	02055663          	bgez	a0,56 <copyinstr1+0x56>
      printf("open(%p) returned %d, not -1\n", addr, fd);
      exit(1);
    }
  }
}
      2e:	60a2                	ld	ra,8(sp)
      30:	6402                	ld	s0,0(sp)
      32:	0141                	add	sp,sp,16
      34:	8082                	ret
    uint64 addr = addrs[ai];
      36:	4585                	li	a1,1
      38:	05fe                	sll	a1,a1,0x1f
      printf("open(%p) returned %d, not -1\n", addr, fd);
      3a:	862a                	mv	a2,a0
      3c:	00006517          	auipc	a0,0x6
      40:	f1450513          	add	a0,a0,-236 # 5f50 <malloc+0x10c>
      44:	00006097          	auipc	ra,0x6
      48:	d30080e7          	jalr	-720(ra) # 5d74 <printf>
      exit(1);
      4c:	4505                	li	a0,1
      4e:	00006097          	auipc	ra,0x6
      52:	9cc080e7          	jalr	-1588(ra) # 5a1a <exit>
    uint64 addr = addrs[ai];
      56:	55fd                	li	a1,-1
      58:	b7cd                	j	3a <copyinstr1+0x3a>

000000000000005a <truncate2>:
// this causes a write at an offset beyond the end of the file.
// such writes fail on xv6 (unlike POSIX) but at least
// they don't crash.
void
truncate2(char *s)
{
      5a:	7179                	add	sp,sp,-48
      5c:	f406                	sd	ra,40(sp)
      5e:	f022                	sd	s0,32(sp)
      60:	ec26                	sd	s1,24(sp)
      62:	1800                	add	s0,sp,48
      64:	e84a                	sd	s2,16(sp)
      66:	e44e                	sd	s3,8(sp)
      68:	89aa                	mv	s3,a0
  unlink("truncfile");
      6a:	00006517          	auipc	a0,0x6
      6e:	f0650513          	add	a0,a0,-250 # 5f70 <malloc+0x12c>
      72:	00006097          	auipc	ra,0x6
      76:	9f8080e7          	jalr	-1544(ra) # 5a6a <unlink>

  int fd1 = open("truncfile", O_CREATE|O_TRUNC|O_WRONLY);
      7a:	60100593          	li	a1,1537
      7e:	00006517          	auipc	a0,0x6
      82:	ef250513          	add	a0,a0,-270 # 5f70 <malloc+0x12c>
      86:	00006097          	auipc	ra,0x6
      8a:	9d4080e7          	jalr	-1580(ra) # 5a5a <open>
  write(fd1, "abcd", 4);
      8e:	4611                	li	a2,4
      90:	00006597          	auipc	a1,0x6
      94:	ef058593          	add	a1,a1,-272 # 5f80 <malloc+0x13c>
  int fd1 = open("truncfile", O_CREATE|O_TRUNC|O_WRONLY);
      98:	84aa                	mv	s1,a0
  write(fd1, "abcd", 4);
      9a:	00006097          	auipc	ra,0x6
      9e:	9a0080e7          	jalr	-1632(ra) # 5a3a <write>

  int fd2 = open("truncfile", O_TRUNC|O_WRONLY);
      a2:	40100593          	li	a1,1025
      a6:	00006517          	auipc	a0,0x6
      aa:	eca50513          	add	a0,a0,-310 # 5f70 <malloc+0x12c>
      ae:	00006097          	auipc	ra,0x6
      b2:	9ac080e7          	jalr	-1620(ra) # 5a5a <open>
      b6:	892a                	mv	s2,a0

  int n = write(fd1, "x", 1);
      b8:	4605                	li	a2,1
      ba:	00006597          	auipc	a1,0x6
      be:	ece58593          	add	a1,a1,-306 # 5f88 <malloc+0x144>
      c2:	8526                	mv	a0,s1
      c4:	00006097          	auipc	ra,0x6
      c8:	976080e7          	jalr	-1674(ra) # 5a3a <write>
  if(n != -1){
      cc:	57fd                	li	a5,-1
      ce:	02f51a63          	bne	a0,a5,102 <truncate2+0xa8>
    printf("%s: write returned %d, expected -1\n", s, n);
    exit(1);
  }

  unlink("truncfile");
      d2:	00006517          	auipc	a0,0x6
      d6:	e9e50513          	add	a0,a0,-354 # 5f70 <malloc+0x12c>
      da:	00006097          	auipc	ra,0x6
      de:	990080e7          	jalr	-1648(ra) # 5a6a <unlink>
  close(fd1);
      e2:	8526                	mv	a0,s1
      e4:	00006097          	auipc	ra,0x6
      e8:	95e080e7          	jalr	-1698(ra) # 5a42 <close>
  close(fd2);
}
      ec:	7402                	ld	s0,32(sp)
      ee:	70a2                	ld	ra,40(sp)
      f0:	64e2                	ld	s1,24(sp)
      f2:	69a2                	ld	s3,8(sp)
  close(fd2);
      f4:	854a                	mv	a0,s2
}
      f6:	6942                	ld	s2,16(sp)
      f8:	6145                	add	sp,sp,48
  close(fd2);
      fa:	00006317          	auipc	t1,0x6
      fe:	94830067          	jr	-1720(t1) # 5a42 <close>
    printf("%s: write returned %d, expected -1\n", s, n);
     102:	862a                	mv	a2,a0
     104:	85ce                	mv	a1,s3
     106:	00006517          	auipc	a0,0x6
     10a:	e8a50513          	add	a0,a0,-374 # 5f90 <malloc+0x14c>
     10e:	00006097          	auipc	ra,0x6
     112:	c66080e7          	jalr	-922(ra) # 5d74 <printf>
    exit(1);
     116:	4505                	li	a0,1
     118:	00006097          	auipc	ra,0x6
     11c:	902080e7          	jalr	-1790(ra) # 5a1a <exit>

0000000000000120 <createtest>:
}

// many creates, followed by unlink test
void
createtest(char *s)
{
     120:	7179                	add	sp,sp,-48
     122:	f022                	sd	s0,32(sp)
     124:	ec26                	sd	s1,24(sp)
     126:	1800                	add	s0,sp,48
     128:	e84a                	sd	s2,16(sp)
     12a:	f406                	sd	ra,40(sp)
  int i, fd;
  enum { N=52 };

  char name[3];
  name[0] = 'a';
     12c:	06100793          	li	a5,97
     130:	fcf40c23          	sb	a5,-40(s0)
  name[2] = '\0';
     134:	fc040d23          	sb	zero,-38(s0)
     138:	03000493          	li	s1,48
  for(i = 0; i < N; i++){
     13c:	06400913          	li	s2,100
    name[1] = '0' + i;
    fd = open(name, O_CREATE|O_RDWR);
     140:	20200593          	li	a1,514
    name[1] = '0' + i;
     144:	fc940ca3          	sb	s1,-39(s0)
    fd = open(name, O_CREATE|O_RDWR);
     148:	fd840513          	add	a0,s0,-40
  for(i = 0; i < N; i++){
     14c:	2485                	addw	s1,s1,1
    fd = open(name, O_CREATE|O_RDWR);
     14e:	00006097          	auipc	ra,0x6
     152:	90c080e7          	jalr	-1780(ra) # 5a5a <open>
  for(i = 0; i < N; i++){
     156:	0ff4f493          	zext.b	s1,s1
    close(fd);
     15a:	00006097          	auipc	ra,0x6
     15e:	8e8080e7          	jalr	-1816(ra) # 5a42 <close>
  for(i = 0; i < N; i++){
     162:	fd249fe3          	bne	s1,s2,140 <createtest+0x20>
  }
  name[0] = 'a';
     166:	06100793          	li	a5,97
     16a:	fcf40c23          	sb	a5,-40(s0)
  name[2] = '\0';
     16e:	fc040d23          	sb	zero,-38(s0)
     172:	03000493          	li	s1,48
  for(i = 0; i < N; i++){
     176:	06400913          	li	s2,100
    name[1] = '0' + i;
     17a:	fc940ca3          	sb	s1,-39(s0)
  for(i = 0; i < N; i++){
     17e:	2485                	addw	s1,s1,1
    unlink(name);
     180:	fd840513          	add	a0,s0,-40
  for(i = 0; i < N; i++){
     184:	0ff4f493          	zext.b	s1,s1
    unlink(name);
     188:	00006097          	auipc	ra,0x6
     18c:	8e2080e7          	jalr	-1822(ra) # 5a6a <unlink>
  for(i = 0; i < N; i++){
     190:	ff2495e3          	bne	s1,s2,17a <createtest+0x5a>
  }
}
     194:	70a2                	ld	ra,40(sp)
     196:	7402                	ld	s0,32(sp)
     198:	64e2                	ld	s1,24(sp)
     19a:	6942                	ld	s2,16(sp)
     19c:	6145                	add	sp,sp,48
     19e:	8082                	ret

00000000000001a0 <bigwrite>:
}

// test writes that are larger than the log.
void
bigwrite(char *s)
{
     1a0:	7139                	add	sp,sp,-64
     1a2:	f822                	sd	s0,48(sp)
     1a4:	f426                	sd	s1,40(sp)
     1a6:	ec4e                	sd	s3,24(sp)
     1a8:	e852                	sd	s4,16(sp)
     1aa:	e456                	sd	s5,8(sp)
     1ac:	e05a                	sd	s6,0(sp)
     1ae:	fc06                	sd	ra,56(sp)
     1b0:	f04a                	sd	s2,32(sp)
     1b2:	0080                	add	s0,sp,64
     1b4:	8b2a                	mv	s6,a0
  int fd, sz;

  unlink("bigwrite");
  for(sz = 499; sz < (MAXOPBLOCKS+2)*BSIZE; sz += 471){
     1b6:	6a8d                	lui	s5,0x3
  unlink("bigwrite");
     1b8:	00006517          	auipc	a0,0x6
     1bc:	e0050513          	add	a0,a0,-512 # 5fb8 <malloc+0x174>
     1c0:	00006097          	auipc	ra,0x6
     1c4:	8aa080e7          	jalr	-1878(ra) # 5a6a <unlink>
  for(sz = 499; sz < (MAXOPBLOCKS+2)*BSIZE; sz += 471){
     1c8:	1f300493          	li	s1,499
    fd = open("bigwrite", O_CREATE | O_RDWR);
     1cc:	00006a17          	auipc	s4,0x6
     1d0:	deca0a13          	add	s4,s4,-532 # 5fb8 <malloc+0x174>
      printf("%s: cannot create bigwrite\n", s);
      exit(1);
    }
    int i;
    for(i = 0; i < 2; i++){
      int cc = write(fd, buf, sz);
     1d4:	0000d997          	auipc	s3,0xd
     1d8:	aa498993          	add	s3,s3,-1372 # cc78 <buf>
  for(sz = 499; sz < (MAXOPBLOCKS+2)*BSIZE; sz += 471){
     1dc:	1c9a8a93          	add	s5,s5,457 # 31c9 <dirtest+0x79>
    fd = open("bigwrite", O_CREATE | O_RDWR);
     1e0:	20200593          	li	a1,514
     1e4:	8552                	mv	a0,s4
     1e6:	00006097          	auipc	ra,0x6
     1ea:	874080e7          	jalr	-1932(ra) # 5a5a <open>
     1ee:	892a                	mv	s2,a0
    if(fd < 0){
     1f0:	06054b63          	bltz	a0,266 <bigwrite+0xc6>
      int cc = write(fd, buf, sz);
     1f4:	8626                	mv	a2,s1
     1f6:	85ce                	mv	a1,s3
     1f8:	00006097          	auipc	ra,0x6
     1fc:	842080e7          	jalr	-1982(ra) # 5a3a <write>
      if(cc != sz){
     200:	04a49363          	bne	s1,a0,246 <bigwrite+0xa6>
      int cc = write(fd, buf, sz);
     204:	8626                	mv	a2,s1
     206:	85ce                	mv	a1,s3
     208:	854a                	mv	a0,s2
     20a:	00006097          	auipc	ra,0x6
     20e:	830080e7          	jalr	-2000(ra) # 5a3a <write>
      if(cc != sz){
     212:	02a49a63          	bne	s1,a0,246 <bigwrite+0xa6>
        printf("%s: write(%d) ret %d\n", s, sz, cc);
        exit(1);
      }
    }
    close(fd);
     216:	854a                	mv	a0,s2
     218:	00006097          	auipc	ra,0x6
     21c:	82a080e7          	jalr	-2006(ra) # 5a42 <close>
    unlink("bigwrite");
     220:	8552                	mv	a0,s4
  for(sz = 499; sz < (MAXOPBLOCKS+2)*BSIZE; sz += 471){
     222:	1d74849b          	addw	s1,s1,471
    unlink("bigwrite");
     226:	00006097          	auipc	ra,0x6
     22a:	844080e7          	jalr	-1980(ra) # 5a6a <unlink>
  for(sz = 499; sz < (MAXOPBLOCKS+2)*BSIZE; sz += 471){
     22e:	fb5499e3          	bne	s1,s5,1e0 <bigwrite+0x40>
  }
}
     232:	70e2                	ld	ra,56(sp)
     234:	7442                	ld	s0,48(sp)
     236:	74a2                	ld	s1,40(sp)
     238:	7902                	ld	s2,32(sp)
     23a:	69e2                	ld	s3,24(sp)
     23c:	6a42                	ld	s4,16(sp)
     23e:	6aa2                	ld	s5,8(sp)
     240:	6b02                	ld	s6,0(sp)
     242:	6121                	add	sp,sp,64
     244:	8082                	ret
        printf("%s: write(%d) ret %d\n", s, sz, cc);
     246:	86aa                	mv	a3,a0
     248:	8626                	mv	a2,s1
     24a:	00006517          	auipc	a0,0x6
     24e:	d9e50513          	add	a0,a0,-610 # 5fe8 <malloc+0x1a4>
     252:	85da                	mv	a1,s6
     254:	00006097          	auipc	ra,0x6
     258:	b20080e7          	jalr	-1248(ra) # 5d74 <printf>
        exit(1);
     25c:	4505                	li	a0,1
     25e:	00005097          	auipc	ra,0x5
     262:	7bc080e7          	jalr	1980(ra) # 5a1a <exit>
      printf("%s: cannot create bigwrite\n", s);
     266:	00006517          	auipc	a0,0x6
     26a:	d6250513          	add	a0,a0,-670 # 5fc8 <malloc+0x184>
     26e:	85da                	mv	a1,s6
     270:	00006097          	auipc	ra,0x6
     274:	b04080e7          	jalr	-1276(ra) # 5d74 <printf>
      exit(1);
     278:	4505                	li	a0,1
     27a:	00005097          	auipc	ra,0x5
     27e:	7a0080e7          	jalr	1952(ra) # 5a1a <exit>

0000000000000282 <badwrite>:
// file is deleted? if the kernel has this bug, it will panic: balloc:
// out of blocks. assumed_free may need to be raised to be more than
// the number of free blocks. this test takes a long time.
void
badwrite(char *s)
{
     282:	7179                	add	sp,sp,-48
     284:	f022                	sd	s0,32(sp)
     286:	e84a                	sd	s2,16(sp)
     288:	e44e                	sd	s3,8(sp)
     28a:	e052                	sd	s4,0(sp)
     28c:	f406                	sd	ra,40(sp)
     28e:	ec26                	sd	s1,24(sp)
     290:	1800                	add	s0,sp,48
  int assumed_free = 600;
  
  unlink("junk");
     292:	00006517          	auipc	a0,0x6
     296:	d6e50513          	add	a0,a0,-658 # 6000 <malloc+0x1bc>
    int fd = open("junk", O_CREATE|O_WRONLY);
    if(fd < 0){
      printf("open junk failed\n");
      exit(1);
    }
    write(fd, (char*)0xffffffffffL, 1);
     29a:	5a7d                	li	s4,-1
  unlink("junk");
     29c:	00005097          	auipc	ra,0x5
     2a0:	7ce080e7          	jalr	1998(ra) # 5a6a <unlink>
     2a4:	25800913          	li	s2,600
    int fd = open("junk", O_CREATE|O_WRONLY);
     2a8:	00006997          	auipc	s3,0x6
     2ac:	d5898993          	add	s3,s3,-680 # 6000 <malloc+0x1bc>
    write(fd, (char*)0xffffffffffL, 1);
     2b0:	018a5a13          	srl	s4,s4,0x18
     2b4:	a025                	j	2dc <badwrite+0x5a>
     2b6:	4605                	li	a2,1
     2b8:	85d2                	mv	a1,s4
     2ba:	00005097          	auipc	ra,0x5
     2be:	780080e7          	jalr	1920(ra) # 5a3a <write>
    close(fd);
     2c2:	8526                	mv	a0,s1
     2c4:	00005097          	auipc	ra,0x5
     2c8:	77e080e7          	jalr	1918(ra) # 5a42 <close>
    unlink("junk");
     2cc:	854e                	mv	a0,s3
  for(int i = 0; i < assumed_free; i++){
     2ce:	397d                	addw	s2,s2,-1
    unlink("junk");
     2d0:	00005097          	auipc	ra,0x5
     2d4:	79a080e7          	jalr	1946(ra) # 5a6a <unlink>
  for(int i = 0; i < assumed_free; i++){
     2d8:	02090963          	beqz	s2,30a <badwrite+0x88>
    int fd = open("junk", O_CREATE|O_WRONLY);
     2dc:	20100593          	li	a1,513
     2e0:	854e                	mv	a0,s3
     2e2:	00005097          	auipc	ra,0x5
     2e6:	778080e7          	jalr	1912(ra) # 5a5a <open>
     2ea:	84aa                	mv	s1,a0
    if(fd < 0){
     2ec:	fc0555e3          	bgez	a0,2b6 <badwrite+0x34>
      printf("open junk failed\n");
     2f0:	00006517          	auipc	a0,0x6
     2f4:	d1850513          	add	a0,a0,-744 # 6008 <malloc+0x1c4>
     2f8:	00006097          	auipc	ra,0x6
     2fc:	a7c080e7          	jalr	-1412(ra) # 5d74 <printf>
      exit(1);
     300:	4505                	li	a0,1
     302:	00005097          	auipc	ra,0x5
     306:	718080e7          	jalr	1816(ra) # 5a1a <exit>
  }

  int fd = open("junk", O_CREATE|O_WRONLY);
     30a:	20100593          	li	a1,513
     30e:	00006517          	auipc	a0,0x6
     312:	cf250513          	add	a0,a0,-782 # 6000 <malloc+0x1bc>
     316:	00005097          	auipc	ra,0x5
     31a:	744080e7          	jalr	1860(ra) # 5a5a <open>
     31e:	84aa                	mv	s1,a0
  if(fd < 0){
     320:	fc0548e3          	bltz	a0,2f0 <badwrite+0x6e>
    printf("open junk failed\n");
    exit(1);
  }
  if(write(fd, "x", 1) != 1){
     324:	4605                	li	a2,1
     326:	00006597          	auipc	a1,0x6
     32a:	c6258593          	add	a1,a1,-926 # 5f88 <malloc+0x144>
     32e:	00005097          	auipc	ra,0x5
     332:	70c080e7          	jalr	1804(ra) # 5a3a <write>
     336:	4785                	li	a5,1
     338:	00f50f63          	beq	a0,a5,356 <badwrite+0xd4>
    printf("write failed\n");
     33c:	00006517          	auipc	a0,0x6
     340:	ce450513          	add	a0,a0,-796 # 6020 <malloc+0x1dc>
     344:	00006097          	auipc	ra,0x6
     348:	a30080e7          	jalr	-1488(ra) # 5d74 <printf>
    exit(1);
     34c:	4505                	li	a0,1
     34e:	00005097          	auipc	ra,0x5
     352:	6cc080e7          	jalr	1740(ra) # 5a1a <exit>
  }
  close(fd);
     356:	8526                	mv	a0,s1
     358:	00005097          	auipc	ra,0x5
     35c:	6ea080e7          	jalr	1770(ra) # 5a42 <close>
  unlink("junk");
     360:	00006517          	auipc	a0,0x6
     364:	ca050513          	add	a0,a0,-864 # 6000 <malloc+0x1bc>
     368:	00005097          	auipc	ra,0x5
     36c:	702080e7          	jalr	1794(ra) # 5a6a <unlink>

  exit(0);
     370:	4501                	li	a0,0
     372:	00005097          	auipc	ra,0x5
     376:	6a8080e7          	jalr	1704(ra) # 5a1a <exit>

000000000000037a <outofinodes>:
  }
}

void
outofinodes(char *s)
{
     37a:	715d                	add	sp,sp,-80
     37c:	e0a2                	sd	s0,64(sp)
     37e:	fc26                	sd	s1,56(sp)
     380:	f84a                	sd	s2,48(sp)
     382:	f44e                	sd	s3,40(sp)
     384:	e486                	sd	ra,72(sp)
     386:	0880                	add	s0,sp,80
  int nzz = 32*32;
  for(int i = 0; i < nzz; i++){
    char name[32];
    name[0] = 'z';
     388:	64a1                	lui	s1,0x8
  for(int i = 0; i < nzz; i++){
     38a:	4981                	li	s3,0
    name[0] = 'z';
     38c:	a7a48493          	add	s1,s1,-1414 # 7a7a <malloc+0x1c36>
  for(int i = 0; i < nzz; i++){
     390:	40000913          	li	s2,1024
     394:	a801                	j	3a4 <outofinodes+0x2a>
     396:	2985                	addw	s3,s3,1
    int fd = open(name, O_CREATE|O_RDWR|O_TRUNC);
    if(fd < 0){
      // failure is eventually expected.
      break;
    }
    close(fd);
     398:	00005097          	auipc	ra,0x5
     39c:	6aa080e7          	jalr	1706(ra) # 5a42 <close>
  for(int i = 0; i < nzz; i++){
     3a0:	05298563          	beq	s3,s2,3ea <outofinodes+0x70>
    name[2] = '0' + (i / 32);
     3a4:	4059d79b          	sraw	a5,s3,0x5
    name[3] = '0' + (i % 32);
     3a8:	01f9f713          	and	a4,s3,31
    name[2] = '0' + (i / 32);
     3ac:	0307879b          	addw	a5,a5,48
    name[3] = '0' + (i % 32);
     3b0:	0307071b          	addw	a4,a4,48
    name[2] = '0' + (i / 32);
     3b4:	0087171b          	sllw	a4,a4,0x8
     3b8:	0ff7f793          	zext.b	a5,a5
     3bc:	8fd9                	or	a5,a5,a4
    unlink(name);
     3be:	fb040513          	add	a0,s0,-80
    name[0] = 'z';
     3c2:	fa941823          	sh	s1,-80(s0)
    name[2] = '0' + (i / 32);
     3c6:	faf41923          	sh	a5,-78(s0)
    name[4] = '\0';
     3ca:	fa040a23          	sb	zero,-76(s0)
    unlink(name);
     3ce:	00005097          	auipc	ra,0x5
     3d2:	69c080e7          	jalr	1692(ra) # 5a6a <unlink>
    int fd = open(name, O_CREATE|O_RDWR|O_TRUNC);
     3d6:	60200593          	li	a1,1538
     3da:	fb040513          	add	a0,s0,-80
     3de:	00005097          	auipc	ra,0x5
     3e2:	67c080e7          	jalr	1660(ra) # 5a5a <open>
    if(fd < 0){
     3e6:	fa0558e3          	bgez	a0,396 <outofinodes+0x1c>
  }

  for(int i = 0; i < nzz; i++){
    char name[32];
    name[0] = 'z';
     3ea:	6921                	lui	s2,0x8
  for(int i = 0; i < nzz; i++){
     3ec:	4481                	li	s1,0
    name[0] = 'z';
     3ee:	a7a90913          	add	s2,s2,-1414 # 7a7a <malloc+0x1c36>
  for(int i = 0; i < nzz; i++){
     3f2:	40000993          	li	s3,1024
    name[1] = 'z';
    name[2] = '0' + (i / 32);
     3f6:	4054d79b          	sraw	a5,s1,0x5
    name[3] = '0' + (i % 32);
     3fa:	01f4f713          	and	a4,s1,31
    name[2] = '0' + (i / 32);
     3fe:	0307879b          	addw	a5,a5,48
    name[3] = '0' + (i % 32);
     402:	0307071b          	addw	a4,a4,48
    name[2] = '0' + (i / 32);
     406:	0087171b          	sllw	a4,a4,0x8
     40a:	0ff7f793          	zext.b	a5,a5
     40e:	8fd9                	or	a5,a5,a4
    name[4] = '\0';
    unlink(name);
     410:	fb040513          	add	a0,s0,-80
  for(int i = 0; i < nzz; i++){
     414:	2485                	addw	s1,s1,1
    name[0] = 'z';
     416:	fb241823          	sh	s2,-80(s0)
    name[2] = '0' + (i / 32);
     41a:	faf41923          	sh	a5,-78(s0)
    name[4] = '\0';
     41e:	fa040a23          	sb	zero,-76(s0)
    unlink(name);
     422:	00005097          	auipc	ra,0x5
     426:	648080e7          	jalr	1608(ra) # 5a6a <unlink>
  for(int i = 0; i < nzz; i++){
     42a:	fd3496e3          	bne	s1,s3,3f6 <outofinodes+0x7c>
  }
}
     42e:	60a6                	ld	ra,72(sp)
     430:	6406                	ld	s0,64(sp)
     432:	74e2                	ld	s1,56(sp)
     434:	7942                	ld	s2,48(sp)
     436:	79a2                	ld	s3,40(sp)
     438:	6161                	add	sp,sp,80
     43a:	8082                	ret

000000000000043c <copyin>:
{
     43c:	715d                	add	sp,sp,-80
     43e:	e0a2                	sd	s0,64(sp)
     440:	f84a                	sd	s2,48(sp)
     442:	0880                	add	s0,sp,80
     444:	f052                	sd	s4,32(sp)
     446:	e486                	sd	ra,72(sp)
     448:	fc26                	sd	s1,56(sp)
     44a:	f44e                	sd	s3,40(sp)
  uint64 addrs[] = { 0x80000000LL, 0xffffffffffffffff };
     44c:	4785                	li	a5,1
     44e:	07fe                	sll	a5,a5,0x1f
     450:	fcf43023          	sd	a5,-64(s0)
     454:	57fd                	li	a5,-1
     456:	fcf43423          	sd	a5,-56(s0)
  for(int ai = 0; ai < 2; ai++){
     45a:	fc040913          	add	s2,s0,-64
    int fd = open("copyin1", O_CREATE|O_WRONLY);
     45e:	00006a17          	auipc	s4,0x6
     462:	bd2a0a13          	add	s4,s4,-1070 # 6030 <malloc+0x1ec>
     466:	20100593          	li	a1,513
     46a:	8552                	mv	a0,s4
    uint64 addr = addrs[ai];
     46c:	00093983          	ld	s3,0(s2)
    int fd = open("copyin1", O_CREATE|O_WRONLY);
     470:	00005097          	auipc	ra,0x5
     474:	5ea080e7          	jalr	1514(ra) # 5a5a <open>
     478:	84aa                	mv	s1,a0
    if(fd < 0){
     47a:	08054863          	bltz	a0,50a <copyin+0xce>
    int n = write(fd, (void*)addr, 8192);
     47e:	6609                	lui	a2,0x2
     480:	85ce                	mv	a1,s3
     482:	00005097          	auipc	ra,0x5
     486:	5b8080e7          	jalr	1464(ra) # 5a3a <write>
    if(n >= 0){
     48a:	0e055863          	bgez	a0,57a <copyin+0x13e>
    close(fd);
     48e:	8526                	mv	a0,s1
     490:	00005097          	auipc	ra,0x5
     494:	5b2080e7          	jalr	1458(ra) # 5a42 <close>
    unlink("copyin1");
     498:	8552                	mv	a0,s4
     49a:	00005097          	auipc	ra,0x5
     49e:	5d0080e7          	jalr	1488(ra) # 5a6a <unlink>
    n = write(1, (char*)addr, 8192);
     4a2:	6609                	lui	a2,0x2
     4a4:	85ce                	mv	a1,s3
     4a6:	4505                	li	a0,1
     4a8:	00005097          	auipc	ra,0x5
     4ac:	592080e7          	jalr	1426(ra) # 5a3a <write>
    if(n > 0){
     4b0:	0aa04663          	bgtz	a0,55c <copyin+0x120>
    if(pipe(fds) < 0){
     4b4:	fb840513          	add	a0,s0,-72
     4b8:	00005097          	auipc	ra,0x5
     4bc:	572080e7          	jalr	1394(ra) # 5a2a <pipe>
     4c0:	08054163          	bltz	a0,542 <copyin+0x106>
    n = write(fds[1], (char*)addr, 8192);
     4c4:	fbc42503          	lw	a0,-68(s0)
     4c8:	6609                	lui	a2,0x2
     4ca:	85ce                	mv	a1,s3
     4cc:	00005097          	auipc	ra,0x5
     4d0:	56e080e7          	jalr	1390(ra) # 5a3a <write>
    if(n > 0){
     4d4:	04a04863          	bgtz	a0,524 <copyin+0xe8>
    close(fds[0]);
     4d8:	fb842503          	lw	a0,-72(s0)
  for(int ai = 0; ai < 2; ai++){
     4dc:	0921                	add	s2,s2,8
    close(fds[0]);
     4de:	00005097          	auipc	ra,0x5
     4e2:	564080e7          	jalr	1380(ra) # 5a42 <close>
    close(fds[1]);
     4e6:	fbc42503          	lw	a0,-68(s0)
     4ea:	00005097          	auipc	ra,0x5
     4ee:	558080e7          	jalr	1368(ra) # 5a42 <close>
  for(int ai = 0; ai < 2; ai++){
     4f2:	fd040793          	add	a5,s0,-48
     4f6:	f6f918e3          	bne	s2,a5,466 <copyin+0x2a>
}
     4fa:	60a6                	ld	ra,72(sp)
     4fc:	6406                	ld	s0,64(sp)
     4fe:	74e2                	ld	s1,56(sp)
     500:	7942                	ld	s2,48(sp)
     502:	79a2                	ld	s3,40(sp)
     504:	7a02                	ld	s4,32(sp)
     506:	6161                	add	sp,sp,80
     508:	8082                	ret
      printf("open(copyin1) failed\n");
     50a:	00006517          	auipc	a0,0x6
     50e:	b2e50513          	add	a0,a0,-1234 # 6038 <malloc+0x1f4>
     512:	00006097          	auipc	ra,0x6
     516:	862080e7          	jalr	-1950(ra) # 5d74 <printf>
      exit(1);
     51a:	4505                	li	a0,1
     51c:	00005097          	auipc	ra,0x5
     520:	4fe080e7          	jalr	1278(ra) # 5a1a <exit>
      printf("write(pipe, %p, 8192) returned %d, not -1 or 0\n", addr, n);
     524:	862a                	mv	a2,a0
     526:	85ce                	mv	a1,s3
     528:	00006517          	auipc	a0,0x6
     52c:	b9850513          	add	a0,a0,-1128 # 60c0 <malloc+0x27c>
     530:	00006097          	auipc	ra,0x6
     534:	844080e7          	jalr	-1980(ra) # 5d74 <printf>
      exit(1);
     538:	4505                	li	a0,1
     53a:	00005097          	auipc	ra,0x5
     53e:	4e0080e7          	jalr	1248(ra) # 5a1a <exit>
      printf("pipe() failed\n");
     542:	00006517          	auipc	a0,0x6
     546:	b6e50513          	add	a0,a0,-1170 # 60b0 <malloc+0x26c>
     54a:	00006097          	auipc	ra,0x6
     54e:	82a080e7          	jalr	-2006(ra) # 5d74 <printf>
      exit(1);
     552:	4505                	li	a0,1
     554:	00005097          	auipc	ra,0x5
     558:	4c6080e7          	jalr	1222(ra) # 5a1a <exit>
      printf("write(1, %p, 8192) returned %d, not -1 or 0\n", addr, n);
     55c:	862a                	mv	a2,a0
     55e:	85ce                	mv	a1,s3
     560:	00006517          	auipc	a0,0x6
     564:	b2050513          	add	a0,a0,-1248 # 6080 <malloc+0x23c>
     568:	00006097          	auipc	ra,0x6
     56c:	80c080e7          	jalr	-2036(ra) # 5d74 <printf>
      exit(1);
     570:	4505                	li	a0,1
     572:	00005097          	auipc	ra,0x5
     576:	4a8080e7          	jalr	1192(ra) # 5a1a <exit>
      printf("write(fd, %p, 8192) returned %d, not -1\n", addr, n);
     57a:	862a                	mv	a2,a0
     57c:	85ce                	mv	a1,s3
     57e:	00006517          	auipc	a0,0x6
     582:	ad250513          	add	a0,a0,-1326 # 6050 <malloc+0x20c>
     586:	00005097          	auipc	ra,0x5
     58a:	7ee080e7          	jalr	2030(ra) # 5d74 <printf>
      exit(1);
     58e:	4505                	li	a0,1
     590:	00005097          	auipc	ra,0x5
     594:	48a080e7          	jalr	1162(ra) # 5a1a <exit>

0000000000000598 <copyout>:
{
     598:	711d                	add	sp,sp,-96
     59a:	e8a2                	sd	s0,80(sp)
     59c:	e0ca                	sd	s2,64(sp)
     59e:	1080                	add	s0,sp,96
     5a0:	f852                	sd	s4,48(sp)
     5a2:	f456                	sd	s5,40(sp)
     5a4:	ec86                	sd	ra,88(sp)
     5a6:	e4a6                	sd	s1,72(sp)
     5a8:	fc4e                	sd	s3,56(sp)
  uint64 addrs[] = { 0x80000000LL, 0xffffffffffffffff };
     5aa:	4785                	li	a5,1
     5ac:	07fe                	sll	a5,a5,0x1f
     5ae:	faf43823          	sd	a5,-80(s0)
     5b2:	57fd                	li	a5,-1
     5b4:	faf43c23          	sd	a5,-72(s0)
  for(int ai = 0; ai < 2; ai++){
     5b8:	fb040913          	add	s2,s0,-80
    int fd = open("README", 0);
     5bc:	00006a17          	auipc	s4,0x6
     5c0:	b34a0a13          	add	s4,s4,-1228 # 60f0 <malloc+0x2ac>
    n = write(fds[1], "x", 1);
     5c4:	00006a97          	auipc	s5,0x6
     5c8:	9c4a8a93          	add	s5,s5,-1596 # 5f88 <malloc+0x144>
    int fd = open("README", 0);
     5cc:	4581                	li	a1,0
     5ce:	8552                	mv	a0,s4
    uint64 addr = addrs[ai];
     5d0:	00093983          	ld	s3,0(s2)
    int fd = open("README", 0);
     5d4:	00005097          	auipc	ra,0x5
     5d8:	486080e7          	jalr	1158(ra) # 5a5a <open>
     5dc:	84aa                	mv	s1,a0
    if(fd < 0){
     5de:	08054663          	bltz	a0,66a <copyout+0xd2>
    int n = read(fd, (void*)addr, 8192);
     5e2:	6609                	lui	a2,0x2
     5e4:	85ce                	mv	a1,s3
     5e6:	00005097          	auipc	ra,0x5
     5ea:	44c080e7          	jalr	1100(ra) # 5a32 <read>
    if(n > 0){
     5ee:	0ea04463          	bgtz	a0,6d6 <copyout+0x13e>
    close(fd);
     5f2:	8526                	mv	a0,s1
     5f4:	00005097          	auipc	ra,0x5
     5f8:	44e080e7          	jalr	1102(ra) # 5a42 <close>
    if(pipe(fds) < 0){
     5fc:	fa840513          	add	a0,s0,-88
     600:	00005097          	auipc	ra,0x5
     604:	42a080e7          	jalr	1066(ra) # 5a2a <pipe>
     608:	0a054a63          	bltz	a0,6bc <copyout+0x124>
    n = write(fds[1], "x", 1);
     60c:	fac42503          	lw	a0,-84(s0)
     610:	4605                	li	a2,1
     612:	85d6                	mv	a1,s5
     614:	00005097          	auipc	ra,0x5
     618:	426080e7          	jalr	1062(ra) # 5a3a <write>
    if(n != 1){
     61c:	4785                	li	a5,1
     61e:	08f51263          	bne	a0,a5,6a2 <copyout+0x10a>
    n = read(fds[0], (void*)addr, 8192);
     622:	fa842503          	lw	a0,-88(s0)
     626:	6609                	lui	a2,0x2
     628:	85ce                	mv	a1,s3
     62a:	00005097          	auipc	ra,0x5
     62e:	408080e7          	jalr	1032(ra) # 5a32 <read>
    if(n > 0){
     632:	04a04963          	bgtz	a0,684 <copyout+0xec>
    close(fds[0]);
     636:	fa842503          	lw	a0,-88(s0)
  for(int ai = 0; ai < 2; ai++){
     63a:	0921                	add	s2,s2,8
    close(fds[0]);
     63c:	00005097          	auipc	ra,0x5
     640:	406080e7          	jalr	1030(ra) # 5a42 <close>
    close(fds[1]);
     644:	fac42503          	lw	a0,-84(s0)
     648:	00005097          	auipc	ra,0x5
     64c:	3fa080e7          	jalr	1018(ra) # 5a42 <close>
  for(int ai = 0; ai < 2; ai++){
     650:	fc040793          	add	a5,s0,-64
     654:	f6f91ce3          	bne	s2,a5,5cc <copyout+0x34>
}
     658:	60e6                	ld	ra,88(sp)
     65a:	6446                	ld	s0,80(sp)
     65c:	64a6                	ld	s1,72(sp)
     65e:	6906                	ld	s2,64(sp)
     660:	79e2                	ld	s3,56(sp)
     662:	7a42                	ld	s4,48(sp)
     664:	7aa2                	ld	s5,40(sp)
     666:	6125                	add	sp,sp,96
     668:	8082                	ret
      printf("open(README) failed\n");
     66a:	00006517          	auipc	a0,0x6
     66e:	a8e50513          	add	a0,a0,-1394 # 60f8 <malloc+0x2b4>
     672:	00005097          	auipc	ra,0x5
     676:	702080e7          	jalr	1794(ra) # 5d74 <printf>
      exit(1);
     67a:	4505                	li	a0,1
     67c:	00005097          	auipc	ra,0x5
     680:	39e080e7          	jalr	926(ra) # 5a1a <exit>
      printf("read(pipe, %p, 8192) returned %d, not -1 or 0\n", addr, n);
     684:	862a                	mv	a2,a0
     686:	85ce                	mv	a1,s3
     688:	00006517          	auipc	a0,0x6
     68c:	ad050513          	add	a0,a0,-1328 # 6158 <malloc+0x314>
     690:	00005097          	auipc	ra,0x5
     694:	6e4080e7          	jalr	1764(ra) # 5d74 <printf>
      exit(1);
     698:	4505                	li	a0,1
     69a:	00005097          	auipc	ra,0x5
     69e:	380080e7          	jalr	896(ra) # 5a1a <exit>
      printf("pipe write failed\n");
     6a2:	00006517          	auipc	a0,0x6
     6a6:	a9e50513          	add	a0,a0,-1378 # 6140 <malloc+0x2fc>
     6aa:	00005097          	auipc	ra,0x5
     6ae:	6ca080e7          	jalr	1738(ra) # 5d74 <printf>
      exit(1);
     6b2:	4505                	li	a0,1
     6b4:	00005097          	auipc	ra,0x5
     6b8:	366080e7          	jalr	870(ra) # 5a1a <exit>
      printf("pipe() failed\n");
     6bc:	00006517          	auipc	a0,0x6
     6c0:	9f450513          	add	a0,a0,-1548 # 60b0 <malloc+0x26c>
     6c4:	00005097          	auipc	ra,0x5
     6c8:	6b0080e7          	jalr	1712(ra) # 5d74 <printf>
      exit(1);
     6cc:	4505                	li	a0,1
     6ce:	00005097          	auipc	ra,0x5
     6d2:	34c080e7          	jalr	844(ra) # 5a1a <exit>
      printf("read(fd, %p, 8192) returned %d, not -1 or 0\n", addr, n);
     6d6:	862a                	mv	a2,a0
     6d8:	85ce                	mv	a1,s3
     6da:	00006517          	auipc	a0,0x6
     6de:	a3650513          	add	a0,a0,-1482 # 6110 <malloc+0x2cc>
     6e2:	00005097          	auipc	ra,0x5
     6e6:	692080e7          	jalr	1682(ra) # 5d74 <printf>
      exit(1);
     6ea:	4505                	li	a0,1
     6ec:	00005097          	auipc	ra,0x5
     6f0:	32e080e7          	jalr	814(ra) # 5a1a <exit>

00000000000006f4 <truncate1>:
{
     6f4:	711d                	add	sp,sp,-96
     6f6:	ec86                	sd	ra,88(sp)
     6f8:	e8a2                	sd	s0,80(sp)
     6fa:	e4a6                	sd	s1,72(sp)
     6fc:	1080                	add	s0,sp,96
     6fe:	f852                	sd	s4,48(sp)
     700:	e0ca                	sd	s2,64(sp)
     702:	fc4e                	sd	s3,56(sp)
     704:	f456                	sd	s5,40(sp)
     706:	8a2a                	mv	s4,a0
  unlink("truncfile");
     708:	00006517          	auipc	a0,0x6
     70c:	86850513          	add	a0,a0,-1944 # 5f70 <malloc+0x12c>
     710:	00005097          	auipc	ra,0x5
     714:	35a080e7          	jalr	858(ra) # 5a6a <unlink>
  int fd1 = open("truncfile", O_CREATE|O_WRONLY|O_TRUNC);
     718:	60100593          	li	a1,1537
     71c:	00006517          	auipc	a0,0x6
     720:	85450513          	add	a0,a0,-1964 # 5f70 <malloc+0x12c>
     724:	00005097          	auipc	ra,0x5
     728:	336080e7          	jalr	822(ra) # 5a5a <open>
  write(fd1, "abcd", 4);
     72c:	4611                	li	a2,4
     72e:	00006597          	auipc	a1,0x6
     732:	85258593          	add	a1,a1,-1966 # 5f80 <malloc+0x13c>
  int fd1 = open("truncfile", O_CREATE|O_WRONLY|O_TRUNC);
     736:	84aa                	mv	s1,a0
  write(fd1, "abcd", 4);
     738:	00005097          	auipc	ra,0x5
     73c:	302080e7          	jalr	770(ra) # 5a3a <write>
  close(fd1);
     740:	8526                	mv	a0,s1
     742:	00005097          	auipc	ra,0x5
     746:	300080e7          	jalr	768(ra) # 5a42 <close>
  int fd2 = open("truncfile", O_RDONLY);
     74a:	4581                	li	a1,0
     74c:	00006517          	auipc	a0,0x6
     750:	82450513          	add	a0,a0,-2012 # 5f70 <malloc+0x12c>
     754:	00005097          	auipc	ra,0x5
     758:	306080e7          	jalr	774(ra) # 5a5a <open>
  int n = read(fd2, buf, sizeof(buf));
     75c:	02000613          	li	a2,32
     760:	fa040593          	add	a1,s0,-96
  int fd2 = open("truncfile", O_RDONLY);
     764:	84aa                	mv	s1,a0
  int n = read(fd2, buf, sizeof(buf));
     766:	00005097          	auipc	ra,0x5
     76a:	2cc080e7          	jalr	716(ra) # 5a32 <read>
  if(n != 4){
     76e:	4791                	li	a5,4
     770:	10f51c63          	bne	a0,a5,888 <truncate1+0x194>
  fd1 = open("truncfile", O_WRONLY|O_TRUNC);
     774:	40100593          	li	a1,1025
     778:	00005517          	auipc	a0,0x5
     77c:	7f850513          	add	a0,a0,2040 # 5f70 <malloc+0x12c>
     780:	00005097          	auipc	ra,0x5
     784:	2da080e7          	jalr	730(ra) # 5a5a <open>
  int fd3 = open("truncfile", O_RDONLY);
     788:	4581                	li	a1,0
  fd1 = open("truncfile", O_WRONLY|O_TRUNC);
     78a:	89aa                	mv	s3,a0
  int fd3 = open("truncfile", O_RDONLY);
     78c:	00005517          	auipc	a0,0x5
     790:	7e450513          	add	a0,a0,2020 # 5f70 <malloc+0x12c>
     794:	00005097          	auipc	ra,0x5
     798:	2c6080e7          	jalr	710(ra) # 5a5a <open>
  n = read(fd3, buf, sizeof(buf));
     79c:	fa040593          	add	a1,s0,-96
     7a0:	02000613          	li	a2,32
  int fd3 = open("truncfile", O_RDONLY);
     7a4:	892a                	mv	s2,a0
  n = read(fd3, buf, sizeof(buf));
     7a6:	00005097          	auipc	ra,0x5
     7aa:	28c080e7          	jalr	652(ra) # 5a32 <read>
     7ae:	8aaa                	mv	s5,a0
    printf("aaa fd3=%d\n", fd3);
     7b0:	85ca                	mv	a1,s2
     7b2:	00006517          	auipc	a0,0x6
     7b6:	9f650513          	add	a0,a0,-1546 # 61a8 <malloc+0x364>
  if(n != 0){
     7ba:	0a0a9463          	bnez	s5,862 <truncate1+0x16e>
  n = read(fd2, buf, sizeof(buf));
     7be:	02000613          	li	a2,32
     7c2:	fa040593          	add	a1,s0,-96
     7c6:	8526                	mv	a0,s1
     7c8:	00005097          	auipc	ra,0x5
     7cc:	26a080e7          	jalr	618(ra) # 5a32 <read>
     7d0:	8aaa                	mv	s5,a0
  if(n != 0){
     7d2:	e159                	bnez	a0,858 <truncate1+0x164>
  write(fd1, "abcdef", 6);
     7d4:	4619                	li	a2,6
     7d6:	00006597          	auipc	a1,0x6
     7da:	a1258593          	add	a1,a1,-1518 # 61e8 <malloc+0x3a4>
     7de:	854e                	mv	a0,s3
     7e0:	00005097          	auipc	ra,0x5
     7e4:	25a080e7          	jalr	602(ra) # 5a3a <write>
  n = read(fd3, buf, sizeof(buf));
     7e8:	02000613          	li	a2,32
     7ec:	fa040593          	add	a1,s0,-96
     7f0:	854a                	mv	a0,s2
     7f2:	00005097          	auipc	ra,0x5
     7f6:	240080e7          	jalr	576(ra) # 5a32 <read>
  if(n != 6){
     7fa:	4799                	li	a5,6
     7fc:	0cf51463          	bne	a0,a5,8c4 <truncate1+0x1d0>
  n = read(fd2, buf, sizeof(buf));
     800:	02000613          	li	a2,32
     804:	fa040593          	add	a1,s0,-96
     808:	8526                	mv	a0,s1
     80a:	00005097          	auipc	ra,0x5
     80e:	228080e7          	jalr	552(ra) # 5a32 <read>
  if(n != 2){
     812:	4789                	li	a5,2
     814:	08f51963          	bne	a0,a5,8a6 <truncate1+0x1b2>
  unlink("truncfile");
     818:	00005517          	auipc	a0,0x5
     81c:	75850513          	add	a0,a0,1880 # 5f70 <malloc+0x12c>
     820:	00005097          	auipc	ra,0x5
     824:	24a080e7          	jalr	586(ra) # 5a6a <unlink>
  close(fd1);
     828:	854e                	mv	a0,s3
     82a:	00005097          	auipc	ra,0x5
     82e:	218080e7          	jalr	536(ra) # 5a42 <close>
  close(fd2);
     832:	8526                	mv	a0,s1
     834:	00005097          	auipc	ra,0x5
     838:	20e080e7          	jalr	526(ra) # 5a42 <close>
  close(fd3);
     83c:	854a                	mv	a0,s2
     83e:	00005097          	auipc	ra,0x5
     842:	204080e7          	jalr	516(ra) # 5a42 <close>
}
     846:	60e6                	ld	ra,88(sp)
     848:	6446                	ld	s0,80(sp)
     84a:	64a6                	ld	s1,72(sp)
     84c:	6906                	ld	s2,64(sp)
     84e:	79e2                	ld	s3,56(sp)
     850:	7a42                	ld	s4,48(sp)
     852:	7aa2                	ld	s5,40(sp)
     854:	6125                	add	sp,sp,96
     856:	8082                	ret
    printf("bbb fd2=%d\n", fd2);
     858:	85a6                	mv	a1,s1
     85a:	00006517          	auipc	a0,0x6
     85e:	97e50513          	add	a0,a0,-1666 # 61d8 <malloc+0x394>
     862:	00005097          	auipc	ra,0x5
     866:	512080e7          	jalr	1298(ra) # 5d74 <printf>
    printf("%s: read %d bytes, wanted 0\n", s, n);
     86a:	00006517          	auipc	a0,0x6
     86e:	94e50513          	add	a0,a0,-1714 # 61b8 <malloc+0x374>
     872:	8656                	mv	a2,s5
     874:	85d2                	mv	a1,s4
     876:	00005097          	auipc	ra,0x5
     87a:	4fe080e7          	jalr	1278(ra) # 5d74 <printf>
    exit(1);
     87e:	4505                	li	a0,1
     880:	00005097          	auipc	ra,0x5
     884:	19a080e7          	jalr	410(ra) # 5a1a <exit>
    printf("%s: read %d bytes, wanted 4\n", s, n);
     888:	862a                	mv	a2,a0
     88a:	85d2                	mv	a1,s4
     88c:	00006517          	auipc	a0,0x6
     890:	8fc50513          	add	a0,a0,-1796 # 6188 <malloc+0x344>
     894:	00005097          	auipc	ra,0x5
     898:	4e0080e7          	jalr	1248(ra) # 5d74 <printf>
    exit(1);
     89c:	4505                	li	a0,1
     89e:	00005097          	auipc	ra,0x5
     8a2:	17c080e7          	jalr	380(ra) # 5a1a <exit>
    printf("%s: read %d bytes, wanted 2\n", s, n);
     8a6:	862a                	mv	a2,a0
     8a8:	85d2                	mv	a1,s4
     8aa:	00006517          	auipc	a0,0x6
     8ae:	96650513          	add	a0,a0,-1690 # 6210 <malloc+0x3cc>
     8b2:	00005097          	auipc	ra,0x5
     8b6:	4c2080e7          	jalr	1218(ra) # 5d74 <printf>
    exit(1);
     8ba:	4505                	li	a0,1
     8bc:	00005097          	auipc	ra,0x5
     8c0:	15e080e7          	jalr	350(ra) # 5a1a <exit>
    printf("%s: read %d bytes, wanted 6\n", s, n);
     8c4:	862a                	mv	a2,a0
     8c6:	85d2                	mv	a1,s4
     8c8:	00006517          	auipc	a0,0x6
     8cc:	92850513          	add	a0,a0,-1752 # 61f0 <malloc+0x3ac>
     8d0:	00005097          	auipc	ra,0x5
     8d4:	4a4080e7          	jalr	1188(ra) # 5d74 <printf>
    exit(1);
     8d8:	4505                	li	a0,1
     8da:	00005097          	auipc	ra,0x5
     8de:	140080e7          	jalr	320(ra) # 5a1a <exit>

00000000000008e2 <writetest>:
{
     8e2:	715d                	add	sp,sp,-80
     8e4:	e0a2                	sd	s0,64(sp)
     8e6:	e45e                	sd	s7,8(sp)
     8e8:	e486                	sd	ra,72(sp)
     8ea:	fc26                	sd	s1,56(sp)
     8ec:	f84a                	sd	s2,48(sp)
     8ee:	f44e                	sd	s3,40(sp)
     8f0:	f052                	sd	s4,32(sp)
     8f2:	ec56                	sd	s5,24(sp)
     8f4:	e85a                	sd	s6,16(sp)
     8f6:	0880                	add	s0,sp,80
     8f8:	8baa                	mv	s7,a0
  fd = open("small", O_CREATE|O_RDWR);
     8fa:	20200593          	li	a1,514
     8fe:	00006517          	auipc	a0,0x6
     902:	93250513          	add	a0,a0,-1742 # 6230 <malloc+0x3ec>
     906:	00005097          	auipc	ra,0x5
     90a:	154080e7          	jalr	340(ra) # 5a5a <open>
  if(fd < 0){
     90e:	14054663          	bltz	a0,a5a <writetest+0x178>
     912:	89aa                	mv	s3,a0
     914:	4901                	li	s2,0
    if(write(fd, "aaaaaaaaaa", SZ) != SZ){
     916:	00006a17          	auipc	s4,0x6
     91a:	942a0a13          	add	s4,s4,-1726 # 6258 <malloc+0x414>
    if(write(fd, "bbbbbbbbbb", SZ) != SZ){
     91e:	00006b17          	auipc	s6,0x6
     922:	972b0b13          	add	s6,s6,-1678 # 6290 <malloc+0x44c>
  for(i = 0; i < N; i++){
     926:	06400a93          	li	s5,100
    if(write(fd, "aaaaaaaaaa", SZ) != SZ){
     92a:	4629                	li	a2,10
     92c:	85d2                	mv	a1,s4
     92e:	854e                	mv	a0,s3
     930:	00005097          	auipc	ra,0x5
     934:	10a080e7          	jalr	266(ra) # 5a3a <write>
     938:	47a9                	li	a5,10
     93a:	84aa                	mv	s1,a0
     93c:	08f51763          	bne	a0,a5,9ca <writetest+0xe8>
    if(write(fd, "bbbbbbbbbb", SZ) != SZ){
     940:	4629                	li	a2,10
     942:	85da                	mv	a1,s6
     944:	854e                	mv	a0,s3
     946:	00005097          	auipc	ra,0x5
     94a:	0f4080e7          	jalr	244(ra) # 5a3a <write>
     94e:	08951d63          	bne	a0,s1,9e8 <writetest+0x106>
  for(i = 0; i < N; i++){
     952:	2905                	addw	s2,s2,1
     954:	fd591be3          	bne	s2,s5,92a <writetest+0x48>
  close(fd);
     958:	854e                	mv	a0,s3
     95a:	00005097          	auipc	ra,0x5
     95e:	0e8080e7          	jalr	232(ra) # 5a42 <close>
  fd = open("small", O_RDONLY);
     962:	4581                	li	a1,0
     964:	00006517          	auipc	a0,0x6
     968:	8cc50513          	add	a0,a0,-1844 # 6230 <malloc+0x3ec>
     96c:	00005097          	auipc	ra,0x5
     970:	0ee080e7          	jalr	238(ra) # 5a5a <open>
     974:	84aa                	mv	s1,a0
  if(fd < 0){
     976:	08054863          	bltz	a0,a06 <writetest+0x124>
  i = read(fd, buf, N*SZ*2);
     97a:	7d000613          	li	a2,2000
     97e:	0000c597          	auipc	a1,0xc
     982:	2fa58593          	add	a1,a1,762 # cc78 <buf>
     986:	00005097          	auipc	ra,0x5
     98a:	0ac080e7          	jalr	172(ra) # 5a32 <read>
  if(i != N*SZ*2){
     98e:	7d000793          	li	a5,2000
     992:	08f51863          	bne	a0,a5,a22 <writetest+0x140>
  close(fd);
     996:	8526                	mv	a0,s1
     998:	00005097          	auipc	ra,0x5
     99c:	0aa080e7          	jalr	170(ra) # 5a42 <close>
  if(unlink("small") < 0){
     9a0:	00006517          	auipc	a0,0x6
     9a4:	89050513          	add	a0,a0,-1904 # 6230 <malloc+0x3ec>
     9a8:	00005097          	auipc	ra,0x5
     9ac:	0c2080e7          	jalr	194(ra) # 5a6a <unlink>
     9b0:	08054763          	bltz	a0,a3e <writetest+0x15c>
}
     9b4:	60a6                	ld	ra,72(sp)
     9b6:	6406                	ld	s0,64(sp)
     9b8:	74e2                	ld	s1,56(sp)
     9ba:	7942                	ld	s2,48(sp)
     9bc:	79a2                	ld	s3,40(sp)
     9be:	7a02                	ld	s4,32(sp)
     9c0:	6ae2                	ld	s5,24(sp)
     9c2:	6b42                	ld	s6,16(sp)
     9c4:	6ba2                	ld	s7,8(sp)
     9c6:	6161                	add	sp,sp,80
     9c8:	8082                	ret
      printf("%s: error: write aa %d new file failed\n", s, i);
     9ca:	00006517          	auipc	a0,0x6
     9ce:	89e50513          	add	a0,a0,-1890 # 6268 <malloc+0x424>
     9d2:	864a                	mv	a2,s2
     9d4:	85de                	mv	a1,s7
     9d6:	00005097          	auipc	ra,0x5
     9da:	39e080e7          	jalr	926(ra) # 5d74 <printf>
      exit(1);
     9de:	4505                	li	a0,1
     9e0:	00005097          	auipc	ra,0x5
     9e4:	03a080e7          	jalr	58(ra) # 5a1a <exit>
      printf("%s: error: write bb %d new file failed\n", s, i);
     9e8:	00006517          	auipc	a0,0x6
     9ec:	8b850513          	add	a0,a0,-1864 # 62a0 <malloc+0x45c>
     9f0:	864a                	mv	a2,s2
     9f2:	85de                	mv	a1,s7
     9f4:	00005097          	auipc	ra,0x5
     9f8:	380080e7          	jalr	896(ra) # 5d74 <printf>
      exit(1);
     9fc:	4505                	li	a0,1
     9fe:	00005097          	auipc	ra,0x5
     a02:	01c080e7          	jalr	28(ra) # 5a1a <exit>
    printf("%s: error: open small failed!\n", s);
     a06:	00006517          	auipc	a0,0x6
     a0a:	8c250513          	add	a0,a0,-1854 # 62c8 <malloc+0x484>
     a0e:	85de                	mv	a1,s7
     a10:	00005097          	auipc	ra,0x5
     a14:	364080e7          	jalr	868(ra) # 5d74 <printf>
    exit(1);
     a18:	4505                	li	a0,1
     a1a:	00005097          	auipc	ra,0x5
     a1e:	000080e7          	jalr	ra # 5a1a <exit>
    printf("%s: read failed\n", s);
     a22:	00006517          	auipc	a0,0x6
     a26:	8c650513          	add	a0,a0,-1850 # 62e8 <malloc+0x4a4>
     a2a:	85de                	mv	a1,s7
     a2c:	00005097          	auipc	ra,0x5
     a30:	348080e7          	jalr	840(ra) # 5d74 <printf>
    exit(1);
     a34:	4505                	li	a0,1
     a36:	00005097          	auipc	ra,0x5
     a3a:	fe4080e7          	jalr	-28(ra) # 5a1a <exit>
    printf("%s: unlink small failed\n", s);
     a3e:	00006517          	auipc	a0,0x6
     a42:	8c250513          	add	a0,a0,-1854 # 6300 <malloc+0x4bc>
     a46:	85de                	mv	a1,s7
     a48:	00005097          	auipc	ra,0x5
     a4c:	32c080e7          	jalr	812(ra) # 5d74 <printf>
    exit(1);
     a50:	4505                	li	a0,1
     a52:	00005097          	auipc	ra,0x5
     a56:	fc8080e7          	jalr	-56(ra) # 5a1a <exit>
    printf("%s: error: creat small failed!\n", s);
     a5a:	00005517          	auipc	a0,0x5
     a5e:	7de50513          	add	a0,a0,2014 # 6238 <malloc+0x3f4>
     a62:	85de                	mv	a1,s7
     a64:	00005097          	auipc	ra,0x5
     a68:	310080e7          	jalr	784(ra) # 5d74 <printf>
    exit(1);
     a6c:	4505                	li	a0,1
     a6e:	00005097          	auipc	ra,0x5
     a72:	fac080e7          	jalr	-84(ra) # 5a1a <exit>

0000000000000a76 <writebig>:
{
     a76:	7139                	add	sp,sp,-64
     a78:	f822                	sd	s0,48(sp)
     a7a:	e456                	sd	s5,8(sp)
     a7c:	fc06                	sd	ra,56(sp)
     a7e:	f426                	sd	s1,40(sp)
     a80:	f04a                	sd	s2,32(sp)
     a82:	ec4e                	sd	s3,24(sp)
     a84:	e852                	sd	s4,16(sp)
     a86:	0080                	add	s0,sp,64
     a88:	8aaa                	mv	s5,a0
  fd = open("big", O_CREATE|O_RDWR);
     a8a:	20200593          	li	a1,514
     a8e:	00006517          	auipc	a0,0x6
     a92:	89250513          	add	a0,a0,-1902 # 6320 <malloc+0x4dc>
     a96:	00005097          	auipc	ra,0x5
     a9a:	fc4080e7          	jalr	-60(ra) # 5a5a <open>
  if(fd < 0){
     a9e:	14054b63          	bltz	a0,bf4 <writebig+0x17e>
     aa2:	89aa                	mv	s3,a0
     aa4:	4481                	li	s1,0
     aa6:	0000c917          	auipc	s2,0xc
     aaa:	1d290913          	add	s2,s2,466 # cc78 <buf>
     aae:	10c00a13          	li	s4,268
    if(write(fd, buf, BSIZE) != BSIZE){
     ab2:	40000613          	li	a2,1024
     ab6:	85ca                	mv	a1,s2
     ab8:	854e                	mv	a0,s3
    ((int*)buf)[0] = i;
     aba:	00992023          	sw	s1,0(s2)
    if(write(fd, buf, BSIZE) != BSIZE){
     abe:	00005097          	auipc	ra,0x5
     ac2:	f7c080e7          	jalr	-132(ra) # 5a3a <write>
     ac6:	40000793          	li	a5,1024
     aca:	08f51a63          	bne	a0,a5,b5e <writebig+0xe8>
  for(i = 0; i < MAXFILE; i++){
     ace:	2485                	addw	s1,s1,1
     ad0:	ff4491e3          	bne	s1,s4,ab2 <writebig+0x3c>
  close(fd);
     ad4:	854e                	mv	a0,s3
     ad6:	00005097          	auipc	ra,0x5
     ada:	f6c080e7          	jalr	-148(ra) # 5a42 <close>
  fd = open("big", O_RDONLY);
     ade:	4581                	li	a1,0
     ae0:	00006517          	auipc	a0,0x6
     ae4:	84050513          	add	a0,a0,-1984 # 6320 <malloc+0x4dc>
     ae8:	00005097          	auipc	ra,0x5
     aec:	f72080e7          	jalr	-142(ra) # 5a5a <open>
     af0:	89aa                	mv	s3,a0
  n = 0;
     af2:	4481                	li	s1,0
    i = read(fd, buf, BSIZE);
     af4:	0000ca17          	auipc	s4,0xc
     af8:	184a0a13          	add	s4,s4,388 # cc78 <buf>
  if(fd < 0){
     afc:	00055c63          	bgez	a0,b14 <writebig+0x9e>
     b00:	a8e1                	j	bd8 <writebig+0x162>
    } else if(i != BSIZE){
     b02:	40000793          	li	a5,1024
     b06:	08f51a63          	bne	a0,a5,b9a <writebig+0x124>
    if(((int*)buf)[0] != n){
     b0a:	00092683          	lw	a3,0(s2)
     b0e:	06969763          	bne	a3,s1,b7c <writebig+0x106>
    n++;
     b12:	2485                	addw	s1,s1,1
    i = read(fd, buf, BSIZE);
     b14:	40000613          	li	a2,1024
     b18:	85d2                	mv	a1,s4
     b1a:	854e                	mv	a0,s3
     b1c:	00005097          	auipc	ra,0x5
     b20:	f16080e7          	jalr	-234(ra) # 5a32 <read>
    if(i == 0){
     b24:	fd79                	bnez	a0,b02 <writebig+0x8c>
      if(n == MAXFILE - 1){
     b26:	10b00793          	li	a5,267
     b2a:	08f48763          	beq	s1,a5,bb8 <writebig+0x142>
  close(fd);
     b2e:	854e                	mv	a0,s3
     b30:	00005097          	auipc	ra,0x5
     b34:	f12080e7          	jalr	-238(ra) # 5a42 <close>
  if(unlink("big") < 0){
     b38:	00005517          	auipc	a0,0x5
     b3c:	7e850513          	add	a0,a0,2024 # 6320 <malloc+0x4dc>
     b40:	00005097          	auipc	ra,0x5
     b44:	f2a080e7          	jalr	-214(ra) # 5a6a <unlink>
     b48:	0c054463          	bltz	a0,c10 <writebig+0x19a>
}
     b4c:	70e2                	ld	ra,56(sp)
     b4e:	7442                	ld	s0,48(sp)
     b50:	74a2                	ld	s1,40(sp)
     b52:	7902                	ld	s2,32(sp)
     b54:	69e2                	ld	s3,24(sp)
     b56:	6a42                	ld	s4,16(sp)
     b58:	6aa2                	ld	s5,8(sp)
     b5a:	6121                	add	sp,sp,64
     b5c:	8082                	ret
      printf("%s: error: write big file failed\n", s, i);
     b5e:	00005517          	auipc	a0,0x5
     b62:	7ea50513          	add	a0,a0,2026 # 6348 <malloc+0x504>
     b66:	8626                	mv	a2,s1
     b68:	85d6                	mv	a1,s5
     b6a:	00005097          	auipc	ra,0x5
     b6e:	20a080e7          	jalr	522(ra) # 5d74 <printf>
      exit(1);
     b72:	4505                	li	a0,1
     b74:	00005097          	auipc	ra,0x5
     b78:	ea6080e7          	jalr	-346(ra) # 5a1a <exit>
      printf("%s: read content of block %d is %d\n", s,
     b7c:	00006517          	auipc	a0,0x6
     b80:	85450513          	add	a0,a0,-1964 # 63d0 <malloc+0x58c>
     b84:	8626                	mv	a2,s1
     b86:	85d6                	mv	a1,s5
     b88:	00005097          	auipc	ra,0x5
     b8c:	1ec080e7          	jalr	492(ra) # 5d74 <printf>
      exit(1);
     b90:	4505                	li	a0,1
     b92:	00005097          	auipc	ra,0x5
     b96:	e88080e7          	jalr	-376(ra) # 5a1a <exit>
      printf("%s: read failed %d\n", s, i);
     b9a:	862a                	mv	a2,a0
     b9c:	85d6                	mv	a1,s5
     b9e:	00006517          	auipc	a0,0x6
     ba2:	81a50513          	add	a0,a0,-2022 # 63b8 <malloc+0x574>
     ba6:	00005097          	auipc	ra,0x5
     baa:	1ce080e7          	jalr	462(ra) # 5d74 <printf>
      exit(1);
     bae:	4505                	li	a0,1
     bb0:	00005097          	auipc	ra,0x5
     bb4:	e6a080e7          	jalr	-406(ra) # 5a1a <exit>
        printf("%s: read only %d blocks from big", s, n);
     bb8:	00005517          	auipc	a0,0x5
     bbc:	7d850513          	add	a0,a0,2008 # 6390 <malloc+0x54c>
     bc0:	10b00613          	li	a2,267
     bc4:	85d6                	mv	a1,s5
     bc6:	00005097          	auipc	ra,0x5
     bca:	1ae080e7          	jalr	430(ra) # 5d74 <printf>
        exit(1);
     bce:	4505                	li	a0,1
     bd0:	00005097          	auipc	ra,0x5
     bd4:	e4a080e7          	jalr	-438(ra) # 5a1a <exit>
    printf("%s: error: open big failed!\n", s);
     bd8:	00005517          	auipc	a0,0x5
     bdc:	79850513          	add	a0,a0,1944 # 6370 <malloc+0x52c>
     be0:	85d6                	mv	a1,s5
     be2:	00005097          	auipc	ra,0x5
     be6:	192080e7          	jalr	402(ra) # 5d74 <printf>
    exit(1);
     bea:	4505                	li	a0,1
     bec:	00005097          	auipc	ra,0x5
     bf0:	e2e080e7          	jalr	-466(ra) # 5a1a <exit>
    printf("%s: error: creat big failed!\n", s);
     bf4:	00005517          	auipc	a0,0x5
     bf8:	73450513          	add	a0,a0,1844 # 6328 <malloc+0x4e4>
     bfc:	85d6                	mv	a1,s5
     bfe:	00005097          	auipc	ra,0x5
     c02:	176080e7          	jalr	374(ra) # 5d74 <printf>
    exit(1);
     c06:	4505                	li	a0,1
     c08:	00005097          	auipc	ra,0x5
     c0c:	e12080e7          	jalr	-494(ra) # 5a1a <exit>
    printf("%s: unlink big failed\n", s);
     c10:	00005517          	auipc	a0,0x5
     c14:	7e850513          	add	a0,a0,2024 # 63f8 <malloc+0x5b4>
     c18:	85d6                	mv	a1,s5
     c1a:	00005097          	auipc	ra,0x5
     c1e:	15a080e7          	jalr	346(ra) # 5d74 <printf>
    exit(1);
     c22:	4505                	li	a0,1
     c24:	00005097          	auipc	ra,0x5
     c28:	df6080e7          	jalr	-522(ra) # 5a1a <exit>

0000000000000c2c <unlinkread>:
{
     c2c:	7179                	add	sp,sp,-48
     c2e:	f022                	sd	s0,32(sp)
     c30:	e44e                	sd	s3,8(sp)
     c32:	f406                	sd	ra,40(sp)
     c34:	ec26                	sd	s1,24(sp)
     c36:	e84a                	sd	s2,16(sp)
     c38:	1800                	add	s0,sp,48
     c3a:	89aa                	mv	s3,a0
  fd = open("unlinkread", O_CREATE | O_RDWR);
     c3c:	20200593          	li	a1,514
     c40:	00005517          	auipc	a0,0x5
     c44:	7d050513          	add	a0,a0,2000 # 6410 <malloc+0x5cc>
     c48:	00005097          	auipc	ra,0x5
     c4c:	e12080e7          	jalr	-494(ra) # 5a5a <open>
  if(fd < 0){
     c50:	0e054363          	bltz	a0,d36 <unlinkread+0x10a>
  write(fd, "hello", SZ);
     c54:	4615                	li	a2,5
     c56:	00005597          	auipc	a1,0x5
     c5a:	7ea58593          	add	a1,a1,2026 # 6440 <malloc+0x5fc>
     c5e:	84aa                	mv	s1,a0
     c60:	00005097          	auipc	ra,0x5
     c64:	dda080e7          	jalr	-550(ra) # 5a3a <write>
  close(fd);
     c68:	8526                	mv	a0,s1
     c6a:	00005097          	auipc	ra,0x5
     c6e:	dd8080e7          	jalr	-552(ra) # 5a42 <close>
  fd = open("unlinkread", O_RDWR);
     c72:	4589                	li	a1,2
     c74:	00005517          	auipc	a0,0x5
     c78:	79c50513          	add	a0,a0,1948 # 6410 <malloc+0x5cc>
     c7c:	00005097          	auipc	ra,0x5
     c80:	dde080e7          	jalr	-546(ra) # 5a5a <open>
     c84:	84aa                	mv	s1,a0
  if(fd < 0){
     c86:	12054e63          	bltz	a0,dc2 <unlinkread+0x196>
  if(unlink("unlinkread") != 0){
     c8a:	00005517          	auipc	a0,0x5
     c8e:	78650513          	add	a0,a0,1926 # 6410 <malloc+0x5cc>
     c92:	00005097          	auipc	ra,0x5
     c96:	dd8080e7          	jalr	-552(ra) # 5a6a <unlink>
     c9a:	10051663          	bnez	a0,da6 <unlinkread+0x17a>
  fd1 = open("unlinkread", O_CREATE | O_RDWR);
     c9e:	20200593          	li	a1,514
     ca2:	00005517          	auipc	a0,0x5
     ca6:	76e50513          	add	a0,a0,1902 # 6410 <malloc+0x5cc>
     caa:	00005097          	auipc	ra,0x5
     cae:	db0080e7          	jalr	-592(ra) # 5a5a <open>
  write(fd1, "yyy", 3);
     cb2:	460d                	li	a2,3
     cb4:	00005597          	auipc	a1,0x5
     cb8:	7d458593          	add	a1,a1,2004 # 6488 <malloc+0x644>
  fd1 = open("unlinkread", O_CREATE | O_RDWR);
     cbc:	892a                	mv	s2,a0
  write(fd1, "yyy", 3);
     cbe:	00005097          	auipc	ra,0x5
     cc2:	d7c080e7          	jalr	-644(ra) # 5a3a <write>
  close(fd1);
     cc6:	854a                	mv	a0,s2
     cc8:	00005097          	auipc	ra,0x5
     ccc:	d7a080e7          	jalr	-646(ra) # 5a42 <close>
  if(read(fd, buf, sizeof(buf)) != SZ){
     cd0:	660d                	lui	a2,0x3
     cd2:	0000c597          	auipc	a1,0xc
     cd6:	fa658593          	add	a1,a1,-90 # cc78 <buf>
     cda:	8526                	mv	a0,s1
     cdc:	00005097          	auipc	ra,0x5
     ce0:	d56080e7          	jalr	-682(ra) # 5a32 <read>
     ce4:	4795                	li	a5,5
     ce6:	0af51263          	bne	a0,a5,d8a <unlinkread+0x15e>
  if(buf[0] != 'h'){
     cea:	0000c597          	auipc	a1,0xc
     cee:	f8e58593          	add	a1,a1,-114 # cc78 <buf>
     cf2:	0005c703          	lbu	a4,0(a1)
     cf6:	06800793          	li	a5,104
     cfa:	06f71a63          	bne	a4,a5,d6e <unlinkread+0x142>
  if(write(fd, buf, 10) != 10){
     cfe:	4629                	li	a2,10
     d00:	8526                	mv	a0,s1
     d02:	00005097          	auipc	ra,0x5
     d06:	d38080e7          	jalr	-712(ra) # 5a3a <write>
     d0a:	47a9                	li	a5,10
     d0c:	04f51363          	bne	a0,a5,d52 <unlinkread+0x126>
  close(fd);
     d10:	8526                	mv	a0,s1
     d12:	00005097          	auipc	ra,0x5
     d16:	d30080e7          	jalr	-720(ra) # 5a42 <close>
}
     d1a:	7402                	ld	s0,32(sp)
     d1c:	70a2                	ld	ra,40(sp)
     d1e:	64e2                	ld	s1,24(sp)
     d20:	6942                	ld	s2,16(sp)
     d22:	69a2                	ld	s3,8(sp)
  unlink("unlinkread");
     d24:	00005517          	auipc	a0,0x5
     d28:	6ec50513          	add	a0,a0,1772 # 6410 <malloc+0x5cc>
}
     d2c:	6145                	add	sp,sp,48
  unlink("unlinkread");
     d2e:	00005317          	auipc	t1,0x5
     d32:	d3c30067          	jr	-708(t1) # 5a6a <unlink>
    printf("%s: create unlinkread failed\n", s);
     d36:	00005517          	auipc	a0,0x5
     d3a:	6ea50513          	add	a0,a0,1770 # 6420 <malloc+0x5dc>
     d3e:	85ce                	mv	a1,s3
     d40:	00005097          	auipc	ra,0x5
     d44:	034080e7          	jalr	52(ra) # 5d74 <printf>
    exit(1);
     d48:	4505                	li	a0,1
     d4a:	00005097          	auipc	ra,0x5
     d4e:	cd0080e7          	jalr	-816(ra) # 5a1a <exit>
    printf("%s: unlinkread write failed\n", s);
     d52:	00005517          	auipc	a0,0x5
     d56:	77e50513          	add	a0,a0,1918 # 64d0 <malloc+0x68c>
     d5a:	85ce                	mv	a1,s3
     d5c:	00005097          	auipc	ra,0x5
     d60:	018080e7          	jalr	24(ra) # 5d74 <printf>
    exit(1);
     d64:	4505                	li	a0,1
     d66:	00005097          	auipc	ra,0x5
     d6a:	cb4080e7          	jalr	-844(ra) # 5a1a <exit>
    printf("%s: unlinkread wrong data\n", s);
     d6e:	00005517          	auipc	a0,0x5
     d72:	74250513          	add	a0,a0,1858 # 64b0 <malloc+0x66c>
     d76:	85ce                	mv	a1,s3
     d78:	00005097          	auipc	ra,0x5
     d7c:	ffc080e7          	jalr	-4(ra) # 5d74 <printf>
    exit(1);
     d80:	4505                	li	a0,1
     d82:	00005097          	auipc	ra,0x5
     d86:	c98080e7          	jalr	-872(ra) # 5a1a <exit>
    printf("%s: unlinkread read failed", s);
     d8a:	00005517          	auipc	a0,0x5
     d8e:	70650513          	add	a0,a0,1798 # 6490 <malloc+0x64c>
     d92:	85ce                	mv	a1,s3
     d94:	00005097          	auipc	ra,0x5
     d98:	fe0080e7          	jalr	-32(ra) # 5d74 <printf>
    exit(1);
     d9c:	4505                	li	a0,1
     d9e:	00005097          	auipc	ra,0x5
     da2:	c7c080e7          	jalr	-900(ra) # 5a1a <exit>
    printf("%s: unlink unlinkread failed\n", s);
     da6:	00005517          	auipc	a0,0x5
     daa:	6c250513          	add	a0,a0,1730 # 6468 <malloc+0x624>
     dae:	85ce                	mv	a1,s3
     db0:	00005097          	auipc	ra,0x5
     db4:	fc4080e7          	jalr	-60(ra) # 5d74 <printf>
    exit(1);
     db8:	4505                	li	a0,1
     dba:	00005097          	auipc	ra,0x5
     dbe:	c60080e7          	jalr	-928(ra) # 5a1a <exit>
    printf("%s: open unlinkread failed\n", s);
     dc2:	00005517          	auipc	a0,0x5
     dc6:	68650513          	add	a0,a0,1670 # 6448 <malloc+0x604>
     dca:	85ce                	mv	a1,s3
     dcc:	00005097          	auipc	ra,0x5
     dd0:	fa8080e7          	jalr	-88(ra) # 5d74 <printf>
    exit(1);
     dd4:	4505                	li	a0,1
     dd6:	00005097          	auipc	ra,0x5
     dda:	c44080e7          	jalr	-956(ra) # 5a1a <exit>

0000000000000dde <linktest>:
{
     dde:	7179                	add	sp,sp,-48
     de0:	f406                	sd	ra,40(sp)
     de2:	f022                	sd	s0,32(sp)
     de4:	e44e                	sd	s3,8(sp)
     de6:	1800                	add	s0,sp,48
     de8:	ec26                	sd	s1,24(sp)
     dea:	e84a                	sd	s2,16(sp)
     dec:	89aa                	mv	s3,a0
  unlink("lf1");
     dee:	00005517          	auipc	a0,0x5
     df2:	70250513          	add	a0,a0,1794 # 64f0 <malloc+0x6ac>
     df6:	00005097          	auipc	ra,0x5
     dfa:	c74080e7          	jalr	-908(ra) # 5a6a <unlink>
  unlink("lf2");
     dfe:	00005517          	auipc	a0,0x5
     e02:	6fa50513          	add	a0,a0,1786 # 64f8 <malloc+0x6b4>
     e06:	00005097          	auipc	ra,0x5
     e0a:	c64080e7          	jalr	-924(ra) # 5a6a <unlink>
  fd = open("lf1", O_CREATE|O_RDWR);
     e0e:	20200593          	li	a1,514
     e12:	00005517          	auipc	a0,0x5
     e16:	6de50513          	add	a0,a0,1758 # 64f0 <malloc+0x6ac>
     e1a:	00005097          	auipc	ra,0x5
     e1e:	c40080e7          	jalr	-960(ra) # 5a5a <open>
  if(fd < 0){
     e22:	10054863          	bltz	a0,f32 <linktest+0x154>
  if(write(fd, "hello", SZ) != SZ){
     e26:	4615                	li	a2,5
     e28:	00005597          	auipc	a1,0x5
     e2c:	61858593          	add	a1,a1,1560 # 6440 <malloc+0x5fc>
     e30:	84aa                	mv	s1,a0
     e32:	00005097          	auipc	ra,0x5
     e36:	c08080e7          	jalr	-1016(ra) # 5a3a <write>
     e3a:	4795                	li	a5,5
     e3c:	892a                	mv	s2,a0
     e3e:	1cf51a63          	bne	a0,a5,1012 <linktest+0x234>
  close(fd);
     e42:	8526                	mv	a0,s1
     e44:	00005097          	auipc	ra,0x5
     e48:	bfe080e7          	jalr	-1026(ra) # 5a42 <close>
  if(link("lf1", "lf2") < 0){
     e4c:	00005597          	auipc	a1,0x5
     e50:	6ac58593          	add	a1,a1,1708 # 64f8 <malloc+0x6b4>
     e54:	00005517          	auipc	a0,0x5
     e58:	69c50513          	add	a0,a0,1692 # 64f0 <malloc+0x6ac>
     e5c:	00005097          	auipc	ra,0x5
     e60:	c1e080e7          	jalr	-994(ra) # 5a7a <link>
     e64:	18054963          	bltz	a0,ff6 <linktest+0x218>
  unlink("lf1");
     e68:	00005517          	auipc	a0,0x5
     e6c:	68850513          	add	a0,a0,1672 # 64f0 <malloc+0x6ac>
     e70:	00005097          	auipc	ra,0x5
     e74:	bfa080e7          	jalr	-1030(ra) # 5a6a <unlink>
  if(open("lf1", 0) >= 0){
     e78:	4581                	li	a1,0
     e7a:	00005517          	auipc	a0,0x5
     e7e:	67650513          	add	a0,a0,1654 # 64f0 <malloc+0x6ac>
     e82:	00005097          	auipc	ra,0x5
     e86:	bd8080e7          	jalr	-1064(ra) # 5a5a <open>
     e8a:	14055863          	bgez	a0,fda <linktest+0x1fc>
  fd = open("lf2", 0);
     e8e:	4581                	li	a1,0
     e90:	00005517          	auipc	a0,0x5
     e94:	66850513          	add	a0,a0,1640 # 64f8 <malloc+0x6b4>
     e98:	00005097          	auipc	ra,0x5
     e9c:	bc2080e7          	jalr	-1086(ra) # 5a5a <open>
     ea0:	84aa                	mv	s1,a0
  if(fd < 0){
     ea2:	10054e63          	bltz	a0,fbe <linktest+0x1e0>
  if(read(fd, buf, sizeof(buf)) != SZ){
     ea6:	660d                	lui	a2,0x3
     ea8:	0000c597          	auipc	a1,0xc
     eac:	dd058593          	add	a1,a1,-560 # cc78 <buf>
     eb0:	00005097          	auipc	ra,0x5
     eb4:	b82080e7          	jalr	-1150(ra) # 5a32 <read>
     eb8:	0f251563          	bne	a0,s2,fa2 <linktest+0x1c4>
  close(fd);
     ebc:	8526                	mv	a0,s1
     ebe:	00005097          	auipc	ra,0x5
     ec2:	b84080e7          	jalr	-1148(ra) # 5a42 <close>
  if(link("lf2", "lf2") >= 0){
     ec6:	00005597          	auipc	a1,0x5
     eca:	63258593          	add	a1,a1,1586 # 64f8 <malloc+0x6b4>
     ece:	852e                	mv	a0,a1
     ed0:	00005097          	auipc	ra,0x5
     ed4:	baa080e7          	jalr	-1110(ra) # 5a7a <link>
     ed8:	0a055763          	bgez	a0,f86 <linktest+0x1a8>
  unlink("lf2");
     edc:	00005517          	auipc	a0,0x5
     ee0:	61c50513          	add	a0,a0,1564 # 64f8 <malloc+0x6b4>
     ee4:	00005097          	auipc	ra,0x5
     ee8:	b86080e7          	jalr	-1146(ra) # 5a6a <unlink>
  if(link("lf2", "lf1") >= 0){
     eec:	00005597          	auipc	a1,0x5
     ef0:	60458593          	add	a1,a1,1540 # 64f0 <malloc+0x6ac>
     ef4:	00005517          	auipc	a0,0x5
     ef8:	60450513          	add	a0,a0,1540 # 64f8 <malloc+0x6b4>
     efc:	00005097          	auipc	ra,0x5
     f00:	b7e080e7          	jalr	-1154(ra) # 5a7a <link>
     f04:	06055363          	bgez	a0,f6a <linktest+0x18c>
  if(link(".", "lf1") >= 0){
     f08:	00005597          	auipc	a1,0x5
     f0c:	5e858593          	add	a1,a1,1512 # 64f0 <malloc+0x6ac>
     f10:	00005517          	auipc	a0,0x5
     f14:	6f050513          	add	a0,a0,1776 # 6600 <malloc+0x7bc>
     f18:	00005097          	auipc	ra,0x5
     f1c:	b62080e7          	jalr	-1182(ra) # 5a7a <link>
     f20:	02055763          	bgez	a0,f4e <linktest+0x170>
}
     f24:	70a2                	ld	ra,40(sp)
     f26:	7402                	ld	s0,32(sp)
     f28:	64e2                	ld	s1,24(sp)
     f2a:	6942                	ld	s2,16(sp)
     f2c:	69a2                	ld	s3,8(sp)
     f2e:	6145                	add	sp,sp,48
     f30:	8082                	ret
    printf("%s: create lf1 failed\n", s);
     f32:	00005517          	auipc	a0,0x5
     f36:	5ce50513          	add	a0,a0,1486 # 6500 <malloc+0x6bc>
     f3a:	85ce                	mv	a1,s3
     f3c:	00005097          	auipc	ra,0x5
     f40:	e38080e7          	jalr	-456(ra) # 5d74 <printf>
    exit(1);
     f44:	4505                	li	a0,1
     f46:	00005097          	auipc	ra,0x5
     f4a:	ad4080e7          	jalr	-1324(ra) # 5a1a <exit>
    printf("%s: link . lf1 succeeded! oops\n", s);
     f4e:	00005517          	auipc	a0,0x5
     f52:	6ba50513          	add	a0,a0,1722 # 6608 <malloc+0x7c4>
     f56:	85ce                	mv	a1,s3
     f58:	00005097          	auipc	ra,0x5
     f5c:	e1c080e7          	jalr	-484(ra) # 5d74 <printf>
    exit(1);
     f60:	4505                	li	a0,1
     f62:	00005097          	auipc	ra,0x5
     f66:	ab8080e7          	jalr	-1352(ra) # 5a1a <exit>
    printf("%s: link non-existent succeeded! oops\n", s);
     f6a:	00005517          	auipc	a0,0x5
     f6e:	66e50513          	add	a0,a0,1646 # 65d8 <malloc+0x794>
     f72:	85ce                	mv	a1,s3
     f74:	00005097          	auipc	ra,0x5
     f78:	e00080e7          	jalr	-512(ra) # 5d74 <printf>
    exit(1);
     f7c:	4505                	li	a0,1
     f7e:	00005097          	auipc	ra,0x5
     f82:	a9c080e7          	jalr	-1380(ra) # 5a1a <exit>
    printf("%s: link lf2 lf2 succeeded! oops\n", s);
     f86:	00005517          	auipc	a0,0x5
     f8a:	62a50513          	add	a0,a0,1578 # 65b0 <malloc+0x76c>
     f8e:	85ce                	mv	a1,s3
     f90:	00005097          	auipc	ra,0x5
     f94:	de4080e7          	jalr	-540(ra) # 5d74 <printf>
    exit(1);
     f98:	4505                	li	a0,1
     f9a:	00005097          	auipc	ra,0x5
     f9e:	a80080e7          	jalr	-1408(ra) # 5a1a <exit>
    printf("%s: read lf2 failed\n", s);
     fa2:	00005517          	auipc	a0,0x5
     fa6:	5f650513          	add	a0,a0,1526 # 6598 <malloc+0x754>
     faa:	85ce                	mv	a1,s3
     fac:	00005097          	auipc	ra,0x5
     fb0:	dc8080e7          	jalr	-568(ra) # 5d74 <printf>
    exit(1);
     fb4:	4505                	li	a0,1
     fb6:	00005097          	auipc	ra,0x5
     fba:	a64080e7          	jalr	-1436(ra) # 5a1a <exit>
    printf("%s: open lf2 failed\n", s);
     fbe:	00005517          	auipc	a0,0x5
     fc2:	5c250513          	add	a0,a0,1474 # 6580 <malloc+0x73c>
     fc6:	85ce                	mv	a1,s3
     fc8:	00005097          	auipc	ra,0x5
     fcc:	dac080e7          	jalr	-596(ra) # 5d74 <printf>
    exit(1);
     fd0:	4505                	li	a0,1
     fd2:	00005097          	auipc	ra,0x5
     fd6:	a48080e7          	jalr	-1464(ra) # 5a1a <exit>
    printf("%s: unlinked lf1 but it is still there!\n", s);
     fda:	00005517          	auipc	a0,0x5
     fde:	57650513          	add	a0,a0,1398 # 6550 <malloc+0x70c>
     fe2:	85ce                	mv	a1,s3
     fe4:	00005097          	auipc	ra,0x5
     fe8:	d90080e7          	jalr	-624(ra) # 5d74 <printf>
    exit(1);
     fec:	4505                	li	a0,1
     fee:	00005097          	auipc	ra,0x5
     ff2:	a2c080e7          	jalr	-1492(ra) # 5a1a <exit>
    printf("%s: link lf1 lf2 failed\n", s);
     ff6:	00005517          	auipc	a0,0x5
     ffa:	53a50513          	add	a0,a0,1338 # 6530 <malloc+0x6ec>
     ffe:	85ce                	mv	a1,s3
    1000:	00005097          	auipc	ra,0x5
    1004:	d74080e7          	jalr	-652(ra) # 5d74 <printf>
    exit(1);
    1008:	4505                	li	a0,1
    100a:	00005097          	auipc	ra,0x5
    100e:	a10080e7          	jalr	-1520(ra) # 5a1a <exit>
    printf("%s: write lf1 failed\n", s);
    1012:	00005517          	auipc	a0,0x5
    1016:	50650513          	add	a0,a0,1286 # 6518 <malloc+0x6d4>
    101a:	85ce                	mv	a1,s3
    101c:	00005097          	auipc	ra,0x5
    1020:	d58080e7          	jalr	-680(ra) # 5d74 <printf>
    exit(1);
    1024:	4505                	li	a0,1
    1026:	00005097          	auipc	ra,0x5
    102a:	9f4080e7          	jalr	-1548(ra) # 5a1a <exit>

000000000000102e <pgbug>:
{
    102e:	7179                	add	sp,sp,-48
    1030:	f406                	sd	ra,40(sp)
    1032:	f022                	sd	s0,32(sp)
    1034:	ec26                	sd	s1,24(sp)
    1036:	1800                	add	s0,sp,48
  exec(big, argv);
    1038:	00008497          	auipc	s1,0x8
    103c:	fc848493          	add	s1,s1,-56 # 9000 <big>
    1040:	6088                	ld	a0,0(s1)
    1042:	fd840593          	add	a1,s0,-40
  argv[0] = 0;
    1046:	fc043c23          	sd	zero,-40(s0)
  exec(big, argv);
    104a:	00005097          	auipc	ra,0x5
    104e:	a08080e7          	jalr	-1528(ra) # 5a52 <exec>
  pipe(big);
    1052:	6088                	ld	a0,0(s1)
    1054:	00005097          	auipc	ra,0x5
    1058:	9d6080e7          	jalr	-1578(ra) # 5a2a <pipe>
  exit(0);
    105c:	4501                	li	a0,0
    105e:	00005097          	auipc	ra,0x5
    1062:	9bc080e7          	jalr	-1604(ra) # 5a1a <exit>

0000000000001066 <badarg>:
{
    1066:	7139                	add	sp,sp,-64
    1068:	f822                	sd	s0,48(sp)
    106a:	f426                	sd	s1,40(sp)
    106c:	f04a                	sd	s2,32(sp)
    106e:	ec4e                	sd	s3,24(sp)
    1070:	fc06                	sd	ra,56(sp)
    1072:	0080                	add	s0,sp,64
    1074:	64b1                	lui	s1,0xc
    argv[0] = (char*)0xffffffff;
    1076:	597d                	li	s2,-1
{
    1078:	35048493          	add	s1,s1,848 # c350 <uninit+0x1de8>
    argv[0] = (char*)0xffffffff;
    107c:	02095913          	srl	s2,s2,0x20
    exec("echo", argv);
    1080:	00005997          	auipc	s3,0x5
    1084:	5a898993          	add	s3,s3,1448 # 6628 <malloc+0x7e4>
    1088:	fc040593          	add	a1,s0,-64
    108c:	854e                	mv	a0,s3
  for(int i = 0; i < 50000; i++){
    108e:	34fd                	addw	s1,s1,-1
    argv[0] = (char*)0xffffffff;
    1090:	fd243023          	sd	s2,-64(s0)
    argv[1] = 0;
    1094:	fc043423          	sd	zero,-56(s0)
    exec("echo", argv);
    1098:	00005097          	auipc	ra,0x5
    109c:	9ba080e7          	jalr	-1606(ra) # 5a52 <exec>
  for(int i = 0; i < 50000; i++){
    10a0:	f4e5                	bnez	s1,1088 <badarg+0x22>
  exit(0);
    10a2:	4501                	li	a0,0
    10a4:	00005097          	auipc	ra,0x5
    10a8:	976080e7          	jalr	-1674(ra) # 5a1a <exit>

00000000000010ac <copyinstr2>:
{
    10ac:	7151                	add	sp,sp,-240
    10ae:	f1a2                	sd	s0,224(sp)
    10b0:	e5ce                	sd	s3,200(sp)
    10b2:	1980                	add	s0,sp,240
    10b4:	f586                	sd	ra,232(sp)
    10b6:	eda6                	sd	s1,216(sp)
    10b8:	e9ca                	sd	s2,208(sp)
    10ba:	00005997          	auipc	s3,0x5
    10be:	e8698993          	add	s3,s3,-378 # 5f40 <malloc+0xfc>
    b[i] = 'x';
    10c2:	0009b683          	ld	a3,0(s3)
    10c6:	f4840793          	add	a5,s0,-184
    10ca:	fc840713          	add	a4,s0,-56
    10ce:	e394                	sd	a3,0(a5)
  for(int i = 0; i < MAXPATH; i++)
    10d0:	07a1                	add	a5,a5,8
    10d2:	fee79ee3          	bne	a5,a4,10ce <copyinstr2+0x22>
  int ret = unlink(b);
    10d6:	f4840513          	add	a0,s0,-184
  b[MAXPATH] = '\0';
    10da:	fc040423          	sb	zero,-56(s0)
  int ret = unlink(b);
    10de:	00005097          	auipc	ra,0x5
    10e2:	98c080e7          	jalr	-1652(ra) # 5a6a <unlink>
  if(ret != -1){
    10e6:	57fd                	li	a5,-1
  int ret = unlink(b);
    10e8:	84aa                	mv	s1,a0
  if(ret != -1){
    10ea:	12f51563          	bne	a0,a5,1214 <copyinstr2+0x168>
  int fd = open(b, O_CREATE | O_WRONLY);
    10ee:	20100593          	li	a1,513
    10f2:	f4840513          	add	a0,s0,-184
    10f6:	00005097          	auipc	ra,0x5
    10fa:	964080e7          	jalr	-1692(ra) # 5a5a <open>
    10fe:	892a                	mv	s2,a0
  if(fd != -1){
    1100:	18951863          	bne	a0,s1,1290 <copyinstr2+0x1e4>
  ret = link(b, b);
    1104:	f4840593          	add	a1,s0,-184
    1108:	852e                	mv	a0,a1
    110a:	00005097          	auipc	ra,0x5
    110e:	970080e7          	jalr	-1680(ra) # 5a7a <link>
    1112:	84aa                	mv	s1,a0
  if(ret != -1){
    1114:	15251d63          	bne	a0,s2,126e <copyinstr2+0x1c2>
  char *args[] = { "xx", 0 };
    1118:	00006797          	auipc	a5,0x6
    111c:	74878793          	add	a5,a5,1864 # 7860 <malloc+0x1a1c>
  ret = exec(b, args);
    1120:	f1840593          	add	a1,s0,-232
    1124:	f4840513          	add	a0,s0,-184
  char *args[] = { "xx", 0 };
    1128:	f0f43c23          	sd	a5,-232(s0)
    112c:	f2043023          	sd	zero,-224(s0)
  ret = exec(b, args);
    1130:	00005097          	auipc	ra,0x5
    1134:	922080e7          	jalr	-1758(ra) # 5a52 <exec>
  if(ret != -1){
    1138:	10951b63          	bne	a0,s1,124e <copyinstr2+0x1a2>
  int pid = fork();
    113c:	00005097          	auipc	ra,0x5
    1140:	8d6080e7          	jalr	-1834(ra) # 5a12 <fork>
  if(pid < 0){
    1144:	0e054863          	bltz	a0,1234 <copyinstr2+0x188>
  if(pid == 0){
    1148:	e541                	bnez	a0,11d0 <copyinstr2+0x124>
      big[i] = 'x';
    114a:	0009b683          	ld	a3,0(s3)
    114e:	00008797          	auipc	a5,0x8
    1152:	41278793          	add	a5,a5,1042 # 9560 <big.0>
    1156:	00009717          	auipc	a4,0x9
    115a:	40a70713          	add	a4,a4,1034 # a560 <big.0+0x1000>
    115e:	e394                	sd	a3,0(a5)
    for(int i = 0; i < PGSIZE; i++)
    1160:	07a1                	add	a5,a5,8
    1162:	fee79ee3          	bne	a5,a4,115e <copyinstr2+0xb2>
    char *args2[] = { big, big, big, 0 };
    1166:	00007797          	auipc	a5,0x7
    116a:	24a78793          	add	a5,a5,586 # 83b0 <malloc+0x256c>
    116e:	6390                	ld	a2,0(a5)
    1170:	6794                	ld	a3,8(a5)
    1172:	6b98                	ld	a4,16(a5)
    1174:	6f9c                	ld	a5,24(a5)
    ret = exec("echo", args2);
    1176:	f2840593          	add	a1,s0,-216
    117a:	00005517          	auipc	a0,0x5
    117e:	4ae50513          	add	a0,a0,1198 # 6628 <malloc+0x7e4>
    char *args2[] = { big, big, big, 0 };
    1182:	f4f43023          	sd	a5,-192(s0)
    big[PGSIZE] = '\0';
    1186:	00009817          	auipc	a6,0x9
    118a:	3c080d23          	sb	zero,986(a6) # a560 <big.0+0x1000>
    char *args2[] = { big, big, big, 0 };
    118e:	f2c43423          	sd	a2,-216(s0)
    1192:	f2d43823          	sd	a3,-208(s0)
    1196:	f2e43c23          	sd	a4,-200(s0)
    ret = exec("echo", args2);
    119a:	00005097          	auipc	ra,0x5
    119e:	8b8080e7          	jalr	-1864(ra) # 5a52 <exec>
    if(ret != -1){
    11a2:	57fd                	li	a5,-1
    11a4:	02f50063          	beq	a0,a5,11c4 <copyinstr2+0x118>
      printf("exec(echo, BIG) returned %d, not -1\n", fd);
    11a8:	00005517          	auipc	a0,0x5
    11ac:	51050513          	add	a0,a0,1296 # 66b8 <malloc+0x874>
    11b0:	55fd                	li	a1,-1
    11b2:	00005097          	auipc	ra,0x5
    11b6:	bc2080e7          	jalr	-1086(ra) # 5d74 <printf>
      exit(1);
    11ba:	4505                	li	a0,1
    11bc:	00005097          	auipc	ra,0x5
    11c0:	85e080e7          	jalr	-1954(ra) # 5a1a <exit>
    exit(747); // OK
    11c4:	2eb00513          	li	a0,747
    11c8:	00005097          	auipc	ra,0x5
    11cc:	852080e7          	jalr	-1966(ra) # 5a1a <exit>
  wait(&st);
    11d0:	f2840513          	add	a0,s0,-216
  int st = 0;
    11d4:	f2042423          	sw	zero,-216(s0)
  wait(&st);
    11d8:	00005097          	auipc	ra,0x5
    11dc:	84a080e7          	jalr	-1974(ra) # 5a22 <wait>
  if(st != 747){
    11e0:	f2842703          	lw	a4,-216(s0)
    11e4:	2eb00793          	li	a5,747
    11e8:	00f71963          	bne	a4,a5,11fa <copyinstr2+0x14e>
}
    11ec:	70ae                	ld	ra,232(sp)
    11ee:	740e                	ld	s0,224(sp)
    11f0:	64ee                	ld	s1,216(sp)
    11f2:	694e                	ld	s2,208(sp)
    11f4:	69ae                	ld	s3,200(sp)
    11f6:	616d                	add	sp,sp,240
    11f8:	8082                	ret
    printf("exec(echo, BIG) succeeded, should have failed\n");
    11fa:	00005517          	auipc	a0,0x5
    11fe:	4e650513          	add	a0,a0,1254 # 66e0 <malloc+0x89c>
    1202:	00005097          	auipc	ra,0x5
    1206:	b72080e7          	jalr	-1166(ra) # 5d74 <printf>
    exit(1);
    120a:	4505                	li	a0,1
    120c:	00005097          	auipc	ra,0x5
    1210:	80e080e7          	jalr	-2034(ra) # 5a1a <exit>
    printf("unlink(%s) returned %d, not -1\n", b, ret);
    1214:	862a                	mv	a2,a0
    1216:	f4840593          	add	a1,s0,-184
    121a:	00005517          	auipc	a0,0x5
    121e:	41650513          	add	a0,a0,1046 # 6630 <malloc+0x7ec>
    1222:	00005097          	auipc	ra,0x5
    1226:	b52080e7          	jalr	-1198(ra) # 5d74 <printf>
    exit(1);
    122a:	4505                	li	a0,1
    122c:	00004097          	auipc	ra,0x4
    1230:	7ee080e7          	jalr	2030(ra) # 5a1a <exit>
    printf("fork failed\n");
    1234:	00006517          	auipc	a0,0x6
    1238:	8e450513          	add	a0,a0,-1820 # 6b18 <malloc+0xcd4>
    123c:	00005097          	auipc	ra,0x5
    1240:	b38080e7          	jalr	-1224(ra) # 5d74 <printf>
    exit(1);
    1244:	4505                	li	a0,1
    1246:	00004097          	auipc	ra,0x4
    124a:	7d4080e7          	jalr	2004(ra) # 5a1a <exit>
    printf("exec(%s) returned %d, not -1\n", b, fd);
    124e:	00005517          	auipc	a0,0x5
    1252:	44a50513          	add	a0,a0,1098 # 6698 <malloc+0x854>
    1256:	567d                	li	a2,-1
    1258:	f4840593          	add	a1,s0,-184
    125c:	00005097          	auipc	ra,0x5
    1260:	b18080e7          	jalr	-1256(ra) # 5d74 <printf>
    exit(1);
    1264:	4505                	li	a0,1
    1266:	00004097          	auipc	ra,0x4
    126a:	7b4080e7          	jalr	1972(ra) # 5a1a <exit>
    printf("link(%s, %s) returned %d, not -1\n", b, b, ret);
    126e:	f4840613          	add	a2,s0,-184
    1272:	86aa                	mv	a3,a0
    1274:	85b2                	mv	a1,a2
    1276:	00005517          	auipc	a0,0x5
    127a:	3fa50513          	add	a0,a0,1018 # 6670 <malloc+0x82c>
    127e:	00005097          	auipc	ra,0x5
    1282:	af6080e7          	jalr	-1290(ra) # 5d74 <printf>
    exit(1);
    1286:	4505                	li	a0,1
    1288:	00004097          	auipc	ra,0x4
    128c:	792080e7          	jalr	1938(ra) # 5a1a <exit>
    printf("open(%s) returned %d, not -1\n", b, fd);
    1290:	862a                	mv	a2,a0
    1292:	f4840593          	add	a1,s0,-184
    1296:	00005517          	auipc	a0,0x5
    129a:	3ba50513          	add	a0,a0,954 # 6650 <malloc+0x80c>
    129e:	00005097          	auipc	ra,0x5
    12a2:	ad6080e7          	jalr	-1322(ra) # 5d74 <printf>
    exit(1);
    12a6:	4505                	li	a0,1
    12a8:	00004097          	auipc	ra,0x4
    12ac:	772080e7          	jalr	1906(ra) # 5a1a <exit>

00000000000012b0 <truncate3>:
{
    12b0:	711d                	add	sp,sp,-96
    12b2:	ec86                	sd	ra,88(sp)
    12b4:	e8a2                	sd	s0,80(sp)
    12b6:	e0ca                	sd	s2,64(sp)
    12b8:	1080                	add	s0,sp,96
  close(open("truncfile", O_CREATE|O_TRUNC|O_WRONLY));
    12ba:	60100593          	li	a1,1537
{
    12be:	892a                	mv	s2,a0
  close(open("truncfile", O_CREATE|O_TRUNC|O_WRONLY));
    12c0:	00005517          	auipc	a0,0x5
    12c4:	cb050513          	add	a0,a0,-848 # 5f70 <malloc+0x12c>
    12c8:	00004097          	auipc	ra,0x4
    12cc:	792080e7          	jalr	1938(ra) # 5a5a <open>
    12d0:	00004097          	auipc	ra,0x4
    12d4:	772080e7          	jalr	1906(ra) # 5a42 <close>
  pid = fork();
    12d8:	00004097          	auipc	ra,0x4
    12dc:	73a080e7          	jalr	1850(ra) # 5a12 <fork>
  if(pid < 0){
    12e0:	e4a6                	sd	s1,72(sp)
    12e2:	fc4e                	sd	s3,56(sp)
    12e4:	f852                	sd	s4,48(sp)
    12e6:	f456                	sd	s5,40(sp)
    12e8:	0e054163          	bltz	a0,13ca <truncate3+0x11a>
  if(pid == 0){
    12ec:	e941                	bnez	a0,137c <truncate3+0xcc>
    12ee:	06400993          	li	s3,100
      int fd = open("truncfile", O_WRONLY);
    12f2:	00005a17          	auipc	s4,0x5
    12f6:	c7ea0a13          	add	s4,s4,-898 # 5f70 <malloc+0x12c>
      int n = write(fd, "1234567890", 10);
    12fa:	00005a97          	auipc	s5,0x5
    12fe:	446a8a93          	add	s5,s5,1094 # 6740 <malloc+0x8fc>
    1302:	a0b1                	j	134e <truncate3+0x9e>
    1304:	4629                	li	a2,10
    1306:	85d6                	mv	a1,s5
    1308:	00004097          	auipc	ra,0x4
    130c:	732080e7          	jalr	1842(ra) # 5a3a <write>
      if(n != 10){
    1310:	47a9                	li	a5,10
    1312:	0ef51963          	bne	a0,a5,1404 <truncate3+0x154>
      close(fd);
    1316:	8526                	mv	a0,s1
    1318:	00004097          	auipc	ra,0x4
    131c:	72a080e7          	jalr	1834(ra) # 5a42 <close>
      fd = open("truncfile", O_RDONLY);
    1320:	4581                	li	a1,0
    1322:	8552                	mv	a0,s4
    1324:	00004097          	auipc	ra,0x4
    1328:	736080e7          	jalr	1846(ra) # 5a5a <open>
      read(fd, buf, sizeof(buf));
    132c:	02000613          	li	a2,32
    1330:	fa040593          	add	a1,s0,-96
      fd = open("truncfile", O_RDONLY);
    1334:	84aa                	mv	s1,a0
      read(fd, buf, sizeof(buf));
    1336:	00004097          	auipc	ra,0x4
    133a:	6fc080e7          	jalr	1788(ra) # 5a32 <read>
      close(fd);
    133e:	8526                	mv	a0,s1
    for(int i = 0; i < 100; i++){
    1340:	39fd                	addw	s3,s3,-1
      close(fd);
    1342:	00004097          	auipc	ra,0x4
    1346:	700080e7          	jalr	1792(ra) # 5a42 <close>
    for(int i = 0; i < 100; i++){
    134a:	0c098c63          	beqz	s3,1422 <truncate3+0x172>
      int fd = open("truncfile", O_WRONLY);
    134e:	4585                	li	a1,1
    1350:	8552                	mv	a0,s4
    1352:	00004097          	auipc	ra,0x4
    1356:	708080e7          	jalr	1800(ra) # 5a5a <open>
    135a:	84aa                	mv	s1,a0
      if(fd < 0){
    135c:	fa0554e3          	bgez	a0,1304 <truncate3+0x54>
        printf("%s: open failed\n", s);
    1360:	00005517          	auipc	a0,0x5
    1364:	3c850513          	add	a0,a0,968 # 6728 <malloc+0x8e4>
    1368:	85ca                	mv	a1,s2
    136a:	00005097          	auipc	ra,0x5
    136e:	a0a080e7          	jalr	-1526(ra) # 5d74 <printf>
        exit(1);
    1372:	4505                	li	a0,1
    1374:	00004097          	auipc	ra,0x4
    1378:	6a6080e7          	jalr	1702(ra) # 5a1a <exit>
    137c:	09600993          	li	s3,150
    int fd = open("truncfile", O_CREATE|O_WRONLY|O_TRUNC);
    1380:	00005a17          	auipc	s4,0x5
    1384:	bf0a0a13          	add	s4,s4,-1040 # 5f70 <malloc+0x12c>
    int n = write(fd, "xxx", 3);
    1388:	00005a97          	auipc	s5,0x5
    138c:	3e8a8a93          	add	s5,s5,1000 # 6770 <malloc+0x92c>
    1390:	a015                	j	13b4 <truncate3+0x104>
    1392:	460d                	li	a2,3
    1394:	85d6                	mv	a1,s5
    1396:	00004097          	auipc	ra,0x4
    139a:	6a4080e7          	jalr	1700(ra) # 5a3a <write>
    if(n != 3){
    139e:	478d                	li	a5,3
    13a0:	04f51363          	bne	a0,a5,13e6 <truncate3+0x136>
    close(fd);
    13a4:	8526                	mv	a0,s1
  for(int i = 0; i < 150; i++){
    13a6:	39fd                	addw	s3,s3,-1
    close(fd);
    13a8:	00004097          	auipc	ra,0x4
    13ac:	69a080e7          	jalr	1690(ra) # 5a42 <close>
  for(int i = 0; i < 150; i++){
    13b0:	06098e63          	beqz	s3,142c <truncate3+0x17c>
    int fd = open("truncfile", O_CREATE|O_WRONLY|O_TRUNC);
    13b4:	60100593          	li	a1,1537
    13b8:	8552                	mv	a0,s4
    13ba:	00004097          	auipc	ra,0x4
    13be:	6a0080e7          	jalr	1696(ra) # 5a5a <open>
    13c2:	84aa                	mv	s1,a0
    if(fd < 0){
    13c4:	fc0557e3          	bgez	a0,1392 <truncate3+0xe2>
    13c8:	bf61                	j	1360 <truncate3+0xb0>
    printf("%s: fork failed\n", s);
    13ca:	00005517          	auipc	a0,0x5
    13ce:	34650513          	add	a0,a0,838 # 6710 <malloc+0x8cc>
    13d2:	85ca                	mv	a1,s2
    13d4:	00005097          	auipc	ra,0x5
    13d8:	9a0080e7          	jalr	-1632(ra) # 5d74 <printf>
    exit(1);
    13dc:	4505                	li	a0,1
    13de:	00004097          	auipc	ra,0x4
    13e2:	63c080e7          	jalr	1596(ra) # 5a1a <exit>
      printf("%s: write got %d, expected 3\n", s, n);
    13e6:	862a                	mv	a2,a0
    13e8:	85ca                	mv	a1,s2
    13ea:	00005517          	auipc	a0,0x5
    13ee:	38e50513          	add	a0,a0,910 # 6778 <malloc+0x934>
    13f2:	00005097          	auipc	ra,0x5
    13f6:	982080e7          	jalr	-1662(ra) # 5d74 <printf>
      exit(1);
    13fa:	4505                	li	a0,1
    13fc:	00004097          	auipc	ra,0x4
    1400:	61e080e7          	jalr	1566(ra) # 5a1a <exit>
        printf("%s: write got %d, expected 10\n", s, n);
    1404:	862a                	mv	a2,a0
    1406:	85ca                	mv	a1,s2
    1408:	00005517          	auipc	a0,0x5
    140c:	34850513          	add	a0,a0,840 # 6750 <malloc+0x90c>
    1410:	00005097          	auipc	ra,0x5
    1414:	964080e7          	jalr	-1692(ra) # 5d74 <printf>
        exit(1);
    1418:	4505                	li	a0,1
    141a:	00004097          	auipc	ra,0x4
    141e:	600080e7          	jalr	1536(ra) # 5a1a <exit>
    exit(0);
    1422:	4501                	li	a0,0
    1424:	00004097          	auipc	ra,0x4
    1428:	5f6080e7          	jalr	1526(ra) # 5a1a <exit>
  wait(&xstatus);
    142c:	fa040513          	add	a0,s0,-96
    1430:	00004097          	auipc	ra,0x4
    1434:	5f2080e7          	jalr	1522(ra) # 5a22 <wait>
  unlink("truncfile");
    1438:	00005517          	auipc	a0,0x5
    143c:	b3850513          	add	a0,a0,-1224 # 5f70 <malloc+0x12c>
    1440:	00004097          	auipc	ra,0x4
    1444:	62a080e7          	jalr	1578(ra) # 5a6a <unlink>
  exit(xstatus);
    1448:	fa042503          	lw	a0,-96(s0)
    144c:	00004097          	auipc	ra,0x4
    1450:	5ce080e7          	jalr	1486(ra) # 5a1a <exit>

0000000000001454 <exectest>:
{
    1454:	715d                	add	sp,sp,-80
    1456:	e486                	sd	ra,72(sp)
    1458:	e0a2                	sd	s0,64(sp)
    145a:	f84a                	sd	s2,48(sp)
    145c:	0880                	add	s0,sp,80
    145e:	f44e                	sd	s3,40(sp)
  char *echoargv[] = { "echo", "OK", 0 };
    1460:	00005797          	auipc	a5,0x5
    1464:	33878793          	add	a5,a5,824 # 6798 <malloc+0x954>
{
    1468:	89aa                	mv	s3,a0
  char *echoargv[] = { "echo", "OK", 0 };
    146a:	00005917          	auipc	s2,0x5
    146e:	1be90913          	add	s2,s2,446 # 6628 <malloc+0x7e4>
  unlink("echo-ok");
    1472:	00005517          	auipc	a0,0x5
    1476:	32e50513          	add	a0,a0,814 # 67a0 <malloc+0x95c>
  char *echoargv[] = { "echo", "OK", 0 };
    147a:	fcf43023          	sd	a5,-64(s0)
    147e:	fb243c23          	sd	s2,-72(s0)
    1482:	fc043423          	sd	zero,-56(s0)
  unlink("echo-ok");
    1486:	00004097          	auipc	ra,0x4
    148a:	5e4080e7          	jalr	1508(ra) # 5a6a <unlink>
  pid = fork();
    148e:	00004097          	auipc	ra,0x4
    1492:	584080e7          	jalr	1412(ra) # 5a12 <fork>
  if(pid < 0) {
    1496:	fc26                	sd	s1,56(sp)
    1498:	0c054b63          	bltz	a0,156e <exectest+0x11a>
    149c:	84aa                	mv	s1,a0
  if(pid == 0) {
    149e:	c925                	beqz	a0,150e <exectest+0xba>
  if (wait(&xstatus) != pid) {
    14a0:	fb440513          	add	a0,s0,-76
    14a4:	00004097          	auipc	ra,0x4
    14a8:	57e080e7          	jalr	1406(ra) # 5a22 <wait>
    14ac:	00950b63          	beq	a0,s1,14c2 <exectest+0x6e>
    printf("%s: wait failed!\n", s);
    14b0:	85ce                	mv	a1,s3
    14b2:	00005517          	auipc	a0,0x5
    14b6:	33650513          	add	a0,a0,822 # 67e8 <malloc+0x9a4>
    14ba:	00005097          	auipc	ra,0x5
    14be:	8ba080e7          	jalr	-1862(ra) # 5d74 <printf>
  if(xstatus != 0)
    14c2:	fb442503          	lw	a0,-76(s0)
    14c6:	e145                	bnez	a0,1566 <exectest+0x112>
  fd = open("echo-ok", O_RDONLY);
    14c8:	4581                	li	a1,0
    14ca:	00005517          	auipc	a0,0x5
    14ce:	2d650513          	add	a0,a0,726 # 67a0 <malloc+0x95c>
    14d2:	00004097          	auipc	ra,0x4
    14d6:	588080e7          	jalr	1416(ra) # 5a5a <open>
  if(fd < 0) {
    14da:	06054c63          	bltz	a0,1552 <exectest+0xfe>
  if (read(fd, buf, 2) != 2) {
    14de:	4609                	li	a2,2
    14e0:	fb040593          	add	a1,s0,-80
    14e4:	00004097          	auipc	ra,0x4
    14e8:	54e080e7          	jalr	1358(ra) # 5a32 <read>
    14ec:	4789                	li	a5,2
    14ee:	0ef50363          	beq	a0,a5,15d4 <exectest+0x180>
    printf("%s: read failed\n", s);
    14f2:	00005517          	auipc	a0,0x5
    14f6:	df650513          	add	a0,a0,-522 # 62e8 <malloc+0x4a4>
    14fa:	85ce                	mv	a1,s3
    14fc:	00005097          	auipc	ra,0x5
    1500:	878080e7          	jalr	-1928(ra) # 5d74 <printf>
    exit(1);
    1504:	4505                	li	a0,1
    1506:	00004097          	auipc	ra,0x4
    150a:	514080e7          	jalr	1300(ra) # 5a1a <exit>
    close(1);
    150e:	4505                	li	a0,1
    1510:	00004097          	auipc	ra,0x4
    1514:	532080e7          	jalr	1330(ra) # 5a42 <close>
    fd = open("echo-ok", O_CREATE|O_WRONLY);
    1518:	20100593          	li	a1,513
    151c:	00005517          	auipc	a0,0x5
    1520:	28450513          	add	a0,a0,644 # 67a0 <malloc+0x95c>
    1524:	00004097          	auipc	ra,0x4
    1528:	536080e7          	jalr	1334(ra) # 5a5a <open>
    if(fd < 0) {
    152c:	08054663          	bltz	a0,15b8 <exectest+0x164>
    if(fd != 1) {
    1530:	4785                	li	a5,1
    1532:	04f50c63          	beq	a0,a5,158a <exectest+0x136>
      printf("%s: wrong fd\n", s);
    1536:	00005517          	auipc	a0,0x5
    153a:	28a50513          	add	a0,a0,650 # 67c0 <malloc+0x97c>
    153e:	85ce                	mv	a1,s3
    1540:	00005097          	auipc	ra,0x5
    1544:	834080e7          	jalr	-1996(ra) # 5d74 <printf>
      exit(1);
    1548:	4505                	li	a0,1
    154a:	00004097          	auipc	ra,0x4
    154e:	4d0080e7          	jalr	1232(ra) # 5a1a <exit>
    printf("%s: open failed\n", s);
    1552:	00005517          	auipc	a0,0x5
    1556:	1d650513          	add	a0,a0,470 # 6728 <malloc+0x8e4>
    155a:	85ce                	mv	a1,s3
    155c:	00005097          	auipc	ra,0x5
    1560:	818080e7          	jalr	-2024(ra) # 5d74 <printf>
    exit(1);
    1564:	4505                	li	a0,1
    1566:	00004097          	auipc	ra,0x4
    156a:	4b4080e7          	jalr	1204(ra) # 5a1a <exit>
     printf("%s: fork failed\n", s);
    156e:	00005517          	auipc	a0,0x5
    1572:	1a250513          	add	a0,a0,418 # 6710 <malloc+0x8cc>
    1576:	85ce                	mv	a1,s3
    1578:	00004097          	auipc	ra,0x4
    157c:	7fc080e7          	jalr	2044(ra) # 5d74 <printf>
     exit(1);
    1580:	4505                	li	a0,1
    1582:	00004097          	auipc	ra,0x4
    1586:	498080e7          	jalr	1176(ra) # 5a1a <exit>
    if(exec("echo", echoargv) < 0){
    158a:	fb840593          	add	a1,s0,-72
    158e:	854a                	mv	a0,s2
    1590:	00004097          	auipc	ra,0x4
    1594:	4c2080e7          	jalr	1218(ra) # 5a52 <exec>
    1598:	f00554e3          	bgez	a0,14a0 <exectest+0x4c>
      printf("%s: exec echo failed\n", s);
    159c:	00005517          	auipc	a0,0x5
    15a0:	23450513          	add	a0,a0,564 # 67d0 <malloc+0x98c>
    15a4:	85ce                	mv	a1,s3
    15a6:	00004097          	auipc	ra,0x4
    15aa:	7ce080e7          	jalr	1998(ra) # 5d74 <printf>
      exit(1);
    15ae:	4505                	li	a0,1
    15b0:	00004097          	auipc	ra,0x4
    15b4:	46a080e7          	jalr	1130(ra) # 5a1a <exit>
      printf("%s: create failed\n", s);
    15b8:	00005517          	auipc	a0,0x5
    15bc:	1f050513          	add	a0,a0,496 # 67a8 <malloc+0x964>
    15c0:	85ce                	mv	a1,s3
    15c2:	00004097          	auipc	ra,0x4
    15c6:	7b2080e7          	jalr	1970(ra) # 5d74 <printf>
      exit(1);
    15ca:	4505                	li	a0,1
    15cc:	00004097          	auipc	ra,0x4
    15d0:	44e080e7          	jalr	1102(ra) # 5a1a <exit>
  unlink("echo-ok");
    15d4:	00005517          	auipc	a0,0x5
    15d8:	1cc50513          	add	a0,a0,460 # 67a0 <malloc+0x95c>
    15dc:	00004097          	auipc	ra,0x4
    15e0:	48e080e7          	jalr	1166(ra) # 5a6a <unlink>
  if(buf[0] == 'O' && buf[1] == 'K')
    15e4:	fb044703          	lbu	a4,-80(s0)
    15e8:	04f00793          	li	a5,79
    15ec:	00f71863          	bne	a4,a5,15fc <exectest+0x1a8>
    15f0:	fb144703          	lbu	a4,-79(s0)
    15f4:	04b00793          	li	a5,75
    15f8:	02f70063          	beq	a4,a5,1618 <exectest+0x1c4>
    printf("%s: wrong output\n", s);
    15fc:	00005517          	auipc	a0,0x5
    1600:	20450513          	add	a0,a0,516 # 6800 <malloc+0x9bc>
    1604:	85ce                	mv	a1,s3
    1606:	00004097          	auipc	ra,0x4
    160a:	76e080e7          	jalr	1902(ra) # 5d74 <printf>
    exit(1);
    160e:	4505                	li	a0,1
    1610:	00004097          	auipc	ra,0x4
    1614:	40a080e7          	jalr	1034(ra) # 5a1a <exit>
    exit(0);
    1618:	4501                	li	a0,0
    161a:	00004097          	auipc	ra,0x4
    161e:	400080e7          	jalr	1024(ra) # 5a1a <exit>

0000000000001622 <pipe1>:
{
    1622:	715d                	add	sp,sp,-80
    1624:	e0a2                	sd	s0,64(sp)
    1626:	f44e                	sd	s3,40(sp)
    1628:	0880                	add	s0,sp,80
    162a:	e486                	sd	ra,72(sp)
    162c:	89aa                	mv	s3,a0
  if(pipe(fds) != 0){
    162e:	fb840513          	add	a0,s0,-72
    1632:	00004097          	auipc	ra,0x4
    1636:	3f8080e7          	jalr	1016(ra) # 5a2a <pipe>
    163a:	fc26                	sd	s1,56(sp)
    163c:	16051b63          	bnez	a0,17b2 <pipe1+0x190>
    1640:	f052                	sd	s4,32(sp)
    1642:	84aa                	mv	s1,a0
  pid = fork();
    1644:	00004097          	auipc	ra,0x4
    1648:	3ce080e7          	jalr	974(ra) # 5a12 <fork>
    164c:	f84a                	sd	s2,48(sp)
    164e:	ec56                	sd	s5,24(sp)
    1650:	8a2a                	mv	s4,a0
  if(pid == 0){
    1652:	c549                	beqz	a0,16dc <pipe1+0xba>
  } else if(pid > 0){
    1654:	18a05163          	blez	a0,17d6 <pipe1+0x1b4>
    close(fds[1]);
    1658:	fbc42503          	lw	a0,-68(s0)
    total = 0;
    165c:	4901                	li	s2,0
    cc = 1;
    165e:	4a85                	li	s5,1
    close(fds[1]);
    1660:	00004097          	auipc	ra,0x4
    1664:	3e2080e7          	jalr	994(ra) # 5a42 <close>
    while((n = read(fds[0], buf, cc)) > 0){
    1668:	0000ba17          	auipc	s4,0xb
    166c:	610a0a13          	add	s4,s4,1552 # cc78 <buf>
    1670:	fb842503          	lw	a0,-72(s0)
    1674:	8656                	mv	a2,s5
    1676:	85d2                	mv	a1,s4
    1678:	00004097          	auipc	ra,0x4
    167c:	3ba080e7          	jalr	954(ra) # 5a32 <read>
    1680:	0ca05563          	blez	a0,174a <pipe1+0x128>
      for(i = 0; i < n; i++){
    1684:	0000b717          	auipc	a4,0xb
    1688:	5f470713          	add	a4,a4,1524 # cc78 <buf>
    168c:	00a485bb          	addw	a1,s1,a0
    1690:	a021                	j	1698 <pipe1+0x76>
    1692:	0705                	add	a4,a4,1
    1694:	02b48b63          	beq	s1,a1,16ca <pipe1+0xa8>
        if((buf[i] & 0xff) != (seq++ & 0xff)){
    1698:	00074683          	lbu	a3,0(a4)
    169c:	0ff4f793          	zext.b	a5,s1
    16a0:	2485                	addw	s1,s1,1
    16a2:	fef688e3          	beq	a3,a5,1692 <pipe1+0x70>
          printf("%s: pipe1 oops 2\n", s);
    16a6:	85ce                	mv	a1,s3
    16a8:	00005517          	auipc	a0,0x5
    16ac:	1a050513          	add	a0,a0,416 # 6848 <malloc+0xa04>
    16b0:	00004097          	auipc	ra,0x4
    16b4:	6c4080e7          	jalr	1732(ra) # 5d74 <printf>
}
    16b8:	60a6                	ld	ra,72(sp)
    16ba:	6406                	ld	s0,64(sp)
    16bc:	74e2                	ld	s1,56(sp)
    16be:	7942                	ld	s2,48(sp)
    16c0:	7a02                	ld	s4,32(sp)
    16c2:	6ae2                	ld	s5,24(sp)
    16c4:	79a2                	ld	s3,40(sp)
    16c6:	6161                	add	sp,sp,80
    16c8:	8082                	ret
      cc = cc * 2;
    16ca:	001a9a9b          	sllw	s5,s5,0x1
      if(cc > sizeof(buf))
    16ce:	678d                	lui	a5,0x3
      total += n;
    16d0:	00a9093b          	addw	s2,s2,a0
      if(cc > sizeof(buf))
    16d4:	f957dee3          	bge	a5,s5,1670 <pipe1+0x4e>
    16d8:	6a8d                	lui	s5,0x3
    16da:	bf59                	j	1670 <pipe1+0x4e>
    close(fds[0]);
    16dc:	fb842503          	lw	a0,-72(s0)
    16e0:	0000ba97          	auipc	s5,0xb
    16e4:	598a8a93          	add	s5,s5,1432 # cc78 <buf>
    16e8:	e85a                	sd	s6,16(sp)
    16ea:	415004bb          	negw	s1,s5
    for(n = 0; n < N; n++){
    16ee:	6b05                	lui	s6,0x1
    close(fds[0]);
    16f0:	00004097          	auipc	ra,0x4
    16f4:	352080e7          	jalr	850(ra) # 5a42 <close>
    for(n = 0; n < N; n++){
    16f8:	0ff4f493          	zext.b	s1,s1
    16fc:	0000c917          	auipc	s2,0xc
    1700:	98590913          	add	s2,s2,-1659 # d081 <buf+0x409>
    1704:	42db0b13          	add	s6,s6,1069 # 142d <truncate3+0x17d>
{
    1708:	87d6                	mv	a5,s5
        buf[i] = seq++;
    170a:	0097873b          	addw	a4,a5,s1
    170e:	00e78023          	sb	a4,0(a5) # 3000 <iputtest+0x6e>
      for(i = 0; i < SZ; i++)
    1712:	0785                	add	a5,a5,1
    1714:	fef91be3          	bne	s2,a5,170a <pipe1+0xe8>
      if(write(fds[1], buf, SZ) != SZ){
    1718:	fbc42503          	lw	a0,-68(s0)
    171c:	40900613          	li	a2,1033
    1720:	85d6                	mv	a1,s5
    1722:	00004097          	auipc	ra,0x4
    1726:	318080e7          	jalr	792(ra) # 5a3a <write>
    172a:	40900793          	li	a5,1033
    172e:	409a0a1b          	addw	s4,s4,1033
    1732:	06f51263          	bne	a0,a5,1796 <pipe1+0x174>
    for(n = 0; n < N; n++){
    1736:	24a5                	addw	s1,s1,9
    1738:	0ff4f493          	zext.b	s1,s1
    173c:	fd6a16e3          	bne	s4,s6,1708 <pipe1+0xe6>
    exit(0);
    1740:	4501                	li	a0,0
    1742:	00004097          	auipc	ra,0x4
    1746:	2d8080e7          	jalr	728(ra) # 5a1a <exit>
    if(total != N * SZ){
    174a:	6785                	lui	a5,0x1
    174c:	42d78793          	add	a5,a5,1069 # 142d <truncate3+0x17d>
    1750:	e85a                	sd	s6,16(sp)
    1752:	02f90063          	beq	s2,a5,1772 <pipe1+0x150>
      printf("%s: pipe1 oops 3 total %d\n", total);
    1756:	00005517          	auipc	a0,0x5
    175a:	10a50513          	add	a0,a0,266 # 6860 <malloc+0xa1c>
    175e:	85ca                	mv	a1,s2
    1760:	00004097          	auipc	ra,0x4
    1764:	614080e7          	jalr	1556(ra) # 5d74 <printf>
      exit(1);
    1768:	4505                	li	a0,1
    176a:	00004097          	auipc	ra,0x4
    176e:	2b0080e7          	jalr	688(ra) # 5a1a <exit>
    close(fds[0]);
    1772:	fb842503          	lw	a0,-72(s0)
    1776:	00004097          	auipc	ra,0x4
    177a:	2cc080e7          	jalr	716(ra) # 5a42 <close>
    wait(&xstatus);
    177e:	fb440513          	add	a0,s0,-76
    1782:	00004097          	auipc	ra,0x4
    1786:	2a0080e7          	jalr	672(ra) # 5a22 <wait>
    exit(xstatus);
    178a:	fb442503          	lw	a0,-76(s0)
    178e:	00004097          	auipc	ra,0x4
    1792:	28c080e7          	jalr	652(ra) # 5a1a <exit>
        printf("%s: pipe1 oops 1\n", s);
    1796:	00005517          	auipc	a0,0x5
    179a:	09a50513          	add	a0,a0,154 # 6830 <malloc+0x9ec>
    179e:	85ce                	mv	a1,s3
    17a0:	00004097          	auipc	ra,0x4
    17a4:	5d4080e7          	jalr	1492(ra) # 5d74 <printf>
        exit(1);
    17a8:	4505                	li	a0,1
    17aa:	00004097          	auipc	ra,0x4
    17ae:	270080e7          	jalr	624(ra) # 5a1a <exit>
    printf("%s: pipe() failed\n", s);
    17b2:	00005517          	auipc	a0,0x5
    17b6:	06650513          	add	a0,a0,102 # 6818 <malloc+0x9d4>
    17ba:	85ce                	mv	a1,s3
    17bc:	f84a                	sd	s2,48(sp)
    17be:	f052                	sd	s4,32(sp)
    17c0:	ec56                	sd	s5,24(sp)
    17c2:	e85a                	sd	s6,16(sp)
    17c4:	00004097          	auipc	ra,0x4
    17c8:	5b0080e7          	jalr	1456(ra) # 5d74 <printf>
    exit(1);
    17cc:	4505                	li	a0,1
    17ce:	00004097          	auipc	ra,0x4
    17d2:	24c080e7          	jalr	588(ra) # 5a1a <exit>
    printf("%s: fork() failed\n", s);
    17d6:	00005517          	auipc	a0,0x5
    17da:	0aa50513          	add	a0,a0,170 # 6880 <malloc+0xa3c>
    17de:	85ce                	mv	a1,s3
    17e0:	e85a                	sd	s6,16(sp)
    17e2:	00004097          	auipc	ra,0x4
    17e6:	592080e7          	jalr	1426(ra) # 5d74 <printf>
    exit(1);
    17ea:	4505                	li	a0,1
    17ec:	00004097          	auipc	ra,0x4
    17f0:	22e080e7          	jalr	558(ra) # 5a1a <exit>

00000000000017f4 <exitwait>:
{
    17f4:	7139                	add	sp,sp,-64
    17f6:	f822                	sd	s0,48(sp)
    17f8:	f04a                	sd	s2,32(sp)
    17fa:	ec4e                	sd	s3,24(sp)
    17fc:	e852                	sd	s4,16(sp)
    17fe:	fc06                	sd	ra,56(sp)
    1800:	f426                	sd	s1,40(sp)
    1802:	0080                	add	s0,sp,64
    1804:	8a2a                	mv	s4,a0
  for(i = 0; i < 100; i++){
    1806:	4901                	li	s2,0
    1808:	06400993          	li	s3,100
    pid = fork();
    180c:	00004097          	auipc	ra,0x4
    1810:	206080e7          	jalr	518(ra) # 5a12 <fork>
    1814:	84aa                	mv	s1,a0
    if(pid < 0){
    1816:	02054a63          	bltz	a0,184a <exitwait+0x56>
    if(pid){
    181a:	c151                	beqz	a0,189e <exitwait+0xaa>
      if(wait(&xstate) != pid){
    181c:	fcc40513          	add	a0,s0,-52
    1820:	00004097          	auipc	ra,0x4
    1824:	202080e7          	jalr	514(ra) # 5a22 <wait>
    1828:	04951d63          	bne	a0,s1,1882 <exitwait+0x8e>
      if(i != xstate) {
    182c:	fcc42783          	lw	a5,-52(s0)
    1830:	03279b63          	bne	a5,s2,1866 <exitwait+0x72>
  for(i = 0; i < 100; i++){
    1834:	2905                	addw	s2,s2,1
    1836:	fd391be3          	bne	s2,s3,180c <exitwait+0x18>
}
    183a:	70e2                	ld	ra,56(sp)
    183c:	7442                	ld	s0,48(sp)
    183e:	74a2                	ld	s1,40(sp)
    1840:	7902                	ld	s2,32(sp)
    1842:	69e2                	ld	s3,24(sp)
    1844:	6a42                	ld	s4,16(sp)
    1846:	6121                	add	sp,sp,64
    1848:	8082                	ret
      printf("%s: fork failed\n", s);
    184a:	00005517          	auipc	a0,0x5
    184e:	ec650513          	add	a0,a0,-314 # 6710 <malloc+0x8cc>
    1852:	85d2                	mv	a1,s4
    1854:	00004097          	auipc	ra,0x4
    1858:	520080e7          	jalr	1312(ra) # 5d74 <printf>
      exit(1);
    185c:	4505                	li	a0,1
    185e:	00004097          	auipc	ra,0x4
    1862:	1bc080e7          	jalr	444(ra) # 5a1a <exit>
        printf("%s: wait wrong exit status\n", s);
    1866:	00005517          	auipc	a0,0x5
    186a:	04a50513          	add	a0,a0,74 # 68b0 <malloc+0xa6c>
    186e:	85d2                	mv	a1,s4
    1870:	00004097          	auipc	ra,0x4
    1874:	504080e7          	jalr	1284(ra) # 5d74 <printf>
        exit(1);
    1878:	4505                	li	a0,1
    187a:	00004097          	auipc	ra,0x4
    187e:	1a0080e7          	jalr	416(ra) # 5a1a <exit>
        printf("%s: wait wrong pid\n", s);
    1882:	00005517          	auipc	a0,0x5
    1886:	01650513          	add	a0,a0,22 # 6898 <malloc+0xa54>
    188a:	85d2                	mv	a1,s4
    188c:	00004097          	auipc	ra,0x4
    1890:	4e8080e7          	jalr	1256(ra) # 5d74 <printf>
        exit(1);
    1894:	4505                	li	a0,1
    1896:	00004097          	auipc	ra,0x4
    189a:	184080e7          	jalr	388(ra) # 5a1a <exit>
      exit(i);
    189e:	854a                	mv	a0,s2
    18a0:	00004097          	auipc	ra,0x4
    18a4:	17a080e7          	jalr	378(ra) # 5a1a <exit>

00000000000018a8 <twochildren>:
{
    18a8:	1101                	add	sp,sp,-32
    18aa:	e822                	sd	s0,16(sp)
    18ac:	e426                	sd	s1,8(sp)
    18ae:	e04a                	sd	s2,0(sp)
    18b0:	ec06                	sd	ra,24(sp)
    18b2:	1000                	add	s0,sp,32
    18b4:	892a                	mv	s2,a0
    18b6:	3e800493          	li	s1,1000
    int pid1 = fork();
    18ba:	00004097          	auipc	ra,0x4
    18be:	158080e7          	jalr	344(ra) # 5a12 <fork>
    if(pid1 < 0){
    18c2:	02054c63          	bltz	a0,18fa <twochildren+0x52>
    if(pid1 == 0){
    18c6:	c921                	beqz	a0,1916 <twochildren+0x6e>
      int pid2 = fork();
    18c8:	00004097          	auipc	ra,0x4
    18cc:	14a080e7          	jalr	330(ra) # 5a12 <fork>
      if(pid2 < 0){
    18d0:	02054563          	bltz	a0,18fa <twochildren+0x52>
      if(pid2 == 0){
    18d4:	c129                	beqz	a0,1916 <twochildren+0x6e>
        wait(0);
    18d6:	4501                	li	a0,0
    18d8:	00004097          	auipc	ra,0x4
    18dc:	14a080e7          	jalr	330(ra) # 5a22 <wait>
        wait(0);
    18e0:	4501                	li	a0,0
  for(int i = 0; i < 1000; i++){
    18e2:	34fd                	addw	s1,s1,-1
        wait(0);
    18e4:	00004097          	auipc	ra,0x4
    18e8:	13e080e7          	jalr	318(ra) # 5a22 <wait>
  for(int i = 0; i < 1000; i++){
    18ec:	f4f9                	bnez	s1,18ba <twochildren+0x12>
}
    18ee:	60e2                	ld	ra,24(sp)
    18f0:	6442                	ld	s0,16(sp)
    18f2:	64a2                	ld	s1,8(sp)
    18f4:	6902                	ld	s2,0(sp)
    18f6:	6105                	add	sp,sp,32
    18f8:	8082                	ret
      printf("%s: fork failed\n", s);
    18fa:	00005517          	auipc	a0,0x5
    18fe:	e1650513          	add	a0,a0,-490 # 6710 <malloc+0x8cc>
    1902:	85ca                	mv	a1,s2
    1904:	00004097          	auipc	ra,0x4
    1908:	470080e7          	jalr	1136(ra) # 5d74 <printf>
      exit(1);
    190c:	4505                	li	a0,1
    190e:	00004097          	auipc	ra,0x4
    1912:	10c080e7          	jalr	268(ra) # 5a1a <exit>
      exit(0);
    1916:	4501                	li	a0,0
    1918:	00004097          	auipc	ra,0x4
    191c:	102080e7          	jalr	258(ra) # 5a1a <exit>

0000000000001920 <forkfork>:
{
    1920:	7179                	add	sp,sp,-48
    1922:	f022                	sd	s0,32(sp)
    1924:	ec26                	sd	s1,24(sp)
    1926:	f406                	sd	ra,40(sp)
    1928:	1800                	add	s0,sp,48
    192a:	84aa                	mv	s1,a0
    int pid = fork();
    192c:	00004097          	auipc	ra,0x4
    1930:	0e6080e7          	jalr	230(ra) # 5a12 <fork>
    if(pid < 0){
    1934:	08054463          	bltz	a0,19bc <forkfork+0x9c>
    if(pid == 0){
    1938:	cd1d                	beqz	a0,1976 <forkfork+0x56>
    int pid = fork();
    193a:	00004097          	auipc	ra,0x4
    193e:	0d8080e7          	jalr	216(ra) # 5a12 <fork>
    if(pid < 0){
    1942:	06054d63          	bltz	a0,19bc <forkfork+0x9c>
    if(pid == 0){
    1946:	c905                	beqz	a0,1976 <forkfork+0x56>
    wait(&xstatus);
    1948:	fdc40513          	add	a0,s0,-36
    194c:	00004097          	auipc	ra,0x4
    1950:	0d6080e7          	jalr	214(ra) # 5a22 <wait>
    if(xstatus != 0) {
    1954:	fdc42783          	lw	a5,-36(s0)
    1958:	e7a1                	bnez	a5,19a0 <forkfork+0x80>
    wait(&xstatus);
    195a:	fdc40513          	add	a0,s0,-36
    195e:	00004097          	auipc	ra,0x4
    1962:	0c4080e7          	jalr	196(ra) # 5a22 <wait>
    if(xstatus != 0) {
    1966:	fdc42783          	lw	a5,-36(s0)
    196a:	eb9d                	bnez	a5,19a0 <forkfork+0x80>
}
    196c:	70a2                	ld	ra,40(sp)
    196e:	7402                	ld	s0,32(sp)
    1970:	64e2                	ld	s1,24(sp)
    1972:	6145                	add	sp,sp,48
    1974:	8082                	ret
{
    1976:	0c800493          	li	s1,200
        int pid1 = fork();
    197a:	00004097          	auipc	ra,0x4
    197e:	098080e7          	jalr	152(ra) # 5a12 <fork>
        if(pid1 < 0){
    1982:	02054863          	bltz	a0,19b2 <forkfork+0x92>
        if(pid1 == 0){
    1986:	c901                	beqz	a0,1996 <forkfork+0x76>
        wait(0);
    1988:	4501                	li	a0,0
      for(int j = 0; j < 200; j++){
    198a:	34fd                	addw	s1,s1,-1
        wait(0);
    198c:	00004097          	auipc	ra,0x4
    1990:	096080e7          	jalr	150(ra) # 5a22 <wait>
      for(int j = 0; j < 200; j++){
    1994:	f0fd                	bnez	s1,197a <forkfork+0x5a>
          exit(0);
    1996:	4501                	li	a0,0
    1998:	00004097          	auipc	ra,0x4
    199c:	082080e7          	jalr	130(ra) # 5a1a <exit>
      printf("%s: fork in child failed", s);
    19a0:	85a6                	mv	a1,s1
    19a2:	00005517          	auipc	a0,0x5
    19a6:	f3e50513          	add	a0,a0,-194 # 68e0 <malloc+0xa9c>
    19aa:	00004097          	auipc	ra,0x4
    19ae:	3ca080e7          	jalr	970(ra) # 5d74 <printf>
      exit(1);
    19b2:	4505                	li	a0,1
    19b4:	00004097          	auipc	ra,0x4
    19b8:	066080e7          	jalr	102(ra) # 5a1a <exit>
      printf("%s: fork failed", s);
    19bc:	00005517          	auipc	a0,0x5
    19c0:	f1450513          	add	a0,a0,-236 # 68d0 <malloc+0xa8c>
    19c4:	85a6                	mv	a1,s1
    19c6:	00004097          	auipc	ra,0x4
    19ca:	3ae080e7          	jalr	942(ra) # 5d74 <printf>
      exit(1);
    19ce:	4505                	li	a0,1
    19d0:	00004097          	auipc	ra,0x4
    19d4:	04a080e7          	jalr	74(ra) # 5a1a <exit>

00000000000019d8 <reparent2>:
{
    19d8:	1101                	add	sp,sp,-32
    19da:	e822                	sd	s0,16(sp)
    19dc:	e426                	sd	s1,8(sp)
    19de:	ec06                	sd	ra,24(sp)
    19e0:	1000                	add	s0,sp,32
    19e2:	32000493          	li	s1,800
    19e6:	a809                	j	19f8 <reparent2+0x20>
    if(pid1 == 0){
    19e8:	c91d                	beqz	a0,1a1e <reparent2+0x46>
    wait(0);
    19ea:	4501                	li	a0,0
  for(int i = 0; i < 800; i++){
    19ec:	34fd                	addw	s1,s1,-1
    wait(0);
    19ee:	00004097          	auipc	ra,0x4
    19f2:	034080e7          	jalr	52(ra) # 5a22 <wait>
  for(int i = 0; i < 800; i++){
    19f6:	c0a9                	beqz	s1,1a38 <reparent2+0x60>
    int pid1 = fork();
    19f8:	00004097          	auipc	ra,0x4
    19fc:	01a080e7          	jalr	26(ra) # 5a12 <fork>
    if(pid1 < 0){
    1a00:	fe0554e3          	bgez	a0,19e8 <reparent2+0x10>
      printf("fork failed\n");
    1a04:	00005517          	auipc	a0,0x5
    1a08:	11450513          	add	a0,a0,276 # 6b18 <malloc+0xcd4>
    1a0c:	00004097          	auipc	ra,0x4
    1a10:	368080e7          	jalr	872(ra) # 5d74 <printf>
      exit(1);
    1a14:	4505                	li	a0,1
    1a16:	00004097          	auipc	ra,0x4
    1a1a:	004080e7          	jalr	4(ra) # 5a1a <exit>
      fork();
    1a1e:	00004097          	auipc	ra,0x4
    1a22:	ff4080e7          	jalr	-12(ra) # 5a12 <fork>
      fork();
    1a26:	00004097          	auipc	ra,0x4
    1a2a:	fec080e7          	jalr	-20(ra) # 5a12 <fork>
      exit(0);
    1a2e:	4501                	li	a0,0
    1a30:	00004097          	auipc	ra,0x4
    1a34:	fea080e7          	jalr	-22(ra) # 5a1a <exit>
  exit(0);
    1a38:	4501                	li	a0,0
    1a3a:	00004097          	auipc	ra,0x4
    1a3e:	fe0080e7          	jalr	-32(ra) # 5a1a <exit>

0000000000001a42 <createdelete>:
{
    1a42:	7119                	add	sp,sp,-128
    1a44:	f8a2                	sd	s0,112(sp)
    1a46:	f0ca                	sd	s2,96(sp)
    1a48:	ecce                	sd	s3,88(sp)
    1a4a:	f862                	sd	s8,48(sp)
    1a4c:	fc86                	sd	ra,120(sp)
    1a4e:	f4a6                	sd	s1,104(sp)
    1a50:	e8d2                	sd	s4,80(sp)
    1a52:	e4d6                	sd	s5,72(sp)
    1a54:	e0da                	sd	s6,64(sp)
    1a56:	fc5e                	sd	s7,56(sp)
    1a58:	0100                	add	s0,sp,128
    1a5a:	8c2a                	mv	s8,a0
  for(pi = 0; pi < NCHILD; pi++){
    1a5c:	4901                	li	s2,0
    1a5e:	4991                	li	s3,4
    pid = fork();
    1a60:	00004097          	auipc	ra,0x4
    1a64:	fb2080e7          	jalr	-78(ra) # 5a12 <fork>
    1a68:	84aa                	mv	s1,a0
    if(pid < 0){
    1a6a:	18054963          	bltz	a0,1bfc <createdelete+0x1ba>
    if(pid == 0){
    1a6e:	c56d                	beqz	a0,1b58 <createdelete+0x116>
  for(pi = 0; pi < NCHILD; pi++){
    1a70:	2905                	addw	s2,s2,1
    1a72:	ff3917e3          	bne	s2,s3,1a60 <createdelete+0x1e>
    1a76:	4491                	li	s1,4
    wait(&xstatus);
    1a78:	f8c40513          	add	a0,s0,-116
    1a7c:	00004097          	auipc	ra,0x4
    1a80:	fa6080e7          	jalr	-90(ra) # 5a22 <wait>
    if(xstatus != 0)
    1a84:	f8c42903          	lw	s2,-116(s0)
    1a88:	16091563          	bnez	s2,1bf2 <createdelete+0x1b0>
  for(pi = 0; pi < NCHILD; pi++){
    1a8c:	34fd                	addw	s1,s1,-1
    1a8e:	f4ed                	bnez	s1,1a78 <createdelete+0x36>
  name[0] = name[1] = name[2] = 0;
    1a90:	f8040923          	sb	zero,-110(s0)
  for(i = 0; i < N; i++){
    1a94:	f9040a13          	add	s4,s0,-112
      if((i == 0 || i >= N/2) && fd < 0){
    1a98:	4b25                	li	s6,9
    for(pi = 0; pi < NCHILD; pi++){
    1a9a:	07400a93          	li	s5,116
  for(i = 0; i < N; i++){
    1a9e:	4bd1                	li	s7,20
      name[1] = '0' + i;
    1aa0:	0309099b          	addw	s3,s2,48
    1aa4:	0ff9f993          	zext.b	s3,s3
    1aa8:	07000493          	li	s1,112
    1aac:	0089999b          	sllw	s3,s3,0x8
      name[0] = 'p' + pi;
    1ab0:	0134e7b3          	or	a5,s1,s3
      fd = open(name, 0);
    1ab4:	4581                	li	a1,0
    1ab6:	8552                	mv	a0,s4
      name[0] = 'p' + pi;
    1ab8:	f8f41823          	sh	a5,-112(s0)
      fd = open(name, 0);
    1abc:	00004097          	auipc	ra,0x4
    1ac0:	f9e080e7          	jalr	-98(ra) # 5a5a <open>
      if((i == 0 || i >= N/2) && fd < 0){
    1ac4:	00090463          	beqz	s2,1acc <createdelete+0x8a>
    1ac8:	072b5763          	bge	s6,s2,1b36 <createdelete+0xf4>
    1acc:	10054963          	bltz	a0,1bde <createdelete+0x19c>
        close(fd);
    1ad0:	00004097          	auipc	ra,0x4
    1ad4:	f72080e7          	jalr	-142(ra) # 5a42 <close>
    for(pi = 0; pi < NCHILD; pi++){
    1ad8:	2485                	addw	s1,s1,1
    1ada:	0ff4f493          	zext.b	s1,s1
    1ade:	fd5499e3          	bne	s1,s5,1ab0 <createdelete+0x6e>
  for(i = 0; i < N; i++){
    1ae2:	2905                	addw	s2,s2,1
    1ae4:	fb791ee3          	bne	s2,s7,1aa0 <createdelete+0x5e>
    1ae8:	07000993          	li	s3,112
  for(i = 0; i < N; i++){
    1aec:	08400a93          	li	s5,132
      name[1] = '0' + i;
    1af0:	fc09891b          	addw	s2,s3,-64
    1af4:	0ff97913          	zext.b	s2,s2
    1af8:	0089191b          	sllw	s2,s2,0x8
    1afc:	0129e933          	or	s2,s3,s2
    1b00:	4491                	li	s1,4
      unlink(name);
    1b02:	8552                	mv	a0,s4
    for(pi = 0; pi < NCHILD; pi++){
    1b04:	34fd                	addw	s1,s1,-1
      name[0] = 'p' + i;
    1b06:	f9241823          	sh	s2,-112(s0)
      unlink(name);
    1b0a:	00004097          	auipc	ra,0x4
    1b0e:	f60080e7          	jalr	-160(ra) # 5a6a <unlink>
    for(pi = 0; pi < NCHILD; pi++){
    1b12:	f8e5                	bnez	s1,1b02 <createdelete+0xc0>
  for(i = 0; i < N; i++){
    1b14:	2985                	addw	s3,s3,1
    1b16:	0ff9f993          	zext.b	s3,s3
    1b1a:	fd599be3          	bne	s3,s5,1af0 <createdelete+0xae>
}
    1b1e:	70e6                	ld	ra,120(sp)
    1b20:	7446                	ld	s0,112(sp)
    1b22:	74a6                	ld	s1,104(sp)
    1b24:	7906                	ld	s2,96(sp)
    1b26:	69e6                	ld	s3,88(sp)
    1b28:	6a46                	ld	s4,80(sp)
    1b2a:	6aa6                	ld	s5,72(sp)
    1b2c:	6b06                	ld	s6,64(sp)
    1b2e:	7be2                	ld	s7,56(sp)
    1b30:	7c42                	ld	s8,48(sp)
    1b32:	6109                	add	sp,sp,128
    1b34:	8082                	ret
      } else if((i >= 1 && i < N/2) && fd >= 0){
    1b36:	fa0541e3          	bltz	a0,1ad8 <createdelete+0x96>
        printf("%s: oops createdelete %s did exist\n", s, name);
    1b3a:	00005517          	auipc	a0,0x5
    1b3e:	e0650513          	add	a0,a0,-506 # 6940 <malloc+0xafc>
    1b42:	8652                	mv	a2,s4
    1b44:	85e2                	mv	a1,s8
    1b46:	00004097          	auipc	ra,0x4
    1b4a:	22e080e7          	jalr	558(ra) # 5d74 <printf>
        exit(1);
    1b4e:	4505                	li	a0,1
    1b50:	00004097          	auipc	ra,0x4
    1b54:	eca080e7          	jalr	-310(ra) # 5a1a <exit>
      name[0] = 'p' + pi;
    1b58:	0709091b          	addw	s2,s2,112
    1b5c:	f9240823          	sb	s2,-112(s0)
      name[2] = '\0';
    1b60:	f8040923          	sb	zero,-110(s0)
      for(i = 0; i < N; i++){
    1b64:	f9040a13          	add	s4,s0,-112
    1b68:	4951                	li	s2,20
        name[1] = '0' + i;
    1b6a:	0304879b          	addw	a5,s1,48
        fd = open(name, O_CREATE | O_RDWR);
    1b6e:	20200593          	li	a1,514
    1b72:	8552                	mv	a0,s4
        name[1] = '0' + i;
    1b74:	f8f408a3          	sb	a5,-111(s0)
        fd = open(name, O_CREATE | O_RDWR);
    1b78:	00004097          	auipc	ra,0x4
    1b7c:	ee2080e7          	jalr	-286(ra) # 5a5a <open>
        if(fd < 0){
    1b80:	08054c63          	bltz	a0,1c18 <createdelete+0x1d6>
        close(fd);
    1b84:	00004097          	auipc	ra,0x4
    1b88:	ebe080e7          	jalr	-322(ra) # 5a42 <close>
        if(i > 0 && (i % 2 ) == 0){
    1b8c:	cc81                	beqz	s1,1ba4 <createdelete+0x162>
    1b8e:	0014f793          	and	a5,s1,1
    1b92:	cb99                	beqz	a5,1ba8 <createdelete+0x166>
      for(i = 0; i < N; i++){
    1b94:	2485                	addw	s1,s1,1
    1b96:	fd249ae3          	bne	s1,s2,1b6a <createdelete+0x128>
      exit(0);
    1b9a:	4501                	li	a0,0
    1b9c:	00004097          	auipc	ra,0x4
    1ba0:	e7e080e7          	jalr	-386(ra) # 5a1a <exit>
      for(i = 0; i < N; i++){
    1ba4:	4485                	li	s1,1
    1ba6:	b7d1                	j	1b6a <createdelete+0x128>
          name[1] = '0' + (i / 2);
    1ba8:	4014d79b          	sraw	a5,s1,0x1
    1bac:	0307879b          	addw	a5,a5,48
          if(unlink(name) < 0){
    1bb0:	8552                	mv	a0,s4
          name[1] = '0' + (i / 2);
    1bb2:	f8f408a3          	sb	a5,-111(s0)
          if(unlink(name) < 0){
    1bb6:	00004097          	auipc	ra,0x4
    1bba:	eb4080e7          	jalr	-332(ra) # 5a6a <unlink>
    1bbe:	fc055be3          	bgez	a0,1b94 <createdelete+0x152>
            printf("%s: unlink failed\n", s);
    1bc2:	00005517          	auipc	a0,0x5
    1bc6:	d3e50513          	add	a0,a0,-706 # 6900 <malloc+0xabc>
    1bca:	85e2                	mv	a1,s8
    1bcc:	00004097          	auipc	ra,0x4
    1bd0:	1a8080e7          	jalr	424(ra) # 5d74 <printf>
            exit(1);
    1bd4:	4505                	li	a0,1
    1bd6:	00004097          	auipc	ra,0x4
    1bda:	e44080e7          	jalr	-444(ra) # 5a1a <exit>
        printf("%s: oops createdelete %s didn't exist\n", s, name);
    1bde:	8652                	mv	a2,s4
    1be0:	85e2                	mv	a1,s8
    1be2:	00005517          	auipc	a0,0x5
    1be6:	d3650513          	add	a0,a0,-714 # 6918 <malloc+0xad4>
    1bea:	00004097          	auipc	ra,0x4
    1bee:	18a080e7          	jalr	394(ra) # 5d74 <printf>
        exit(1);
    1bf2:	4505                	li	a0,1
    1bf4:	00004097          	auipc	ra,0x4
    1bf8:	e26080e7          	jalr	-474(ra) # 5a1a <exit>
      printf("fork failed\n", s);
    1bfc:	00005517          	auipc	a0,0x5
    1c00:	f1c50513          	add	a0,a0,-228 # 6b18 <malloc+0xcd4>
    1c04:	85e2                	mv	a1,s8
    1c06:	00004097          	auipc	ra,0x4
    1c0a:	16e080e7          	jalr	366(ra) # 5d74 <printf>
      exit(1);
    1c0e:	4505                	li	a0,1
    1c10:	00004097          	auipc	ra,0x4
    1c14:	e0a080e7          	jalr	-502(ra) # 5a1a <exit>
          printf("%s: create failed\n", s);
    1c18:	00005517          	auipc	a0,0x5
    1c1c:	b9050513          	add	a0,a0,-1136 # 67a8 <malloc+0x964>
    1c20:	85e2                	mv	a1,s8
    1c22:	00004097          	auipc	ra,0x4
    1c26:	152080e7          	jalr	338(ra) # 5d74 <printf>
          exit(1);
    1c2a:	4505                	li	a0,1
    1c2c:	00004097          	auipc	ra,0x4
    1c30:	dee080e7          	jalr	-530(ra) # 5a1a <exit>

0000000000001c34 <linkunlink>:
{
    1c34:	711d                	add	sp,sp,-96
    1c36:	ec86                	sd	ra,88(sp)
    1c38:	e8a2                	sd	s0,80(sp)
    1c3a:	e4a6                	sd	s1,72(sp)
    1c3c:	1080                	add	s0,sp,96
    1c3e:	e0ca                	sd	s2,64(sp)
    1c40:	fc4e                	sd	s3,56(sp)
    1c42:	f852                	sd	s4,48(sp)
    1c44:	f456                	sd	s5,40(sp)
    1c46:	f05a                	sd	s6,32(sp)
    1c48:	ec5e                	sd	s7,24(sp)
    1c4a:	e862                	sd	s8,16(sp)
    1c4c:	e466                	sd	s9,8(sp)
    1c4e:	84aa                	mv	s1,a0
  unlink("x");
    1c50:	00004517          	auipc	a0,0x4
    1c54:	33850513          	add	a0,a0,824 # 5f88 <malloc+0x144>
    1c58:	00004097          	auipc	ra,0x4
    1c5c:	e12080e7          	jalr	-494(ra) # 5a6a <unlink>
  pid = fork();
    1c60:	00004097          	auipc	ra,0x4
    1c64:	db2080e7          	jalr	-590(ra) # 5a12 <fork>
  if(pid < 0){
    1c68:	0a054763          	bltz	a0,1d16 <linkunlink+0xe2>
    1c6c:	8c2a                	mv	s8,a0
  unsigned int x = (pid ? 1 : 97);
    1c6e:	06100493          	li	s1,97
    1c72:	e145                	bnez	a0,1d12 <linkunlink+0xde>
    x = x * 1103515245 + 12345;
    1c74:	41c659b7          	lui	s3,0x41c65
    1c78:	690d                	lui	s2,0x3
  unsigned int x = (pid ? 1 : 97);
    1c7a:	06400c93          	li	s9,100
    x = x * 1103515245 + 12345;
    1c7e:	e6d9899b          	addw	s3,s3,-403 # 41c64e6d <base+0x41c551f5>
    1c82:	0399091b          	addw	s2,s2,57 # 3039 <iputtest+0xa7>
    if((x % 3) == 0){
    1c86:	4a0d                	li	s4,3
    } else if((x % 3) == 1){
    1c88:	4b05                	li	s6,1
      unlink("x");
    1c8a:	00004a97          	auipc	s5,0x4
    1c8e:	2fea8a93          	add	s5,s5,766 # 5f88 <malloc+0x144>
      link("cat", "x");
    1c92:	00005b97          	auipc	s7,0x5
    1c96:	cd6b8b93          	add	s7,s7,-810 # 6968 <malloc+0xb24>
    1c9a:	a819                	j	1cb0 <linkunlink+0x7c>
    } else if((x % 3) == 1){
    1c9c:	07678463          	beq	a5,s6,1d04 <linkunlink+0xd0>
      unlink("x");
    1ca0:	8556                	mv	a0,s5
    1ca2:	00004097          	auipc	ra,0x4
    1ca6:	dc8080e7          	jalr	-568(ra) # 5a6a <unlink>
  for(i = 0; i < 100; i++){
    1caa:	3cfd                	addw	s9,s9,-1
    1cac:	020c8963          	beqz	s9,1cde <linkunlink+0xaa>
    x = x * 1103515245 + 12345;
    1cb0:	033487bb          	mulw	a5,s1,s3
    1cb4:	012784bb          	addw	s1,a5,s2
    if((x % 3) == 0){
    1cb8:	0344f73b          	remuw	a4,s1,s4
    1cbc:	0007079b          	sext.w	a5,a4
    1cc0:	fff1                	bnez	a5,1c9c <linkunlink+0x68>
      close(open("x", O_RDWR | O_CREATE));
    1cc2:	20200593          	li	a1,514
    1cc6:	8556                	mv	a0,s5
    1cc8:	00004097          	auipc	ra,0x4
    1ccc:	d92080e7          	jalr	-622(ra) # 5a5a <open>
  for(i = 0; i < 100; i++){
    1cd0:	3cfd                	addw	s9,s9,-1
      close(open("x", O_RDWR | O_CREATE));
    1cd2:	00004097          	auipc	ra,0x4
    1cd6:	d70080e7          	jalr	-656(ra) # 5a42 <close>
  for(i = 0; i < 100; i++){
    1cda:	fc0c9be3          	bnez	s9,1cb0 <linkunlink+0x7c>
    wait(0);
    1cde:	4501                	li	a0,0
  if(pid)
    1ce0:	040c0963          	beqz	s8,1d32 <linkunlink+0xfe>
}
    1ce4:	6446                	ld	s0,80(sp)
    1ce6:	60e6                	ld	ra,88(sp)
    1ce8:	64a6                	ld	s1,72(sp)
    1cea:	6906                	ld	s2,64(sp)
    1cec:	79e2                	ld	s3,56(sp)
    1cee:	7a42                	ld	s4,48(sp)
    1cf0:	7aa2                	ld	s5,40(sp)
    1cf2:	7b02                	ld	s6,32(sp)
    1cf4:	6be2                	ld	s7,24(sp)
    1cf6:	6c42                	ld	s8,16(sp)
    1cf8:	6ca2                	ld	s9,8(sp)
    1cfa:	6125                	add	sp,sp,96
    wait(0);
    1cfc:	00004317          	auipc	t1,0x4
    1d00:	d2630067          	jr	-730(t1) # 5a22 <wait>
      link("cat", "x");
    1d04:	85d6                	mv	a1,s5
    1d06:	855e                	mv	a0,s7
    1d08:	00004097          	auipc	ra,0x4
    1d0c:	d72080e7          	jalr	-654(ra) # 5a7a <link>
    1d10:	bf69                	j	1caa <linkunlink+0x76>
  unsigned int x = (pid ? 1 : 97);
    1d12:	4485                	li	s1,1
    1d14:	b785                	j	1c74 <linkunlink+0x40>
    printf("%s: fork failed\n", s);
    1d16:	00005517          	auipc	a0,0x5
    1d1a:	9fa50513          	add	a0,a0,-1542 # 6710 <malloc+0x8cc>
    1d1e:	85a6                	mv	a1,s1
    1d20:	00004097          	auipc	ra,0x4
    1d24:	054080e7          	jalr	84(ra) # 5d74 <printf>
    exit(1);
    1d28:	4505                	li	a0,1
    1d2a:	00004097          	auipc	ra,0x4
    1d2e:	cf0080e7          	jalr	-784(ra) # 5a1a <exit>
    exit(0);
    1d32:	00004097          	auipc	ra,0x4
    1d36:	ce8080e7          	jalr	-792(ra) # 5a1a <exit>

0000000000001d3a <forktest>:
{
    1d3a:	7179                	add	sp,sp,-48
    1d3c:	f022                	sd	s0,32(sp)
    1d3e:	ec26                	sd	s1,24(sp)
    1d40:	e84a                	sd	s2,16(sp)
    1d42:	e44e                	sd	s3,8(sp)
    1d44:	f406                	sd	ra,40(sp)
    1d46:	1800                	add	s0,sp,48
    1d48:	89aa                	mv	s3,a0
  for(n=0; n<N; n++){
    1d4a:	4481                	li	s1,0
    1d4c:	3e800913          	li	s2,1000
    1d50:	a029                	j	1d5a <forktest+0x20>
    if(pid == 0)
    1d52:	cd29                	beqz	a0,1dac <forktest+0x72>
  for(n=0; n<N; n++){
    1d54:	2485                	addw	s1,s1,1
    1d56:	09248b63          	beq	s1,s2,1dec <forktest+0xb2>
    pid = fork();
    1d5a:	00004097          	auipc	ra,0x4
    1d5e:	cb8080e7          	jalr	-840(ra) # 5a12 <fork>
    if(pid < 0)
    1d62:	fe0558e3          	bgez	a0,1d52 <forktest+0x18>
  if (n == 0) {
    1d66:	c88d                	beqz	s1,1d98 <forktest+0x5e>
    if(wait(0) < 0){
    1d68:	4501                	li	a0,0
    1d6a:	00004097          	auipc	ra,0x4
    1d6e:	cb8080e7          	jalr	-840(ra) # 5a22 <wait>
    1d72:	04054163          	bltz	a0,1db4 <forktest+0x7a>
  for(; n > 0; n--){
    1d76:	34fd                	addw	s1,s1,-1
    1d78:	f8e5                	bnez	s1,1d68 <forktest+0x2e>
  if(wait(0) != -1){
    1d7a:	4501                	li	a0,0
    1d7c:	00004097          	auipc	ra,0x4
    1d80:	ca6080e7          	jalr	-858(ra) # 5a22 <wait>
    1d84:	57fd                	li	a5,-1
    1d86:	04f51563          	bne	a0,a5,1dd0 <forktest+0x96>
}
    1d8a:	70a2                	ld	ra,40(sp)
    1d8c:	7402                	ld	s0,32(sp)
    1d8e:	64e2                	ld	s1,24(sp)
    1d90:	6942                	ld	s2,16(sp)
    1d92:	69a2                	ld	s3,8(sp)
    1d94:	6145                	add	sp,sp,48
    1d96:	8082                	ret
    printf("%s: no fork at all!\n", s);
    1d98:	00005517          	auipc	a0,0x5
    1d9c:	bd850513          	add	a0,a0,-1064 # 6970 <malloc+0xb2c>
    1da0:	85ce                	mv	a1,s3
    1da2:	00004097          	auipc	ra,0x4
    1da6:	fd2080e7          	jalr	-46(ra) # 5d74 <printf>
    exit(1);
    1daa:	4505                	li	a0,1
    1dac:	00004097          	auipc	ra,0x4
    1db0:	c6e080e7          	jalr	-914(ra) # 5a1a <exit>
      printf("%s: wait stopped early\n", s);
    1db4:	00005517          	auipc	a0,0x5
    1db8:	bd450513          	add	a0,a0,-1068 # 6988 <malloc+0xb44>
    1dbc:	85ce                	mv	a1,s3
    1dbe:	00004097          	auipc	ra,0x4
    1dc2:	fb6080e7          	jalr	-74(ra) # 5d74 <printf>
      exit(1);
    1dc6:	4505                	li	a0,1
    1dc8:	00004097          	auipc	ra,0x4
    1dcc:	c52080e7          	jalr	-942(ra) # 5a1a <exit>
    printf("%s: wait got too many\n", s);
    1dd0:	00005517          	auipc	a0,0x5
    1dd4:	bd050513          	add	a0,a0,-1072 # 69a0 <malloc+0xb5c>
    1dd8:	85ce                	mv	a1,s3
    1dda:	00004097          	auipc	ra,0x4
    1dde:	f9a080e7          	jalr	-102(ra) # 5d74 <printf>
    exit(1);
    1de2:	4505                	li	a0,1
    1de4:	00004097          	auipc	ra,0x4
    1de8:	c36080e7          	jalr	-970(ra) # 5a1a <exit>
    printf("%s: fork claimed to work 1000 times!\n", s);
    1dec:	00005517          	auipc	a0,0x5
    1df0:	bcc50513          	add	a0,a0,-1076 # 69b8 <malloc+0xb74>
    1df4:	85ce                	mv	a1,s3
    1df6:	00004097          	auipc	ra,0x4
    1dfa:	f7e080e7          	jalr	-130(ra) # 5d74 <printf>
    exit(1);
    1dfe:	4505                	li	a0,1
    1e00:	00004097          	auipc	ra,0x4
    1e04:	c1a080e7          	jalr	-998(ra) # 5a1a <exit>

0000000000001e08 <kernmem>:
{
    1e08:	715d                	add	sp,sp,-80
    1e0a:	f84a                	sd	s2,48(sp)
  for(a = (char*)(KERNBASE); a < (char*) (KERNBASE+2000000); a += 50000){
    1e0c:	1003d937          	lui	s2,0x1003d
{
    1e10:	e0a2                	sd	s0,64(sp)
    1e12:	fc26                	sd	s1,56(sp)
    1e14:	f44e                	sd	s3,40(sp)
    1e16:	f052                	sd	s4,32(sp)
    1e18:	ec56                	sd	s5,24(sp)
    1e1a:	e486                	sd	ra,72(sp)
    1e1c:	0880                	add	s0,sp,80
  for(a = (char*)(KERNBASE); a < (char*) (KERNBASE+2000000); a += 50000){
    1e1e:	4485                	li	s1,1
    1e20:	69b1                	lui	s3,0xc
    1e22:	090e                	sll	s2,s2,0x3
{
    1e24:	8aaa                	mv	s5,a0
  for(a = (char*)(KERNBASE); a < (char*) (KERNBASE+2000000); a += 50000){
    1e26:	04fe                	sll	s1,s1,0x1f
    if(xstatus != -1)  // did kernel kill child?
    1e28:	5a7d                	li	s4,-1
  for(a = (char*)(KERNBASE); a < (char*) (KERNBASE+2000000); a += 50000){
    1e2a:	35098993          	add	s3,s3,848 # c350 <uninit+0x1de8>
    1e2e:	48090913          	add	s2,s2,1152 # 1003d480 <base+0x1002d808>
    pid = fork();
    1e32:	00004097          	auipc	ra,0x4
    1e36:	be0080e7          	jalr	-1056(ra) # 5a12 <fork>
    if(pid < 0){
    1e3a:	02054963          	bltz	a0,1e6c <kernmem+0x64>
    if(pid == 0){
    1e3e:	c931                	beqz	a0,1e92 <kernmem+0x8a>
    wait(&xstatus);
    1e40:	fbc40513          	add	a0,s0,-68
    1e44:	00004097          	auipc	ra,0x4
    1e48:	bde080e7          	jalr	-1058(ra) # 5a22 <wait>
    if(xstatus != -1)  // did kernel kill child?
    1e4c:	fbc42783          	lw	a5,-68(s0)
    1e50:	03479c63          	bne	a5,s4,1e88 <kernmem+0x80>
  for(a = (char*)(KERNBASE); a < (char*) (KERNBASE+2000000); a += 50000){
    1e54:	94ce                	add	s1,s1,s3
    1e56:	fd249ee3          	bne	s1,s2,1e32 <kernmem+0x2a>
}
    1e5a:	60a6                	ld	ra,72(sp)
    1e5c:	6406                	ld	s0,64(sp)
    1e5e:	74e2                	ld	s1,56(sp)
    1e60:	7942                	ld	s2,48(sp)
    1e62:	79a2                	ld	s3,40(sp)
    1e64:	7a02                	ld	s4,32(sp)
    1e66:	6ae2                	ld	s5,24(sp)
    1e68:	6161                	add	sp,sp,80
    1e6a:	8082                	ret
      printf("%s: fork failed\n", s);
    1e6c:	00005517          	auipc	a0,0x5
    1e70:	8a450513          	add	a0,a0,-1884 # 6710 <malloc+0x8cc>
    1e74:	85d6                	mv	a1,s5
    1e76:	00004097          	auipc	ra,0x4
    1e7a:	efe080e7          	jalr	-258(ra) # 5d74 <printf>
      exit(1);
    1e7e:	4505                	li	a0,1
    1e80:	00004097          	auipc	ra,0x4
    1e84:	b9a080e7          	jalr	-1126(ra) # 5a1a <exit>
      exit(1);
    1e88:	4505                	li	a0,1
    1e8a:	00004097          	auipc	ra,0x4
    1e8e:	b90080e7          	jalr	-1136(ra) # 5a1a <exit>
      printf("%s: oops could read %x = %x\n", s, a, *a);
    1e92:	0004c683          	lbu	a3,0(s1)
    1e96:	00005517          	auipc	a0,0x5
    1e9a:	b4a50513          	add	a0,a0,-1206 # 69e0 <malloc+0xb9c>
    1e9e:	8626                	mv	a2,s1
    1ea0:	85d6                	mv	a1,s5
    1ea2:	00004097          	auipc	ra,0x4
    1ea6:	ed2080e7          	jalr	-302(ra) # 5d74 <printf>
      exit(1);
    1eaa:	4505                	li	a0,1
    1eac:	00004097          	auipc	ra,0x4
    1eb0:	b6e080e7          	jalr	-1170(ra) # 5a1a <exit>

0000000000001eb4 <MAXVAplus>:
{
    1eb4:	7179                	add	sp,sp,-48
    1eb6:	f022                	sd	s0,32(sp)
    1eb8:	f406                	sd	ra,40(sp)
    1eba:	1800                	add	s0,sp,48
  volatile uint64 a = MAXVA;
    1ebc:	4785                	li	a5,1
    1ebe:	179a                	sll	a5,a5,0x26
    1ec0:	fcf43c23          	sd	a5,-40(s0)
  for( ; a != 0; a <<= 1){
    1ec4:	fd843783          	ld	a5,-40(s0)
    1ec8:	c3a1                	beqz	a5,1f08 <MAXVAplus+0x54>
    1eca:	ec26                	sd	s1,24(sp)
    1ecc:	e84a                	sd	s2,16(sp)
    if(xstatus != -1)  // did kernel kill child?
    1ece:	54fd                	li	s1,-1
    1ed0:	892a                	mv	s2,a0
    pid = fork();
    1ed2:	00004097          	auipc	ra,0x4
    1ed6:	b40080e7          	jalr	-1216(ra) # 5a12 <fork>
    if(pid < 0){
    1eda:	02054b63          	bltz	a0,1f10 <MAXVAplus+0x5c>
    if(pid == 0){
    1ede:	cd21                	beqz	a0,1f36 <MAXVAplus+0x82>
    wait(&xstatus);
    1ee0:	fd440513          	add	a0,s0,-44
    1ee4:	00004097          	auipc	ra,0x4
    1ee8:	b3e080e7          	jalr	-1218(ra) # 5a22 <wait>
    if(xstatus != -1)  // did kernel kill child?
    1eec:	fd442783          	lw	a5,-44(s0)
    1ef0:	02979e63          	bne	a5,s1,1f2c <MAXVAplus+0x78>
  for( ; a != 0; a <<= 1){
    1ef4:	fd843783          	ld	a5,-40(s0)
    1ef8:	0786                	sll	a5,a5,0x1
    1efa:	fcf43c23          	sd	a5,-40(s0)
    1efe:	fd843783          	ld	a5,-40(s0)
    1f02:	fbe1                	bnez	a5,1ed2 <MAXVAplus+0x1e>
    1f04:	64e2                	ld	s1,24(sp)
    1f06:	6942                	ld	s2,16(sp)
}
    1f08:	70a2                	ld	ra,40(sp)
    1f0a:	7402                	ld	s0,32(sp)
    1f0c:	6145                	add	sp,sp,48
    1f0e:	8082                	ret
      printf("%s: fork failed\n", s);
    1f10:	00005517          	auipc	a0,0x5
    1f14:	80050513          	add	a0,a0,-2048 # 6710 <malloc+0x8cc>
    1f18:	85ca                	mv	a1,s2
    1f1a:	00004097          	auipc	ra,0x4
    1f1e:	e5a080e7          	jalr	-422(ra) # 5d74 <printf>
      exit(1);
    1f22:	4505                	li	a0,1
    1f24:	00004097          	auipc	ra,0x4
    1f28:	af6080e7          	jalr	-1290(ra) # 5a1a <exit>
      exit(1);
    1f2c:	4505                	li	a0,1
    1f2e:	00004097          	auipc	ra,0x4
    1f32:	aec080e7          	jalr	-1300(ra) # 5a1a <exit>
      *(char*)a = 99;
    1f36:	fd843783          	ld	a5,-40(s0)
      printf("%s: oops wrote %x\n", s, a);
    1f3a:	fd843603          	ld	a2,-40(s0)
      *(char*)a = 99;
    1f3e:	06300713          	li	a4,99
      printf("%s: oops wrote %x\n", s, a);
    1f42:	00005517          	auipc	a0,0x5
    1f46:	abe50513          	add	a0,a0,-1346 # 6a00 <malloc+0xbbc>
      *(char*)a = 99;
    1f4a:	00e78023          	sb	a4,0(a5)
      printf("%s: oops wrote %x\n", s, a);
    1f4e:	85ca                	mv	a1,s2
    1f50:	00004097          	auipc	ra,0x4
    1f54:	e24080e7          	jalr	-476(ra) # 5d74 <printf>
      exit(1);
    1f58:	4505                	li	a0,1
    1f5a:	00004097          	auipc	ra,0x4
    1f5e:	ac0080e7          	jalr	-1344(ra) # 5a1a <exit>

0000000000001f62 <bigargtest>:
{
    1f62:	7179                	add	sp,sp,-48
    1f64:	f406                	sd	ra,40(sp)
    1f66:	f022                	sd	s0,32(sp)
    1f68:	ec26                	sd	s1,24(sp)
    1f6a:	1800                	add	s0,sp,48
    1f6c:	84aa                	mv	s1,a0
  unlink("bigarg-ok");
    1f6e:	00005517          	auipc	a0,0x5
    1f72:	aaa50513          	add	a0,a0,-1366 # 6a18 <malloc+0xbd4>
    1f76:	00004097          	auipc	ra,0x4
    1f7a:	af4080e7          	jalr	-1292(ra) # 5a6a <unlink>
  pid = fork();
    1f7e:	00004097          	auipc	ra,0x4
    1f82:	a94080e7          	jalr	-1388(ra) # 5a12 <fork>
  if(pid == 0){
    1f86:	cd25                	beqz	a0,1ffe <bigargtest+0x9c>
  } else if(pid < 0){
    1f88:	04054d63          	bltz	a0,1fe2 <bigargtest+0x80>
  wait(&xstatus);
    1f8c:	fdc40513          	add	a0,s0,-36
    1f90:	00004097          	auipc	ra,0x4
    1f94:	a92080e7          	jalr	-1390(ra) # 5a22 <wait>
  if(xstatus != 0)
    1f98:	fdc42503          	lw	a0,-36(s0)
    1f9c:	ed1d                	bnez	a0,1fda <bigargtest+0x78>
  fd = open("bigarg-ok", 0);
    1f9e:	4581                	li	a1,0
    1fa0:	00005517          	auipc	a0,0x5
    1fa4:	a7850513          	add	a0,a0,-1416 # 6a18 <malloc+0xbd4>
    1fa8:	00004097          	auipc	ra,0x4
    1fac:	ab2080e7          	jalr	-1358(ra) # 5a5a <open>
  if(fd < 0){
    1fb0:	00054b63          	bltz	a0,1fc6 <bigargtest+0x64>
  close(fd);
    1fb4:	00004097          	auipc	ra,0x4
    1fb8:	a8e080e7          	jalr	-1394(ra) # 5a42 <close>
}
    1fbc:	70a2                	ld	ra,40(sp)
    1fbe:	7402                	ld	s0,32(sp)
    1fc0:	64e2                	ld	s1,24(sp)
    1fc2:	6145                	add	sp,sp,48
    1fc4:	8082                	ret
    printf("%s: bigarg test failed!\n", s);
    1fc6:	00005517          	auipc	a0,0x5
    1fca:	b6250513          	add	a0,a0,-1182 # 6b28 <malloc+0xce4>
    1fce:	85a6                	mv	a1,s1
    1fd0:	00004097          	auipc	ra,0x4
    1fd4:	da4080e7          	jalr	-604(ra) # 5d74 <printf>
    exit(1);
    1fd8:	4505                	li	a0,1
    1fda:	00004097          	auipc	ra,0x4
    1fde:	a40080e7          	jalr	-1472(ra) # 5a1a <exit>
    printf("%s: bigargtest: fork failed\n", s);
    1fe2:	00005517          	auipc	a0,0x5
    1fe6:	b2650513          	add	a0,a0,-1242 # 6b08 <malloc+0xcc4>
    1fea:	85a6                	mv	a1,s1
    1fec:	00004097          	auipc	ra,0x4
    1ff0:	d88080e7          	jalr	-632(ra) # 5d74 <printf>
    exit(1);
    1ff4:	4505                	li	a0,1
    1ff6:	00004097          	auipc	ra,0x4
    1ffa:	a24080e7          	jalr	-1500(ra) # 5a1a <exit>
    1ffe:	00007797          	auipc	a5,0x7
    2002:	46278793          	add	a5,a5,1122 # 9460 <args.1>
    2006:	00007697          	auipc	a3,0x7
    200a:	55268693          	add	a3,a3,1362 # 9558 <args.1+0xf8>
    200e:	00005717          	auipc	a4,0x5
    2012:	a1a70713          	add	a4,a4,-1510 # 6a28 <malloc+0xbe4>
      args[i] = "bigargs test: failed\n                                                                                                                                                                                                       ";
    2016:	e398                	sd	a4,0(a5)
    for(i = 0; i < MAXARG-1; i++)
    2018:	07a1                	add	a5,a5,8
    201a:	fed79ee3          	bne	a5,a3,2016 <bigargtest+0xb4>
    exec("echo", args);
    201e:	00007597          	auipc	a1,0x7
    2022:	44258593          	add	a1,a1,1090 # 9460 <args.1>
    2026:	00004517          	auipc	a0,0x4
    202a:	60250513          	add	a0,a0,1538 # 6628 <malloc+0x7e4>
    args[MAXARG-1] = 0;
    202e:	00007797          	auipc	a5,0x7
    2032:	5207b523          	sd	zero,1322(a5) # 9558 <args.1+0xf8>
    exec("echo", args);
    2036:	00004097          	auipc	ra,0x4
    203a:	a1c080e7          	jalr	-1508(ra) # 5a52 <exec>
    fd = open("bigarg-ok", O_CREATE);
    203e:	20000593          	li	a1,512
    2042:	00005517          	auipc	a0,0x5
    2046:	9d650513          	add	a0,a0,-1578 # 6a18 <malloc+0xbd4>
    204a:	00004097          	auipc	ra,0x4
    204e:	a10080e7          	jalr	-1520(ra) # 5a5a <open>
    close(fd);
    2052:	00004097          	auipc	ra,0x4
    2056:	9f0080e7          	jalr	-1552(ra) # 5a42 <close>
    exit(0);
    205a:	4501                	li	a0,0
    205c:	00004097          	auipc	ra,0x4
    2060:	9be080e7          	jalr	-1602(ra) # 5a1a <exit>

0000000000002064 <stacktest>:
{
    2064:	7179                	add	sp,sp,-48
    2066:	f022                	sd	s0,32(sp)
    2068:	ec26                	sd	s1,24(sp)
    206a:	f406                	sd	ra,40(sp)
    206c:	1800                	add	s0,sp,48
    206e:	84aa                	mv	s1,a0
  pid = fork();
    2070:	00004097          	auipc	ra,0x4
    2074:	9a2080e7          	jalr	-1630(ra) # 5a12 <fork>
  if(pid == 0) {
    2078:	c121                	beqz	a0,20b8 <stacktest+0x54>
  } else if(pid < 0){
    207a:	02054163          	bltz	a0,209c <stacktest+0x38>
  wait(&xstatus);
    207e:	fdc40513          	add	a0,s0,-36
    2082:	00004097          	auipc	ra,0x4
    2086:	9a0080e7          	jalr	-1632(ra) # 5a22 <wait>
  if(xstatus == -1)  // kernel killed child?
    208a:	fdc42503          	lw	a0,-36(s0)
    208e:	57fd                	li	a5,-1
    2090:	04f50763          	beq	a0,a5,20de <stacktest+0x7a>
    exit(xstatus);
    2094:	00004097          	auipc	ra,0x4
    2098:	986080e7          	jalr	-1658(ra) # 5a1a <exit>
    printf("%s: fork failed\n", s);
    209c:	00004517          	auipc	a0,0x4
    20a0:	67450513          	add	a0,a0,1652 # 6710 <malloc+0x8cc>
    20a4:	85a6                	mv	a1,s1
    20a6:	00004097          	auipc	ra,0x4
    20aa:	cce080e7          	jalr	-818(ra) # 5d74 <printf>
    exit(1);
    20ae:	4505                	li	a0,1
    20b0:	00004097          	auipc	ra,0x4
    20b4:	96a080e7          	jalr	-1686(ra) # 5a1a <exit>

static inline uint64
r_sp()
{
  uint64 x;
  __asm__ volatile("mv %0, sp" : "=r" (x) );
    20b8:	870a                	mv	a4,sp
    printf("%s: stacktest: read below stack %p\n", s, *sp);
    20ba:	77fd                	lui	a5,0xfffff
    20bc:	97ba                	add	a5,a5,a4
    20be:	0007c603          	lbu	a2,0(a5) # fffffffffffff000 <base+0xfffffffffffef388>
    20c2:	00005517          	auipc	a0,0x5
    20c6:	a8650513          	add	a0,a0,-1402 # 6b48 <malloc+0xd04>
    20ca:	85a6                	mv	a1,s1
    20cc:	00004097          	auipc	ra,0x4
    20d0:	ca8080e7          	jalr	-856(ra) # 5d74 <printf>
    exit(1);
    20d4:	4505                	li	a0,1
    20d6:	00004097          	auipc	ra,0x4
    20da:	944080e7          	jalr	-1724(ra) # 5a1a <exit>
    exit(0);
    20de:	4501                	li	a0,0
    20e0:	00004097          	auipc	ra,0x4
    20e4:	93a080e7          	jalr	-1734(ra) # 5a1a <exit>

00000000000020e8 <textwrite>:
{
    20e8:	7179                	add	sp,sp,-48
    20ea:	f022                	sd	s0,32(sp)
    20ec:	ec26                	sd	s1,24(sp)
    20ee:	f406                	sd	ra,40(sp)
    20f0:	1800                	add	s0,sp,48
    20f2:	84aa                	mv	s1,a0
  pid = fork();
    20f4:	00004097          	auipc	ra,0x4
    20f8:	91e080e7          	jalr	-1762(ra) # 5a12 <fork>
  if(pid == 0) {
    20fc:	c121                	beqz	a0,213c <textwrite+0x54>
  } else if(pid < 0){
    20fe:	02054163          	bltz	a0,2120 <textwrite+0x38>
  wait(&xstatus);
    2102:	fdc40513          	add	a0,s0,-36
    2106:	00004097          	auipc	ra,0x4
    210a:	91c080e7          	jalr	-1764(ra) # 5a22 <wait>
  if(xstatus == -1)  // kernel killed child?
    210e:	fdc42503          	lw	a0,-36(s0)
    2112:	57fd                	li	a5,-1
    2114:	02f50763          	beq	a0,a5,2142 <textwrite+0x5a>
    exit(xstatus);
    2118:	00004097          	auipc	ra,0x4
    211c:	902080e7          	jalr	-1790(ra) # 5a1a <exit>
    printf("%s: fork failed\n", s);
    2120:	00004517          	auipc	a0,0x4
    2124:	5f050513          	add	a0,a0,1520 # 6710 <malloc+0x8cc>
    2128:	85a6                	mv	a1,s1
    212a:	00004097          	auipc	ra,0x4
    212e:	c4a080e7          	jalr	-950(ra) # 5d74 <printf>
    exit(1);
    2132:	4505                	li	a0,1
    2134:	00004097          	auipc	ra,0x4
    2138:	8e6080e7          	jalr	-1818(ra) # 5a1a <exit>
    *addr = 10;
    213c:	00002023          	sw	zero,0(zero) # 0 <copyinstr1>
    2140:	9002                	ebreak
    exit(0);
    2142:	4501                	li	a0,0
    2144:	00004097          	auipc	ra,0x4
    2148:	8d6080e7          	jalr	-1834(ra) # 5a1a <exit>

000000000000214c <manywrites>:
{
    214c:	711d                	add	sp,sp,-96
    214e:	e8a2                	sd	s0,80(sp)
    2150:	e4a6                	sd	s1,72(sp)
    2152:	e0ca                	sd	s2,64(sp)
    2154:	f456                	sd	s5,40(sp)
    2156:	ec86                	sd	ra,88(sp)
    2158:	1080                	add	s0,sp,96
    215a:	8aaa                	mv	s5,a0
  for(int ci = 0; ci < nchildren; ci++){
    215c:	4481                	li	s1,0
    215e:	4911                	li	s2,4
    int pid = fork();
    2160:	00004097          	auipc	ra,0x4
    2164:	8b2080e7          	jalr	-1870(ra) # 5a12 <fork>
    if(pid < 0){
    2168:	02054e63          	bltz	a0,21a4 <manywrites+0x58>
    if(pid == 0){
    216c:	cd29                	beqz	a0,21c6 <manywrites+0x7a>
  for(int ci = 0; ci < nchildren; ci++){
    216e:	2485                	addw	s1,s1,1
    2170:	ff2498e3          	bne	s1,s2,2160 <manywrites+0x14>
    2174:	fc4e                	sd	s3,56(sp)
    2176:	f852                	sd	s4,48(sp)
    2178:	f05a                	sd	s6,32(sp)
    217a:	ec5e                	sd	s7,24(sp)
    217c:	4491                	li	s1,4
    217e:	fa840993          	add	s3,s0,-88
    wait(&st);
    2182:	854e                	mv	a0,s3
    int st = 0;
    2184:	fa042423          	sw	zero,-88(s0)
    wait(&st);
    2188:	00004097          	auipc	ra,0x4
    218c:	89a080e7          	jalr	-1894(ra) # 5a22 <wait>
    if(st != 0)
    2190:	fa842503          	lw	a0,-88(s0)
    2194:	e501                	bnez	a0,219c <manywrites+0x50>
  for(int ci = 0; ci < nchildren; ci++){
    2196:	34fd                	addw	s1,s1,-1
    2198:	f4ed                	bnez	s1,2182 <manywrites+0x36>
  exit(0);
    219a:	4501                	li	a0,0
    219c:	00004097          	auipc	ra,0x4
    21a0:	87e080e7          	jalr	-1922(ra) # 5a1a <exit>
      printf("fork failed\n");
    21a4:	00005517          	auipc	a0,0x5
    21a8:	97450513          	add	a0,a0,-1676 # 6b18 <malloc+0xcd4>
    21ac:	fc4e                	sd	s3,56(sp)
    21ae:	f852                	sd	s4,48(sp)
    21b0:	f05a                	sd	s6,32(sp)
    21b2:	ec5e                	sd	s7,24(sp)
    21b4:	00004097          	auipc	ra,0x4
    21b8:	bc0080e7          	jalr	-1088(ra) # 5d74 <printf>
      exit(1);
    21bc:	4505                	li	a0,1
    21be:	00004097          	auipc	ra,0x4
    21c2:	85c080e7          	jalr	-1956(ra) # 5a1a <exit>
    21c6:	fc4e                	sd	s3,56(sp)
      unlink(name);
    21c8:	fa840993          	add	s3,s0,-88
      name[1] = 'a' + ci;
    21cc:	0614879b          	addw	a5,s1,97
      name[0] = 'b';
    21d0:	06200713          	li	a4,98
      unlink(name);
    21d4:	854e                	mv	a0,s3
    21d6:	f05a                	sd	s6,32(sp)
    21d8:	ec5e                	sd	s7,24(sp)
      name[0] = 'b';
    21da:	f852                	sd	s4,48(sp)
    21dc:	fae40423          	sb	a4,-88(s0)
      name[1] = 'a' + ci;
    21e0:	faf404a3          	sb	a5,-87(s0)
      name[2] = '\0';
    21e4:	fa040523          	sb	zero,-86(s0)
      unlink(name);
    21e8:	4bf9                	li	s7,30
    21ea:	00004097          	auipc	ra,0x4
    21ee:	880080e7          	jalr	-1920(ra) # 5a6a <unlink>
          int cc = write(fd, buf, sz);
    21f2:	0000bb17          	auipc	s6,0xb
    21f6:	a86b0b13          	add	s6,s6,-1402 # cc78 <buf>
        for(int i = 0; i < ci+1; i++){
    21fa:	4a01                	li	s4,0
    21fc:	a015                	j	2220 <manywrites+0xd4>
          int cc = write(fd, buf, sz);
    21fe:	660d                	lui	a2,0x3
    2200:	85da                	mv	a1,s6
    2202:	00004097          	auipc	ra,0x4
    2206:	838080e7          	jalr	-1992(ra) # 5a3a <write>
          if(cc != sz){
    220a:	678d                	lui	a5,0x3
    220c:	06f51563          	bne	a0,a5,2276 <manywrites+0x12a>
          close(fd);
    2210:	854a                	mv	a0,s2
        for(int i = 0; i < ci+1; i++){
    2212:	2a05                	addw	s4,s4,1
          close(fd);
    2214:	00004097          	auipc	ra,0x4
    2218:	82e080e7          	jalr	-2002(ra) # 5a42 <close>
        for(int i = 0; i < ci+1; i++){
    221c:	0344cb63          	blt	s1,s4,2252 <manywrites+0x106>
          int fd = open(name, O_CREATE | O_RDWR);
    2220:	20200593          	li	a1,514
    2224:	854e                	mv	a0,s3
    2226:	00004097          	auipc	ra,0x4
    222a:	834080e7          	jalr	-1996(ra) # 5a5a <open>
    222e:	892a                	mv	s2,a0
          if(fd < 0){
    2230:	fc0557e3          	bgez	a0,21fe <manywrites+0xb2>
            printf("%s: cannot create %s\n", s, name);
    2234:	00005517          	auipc	a0,0x5
    2238:	93c50513          	add	a0,a0,-1732 # 6b70 <malloc+0xd2c>
    223c:	864e                	mv	a2,s3
    223e:	85d6                	mv	a1,s5
    2240:	00004097          	auipc	ra,0x4
    2244:	b34080e7          	jalr	-1228(ra) # 5d74 <printf>
            exit(1);
    2248:	4505                	li	a0,1
    224a:	00003097          	auipc	ra,0x3
    224e:	7d0080e7          	jalr	2000(ra) # 5a1a <exit>
        unlink(name);
    2252:	854e                	mv	a0,s3
      for(int iters = 0; iters < howmany; iters++){
    2254:	3bfd                	addw	s7,s7,-1
        unlink(name);
    2256:	00004097          	auipc	ra,0x4
    225a:	814080e7          	jalr	-2028(ra) # 5a6a <unlink>
      for(int iters = 0; iters < howmany; iters++){
    225e:	f80b9ee3          	bnez	s7,21fa <manywrites+0xae>
      unlink(name);
    2262:	854e                	mv	a0,s3
    2264:	00004097          	auipc	ra,0x4
    2268:	806080e7          	jalr	-2042(ra) # 5a6a <unlink>
      exit(0);
    226c:	4501                	li	a0,0
    226e:	00003097          	auipc	ra,0x3
    2272:	7ac080e7          	jalr	1964(ra) # 5a1a <exit>
            printf("%s: write(%d) ret %d\n", s, sz, cc);
    2276:	86aa                	mv	a3,a0
    2278:	660d                	lui	a2,0x3
    227a:	00004517          	auipc	a0,0x4
    227e:	d6e50513          	add	a0,a0,-658 # 5fe8 <malloc+0x1a4>
    2282:	85d6                	mv	a1,s5
    2284:	00004097          	auipc	ra,0x4
    2288:	af0080e7          	jalr	-1296(ra) # 5d74 <printf>
            exit(1);
    228c:	4505                	li	a0,1
    228e:	00003097          	auipc	ra,0x3
    2292:	78c080e7          	jalr	1932(ra) # 5a1a <exit>

0000000000002296 <copyinstr3>:
{
    2296:	7139                	add	sp,sp,-64
    2298:	fc06                	sd	ra,56(sp)
    229a:	f822                	sd	s0,48(sp)
    229c:	f426                	sd	s1,40(sp)
    229e:	0080                	add	s0,sp,64
    22a0:	f04a                	sd	s2,32(sp)
    22a2:	ec4e                	sd	s3,24(sp)
  sbrk(8192);
    22a4:	6509                	lui	a0,0x2
    22a6:	00003097          	auipc	ra,0x3
    22aa:	7fc080e7          	jalr	2044(ra) # 5aa2 <sbrk>
  uint64 top = (uint64) sbrk(0);
    22ae:	4501                	li	a0,0
    22b0:	00003097          	auipc	ra,0x3
    22b4:	7f2080e7          	jalr	2034(ra) # 5aa2 <sbrk>
  if((top % PGSIZE) != 0){
    22b8:	1552                	sll	a0,a0,0x34
    22ba:	e541                	bnez	a0,2342 <copyinstr3+0xac>
  top = (uint64) sbrk(0);
    22bc:	4501                	li	a0,0
    22be:	00003097          	auipc	ra,0x3
    22c2:	7e4080e7          	jalr	2020(ra) # 5aa2 <sbrk>
  if(top % PGSIZE){
    22c6:	03451793          	sll	a5,a0,0x34
    22ca:	10079263          	bnez	a5,23ce <copyinstr3+0x138>
  *b = 'x';
    22ce:	07800793          	li	a5,120
  char *b = (char *) (top - 1);
    22d2:	fff50493          	add	s1,a0,-1 # 1fff <bigargtest+0x9d>
  *b = 'x';
    22d6:	fef50fa3          	sb	a5,-1(a0)
  int ret = unlink(b);
    22da:	8526                	mv	a0,s1
    22dc:	00003097          	auipc	ra,0x3
    22e0:	78e080e7          	jalr	1934(ra) # 5a6a <unlink>
  if(ret != -1){
    22e4:	57fd                	li	a5,-1
  int ret = unlink(b);
    22e6:	892a                	mv	s2,a0
  if(ret != -1){
    22e8:	0cf51463          	bne	a0,a5,23b0 <copyinstr3+0x11a>
  int fd = open(b, O_CREATE | O_WRONLY);
    22ec:	20100593          	li	a1,513
    22f0:	8526                	mv	a0,s1
    22f2:	00003097          	auipc	ra,0x3
    22f6:	768080e7          	jalr	1896(ra) # 5a5a <open>
    22fa:	89aa                	mv	s3,a0
  if(fd != -1){
    22fc:	09251b63          	bne	a0,s2,2392 <copyinstr3+0xfc>
  ret = link(b, b);
    2300:	85a6                	mv	a1,s1
    2302:	8526                	mv	a0,s1
    2304:	00003097          	auipc	ra,0x3
    2308:	776080e7          	jalr	1910(ra) # 5a7a <link>
    230c:	892a                	mv	s2,a0
  if(ret != -1){
    230e:	07351263          	bne	a0,s3,2372 <copyinstr3+0xdc>
  char *args[] = { "xx", 0 };
    2312:	00005797          	auipc	a5,0x5
    2316:	54e78793          	add	a5,a5,1358 # 7860 <malloc+0x1a1c>
  ret = exec(b, args);
    231a:	fc040593          	add	a1,s0,-64
    231e:	8526                	mv	a0,s1
  char *args[] = { "xx", 0 };
    2320:	fcf43023          	sd	a5,-64(s0)
    2324:	fc043423          	sd	zero,-56(s0)
  ret = exec(b, args);
    2328:	00003097          	auipc	ra,0x3
    232c:	72a080e7          	jalr	1834(ra) # 5a52 <exec>
  if(ret != -1){
    2330:	03251263          	bne	a0,s2,2354 <copyinstr3+0xbe>
}
    2334:	70e2                	ld	ra,56(sp)
    2336:	7442                	ld	s0,48(sp)
    2338:	74a2                	ld	s1,40(sp)
    233a:	7902                	ld	s2,32(sp)
    233c:	69e2                	ld	s3,24(sp)
    233e:	6121                	add	sp,sp,64
    2340:	8082                	ret
    sbrk(PGSIZE - (top % PGSIZE));
    2342:	03455793          	srl	a5,a0,0x34
    2346:	6505                	lui	a0,0x1
    2348:	9d1d                	subw	a0,a0,a5
    234a:	00003097          	auipc	ra,0x3
    234e:	758080e7          	jalr	1880(ra) # 5aa2 <sbrk>
    2352:	b7ad                	j	22bc <copyinstr3+0x26>
    printf("exec(%s) returned %d, not -1\n", b, fd);
    2354:	00004517          	auipc	a0,0x4
    2358:	34450513          	add	a0,a0,836 # 6698 <malloc+0x854>
    235c:	567d                	li	a2,-1
    235e:	85a6                	mv	a1,s1
    2360:	00004097          	auipc	ra,0x4
    2364:	a14080e7          	jalr	-1516(ra) # 5d74 <printf>
    exit(1);
    2368:	4505                	li	a0,1
    236a:	00003097          	auipc	ra,0x3
    236e:	6b0080e7          	jalr	1712(ra) # 5a1a <exit>
    printf("link(%s, %s) returned %d, not -1\n", b, b, ret);
    2372:	86aa                	mv	a3,a0
    2374:	8626                	mv	a2,s1
    2376:	00004517          	auipc	a0,0x4
    237a:	2fa50513          	add	a0,a0,762 # 6670 <malloc+0x82c>
    237e:	85a6                	mv	a1,s1
    2380:	00004097          	auipc	ra,0x4
    2384:	9f4080e7          	jalr	-1548(ra) # 5d74 <printf>
    exit(1);
    2388:	4505                	li	a0,1
    238a:	00003097          	auipc	ra,0x3
    238e:	690080e7          	jalr	1680(ra) # 5a1a <exit>
    printf("open(%s) returned %d, not -1\n", b, fd);
    2392:	862a                	mv	a2,a0
    2394:	85a6                	mv	a1,s1
    2396:	00004517          	auipc	a0,0x4
    239a:	2ba50513          	add	a0,a0,698 # 6650 <malloc+0x80c>
    239e:	00004097          	auipc	ra,0x4
    23a2:	9d6080e7          	jalr	-1578(ra) # 5d74 <printf>
    exit(1);
    23a6:	4505                	li	a0,1
    23a8:	00003097          	auipc	ra,0x3
    23ac:	672080e7          	jalr	1650(ra) # 5a1a <exit>
    printf("unlink(%s) returned %d, not -1\n", b, ret);
    23b0:	862a                	mv	a2,a0
    23b2:	85a6                	mv	a1,s1
    23b4:	00004517          	auipc	a0,0x4
    23b8:	27c50513          	add	a0,a0,636 # 6630 <malloc+0x7ec>
    23bc:	00004097          	auipc	ra,0x4
    23c0:	9b8080e7          	jalr	-1608(ra) # 5d74 <printf>
    exit(1);
    23c4:	4505                	li	a0,1
    23c6:	00003097          	auipc	ra,0x3
    23ca:	654080e7          	jalr	1620(ra) # 5a1a <exit>
    printf("oops\n");
    23ce:	00004517          	auipc	a0,0x4
    23d2:	7ba50513          	add	a0,a0,1978 # 6b88 <malloc+0xd44>
    23d6:	00004097          	auipc	ra,0x4
    23da:	99e080e7          	jalr	-1634(ra) # 5d74 <printf>
    exit(1);
    23de:	4505                	li	a0,1
    23e0:	00003097          	auipc	ra,0x3
    23e4:	63a080e7          	jalr	1594(ra) # 5a1a <exit>

00000000000023e8 <rwsbrk>:
{
    23e8:	1101                	add	sp,sp,-32
    23ea:	e822                	sd	s0,16(sp)
    23ec:	e04a                	sd	s2,0(sp)
    23ee:	ec06                	sd	ra,24(sp)
    23f0:	1000                	add	s0,sp,32
  uint64 a = (uint64) sbrk(8192);
    23f2:	6509                	lui	a0,0x2
    23f4:	00003097          	auipc	ra,0x3
    23f8:	6ae080e7          	jalr	1710(ra) # 5aa2 <sbrk>
  if(a == 0xffffffffffffffffLL) {
    23fc:	597d                	li	s2,-1
    23fe:	e426                	sd	s1,8(sp)
    2400:	07250e63          	beq	a0,s2,247c <rwsbrk+0x94>
  if ((uint64) sbrk(-8192) ==  0xffffffffffffffffLL) {
    2404:	84aa                	mv	s1,a0
    2406:	7579                	lui	a0,0xffffe
    2408:	00003097          	auipc	ra,0x3
    240c:	69a080e7          	jalr	1690(ra) # 5aa2 <sbrk>
    2410:	05250963          	beq	a0,s2,2462 <rwsbrk+0x7a>
  fd = open("rwsbrk", O_CREATE|O_WRONLY);
    2414:	20100593          	li	a1,513
    2418:	00004517          	auipc	a0,0x4
    241c:	7b050513          	add	a0,a0,1968 # 6bc8 <malloc+0xd84>
    2420:	00003097          	auipc	ra,0x3
    2424:	63a080e7          	jalr	1594(ra) # 5a5a <open>
    2428:	892a                	mv	s2,a0
  if(fd < 0){
    242a:	06054663          	bltz	a0,2496 <rwsbrk+0xae>
  n = write(fd, (void*)(a+4096), 1024);
    242e:	6785                	lui	a5,0x1
    2430:	94be                	add	s1,s1,a5
    2432:	40000613          	li	a2,1024
    2436:	85a6                	mv	a1,s1
    2438:	00003097          	auipc	ra,0x3
    243c:	602080e7          	jalr	1538(ra) # 5a3a <write>
    2440:	862a                	mv	a2,a0
  if(n >= 0){
    2442:	06054763          	bltz	a0,24b0 <rwsbrk+0xc8>
    printf("write(fd, %p, 1024) returned %d, not -1\n", a+4096, n);
    2446:	00004517          	auipc	a0,0x4
    244a:	7a250513          	add	a0,a0,1954 # 6be8 <malloc+0xda4>
    244e:	85a6                	mv	a1,s1
    2450:	00004097          	auipc	ra,0x4
    2454:	924080e7          	jalr	-1756(ra) # 5d74 <printf>
    exit(1);
    2458:	4505                	li	a0,1
    245a:	00003097          	auipc	ra,0x3
    245e:	5c0080e7          	jalr	1472(ra) # 5a1a <exit>
    printf("sbrk(rwsbrk) shrink failed\n");
    2462:	00004517          	auipc	a0,0x4
    2466:	74650513          	add	a0,a0,1862 # 6ba8 <malloc+0xd64>
    246a:	00004097          	auipc	ra,0x4
    246e:	90a080e7          	jalr	-1782(ra) # 5d74 <printf>
    exit(1);
    2472:	4505                	li	a0,1
    2474:	00003097          	auipc	ra,0x3
    2478:	5a6080e7          	jalr	1446(ra) # 5a1a <exit>
    printf("sbrk(rwsbrk) failed\n");
    247c:	00004517          	auipc	a0,0x4
    2480:	71450513          	add	a0,a0,1812 # 6b90 <malloc+0xd4c>
    2484:	00004097          	auipc	ra,0x4
    2488:	8f0080e7          	jalr	-1808(ra) # 5d74 <printf>
    exit(1);
    248c:	4505                	li	a0,1
    248e:	00003097          	auipc	ra,0x3
    2492:	58c080e7          	jalr	1420(ra) # 5a1a <exit>
    printf("open(rwsbrk) failed\n");
    2496:	00004517          	auipc	a0,0x4
    249a:	73a50513          	add	a0,a0,1850 # 6bd0 <malloc+0xd8c>
    249e:	00004097          	auipc	ra,0x4
    24a2:	8d6080e7          	jalr	-1834(ra) # 5d74 <printf>
    exit(1);
    24a6:	4505                	li	a0,1
    24a8:	00003097          	auipc	ra,0x3
    24ac:	572080e7          	jalr	1394(ra) # 5a1a <exit>
  close(fd);
    24b0:	854a                	mv	a0,s2
    24b2:	00003097          	auipc	ra,0x3
    24b6:	590080e7          	jalr	1424(ra) # 5a42 <close>
  unlink("rwsbrk");
    24ba:	00004517          	auipc	a0,0x4
    24be:	70e50513          	add	a0,a0,1806 # 6bc8 <malloc+0xd84>
    24c2:	00003097          	auipc	ra,0x3
    24c6:	5a8080e7          	jalr	1448(ra) # 5a6a <unlink>
  fd = open("README", O_RDONLY);
    24ca:	4581                	li	a1,0
    24cc:	00004517          	auipc	a0,0x4
    24d0:	c2450513          	add	a0,a0,-988 # 60f0 <malloc+0x2ac>
    24d4:	00003097          	auipc	ra,0x3
    24d8:	586080e7          	jalr	1414(ra) # 5a5a <open>
    24dc:	892a                	mv	s2,a0
  if(fd < 0){
    24de:	fa054ce3          	bltz	a0,2496 <rwsbrk+0xae>
  n = read(fd, (void*)(a+4096), 10);
    24e2:	4629                	li	a2,10
    24e4:	85a6                	mv	a1,s1
    24e6:	00003097          	auipc	ra,0x3
    24ea:	54c080e7          	jalr	1356(ra) # 5a32 <read>
    24ee:	862a                	mv	a2,a0
  if(n >= 0){
    24f0:	02054063          	bltz	a0,2510 <rwsbrk+0x128>
    printf("read(fd, %p, 10) returned %d, not -1\n", a+4096, n);
    24f4:	00004517          	auipc	a0,0x4
    24f8:	72450513          	add	a0,a0,1828 # 6c18 <malloc+0xdd4>
    24fc:	85a6                	mv	a1,s1
    24fe:	00004097          	auipc	ra,0x4
    2502:	876080e7          	jalr	-1930(ra) # 5d74 <printf>
    exit(1);
    2506:	4505                	li	a0,1
    2508:	00003097          	auipc	ra,0x3
    250c:	512080e7          	jalr	1298(ra) # 5a1a <exit>
  close(fd);
    2510:	854a                	mv	a0,s2
    2512:	00003097          	auipc	ra,0x3
    2516:	530080e7          	jalr	1328(ra) # 5a42 <close>
  exit(0);
    251a:	4501                	li	a0,0
    251c:	00003097          	auipc	ra,0x3
    2520:	4fe080e7          	jalr	1278(ra) # 5a1a <exit>

0000000000002524 <sbrkbasic>:
{
    2524:	7139                	add	sp,sp,-64
    2526:	f822                	sd	s0,48(sp)
    2528:	ec4e                	sd	s3,24(sp)
    252a:	fc06                	sd	ra,56(sp)
    252c:	0080                	add	s0,sp,64
    252e:	89aa                	mv	s3,a0
  pid = fork();
    2530:	00003097          	auipc	ra,0x3
    2534:	4e2080e7          	jalr	1250(ra) # 5a12 <fork>
  if(pid < 0){
    2538:	f426                	sd	s1,40(sp)
    253a:	f04a                	sd	s2,32(sp)
    253c:	e852                	sd	s4,16(sp)
    253e:	0a054363          	bltz	a0,25e4 <sbrkbasic+0xc0>
  if(pid == 0){
    2542:	c925                	beqz	a0,25b2 <sbrkbasic+0x8e>
  wait(&xstatus);
    2544:	fcc40513          	add	a0,s0,-52
    2548:	00003097          	auipc	ra,0x3
    254c:	4da080e7          	jalr	1242(ra) # 5a22 <wait>
  if(xstatus == 1){
    2550:	fcc42703          	lw	a4,-52(s0)
    2554:	4785                	li	a5,1
    2556:	0af70463          	beq	a4,a5,25fe <sbrkbasic+0xda>
  a = sbrk(0);
    255a:	4501                	li	a0,0
    255c:	00003097          	auipc	ra,0x3
    2560:	546080e7          	jalr	1350(ra) # 5aa2 <sbrk>
  for(i = 0; i < 5000; i++){
    2564:	6a05                	lui	s4,0x1
  a = sbrk(0);
    2566:	84aa                	mv	s1,a0
  for(i = 0; i < 5000; i++){
    2568:	4901                	li	s2,0
    256a:	388a0a13          	add	s4,s4,904 # 1388 <truncate3+0xd8>
    256e:	a811                	j	2582 <sbrkbasic+0x5e>
    *b = 1;
    2570:	4785                	li	a5,1
    2572:	00f48023          	sb	a5,0(s1)
  for(i = 0; i < 5000; i++){
    2576:	2905                	addw	s2,s2,1
    a = b + 1;
    2578:	00148793          	add	a5,s1,1
  for(i = 0; i < 5000; i++){
    257c:	0b490063          	beq	s2,s4,261c <sbrkbasic+0xf8>
    2580:	84be                	mv	s1,a5
    b = sbrk(1);
    2582:	4505                	li	a0,1
    2584:	00003097          	auipc	ra,0x3
    2588:	51e080e7          	jalr	1310(ra) # 5aa2 <sbrk>
    if(b != a){
    258c:	fe9502e3          	beq	a0,s1,2570 <sbrkbasic+0x4c>
      printf("%s: sbrk test failed %d %x %x\n", s, i, a, b);
    2590:	872a                	mv	a4,a0
    2592:	86a6                	mv	a3,s1
    2594:	00004517          	auipc	a0,0x4
    2598:	6ec50513          	add	a0,a0,1772 # 6c80 <malloc+0xe3c>
    259c:	864a                	mv	a2,s2
    259e:	85ce                	mv	a1,s3
    25a0:	00003097          	auipc	ra,0x3
    25a4:	7d4080e7          	jalr	2004(ra) # 5d74 <printf>
      exit(1);
    25a8:	4505                	li	a0,1
    25aa:	00003097          	auipc	ra,0x3
    25ae:	470080e7          	jalr	1136(ra) # 5a1a <exit>
    a = sbrk(TOOMUCH);
    25b2:	40000537          	lui	a0,0x40000
    25b6:	00003097          	auipc	ra,0x3
    25ba:	4ec080e7          	jalr	1260(ra) # 5aa2 <sbrk>
    if(a == (char*)0xffffffffffffffffL){
    25be:	57fd                	li	a5,-1
    25c0:	04f50963          	beq	a0,a5,2612 <sbrkbasic+0xee>
    for(b = a; b < a+TOOMUCH; b += 4096){
    25c4:	400007b7          	lui	a5,0x40000
    25c8:	97aa                	add	a5,a5,a0
      *b = 99;
    25ca:	06300693          	li	a3,99
    for(b = a; b < a+TOOMUCH; b += 4096){
    25ce:	6705                	lui	a4,0x1
      *b = 99;
    25d0:	00d50023          	sb	a3,0(a0) # 40000000 <base+0x3fff0388>
    for(b = a; b < a+TOOMUCH; b += 4096){
    25d4:	953a                	add	a0,a0,a4
    25d6:	fef51de3          	bne	a0,a5,25d0 <sbrkbasic+0xac>
    exit(1);
    25da:	4505                	li	a0,1
    25dc:	00003097          	auipc	ra,0x3
    25e0:	43e080e7          	jalr	1086(ra) # 5a1a <exit>
    printf("fork failed in sbrkbasic\n");
    25e4:	00004517          	auipc	a0,0x4
    25e8:	65c50513          	add	a0,a0,1628 # 6c40 <malloc+0xdfc>
    25ec:	00003097          	auipc	ra,0x3
    25f0:	788080e7          	jalr	1928(ra) # 5d74 <printf>
    exit(1);
    25f4:	4505                	li	a0,1
    25f6:	00003097          	auipc	ra,0x3
    25fa:	424080e7          	jalr	1060(ra) # 5a1a <exit>
    printf("%s: too much memory allocated!\n", s);
    25fe:	85ce                	mv	a1,s3
    2600:	00004517          	auipc	a0,0x4
    2604:	66050513          	add	a0,a0,1632 # 6c60 <malloc+0xe1c>
    2608:	00003097          	auipc	ra,0x3
    260c:	76c080e7          	jalr	1900(ra) # 5d74 <printf>
    2610:	b7e9                	j	25da <sbrkbasic+0xb6>
      exit(0);
    2612:	4501                	li	a0,0
    2614:	00003097          	auipc	ra,0x3
    2618:	406080e7          	jalr	1030(ra) # 5a1a <exit>
  pid = fork();
    261c:	00003097          	auipc	ra,0x3
    2620:	3f6080e7          	jalr	1014(ra) # 5a12 <fork>
    2624:	892a                	mv	s2,a0
  if(pid < 0){
    2626:	02054d63          	bltz	a0,2660 <sbrkbasic+0x13c>
  c = sbrk(1);
    262a:	4505                	li	a0,1
    262c:	00003097          	auipc	ra,0x3
    2630:	476080e7          	jalr	1142(ra) # 5aa2 <sbrk>
  c = sbrk(1);
    2634:	4505                	li	a0,1
    2636:	00003097          	auipc	ra,0x3
    263a:	46c080e7          	jalr	1132(ra) # 5aa2 <sbrk>
  if(c != a + 1){
    263e:	0489                	add	s1,s1,2
    2640:	02a48e63          	beq	s1,a0,267c <sbrkbasic+0x158>
    printf("%s: sbrk test failed post-fork\n", s);
    2644:	00004517          	auipc	a0,0x4
    2648:	67c50513          	add	a0,a0,1660 # 6cc0 <malloc+0xe7c>
    264c:	85ce                	mv	a1,s3
    264e:	00003097          	auipc	ra,0x3
    2652:	726080e7          	jalr	1830(ra) # 5d74 <printf>
    exit(1);
    2656:	4505                	li	a0,1
    2658:	00003097          	auipc	ra,0x3
    265c:	3c2080e7          	jalr	962(ra) # 5a1a <exit>
    printf("%s: sbrk test fork failed\n", s);
    2660:	00004517          	auipc	a0,0x4
    2664:	64050513          	add	a0,a0,1600 # 6ca0 <malloc+0xe5c>
    2668:	85ce                	mv	a1,s3
    266a:	00003097          	auipc	ra,0x3
    266e:	70a080e7          	jalr	1802(ra) # 5d74 <printf>
    exit(1);
    2672:	4505                	li	a0,1
    2674:	00003097          	auipc	ra,0x3
    2678:	3a6080e7          	jalr	934(ra) # 5a1a <exit>
  if(pid == 0)
    267c:	f8090be3          	beqz	s2,2612 <sbrkbasic+0xee>
  wait(&xstatus);
    2680:	fcc40513          	add	a0,s0,-52
    2684:	00003097          	auipc	ra,0x3
    2688:	39e080e7          	jalr	926(ra) # 5a22 <wait>
  exit(xstatus);
    268c:	fcc42503          	lw	a0,-52(s0)
    2690:	00003097          	auipc	ra,0x3
    2694:	38a080e7          	jalr	906(ra) # 5a1a <exit>

0000000000002698 <sbrkmuch>:
{
    2698:	7139                	add	sp,sp,-64
    269a:	fc06                	sd	ra,56(sp)
    269c:	f822                	sd	s0,48(sp)
    269e:	f426                	sd	s1,40(sp)
    26a0:	ec4e                	sd	s3,24(sp)
    26a2:	e852                	sd	s4,16(sp)
    26a4:	0080                	add	s0,sp,64
    26a6:	f04a                	sd	s2,32(sp)
    26a8:	e456                	sd	s5,8(sp)
    26aa:	e05a                	sd	s6,0(sp)
    26ac:	8a2a                	mv	s4,a0
  oldbrk = sbrk(0);
    26ae:	4501                	li	a0,0
    26b0:	00003097          	auipc	ra,0x3
    26b4:	3f2080e7          	jalr	1010(ra) # 5aa2 <sbrk>
    26b8:	89aa                	mv	s3,a0
  a = sbrk(0);
    26ba:	4501                	li	a0,0
    26bc:	00003097          	auipc	ra,0x3
    26c0:	3e6080e7          	jalr	998(ra) # 5aa2 <sbrk>
    26c4:	84aa                	mv	s1,a0
  amt = BIG - (uint64)a;
    26c6:	06400537          	lui	a0,0x6400
  p = sbrk(amt);
    26ca:	9d05                	subw	a0,a0,s1
    26cc:	00003097          	auipc	ra,0x3
    26d0:	3d6080e7          	jalr	982(ra) # 5aa2 <sbrk>
  if (p != a) {
    26d4:	12a49563          	bne	s1,a0,27fe <sbrkmuch+0x166>
  char *eee = sbrk(0);
    26d8:	4501                	li	a0,0
    26da:	00003097          	auipc	ra,0x3
    26de:	3c8080e7          	jalr	968(ra) # 5aa2 <sbrk>
    26e2:	87aa                	mv	a5,a0
  for(char *pp = a; pp < eee; pp += 4096)
    26e4:	00a4f963          	bgeu	s1,a0,26f6 <sbrkmuch+0x5e>
    *pp = 1;
    26e8:	4685                	li	a3,1
  for(char *pp = a; pp < eee; pp += 4096)
    26ea:	6705                	lui	a4,0x1
    *pp = 1;
    26ec:	00d48023          	sb	a3,0(s1)
  for(char *pp = a; pp < eee; pp += 4096)
    26f0:	94ba                	add	s1,s1,a4
    26f2:	fef4ede3          	bltu	s1,a5,26ec <sbrkmuch+0x54>
  *lastaddr = 99;
    26f6:	064004b7          	lui	s1,0x6400
    26fa:	14fd                	add	s1,s1,-1 # 63fffff <base+0x63f0387>
    26fc:	06300a93          	li	s5,99
    2700:	01548023          	sb	s5,0(s1)
  a = sbrk(0);
    2704:	4501                	li	a0,0
    2706:	00003097          	auipc	ra,0x3
    270a:	39c080e7          	jalr	924(ra) # 5aa2 <sbrk>
    270e:	892a                	mv	s2,a0
  c = sbrk(-PGSIZE);
    2710:	757d                	lui	a0,0xfffff
    2712:	00003097          	auipc	ra,0x3
    2716:	390080e7          	jalr	912(ra) # 5aa2 <sbrk>
  if(c == (char*)0xffffffffffffffffL){
    271a:	57fd                	li	a5,-1
    271c:	0cf50363          	beq	a0,a5,27e2 <sbrkmuch+0x14a>
  c = sbrk(0);
    2720:	4501                	li	a0,0
    2722:	00003097          	auipc	ra,0x3
    2726:	380080e7          	jalr	896(ra) # 5aa2 <sbrk>
  if(c != a - PGSIZE){
    272a:	77fd                	lui	a5,0xfffff
    272c:	97ca                	add	a5,a5,s2
    272e:	08f51a63          	bne	a0,a5,27c2 <sbrkmuch+0x12a>
  a = sbrk(0);
    2732:	4501                	li	a0,0
    2734:	00003097          	auipc	ra,0x3
    2738:	36e080e7          	jalr	878(ra) # 5aa2 <sbrk>
    273c:	892a                	mv	s2,a0
  c = sbrk(PGSIZE);
    273e:	6505                	lui	a0,0x1
    2740:	00003097          	auipc	ra,0x3
    2744:	362080e7          	jalr	866(ra) # 5aa2 <sbrk>
    2748:	8b2a                	mv	s6,a0
  if(c != a || sbrk(0) != a + PGSIZE){
    274a:	04a91c63          	bne	s2,a0,27a2 <sbrkmuch+0x10a>
    274e:	4501                	li	a0,0
    2750:	00003097          	auipc	ra,0x3
    2754:	352080e7          	jalr	850(ra) # 5aa2 <sbrk>
    2758:	6785                	lui	a5,0x1
    275a:	97ca                	add	a5,a5,s2
    275c:	04f51363          	bne	a0,a5,27a2 <sbrkmuch+0x10a>
  if(*lastaddr == 99){
    2760:	0004c783          	lbu	a5,0(s1)
    2764:	0d578b63          	beq	a5,s5,283a <sbrkmuch+0x1a2>
  a = sbrk(0);
    2768:	4501                	li	a0,0
    276a:	00003097          	auipc	ra,0x3
    276e:	338080e7          	jalr	824(ra) # 5aa2 <sbrk>
    2772:	84aa                	mv	s1,a0
  c = sbrk(-(sbrk(0) - oldbrk));
    2774:	4501                	li	a0,0
    2776:	00003097          	auipc	ra,0x3
    277a:	32c080e7          	jalr	812(ra) # 5aa2 <sbrk>
    277e:	40a9853b          	subw	a0,s3,a0
    2782:	00003097          	auipc	ra,0x3
    2786:	320080e7          	jalr	800(ra) # 5aa2 <sbrk>
  if(c != a){
    278a:	08a49863          	bne	s1,a0,281a <sbrkmuch+0x182>
}
    278e:	70e2                	ld	ra,56(sp)
    2790:	7442                	ld	s0,48(sp)
    2792:	74a2                	ld	s1,40(sp)
    2794:	7902                	ld	s2,32(sp)
    2796:	69e2                	ld	s3,24(sp)
    2798:	6a42                	ld	s4,16(sp)
    279a:	6aa2                	ld	s5,8(sp)
    279c:	6b02                	ld	s6,0(sp)
    279e:	6121                	add	sp,sp,64
    27a0:	8082                	ret
    printf("%s: sbrk re-allocation failed, a %x c %x\n", s, a, c);
    27a2:	00004517          	auipc	a0,0x4
    27a6:	5e650513          	add	a0,a0,1510 # 6d88 <malloc+0xf44>
    27aa:	86da                	mv	a3,s6
    27ac:	864a                	mv	a2,s2
    27ae:	85d2                	mv	a1,s4
    27b0:	00003097          	auipc	ra,0x3
    27b4:	5c4080e7          	jalr	1476(ra) # 5d74 <printf>
    exit(1);
    27b8:	4505                	li	a0,1
    27ba:	00003097          	auipc	ra,0x3
    27be:	260080e7          	jalr	608(ra) # 5a1a <exit>
    printf("%s: sbrk deallocation produced wrong address, a %x c %x\n", s, a, c);
    27c2:	86aa                	mv	a3,a0
    27c4:	864a                	mv	a2,s2
    27c6:	00004517          	auipc	a0,0x4
    27ca:	58250513          	add	a0,a0,1410 # 6d48 <malloc+0xf04>
    27ce:	85d2                	mv	a1,s4
    27d0:	00003097          	auipc	ra,0x3
    27d4:	5a4080e7          	jalr	1444(ra) # 5d74 <printf>
    exit(1);
    27d8:	4505                	li	a0,1
    27da:	00003097          	auipc	ra,0x3
    27de:	240080e7          	jalr	576(ra) # 5a1a <exit>
    printf("%s: sbrk could not deallocate\n", s);
    27e2:	00004517          	auipc	a0,0x4
    27e6:	54650513          	add	a0,a0,1350 # 6d28 <malloc+0xee4>
    27ea:	85d2                	mv	a1,s4
    27ec:	00003097          	auipc	ra,0x3
    27f0:	588080e7          	jalr	1416(ra) # 5d74 <printf>
    exit(1);
    27f4:	4505                	li	a0,1
    27f6:	00003097          	auipc	ra,0x3
    27fa:	224080e7          	jalr	548(ra) # 5a1a <exit>
    printf("%s: sbrk test failed to grow big address space; enough phys mem?\n", s);
    27fe:	00004517          	auipc	a0,0x4
    2802:	4e250513          	add	a0,a0,1250 # 6ce0 <malloc+0xe9c>
    2806:	85d2                	mv	a1,s4
    2808:	00003097          	auipc	ra,0x3
    280c:	56c080e7          	jalr	1388(ra) # 5d74 <printf>
    exit(1);
    2810:	4505                	li	a0,1
    2812:	00003097          	auipc	ra,0x3
    2816:	208080e7          	jalr	520(ra) # 5a1a <exit>
    printf("%s: sbrk downsize failed, a %x c %x\n", s, a, c);
    281a:	86aa                	mv	a3,a0
    281c:	8626                	mv	a2,s1
    281e:	00004517          	auipc	a0,0x4
    2822:	5d250513          	add	a0,a0,1490 # 6df0 <malloc+0xfac>
    2826:	85d2                	mv	a1,s4
    2828:	00003097          	auipc	ra,0x3
    282c:	54c080e7          	jalr	1356(ra) # 5d74 <printf>
    exit(1);
    2830:	4505                	li	a0,1
    2832:	00003097          	auipc	ra,0x3
    2836:	1e8080e7          	jalr	488(ra) # 5a1a <exit>
    printf("%s: sbrk de-allocation didn't really deallocate\n", s);
    283a:	00004517          	auipc	a0,0x4
    283e:	57e50513          	add	a0,a0,1406 # 6db8 <malloc+0xf74>
    2842:	85d2                	mv	a1,s4
    2844:	00003097          	auipc	ra,0x3
    2848:	530080e7          	jalr	1328(ra) # 5d74 <printf>
    exit(1);
    284c:	4505                	li	a0,1
    284e:	00003097          	auipc	ra,0x3
    2852:	1cc080e7          	jalr	460(ra) # 5a1a <exit>

0000000000002856 <sbrkarg>:
{
    2856:	7179                	add	sp,sp,-48
    2858:	f406                	sd	ra,40(sp)
    285a:	f022                	sd	s0,32(sp)
    285c:	ec26                	sd	s1,24(sp)
    285e:	e84a                	sd	s2,16(sp)
    2860:	e44e                	sd	s3,8(sp)
    2862:	1800                	add	s0,sp,48
    2864:	89aa                	mv	s3,a0
  a = sbrk(PGSIZE);
    2866:	6505                	lui	a0,0x1
    2868:	00003097          	auipc	ra,0x3
    286c:	23a080e7          	jalr	570(ra) # 5aa2 <sbrk>
    2870:	892a                	mv	s2,a0
  fd = open("sbrk", O_CREATE|O_WRONLY);
    2872:	20100593          	li	a1,513
    2876:	00004517          	auipc	a0,0x4
    287a:	5a250513          	add	a0,a0,1442 # 6e18 <malloc+0xfd4>
    287e:	00003097          	auipc	ra,0x3
    2882:	1dc080e7          	jalr	476(ra) # 5a5a <open>
    2886:	84aa                	mv	s1,a0
  unlink("sbrk");
    2888:	00004517          	auipc	a0,0x4
    288c:	59050513          	add	a0,a0,1424 # 6e18 <malloc+0xfd4>
    2890:	00003097          	auipc	ra,0x3
    2894:	1da080e7          	jalr	474(ra) # 5a6a <unlink>
  if(fd < 0)  {
    2898:	0404c163          	bltz	s1,28da <sbrkarg+0x84>
  if ((n = write(fd, a, PGSIZE)) < 0) {
    289c:	6605                	lui	a2,0x1
    289e:	85ca                	mv	a1,s2
    28a0:	8526                	mv	a0,s1
    28a2:	00003097          	auipc	ra,0x3
    28a6:	198080e7          	jalr	408(ra) # 5a3a <write>
    28aa:	06054463          	bltz	a0,2912 <sbrkarg+0xbc>
  close(fd);
    28ae:	8526                	mv	a0,s1
    28b0:	00003097          	auipc	ra,0x3
    28b4:	192080e7          	jalr	402(ra) # 5a42 <close>
  a = sbrk(PGSIZE);
    28b8:	6505                	lui	a0,0x1
    28ba:	00003097          	auipc	ra,0x3
    28be:	1e8080e7          	jalr	488(ra) # 5aa2 <sbrk>
  if(pipe((int *) a) != 0){
    28c2:	00003097          	auipc	ra,0x3
    28c6:	168080e7          	jalr	360(ra) # 5a2a <pipe>
    28ca:	e515                	bnez	a0,28f6 <sbrkarg+0xa0>
}
    28cc:	70a2                	ld	ra,40(sp)
    28ce:	7402                	ld	s0,32(sp)
    28d0:	64e2                	ld	s1,24(sp)
    28d2:	6942                	ld	s2,16(sp)
    28d4:	69a2                	ld	s3,8(sp)
    28d6:	6145                	add	sp,sp,48
    28d8:	8082                	ret
    printf("%s: open sbrk failed\n", s);
    28da:	00004517          	auipc	a0,0x4
    28de:	54650513          	add	a0,a0,1350 # 6e20 <malloc+0xfdc>
    28e2:	85ce                	mv	a1,s3
    28e4:	00003097          	auipc	ra,0x3
    28e8:	490080e7          	jalr	1168(ra) # 5d74 <printf>
    exit(1);
    28ec:	4505                	li	a0,1
    28ee:	00003097          	auipc	ra,0x3
    28f2:	12c080e7          	jalr	300(ra) # 5a1a <exit>
    printf("%s: pipe() failed\n", s);
    28f6:	00004517          	auipc	a0,0x4
    28fa:	f2250513          	add	a0,a0,-222 # 6818 <malloc+0x9d4>
    28fe:	85ce                	mv	a1,s3
    2900:	00003097          	auipc	ra,0x3
    2904:	474080e7          	jalr	1140(ra) # 5d74 <printf>
    exit(1);
    2908:	4505                	li	a0,1
    290a:	00003097          	auipc	ra,0x3
    290e:	110080e7          	jalr	272(ra) # 5a1a <exit>
    printf("%s: write sbrk failed\n", s);
    2912:	00004517          	auipc	a0,0x4
    2916:	52650513          	add	a0,a0,1318 # 6e38 <malloc+0xff4>
    291a:	85ce                	mv	a1,s3
    291c:	00003097          	auipc	ra,0x3
    2920:	458080e7          	jalr	1112(ra) # 5d74 <printf>
    exit(1);
    2924:	4505                	li	a0,1
    2926:	00003097          	auipc	ra,0x3
    292a:	0f4080e7          	jalr	244(ra) # 5a1a <exit>

000000000000292e <sbrkbugs>:
{
    292e:	1141                	add	sp,sp,-16
    2930:	e022                	sd	s0,0(sp)
    2932:	e406                	sd	ra,8(sp)
    2934:	0800                	add	s0,sp,16
  int pid = fork();
    2936:	00003097          	auipc	ra,0x3
    293a:	0dc080e7          	jalr	220(ra) # 5a12 <fork>
  if(pid < 0){
    293e:	08054163          	bltz	a0,29c0 <sbrkbugs+0x92>
  if(pid == 0){
    2942:	c125                	beqz	a0,29a2 <sbrkbugs+0x74>
  wait(0);
    2944:	4501                	li	a0,0
    2946:	00003097          	auipc	ra,0x3
    294a:	0dc080e7          	jalr	220(ra) # 5a22 <wait>
  pid = fork();
    294e:	00003097          	auipc	ra,0x3
    2952:	0c4080e7          	jalr	196(ra) # 5a12 <fork>
  if(pid < 0){
    2956:	06054563          	bltz	a0,29c0 <sbrkbugs+0x92>
  if(pid == 0){
    295a:	c141                	beqz	a0,29da <sbrkbugs+0xac>
  wait(0);
    295c:	4501                	li	a0,0
    295e:	00003097          	auipc	ra,0x3
    2962:	0c4080e7          	jalr	196(ra) # 5a22 <wait>
  pid = fork();
    2966:	00003097          	auipc	ra,0x3
    296a:	0ac080e7          	jalr	172(ra) # 5a12 <fork>
  if(pid < 0){
    296e:	04054963          	bltz	a0,29c0 <sbrkbugs+0x92>
  if(pid == 0){
    2972:	e551                	bnez	a0,29fe <sbrkbugs+0xd0>
    sbrk((10*4096 + 2048) - (uint64)sbrk(0));
    2974:	00003097          	auipc	ra,0x3
    2978:	12e080e7          	jalr	302(ra) # 5aa2 <sbrk>
    297c:	67ad                	lui	a5,0xb
    297e:	8007879b          	addw	a5,a5,-2048 # a800 <uninit+0x298>
    2982:	40a7853b          	subw	a0,a5,a0
    2986:	00003097          	auipc	ra,0x3
    298a:	11c080e7          	jalr	284(ra) # 5aa2 <sbrk>
    sbrk(-10);
    298e:	5559                	li	a0,-10
    2990:	00003097          	auipc	ra,0x3
    2994:	112080e7          	jalr	274(ra) # 5aa2 <sbrk>
    exit(0);
    2998:	4501                	li	a0,0
    299a:	00003097          	auipc	ra,0x3
    299e:	080080e7          	jalr	128(ra) # 5a1a <exit>
    int sz = (uint64) sbrk(0);
    29a2:	00003097          	auipc	ra,0x3
    29a6:	100080e7          	jalr	256(ra) # 5aa2 <sbrk>
    sbrk(-sz);
    29aa:	40a0053b          	negw	a0,a0
    29ae:	00003097          	auipc	ra,0x3
    29b2:	0f4080e7          	jalr	244(ra) # 5aa2 <sbrk>
    exit(0);
    29b6:	4501                	li	a0,0
    29b8:	00003097          	auipc	ra,0x3
    29bc:	062080e7          	jalr	98(ra) # 5a1a <exit>
    printf("fork failed\n");
    29c0:	00004517          	auipc	a0,0x4
    29c4:	15850513          	add	a0,a0,344 # 6b18 <malloc+0xcd4>
    29c8:	00003097          	auipc	ra,0x3
    29cc:	3ac080e7          	jalr	940(ra) # 5d74 <printf>
    exit(1);
    29d0:	4505                	li	a0,1
    29d2:	00003097          	auipc	ra,0x3
    29d6:	048080e7          	jalr	72(ra) # 5a1a <exit>
    int sz = (uint64) sbrk(0);
    29da:	00003097          	auipc	ra,0x3
    29de:	0c8080e7          	jalr	200(ra) # 5aa2 <sbrk>
    sbrk(-(sz - 3500));
    29e2:	6785                	lui	a5,0x1
    29e4:	dac7879b          	addw	a5,a5,-596 # dac <unlinkread+0x180>
    29e8:	40a7853b          	subw	a0,a5,a0
    29ec:	00003097          	auipc	ra,0x3
    29f0:	0b6080e7          	jalr	182(ra) # 5aa2 <sbrk>
    exit(0);
    29f4:	4501                	li	a0,0
    29f6:	00003097          	auipc	ra,0x3
    29fa:	024080e7          	jalr	36(ra) # 5a1a <exit>
  wait(0);
    29fe:	4501                	li	a0,0
    2a00:	00003097          	auipc	ra,0x3
    2a04:	022080e7          	jalr	34(ra) # 5a22 <wait>
  exit(0);
    2a08:	4501                	li	a0,0
    2a0a:	00003097          	auipc	ra,0x3
    2a0e:	010080e7          	jalr	16(ra) # 5a1a <exit>

0000000000002a12 <sbrklast>:
{
    2a12:	7179                	add	sp,sp,-48
    2a14:	f022                	sd	s0,32(sp)
    2a16:	f406                	sd	ra,40(sp)
    2a18:	ec26                	sd	s1,24(sp)
    2a1a:	e84a                	sd	s2,16(sp)
    2a1c:	e44e                	sd	s3,8(sp)
    2a1e:	e052                	sd	s4,0(sp)
    2a20:	1800                	add	s0,sp,48
  uint64 top = (uint64) sbrk(0);
    2a22:	4501                	li	a0,0
    2a24:	00003097          	auipc	ra,0x3
    2a28:	07e080e7          	jalr	126(ra) # 5aa2 <sbrk>
  if((top % 4096) != 0)
    2a2c:	1552                	sll	a0,a0,0x34
    2a2e:	e959                	bnez	a0,2ac4 <sbrklast+0xb2>
  sbrk(4096);
    2a30:	6505                	lui	a0,0x1
    2a32:	00003097          	auipc	ra,0x3
    2a36:	070080e7          	jalr	112(ra) # 5aa2 <sbrk>
  sbrk(10);
    2a3a:	4529                	li	a0,10
    2a3c:	00003097          	auipc	ra,0x3
    2a40:	066080e7          	jalr	102(ra) # 5aa2 <sbrk>
  sbrk(-20);
    2a44:	5531                	li	a0,-20
    2a46:	00003097          	auipc	ra,0x3
    2a4a:	05c080e7          	jalr	92(ra) # 5aa2 <sbrk>
  top = (uint64) sbrk(0);
    2a4e:	4501                	li	a0,0
    2a50:	00003097          	auipc	ra,0x3
    2a54:	052080e7          	jalr	82(ra) # 5aa2 <sbrk>
  char *p = (char *) (top - 64);
    2a58:	fc050913          	add	s2,a0,-64 # fc0 <linktest+0x1e2>
  p[0] = 'x';
    2a5c:	07800a13          	li	s4,120
  top = (uint64) sbrk(0);
    2a60:	84aa                	mv	s1,a0
  p[0] = 'x';
    2a62:	fd450023          	sb	s4,-64(a0)
  p[1] = '\0';
    2a66:	fc0500a3          	sb	zero,-63(a0)
  int fd = open(p, O_RDWR|O_CREATE);
    2a6a:	20200593          	li	a1,514
    2a6e:	854a                	mv	a0,s2
    2a70:	00003097          	auipc	ra,0x3
    2a74:	fea080e7          	jalr	-22(ra) # 5a5a <open>
  write(fd, p, 1);
    2a78:	4605                	li	a2,1
    2a7a:	85ca                	mv	a1,s2
  int fd = open(p, O_RDWR|O_CREATE);
    2a7c:	89aa                	mv	s3,a0
  write(fd, p, 1);
    2a7e:	00003097          	auipc	ra,0x3
    2a82:	fbc080e7          	jalr	-68(ra) # 5a3a <write>
  close(fd);
    2a86:	854e                	mv	a0,s3
    2a88:	00003097          	auipc	ra,0x3
    2a8c:	fba080e7          	jalr	-70(ra) # 5a42 <close>
  fd = open(p, O_RDWR);
    2a90:	4589                	li	a1,2
    2a92:	854a                	mv	a0,s2
    2a94:	00003097          	auipc	ra,0x3
    2a98:	fc6080e7          	jalr	-58(ra) # 5a5a <open>
  read(fd, p, 1);
    2a9c:	4605                	li	a2,1
  p[0] = '\0';
    2a9e:	fc048023          	sb	zero,-64(s1)
  read(fd, p, 1);
    2aa2:	85ca                	mv	a1,s2
    2aa4:	00003097          	auipc	ra,0x3
    2aa8:	f8e080e7          	jalr	-114(ra) # 5a32 <read>
  if(p[0] != 'x')
    2aac:	fc04c783          	lbu	a5,-64(s1)
    2ab0:	03479363          	bne	a5,s4,2ad6 <sbrklast+0xc4>
}
    2ab4:	70a2                	ld	ra,40(sp)
    2ab6:	7402                	ld	s0,32(sp)
    2ab8:	64e2                	ld	s1,24(sp)
    2aba:	6942                	ld	s2,16(sp)
    2abc:	69a2                	ld	s3,8(sp)
    2abe:	6a02                	ld	s4,0(sp)
    2ac0:	6145                	add	sp,sp,48
    2ac2:	8082                	ret
    sbrk(4096 - (top % 4096));
    2ac4:	03455793          	srl	a5,a0,0x34
    2ac8:	6505                	lui	a0,0x1
    2aca:	9d1d                	subw	a0,a0,a5
    2acc:	00003097          	auipc	ra,0x3
    2ad0:	fd6080e7          	jalr	-42(ra) # 5aa2 <sbrk>
    2ad4:	bfb1                	j	2a30 <sbrklast+0x1e>
    exit(1);
    2ad6:	4505                	li	a0,1
    2ad8:	00003097          	auipc	ra,0x3
    2adc:	f42080e7          	jalr	-190(ra) # 5a1a <exit>

0000000000002ae0 <sbrk8000>:
{
    2ae0:	1141                	add	sp,sp,-16
    2ae2:	e406                	sd	ra,8(sp)
    2ae4:	e022                	sd	s0,0(sp)
  sbrk(0x80000004);
    2ae6:	80000537          	lui	a0,0x80000
{
    2aea:	0800                	add	s0,sp,16
  sbrk(0x80000004);
    2aec:	0511                	add	a0,a0,4 # ffffffff80000004 <base+0xffffffff7fff038c>
    2aee:	00003097          	auipc	ra,0x3
    2af2:	fb4080e7          	jalr	-76(ra) # 5aa2 <sbrk>
  volatile char *top = sbrk(0);
    2af6:	4501                	li	a0,0
    2af8:	00003097          	auipc	ra,0x3
    2afc:	faa080e7          	jalr	-86(ra) # 5aa2 <sbrk>
  *(top-1) = *(top-1) + 1;
    2b00:	fff54783          	lbu	a5,-1(a0)
    2b04:	2785                	addw	a5,a5,1
    2b06:	0ff7f793          	zext.b	a5,a5
    2b0a:	fef50fa3          	sb	a5,-1(a0)
}
    2b0e:	60a2                	ld	ra,8(sp)
    2b10:	6402                	ld	s0,0(sp)
    2b12:	0141                	add	sp,sp,16
    2b14:	8082                	ret

0000000000002b16 <execout>:
{
    2b16:	715d                	add	sp,sp,-80
    2b18:	e0a2                	sd	s0,64(sp)
    2b1a:	f84a                	sd	s2,48(sp)
    2b1c:	f44e                	sd	s3,40(sp)
    2b1e:	e486                	sd	ra,72(sp)
    2b20:	fc26                	sd	s1,56(sp)
    2b22:	f052                	sd	s4,32(sp)
    2b24:	0880                	add	s0,sp,80
  for(int avail = 0; avail < 15; avail++){
    2b26:	4901                	li	s2,0
    2b28:	49bd                	li	s3,15
    int pid = fork();
    2b2a:	00003097          	auipc	ra,0x3
    2b2e:	ee8080e7          	jalr	-280(ra) # 5a12 <fork>
    2b32:	84aa                	mv	s1,a0
    if(pid < 0){
    2b34:	02054063          	bltz	a0,2b54 <execout+0x3e>
    } else if(pid == 0){
    2b38:	c91d                	beqz	a0,2b6e <execout+0x58>
      wait((int*)0);
    2b3a:	4501                	li	a0,0
  for(int avail = 0; avail < 15; avail++){
    2b3c:	2905                	addw	s2,s2,1
      wait((int*)0);
    2b3e:	00003097          	auipc	ra,0x3
    2b42:	ee4080e7          	jalr	-284(ra) # 5a22 <wait>
  for(int avail = 0; avail < 15; avail++){
    2b46:	ff3912e3          	bne	s2,s3,2b2a <execout+0x14>
  exit(0);
    2b4a:	4501                	li	a0,0
    2b4c:	00003097          	auipc	ra,0x3
    2b50:	ece080e7          	jalr	-306(ra) # 5a1a <exit>
      printf("fork failed\n");
    2b54:	00004517          	auipc	a0,0x4
    2b58:	fc450513          	add	a0,a0,-60 # 6b18 <malloc+0xcd4>
    2b5c:	00003097          	auipc	ra,0x3
    2b60:	218080e7          	jalr	536(ra) # 5d74 <printf>
      exit(1);
    2b64:	4505                	li	a0,1
    2b66:	00003097          	auipc	ra,0x3
    2b6a:	eb4080e7          	jalr	-332(ra) # 5a1a <exit>
        if(a == 0xffffffffffffffffLL)
    2b6e:	59fd                	li	s3,-1
        *(char*)(a + 4096 - 1) = 1;
    2b70:	4a05                	li	s4,1
    2b72:	a029                	j	2b7c <execout+0x66>
    2b74:	6785                	lui	a5,0x1
    2b76:	97aa                	add	a5,a5,a0
    2b78:	ff478fa3          	sb	s4,-1(a5) # fff <linktest+0x221>
        uint64 a = (uint64) sbrk(4096);
    2b7c:	6505                	lui	a0,0x1
    2b7e:	00003097          	auipc	ra,0x3
    2b82:	f24080e7          	jalr	-220(ra) # 5aa2 <sbrk>
        if(a == 0xffffffffffffffffLL)
    2b86:	ff3517e3          	bne	a0,s3,2b74 <execout+0x5e>
      for(int i = 0; i < avail; i++)
    2b8a:	00090a63          	beqz	s2,2b9e <execout+0x88>
        sbrk(-4096);
    2b8e:	757d                	lui	a0,0xfffff
      for(int i = 0; i < avail; i++)
    2b90:	2485                	addw	s1,s1,1
        sbrk(-4096);
    2b92:	00003097          	auipc	ra,0x3
    2b96:	f10080e7          	jalr	-240(ra) # 5aa2 <sbrk>
      for(int i = 0; i < avail; i++)
    2b9a:	ff249ae3          	bne	s1,s2,2b8e <execout+0x78>
      close(1);
    2b9e:	4505                	li	a0,1
    2ba0:	00003097          	auipc	ra,0x3
    2ba4:	ea2080e7          	jalr	-350(ra) # 5a42 <close>
      char *args[] = { "echo", "x", 0 };
    2ba8:	00004517          	auipc	a0,0x4
    2bac:	a8050513          	add	a0,a0,-1408 # 6628 <malloc+0x7e4>
    2bb0:	00003797          	auipc	a5,0x3
    2bb4:	3d878793          	add	a5,a5,984 # 5f88 <malloc+0x144>
      exec("echo", args);
    2bb8:	fb840593          	add	a1,s0,-72
      char *args[] = { "echo", "x", 0 };
    2bbc:	faa43c23          	sd	a0,-72(s0)
    2bc0:	fcf43023          	sd	a5,-64(s0)
    2bc4:	fc043423          	sd	zero,-56(s0)
      exec("echo", args);
    2bc8:	00003097          	auipc	ra,0x3
    2bcc:	e8a080e7          	jalr	-374(ra) # 5a52 <exec>
      exit(0);
    2bd0:	4501                	li	a0,0
    2bd2:	00003097          	auipc	ra,0x3
    2bd6:	e48080e7          	jalr	-440(ra) # 5a1a <exit>

0000000000002bda <fourteen>:
{
    2bda:	1101                	add	sp,sp,-32
    2bdc:	e822                	sd	s0,16(sp)
    2bde:	e426                	sd	s1,8(sp)
    2be0:	ec06                	sd	ra,24(sp)
    2be2:	1000                	add	s0,sp,32
    2be4:	84aa                	mv	s1,a0
  if(mkdir("12345678901234") != 0){
    2be6:	00004517          	auipc	a0,0x4
    2bea:	43a50513          	add	a0,a0,1082 # 7020 <malloc+0x11dc>
    2bee:	00003097          	auipc	ra,0x3
    2bf2:	e94080e7          	jalr	-364(ra) # 5a82 <mkdir>
    2bf6:	e165                	bnez	a0,2cd6 <fourteen+0xfc>
  if(mkdir("12345678901234/123456789012345") != 0){
    2bf8:	00004517          	auipc	a0,0x4
    2bfc:	28050513          	add	a0,a0,640 # 6e78 <malloc+0x1034>
    2c00:	00003097          	auipc	ra,0x3
    2c04:	e82080e7          	jalr	-382(ra) # 5a82 <mkdir>
    2c08:	14051d63          	bnez	a0,2d62 <fourteen+0x188>
  fd = open("123456789012345/123456789012345/123456789012345", O_CREATE);
    2c0c:	20000593          	li	a1,512
    2c10:	00004517          	auipc	a0,0x4
    2c14:	2c050513          	add	a0,a0,704 # 6ed0 <malloc+0x108c>
    2c18:	00003097          	auipc	ra,0x3
    2c1c:	e42080e7          	jalr	-446(ra) # 5a5a <open>
  if(fd < 0){
    2c20:	12054363          	bltz	a0,2d46 <fourteen+0x16c>
  close(fd);
    2c24:	00003097          	auipc	ra,0x3
    2c28:	e1e080e7          	jalr	-482(ra) # 5a42 <close>
  fd = open("12345678901234/12345678901234/12345678901234", 0);
    2c2c:	4581                	li	a1,0
    2c2e:	00004517          	auipc	a0,0x4
    2c32:	31a50513          	add	a0,a0,794 # 6f48 <malloc+0x1104>
    2c36:	00003097          	auipc	ra,0x3
    2c3a:	e24080e7          	jalr	-476(ra) # 5a5a <open>
  if(fd < 0){
    2c3e:	0e054663          	bltz	a0,2d2a <fourteen+0x150>
  close(fd);
    2c42:	00003097          	auipc	ra,0x3
    2c46:	e00080e7          	jalr	-512(ra) # 5a42 <close>
  if(mkdir("12345678901234/12345678901234") == 0){
    2c4a:	00004517          	auipc	a0,0x4
    2c4e:	36e50513          	add	a0,a0,878 # 6fb8 <malloc+0x1174>
    2c52:	00003097          	auipc	ra,0x3
    2c56:	e30080e7          	jalr	-464(ra) # 5a82 <mkdir>
    2c5a:	c955                	beqz	a0,2d0e <fourteen+0x134>
  if(mkdir("123456789012345/12345678901234") == 0){
    2c5c:	00004517          	auipc	a0,0x4
    2c60:	3b450513          	add	a0,a0,948 # 7010 <malloc+0x11cc>
    2c64:	00003097          	auipc	ra,0x3
    2c68:	e1e080e7          	jalr	-482(ra) # 5a82 <mkdir>
    2c6c:	c159                	beqz	a0,2cf2 <fourteen+0x118>
  unlink("123456789012345/12345678901234");
    2c6e:	00004517          	auipc	a0,0x4
    2c72:	3a250513          	add	a0,a0,930 # 7010 <malloc+0x11cc>
    2c76:	00003097          	auipc	ra,0x3
    2c7a:	df4080e7          	jalr	-524(ra) # 5a6a <unlink>
  unlink("12345678901234/12345678901234");
    2c7e:	00004517          	auipc	a0,0x4
    2c82:	33a50513          	add	a0,a0,826 # 6fb8 <malloc+0x1174>
    2c86:	00003097          	auipc	ra,0x3
    2c8a:	de4080e7          	jalr	-540(ra) # 5a6a <unlink>
  unlink("12345678901234/12345678901234/12345678901234");
    2c8e:	00004517          	auipc	a0,0x4
    2c92:	2ba50513          	add	a0,a0,698 # 6f48 <malloc+0x1104>
    2c96:	00003097          	auipc	ra,0x3
    2c9a:	dd4080e7          	jalr	-556(ra) # 5a6a <unlink>
  unlink("123456789012345/123456789012345/123456789012345");
    2c9e:	00004517          	auipc	a0,0x4
    2ca2:	23250513          	add	a0,a0,562 # 6ed0 <malloc+0x108c>
    2ca6:	00003097          	auipc	ra,0x3
    2caa:	dc4080e7          	jalr	-572(ra) # 5a6a <unlink>
  unlink("12345678901234/123456789012345");
    2cae:	00004517          	auipc	a0,0x4
    2cb2:	1ca50513          	add	a0,a0,458 # 6e78 <malloc+0x1034>
    2cb6:	00003097          	auipc	ra,0x3
    2cba:	db4080e7          	jalr	-588(ra) # 5a6a <unlink>
}
    2cbe:	6442                	ld	s0,16(sp)
    2cc0:	60e2                	ld	ra,24(sp)
    2cc2:	64a2                	ld	s1,8(sp)
  unlink("12345678901234");
    2cc4:	00004517          	auipc	a0,0x4
    2cc8:	35c50513          	add	a0,a0,860 # 7020 <malloc+0x11dc>
}
    2ccc:	6105                	add	sp,sp,32
  unlink("12345678901234");
    2cce:	00003317          	auipc	t1,0x3
    2cd2:	d9c30067          	jr	-612(t1) # 5a6a <unlink>
    printf("%s: mkdir 12345678901234 failed\n", s);
    2cd6:	00004517          	auipc	a0,0x4
    2cda:	17a50513          	add	a0,a0,378 # 6e50 <malloc+0x100c>
    2cde:	85a6                	mv	a1,s1
    2ce0:	00003097          	auipc	ra,0x3
    2ce4:	094080e7          	jalr	148(ra) # 5d74 <printf>
    exit(1);
    2ce8:	4505                	li	a0,1
    2cea:	00003097          	auipc	ra,0x3
    2cee:	d30080e7          	jalr	-720(ra) # 5a1a <exit>
    printf("%s: mkdir 12345678901234/123456789012345 succeeded!\n", s);
    2cf2:	00004517          	auipc	a0,0x4
    2cf6:	33e50513          	add	a0,a0,830 # 7030 <malloc+0x11ec>
    2cfa:	85a6                	mv	a1,s1
    2cfc:	00003097          	auipc	ra,0x3
    2d00:	078080e7          	jalr	120(ra) # 5d74 <printf>
    exit(1);
    2d04:	4505                	li	a0,1
    2d06:	00003097          	auipc	ra,0x3
    2d0a:	d14080e7          	jalr	-748(ra) # 5a1a <exit>
    printf("%s: mkdir 12345678901234/12345678901234 succeeded!\n", s);
    2d0e:	00004517          	auipc	a0,0x4
    2d12:	2ca50513          	add	a0,a0,714 # 6fd8 <malloc+0x1194>
    2d16:	85a6                	mv	a1,s1
    2d18:	00003097          	auipc	ra,0x3
    2d1c:	05c080e7          	jalr	92(ra) # 5d74 <printf>
    exit(1);
    2d20:	4505                	li	a0,1
    2d22:	00003097          	auipc	ra,0x3
    2d26:	cf8080e7          	jalr	-776(ra) # 5a1a <exit>
    printf("%s: open 12345678901234/12345678901234/12345678901234 failed\n", s);
    2d2a:	00004517          	auipc	a0,0x4
    2d2e:	24e50513          	add	a0,a0,590 # 6f78 <malloc+0x1134>
    2d32:	85a6                	mv	a1,s1
    2d34:	00003097          	auipc	ra,0x3
    2d38:	040080e7          	jalr	64(ra) # 5d74 <printf>
    exit(1);
    2d3c:	4505                	li	a0,1
    2d3e:	00003097          	auipc	ra,0x3
    2d42:	cdc080e7          	jalr	-804(ra) # 5a1a <exit>
    printf("%s: create 123456789012345/123456789012345/123456789012345 failed\n", s);
    2d46:	00004517          	auipc	a0,0x4
    2d4a:	1ba50513          	add	a0,a0,442 # 6f00 <malloc+0x10bc>
    2d4e:	85a6                	mv	a1,s1
    2d50:	00003097          	auipc	ra,0x3
    2d54:	024080e7          	jalr	36(ra) # 5d74 <printf>
    exit(1);
    2d58:	4505                	li	a0,1
    2d5a:	00003097          	auipc	ra,0x3
    2d5e:	cc0080e7          	jalr	-832(ra) # 5a1a <exit>
    printf("%s: mkdir 12345678901234/123456789012345 failed\n", s);
    2d62:	00004517          	auipc	a0,0x4
    2d66:	13650513          	add	a0,a0,310 # 6e98 <malloc+0x1054>
    2d6a:	85a6                	mv	a1,s1
    2d6c:	00003097          	auipc	ra,0x3
    2d70:	008080e7          	jalr	8(ra) # 5d74 <printf>
    exit(1);
    2d74:	4505                	li	a0,1
    2d76:	00003097          	auipc	ra,0x3
    2d7a:	ca4080e7          	jalr	-860(ra) # 5a1a <exit>

0000000000002d7e <diskfull>:
{
    2d7e:	ba010113          	add	sp,sp,-1120
    2d82:	44813823          	sd	s0,1104(sp)
    2d86:	45213023          	sd	s2,1088(sp)
    2d8a:	43413823          	sd	s4,1072(sp)
    2d8e:	43513423          	sd	s5,1064(sp)
    2d92:	43613023          	sd	s6,1056(sp)
    2d96:	44113c23          	sd	ra,1112(sp)
    2d9a:	44913423          	sd	s1,1096(sp)
    2d9e:	43313c23          	sd	s3,1080(sp)
    2da2:	46010413          	add	s0,sp,1120
    2da6:	8b2a                	mv	s6,a0
    name[0] = 'b';
    2da8:	6a1d                	lui	s4,0x7
  unlink("diskfulldir");
    2daa:	00004517          	auipc	a0,0x4
    2dae:	2be50513          	add	a0,a0,702 # 7068 <malloc+0x1224>
    2db2:	00003097          	auipc	ra,0x3
    2db6:	cb8080e7          	jalr	-840(ra) # 5a6a <unlink>
  for(fi = 0; done == 0; fi++){
    2dba:	4901                	li	s2,0
    name[0] = 'b';
    2dbc:	962a0a13          	add	s4,s4,-1694 # 6962 <malloc+0xb1e>
    name[2] = 'g';
    2dc0:	06700a93          	li	s5,103
    name[3] = '0' + fi;
    2dc4:	0309079b          	addw	a5,s2,48
    unlink(name);
    2dc8:	ba040513          	add	a0,s0,-1120
    name[3] = '0' + fi;
    2dcc:	baf401a3          	sb	a5,-1117(s0)
    name[0] = 'b';
    2dd0:	bb441023          	sh	s4,-1120(s0)
    name[2] = 'g';
    2dd4:	bb540123          	sb	s5,-1118(s0)
    name[4] = '\0';
    2dd8:	ba040223          	sb	zero,-1116(s0)
    unlink(name);
    2ddc:	00003097          	auipc	ra,0x3
    2de0:	c8e080e7          	jalr	-882(ra) # 5a6a <unlink>
    int fd = open(name, O_CREATE|O_RDWR|O_TRUNC);
    2de4:	60200593          	li	a1,1538
    2de8:	ba040513          	add	a0,s0,-1120
    2dec:	00003097          	auipc	ra,0x3
    2df0:	c6e080e7          	jalr	-914(ra) # 5a5a <open>
    2df4:	89aa                	mv	s3,a0
    if(fd < 0){
    2df6:	16054963          	bltz	a0,2f68 <diskfull+0x1ea>
    2dfa:	10c00493          	li	s1,268
    2dfe:	a019                	j	2e04 <diskfull+0x86>
    for(int i = 0; i < MAXFILE; i++){
    2e00:	14048d63          	beqz	s1,2f5a <diskfull+0x1dc>
      if(write(fd, buf, BSIZE) != BSIZE){
    2e04:	40000613          	li	a2,1024
    2e08:	bc040593          	add	a1,s0,-1088
    2e0c:	854e                	mv	a0,s3
    2e0e:	00003097          	auipc	ra,0x3
    2e12:	c2c080e7          	jalr	-980(ra) # 5a3a <write>
    2e16:	40000793          	li	a5,1024
    for(int i = 0; i < MAXFILE; i++){
    2e1a:	34fd                	addw	s1,s1,-1
      if(write(fd, buf, BSIZE) != BSIZE){
    2e1c:	fef502e3          	beq	a0,a5,2e00 <diskfull+0x82>
        close(fd);
    2e20:	854e                	mv	a0,s3
    2e22:	00003097          	auipc	ra,0x3
    2e26:	c20080e7          	jalr	-992(ra) # 5a42 <close>
    close(fd);
    2e2a:	854e                	mv	a0,s3
    2e2c:	00003097          	auipc	ra,0x3
    2e30:	c16080e7          	jalr	-1002(ra) # 5a42 <close>
  for(fi = 0; done == 0; fi++){
    2e34:	2905                	addw	s2,s2,1
    name[0] = 'z';
    2e36:	64a1                	lui	s1,0x8
    2e38:	4a01                	li	s4,0
    2e3a:	a7a48493          	add	s1,s1,-1414 # 7a7a <malloc+0x1c36>
  for(int i = 0; i < nzz; i++){
    2e3e:	08000993          	li	s3,128
    2e42:	a801                	j	2e52 <diskfull+0xd4>
    2e44:	2a05                	addw	s4,s4,1
    close(fd);
    2e46:	00003097          	auipc	ra,0x3
    2e4a:	bfc080e7          	jalr	-1028(ra) # 5a42 <close>
  for(int i = 0; i < nzz; i++){
    2e4e:	053a0563          	beq	s4,s3,2e98 <diskfull+0x11a>
    name[2] = '0' + (i / 32);
    2e52:	405a579b          	sraw	a5,s4,0x5
    name[3] = '0' + (i % 32);
    2e56:	01fa7713          	and	a4,s4,31
    name[2] = '0' + (i / 32);
    2e5a:	0307879b          	addw	a5,a5,48
    name[3] = '0' + (i % 32);
    2e5e:	0307071b          	addw	a4,a4,48 # 1030 <pgbug+0x2>
    name[2] = '0' + (i / 32);
    2e62:	0087171b          	sllw	a4,a4,0x8
    2e66:	0ff7f793          	zext.b	a5,a5
    2e6a:	8fd9                	or	a5,a5,a4
    unlink(name);
    2e6c:	bc040513          	add	a0,s0,-1088
    name[0] = 'z';
    2e70:	bc941023          	sh	s1,-1088(s0)
    name[2] = '0' + (i / 32);
    2e74:	bcf41123          	sh	a5,-1086(s0)
    name[4] = '\0';
    2e78:	bc040223          	sb	zero,-1084(s0)
    unlink(name);
    2e7c:	00003097          	auipc	ra,0x3
    2e80:	bee080e7          	jalr	-1042(ra) # 5a6a <unlink>
    int fd = open(name, O_CREATE|O_RDWR|O_TRUNC);
    2e84:	60200593          	li	a1,1538
    2e88:	bc040513          	add	a0,s0,-1088
    2e8c:	00003097          	auipc	ra,0x3
    2e90:	bce080e7          	jalr	-1074(ra) # 5a5a <open>
    if(fd < 0)
    2e94:	fa0558e3          	bgez	a0,2e44 <diskfull+0xc6>
  if(mkdir("diskfulldir") == 0)
    2e98:	00004517          	auipc	a0,0x4
    2e9c:	1d050513          	add	a0,a0,464 # 7068 <malloc+0x1224>
    2ea0:	00003097          	auipc	ra,0x3
    2ea4:	be2080e7          	jalr	-1054(ra) # 5a82 <mkdir>
    2ea8:	cd61                	beqz	a0,2f80 <diskfull+0x202>
  unlink("diskfulldir");
    2eaa:	00004517          	auipc	a0,0x4
    2eae:	1be50513          	add	a0,a0,446 # 7068 <malloc+0x1224>
    name[0] = 'z';
    2eb2:	69a1                	lui	s3,0x8
  unlink("diskfulldir");
    2eb4:	00003097          	auipc	ra,0x3
    2eb8:	bb6080e7          	jalr	-1098(ra) # 5a6a <unlink>
  for(int i = 0; i < nzz; i++){
    2ebc:	4481                	li	s1,0
    name[0] = 'z';
    2ebe:	a7a98993          	add	s3,s3,-1414 # 7a7a <malloc+0x1c36>
  for(int i = 0; i < nzz; i++){
    2ec2:	08000a13          	li	s4,128
    name[2] = '0' + (i / 32);
    2ec6:	4054d79b          	sraw	a5,s1,0x5
    name[3] = '0' + (i % 32);
    2eca:	01f4f713          	and	a4,s1,31
    name[2] = '0' + (i / 32);
    2ece:	0307879b          	addw	a5,a5,48
    name[3] = '0' + (i % 32);
    2ed2:	0307071b          	addw	a4,a4,48
    name[2] = '0' + (i / 32);
    2ed6:	0087171b          	sllw	a4,a4,0x8
    2eda:	0ff7f793          	zext.b	a5,a5
    2ede:	8fd9                	or	a5,a5,a4
    unlink(name);
    2ee0:	bc040513          	add	a0,s0,-1088
  for(int i = 0; i < nzz; i++){
    2ee4:	2485                	addw	s1,s1,1
    name[0] = 'z';
    2ee6:	bd341023          	sh	s3,-1088(s0)
    name[2] = '0' + (i / 32);
    2eea:	bcf41123          	sh	a5,-1086(s0)
    name[4] = '\0';
    2eee:	bc040223          	sb	zero,-1084(s0)
    unlink(name);
    2ef2:	00003097          	auipc	ra,0x3
    2ef6:	b78080e7          	jalr	-1160(ra) # 5a6a <unlink>
  for(int i = 0; i < nzz; i++){
    2efa:	fd4496e3          	bne	s1,s4,2ec6 <diskfull+0x148>
  for(int i = 0; i < fi; i++){
    2efe:	02090b63          	beqz	s2,2f34 <diskfull+0x1b6>
    name[0] = 'b';
    2f02:	699d                	lui	s3,0x7
  for(int i = 0; i < fi; i++){
    2f04:	4481                	li	s1,0
    name[0] = 'b';
    2f06:	96298993          	add	s3,s3,-1694 # 6962 <malloc+0xb1e>
    name[2] = 'g';
    2f0a:	06700a13          	li	s4,103
    name[3] = '0' + i;
    2f0e:	0304879b          	addw	a5,s1,48
    unlink(name);
    2f12:	bc040513          	add	a0,s0,-1088
  for(int i = 0; i < fi; i++){
    2f16:	2485                	addw	s1,s1,1
    name[0] = 'b';
    2f18:	bd341023          	sh	s3,-1088(s0)
    name[2] = 'g';
    2f1c:	bd440123          	sb	s4,-1086(s0)
    name[3] = '0' + i;
    2f20:	bcf401a3          	sb	a5,-1085(s0)
    name[4] = '\0';
    2f24:	bc040223          	sb	zero,-1084(s0)
    unlink(name);
    2f28:	00003097          	auipc	ra,0x3
    2f2c:	b42080e7          	jalr	-1214(ra) # 5a6a <unlink>
  for(int i = 0; i < fi; i++){
    2f30:	fc991fe3          	bne	s2,s1,2f0e <diskfull+0x190>
}
    2f34:	45813083          	ld	ra,1112(sp)
    2f38:	45013403          	ld	s0,1104(sp)
    2f3c:	44813483          	ld	s1,1096(sp)
    2f40:	44013903          	ld	s2,1088(sp)
    2f44:	43813983          	ld	s3,1080(sp)
    2f48:	43013a03          	ld	s4,1072(sp)
    2f4c:	42813a83          	ld	s5,1064(sp)
    2f50:	42013b03          	ld	s6,1056(sp)
    2f54:	46010113          	add	sp,sp,1120
    2f58:	8082                	ret
    close(fd);
    2f5a:	854e                	mv	a0,s3
    2f5c:	00003097          	auipc	ra,0x3
    2f60:	ae6080e7          	jalr	-1306(ra) # 5a42 <close>
  for(fi = 0; done == 0; fi++){
    2f64:	2905                	addw	s2,s2,1
    2f66:	bdb9                	j	2dc4 <diskfull+0x46>
      printf("%s: could not create file %s\n", s, name);
    2f68:	ba040613          	add	a2,s0,-1120
    2f6c:	85da                	mv	a1,s6
    2f6e:	00004517          	auipc	a0,0x4
    2f72:	10a50513          	add	a0,a0,266 # 7078 <malloc+0x1234>
    2f76:	00003097          	auipc	ra,0x3
    2f7a:	dfe080e7          	jalr	-514(ra) # 5d74 <printf>
  for(int i = 0; i < nzz; i++){
    2f7e:	bd65                	j	2e36 <diskfull+0xb8>
    printf("%s: mkdir(diskfulldir) unexpectedly succeeded!\n");
    2f80:	00004517          	auipc	a0,0x4
    2f84:	11850513          	add	a0,a0,280 # 7098 <malloc+0x1254>
    2f88:	00003097          	auipc	ra,0x3
    2f8c:	dec080e7          	jalr	-532(ra) # 5d74 <printf>
    2f90:	bf29                	j	2eaa <diskfull+0x12c>

0000000000002f92 <iputtest>:
{
    2f92:	1101                	add	sp,sp,-32
    2f94:	e822                	sd	s0,16(sp)
    2f96:	e426                	sd	s1,8(sp)
    2f98:	ec06                	sd	ra,24(sp)
    2f9a:	1000                	add	s0,sp,32
    2f9c:	84aa                	mv	s1,a0
  if(mkdir("iputdir") < 0){
    2f9e:	00004517          	auipc	a0,0x4
    2fa2:	12a50513          	add	a0,a0,298 # 70c8 <malloc+0x1284>
    2fa6:	00003097          	auipc	ra,0x3
    2faa:	adc080e7          	jalr	-1316(ra) # 5a82 <mkdir>
    2fae:	04054563          	bltz	a0,2ff8 <iputtest+0x66>
  if(chdir("iputdir") < 0){
    2fb2:	00004517          	auipc	a0,0x4
    2fb6:	11650513          	add	a0,a0,278 # 70c8 <malloc+0x1284>
    2fba:	00003097          	auipc	ra,0x3
    2fbe:	ad0080e7          	jalr	-1328(ra) # 5a8a <chdir>
    2fc2:	08054563          	bltz	a0,304c <iputtest+0xba>
  if(unlink("../iputdir") < 0){
    2fc6:	00004517          	auipc	a0,0x4
    2fca:	14250513          	add	a0,a0,322 # 7108 <malloc+0x12c4>
    2fce:	00003097          	auipc	ra,0x3
    2fd2:	a9c080e7          	jalr	-1380(ra) # 5a6a <unlink>
    2fd6:	04054d63          	bltz	a0,3030 <iputtest+0x9e>
  if(chdir("/") < 0){
    2fda:	00004517          	auipc	a0,0x4
    2fde:	15e50513          	add	a0,a0,350 # 7138 <malloc+0x12f4>
    2fe2:	00003097          	auipc	ra,0x3
    2fe6:	aa8080e7          	jalr	-1368(ra) # 5a8a <chdir>
    2fea:	02054563          	bltz	a0,3014 <iputtest+0x82>
}
    2fee:	60e2                	ld	ra,24(sp)
    2ff0:	6442                	ld	s0,16(sp)
    2ff2:	64a2                	ld	s1,8(sp)
    2ff4:	6105                	add	sp,sp,32
    2ff6:	8082                	ret
    printf("%s: mkdir failed\n", s);
    2ff8:	00004517          	auipc	a0,0x4
    2ffc:	0d850513          	add	a0,a0,216 # 70d0 <malloc+0x128c>
    3000:	85a6                	mv	a1,s1
    3002:	00003097          	auipc	ra,0x3
    3006:	d72080e7          	jalr	-654(ra) # 5d74 <printf>
    exit(1);
    300a:	4505                	li	a0,1
    300c:	00003097          	auipc	ra,0x3
    3010:	a0e080e7          	jalr	-1522(ra) # 5a1a <exit>
    printf("%s: chdir / failed\n", s);
    3014:	00004517          	auipc	a0,0x4
    3018:	12c50513          	add	a0,a0,300 # 7140 <malloc+0x12fc>
    301c:	85a6                	mv	a1,s1
    301e:	00003097          	auipc	ra,0x3
    3022:	d56080e7          	jalr	-682(ra) # 5d74 <printf>
    exit(1);
    3026:	4505                	li	a0,1
    3028:	00003097          	auipc	ra,0x3
    302c:	9f2080e7          	jalr	-1550(ra) # 5a1a <exit>
    printf("%s: unlink ../iputdir failed\n", s);
    3030:	00004517          	auipc	a0,0x4
    3034:	0e850513          	add	a0,a0,232 # 7118 <malloc+0x12d4>
    3038:	85a6                	mv	a1,s1
    303a:	00003097          	auipc	ra,0x3
    303e:	d3a080e7          	jalr	-710(ra) # 5d74 <printf>
    exit(1);
    3042:	4505                	li	a0,1
    3044:	00003097          	auipc	ra,0x3
    3048:	9d6080e7          	jalr	-1578(ra) # 5a1a <exit>
    printf("%s: chdir iputdir failed\n", s);
    304c:	00004517          	auipc	a0,0x4
    3050:	09c50513          	add	a0,a0,156 # 70e8 <malloc+0x12a4>
    3054:	85a6                	mv	a1,s1
    3056:	00003097          	auipc	ra,0x3
    305a:	d1e080e7          	jalr	-738(ra) # 5d74 <printf>
    exit(1);
    305e:	4505                	li	a0,1
    3060:	00003097          	auipc	ra,0x3
    3064:	9ba080e7          	jalr	-1606(ra) # 5a1a <exit>

0000000000003068 <exitiputtest>:
{
    3068:	7179                	add	sp,sp,-48
    306a:	f022                	sd	s0,32(sp)
    306c:	ec26                	sd	s1,24(sp)
    306e:	f406                	sd	ra,40(sp)
    3070:	1800                	add	s0,sp,48
    3072:	84aa                	mv	s1,a0
  pid = fork();
    3074:	00003097          	auipc	ra,0x3
    3078:	99e080e7          	jalr	-1634(ra) # 5a12 <fork>
  if(pid < 0){
    307c:	06054263          	bltz	a0,30e0 <exitiputtest+0x78>
  if(pid == 0){
    3080:	e521                	bnez	a0,30c8 <exitiputtest+0x60>
    if(mkdir("iputdir") < 0){
    3082:	00004517          	auipc	a0,0x4
    3086:	04650513          	add	a0,a0,70 # 70c8 <malloc+0x1284>
    308a:	00003097          	auipc	ra,0x3
    308e:	9f8080e7          	jalr	-1544(ra) # 5a82 <mkdir>
    3092:	08054363          	bltz	a0,3118 <exitiputtest+0xb0>
    if(chdir("iputdir") < 0){
    3096:	00004517          	auipc	a0,0x4
    309a:	03250513          	add	a0,a0,50 # 70c8 <malloc+0x1284>
    309e:	00003097          	auipc	ra,0x3
    30a2:	9ec080e7          	jalr	-1556(ra) # 5a8a <chdir>
    30a6:	04054b63          	bltz	a0,30fc <exitiputtest+0x94>
    if(unlink("../iputdir") < 0){
    30aa:	00004517          	auipc	a0,0x4
    30ae:	05e50513          	add	a0,a0,94 # 7108 <malloc+0x12c4>
    30b2:	00003097          	auipc	ra,0x3
    30b6:	9b8080e7          	jalr	-1608(ra) # 5a6a <unlink>
    30ba:	06054d63          	bltz	a0,3134 <exitiputtest+0xcc>
    exit(0);
    30be:	4501                	li	a0,0
    30c0:	00003097          	auipc	ra,0x3
    30c4:	95a080e7          	jalr	-1702(ra) # 5a1a <exit>
  wait(&xstatus);
    30c8:	fdc40513          	add	a0,s0,-36
    30cc:	00003097          	auipc	ra,0x3
    30d0:	956080e7          	jalr	-1706(ra) # 5a22 <wait>
  exit(xstatus);
    30d4:	fdc42503          	lw	a0,-36(s0)
    30d8:	00003097          	auipc	ra,0x3
    30dc:	942080e7          	jalr	-1726(ra) # 5a1a <exit>
    printf("%s: fork failed\n", s);
    30e0:	00003517          	auipc	a0,0x3
    30e4:	63050513          	add	a0,a0,1584 # 6710 <malloc+0x8cc>
    30e8:	85a6                	mv	a1,s1
    30ea:	00003097          	auipc	ra,0x3
    30ee:	c8a080e7          	jalr	-886(ra) # 5d74 <printf>
    exit(1);
    30f2:	4505                	li	a0,1
    30f4:	00003097          	auipc	ra,0x3
    30f8:	926080e7          	jalr	-1754(ra) # 5a1a <exit>
      printf("%s: child chdir failed\n", s);
    30fc:	00004517          	auipc	a0,0x4
    3100:	05c50513          	add	a0,a0,92 # 7158 <malloc+0x1314>
    3104:	85a6                	mv	a1,s1
    3106:	00003097          	auipc	ra,0x3
    310a:	c6e080e7          	jalr	-914(ra) # 5d74 <printf>
      exit(1);
    310e:	4505                	li	a0,1
    3110:	00003097          	auipc	ra,0x3
    3114:	90a080e7          	jalr	-1782(ra) # 5a1a <exit>
      printf("%s: mkdir failed\n", s);
    3118:	00004517          	auipc	a0,0x4
    311c:	fb850513          	add	a0,a0,-72 # 70d0 <malloc+0x128c>
    3120:	85a6                	mv	a1,s1
    3122:	00003097          	auipc	ra,0x3
    3126:	c52080e7          	jalr	-942(ra) # 5d74 <printf>
      exit(1);
    312a:	4505                	li	a0,1
    312c:	00003097          	auipc	ra,0x3
    3130:	8ee080e7          	jalr	-1810(ra) # 5a1a <exit>
      printf("%s: unlink ../iputdir failed\n", s);
    3134:	00004517          	auipc	a0,0x4
    3138:	fe450513          	add	a0,a0,-28 # 7118 <malloc+0x12d4>
    313c:	85a6                	mv	a1,s1
    313e:	00003097          	auipc	ra,0x3
    3142:	c36080e7          	jalr	-970(ra) # 5d74 <printf>
      exit(1);
    3146:	4505                	li	a0,1
    3148:	00003097          	auipc	ra,0x3
    314c:	8d2080e7          	jalr	-1838(ra) # 5a1a <exit>

0000000000003150 <dirtest>:
{
    3150:	1101                	add	sp,sp,-32
    3152:	e822                	sd	s0,16(sp)
    3154:	e426                	sd	s1,8(sp)
    3156:	ec06                	sd	ra,24(sp)
    3158:	1000                	add	s0,sp,32
    315a:	84aa                	mv	s1,a0
  if(mkdir("dir0") < 0){
    315c:	00004517          	auipc	a0,0x4
    3160:	01450513          	add	a0,a0,20 # 7170 <malloc+0x132c>
    3164:	00003097          	auipc	ra,0x3
    3168:	91e080e7          	jalr	-1762(ra) # 5a82 <mkdir>
    316c:	04054563          	bltz	a0,31b6 <dirtest+0x66>
  if(chdir("dir0") < 0){
    3170:	00004517          	auipc	a0,0x4
    3174:	00050513          	mv	a0,a0
    3178:	00003097          	auipc	ra,0x3
    317c:	912080e7          	jalr	-1774(ra) # 5a8a <chdir>
    3180:	08054563          	bltz	a0,320a <dirtest+0xba>
  if(chdir("..") < 0){
    3184:	00004517          	auipc	a0,0x4
    3188:	00c50513          	add	a0,a0,12 # 7190 <malloc+0x134c>
    318c:	00003097          	auipc	ra,0x3
    3190:	8fe080e7          	jalr	-1794(ra) # 5a8a <chdir>
    3194:	04054d63          	bltz	a0,31ee <dirtest+0x9e>
  if(unlink("dir0") < 0){
    3198:	00004517          	auipc	a0,0x4
    319c:	fd850513          	add	a0,a0,-40 # 7170 <malloc+0x132c>
    31a0:	00003097          	auipc	ra,0x3
    31a4:	8ca080e7          	jalr	-1846(ra) # 5a6a <unlink>
    31a8:	02054563          	bltz	a0,31d2 <dirtest+0x82>
}
    31ac:	60e2                	ld	ra,24(sp)
    31ae:	6442                	ld	s0,16(sp)
    31b0:	64a2                	ld	s1,8(sp)
    31b2:	6105                	add	sp,sp,32
    31b4:	8082                	ret
    printf("%s: mkdir failed\n", s);
    31b6:	00004517          	auipc	a0,0x4
    31ba:	f1a50513          	add	a0,a0,-230 # 70d0 <malloc+0x128c>
    31be:	85a6                	mv	a1,s1
    31c0:	00003097          	auipc	ra,0x3
    31c4:	bb4080e7          	jalr	-1100(ra) # 5d74 <printf>
    exit(1);
    31c8:	4505                	li	a0,1
    31ca:	00003097          	auipc	ra,0x3
    31ce:	850080e7          	jalr	-1968(ra) # 5a1a <exit>
    printf("%s: unlink dir0 failed\n", s);
    31d2:	00004517          	auipc	a0,0x4
    31d6:	fde50513          	add	a0,a0,-34 # 71b0 <malloc+0x136c>
    31da:	85a6                	mv	a1,s1
    31dc:	00003097          	auipc	ra,0x3
    31e0:	b98080e7          	jalr	-1128(ra) # 5d74 <printf>
    exit(1);
    31e4:	4505                	li	a0,1
    31e6:	00003097          	auipc	ra,0x3
    31ea:	834080e7          	jalr	-1996(ra) # 5a1a <exit>
    printf("%s: chdir .. failed\n", s);
    31ee:	00004517          	auipc	a0,0x4
    31f2:	faa50513          	add	a0,a0,-86 # 7198 <malloc+0x1354>
    31f6:	85a6                	mv	a1,s1
    31f8:	00003097          	auipc	ra,0x3
    31fc:	b7c080e7          	jalr	-1156(ra) # 5d74 <printf>
    exit(1);
    3200:	4505                	li	a0,1
    3202:	00003097          	auipc	ra,0x3
    3206:	818080e7          	jalr	-2024(ra) # 5a1a <exit>
    printf("%s: chdir dir0 failed\n", s);
    320a:	00004517          	auipc	a0,0x4
    320e:	f6e50513          	add	a0,a0,-146 # 7178 <malloc+0x1334>
    3212:	85a6                	mv	a1,s1
    3214:	00003097          	auipc	ra,0x3
    3218:	b60080e7          	jalr	-1184(ra) # 5d74 <printf>
    exit(1);
    321c:	4505                	li	a0,1
    321e:	00002097          	auipc	ra,0x2
    3222:	7fc080e7          	jalr	2044(ra) # 5a1a <exit>

0000000000003226 <subdir>:
{
    3226:	1101                	add	sp,sp,-32
    3228:	e822                	sd	s0,16(sp)
    322a:	e04a                	sd	s2,0(sp)
    322c:	ec06                	sd	ra,24(sp)
    322e:	e426                	sd	s1,8(sp)
    3230:	1000                	add	s0,sp,32
    3232:	892a                	mv	s2,a0
  unlink("ff");
    3234:	00004517          	auipc	a0,0x4
    3238:	0c450513          	add	a0,a0,196 # 72f8 <malloc+0x14b4>
    323c:	00003097          	auipc	ra,0x3
    3240:	82e080e7          	jalr	-2002(ra) # 5a6a <unlink>
  if(mkdir("dd") != 0){
    3244:	00004517          	auipc	a0,0x4
    3248:	f8450513          	add	a0,a0,-124 # 71c8 <malloc+0x1384>
    324c:	00003097          	auipc	ra,0x3
    3250:	836080e7          	jalr	-1994(ra) # 5a82 <mkdir>
    3254:	5e051963          	bnez	a0,3846 <subdir+0x620>
  fd = open("dd/ff", O_CREATE | O_RDWR);
    3258:	20200593          	li	a1,514
    325c:	00004517          	auipc	a0,0x4
    3260:	f8c50513          	add	a0,a0,-116 # 71e8 <malloc+0x13a4>
    3264:	00002097          	auipc	ra,0x2
    3268:	7f6080e7          	jalr	2038(ra) # 5a5a <open>
    326c:	84aa                	mv	s1,a0
  if(fd < 0){
    326e:	5a054e63          	bltz	a0,382a <subdir+0x604>
  write(fd, "ff", 2);
    3272:	4609                	li	a2,2
    3274:	00004597          	auipc	a1,0x4
    3278:	08458593          	add	a1,a1,132 # 72f8 <malloc+0x14b4>
    327c:	00002097          	auipc	ra,0x2
    3280:	7be080e7          	jalr	1982(ra) # 5a3a <write>
  close(fd);
    3284:	8526                	mv	a0,s1
    3286:	00002097          	auipc	ra,0x2
    328a:	7bc080e7          	jalr	1980(ra) # 5a42 <close>
  if(unlink("dd") >= 0){
    328e:	00004517          	auipc	a0,0x4
    3292:	f3a50513          	add	a0,a0,-198 # 71c8 <malloc+0x1384>
    3296:	00002097          	auipc	ra,0x2
    329a:	7d4080e7          	jalr	2004(ra) # 5a6a <unlink>
    329e:	56055863          	bgez	a0,380e <subdir+0x5e8>
  if(mkdir("/dd/dd") != 0){
    32a2:	00004517          	auipc	a0,0x4
    32a6:	f9e50513          	add	a0,a0,-98 # 7240 <malloc+0x13fc>
    32aa:	00002097          	auipc	ra,0x2
    32ae:	7d8080e7          	jalr	2008(ra) # 5a82 <mkdir>
    32b2:	42051463          	bnez	a0,36da <subdir+0x4b4>
  fd = open("dd/dd/ff", O_CREATE | O_RDWR);
    32b6:	20200593          	li	a1,514
    32ba:	00004517          	auipc	a0,0x4
    32be:	fae50513          	add	a0,a0,-82 # 7268 <malloc+0x1424>
    32c2:	00002097          	auipc	ra,0x2
    32c6:	798080e7          	jalr	1944(ra) # 5a5a <open>
    32ca:	84aa                	mv	s1,a0
  if(fd < 0){
    32cc:	44054363          	bltz	a0,3712 <subdir+0x4ec>
  write(fd, "FF", 2);
    32d0:	4609                	li	a2,2
    32d2:	00004597          	auipc	a1,0x4
    32d6:	fc658593          	add	a1,a1,-58 # 7298 <malloc+0x1454>
    32da:	00002097          	auipc	ra,0x2
    32de:	760080e7          	jalr	1888(ra) # 5a3a <write>
  close(fd);
    32e2:	8526                	mv	a0,s1
    32e4:	00002097          	auipc	ra,0x2
    32e8:	75e080e7          	jalr	1886(ra) # 5a42 <close>
  fd = open("dd/dd/../ff", 0);
    32ec:	4581                	li	a1,0
    32ee:	00004517          	auipc	a0,0x4
    32f2:	fb250513          	add	a0,a0,-78 # 72a0 <malloc+0x145c>
    32f6:	00002097          	auipc	ra,0x2
    32fa:	764080e7          	jalr	1892(ra) # 5a5a <open>
    32fe:	84aa                	mv	s1,a0
  if(fd < 0){
    3300:	3e054b63          	bltz	a0,36f6 <subdir+0x4d0>
  cc = read(fd, buf, sizeof(buf));
    3304:	660d                	lui	a2,0x3
    3306:	0000a597          	auipc	a1,0xa
    330a:	97258593          	add	a1,a1,-1678 # cc78 <buf>
    330e:	00002097          	auipc	ra,0x2
    3312:	724080e7          	jalr	1828(ra) # 5a32 <read>
  if(cc != 2 || buf[0] != 'f'){
    3316:	4789                	li	a5,2
    3318:	2cf51363          	bne	a0,a5,35de <subdir+0x3b8>
    331c:	0000a717          	auipc	a4,0xa
    3320:	95c74703          	lbu	a4,-1700(a4) # cc78 <buf>
    3324:	06600793          	li	a5,102
    3328:	2af71b63          	bne	a4,a5,35de <subdir+0x3b8>
  close(fd);
    332c:	8526                	mv	a0,s1
    332e:	00002097          	auipc	ra,0x2
    3332:	714080e7          	jalr	1812(ra) # 5a42 <close>
  if(link("dd/dd/ff", "dd/dd/ffff") != 0){
    3336:	00004597          	auipc	a1,0x4
    333a:	fba58593          	add	a1,a1,-70 # 72f0 <malloc+0x14ac>
    333e:	00004517          	auipc	a0,0x4
    3342:	f2a50513          	add	a0,a0,-214 # 7268 <malloc+0x1424>
    3346:	00002097          	auipc	ra,0x2
    334a:	734080e7          	jalr	1844(ra) # 5a7a <link>
    334e:	46051663          	bnez	a0,37ba <subdir+0x594>
  if(unlink("dd/dd/ff") != 0){
    3352:	00004517          	auipc	a0,0x4
    3356:	f1650513          	add	a0,a0,-234 # 7268 <malloc+0x1424>
    335a:	00002097          	auipc	ra,0x2
    335e:	710080e7          	jalr	1808(ra) # 5a6a <unlink>
    3362:	28051c63          	bnez	a0,35fa <subdir+0x3d4>
  if(open("dd/dd/ff", O_RDONLY) >= 0){
    3366:	4581                	li	a1,0
    3368:	00004517          	auipc	a0,0x4
    336c:	f0050513          	add	a0,a0,-256 # 7268 <malloc+0x1424>
    3370:	00002097          	auipc	ra,0x2
    3374:	6ea080e7          	jalr	1770(ra) # 5a5a <open>
    3378:	46055d63          	bgez	a0,37f2 <subdir+0x5cc>
  if(chdir("dd") != 0){
    337c:	00004517          	auipc	a0,0x4
    3380:	e4c50513          	add	a0,a0,-436 # 71c8 <malloc+0x1384>
    3384:	00002097          	auipc	ra,0x2
    3388:	706080e7          	jalr	1798(ra) # 5a8a <chdir>
    338c:	44051563          	bnez	a0,37d6 <subdir+0x5b0>
  if(chdir("dd/../../dd") != 0){
    3390:	00004517          	auipc	a0,0x4
    3394:	ff850513          	add	a0,a0,-8 # 7388 <malloc+0x1544>
    3398:	00002097          	auipc	ra,0x2
    339c:	6f2080e7          	jalr	1778(ra) # 5a8a <chdir>
    33a0:	60051963          	bnez	a0,39b2 <subdir+0x78c>
  if(chdir("dd/../../../dd") != 0){
    33a4:	00004517          	auipc	a0,0x4
    33a8:	01450513          	add	a0,a0,20 # 73b8 <malloc+0x1574>
    33ac:	00002097          	auipc	ra,0x2
    33b0:	6de080e7          	jalr	1758(ra) # 5a8a <chdir>
    33b4:	5e051163          	bnez	a0,3996 <subdir+0x770>
  if(chdir("./..") != 0){
    33b8:	00004517          	auipc	a0,0x4
    33bc:	03050513          	add	a0,a0,48 # 73e8 <malloc+0x15a4>
    33c0:	00002097          	auipc	ra,0x2
    33c4:	6ca080e7          	jalr	1738(ra) # 5a8a <chdir>
    33c8:	5a051963          	bnez	a0,397a <subdir+0x754>
  fd = open("dd/dd/ffff", 0);
    33cc:	4581                	li	a1,0
    33ce:	00004517          	auipc	a0,0x4
    33d2:	f2250513          	add	a0,a0,-222 # 72f0 <malloc+0x14ac>
    33d6:	00002097          	auipc	ra,0x2
    33da:	684080e7          	jalr	1668(ra) # 5a5a <open>
    33de:	84aa                	mv	s1,a0
  if(fd < 0){
    33e0:	2c054f63          	bltz	a0,36be <subdir+0x498>
  if(read(fd, buf, sizeof(buf)) != 2){
    33e4:	660d                	lui	a2,0x3
    33e6:	0000a597          	auipc	a1,0xa
    33ea:	89258593          	add	a1,a1,-1902 # cc78 <buf>
    33ee:	00002097          	auipc	ra,0x2
    33f2:	644080e7          	jalr	1604(ra) # 5a32 <read>
    33f6:	4789                	li	a5,2
    33f8:	22f51d63          	bne	a0,a5,3632 <subdir+0x40c>
  close(fd);
    33fc:	8526                	mv	a0,s1
    33fe:	00002097          	auipc	ra,0x2
    3402:	644080e7          	jalr	1604(ra) # 5a42 <close>
  if(open("dd/dd/ff", O_RDONLY) >= 0){
    3406:	4581                	li	a1,0
    3408:	00004517          	auipc	a0,0x4
    340c:	e6050513          	add	a0,a0,-416 # 7268 <malloc+0x1424>
    3410:	00002097          	auipc	ra,0x2
    3414:	64a080e7          	jalr	1610(ra) # 5a5a <open>
    3418:	1e055f63          	bgez	a0,3616 <subdir+0x3f0>
  if(open("dd/ff/ff", O_CREATE|O_RDWR) >= 0){
    341c:	20200593          	li	a1,514
    3420:	00004517          	auipc	a0,0x4
    3424:	05850513          	add	a0,a0,88 # 7478 <malloc+0x1634>
    3428:	00002097          	auipc	ra,0x2
    342c:	632080e7          	jalr	1586(ra) # 5a5a <open>
    3430:	20055f63          	bgez	a0,364e <subdir+0x428>
  if(open("dd/xx/ff", O_CREATE|O_RDWR) >= 0){
    3434:	20200593          	li	a1,514
    3438:	00004517          	auipc	a0,0x4
    343c:	07050513          	add	a0,a0,112 # 74a8 <malloc+0x1664>
    3440:	00002097          	auipc	ra,0x2
    3444:	61a080e7          	jalr	1562(ra) # 5a5a <open>
    3448:	34055b63          	bgez	a0,379e <subdir+0x578>
  if(open("dd", O_CREATE) >= 0){
    344c:	20000593          	li	a1,512
    3450:	00004517          	auipc	a0,0x4
    3454:	d7850513          	add	a0,a0,-648 # 71c8 <malloc+0x1384>
    3458:	00002097          	auipc	ra,0x2
    345c:	602080e7          	jalr	1538(ra) # 5a5a <open>
    3460:	32055163          	bgez	a0,3782 <subdir+0x55c>
  if(open("dd", O_RDWR) >= 0){
    3464:	4589                	li	a1,2
    3466:	00004517          	auipc	a0,0x4
    346a:	d6250513          	add	a0,a0,-670 # 71c8 <malloc+0x1384>
    346e:	00002097          	auipc	ra,0x2
    3472:	5ec080e7          	jalr	1516(ra) # 5a5a <open>
    3476:	2e055863          	bgez	a0,3766 <subdir+0x540>
  if(open("dd", O_WRONLY) >= 0){
    347a:	4585                	li	a1,1
    347c:	00004517          	auipc	a0,0x4
    3480:	d4c50513          	add	a0,a0,-692 # 71c8 <malloc+0x1384>
    3484:	00002097          	auipc	ra,0x2
    3488:	5d6080e7          	jalr	1494(ra) # 5a5a <open>
    348c:	2a055f63          	bgez	a0,374a <subdir+0x524>
  if(link("dd/ff/ff", "dd/dd/xx") == 0){
    3490:	00004597          	auipc	a1,0x4
    3494:	0a858593          	add	a1,a1,168 # 7538 <malloc+0x16f4>
    3498:	00004517          	auipc	a0,0x4
    349c:	fe050513          	add	a0,a0,-32 # 7478 <malloc+0x1634>
    34a0:	00002097          	auipc	ra,0x2
    34a4:	5da080e7          	jalr	1498(ra) # 5a7a <link>
    34a8:	28050363          	beqz	a0,372e <subdir+0x508>
  if(link("dd/xx/ff", "dd/dd/xx") == 0){
    34ac:	00004597          	auipc	a1,0x4
    34b0:	08c58593          	add	a1,a1,140 # 7538 <malloc+0x16f4>
    34b4:	00004517          	auipc	a0,0x4
    34b8:	ff450513          	add	a0,a0,-12 # 74a8 <malloc+0x1664>
    34bc:	00002097          	auipc	ra,0x2
    34c0:	5be080e7          	jalr	1470(ra) # 5a7a <link>
    34c4:	1c050163          	beqz	a0,3686 <subdir+0x460>
  if(link("dd/ff", "dd/dd/ffff") == 0){
    34c8:	00004597          	auipc	a1,0x4
    34cc:	e2858593          	add	a1,a1,-472 # 72f0 <malloc+0x14ac>
    34d0:	00004517          	auipc	a0,0x4
    34d4:	d1850513          	add	a0,a0,-744 # 71e8 <malloc+0x13a4>
    34d8:	00002097          	auipc	ra,0x2
    34dc:	5a2080e7          	jalr	1442(ra) # 5a7a <link>
    34e0:	18050563          	beqz	a0,366a <subdir+0x444>
  if(mkdir("dd/ff/ff") == 0){
    34e4:	00004517          	auipc	a0,0x4
    34e8:	f9450513          	add	a0,a0,-108 # 7478 <malloc+0x1634>
    34ec:	00002097          	auipc	ra,0x2
    34f0:	596080e7          	jalr	1430(ra) # 5a82 <mkdir>
    34f4:	1a050763          	beqz	a0,36a2 <subdir+0x47c>
  if(mkdir("dd/xx/ff") == 0){
    34f8:	00004517          	auipc	a0,0x4
    34fc:	fb050513          	add	a0,a0,-80 # 74a8 <malloc+0x1664>
    3500:	00002097          	auipc	ra,0x2
    3504:	582080e7          	jalr	1410(ra) # 5a82 <mkdir>
    3508:	44050b63          	beqz	a0,395e <subdir+0x738>
  if(mkdir("dd/dd/ffff") == 0){
    350c:	00004517          	auipc	a0,0x4
    3510:	de450513          	add	a0,a0,-540 # 72f0 <malloc+0x14ac>
    3514:	00002097          	auipc	ra,0x2
    3518:	56e080e7          	jalr	1390(ra) # 5a82 <mkdir>
    351c:	42050363          	beqz	a0,3942 <subdir+0x71c>
  if(unlink("dd/xx/ff") == 0){
    3520:	00004517          	auipc	a0,0x4
    3524:	f8850513          	add	a0,a0,-120 # 74a8 <malloc+0x1664>
    3528:	00002097          	auipc	ra,0x2
    352c:	542080e7          	jalr	1346(ra) # 5a6a <unlink>
    3530:	3e050b63          	beqz	a0,3926 <subdir+0x700>
  if(unlink("dd/ff/ff") == 0){
    3534:	00004517          	auipc	a0,0x4
    3538:	f4450513          	add	a0,a0,-188 # 7478 <malloc+0x1634>
    353c:	00002097          	auipc	ra,0x2
    3540:	52e080e7          	jalr	1326(ra) # 5a6a <unlink>
    3544:	3c050363          	beqz	a0,390a <subdir+0x6e4>
  if(chdir("dd/ff") == 0){
    3548:	00004517          	auipc	a0,0x4
    354c:	ca050513          	add	a0,a0,-864 # 71e8 <malloc+0x13a4>
    3550:	00002097          	auipc	ra,0x2
    3554:	53a080e7          	jalr	1338(ra) # 5a8a <chdir>
    3558:	38050b63          	beqz	a0,38ee <subdir+0x6c8>
  if(chdir("dd/xx") == 0){
    355c:	00004517          	auipc	a0,0x4
    3560:	12c50513          	add	a0,a0,300 # 7688 <malloc+0x1844>
    3564:	00002097          	auipc	ra,0x2
    3568:	526080e7          	jalr	1318(ra) # 5a8a <chdir>
    356c:	36050363          	beqz	a0,38d2 <subdir+0x6ac>
  if(unlink("dd/dd/ffff") != 0){
    3570:	00004517          	auipc	a0,0x4
    3574:	d8050513          	add	a0,a0,-640 # 72f0 <malloc+0x14ac>
    3578:	00002097          	auipc	ra,0x2
    357c:	4f2080e7          	jalr	1266(ra) # 5a6a <unlink>
    3580:	ed2d                	bnez	a0,35fa <subdir+0x3d4>
  if(unlink("dd/ff") != 0){
    3582:	00004517          	auipc	a0,0x4
    3586:	c6650513          	add	a0,a0,-922 # 71e8 <malloc+0x13a4>
    358a:	00002097          	auipc	ra,0x2
    358e:	4e0080e7          	jalr	1248(ra) # 5a6a <unlink>
    3592:	32051263          	bnez	a0,38b6 <subdir+0x690>
  if(unlink("dd") == 0){
    3596:	00004517          	auipc	a0,0x4
    359a:	c3250513          	add	a0,a0,-974 # 71c8 <malloc+0x1384>
    359e:	00002097          	auipc	ra,0x2
    35a2:	4cc080e7          	jalr	1228(ra) # 5a6a <unlink>
    35a6:	2e050a63          	beqz	a0,389a <subdir+0x674>
  if(unlink("dd/dd") < 0){
    35aa:	00004517          	auipc	a0,0x4
    35ae:	14e50513          	add	a0,a0,334 # 76f8 <malloc+0x18b4>
    35b2:	00002097          	auipc	ra,0x2
    35b6:	4b8080e7          	jalr	1208(ra) # 5a6a <unlink>
    35ba:	2c054263          	bltz	a0,387e <subdir+0x658>
  if(unlink("dd") < 0){
    35be:	00004517          	auipc	a0,0x4
    35c2:	c0a50513          	add	a0,a0,-1014 # 71c8 <malloc+0x1384>
    35c6:	00002097          	auipc	ra,0x2
    35ca:	4a4080e7          	jalr	1188(ra) # 5a6a <unlink>
    35ce:	28054a63          	bltz	a0,3862 <subdir+0x63c>
}
    35d2:	60e2                	ld	ra,24(sp)
    35d4:	6442                	ld	s0,16(sp)
    35d6:	64a2                	ld	s1,8(sp)
    35d8:	6902                	ld	s2,0(sp)
    35da:	6105                	add	sp,sp,32
    35dc:	8082                	ret
    printf("%s: dd/dd/../ff wrong content\n", s);
    35de:	00004517          	auipc	a0,0x4
    35e2:	cf250513          	add	a0,a0,-782 # 72d0 <malloc+0x148c>
    35e6:	85ca                	mv	a1,s2
    35e8:	00002097          	auipc	ra,0x2
    35ec:	78c080e7          	jalr	1932(ra) # 5d74 <printf>
    exit(1);
    35f0:	4505                	li	a0,1
    35f2:	00002097          	auipc	ra,0x2
    35f6:	428080e7          	jalr	1064(ra) # 5a1a <exit>
    printf("%s: unlink dd/dd/ff failed\n", s);
    35fa:	00004517          	auipc	a0,0x4
    35fe:	d2e50513          	add	a0,a0,-722 # 7328 <malloc+0x14e4>
    3602:	85ca                	mv	a1,s2
    3604:	00002097          	auipc	ra,0x2
    3608:	770080e7          	jalr	1904(ra) # 5d74 <printf>
    exit(1);
    360c:	4505                	li	a0,1
    360e:	00002097          	auipc	ra,0x2
    3612:	40c080e7          	jalr	1036(ra) # 5a1a <exit>
    printf("%s: open (unlinked) dd/dd/ff succeeded!\n", s);
    3616:	00004517          	auipc	a0,0x4
    361a:	e3250513          	add	a0,a0,-462 # 7448 <malloc+0x1604>
    361e:	85ca                	mv	a1,s2
    3620:	00002097          	auipc	ra,0x2
    3624:	754080e7          	jalr	1876(ra) # 5d74 <printf>
    exit(1);
    3628:	4505                	li	a0,1
    362a:	00002097          	auipc	ra,0x2
    362e:	3f0080e7          	jalr	1008(ra) # 5a1a <exit>
    printf("%s: read dd/dd/ffff wrong len\n", s);
    3632:	00004517          	auipc	a0,0x4
    3636:	df650513          	add	a0,a0,-522 # 7428 <malloc+0x15e4>
    363a:	85ca                	mv	a1,s2
    363c:	00002097          	auipc	ra,0x2
    3640:	738080e7          	jalr	1848(ra) # 5d74 <printf>
    exit(1);
    3644:	4505                	li	a0,1
    3646:	00002097          	auipc	ra,0x2
    364a:	3d4080e7          	jalr	980(ra) # 5a1a <exit>
    printf("%s: create dd/ff/ff succeeded!\n", s);
    364e:	00004517          	auipc	a0,0x4
    3652:	e3a50513          	add	a0,a0,-454 # 7488 <malloc+0x1644>
    3656:	85ca                	mv	a1,s2
    3658:	00002097          	auipc	ra,0x2
    365c:	71c080e7          	jalr	1820(ra) # 5d74 <printf>
    exit(1);
    3660:	4505                	li	a0,1
    3662:	00002097          	auipc	ra,0x2
    3666:	3b8080e7          	jalr	952(ra) # 5a1a <exit>
    printf("%s: link dd/ff dd/dd/ffff succeeded!\n", s);
    366a:	00004517          	auipc	a0,0x4
    366e:	f2e50513          	add	a0,a0,-210 # 7598 <malloc+0x1754>
    3672:	85ca                	mv	a1,s2
    3674:	00002097          	auipc	ra,0x2
    3678:	700080e7          	jalr	1792(ra) # 5d74 <printf>
    exit(1);
    367c:	4505                	li	a0,1
    367e:	00002097          	auipc	ra,0x2
    3682:	39c080e7          	jalr	924(ra) # 5a1a <exit>
    printf("%s: link dd/xx/ff dd/dd/xx succeeded!\n", s);
    3686:	00004517          	auipc	a0,0x4
    368a:	eea50513          	add	a0,a0,-278 # 7570 <malloc+0x172c>
    368e:	85ca                	mv	a1,s2
    3690:	00002097          	auipc	ra,0x2
    3694:	6e4080e7          	jalr	1764(ra) # 5d74 <printf>
    exit(1);
    3698:	4505                	li	a0,1
    369a:	00002097          	auipc	ra,0x2
    369e:	380080e7          	jalr	896(ra) # 5a1a <exit>
    printf("%s: mkdir dd/ff/ff succeeded!\n", s);
    36a2:	00004517          	auipc	a0,0x4
    36a6:	f1e50513          	add	a0,a0,-226 # 75c0 <malloc+0x177c>
    36aa:	85ca                	mv	a1,s2
    36ac:	00002097          	auipc	ra,0x2
    36b0:	6c8080e7          	jalr	1736(ra) # 5d74 <printf>
    exit(1);
    36b4:	4505                	li	a0,1
    36b6:	00002097          	auipc	ra,0x2
    36ba:	364080e7          	jalr	868(ra) # 5a1a <exit>
    printf("%s: open dd/dd/ffff failed\n", s);
    36be:	00004517          	auipc	a0,0x4
    36c2:	d4a50513          	add	a0,a0,-694 # 7408 <malloc+0x15c4>
    36c6:	85ca                	mv	a1,s2
    36c8:	00002097          	auipc	ra,0x2
    36cc:	6ac080e7          	jalr	1708(ra) # 5d74 <printf>
    exit(1);
    36d0:	4505                	li	a0,1
    36d2:	00002097          	auipc	ra,0x2
    36d6:	348080e7          	jalr	840(ra) # 5a1a <exit>
    printf("subdir mkdir dd/dd failed\n", s);
    36da:	00004517          	auipc	a0,0x4
    36de:	b6e50513          	add	a0,a0,-1170 # 7248 <malloc+0x1404>
    36e2:	85ca                	mv	a1,s2
    36e4:	00002097          	auipc	ra,0x2
    36e8:	690080e7          	jalr	1680(ra) # 5d74 <printf>
    exit(1);
    36ec:	4505                	li	a0,1
    36ee:	00002097          	auipc	ra,0x2
    36f2:	32c080e7          	jalr	812(ra) # 5a1a <exit>
    printf("%s: open dd/dd/../ff failed\n", s);
    36f6:	00004517          	auipc	a0,0x4
    36fa:	bba50513          	add	a0,a0,-1094 # 72b0 <malloc+0x146c>
    36fe:	85ca                	mv	a1,s2
    3700:	00002097          	auipc	ra,0x2
    3704:	674080e7          	jalr	1652(ra) # 5d74 <printf>
    exit(1);
    3708:	4505                	li	a0,1
    370a:	00002097          	auipc	ra,0x2
    370e:	310080e7          	jalr	784(ra) # 5a1a <exit>
    printf("%s: create dd/dd/ff failed\n", s);
    3712:	00004517          	auipc	a0,0x4
    3716:	b6650513          	add	a0,a0,-1178 # 7278 <malloc+0x1434>
    371a:	85ca                	mv	a1,s2
    371c:	00002097          	auipc	ra,0x2
    3720:	658080e7          	jalr	1624(ra) # 5d74 <printf>
    exit(1);
    3724:	4505                	li	a0,1
    3726:	00002097          	auipc	ra,0x2
    372a:	2f4080e7          	jalr	756(ra) # 5a1a <exit>
    printf("%s: link dd/ff/ff dd/dd/xx succeeded!\n", s);
    372e:	00004517          	auipc	a0,0x4
    3732:	e1a50513          	add	a0,a0,-486 # 7548 <malloc+0x1704>
    3736:	85ca                	mv	a1,s2
    3738:	00002097          	auipc	ra,0x2
    373c:	63c080e7          	jalr	1596(ra) # 5d74 <printf>
    exit(1);
    3740:	4505                	li	a0,1
    3742:	00002097          	auipc	ra,0x2
    3746:	2d8080e7          	jalr	728(ra) # 5a1a <exit>
    printf("%s: open dd wronly succeeded!\n", s);
    374a:	00004517          	auipc	a0,0x4
    374e:	dce50513          	add	a0,a0,-562 # 7518 <malloc+0x16d4>
    3752:	85ca                	mv	a1,s2
    3754:	00002097          	auipc	ra,0x2
    3758:	620080e7          	jalr	1568(ra) # 5d74 <printf>
    exit(1);
    375c:	4505                	li	a0,1
    375e:	00002097          	auipc	ra,0x2
    3762:	2bc080e7          	jalr	700(ra) # 5a1a <exit>
    printf("%s: open dd rdwr succeeded!\n", s);
    3766:	00004517          	auipc	a0,0x4
    376a:	d9250513          	add	a0,a0,-622 # 74f8 <malloc+0x16b4>
    376e:	85ca                	mv	a1,s2
    3770:	00002097          	auipc	ra,0x2
    3774:	604080e7          	jalr	1540(ra) # 5d74 <printf>
    exit(1);
    3778:	4505                	li	a0,1
    377a:	00002097          	auipc	ra,0x2
    377e:	2a0080e7          	jalr	672(ra) # 5a1a <exit>
    printf("%s: create dd succeeded!\n", s);
    3782:	00004517          	auipc	a0,0x4
    3786:	d5650513          	add	a0,a0,-682 # 74d8 <malloc+0x1694>
    378a:	85ca                	mv	a1,s2
    378c:	00002097          	auipc	ra,0x2
    3790:	5e8080e7          	jalr	1512(ra) # 5d74 <printf>
    exit(1);
    3794:	4505                	li	a0,1
    3796:	00002097          	auipc	ra,0x2
    379a:	284080e7          	jalr	644(ra) # 5a1a <exit>
    printf("%s: create dd/xx/ff succeeded!\n", s);
    379e:	00004517          	auipc	a0,0x4
    37a2:	d1a50513          	add	a0,a0,-742 # 74b8 <malloc+0x1674>
    37a6:	85ca                	mv	a1,s2
    37a8:	00002097          	auipc	ra,0x2
    37ac:	5cc080e7          	jalr	1484(ra) # 5d74 <printf>
    exit(1);
    37b0:	4505                	li	a0,1
    37b2:	00002097          	auipc	ra,0x2
    37b6:	268080e7          	jalr	616(ra) # 5a1a <exit>
    printf("link dd/dd/ff dd/dd/ffff failed\n", s);
    37ba:	00004517          	auipc	a0,0x4
    37be:	b4650513          	add	a0,a0,-1210 # 7300 <malloc+0x14bc>
    37c2:	85ca                	mv	a1,s2
    37c4:	00002097          	auipc	ra,0x2
    37c8:	5b0080e7          	jalr	1456(ra) # 5d74 <printf>
    exit(1);
    37cc:	4505                	li	a0,1
    37ce:	00002097          	auipc	ra,0x2
    37d2:	24c080e7          	jalr	588(ra) # 5a1a <exit>
    printf("%s: chdir dd failed\n", s);
    37d6:	00004517          	auipc	a0,0x4
    37da:	b9a50513          	add	a0,a0,-1126 # 7370 <malloc+0x152c>
    37de:	85ca                	mv	a1,s2
    37e0:	00002097          	auipc	ra,0x2
    37e4:	594080e7          	jalr	1428(ra) # 5d74 <printf>
    exit(1);
    37e8:	4505                	li	a0,1
    37ea:	00002097          	auipc	ra,0x2
    37ee:	230080e7          	jalr	560(ra) # 5a1a <exit>
    printf("%s: open (unlinked) dd/dd/ff succeeded\n", s);
    37f2:	00004517          	auipc	a0,0x4
    37f6:	b5650513          	add	a0,a0,-1194 # 7348 <malloc+0x1504>
    37fa:	85ca                	mv	a1,s2
    37fc:	00002097          	auipc	ra,0x2
    3800:	578080e7          	jalr	1400(ra) # 5d74 <printf>
    exit(1);
    3804:	4505                	li	a0,1
    3806:	00002097          	auipc	ra,0x2
    380a:	214080e7          	jalr	532(ra) # 5a1a <exit>
    printf("%s: unlink dd (non-empty dir) succeeded!\n", s);
    380e:	00004517          	auipc	a0,0x4
    3812:	a0250513          	add	a0,a0,-1534 # 7210 <malloc+0x13cc>
    3816:	85ca                	mv	a1,s2
    3818:	00002097          	auipc	ra,0x2
    381c:	55c080e7          	jalr	1372(ra) # 5d74 <printf>
    exit(1);
    3820:	4505                	li	a0,1
    3822:	00002097          	auipc	ra,0x2
    3826:	1f8080e7          	jalr	504(ra) # 5a1a <exit>
    printf("%s: create dd/ff failed\n", s);
    382a:	00004517          	auipc	a0,0x4
    382e:	9c650513          	add	a0,a0,-1594 # 71f0 <malloc+0x13ac>
    3832:	85ca                	mv	a1,s2
    3834:	00002097          	auipc	ra,0x2
    3838:	540080e7          	jalr	1344(ra) # 5d74 <printf>
    exit(1);
    383c:	4505                	li	a0,1
    383e:	00002097          	auipc	ra,0x2
    3842:	1dc080e7          	jalr	476(ra) # 5a1a <exit>
    printf("%s: mkdir dd failed\n", s);
    3846:	00004517          	auipc	a0,0x4
    384a:	98a50513          	add	a0,a0,-1654 # 71d0 <malloc+0x138c>
    384e:	85ca                	mv	a1,s2
    3850:	00002097          	auipc	ra,0x2
    3854:	524080e7          	jalr	1316(ra) # 5d74 <printf>
    exit(1);
    3858:	4505                	li	a0,1
    385a:	00002097          	auipc	ra,0x2
    385e:	1c0080e7          	jalr	448(ra) # 5a1a <exit>
    printf("%s: unlink dd failed\n", s);
    3862:	00004517          	auipc	a0,0x4
    3866:	ebe50513          	add	a0,a0,-322 # 7720 <malloc+0x18dc>
    386a:	85ca                	mv	a1,s2
    386c:	00002097          	auipc	ra,0x2
    3870:	508080e7          	jalr	1288(ra) # 5d74 <printf>
    exit(1);
    3874:	4505                	li	a0,1
    3876:	00002097          	auipc	ra,0x2
    387a:	1a4080e7          	jalr	420(ra) # 5a1a <exit>
    printf("%s: unlink dd/dd failed\n", s);
    387e:	00004517          	auipc	a0,0x4
    3882:	e8250513          	add	a0,a0,-382 # 7700 <malloc+0x18bc>
    3886:	85ca                	mv	a1,s2
    3888:	00002097          	auipc	ra,0x2
    388c:	4ec080e7          	jalr	1260(ra) # 5d74 <printf>
    exit(1);
    3890:	4505                	li	a0,1
    3892:	00002097          	auipc	ra,0x2
    3896:	188080e7          	jalr	392(ra) # 5a1a <exit>
    printf("%s: unlink non-empty dd succeeded!\n", s);
    389a:	00004517          	auipc	a0,0x4
    389e:	e3650513          	add	a0,a0,-458 # 76d0 <malloc+0x188c>
    38a2:	85ca                	mv	a1,s2
    38a4:	00002097          	auipc	ra,0x2
    38a8:	4d0080e7          	jalr	1232(ra) # 5d74 <printf>
    exit(1);
    38ac:	4505                	li	a0,1
    38ae:	00002097          	auipc	ra,0x2
    38b2:	16c080e7          	jalr	364(ra) # 5a1a <exit>
    printf("%s: unlink dd/ff failed\n", s);
    38b6:	00004517          	auipc	a0,0x4
    38ba:	dfa50513          	add	a0,a0,-518 # 76b0 <malloc+0x186c>
    38be:	85ca                	mv	a1,s2
    38c0:	00002097          	auipc	ra,0x2
    38c4:	4b4080e7          	jalr	1204(ra) # 5d74 <printf>
    exit(1);
    38c8:	4505                	li	a0,1
    38ca:	00002097          	auipc	ra,0x2
    38ce:	150080e7          	jalr	336(ra) # 5a1a <exit>
    printf("%s: chdir dd/xx succeeded!\n", s);
    38d2:	00004517          	auipc	a0,0x4
    38d6:	dbe50513          	add	a0,a0,-578 # 7690 <malloc+0x184c>
    38da:	85ca                	mv	a1,s2
    38dc:	00002097          	auipc	ra,0x2
    38e0:	498080e7          	jalr	1176(ra) # 5d74 <printf>
    exit(1);
    38e4:	4505                	li	a0,1
    38e6:	00002097          	auipc	ra,0x2
    38ea:	134080e7          	jalr	308(ra) # 5a1a <exit>
    printf("%s: chdir dd/ff succeeded!\n", s);
    38ee:	00004517          	auipc	a0,0x4
    38f2:	d7a50513          	add	a0,a0,-646 # 7668 <malloc+0x1824>
    38f6:	85ca                	mv	a1,s2
    38f8:	00002097          	auipc	ra,0x2
    38fc:	47c080e7          	jalr	1148(ra) # 5d74 <printf>
    exit(1);
    3900:	4505                	li	a0,1
    3902:	00002097          	auipc	ra,0x2
    3906:	118080e7          	jalr	280(ra) # 5a1a <exit>
    printf("%s: unlink dd/ff/ff succeeded!\n", s);
    390a:	00004517          	auipc	a0,0x4
    390e:	d3e50513          	add	a0,a0,-706 # 7648 <malloc+0x1804>
    3912:	85ca                	mv	a1,s2
    3914:	00002097          	auipc	ra,0x2
    3918:	460080e7          	jalr	1120(ra) # 5d74 <printf>
    exit(1);
    391c:	4505                	li	a0,1
    391e:	00002097          	auipc	ra,0x2
    3922:	0fc080e7          	jalr	252(ra) # 5a1a <exit>
    printf("%s: unlink dd/xx/ff succeeded!\n", s);
    3926:	00004517          	auipc	a0,0x4
    392a:	d0250513          	add	a0,a0,-766 # 7628 <malloc+0x17e4>
    392e:	85ca                	mv	a1,s2
    3930:	00002097          	auipc	ra,0x2
    3934:	444080e7          	jalr	1092(ra) # 5d74 <printf>
    exit(1);
    3938:	4505                	li	a0,1
    393a:	00002097          	auipc	ra,0x2
    393e:	0e0080e7          	jalr	224(ra) # 5a1a <exit>
    printf("%s: mkdir dd/dd/ffff succeeded!\n", s);
    3942:	00004517          	auipc	a0,0x4
    3946:	cbe50513          	add	a0,a0,-834 # 7600 <malloc+0x17bc>
    394a:	85ca                	mv	a1,s2
    394c:	00002097          	auipc	ra,0x2
    3950:	428080e7          	jalr	1064(ra) # 5d74 <printf>
    exit(1);
    3954:	4505                	li	a0,1
    3956:	00002097          	auipc	ra,0x2
    395a:	0c4080e7          	jalr	196(ra) # 5a1a <exit>
    printf("%s: mkdir dd/xx/ff succeeded!\n", s);
    395e:	00004517          	auipc	a0,0x4
    3962:	c8250513          	add	a0,a0,-894 # 75e0 <malloc+0x179c>
    3966:	85ca                	mv	a1,s2
    3968:	00002097          	auipc	ra,0x2
    396c:	40c080e7          	jalr	1036(ra) # 5d74 <printf>
    exit(1);
    3970:	4505                	li	a0,1
    3972:	00002097          	auipc	ra,0x2
    3976:	0a8080e7          	jalr	168(ra) # 5a1a <exit>
    printf("%s: chdir ./.. failed\n", s);
    397a:	00004517          	auipc	a0,0x4
    397e:	a7650513          	add	a0,a0,-1418 # 73f0 <malloc+0x15ac>
    3982:	85ca                	mv	a1,s2
    3984:	00002097          	auipc	ra,0x2
    3988:	3f0080e7          	jalr	1008(ra) # 5d74 <printf>
    exit(1);
    398c:	4505                	li	a0,1
    398e:	00002097          	auipc	ra,0x2
    3992:	08c080e7          	jalr	140(ra) # 5a1a <exit>
    printf("chdir dd/../../dd failed\n", s);
    3996:	00004517          	auipc	a0,0x4
    399a:	a3250513          	add	a0,a0,-1486 # 73c8 <malloc+0x1584>
    399e:	85ca                	mv	a1,s2
    39a0:	00002097          	auipc	ra,0x2
    39a4:	3d4080e7          	jalr	980(ra) # 5d74 <printf>
    exit(1);
    39a8:	4505                	li	a0,1
    39aa:	00002097          	auipc	ra,0x2
    39ae:	070080e7          	jalr	112(ra) # 5a1a <exit>
    printf("%s: chdir dd/../../dd failed\n", s);
    39b2:	00004517          	auipc	a0,0x4
    39b6:	9e650513          	add	a0,a0,-1562 # 7398 <malloc+0x1554>
    39ba:	85ca                	mv	a1,s2
    39bc:	00002097          	auipc	ra,0x2
    39c0:	3b8080e7          	jalr	952(ra) # 5d74 <printf>
    exit(1);
    39c4:	4505                	li	a0,1
    39c6:	00002097          	auipc	ra,0x2
    39ca:	054080e7          	jalr	84(ra) # 5a1a <exit>

00000000000039ce <rmdot>:
{
    39ce:	1101                	add	sp,sp,-32
    39d0:	e822                	sd	s0,16(sp)
    39d2:	e426                	sd	s1,8(sp)
    39d4:	ec06                	sd	ra,24(sp)
    39d6:	1000                	add	s0,sp,32
    39d8:	84aa                	mv	s1,a0
  if(mkdir("dots") != 0){
    39da:	00004517          	auipc	a0,0x4
    39de:	d5e50513          	add	a0,a0,-674 # 7738 <malloc+0x18f4>
    39e2:	00002097          	auipc	ra,0x2
    39e6:	0a0080e7          	jalr	160(ra) # 5a82 <mkdir>
    39ea:	e559                	bnez	a0,3a78 <rmdot+0xaa>
  if(chdir("dots") != 0){
    39ec:	00004517          	auipc	a0,0x4
    39f0:	d4c50513          	add	a0,a0,-692 # 7738 <malloc+0x18f4>
    39f4:	00002097          	auipc	ra,0x2
    39f8:	096080e7          	jalr	150(ra) # 5a8a <chdir>
    39fc:	14051063          	bnez	a0,3b3c <rmdot+0x16e>
  if(unlink(".") == 0){
    3a00:	00003517          	auipc	a0,0x3
    3a04:	c0050513          	add	a0,a0,-1024 # 6600 <malloc+0x7bc>
    3a08:	00002097          	auipc	ra,0x2
    3a0c:	062080e7          	jalr	98(ra) # 5a6a <unlink>
    3a10:	10050863          	beqz	a0,3b20 <rmdot+0x152>
  if(unlink("..") == 0){
    3a14:	00003517          	auipc	a0,0x3
    3a18:	77c50513          	add	a0,a0,1916 # 7190 <malloc+0x134c>
    3a1c:	00002097          	auipc	ra,0x2
    3a20:	04e080e7          	jalr	78(ra) # 5a6a <unlink>
    3a24:	c165                	beqz	a0,3b04 <rmdot+0x136>
  if(chdir("/") != 0){
    3a26:	00003517          	auipc	a0,0x3
    3a2a:	71250513          	add	a0,a0,1810 # 7138 <malloc+0x12f4>
    3a2e:	00002097          	auipc	ra,0x2
    3a32:	05c080e7          	jalr	92(ra) # 5a8a <chdir>
    3a36:	e94d                	bnez	a0,3ae8 <rmdot+0x11a>
  if(unlink("dots/.") == 0){
    3a38:	00004517          	auipc	a0,0x4
    3a3c:	d6850513          	add	a0,a0,-664 # 77a0 <malloc+0x195c>
    3a40:	00002097          	auipc	ra,0x2
    3a44:	02a080e7          	jalr	42(ra) # 5a6a <unlink>
    3a48:	c151                	beqz	a0,3acc <rmdot+0xfe>
  if(unlink("dots/..") == 0){
    3a4a:	00004517          	auipc	a0,0x4
    3a4e:	d7e50513          	add	a0,a0,-642 # 77c8 <malloc+0x1984>
    3a52:	00002097          	auipc	ra,0x2
    3a56:	018080e7          	jalr	24(ra) # 5a6a <unlink>
    3a5a:	c939                	beqz	a0,3ab0 <rmdot+0xe2>
  if(unlink("dots") != 0){
    3a5c:	00004517          	auipc	a0,0x4
    3a60:	cdc50513          	add	a0,a0,-804 # 7738 <malloc+0x18f4>
    3a64:	00002097          	auipc	ra,0x2
    3a68:	006080e7          	jalr	6(ra) # 5a6a <unlink>
    3a6c:	e505                	bnez	a0,3a94 <rmdot+0xc6>
}
    3a6e:	60e2                	ld	ra,24(sp)
    3a70:	6442                	ld	s0,16(sp)
    3a72:	64a2                	ld	s1,8(sp)
    3a74:	6105                	add	sp,sp,32
    3a76:	8082                	ret
    printf("%s: mkdir dots failed\n", s);
    3a78:	00004517          	auipc	a0,0x4
    3a7c:	cc850513          	add	a0,a0,-824 # 7740 <malloc+0x18fc>
    3a80:	85a6                	mv	a1,s1
    3a82:	00002097          	auipc	ra,0x2
    3a86:	2f2080e7          	jalr	754(ra) # 5d74 <printf>
    exit(1);
    3a8a:	4505                	li	a0,1
    3a8c:	00002097          	auipc	ra,0x2
    3a90:	f8e080e7          	jalr	-114(ra) # 5a1a <exit>
    printf("%s: unlink dots failed!\n", s);
    3a94:	00004517          	auipc	a0,0x4
    3a98:	d5c50513          	add	a0,a0,-676 # 77f0 <malloc+0x19ac>
    3a9c:	85a6                	mv	a1,s1
    3a9e:	00002097          	auipc	ra,0x2
    3aa2:	2d6080e7          	jalr	726(ra) # 5d74 <printf>
    exit(1);
    3aa6:	4505                	li	a0,1
    3aa8:	00002097          	auipc	ra,0x2
    3aac:	f72080e7          	jalr	-142(ra) # 5a1a <exit>
    printf("%s: unlink dots/.. worked!\n", s);
    3ab0:	00004517          	auipc	a0,0x4
    3ab4:	d2050513          	add	a0,a0,-736 # 77d0 <malloc+0x198c>
    3ab8:	85a6                	mv	a1,s1
    3aba:	00002097          	auipc	ra,0x2
    3abe:	2ba080e7          	jalr	698(ra) # 5d74 <printf>
    exit(1);
    3ac2:	4505                	li	a0,1
    3ac4:	00002097          	auipc	ra,0x2
    3ac8:	f56080e7          	jalr	-170(ra) # 5a1a <exit>
    printf("%s: unlink dots/. worked!\n", s);
    3acc:	00004517          	auipc	a0,0x4
    3ad0:	cdc50513          	add	a0,a0,-804 # 77a8 <malloc+0x1964>
    3ad4:	85a6                	mv	a1,s1
    3ad6:	00002097          	auipc	ra,0x2
    3ada:	29e080e7          	jalr	670(ra) # 5d74 <printf>
    exit(1);
    3ade:	4505                	li	a0,1
    3ae0:	00002097          	auipc	ra,0x2
    3ae4:	f3a080e7          	jalr	-198(ra) # 5a1a <exit>
    printf("%s: chdir / failed\n", s);
    3ae8:	00003517          	auipc	a0,0x3
    3aec:	65850513          	add	a0,a0,1624 # 7140 <malloc+0x12fc>
    3af0:	85a6                	mv	a1,s1
    3af2:	00002097          	auipc	ra,0x2
    3af6:	282080e7          	jalr	642(ra) # 5d74 <printf>
    exit(1);
    3afa:	4505                	li	a0,1
    3afc:	00002097          	auipc	ra,0x2
    3b00:	f1e080e7          	jalr	-226(ra) # 5a1a <exit>
    printf("%s: rm .. worked!\n", s);
    3b04:	00004517          	auipc	a0,0x4
    3b08:	c8450513          	add	a0,a0,-892 # 7788 <malloc+0x1944>
    3b0c:	85a6                	mv	a1,s1
    3b0e:	00002097          	auipc	ra,0x2
    3b12:	266080e7          	jalr	614(ra) # 5d74 <printf>
    exit(1);
    3b16:	4505                	li	a0,1
    3b18:	00002097          	auipc	ra,0x2
    3b1c:	f02080e7          	jalr	-254(ra) # 5a1a <exit>
    printf("%s: rm . worked!\n", s);
    3b20:	00004517          	auipc	a0,0x4
    3b24:	c5050513          	add	a0,a0,-944 # 7770 <malloc+0x192c>
    3b28:	85a6                	mv	a1,s1
    3b2a:	00002097          	auipc	ra,0x2
    3b2e:	24a080e7          	jalr	586(ra) # 5d74 <printf>
    exit(1);
    3b32:	4505                	li	a0,1
    3b34:	00002097          	auipc	ra,0x2
    3b38:	ee6080e7          	jalr	-282(ra) # 5a1a <exit>
    printf("%s: chdir dots failed\n", s);
    3b3c:	00004517          	auipc	a0,0x4
    3b40:	c1c50513          	add	a0,a0,-996 # 7758 <malloc+0x1914>
    3b44:	85a6                	mv	a1,s1
    3b46:	00002097          	auipc	ra,0x2
    3b4a:	22e080e7          	jalr	558(ra) # 5d74 <printf>
    exit(1);
    3b4e:	4505                	li	a0,1
    3b50:	00002097          	auipc	ra,0x2
    3b54:	eca080e7          	jalr	-310(ra) # 5a1a <exit>

0000000000003b58 <dirfile>:
{
    3b58:	1101                	add	sp,sp,-32
    3b5a:	e822                	sd	s0,16(sp)
    3b5c:	e04a                	sd	s2,0(sp)
    3b5e:	ec06                	sd	ra,24(sp)
    3b60:	e426                	sd	s1,8(sp)
    3b62:	1000                	add	s0,sp,32
    3b64:	892a                	mv	s2,a0
  fd = open("dirfile", O_CREATE);
    3b66:	20000593          	li	a1,512
    3b6a:	00004517          	auipc	a0,0x4
    3b6e:	ca650513          	add	a0,a0,-858 # 7810 <malloc+0x19cc>
    3b72:	00002097          	auipc	ra,0x2
    3b76:	ee8080e7          	jalr	-280(ra) # 5a5a <open>
  if(fd < 0){
    3b7a:	12054763          	bltz	a0,3ca8 <dirfile+0x150>
  close(fd);
    3b7e:	00002097          	auipc	ra,0x2
    3b82:	ec4080e7          	jalr	-316(ra) # 5a42 <close>
  if(chdir("dirfile") == 0){
    3b86:	00004517          	auipc	a0,0x4
    3b8a:	c8a50513          	add	a0,a0,-886 # 7810 <malloc+0x19cc>
    3b8e:	00002097          	auipc	ra,0x2
    3b92:	efc080e7          	jalr	-260(ra) # 5a8a <chdir>
    3b96:	c97d                	beqz	a0,3c8c <dirfile+0x134>
  fd = open("dirfile/xx", 0);
    3b98:	4581                	li	a1,0
    3b9a:	00004517          	auipc	a0,0x4
    3b9e:	cbe50513          	add	a0,a0,-834 # 7858 <malloc+0x1a14>
    3ba2:	00002097          	auipc	ra,0x2
    3ba6:	eb8080e7          	jalr	-328(ra) # 5a5a <open>
  if(fd >= 0){
    3baa:	0c055363          	bgez	a0,3c70 <dirfile+0x118>
  fd = open("dirfile/xx", O_CREATE);
    3bae:	20000593          	li	a1,512
    3bb2:	00004517          	auipc	a0,0x4
    3bb6:	ca650513          	add	a0,a0,-858 # 7858 <malloc+0x1a14>
    3bba:	00002097          	auipc	ra,0x2
    3bbe:	ea0080e7          	jalr	-352(ra) # 5a5a <open>
  if(fd >= 0){
    3bc2:	0a055763          	bgez	a0,3c70 <dirfile+0x118>
  if(mkdir("dirfile/xx") == 0){
    3bc6:	00004517          	auipc	a0,0x4
    3bca:	c9250513          	add	a0,a0,-878 # 7858 <malloc+0x1a14>
    3bce:	00002097          	auipc	ra,0x2
    3bd2:	eb4080e7          	jalr	-332(ra) # 5a82 <mkdir>
    3bd6:	16050d63          	beqz	a0,3d50 <dirfile+0x1f8>
  if(unlink("dirfile/xx") == 0){
    3bda:	00004517          	auipc	a0,0x4
    3bde:	c7e50513          	add	a0,a0,-898 # 7858 <malloc+0x1a14>
    3be2:	00002097          	auipc	ra,0x2
    3be6:	e88080e7          	jalr	-376(ra) # 5a6a <unlink>
    3bea:	14050563          	beqz	a0,3d34 <dirfile+0x1dc>
  if(link("README", "dirfile/xx") == 0){
    3bee:	00004597          	auipc	a1,0x4
    3bf2:	c6a58593          	add	a1,a1,-918 # 7858 <malloc+0x1a14>
    3bf6:	00002517          	auipc	a0,0x2
    3bfa:	4fa50513          	add	a0,a0,1274 # 60f0 <malloc+0x2ac>
    3bfe:	00002097          	auipc	ra,0x2
    3c02:	e7c080e7          	jalr	-388(ra) # 5a7a <link>
    3c06:	10050963          	beqz	a0,3d18 <dirfile+0x1c0>
  if(unlink("dirfile") != 0){
    3c0a:	00004517          	auipc	a0,0x4
    3c0e:	c0650513          	add	a0,a0,-1018 # 7810 <malloc+0x19cc>
    3c12:	00002097          	auipc	ra,0x2
    3c16:	e58080e7          	jalr	-424(ra) # 5a6a <unlink>
    3c1a:	e16d                	bnez	a0,3cfc <dirfile+0x1a4>
  fd = open(".", O_RDWR);
    3c1c:	4589                	li	a1,2
    3c1e:	00003517          	auipc	a0,0x3
    3c22:	9e250513          	add	a0,a0,-1566 # 6600 <malloc+0x7bc>
    3c26:	00002097          	auipc	ra,0x2
    3c2a:	e34080e7          	jalr	-460(ra) # 5a5a <open>
  if(fd >= 0){
    3c2e:	0a055963          	bgez	a0,3ce0 <dirfile+0x188>
  fd = open(".", 0);
    3c32:	4581                	li	a1,0
    3c34:	00003517          	auipc	a0,0x3
    3c38:	9cc50513          	add	a0,a0,-1588 # 6600 <malloc+0x7bc>
    3c3c:	00002097          	auipc	ra,0x2
    3c40:	e1e080e7          	jalr	-482(ra) # 5a5a <open>
  if(write(fd, "x", 1) > 0){
    3c44:	4605                	li	a2,1
    3c46:	00002597          	auipc	a1,0x2
    3c4a:	34258593          	add	a1,a1,834 # 5f88 <malloc+0x144>
  fd = open(".", 0);
    3c4e:	84aa                	mv	s1,a0
  if(write(fd, "x", 1) > 0){
    3c50:	00002097          	auipc	ra,0x2
    3c54:	dea080e7          	jalr	-534(ra) # 5a3a <write>
    3c58:	06a04663          	bgtz	a0,3cc4 <dirfile+0x16c>
}
    3c5c:	6442                	ld	s0,16(sp)
    3c5e:	60e2                	ld	ra,24(sp)
    3c60:	6902                	ld	s2,0(sp)
  close(fd);
    3c62:	8526                	mv	a0,s1
}
    3c64:	64a2                	ld	s1,8(sp)
    3c66:	6105                	add	sp,sp,32
  close(fd);
    3c68:	00002317          	auipc	t1,0x2
    3c6c:	dda30067          	jr	-550(t1) # 5a42 <close>
    printf("%s: create dirfile/xx succeeded!\n", s);
    3c70:	00004517          	auipc	a0,0x4
    3c74:	bf850513          	add	a0,a0,-1032 # 7868 <malloc+0x1a24>
    3c78:	85ca                	mv	a1,s2
    3c7a:	00002097          	auipc	ra,0x2
    3c7e:	0fa080e7          	jalr	250(ra) # 5d74 <printf>
    exit(1);
    3c82:	4505                	li	a0,1
    3c84:	00002097          	auipc	ra,0x2
    3c88:	d96080e7          	jalr	-618(ra) # 5a1a <exit>
    printf("%s: chdir dirfile succeeded!\n", s);
    3c8c:	00004517          	auipc	a0,0x4
    3c90:	bac50513          	add	a0,a0,-1108 # 7838 <malloc+0x19f4>
    3c94:	85ca                	mv	a1,s2
    3c96:	00002097          	auipc	ra,0x2
    3c9a:	0de080e7          	jalr	222(ra) # 5d74 <printf>
    exit(1);
    3c9e:	4505                	li	a0,1
    3ca0:	00002097          	auipc	ra,0x2
    3ca4:	d7a080e7          	jalr	-646(ra) # 5a1a <exit>
    printf("%s: create dirfile failed\n", s);
    3ca8:	00004517          	auipc	a0,0x4
    3cac:	b7050513          	add	a0,a0,-1168 # 7818 <malloc+0x19d4>
    3cb0:	85ca                	mv	a1,s2
    3cb2:	00002097          	auipc	ra,0x2
    3cb6:	0c2080e7          	jalr	194(ra) # 5d74 <printf>
    exit(1);
    3cba:	4505                	li	a0,1
    3cbc:	00002097          	auipc	ra,0x2
    3cc0:	d5e080e7          	jalr	-674(ra) # 5a1a <exit>
    printf("%s: write . succeeded!\n", s);
    3cc4:	00004517          	auipc	a0,0x4
    3cc8:	c8c50513          	add	a0,a0,-884 # 7950 <malloc+0x1b0c>
    3ccc:	85ca                	mv	a1,s2
    3cce:	00002097          	auipc	ra,0x2
    3cd2:	0a6080e7          	jalr	166(ra) # 5d74 <printf>
    exit(1);
    3cd6:	4505                	li	a0,1
    3cd8:	00002097          	auipc	ra,0x2
    3cdc:	d42080e7          	jalr	-702(ra) # 5a1a <exit>
    printf("%s: open . for writing succeeded!\n", s);
    3ce0:	00004517          	auipc	a0,0x4
    3ce4:	c4850513          	add	a0,a0,-952 # 7928 <malloc+0x1ae4>
    3ce8:	85ca                	mv	a1,s2
    3cea:	00002097          	auipc	ra,0x2
    3cee:	08a080e7          	jalr	138(ra) # 5d74 <printf>
    exit(1);
    3cf2:	4505                	li	a0,1
    3cf4:	00002097          	auipc	ra,0x2
    3cf8:	d26080e7          	jalr	-730(ra) # 5a1a <exit>
    printf("%s: unlink dirfile failed!\n", s);
    3cfc:	00004517          	auipc	a0,0x4
    3d00:	c0c50513          	add	a0,a0,-1012 # 7908 <malloc+0x1ac4>
    3d04:	85ca                	mv	a1,s2
    3d06:	00002097          	auipc	ra,0x2
    3d0a:	06e080e7          	jalr	110(ra) # 5d74 <printf>
    exit(1);
    3d0e:	4505                	li	a0,1
    3d10:	00002097          	auipc	ra,0x2
    3d14:	d0a080e7          	jalr	-758(ra) # 5a1a <exit>
    printf("%s: link to dirfile/xx succeeded!\n", s);
    3d18:	00004517          	auipc	a0,0x4
    3d1c:	bc850513          	add	a0,a0,-1080 # 78e0 <malloc+0x1a9c>
    3d20:	85ca                	mv	a1,s2
    3d22:	00002097          	auipc	ra,0x2
    3d26:	052080e7          	jalr	82(ra) # 5d74 <printf>
    exit(1);
    3d2a:	4505                	li	a0,1
    3d2c:	00002097          	auipc	ra,0x2
    3d30:	cee080e7          	jalr	-786(ra) # 5a1a <exit>
    printf("%s: unlink dirfile/xx succeeded!\n", s);
    3d34:	00004517          	auipc	a0,0x4
    3d38:	b8450513          	add	a0,a0,-1148 # 78b8 <malloc+0x1a74>
    3d3c:	85ca                	mv	a1,s2
    3d3e:	00002097          	auipc	ra,0x2
    3d42:	036080e7          	jalr	54(ra) # 5d74 <printf>
    exit(1);
    3d46:	4505                	li	a0,1
    3d48:	00002097          	auipc	ra,0x2
    3d4c:	cd2080e7          	jalr	-814(ra) # 5a1a <exit>
    printf("%s: mkdir dirfile/xx succeeded!\n", s);
    3d50:	00004517          	auipc	a0,0x4
    3d54:	b4050513          	add	a0,a0,-1216 # 7890 <malloc+0x1a4c>
    3d58:	85ca                	mv	a1,s2
    3d5a:	00002097          	auipc	ra,0x2
    3d5e:	01a080e7          	jalr	26(ra) # 5d74 <printf>
    exit(1);
    3d62:	4505                	li	a0,1
    3d64:	00002097          	auipc	ra,0x2
    3d68:	cb6080e7          	jalr	-842(ra) # 5a1a <exit>

0000000000003d6c <iref>:
{
    3d6c:	7139                	add	sp,sp,-64
    3d6e:	f822                	sd	s0,48(sp)
    3d70:	f426                	sd	s1,40(sp)
    3d72:	f04a                	sd	s2,32(sp)
    3d74:	ec4e                	sd	s3,24(sp)
    3d76:	e852                	sd	s4,16(sp)
    3d78:	e456                	sd	s5,8(sp)
    3d7a:	e05a                	sd	s6,0(sp)
    3d7c:	fc06                	sd	ra,56(sp)
    3d7e:	0080                	add	s0,sp,64
    3d80:	8b2a                	mv	s6,a0
    3d82:	03300913          	li	s2,51
    if(mkdir("irefd") != 0){
    3d86:	00004a17          	auipc	s4,0x4
    3d8a:	be2a0a13          	add	s4,s4,-1054 # 7968 <malloc+0x1b24>
    mkdir("");
    3d8e:	00003497          	auipc	s1,0x3
    3d92:	6e248493          	add	s1,s1,1762 # 7470 <malloc+0x162c>
    link("README", "");
    3d96:	00002a97          	auipc	s5,0x2
    3d9a:	35aa8a93          	add	s5,s5,858 # 60f0 <malloc+0x2ac>
    fd = open("xx", O_CREATE);
    3d9e:	00004997          	auipc	s3,0x4
    3da2:	ac298993          	add	s3,s3,-1342 # 7860 <malloc+0x1a1c>
    if(mkdir("irefd") != 0){
    3da6:	8552                	mv	a0,s4
    3da8:	00002097          	auipc	ra,0x2
    3dac:	cda080e7          	jalr	-806(ra) # 5a82 <mkdir>
    3db0:	e95d                	bnez	a0,3e66 <iref+0xfa>
    if(chdir("irefd") != 0){
    3db2:	8552                	mv	a0,s4
    3db4:	00002097          	auipc	ra,0x2
    3db8:	cd6080e7          	jalr	-810(ra) # 5a8a <chdir>
    3dbc:	e179                	bnez	a0,3e82 <iref+0x116>
    mkdir("");
    3dbe:	8526                	mv	a0,s1
    3dc0:	00002097          	auipc	ra,0x2
    3dc4:	cc2080e7          	jalr	-830(ra) # 5a82 <mkdir>
    link("README", "");
    3dc8:	85a6                	mv	a1,s1
    3dca:	8556                	mv	a0,s5
    3dcc:	00002097          	auipc	ra,0x2
    3dd0:	cae080e7          	jalr	-850(ra) # 5a7a <link>
    fd = open("", O_CREATE);
    3dd4:	20000593          	li	a1,512
    3dd8:	8526                	mv	a0,s1
    3dda:	00002097          	auipc	ra,0x2
    3dde:	c80080e7          	jalr	-896(ra) # 5a5a <open>
    if(fd >= 0)
    3de2:	00054663          	bltz	a0,3dee <iref+0x82>
      close(fd);
    3de6:	00002097          	auipc	ra,0x2
    3dea:	c5c080e7          	jalr	-932(ra) # 5a42 <close>
    fd = open("xx", O_CREATE);
    3dee:	20000593          	li	a1,512
    3df2:	854e                	mv	a0,s3
    3df4:	00002097          	auipc	ra,0x2
    3df8:	c66080e7          	jalr	-922(ra) # 5a5a <open>
    if(fd >= 0)
    3dfc:	00054663          	bltz	a0,3e08 <iref+0x9c>
      close(fd);
    3e00:	00002097          	auipc	ra,0x2
    3e04:	c42080e7          	jalr	-958(ra) # 5a42 <close>
    unlink("xx");
    3e08:	854e                	mv	a0,s3
  for(i = 0; i < NINODE + 1; i++){
    3e0a:	397d                	addw	s2,s2,-1
    unlink("xx");
    3e0c:	00002097          	auipc	ra,0x2
    3e10:	c5e080e7          	jalr	-930(ra) # 5a6a <unlink>
  for(i = 0; i < NINODE + 1; i++){
    3e14:	f80919e3          	bnez	s2,3da6 <iref+0x3a>
    3e18:	03300493          	li	s1,51
    chdir("..");
    3e1c:	00003997          	auipc	s3,0x3
    3e20:	37498993          	add	s3,s3,884 # 7190 <malloc+0x134c>
    unlink("irefd");
    3e24:	00004917          	auipc	s2,0x4
    3e28:	b4490913          	add	s2,s2,-1212 # 7968 <malloc+0x1b24>
    chdir("..");
    3e2c:	854e                	mv	a0,s3
    3e2e:	00002097          	auipc	ra,0x2
    3e32:	c5c080e7          	jalr	-932(ra) # 5a8a <chdir>
    unlink("irefd");
    3e36:	854a                	mv	a0,s2
  for(i = 0; i < NINODE + 1; i++){
    3e38:	34fd                	addw	s1,s1,-1
    unlink("irefd");
    3e3a:	00002097          	auipc	ra,0x2
    3e3e:	c30080e7          	jalr	-976(ra) # 5a6a <unlink>
  for(i = 0; i < NINODE + 1; i++){
    3e42:	f4ed                	bnez	s1,3e2c <iref+0xc0>
}
    3e44:	7442                	ld	s0,48(sp)
    3e46:	70e2                	ld	ra,56(sp)
    3e48:	74a2                	ld	s1,40(sp)
    3e4a:	7902                	ld	s2,32(sp)
    3e4c:	69e2                	ld	s3,24(sp)
    3e4e:	6a42                	ld	s4,16(sp)
    3e50:	6aa2                	ld	s5,8(sp)
    3e52:	6b02                	ld	s6,0(sp)
  chdir("/");
    3e54:	00003517          	auipc	a0,0x3
    3e58:	2e450513          	add	a0,a0,740 # 7138 <malloc+0x12f4>
}
    3e5c:	6121                	add	sp,sp,64
  chdir("/");
    3e5e:	00002317          	auipc	t1,0x2
    3e62:	c2c30067          	jr	-980(t1) # 5a8a <chdir>
      printf("%s: mkdir irefd failed\n", s);
    3e66:	00004517          	auipc	a0,0x4
    3e6a:	b0a50513          	add	a0,a0,-1270 # 7970 <malloc+0x1b2c>
    3e6e:	85da                	mv	a1,s6
    3e70:	00002097          	auipc	ra,0x2
    3e74:	f04080e7          	jalr	-252(ra) # 5d74 <printf>
      exit(1);
    3e78:	4505                	li	a0,1
    3e7a:	00002097          	auipc	ra,0x2
    3e7e:	ba0080e7          	jalr	-1120(ra) # 5a1a <exit>
      printf("%s: chdir irefd failed\n", s);
    3e82:	00004517          	auipc	a0,0x4
    3e86:	b0650513          	add	a0,a0,-1274 # 7988 <malloc+0x1b44>
    3e8a:	85da                	mv	a1,s6
    3e8c:	00002097          	auipc	ra,0x2
    3e90:	ee8080e7          	jalr	-280(ra) # 5d74 <printf>
      exit(1);
    3e94:	4505                	li	a0,1
    3e96:	00002097          	auipc	ra,0x2
    3e9a:	b84080e7          	jalr	-1148(ra) # 5a1a <exit>

0000000000003e9e <openiputtest>:
{
    3e9e:	7179                	add	sp,sp,-48
    3ea0:	f022                	sd	s0,32(sp)
    3ea2:	ec26                	sd	s1,24(sp)
    3ea4:	f406                	sd	ra,40(sp)
    3ea6:	1800                	add	s0,sp,48
    3ea8:	84aa                	mv	s1,a0
  if(mkdir("oidir") < 0){
    3eaa:	00004517          	auipc	a0,0x4
    3eae:	af650513          	add	a0,a0,-1290 # 79a0 <malloc+0x1b5c>
    3eb2:	00002097          	auipc	ra,0x2
    3eb6:	bd0080e7          	jalr	-1072(ra) # 5a82 <mkdir>
    3eba:	04054263          	bltz	a0,3efe <openiputtest+0x60>
  pid = fork();
    3ebe:	00002097          	auipc	ra,0x2
    3ec2:	b54080e7          	jalr	-1196(ra) # 5a12 <fork>
  if(pid < 0){
    3ec6:	08054663          	bltz	a0,3f52 <openiputtest+0xb4>
  if(pid == 0){
    3eca:	e921                	bnez	a0,3f1a <openiputtest+0x7c>
    int fd = open("oidir", O_RDWR);
    3ecc:	4589                	li	a1,2
    3ece:	00004517          	auipc	a0,0x4
    3ed2:	ad250513          	add	a0,a0,-1326 # 79a0 <malloc+0x1b5c>
    3ed6:	00002097          	auipc	ra,0x2
    3eda:	b84080e7          	jalr	-1148(ra) # 5a5a <open>
    if(fd >= 0){
    3ede:	0a054463          	bltz	a0,3f86 <openiputtest+0xe8>
      printf("%s: open directory for write succeeded\n", s);
    3ee2:	00004517          	auipc	a0,0x4
    3ee6:	ade50513          	add	a0,a0,-1314 # 79c0 <malloc+0x1b7c>
    3eea:	85a6                	mv	a1,s1
    3eec:	00002097          	auipc	ra,0x2
    3ef0:	e88080e7          	jalr	-376(ra) # 5d74 <printf>
      exit(1);
    3ef4:	4505                	li	a0,1
    3ef6:	00002097          	auipc	ra,0x2
    3efa:	b24080e7          	jalr	-1244(ra) # 5a1a <exit>
    printf("%s: mkdir oidir failed\n", s);
    3efe:	00004517          	auipc	a0,0x4
    3f02:	aaa50513          	add	a0,a0,-1366 # 79a8 <malloc+0x1b64>
    3f06:	85a6                	mv	a1,s1
    3f08:	00002097          	auipc	ra,0x2
    3f0c:	e6c080e7          	jalr	-404(ra) # 5d74 <printf>
    exit(1);
    3f10:	4505                	li	a0,1
    3f12:	00002097          	auipc	ra,0x2
    3f16:	b08080e7          	jalr	-1272(ra) # 5a1a <exit>
  sleep(1);
    3f1a:	4505                	li	a0,1
    3f1c:	00002097          	auipc	ra,0x2
    3f20:	b8e080e7          	jalr	-1138(ra) # 5aaa <sleep>
  if(unlink("oidir") != 0){
    3f24:	00004517          	auipc	a0,0x4
    3f28:	a7c50513          	add	a0,a0,-1412 # 79a0 <malloc+0x1b5c>
    3f2c:	00002097          	auipc	ra,0x2
    3f30:	b3e080e7          	jalr	-1218(ra) # 5a6a <unlink>
    3f34:	cd0d                	beqz	a0,3f6e <openiputtest+0xd0>
    printf("%s: unlink failed\n", s);
    3f36:	00003517          	auipc	a0,0x3
    3f3a:	9ca50513          	add	a0,a0,-1590 # 6900 <malloc+0xabc>
    3f3e:	85a6                	mv	a1,s1
    3f40:	00002097          	auipc	ra,0x2
    3f44:	e34080e7          	jalr	-460(ra) # 5d74 <printf>
    exit(1);
    3f48:	4505                	li	a0,1
    3f4a:	00002097          	auipc	ra,0x2
    3f4e:	ad0080e7          	jalr	-1328(ra) # 5a1a <exit>
    printf("%s: fork failed\n", s);
    3f52:	00002517          	auipc	a0,0x2
    3f56:	7be50513          	add	a0,a0,1982 # 6710 <malloc+0x8cc>
    3f5a:	85a6                	mv	a1,s1
    3f5c:	00002097          	auipc	ra,0x2
    3f60:	e18080e7          	jalr	-488(ra) # 5d74 <printf>
    exit(1);
    3f64:	4505                	li	a0,1
    3f66:	00002097          	auipc	ra,0x2
    3f6a:	ab4080e7          	jalr	-1356(ra) # 5a1a <exit>
  wait(&xstatus);
    3f6e:	fdc40513          	add	a0,s0,-36
    3f72:	00002097          	auipc	ra,0x2
    3f76:	ab0080e7          	jalr	-1360(ra) # 5a22 <wait>
  exit(xstatus);
    3f7a:	fdc42503          	lw	a0,-36(s0)
    3f7e:	00002097          	auipc	ra,0x2
    3f82:	a9c080e7          	jalr	-1380(ra) # 5a1a <exit>
    exit(0);
    3f86:	4501                	li	a0,0
    3f88:	00002097          	auipc	ra,0x2
    3f8c:	a92080e7          	jalr	-1390(ra) # 5a1a <exit>

0000000000003f90 <forkforkfork>:
{
    3f90:	1101                	add	sp,sp,-32
    3f92:	ec06                	sd	ra,24(sp)
    3f94:	e822                	sd	s0,16(sp)
    3f96:	e426                	sd	s1,8(sp)
    3f98:	1000                	add	s0,sp,32
    3f9a:	84aa                	mv	s1,a0
  unlink("stopforking");
    3f9c:	00004517          	auipc	a0,0x4
    3fa0:	a4c50513          	add	a0,a0,-1460 # 79e8 <malloc+0x1ba4>
    3fa4:	00002097          	auipc	ra,0x2
    3fa8:	ac6080e7          	jalr	-1338(ra) # 5a6a <unlink>
  int pid = fork();
    3fac:	00002097          	auipc	ra,0x2
    3fb0:	a66080e7          	jalr	-1434(ra) # 5a12 <fork>
  if(pid < 0){
    3fb4:	04054463          	bltz	a0,3ffc <forkforkfork+0x6c>
  if(pid == 0){
    3fb8:	c125                	beqz	a0,4018 <forkforkfork+0x88>
  sleep(20); // two seconds
    3fba:	4551                	li	a0,20
    3fbc:	00002097          	auipc	ra,0x2
    3fc0:	aee080e7          	jalr	-1298(ra) # 5aaa <sleep>
  close(open("stopforking", O_CREATE|O_RDWR));
    3fc4:	20200593          	li	a1,514
    3fc8:	00004517          	auipc	a0,0x4
    3fcc:	a2050513          	add	a0,a0,-1504 # 79e8 <malloc+0x1ba4>
    3fd0:	00002097          	auipc	ra,0x2
    3fd4:	a8a080e7          	jalr	-1398(ra) # 5a5a <open>
    3fd8:	00002097          	auipc	ra,0x2
    3fdc:	a6a080e7          	jalr	-1430(ra) # 5a42 <close>
  wait(0);
    3fe0:	4501                	li	a0,0
    3fe2:	00002097          	auipc	ra,0x2
    3fe6:	a40080e7          	jalr	-1472(ra) # 5a22 <wait>
}
    3fea:	6442                	ld	s0,16(sp)
    3fec:	60e2                	ld	ra,24(sp)
    3fee:	64a2                	ld	s1,8(sp)
  sleep(10); // one second
    3ff0:	4529                	li	a0,10
}
    3ff2:	6105                	add	sp,sp,32
  sleep(10); // one second
    3ff4:	00002317          	auipc	t1,0x2
    3ff8:	ab630067          	jr	-1354(t1) # 5aaa <sleep>
    printf("%s: fork failed", s);
    3ffc:	00003517          	auipc	a0,0x3
    4000:	8d450513          	add	a0,a0,-1836 # 68d0 <malloc+0xa8c>
    4004:	85a6                	mv	a1,s1
    4006:	00002097          	auipc	ra,0x2
    400a:	d6e080e7          	jalr	-658(ra) # 5d74 <printf>
    exit(1);
    400e:	4505                	li	a0,1
    4010:	00002097          	auipc	ra,0x2
    4014:	a0a080e7          	jalr	-1526(ra) # 5a1a <exit>
      int fd = open("stopforking", 0);
    4018:	00004497          	auipc	s1,0x4
    401c:	9d048493          	add	s1,s1,-1584 # 79e8 <malloc+0x1ba4>
    4020:	a039                	j	402e <forkforkfork+0x9e>
      if(fork() < 0){
    4022:	00002097          	auipc	ra,0x2
    4026:	9f0080e7          	jalr	-1552(ra) # 5a12 <fork>
    402a:	00054f63          	bltz	a0,4048 <forkforkfork+0xb8>
      int fd = open("stopforking", 0);
    402e:	4581                	li	a1,0
    4030:	8526                	mv	a0,s1
    4032:	00002097          	auipc	ra,0x2
    4036:	a28080e7          	jalr	-1496(ra) # 5a5a <open>
      if(fd >= 0){
    403a:	fe0544e3          	bltz	a0,4022 <forkforkfork+0x92>
        exit(0);
    403e:	4501                	li	a0,0
    4040:	00002097          	auipc	ra,0x2
    4044:	9da080e7          	jalr	-1574(ra) # 5a1a <exit>
        close(open("stopforking", O_CREATE|O_RDWR));
    4048:	20200593          	li	a1,514
    404c:	00004517          	auipc	a0,0x4
    4050:	99c50513          	add	a0,a0,-1636 # 79e8 <malloc+0x1ba4>
    4054:	00002097          	auipc	ra,0x2
    4058:	a06080e7          	jalr	-1530(ra) # 5a5a <open>
    405c:	00002097          	auipc	ra,0x2
    4060:	9e6080e7          	jalr	-1562(ra) # 5a42 <close>
    4064:	b7e9                	j	402e <forkforkfork+0x9e>

0000000000004066 <killstatus>:
{
    4066:	7139                	add	sp,sp,-64
    4068:	f822                	sd	s0,48(sp)
    406a:	f04a                	sd	s2,32(sp)
    406c:	ec4e                	sd	s3,24(sp)
    406e:	e852                	sd	s4,16(sp)
    4070:	fc06                	sd	ra,56(sp)
    4072:	f426                	sd	s1,40(sp)
    4074:	0080                	add	s0,sp,64
    4076:	8a2a                	mv	s4,a0
    4078:	06400913          	li	s2,100
    if(xst != -1) {
    407c:	59fd                	li	s3,-1
    407e:	a80d                	j	40b0 <killstatus+0x4a>
    if(pid1 == 0){
    4080:	cd29                	beqz	a0,40da <killstatus+0x74>
    sleep(1);
    4082:	4505                	li	a0,1
    4084:	00002097          	auipc	ra,0x2
    4088:	a26080e7          	jalr	-1498(ra) # 5aaa <sleep>
    kill(pid1);
    408c:	8526                	mv	a0,s1
    408e:	00002097          	auipc	ra,0x2
    4092:	9bc080e7          	jalr	-1604(ra) # 5a4a <kill>
    wait(&xst);
    4096:	fcc40513          	add	a0,s0,-52
    409a:	00002097          	auipc	ra,0x2
    409e:	988080e7          	jalr	-1656(ra) # 5a22 <wait>
    if(xst != -1) {
    40a2:	fcc42783          	lw	a5,-52(s0)
    40a6:	05379363          	bne	a5,s3,40ec <killstatus+0x86>
  for(int i = 0; i < 100; i++){
    40aa:	397d                	addw	s2,s2,-1
    40ac:	04090e63          	beqz	s2,4108 <killstatus+0xa2>
    int pid1 = fork();
    40b0:	00002097          	auipc	ra,0x2
    40b4:	962080e7          	jalr	-1694(ra) # 5a12 <fork>
    40b8:	84aa                	mv	s1,a0
    if(pid1 < 0){
    40ba:	fc0553e3          	bgez	a0,4080 <killstatus+0x1a>
      printf("%s: fork failed\n", s);
    40be:	00002517          	auipc	a0,0x2
    40c2:	65250513          	add	a0,a0,1618 # 6710 <malloc+0x8cc>
    40c6:	85d2                	mv	a1,s4
    40c8:	00002097          	auipc	ra,0x2
    40cc:	cac080e7          	jalr	-852(ra) # 5d74 <printf>
      exit(1);
    40d0:	4505                	li	a0,1
    40d2:	00002097          	auipc	ra,0x2
    40d6:	948080e7          	jalr	-1720(ra) # 5a1a <exit>
        getpid();
    40da:	00002097          	auipc	ra,0x2
    40de:	9c0080e7          	jalr	-1600(ra) # 5a9a <getpid>
    40e2:	00002097          	auipc	ra,0x2
    40e6:	9b8080e7          	jalr	-1608(ra) # 5a9a <getpid>
      while(1) {
    40ea:	bfc5                	j	40da <killstatus+0x74>
       printf("%s: status should be -1\n", s);
    40ec:	00004517          	auipc	a0,0x4
    40f0:	90c50513          	add	a0,a0,-1780 # 79f8 <malloc+0x1bb4>
    40f4:	85d2                	mv	a1,s4
    40f6:	00002097          	auipc	ra,0x2
    40fa:	c7e080e7          	jalr	-898(ra) # 5d74 <printf>
       exit(1);
    40fe:	4505                	li	a0,1
    4100:	00002097          	auipc	ra,0x2
    4104:	91a080e7          	jalr	-1766(ra) # 5a1a <exit>
  exit(0);
    4108:	4501                	li	a0,0
    410a:	00002097          	auipc	ra,0x2
    410e:	910080e7          	jalr	-1776(ra) # 5a1a <exit>

0000000000004112 <preempt>:
{
    4112:	7139                	add	sp,sp,-64
    4114:	f822                	sd	s0,48(sp)
    4116:	f04a                	sd	s2,32(sp)
    4118:	fc06                	sd	ra,56(sp)
    411a:	f426                	sd	s1,40(sp)
    411c:	ec4e                	sd	s3,24(sp)
    411e:	e852                	sd	s4,16(sp)
    4120:	0080                	add	s0,sp,64
    4122:	892a                	mv	s2,a0
  pid1 = fork();
    4124:	00002097          	auipc	ra,0x2
    4128:	8ee080e7          	jalr	-1810(ra) # 5a12 <fork>
  if(pid1 < 0) {
    412c:	12054b63          	bltz	a0,4262 <preempt+0x150>
    4130:	84aa                	mv	s1,a0
  if(pid1 == 0)
    4132:	e111                	bnez	a0,4136 <preempt+0x24>
    for(;;)
    4134:	a001                	j	4134 <preempt+0x22>
  pid2 = fork();
    4136:	00002097          	auipc	ra,0x2
    413a:	8dc080e7          	jalr	-1828(ra) # 5a12 <fork>
    413e:	89aa                	mv	s3,a0
  if(pid2 < 0) {
    4140:	12054f63          	bltz	a0,427e <preempt+0x16c>
  if(pid2 == 0)
    4144:	e111                	bnez	a0,4148 <preempt+0x36>
    for(;;)
    4146:	a001                	j	4146 <preempt+0x34>
  pipe(pfds);
    4148:	fc840513          	add	a0,s0,-56
    414c:	00002097          	auipc	ra,0x2
    4150:	8de080e7          	jalr	-1826(ra) # 5a2a <pipe>
  pid3 = fork();
    4154:	00002097          	auipc	ra,0x2
    4158:	8be080e7          	jalr	-1858(ra) # 5a12 <fork>
    415c:	8a2a                	mv	s4,a0
  if(pid3 < 0) {
    415e:	12054063          	bltz	a0,427e <preempt+0x16c>
  if(pid3 == 0){
    4162:	ed05                	bnez	a0,419a <preempt+0x88>
    close(pfds[0]);
    4164:	fc842503          	lw	a0,-56(s0)
    4168:	00002097          	auipc	ra,0x2
    416c:	8da080e7          	jalr	-1830(ra) # 5a42 <close>
    if(write(pfds[1], "x", 1) != 1)
    4170:	fcc42503          	lw	a0,-52(s0)
    4174:	4605                	li	a2,1
    4176:	00002597          	auipc	a1,0x2
    417a:	e1258593          	add	a1,a1,-494 # 5f88 <malloc+0x144>
    417e:	00002097          	auipc	ra,0x2
    4182:	8bc080e7          	jalr	-1860(ra) # 5a3a <write>
    4186:	4785                	li	a5,1
    4188:	0cf51363          	bne	a0,a5,424e <preempt+0x13c>
    close(pfds[1]);
    418c:	fcc42503          	lw	a0,-52(s0)
    4190:	00002097          	auipc	ra,0x2
    4194:	8b2080e7          	jalr	-1870(ra) # 5a42 <close>
    for(;;)
    4198:	a001                	j	4198 <preempt+0x86>
  close(pfds[1]);
    419a:	fcc42503          	lw	a0,-52(s0)
    419e:	00002097          	auipc	ra,0x2
    41a2:	8a4080e7          	jalr	-1884(ra) # 5a42 <close>
  if(read(pfds[0], buf, sizeof(buf)) != 1){
    41a6:	fc842503          	lw	a0,-56(s0)
    41aa:	660d                	lui	a2,0x3
    41ac:	00009597          	auipc	a1,0x9
    41b0:	acc58593          	add	a1,a1,-1332 # cc78 <buf>
    41b4:	00002097          	auipc	ra,0x2
    41b8:	87e080e7          	jalr	-1922(ra) # 5a32 <read>
    41bc:	4785                	li	a5,1
    41be:	06f51e63          	bne	a0,a5,423a <preempt+0x128>
  close(pfds[0]);
    41c2:	fc842503          	lw	a0,-56(s0)
    41c6:	00002097          	auipc	ra,0x2
    41ca:	87c080e7          	jalr	-1924(ra) # 5a42 <close>
  printf("kill... ");
    41ce:	00004517          	auipc	a0,0x4
    41d2:	87a50513          	add	a0,a0,-1926 # 7a48 <malloc+0x1c04>
    41d6:	00002097          	auipc	ra,0x2
    41da:	b9e080e7          	jalr	-1122(ra) # 5d74 <printf>
  kill(pid1);
    41de:	8526                	mv	a0,s1
    41e0:	00002097          	auipc	ra,0x2
    41e4:	86a080e7          	jalr	-1942(ra) # 5a4a <kill>
  kill(pid2);
    41e8:	854e                	mv	a0,s3
    41ea:	00002097          	auipc	ra,0x2
    41ee:	860080e7          	jalr	-1952(ra) # 5a4a <kill>
  kill(pid3);
    41f2:	8552                	mv	a0,s4
    41f4:	00002097          	auipc	ra,0x2
    41f8:	856080e7          	jalr	-1962(ra) # 5a4a <kill>
  printf("wait... ");
    41fc:	00004517          	auipc	a0,0x4
    4200:	85c50513          	add	a0,a0,-1956 # 7a58 <malloc+0x1c14>
    4204:	00002097          	auipc	ra,0x2
    4208:	b70080e7          	jalr	-1168(ra) # 5d74 <printf>
  wait(0);
    420c:	4501                	li	a0,0
    420e:	00002097          	auipc	ra,0x2
    4212:	814080e7          	jalr	-2028(ra) # 5a22 <wait>
  wait(0);
    4216:	4501                	li	a0,0
    4218:	00002097          	auipc	ra,0x2
    421c:	80a080e7          	jalr	-2038(ra) # 5a22 <wait>
  wait(0);
    4220:	4501                	li	a0,0
    4222:	00002097          	auipc	ra,0x2
    4226:	800080e7          	jalr	-2048(ra) # 5a22 <wait>
}
    422a:	70e2                	ld	ra,56(sp)
    422c:	7442                	ld	s0,48(sp)
    422e:	74a2                	ld	s1,40(sp)
    4230:	7902                	ld	s2,32(sp)
    4232:	69e2                	ld	s3,24(sp)
    4234:	6a42                	ld	s4,16(sp)
    4236:	6121                	add	sp,sp,64
    4238:	8082                	ret
    printf("%s: preempt read error", s);
    423a:	85ca                	mv	a1,s2
    423c:	00003517          	auipc	a0,0x3
    4240:	7f450513          	add	a0,a0,2036 # 7a30 <malloc+0x1bec>
    4244:	00002097          	auipc	ra,0x2
    4248:	b30080e7          	jalr	-1232(ra) # 5d74 <printf>
    return;
    424c:	bff9                	j	422a <preempt+0x118>
      printf("%s: preempt write error", s);
    424e:	85ca                	mv	a1,s2
    4250:	00003517          	auipc	a0,0x3
    4254:	7c850513          	add	a0,a0,1992 # 7a18 <malloc+0x1bd4>
    4258:	00002097          	auipc	ra,0x2
    425c:	b1c080e7          	jalr	-1252(ra) # 5d74 <printf>
    4260:	b735                	j	418c <preempt+0x7a>
    printf("%s: fork failed", s);
    4262:	00002517          	auipc	a0,0x2
    4266:	66e50513          	add	a0,a0,1646 # 68d0 <malloc+0xa8c>
    426a:	85ca                	mv	a1,s2
    426c:	00002097          	auipc	ra,0x2
    4270:	b08080e7          	jalr	-1272(ra) # 5d74 <printf>
    exit(1);
    4274:	4505                	li	a0,1
    4276:	00001097          	auipc	ra,0x1
    427a:	7a4080e7          	jalr	1956(ra) # 5a1a <exit>
    printf("%s: fork failed\n", s);
    427e:	00002517          	auipc	a0,0x2
    4282:	49250513          	add	a0,a0,1170 # 6710 <malloc+0x8cc>
    4286:	85ca                	mv	a1,s2
    4288:	00002097          	auipc	ra,0x2
    428c:	aec080e7          	jalr	-1300(ra) # 5d74 <printf>
    exit(1);
    4290:	4505                	li	a0,1
    4292:	00001097          	auipc	ra,0x1
    4296:	788080e7          	jalr	1928(ra) # 5a1a <exit>

000000000000429a <reparent>:
{
    429a:	7179                	add	sp,sp,-48
    429c:	f022                	sd	s0,32(sp)
    429e:	e84a                	sd	s2,16(sp)
    42a0:	e44e                	sd	s3,8(sp)
    42a2:	e052                	sd	s4,0(sp)
    42a4:	f406                	sd	ra,40(sp)
    42a6:	ec26                	sd	s1,24(sp)
    42a8:	1800                	add	s0,sp,48
    42aa:	89aa                	mv	s3,a0
  int master_pid = getpid();
    42ac:	00001097          	auipc	ra,0x1
    42b0:	7ee080e7          	jalr	2030(ra) # 5a9a <getpid>
    42b4:	8a2a                	mv	s4,a0
    42b6:	0c800913          	li	s2,200
    42ba:	a821                	j	42d2 <reparent+0x38>
    if(pid){
    42bc:	c121                	beqz	a0,42fc <reparent+0x62>
      if(wait(0) != pid){
    42be:	4501                	li	a0,0
    42c0:	00001097          	auipc	ra,0x1
    42c4:	762080e7          	jalr	1890(ra) # 5a22 <wait>
    42c8:	04951563          	bne	a0,s1,4312 <reparent+0x78>
  for(int i = 0; i < 200; i++){
    42cc:	397d                	addw	s2,s2,-1
    42ce:	02090d63          	beqz	s2,4308 <reparent+0x6e>
    int pid = fork();
    42d2:	00001097          	auipc	ra,0x1
    42d6:	740080e7          	jalr	1856(ra) # 5a12 <fork>
    42da:	84aa                	mv	s1,a0
    if(pid < 0){
    42dc:	fe0550e3          	bgez	a0,42bc <reparent+0x22>
      printf("%s: fork failed\n", s);
    42e0:	00002517          	auipc	a0,0x2
    42e4:	43050513          	add	a0,a0,1072 # 6710 <malloc+0x8cc>
    42e8:	85ce                	mv	a1,s3
    42ea:	00002097          	auipc	ra,0x2
    42ee:	a8a080e7          	jalr	-1398(ra) # 5d74 <printf>
      exit(1);
    42f2:	4505                	li	a0,1
    42f4:	00001097          	auipc	ra,0x1
    42f8:	726080e7          	jalr	1830(ra) # 5a1a <exit>
      int pid2 = fork();
    42fc:	00001097          	auipc	ra,0x1
    4300:	716080e7          	jalr	1814(ra) # 5a12 <fork>
      if(pid2 < 0){
    4304:	02054563          	bltz	a0,432e <reparent+0x94>
      exit(0);
    4308:	4501                	li	a0,0
    430a:	00001097          	auipc	ra,0x1
    430e:	710080e7          	jalr	1808(ra) # 5a1a <exit>
        printf("%s: wait wrong pid\n", s);
    4312:	00002517          	auipc	a0,0x2
    4316:	58650513          	add	a0,a0,1414 # 6898 <malloc+0xa54>
    431a:	85ce                	mv	a1,s3
    431c:	00002097          	auipc	ra,0x2
    4320:	a58080e7          	jalr	-1448(ra) # 5d74 <printf>
        exit(1);
    4324:	4505                	li	a0,1
    4326:	00001097          	auipc	ra,0x1
    432a:	6f4080e7          	jalr	1780(ra) # 5a1a <exit>
        kill(master_pid);
    432e:	8552                	mv	a0,s4
    4330:	00001097          	auipc	ra,0x1
    4334:	71a080e7          	jalr	1818(ra) # 5a4a <kill>
        exit(1);
    4338:	4505                	li	a0,1
    433a:	00001097          	auipc	ra,0x1
    433e:	6e0080e7          	jalr	1760(ra) # 5a1a <exit>

0000000000004342 <sbrkfail>:
{
    4342:	7119                	add	sp,sp,-128
    4344:	f8a2                	sd	s0,112(sp)
    4346:	e4d6                	sd	s5,72(sp)
    4348:	0100                	add	s0,sp,128
    434a:	fc86                	sd	ra,120(sp)
    434c:	f4a6                	sd	s1,104(sp)
    434e:	f0ca                	sd	s2,96(sp)
    4350:	ecce                	sd	s3,88(sp)
    4352:	e8d2                	sd	s4,80(sp)
    4354:	8aaa                	mv	s5,a0
  if(pipe(fds) != 0){
    4356:	f9040513          	add	a0,s0,-112
    435a:	00001097          	auipc	ra,0x1
    435e:	6d0080e7          	jalr	1744(ra) # 5a2a <pipe>
    4362:	12051c63          	bnez	a0,449a <sbrkfail+0x158>
    4366:	f9840493          	add	s1,s0,-104
    436a:	fc040993          	add	s3,s0,-64
    436e:	8926                	mv	s2,s1
    if(pids[i] != -1)
    4370:	5a7d                	li	s4,-1
    if((pids[i] = fork()) == 0){
    4372:	00001097          	auipc	ra,0x1
    4376:	6a0080e7          	jalr	1696(ra) # 5a12 <fork>
    437a:	00a92023          	sw	a0,0(s2)
    437e:	c551                	beqz	a0,440a <sbrkfail+0xc8>
    if(pids[i] != -1)
    4380:	01450b63          	beq	a0,s4,4396 <sbrkfail+0x54>
      read(fds[0], &scratch, 1);
    4384:	f9042503          	lw	a0,-112(s0)
    4388:	4605                	li	a2,1
    438a:	f8b40593          	add	a1,s0,-117
    438e:	00001097          	auipc	ra,0x1
    4392:	6a4080e7          	jalr	1700(ra) # 5a32 <read>
  for(i = 0; i < sizeof(pids)/sizeof(pids[0]); i++){
    4396:	0911                	add	s2,s2,4
    4398:	fd391de3          	bne	s2,s3,4372 <sbrkfail+0x30>
  c = sbrk(PGSIZE);
    439c:	6505                	lui	a0,0x1
    439e:	00001097          	auipc	ra,0x1
    43a2:	704080e7          	jalr	1796(ra) # 5aa2 <sbrk>
    43a6:	8a2a                	mv	s4,a0
    if(pids[i] == -1)
    43a8:	597d                	li	s2,-1
    43aa:	4088                	lw	a0,0(s1)
    43ac:	01250b63          	beq	a0,s2,43c2 <sbrkfail+0x80>
    kill(pids[i]);
    43b0:	00001097          	auipc	ra,0x1
    43b4:	69a080e7          	jalr	1690(ra) # 5a4a <kill>
    wait(0);
    43b8:	4501                	li	a0,0
    43ba:	00001097          	auipc	ra,0x1
    43be:	668080e7          	jalr	1640(ra) # 5a22 <wait>
  for(i = 0; i < sizeof(pids)/sizeof(pids[0]); i++){
    43c2:	0491                	add	s1,s1,4
    43c4:	ff3493e3          	bne	s1,s3,43aa <sbrkfail+0x68>
  if(c == (char*)0xffffffffffffffffL){
    43c8:	597d                	li	s2,-1
    43ca:	112a0463          	beq	s4,s2,44d2 <sbrkfail+0x190>
  pid = fork();
    43ce:	00001097          	auipc	ra,0x1
    43d2:	644080e7          	jalr	1604(ra) # 5a12 <fork>
    43d6:	84aa                	mv	s1,a0
  if(pid < 0){
    43d8:	0c054f63          	bltz	a0,44b6 <sbrkfail+0x174>
  if(pid == 0){
    43dc:	c935                	beqz	a0,4450 <sbrkfail+0x10e>
  wait(&xstatus);
    43de:	f8c40513          	add	a0,s0,-116
    43e2:	00001097          	auipc	ra,0x1
    43e6:	640080e7          	jalr	1600(ra) # 5a22 <wait>
  if(xstatus != -1 && xstatus != 2)
    43ea:	f8c42783          	lw	a5,-116(s0)
    43ee:	01278563          	beq	a5,s2,43f8 <sbrkfail+0xb6>
    43f2:	4709                	li	a4,2
    43f4:	04e79963          	bne	a5,a4,4446 <sbrkfail+0x104>
}
    43f8:	70e6                	ld	ra,120(sp)
    43fa:	7446                	ld	s0,112(sp)
    43fc:	74a6                	ld	s1,104(sp)
    43fe:	7906                	ld	s2,96(sp)
    4400:	69e6                	ld	s3,88(sp)
    4402:	6a46                	ld	s4,80(sp)
    4404:	6aa6                	ld	s5,72(sp)
    4406:	6109                	add	sp,sp,128
    4408:	8082                	ret
      sbrk(BIG - (uint64)sbrk(0));
    440a:	00001097          	auipc	ra,0x1
    440e:	698080e7          	jalr	1688(ra) # 5aa2 <sbrk>
    4412:	064007b7          	lui	a5,0x6400
    4416:	40a7853b          	subw	a0,a5,a0
    441a:	00001097          	auipc	ra,0x1
    441e:	688080e7          	jalr	1672(ra) # 5aa2 <sbrk>
      write(fds[1], "x", 1);
    4422:	f9442503          	lw	a0,-108(s0)
    4426:	4605                	li	a2,1
    4428:	00002597          	auipc	a1,0x2
    442c:	b6058593          	add	a1,a1,-1184 # 5f88 <malloc+0x144>
    4430:	00001097          	auipc	ra,0x1
    4434:	60a080e7          	jalr	1546(ra) # 5a3a <write>
      for(;;) sleep(1000);
    4438:	3e800513          	li	a0,1000
    443c:	00001097          	auipc	ra,0x1
    4440:	66e080e7          	jalr	1646(ra) # 5aaa <sleep>
    4444:	bfd5                	j	4438 <sbrkfail+0xf6>
    exit(1);
    4446:	4505                	li	a0,1
    4448:	00001097          	auipc	ra,0x1
    444c:	5d2080e7          	jalr	1490(ra) # 5a1a <exit>
    a = sbrk(0);
    4450:	00001097          	auipc	ra,0x1
    4454:	652080e7          	jalr	1618(ra) # 5aa2 <sbrk>
    4458:	892a                	mv	s2,a0
    sbrk(10*BIG);
    445a:	3e800537          	lui	a0,0x3e800
    445e:	00001097          	auipc	ra,0x1
    4462:	644080e7          	jalr	1604(ra) # 5aa2 <sbrk>
    for (i = 0; i < 10*BIG; i += PGSIZE) {
    4466:	3e800737          	lui	a4,0x3e800
    446a:	87ca                	mv	a5,s2
    446c:	974a                	add	a4,a4,s2
    446e:	6685                	lui	a3,0x1
      n += *(a+i);
    4470:	0007c603          	lbu	a2,0(a5) # 6400000 <base+0x63f0388>
    for (i = 0; i < 10*BIG; i += PGSIZE) {
    4474:	97b6                	add	a5,a5,a3
      n += *(a+i);
    4476:	9cb1                	addw	s1,s1,a2
    for (i = 0; i < 10*BIG; i += PGSIZE) {
    4478:	fee79ce3          	bne	a5,a4,4470 <sbrkfail+0x12e>
    printf("%s: allocate a lot of memory succeeded %d\n", s, n);
    447c:	00003517          	auipc	a0,0x3
    4480:	60c50513          	add	a0,a0,1548 # 7a88 <malloc+0x1c44>
    4484:	8626                	mv	a2,s1
    4486:	85d6                	mv	a1,s5
    4488:	00002097          	auipc	ra,0x2
    448c:	8ec080e7          	jalr	-1812(ra) # 5d74 <printf>
    exit(1);
    4490:	4505                	li	a0,1
    4492:	00001097          	auipc	ra,0x1
    4496:	588080e7          	jalr	1416(ra) # 5a1a <exit>
    printf("%s: pipe() failed\n", s);
    449a:	00002517          	auipc	a0,0x2
    449e:	37e50513          	add	a0,a0,894 # 6818 <malloc+0x9d4>
    44a2:	85d6                	mv	a1,s5
    44a4:	00002097          	auipc	ra,0x2
    44a8:	8d0080e7          	jalr	-1840(ra) # 5d74 <printf>
    exit(1);
    44ac:	4505                	li	a0,1
    44ae:	00001097          	auipc	ra,0x1
    44b2:	56c080e7          	jalr	1388(ra) # 5a1a <exit>
    printf("%s: fork failed\n", s);
    44b6:	00002517          	auipc	a0,0x2
    44ba:	25a50513          	add	a0,a0,602 # 6710 <malloc+0x8cc>
    44be:	85d6                	mv	a1,s5
    44c0:	00002097          	auipc	ra,0x2
    44c4:	8b4080e7          	jalr	-1868(ra) # 5d74 <printf>
    exit(1);
    44c8:	4505                	li	a0,1
    44ca:	00001097          	auipc	ra,0x1
    44ce:	550080e7          	jalr	1360(ra) # 5a1a <exit>
    printf("%s: failed sbrk leaked memory\n", s);
    44d2:	00003517          	auipc	a0,0x3
    44d6:	59650513          	add	a0,a0,1430 # 7a68 <malloc+0x1c24>
    44da:	85d6                	mv	a1,s5
    44dc:	00002097          	auipc	ra,0x2
    44e0:	898080e7          	jalr	-1896(ra) # 5d74 <printf>
    exit(1);
    44e4:	4505                	li	a0,1
    44e6:	00001097          	auipc	ra,0x1
    44ea:	534080e7          	jalr	1332(ra) # 5a1a <exit>

00000000000044ee <mem>:
{
    44ee:	7139                	add	sp,sp,-64
    44f0:	f822                	sd	s0,48(sp)
    44f2:	ec4e                	sd	s3,24(sp)
    44f4:	fc06                	sd	ra,56(sp)
    44f6:	0080                	add	s0,sp,64
    44f8:	89aa                	mv	s3,a0
  if((pid = fork()) == 0){
    44fa:	00001097          	auipc	ra,0x1
    44fe:	518080e7          	jalr	1304(ra) # 5a12 <fork>
    4502:	e52d                	bnez	a0,456c <mem+0x7e>
    4504:	f04a                	sd	s2,32(sp)
    4506:	6909                	lui	s2,0x2
    4508:	f426                	sd	s1,40(sp)
    450a:	71190913          	add	s2,s2,1809 # 2711 <sbrkmuch+0x79>
    450e:	4481                	li	s1,0
    4510:	a019                	j	4516 <mem+0x28>
      *(char**)m2 = m1;
    4512:	e104                	sd	s1,0(a0)
      m1 = m2;
    4514:	84aa                	mv	s1,a0
    while((m2 = malloc(10001)) != 0){
    4516:	854a                	mv	a0,s2
    4518:	00002097          	auipc	ra,0x2
    451c:	92c080e7          	jalr	-1748(ra) # 5e44 <malloc>
    4520:	f96d                	bnez	a0,4512 <mem+0x24>
    while(m1){
    4522:	c881                	beqz	s1,4532 <mem+0x44>
      m2 = *(char**)m1;
    4524:	8526                	mv	a0,s1
    4526:	6084                	ld	s1,0(s1)
      free(m1);
    4528:	00002097          	auipc	ra,0x2
    452c:	884080e7          	jalr	-1916(ra) # 5dac <free>
    while(m1){
    4530:	f8f5                	bnez	s1,4524 <mem+0x36>
    m1 = malloc(1024*20);
    4532:	6515                	lui	a0,0x5
    4534:	00002097          	auipc	ra,0x2
    4538:	910080e7          	jalr	-1776(ra) # 5e44 <malloc>
    if(m1 == 0){
    453c:	c911                	beqz	a0,4550 <mem+0x62>
    free(m1);
    453e:	00002097          	auipc	ra,0x2
    4542:	86e080e7          	jalr	-1938(ra) # 5dac <free>
    exit(0);
    4546:	4501                	li	a0,0
    4548:	00001097          	auipc	ra,0x1
    454c:	4d2080e7          	jalr	1234(ra) # 5a1a <exit>
      printf("couldn't allocate mem?!!\n", s);
    4550:	00003517          	auipc	a0,0x3
    4554:	56850513          	add	a0,a0,1384 # 7ab8 <malloc+0x1c74>
    4558:	85ce                	mv	a1,s3
    455a:	00002097          	auipc	ra,0x2
    455e:	81a080e7          	jalr	-2022(ra) # 5d74 <printf>
      exit(1);
    4562:	4505                	li	a0,1
    4564:	00001097          	auipc	ra,0x1
    4568:	4b6080e7          	jalr	1206(ra) # 5a1a <exit>
    wait(&xstatus);
    456c:	fcc40513          	add	a0,s0,-52
    4570:	00001097          	auipc	ra,0x1
    4574:	4b2080e7          	jalr	1202(ra) # 5a22 <wait>
    if(xstatus == -1){
    4578:	fcc42503          	lw	a0,-52(s0)
    457c:	57fd                	li	a5,-1
    457e:	f426                	sd	s1,40(sp)
    4580:	f04a                	sd	s2,32(sp)
    4582:	00f50663          	beq	a0,a5,458e <mem+0xa0>
    exit(xstatus);
    4586:	00001097          	auipc	ra,0x1
    458a:	494080e7          	jalr	1172(ra) # 5a1a <exit>
      exit(0);
    458e:	4501                	li	a0,0
    4590:	00001097          	auipc	ra,0x1
    4594:	48a080e7          	jalr	1162(ra) # 5a1a <exit>

0000000000004598 <sharedfd>:
{
    4598:	7159                	add	sp,sp,-112
    459a:	f486                	sd	ra,104(sp)
    459c:	f0a2                	sd	s0,96(sp)
    459e:	e0d2                	sd	s4,64(sp)
    45a0:	1880                	add	s0,sp,112
    45a2:	8a2a                	mv	s4,a0
  unlink("sharedfd");
    45a4:	00003517          	auipc	a0,0x3
    45a8:	53450513          	add	a0,a0,1332 # 7ad8 <malloc+0x1c94>
    45ac:	00001097          	auipc	ra,0x1
    45b0:	4be080e7          	jalr	1214(ra) # 5a6a <unlink>
  fd = open("sharedfd", O_CREATE|O_RDWR);
    45b4:	20200593          	li	a1,514
    45b8:	00003517          	auipc	a0,0x3
    45bc:	52050513          	add	a0,a0,1312 # 7ad8 <malloc+0x1c94>
    45c0:	00001097          	auipc	ra,0x1
    45c4:	49a080e7          	jalr	1178(ra) # 5a5a <open>
  if(fd < 0){
    45c8:	eca6                	sd	s1,88(sp)
    45ca:	e8ca                	sd	s2,80(sp)
    45cc:	e4ce                	sd	s3,72(sp)
    45ce:	fc56                	sd	s5,56(sp)
    45d0:	f85a                	sd	s6,48(sp)
    45d2:	f45e                	sd	s7,40(sp)
    45d4:	06054363          	bltz	a0,463a <sharedfd+0xa2>
    45d8:	892a                	mv	s2,a0
  pid = fork();
    45da:	00001097          	auipc	ra,0x1
    45de:	438080e7          	jalr	1080(ra) # 5a12 <fork>
    45e2:	89aa                	mv	s3,a0
  memset(buf, pid==0?'c':'p', sizeof(buf));
    45e4:	07000593          	li	a1,112
    45e8:	c531                	beqz	a0,4634 <sharedfd+0x9c>
    45ea:	4629                	li	a2,10
    45ec:	fa040513          	add	a0,s0,-96
    45f0:	00001097          	auipc	ra,0x1
    45f4:	1de080e7          	jalr	478(ra) # 57ce <memset>
    45f8:	3e800493          	li	s1,1000
    45fc:	a019                	j	4602 <sharedfd+0x6a>
  for(i = 0; i < N; i++){
    45fe:	34fd                	addw	s1,s1,-1
    4600:	c8b9                	beqz	s1,4656 <sharedfd+0xbe>
    if(write(fd, buf, sizeof(buf)) != sizeof(buf)){
    4602:	4629                	li	a2,10
    4604:	fa040593          	add	a1,s0,-96
    4608:	854a                	mv	a0,s2
    460a:	00001097          	auipc	ra,0x1
    460e:	430080e7          	jalr	1072(ra) # 5a3a <write>
    4612:	47a9                	li	a5,10
    4614:	fef505e3          	beq	a0,a5,45fe <sharedfd+0x66>
      printf("%s: write sharedfd failed\n", s);
    4618:	00003517          	auipc	a0,0x3
    461c:	4f850513          	add	a0,a0,1272 # 7b10 <malloc+0x1ccc>
    4620:	85d2                	mv	a1,s4
    4622:	00001097          	auipc	ra,0x1
    4626:	752080e7          	jalr	1874(ra) # 5d74 <printf>
      exit(1);
    462a:	4505                	li	a0,1
    462c:	00001097          	auipc	ra,0x1
    4630:	3ee080e7          	jalr	1006(ra) # 5a1a <exit>
  memset(buf, pid==0?'c':'p', sizeof(buf));
    4634:	06300593          	li	a1,99
    4638:	bf4d                	j	45ea <sharedfd+0x52>
    printf("%s: cannot open sharedfd for writing", s);
    463a:	00003517          	auipc	a0,0x3
    463e:	4ae50513          	add	a0,a0,1198 # 7ae8 <malloc+0x1ca4>
    4642:	85d2                	mv	a1,s4
    4644:	00001097          	auipc	ra,0x1
    4648:	730080e7          	jalr	1840(ra) # 5d74 <printf>
    exit(1);
    464c:	4505                	li	a0,1
    464e:	00001097          	auipc	ra,0x1
    4652:	3cc080e7          	jalr	972(ra) # 5a1a <exit>
  if(pid == 0) {
    4656:	02098163          	beqz	s3,4678 <sharedfd+0xe0>
    wait(&xstatus);
    465a:	f9c40513          	add	a0,s0,-100
    465e:	00001097          	auipc	ra,0x1
    4662:	3c4080e7          	jalr	964(ra) # 5a22 <wait>
    if(xstatus != 0)
    4666:	f9c42983          	lw	s3,-100(s0)
    466a:	00098c63          	beqz	s3,4682 <sharedfd+0xea>
      exit(xstatus);
    466e:	854e                	mv	a0,s3
    4670:	00001097          	auipc	ra,0x1
    4674:	3aa080e7          	jalr	938(ra) # 5a1a <exit>
    exit(0);
    4678:	4501                	li	a0,0
    467a:	00001097          	auipc	ra,0x1
    467e:	3a0080e7          	jalr	928(ra) # 5a1a <exit>
  close(fd);
    4682:	854a                	mv	a0,s2
    4684:	00001097          	auipc	ra,0x1
    4688:	3be080e7          	jalr	958(ra) # 5a42 <close>
  fd = open("sharedfd", 0);
    468c:	4581                	li	a1,0
    468e:	00003517          	auipc	a0,0x3
    4692:	44a50513          	add	a0,a0,1098 # 7ad8 <malloc+0x1c94>
    4696:	00001097          	auipc	ra,0x1
    469a:	3c4080e7          	jalr	964(ra) # 5a5a <open>
    469e:	8baa                	mv	s7,a0
  nc = np = 0;
    46a0:	4a81                	li	s5,0
  if(fd < 0){
    46a2:	08054363          	bltz	a0,4728 <sharedfd+0x190>
    46a6:	faa40913          	add	s2,s0,-86
      if(buf[i] == 'c')
    46aa:	06300493          	li	s1,99
      if(buf[i] == 'p')
    46ae:	07000b13          	li	s6,112
  while((n = read(fd, buf, sizeof(buf))) > 0){
    46b2:	4629                	li	a2,10
    46b4:	fa040593          	add	a1,s0,-96
    46b8:	855e                	mv	a0,s7
    46ba:	00001097          	auipc	ra,0x1
    46be:	378080e7          	jalr	888(ra) # 5a32 <read>
    46c2:	02a05163          	blez	a0,46e4 <sharedfd+0x14c>
    for(i = 0; i < sizeof(buf); i++){
    46c6:	fa040793          	add	a5,s0,-96
    46ca:	a039                	j	46d8 <sharedfd+0x140>
      if(buf[i] == 'p')
    46cc:	01671363          	bne	a4,s6,46d2 <sharedfd+0x13a>
        np++;
    46d0:	2a85                	addw	s5,s5,1
    for(i = 0; i < sizeof(buf); i++){
    46d2:	0785                	add	a5,a5,1
    46d4:	fd278fe3          	beq	a5,s2,46b2 <sharedfd+0x11a>
      if(buf[i] == 'c')
    46d8:	0007c703          	lbu	a4,0(a5)
    46dc:	fe9718e3          	bne	a4,s1,46cc <sharedfd+0x134>
        nc++;
    46e0:	2985                	addw	s3,s3,1
      if(buf[i] == 'p')
    46e2:	bfc5                	j	46d2 <sharedfd+0x13a>
  close(fd);
    46e4:	855e                	mv	a0,s7
    46e6:	00001097          	auipc	ra,0x1
    46ea:	35c080e7          	jalr	860(ra) # 5a42 <close>
  unlink("sharedfd");
    46ee:	00003517          	auipc	a0,0x3
    46f2:	3ea50513          	add	a0,a0,1002 # 7ad8 <malloc+0x1c94>
    46f6:	00001097          	auipc	ra,0x1
    46fa:	374080e7          	jalr	884(ra) # 5a6a <unlink>
  if(nc == N*SZ && np == N*SZ){
    46fe:	6789                	lui	a5,0x2
    4700:	71078793          	add	a5,a5,1808 # 2710 <sbrkmuch+0x78>
    4704:	00f99463          	bne	s3,a5,470c <sharedfd+0x174>
    4708:	f73a88e3          	beq	s5,s3,4678 <sharedfd+0xe0>
    printf("%s: nc/np test fails\n", s);
    470c:	00003517          	auipc	a0,0x3
    4710:	44c50513          	add	a0,a0,1100 # 7b58 <malloc+0x1d14>
    4714:	85d2                	mv	a1,s4
    4716:	00001097          	auipc	ra,0x1
    471a:	65e080e7          	jalr	1630(ra) # 5d74 <printf>
    exit(1);
    471e:	4505                	li	a0,1
    4720:	00001097          	auipc	ra,0x1
    4724:	2fa080e7          	jalr	762(ra) # 5a1a <exit>
    printf("%s: cannot open sharedfd for reading\n", s);
    4728:	00003517          	auipc	a0,0x3
    472c:	40850513          	add	a0,a0,1032 # 7b30 <malloc+0x1cec>
    4730:	85d2                	mv	a1,s4
    4732:	00001097          	auipc	ra,0x1
    4736:	642080e7          	jalr	1602(ra) # 5d74 <printf>
    exit(1);
    473a:	4505                	li	a0,1
    473c:	00001097          	auipc	ra,0x1
    4740:	2de080e7          	jalr	734(ra) # 5a1a <exit>

0000000000004744 <fourfiles>:
{
    4744:	7175                	add	sp,sp,-144
    4746:	e122                	sd	s0,128(sp)
    4748:	fca6                	sd	s1,120(sp)
    474a:	0900                	add	s0,sp,144
    474c:	f8ca                	sd	s2,112(sp)
    474e:	f0d2                	sd	s4,96(sp)
    4750:	ecd6                	sd	s5,88(sp)
    4752:	e4de                	sd	s7,72(sp)
    4754:	e506                	sd	ra,136(sp)
    4756:	f4ce                	sd	s3,104(sp)
    4758:	e8da                	sd	s6,80(sp)
    475a:	e0e2                	sd	s8,64(sp)
    475c:	fc66                	sd	s9,56(sp)
    475e:	f86a                	sd	s10,48(sp)
  char *names[] = { "f0", "f1", "f2", "f3" };
    4760:	00003797          	auipc	a5,0x3
    4764:	41078793          	add	a5,a5,1040 # 7b70 <malloc+0x1d2c>
    4768:	f8f43023          	sd	a5,-128(s0)
    476c:	00003797          	auipc	a5,0x3
    4770:	40c78793          	add	a5,a5,1036 # 7b78 <malloc+0x1d34>
    4774:	f8f43423          	sd	a5,-120(s0)
    4778:	00003797          	auipc	a5,0x3
    477c:	40878793          	add	a5,a5,1032 # 7b80 <malloc+0x1d3c>
    4780:	f8040a93          	add	s5,s0,-128
    4784:	f8f43823          	sd	a5,-112(s0)
    4788:	00003797          	auipc	a5,0x3
    478c:	40078793          	add	a5,a5,1024 # 7b88 <malloc+0x1d44>
{
    4790:	8baa                	mv	s7,a0
  char *names[] = { "f0", "f1", "f2", "f3" };
    4792:	f8f43c23          	sd	a5,-104(s0)
    4796:	8956                	mv	s2,s5
  for(pi = 0; pi < NCHILD; pi++){
    4798:	4481                	li	s1,0
    479a:	4a11                	li	s4,4
    fname = names[pi];
    479c:	00093983          	ld	s3,0(s2)
    unlink(fname);
    47a0:	854e                	mv	a0,s3
    47a2:	00001097          	auipc	ra,0x1
    47a6:	2c8080e7          	jalr	712(ra) # 5a6a <unlink>
    pid = fork();
    47aa:	00001097          	auipc	ra,0x1
    47ae:	268080e7          	jalr	616(ra) # 5a12 <fork>
    if(pid < 0){
    47b2:	18054163          	bltz	a0,4934 <fourfiles+0x1f0>
    if(pid == 0){
    47b6:	c565                	beqz	a0,489e <fourfiles+0x15a>
  for(pi = 0; pi < NCHILD; pi++){
    47b8:	2485                	addw	s1,s1,1
    47ba:	0921                	add	s2,s2,8
    47bc:	ff4490e3          	bne	s1,s4,479c <fourfiles+0x58>
    47c0:	4491                	li	s1,4
    wait(&xstatus);
    47c2:	f7c40513          	add	a0,s0,-132
    47c6:	00001097          	auipc	ra,0x1
    47ca:	25c080e7          	jalr	604(ra) # 5a22 <wait>
    if(xstatus != 0)
    47ce:	f7c42503          	lw	a0,-132(s0)
    47d2:	e171                	bnez	a0,4896 <fourfiles+0x152>
  for(pi = 0; pi < NCHILD; pi++){
    47d4:	34fd                	addw	s1,s1,-1
    47d6:	f4f5                	bnez	s1,47c2 <fourfiles+0x7e>
    if(total != N*SZ){
    47d8:	6c05                	lui	s8,0x1
    47da:	03000a13          	li	s4,48
    while((n = read(fd, buf, sizeof(buf))) > 0){
    47de:	00008997          	auipc	s3,0x8
    47e2:	49a98993          	add	s3,s3,1178 # cc78 <buf>
    if(total != N*SZ){
    47e6:	770c0c13          	add	s8,s8,1904 # 1770 <pipe1+0x14e>
  for(i = 0; i < NCHILD; i++){
    47ea:	03400c93          	li	s9,52
    fname = names[i];
    47ee:	000abb03          	ld	s6,0(s5)
    fd = open(fname, 0);
    47f2:	4581                	li	a1,0
    total = 0;
    47f4:	4481                	li	s1,0
    fd = open(fname, 0);
    47f6:	855a                	mv	a0,s6
    47f8:	00001097          	auipc	ra,0x1
    47fc:	262080e7          	jalr	610(ra) # 5a5a <open>
    4800:	892a                	mv	s2,a0
    while((n = read(fd, buf, sizeof(buf))) > 0){
    4802:	660d                	lui	a2,0x3
    4804:	85ce                	mv	a1,s3
    4806:	854a                	mv	a0,s2
    4808:	000a0d1b          	sext.w	s10,s4
    480c:	00001097          	auipc	ra,0x1
    4810:	226080e7          	jalr	550(ra) # 5a32 <read>
    4814:	02a05963          	blez	a0,4846 <fourfiles+0x102>
    4818:	00008797          	auipc	a5,0x8
    481c:	46078793          	add	a5,a5,1120 # cc78 <buf>
    4820:	00f506b3          	add	a3,a0,a5
        if(buf[j] != '0'+i){
    4824:	0007c703          	lbu	a4,0(a5)
    4828:	05a71d63          	bne	a4,s10,4882 <fourfiles+0x13e>
      for(j = 0; j < n; j++){
    482c:	0785                	add	a5,a5,1
    482e:	fed79be3          	bne	a5,a3,4824 <fourfiles+0xe0>
      total += n;
    4832:	9ca9                	addw	s1,s1,a0
    while((n = read(fd, buf, sizeof(buf))) > 0){
    4834:	660d                	lui	a2,0x3
    4836:	85ce                	mv	a1,s3
    4838:	854a                	mv	a0,s2
    483a:	00001097          	auipc	ra,0x1
    483e:	1f8080e7          	jalr	504(ra) # 5a32 <read>
    4842:	fca04be3          	bgtz	a0,4818 <fourfiles+0xd4>
    close(fd);
    4846:	854a                	mv	a0,s2
    4848:	00001097          	auipc	ra,0x1
    484c:	1fa080e7          	jalr	506(ra) # 5a42 <close>
    if(total != N*SZ){
    4850:	0d849463          	bne	s1,s8,4918 <fourfiles+0x1d4>
    unlink(fname);
    4854:	855a                	mv	a0,s6
  for(i = 0; i < NCHILD; i++){
    4856:	2a05                	addw	s4,s4,1
    unlink(fname);
    4858:	00001097          	auipc	ra,0x1
    485c:	212080e7          	jalr	530(ra) # 5a6a <unlink>
  for(i = 0; i < NCHILD; i++){
    4860:	0aa1                	add	s5,s5,8
    4862:	f99a16e3          	bne	s4,s9,47ee <fourfiles+0xaa>
}
    4866:	60aa                	ld	ra,136(sp)
    4868:	640a                	ld	s0,128(sp)
    486a:	74e6                	ld	s1,120(sp)
    486c:	7946                	ld	s2,112(sp)
    486e:	79a6                	ld	s3,104(sp)
    4870:	7a06                	ld	s4,96(sp)
    4872:	6ae6                	ld	s5,88(sp)
    4874:	6b46                	ld	s6,80(sp)
    4876:	6ba6                	ld	s7,72(sp)
    4878:	6c06                	ld	s8,64(sp)
    487a:	7ce2                	ld	s9,56(sp)
    487c:	7d42                	ld	s10,48(sp)
    487e:	6149                	add	sp,sp,144
    4880:	8082                	ret
          printf("wrong char\n", s);
    4882:	00003517          	auipc	a0,0x3
    4886:	33650513          	add	a0,a0,822 # 7bb8 <malloc+0x1d74>
    488a:	85de                	mv	a1,s7
    488c:	00001097          	auipc	ra,0x1
    4890:	4e8080e7          	jalr	1256(ra) # 5d74 <printf>
          exit(1);
    4894:	4505                	li	a0,1
    4896:	00001097          	auipc	ra,0x1
    489a:	184080e7          	jalr	388(ra) # 5a1a <exit>
      fd = open(fname, O_CREATE | O_RDWR);
    489e:	20200593          	li	a1,514
    48a2:	854e                	mv	a0,s3
    48a4:	00001097          	auipc	ra,0x1
    48a8:	1b6080e7          	jalr	438(ra) # 5a5a <open>
    48ac:	892a                	mv	s2,a0
      if(fd < 0){
    48ae:	04054763          	bltz	a0,48fc <fourfiles+0x1b8>
      memset(buf, '0'+pi, SZ);
    48b2:	0304859b          	addw	a1,s1,48
    48b6:	1f400613          	li	a2,500
    48ba:	00008517          	auipc	a0,0x8
    48be:	3be50513          	add	a0,a0,958 # cc78 <buf>
    48c2:	00001097          	auipc	ra,0x1
    48c6:	f0c080e7          	jalr	-244(ra) # 57ce <memset>
    48ca:	44b1                	li	s1,12
        if((n = write(fd, buf, SZ)) != SZ){
    48cc:	00008997          	auipc	s3,0x8
    48d0:	3ac98993          	add	s3,s3,940 # cc78 <buf>
    48d4:	85ce                	mv	a1,s3
    48d6:	1f400613          	li	a2,500
    48da:	854a                	mv	a0,s2
    48dc:	00001097          	auipc	ra,0x1
    48e0:	15e080e7          	jalr	350(ra) # 5a3a <write>
    48e4:	1f400793          	li	a5,500
    48e8:	85aa                	mv	a1,a0
    48ea:	06f51363          	bne	a0,a5,4950 <fourfiles+0x20c>
      for(i = 0; i < N; i++){
    48ee:	34fd                	addw	s1,s1,-1
    48f0:	f0f5                	bnez	s1,48d4 <fourfiles+0x190>
      exit(0);
    48f2:	4501                	li	a0,0
    48f4:	00001097          	auipc	ra,0x1
    48f8:	126080e7          	jalr	294(ra) # 5a1a <exit>
        printf("create failed\n", s);
    48fc:	00003517          	auipc	a0,0x3
    4900:	29450513          	add	a0,a0,660 # 7b90 <malloc+0x1d4c>
    4904:	85de                	mv	a1,s7
    4906:	00001097          	auipc	ra,0x1
    490a:	46e080e7          	jalr	1134(ra) # 5d74 <printf>
        exit(1);
    490e:	4505                	li	a0,1
    4910:	00001097          	auipc	ra,0x1
    4914:	10a080e7          	jalr	266(ra) # 5a1a <exit>
      printf("wrong length %d\n", total);
    4918:	00003517          	auipc	a0,0x3
    491c:	2b050513          	add	a0,a0,688 # 7bc8 <malloc+0x1d84>
    4920:	85a6                	mv	a1,s1
    4922:	00001097          	auipc	ra,0x1
    4926:	452080e7          	jalr	1106(ra) # 5d74 <printf>
      exit(1);
    492a:	4505                	li	a0,1
    492c:	00001097          	auipc	ra,0x1
    4930:	0ee080e7          	jalr	238(ra) # 5a1a <exit>
      printf("fork failed\n", s);
    4934:	00002517          	auipc	a0,0x2
    4938:	1e450513          	add	a0,a0,484 # 6b18 <malloc+0xcd4>
    493c:	85de                	mv	a1,s7
    493e:	00001097          	auipc	ra,0x1
    4942:	436080e7          	jalr	1078(ra) # 5d74 <printf>
      exit(1);
    4946:	4505                	li	a0,1
    4948:	00001097          	auipc	ra,0x1
    494c:	0d2080e7          	jalr	210(ra) # 5a1a <exit>
          printf("write failed %d\n", n);
    4950:	00003517          	auipc	a0,0x3
    4954:	25050513          	add	a0,a0,592 # 7ba0 <malloc+0x1d5c>
    4958:	00001097          	auipc	ra,0x1
    495c:	41c080e7          	jalr	1052(ra) # 5d74 <printf>
          exit(1);
    4960:	4505                	li	a0,1
    4962:	00001097          	auipc	ra,0x1
    4966:	0b8080e7          	jalr	184(ra) # 5a1a <exit>

000000000000496a <concreate>:
{
    496a:	7175                	add	sp,sp,-144
    496c:	e122                	sd	s0,128(sp)
    496e:	f8ca                	sd	s2,112(sp)
    4970:	0900                	add	s0,sp,144
    4972:	f4ce                	sd	s3,104(sp)
    4974:	f0d2                	sd	s4,96(sp)
    4976:	ecd6                	sd	s5,88(sp)
    4978:	e8da                	sd	s6,80(sp)
    497a:	e4de                	sd	s7,72(sp)
    497c:	e506                	sd	ra,136(sp)
    497e:	fca6                	sd	s1,120(sp)
  file[0] = 'C';
    4980:	04300793          	li	a5,67
{
    4984:	89aa                	mv	s3,a0
  file[0] = 'C';
    4986:	f6f40823          	sb	a5,-144(s0)
  file[2] = '\0';
    498a:	f6040923          	sb	zero,-142(s0)
  for(i = 0; i < N; i++){
    498e:	4901                	li	s2,0
    4990:	4b0d                	li	s6,3
    if(pid && (i % 3) == 1){
    4992:	4a85                	li	s5,1
      link("C0", file);
    4994:	00003b97          	auipc	s7,0x3
    4998:	24cb8b93          	add	s7,s7,588 # 7be0 <malloc+0x1d9c>
  for(i = 0; i < N; i++){
    499c:	02800a13          	li	s4,40
    49a0:	a081                	j	49e0 <concreate+0x76>
    if(pid && (i % 3) == 1){
    49a2:	036967bb          	remw	a5,s2,s6
    49a6:	09578b63          	beq	a5,s5,4a3c <concreate+0xd2>
      fd = open(file, O_CREATE | O_RDWR);
    49aa:	20200593          	li	a1,514
    49ae:	f7040513          	add	a0,s0,-144
    49b2:	00001097          	auipc	ra,0x1
    49b6:	0a8080e7          	jalr	168(ra) # 5a5a <open>
      if(fd < 0){
    49ba:	06054263          	bltz	a0,4a1e <concreate+0xb4>
      close(fd);
    49be:	00001097          	auipc	ra,0x1
    49c2:	084080e7          	jalr	132(ra) # 5a42 <close>
      wait(&xstatus);
    49c6:	f8840513          	add	a0,s0,-120
    49ca:	00001097          	auipc	ra,0x1
    49ce:	058080e7          	jalr	88(ra) # 5a22 <wait>
      if(xstatus != 0)
    49d2:	f8842483          	lw	s1,-120(s0)
    49d6:	26049963          	bnez	s1,4c48 <concreate+0x2de>
  for(i = 0; i < N; i++){
    49da:	2905                	addw	s2,s2,1
    49dc:	09490763          	beq	s2,s4,4a6a <concreate+0x100>
    file[1] = '0' + i;
    49e0:	0309079b          	addw	a5,s2,48
    unlink(file);
    49e4:	f7040513          	add	a0,s0,-144
    file[1] = '0' + i;
    49e8:	f6f408a3          	sb	a5,-143(s0)
    unlink(file);
    49ec:	00001097          	auipc	ra,0x1
    49f0:	07e080e7          	jalr	126(ra) # 5a6a <unlink>
    pid = fork();
    49f4:	00001097          	auipc	ra,0x1
    49f8:	01e080e7          	jalr	30(ra) # 5a12 <fork>
    if(pid && (i % 3) == 1){
    49fc:	f15d                	bnez	a0,49a2 <concreate+0x38>
      link("C0", file);
    49fe:	4795                	li	a5,5
    } else if(pid == 0 && (i % 5) == 1){
    4a00:	02f9693b          	remw	s2,s2,a5
    4a04:	4785                	li	a5,1
    4a06:	04f90363          	beq	s2,a5,4a4c <concreate+0xe2>
      fd = open(file, O_CREATE | O_RDWR);
    4a0a:	20200593          	li	a1,514
    4a0e:	f7040513          	add	a0,s0,-144
    4a12:	00001097          	auipc	ra,0x1
    4a16:	048080e7          	jalr	72(ra) # 5a5a <open>
      if(fd < 0){
    4a1a:	24055a63          	bgez	a0,4c6e <concreate+0x304>
        printf("concreate create %s failed\n", file);
    4a1e:	00003517          	auipc	a0,0x3
    4a22:	1ca50513          	add	a0,a0,458 # 7be8 <malloc+0x1da4>
    4a26:	f7040593          	add	a1,s0,-144
    4a2a:	00001097          	auipc	ra,0x1
    4a2e:	34a080e7          	jalr	842(ra) # 5d74 <printf>
        exit(1);
    4a32:	4505                	li	a0,1
    4a34:	00001097          	auipc	ra,0x1
    4a38:	fe6080e7          	jalr	-26(ra) # 5a1a <exit>
      link("C0", file);
    4a3c:	f7040593          	add	a1,s0,-144
    4a40:	855e                	mv	a0,s7
    4a42:	00001097          	auipc	ra,0x1
    4a46:	038080e7          	jalr	56(ra) # 5a7a <link>
    if(pid == 0) {
    4a4a:	bfb5                	j	49c6 <concreate+0x5c>
      link("C0", file);
    4a4c:	f7040593          	add	a1,s0,-144
    4a50:	00003517          	auipc	a0,0x3
    4a54:	19050513          	add	a0,a0,400 # 7be0 <malloc+0x1d9c>
    4a58:	00001097          	auipc	ra,0x1
    4a5c:	022080e7          	jalr	34(ra) # 5a7a <link>
      exit(0);
    4a60:	4501                	li	a0,0
    4a62:	00001097          	auipc	ra,0x1
    4a66:	fb8080e7          	jalr	-72(ra) # 5a1a <exit>
  memset(fa, 0, sizeof(fa));
    4a6a:	02800613          	li	a2,40
    4a6e:	4581                	li	a1,0
    4a70:	f8840513          	add	a0,s0,-120
    4a74:	00001097          	auipc	ra,0x1
    4a78:	d5a080e7          	jalr	-678(ra) # 57ce <memset>
  fd = open(".", 0);
    4a7c:	4581                	li	a1,0
    4a7e:	00002517          	auipc	a0,0x2
    4a82:	b8250513          	add	a0,a0,-1150 # 6600 <malloc+0x7bc>
    4a86:	00001097          	auipc	ra,0x1
    4a8a:	fd4080e7          	jalr	-44(ra) # 5a5a <open>
    4a8e:	892a                	mv	s2,a0
  n = 0;
    4a90:	4a81                	li	s5,0
    if(de.name[0] == 'C' && de.name[2] == '\0'){
    4a92:	04300a13          	li	s4,67
      if(i < 0 || i >= sizeof(fa)){
    4a96:	02700b13          	li	s6,39
      fa[i] = 1;
    4a9a:	4b85                	li	s7,1
  while(read(fd, &de, sizeof(de)) > 0){
    4a9c:	4641                	li	a2,16
    4a9e:	f7840593          	add	a1,s0,-136
    4aa2:	854a                	mv	a0,s2
    4aa4:	00001097          	auipc	ra,0x1
    4aa8:	f8e080e7          	jalr	-114(ra) # 5a32 <read>
    4aac:	04a05663          	blez	a0,4af8 <concreate+0x18e>
    if(de.inum == 0)
    4ab0:	f7845783          	lhu	a5,-136(s0)
    4ab4:	d7e5                	beqz	a5,4a9c <concreate+0x132>
    if(de.name[0] == 'C' && de.name[2] == '\0'){
    4ab6:	f7a44783          	lbu	a5,-134(s0)
    4aba:	ff4791e3          	bne	a5,s4,4a9c <concreate+0x132>
    4abe:	f7c44783          	lbu	a5,-132(s0)
    4ac2:	ffe9                	bnez	a5,4a9c <concreate+0x132>
      i = de.name[1] - '0';
    4ac4:	f7b44783          	lbu	a5,-133(s0)
    4ac8:	fd07879b          	addw	a5,a5,-48
      if(i < 0 || i >= sizeof(fa)){
    4acc:	16fb6363          	bltu	s6,a5,4c32 <concreate+0x2c8>
      if(fa[i]){
    4ad0:	fb078793          	add	a5,a5,-80
    4ad4:	97a2                	add	a5,a5,s0
    4ad6:	fd87c703          	lbu	a4,-40(a5)
    4ada:	1a071d63          	bnez	a4,4c94 <concreate+0x32a>
      fa[i] = 1;
    4ade:	fd778c23          	sb	s7,-40(a5)
  while(read(fd, &de, sizeof(de)) > 0){
    4ae2:	4641                	li	a2,16
    4ae4:	f7840593          	add	a1,s0,-136
    4ae8:	854a                	mv	a0,s2
      n++;
    4aea:	2a85                	addw	s5,s5,1
  while(read(fd, &de, sizeof(de)) > 0){
    4aec:	00001097          	auipc	ra,0x1
    4af0:	f46080e7          	jalr	-186(ra) # 5a32 <read>
    4af4:	faa04ee3          	bgtz	a0,4ab0 <concreate+0x146>
  close(fd);
    4af8:	854a                	mv	a0,s2
    4afa:	00001097          	auipc	ra,0x1
    4afe:	f48080e7          	jalr	-184(ra) # 5a42 <close>
  if(n != N){
    4b02:	02800793          	li	a5,40
    4b06:	16fa9963          	bne	s5,a5,4c78 <concreate+0x30e>
    if(((i % 3) == 0 && pid == 0) ||
    4b0a:	4a8d                	li	s5,3
    4b0c:	4b05                	li	s6,1
  for(i = 0; i < N; i++){
    4b0e:	02800a13          	li	s4,40
    file[1] = '0' + i;
    4b12:	0304879b          	addw	a5,s1,48
    4b16:	f6f408a3          	sb	a5,-143(s0)
    pid = fork();
    4b1a:	00001097          	auipc	ra,0x1
    4b1e:	ef8080e7          	jalr	-264(ra) # 5a12 <fork>
    4b22:	892a                	mv	s2,a0
    if(pid < 0){
    4b24:	12054763          	bltz	a0,4c52 <concreate+0x2e8>
    if(((i % 3) == 0 && pid == 0) ||
    4b28:	0354e73b          	remw	a4,s1,s5
    4b2c:	00a767b3          	or	a5,a4,a0
    4b30:	2781                	sext.w	a5,a5
    4b32:	c781                	beqz	a5,4b3a <concreate+0x1d0>
    4b34:	0b671a63          	bne	a4,s6,4be8 <concreate+0x27e>
       ((i % 3) == 1 && pid != 0)){
    4b38:	c945                	beqz	a0,4be8 <concreate+0x27e>
      close(open(file, 0));
    4b3a:	4581                	li	a1,0
    4b3c:	f7040513          	add	a0,s0,-144
    4b40:	00001097          	auipc	ra,0x1
    4b44:	f1a080e7          	jalr	-230(ra) # 5a5a <open>
    4b48:	00001097          	auipc	ra,0x1
    4b4c:	efa080e7          	jalr	-262(ra) # 5a42 <close>
      close(open(file, 0));
    4b50:	4581                	li	a1,0
    4b52:	f7040513          	add	a0,s0,-144
    4b56:	00001097          	auipc	ra,0x1
    4b5a:	f04080e7          	jalr	-252(ra) # 5a5a <open>
    4b5e:	00001097          	auipc	ra,0x1
    4b62:	ee4080e7          	jalr	-284(ra) # 5a42 <close>
      close(open(file, 0));
    4b66:	4581                	li	a1,0
    4b68:	f7040513          	add	a0,s0,-144
    4b6c:	00001097          	auipc	ra,0x1
    4b70:	eee080e7          	jalr	-274(ra) # 5a5a <open>
    4b74:	00001097          	auipc	ra,0x1
    4b78:	ece080e7          	jalr	-306(ra) # 5a42 <close>
      close(open(file, 0));
    4b7c:	4581                	li	a1,0
    4b7e:	f7040513          	add	a0,s0,-144
    4b82:	00001097          	auipc	ra,0x1
    4b86:	ed8080e7          	jalr	-296(ra) # 5a5a <open>
    4b8a:	00001097          	auipc	ra,0x1
    4b8e:	eb8080e7          	jalr	-328(ra) # 5a42 <close>
      close(open(file, 0));
    4b92:	4581                	li	a1,0
    4b94:	f7040513          	add	a0,s0,-144
    4b98:	00001097          	auipc	ra,0x1
    4b9c:	ec2080e7          	jalr	-318(ra) # 5a5a <open>
    4ba0:	00001097          	auipc	ra,0x1
    4ba4:	ea2080e7          	jalr	-350(ra) # 5a42 <close>
      close(open(file, 0));
    4ba8:	4581                	li	a1,0
    4baa:	f7040513          	add	a0,s0,-144
    4bae:	00001097          	auipc	ra,0x1
    4bb2:	eac080e7          	jalr	-340(ra) # 5a5a <open>
    4bb6:	00001097          	auipc	ra,0x1
    4bba:	e8c080e7          	jalr	-372(ra) # 5a42 <close>
    if(pid == 0)
    4bbe:	ea0901e3          	beqz	s2,4a60 <concreate+0xf6>
      wait(0);
    4bc2:	4501                	li	a0,0
  for(i = 0; i < N; i++){
    4bc4:	2485                	addw	s1,s1,1
      wait(0);
    4bc6:	00001097          	auipc	ra,0x1
    4bca:	e5c080e7          	jalr	-420(ra) # 5a22 <wait>
  for(i = 0; i < N; i++){
    4bce:	f54492e3          	bne	s1,s4,4b12 <concreate+0x1a8>
}
    4bd2:	60aa                	ld	ra,136(sp)
    4bd4:	640a                	ld	s0,128(sp)
    4bd6:	74e6                	ld	s1,120(sp)
    4bd8:	7946                	ld	s2,112(sp)
    4bda:	79a6                	ld	s3,104(sp)
    4bdc:	7a06                	ld	s4,96(sp)
    4bde:	6ae6                	ld	s5,88(sp)
    4be0:	6b46                	ld	s6,80(sp)
    4be2:	6ba6                	ld	s7,72(sp)
    4be4:	6149                	add	sp,sp,144
    4be6:	8082                	ret
      unlink(file);
    4be8:	f7040513          	add	a0,s0,-144
    4bec:	00001097          	auipc	ra,0x1
    4bf0:	e7e080e7          	jalr	-386(ra) # 5a6a <unlink>
      unlink(file);
    4bf4:	f7040513          	add	a0,s0,-144
    4bf8:	00001097          	auipc	ra,0x1
    4bfc:	e72080e7          	jalr	-398(ra) # 5a6a <unlink>
      unlink(file);
    4c00:	f7040513          	add	a0,s0,-144
    4c04:	00001097          	auipc	ra,0x1
    4c08:	e66080e7          	jalr	-410(ra) # 5a6a <unlink>
      unlink(file);
    4c0c:	f7040513          	add	a0,s0,-144
    4c10:	00001097          	auipc	ra,0x1
    4c14:	e5a080e7          	jalr	-422(ra) # 5a6a <unlink>
      unlink(file);
    4c18:	f7040513          	add	a0,s0,-144
    4c1c:	00001097          	auipc	ra,0x1
    4c20:	e4e080e7          	jalr	-434(ra) # 5a6a <unlink>
      unlink(file);
    4c24:	f7040513          	add	a0,s0,-144
    4c28:	00001097          	auipc	ra,0x1
    4c2c:	e42080e7          	jalr	-446(ra) # 5a6a <unlink>
    4c30:	b779                	j	4bbe <concreate+0x254>
        printf("%s: concreate weird file %s\n", s, de.name);
    4c32:	f7a40613          	add	a2,s0,-134
    4c36:	85ce                	mv	a1,s3
    4c38:	00003517          	auipc	a0,0x3
    4c3c:	fd050513          	add	a0,a0,-48 # 7c08 <malloc+0x1dc4>
    4c40:	00001097          	auipc	ra,0x1
    4c44:	134080e7          	jalr	308(ra) # 5d74 <printf>
        exit(1);
    4c48:	4505                	li	a0,1
    4c4a:	00001097          	auipc	ra,0x1
    4c4e:	dd0080e7          	jalr	-560(ra) # 5a1a <exit>
      printf("%s: fork failed\n", s);
    4c52:	00002517          	auipc	a0,0x2
    4c56:	abe50513          	add	a0,a0,-1346 # 6710 <malloc+0x8cc>
    4c5a:	85ce                	mv	a1,s3
    4c5c:	00001097          	auipc	ra,0x1
    4c60:	118080e7          	jalr	280(ra) # 5d74 <printf>
      exit(1);
    4c64:	4505                	li	a0,1
    4c66:	00001097          	auipc	ra,0x1
    4c6a:	db4080e7          	jalr	-588(ra) # 5a1a <exit>
      close(fd);
    4c6e:	00001097          	auipc	ra,0x1
    4c72:	dd4080e7          	jalr	-556(ra) # 5a42 <close>
    if(pid == 0) {
    4c76:	b3ed                	j	4a60 <concreate+0xf6>
    printf("%s: concreate not enough files in directory listing\n", s);
    4c78:	00003517          	auipc	a0,0x3
    4c7c:	fd850513          	add	a0,a0,-40 # 7c50 <malloc+0x1e0c>
    4c80:	85ce                	mv	a1,s3
    4c82:	00001097          	auipc	ra,0x1
    4c86:	0f2080e7          	jalr	242(ra) # 5d74 <printf>
    exit(1);
    4c8a:	4505                	li	a0,1
    4c8c:	00001097          	auipc	ra,0x1
    4c90:	d8e080e7          	jalr	-626(ra) # 5a1a <exit>
        printf("%s: concreate duplicate file %s\n", s, de.name);
    4c94:	00003517          	auipc	a0,0x3
    4c98:	f9450513          	add	a0,a0,-108 # 7c28 <malloc+0x1de4>
    4c9c:	f7a40613          	add	a2,s0,-134
    4ca0:	85ce                	mv	a1,s3
    4ca2:	00001097          	auipc	ra,0x1
    4ca6:	0d2080e7          	jalr	210(ra) # 5d74 <printf>
        exit(1);
    4caa:	4505                	li	a0,1
    4cac:	00001097          	auipc	ra,0x1
    4cb0:	d6e080e7          	jalr	-658(ra) # 5a1a <exit>

0000000000004cb4 <bigfile>:
{
    4cb4:	7139                	add	sp,sp,-64
    4cb6:	f822                	sd	s0,48(sp)
    4cb8:	e852                	sd	s4,16(sp)
    4cba:	fc06                	sd	ra,56(sp)
    4cbc:	f426                	sd	s1,40(sp)
    4cbe:	f04a                	sd	s2,32(sp)
    4cc0:	ec4e                	sd	s3,24(sp)
    4cc2:	e456                	sd	s5,8(sp)
    4cc4:	0080                	add	s0,sp,64
    4cc6:	8a2a                	mv	s4,a0
  unlink("bigfile.dat");
    4cc8:	00003517          	auipc	a0,0x3
    4ccc:	fc050513          	add	a0,a0,-64 # 7c88 <malloc+0x1e44>
    4cd0:	00001097          	auipc	ra,0x1
    4cd4:	d9a080e7          	jalr	-614(ra) # 5a6a <unlink>
  fd = open("bigfile.dat", O_CREATE | O_RDWR);
    4cd8:	20200593          	li	a1,514
    4cdc:	00003517          	auipc	a0,0x3
    4ce0:	fac50513          	add	a0,a0,-84 # 7c88 <malloc+0x1e44>
    4ce4:	00001097          	auipc	ra,0x1
    4ce8:	d76080e7          	jalr	-650(ra) # 5a5a <open>
  if(fd < 0){
    4cec:	16054463          	bltz	a0,4e54 <bigfile+0x1a0>
    4cf0:	89aa                	mv	s3,a0
    4cf2:	4481                	li	s1,0
    4cf4:	00008917          	auipc	s2,0x8
    4cf8:	f8490913          	add	s2,s2,-124 # cc78 <buf>
    4cfc:	4ad1                	li	s5,20
    memset(buf, i, SZ);
    4cfe:	25800613          	li	a2,600
    4d02:	85a6                	mv	a1,s1
    4d04:	854a                	mv	a0,s2
    4d06:	00001097          	auipc	ra,0x1
    4d0a:	ac8080e7          	jalr	-1336(ra) # 57ce <memset>
    if(write(fd, buf, SZ) != SZ){
    4d0e:	25800613          	li	a2,600
    4d12:	85ca                	mv	a1,s2
    4d14:	854e                	mv	a0,s3
    4d16:	00001097          	auipc	ra,0x1
    4d1a:	d24080e7          	jalr	-732(ra) # 5a3a <write>
    4d1e:	25800793          	li	a5,600
    4d22:	0ef51d63          	bne	a0,a5,4e1c <bigfile+0x168>
  for(i = 0; i < N; i++){
    4d26:	2485                	addw	s1,s1,1
    4d28:	fd549be3          	bne	s1,s5,4cfe <bigfile+0x4a>
  close(fd);
    4d2c:	854e                	mv	a0,s3
    4d2e:	00001097          	auipc	ra,0x1
    4d32:	d14080e7          	jalr	-748(ra) # 5a42 <close>
  fd = open("bigfile.dat", 0);
    4d36:	4581                	li	a1,0
    4d38:	00003517          	auipc	a0,0x3
    4d3c:	f5050513          	add	a0,a0,-176 # 7c88 <malloc+0x1e44>
    4d40:	00001097          	auipc	ra,0x1
    4d44:	d1a080e7          	jalr	-742(ra) # 5a5a <open>
    4d48:	8aaa                	mv	s5,a0
  total = 0;
    4d4a:	4981                	li	s3,0
  for(i = 0; ; i++){
    4d4c:	4901                	li	s2,0
    cc = read(fd, buf, SZ/2);
    4d4e:	00008497          	auipc	s1,0x8
    4d52:	f2a48493          	add	s1,s1,-214 # cc78 <buf>
  if(fd < 0){
    4d56:	02055463          	bgez	a0,4d7e <bigfile+0xca>
    4d5a:	a8f9                	j	4e38 <bigfile+0x184>
    if(cc != SZ/2){
    4d5c:	12c00793          	li	a5,300
    4d60:	08f51263          	bne	a0,a5,4de4 <bigfile+0x130>
    if(buf[0] != i/2 || buf[SZ/2-1] != i/2){
    4d64:	0004c783          	lbu	a5,0(s1)
    4d68:	40195713          	sra	a4,s2,0x1
    4d6c:	04e79e63          	bne	a5,a4,4dc8 <bigfile+0x114>
    4d70:	12b4c703          	lbu	a4,299(s1)
    4d74:	04f71a63          	bne	a4,a5,4dc8 <bigfile+0x114>
    total += cc;
    4d78:	12c9899b          	addw	s3,s3,300
  for(i = 0; ; i++){
    4d7c:	2905                	addw	s2,s2,1
    cc = read(fd, buf, SZ/2);
    4d7e:	12c00613          	li	a2,300
    4d82:	85a6                	mv	a1,s1
    4d84:	8556                	mv	a0,s5
    4d86:	00001097          	auipc	ra,0x1
    4d8a:	cac080e7          	jalr	-852(ra) # 5a32 <read>
    if(cc < 0){
    4d8e:	06054963          	bltz	a0,4e00 <bigfile+0x14c>
    if(cc == 0)
    4d92:	f569                	bnez	a0,4d5c <bigfile+0xa8>
  close(fd);
    4d94:	8556                	mv	a0,s5
    4d96:	00001097          	auipc	ra,0x1
    4d9a:	cac080e7          	jalr	-852(ra) # 5a42 <close>
  if(total != N*SZ){
    4d9e:	678d                	lui	a5,0x3
    4da0:	ee078793          	add	a5,a5,-288 # 2ee0 <diskfull+0x162>
    4da4:	0cf99663          	bne	s3,a5,4e70 <bigfile+0x1bc>
}
    4da8:	7442                	ld	s0,48(sp)
    4daa:	70e2                	ld	ra,56(sp)
    4dac:	74a2                	ld	s1,40(sp)
    4dae:	7902                	ld	s2,32(sp)
    4db0:	69e2                	ld	s3,24(sp)
    4db2:	6a42                	ld	s4,16(sp)
    4db4:	6aa2                	ld	s5,8(sp)
  unlink("bigfile.dat");
    4db6:	00003517          	auipc	a0,0x3
    4dba:	ed250513          	add	a0,a0,-302 # 7c88 <malloc+0x1e44>
}
    4dbe:	6121                	add	sp,sp,64
  unlink("bigfile.dat");
    4dc0:	00001317          	auipc	t1,0x1
    4dc4:	caa30067          	jr	-854(t1) # 5a6a <unlink>
      printf("%s: read bigfile wrong data\n", s);
    4dc8:	00003517          	auipc	a0,0x3
    4dcc:	f6850513          	add	a0,a0,-152 # 7d30 <malloc+0x1eec>
    4dd0:	85d2                	mv	a1,s4
    4dd2:	00001097          	auipc	ra,0x1
    4dd6:	fa2080e7          	jalr	-94(ra) # 5d74 <printf>
      exit(1);
    4dda:	4505                	li	a0,1
    4ddc:	00001097          	auipc	ra,0x1
    4de0:	c3e080e7          	jalr	-962(ra) # 5a1a <exit>
      printf("%s: short read bigfile\n", s);
    4de4:	00003517          	auipc	a0,0x3
    4de8:	f3450513          	add	a0,a0,-204 # 7d18 <malloc+0x1ed4>
    4dec:	85d2                	mv	a1,s4
    4dee:	00001097          	auipc	ra,0x1
    4df2:	f86080e7          	jalr	-122(ra) # 5d74 <printf>
      exit(1);
    4df6:	4505                	li	a0,1
    4df8:	00001097          	auipc	ra,0x1
    4dfc:	c22080e7          	jalr	-990(ra) # 5a1a <exit>
      printf("%s: read bigfile failed\n", s);
    4e00:	00003517          	auipc	a0,0x3
    4e04:	ef850513          	add	a0,a0,-264 # 7cf8 <malloc+0x1eb4>
    4e08:	85d2                	mv	a1,s4
    4e0a:	00001097          	auipc	ra,0x1
    4e0e:	f6a080e7          	jalr	-150(ra) # 5d74 <printf>
      exit(1);
    4e12:	4505                	li	a0,1
    4e14:	00001097          	auipc	ra,0x1
    4e18:	c06080e7          	jalr	-1018(ra) # 5a1a <exit>
      printf("%s: write bigfile failed\n", s);
    4e1c:	00003517          	auipc	a0,0x3
    4e20:	e9c50513          	add	a0,a0,-356 # 7cb8 <malloc+0x1e74>
    4e24:	85d2                	mv	a1,s4
    4e26:	00001097          	auipc	ra,0x1
    4e2a:	f4e080e7          	jalr	-178(ra) # 5d74 <printf>
      exit(1);
    4e2e:	4505                	li	a0,1
    4e30:	00001097          	auipc	ra,0x1
    4e34:	bea080e7          	jalr	-1046(ra) # 5a1a <exit>
    printf("%s: cannot open bigfile\n", s);
    4e38:	00003517          	auipc	a0,0x3
    4e3c:	ea050513          	add	a0,a0,-352 # 7cd8 <malloc+0x1e94>
    4e40:	85d2                	mv	a1,s4
    4e42:	00001097          	auipc	ra,0x1
    4e46:	f32080e7          	jalr	-206(ra) # 5d74 <printf>
    exit(1);
    4e4a:	4505                	li	a0,1
    4e4c:	00001097          	auipc	ra,0x1
    4e50:	bce080e7          	jalr	-1074(ra) # 5a1a <exit>
    printf("%s: cannot create bigfile", s);
    4e54:	00003517          	auipc	a0,0x3
    4e58:	e4450513          	add	a0,a0,-444 # 7c98 <malloc+0x1e54>
    4e5c:	85d2                	mv	a1,s4
    4e5e:	00001097          	auipc	ra,0x1
    4e62:	f16080e7          	jalr	-234(ra) # 5d74 <printf>
    exit(1);
    4e66:	4505                	li	a0,1
    4e68:	00001097          	auipc	ra,0x1
    4e6c:	bb2080e7          	jalr	-1102(ra) # 5a1a <exit>
    printf("%s: read bigfile wrong total\n", s);
    4e70:	00003517          	auipc	a0,0x3
    4e74:	ee050513          	add	a0,a0,-288 # 7d50 <malloc+0x1f0c>
    4e78:	85d2                	mv	a1,s4
    4e7a:	00001097          	auipc	ra,0x1
    4e7e:	efa080e7          	jalr	-262(ra) # 5d74 <printf>
    exit(1);
    4e82:	4505                	li	a0,1
    4e84:	00001097          	auipc	ra,0x1
    4e88:	b96080e7          	jalr	-1130(ra) # 5a1a <exit>

0000000000004e8c <bsstest>:
  for(i = 0; i < sizeof(uninit); i++){
    4e8c:	00005797          	auipc	a5,0x5
    4e90:	6dc78793          	add	a5,a5,1756 # a568 <uninit>
    4e94:	00008697          	auipc	a3,0x8
    4e98:	de468693          	add	a3,a3,-540 # cc78 <buf>
    if(uninit[i] != '\0'){
    4e9c:	0007c703          	lbu	a4,0(a5)
    4ea0:	e709                	bnez	a4,4eaa <bsstest+0x1e>
  for(i = 0; i < sizeof(uninit); i++){
    4ea2:	0785                	add	a5,a5,1
    4ea4:	fed79ce3          	bne	a5,a3,4e9c <bsstest+0x10>
    4ea8:	8082                	ret
{
    4eaa:	1141                	add	sp,sp,-16
    4eac:	e022                	sd	s0,0(sp)
    4eae:	e406                	sd	ra,8(sp)
    4eb0:	0800                	add	s0,sp,16
      printf("%s: bss test failed\n", s);
    4eb2:	85aa                	mv	a1,a0
    4eb4:	00003517          	auipc	a0,0x3
    4eb8:	ebc50513          	add	a0,a0,-324 # 7d70 <malloc+0x1f2c>
    4ebc:	00001097          	auipc	ra,0x1
    4ec0:	eb8080e7          	jalr	-328(ra) # 5d74 <printf>
      exit(1);
    4ec4:	4505                	li	a0,1
    4ec6:	00001097          	auipc	ra,0x1
    4eca:	b54080e7          	jalr	-1196(ra) # 5a1a <exit>

0000000000004ece <opentest>:
{
    4ece:	1101                	add	sp,sp,-32
    4ed0:	e822                	sd	s0,16(sp)
    4ed2:	e426                	sd	s1,8(sp)
    4ed4:	ec06                	sd	ra,24(sp)
    4ed6:	1000                	add	s0,sp,32
    4ed8:	84aa                	mv	s1,a0
  fd = open("echo", 0);
    4eda:	4581                	li	a1,0
    4edc:	00001517          	auipc	a0,0x1
    4ee0:	74c50513          	add	a0,a0,1868 # 6628 <malloc+0x7e4>
    4ee4:	00001097          	auipc	ra,0x1
    4ee8:	b76080e7          	jalr	-1162(ra) # 5a5a <open>
  if(fd < 0){
    4eec:	02054663          	bltz	a0,4f18 <opentest+0x4a>
  close(fd);
    4ef0:	00001097          	auipc	ra,0x1
    4ef4:	b52080e7          	jalr	-1198(ra) # 5a42 <close>
  fd = open("doesnotexist", 0);
    4ef8:	4581                	li	a1,0
    4efa:	00003517          	auipc	a0,0x3
    4efe:	ea650513          	add	a0,a0,-346 # 7da0 <malloc+0x1f5c>
    4f02:	00001097          	auipc	ra,0x1
    4f06:	b58080e7          	jalr	-1192(ra) # 5a5a <open>
  if(fd >= 0){
    4f0a:	02055563          	bgez	a0,4f34 <opentest+0x66>
}
    4f0e:	60e2                	ld	ra,24(sp)
    4f10:	6442                	ld	s0,16(sp)
    4f12:	64a2                	ld	s1,8(sp)
    4f14:	6105                	add	sp,sp,32
    4f16:	8082                	ret
    printf("%s: open echo failed!\n", s);
    4f18:	00003517          	auipc	a0,0x3
    4f1c:	e7050513          	add	a0,a0,-400 # 7d88 <malloc+0x1f44>
    4f20:	85a6                	mv	a1,s1
    4f22:	00001097          	auipc	ra,0x1
    4f26:	e52080e7          	jalr	-430(ra) # 5d74 <printf>
    exit(1);
    4f2a:	4505                	li	a0,1
    4f2c:	00001097          	auipc	ra,0x1
    4f30:	aee080e7          	jalr	-1298(ra) # 5a1a <exit>
    printf("%s: open doesnotexist succeeded!\n", s);
    4f34:	00003517          	auipc	a0,0x3
    4f38:	e7c50513          	add	a0,a0,-388 # 7db0 <malloc+0x1f6c>
    4f3c:	85a6                	mv	a1,s1
    4f3e:	00001097          	auipc	ra,0x1
    4f42:	e36080e7          	jalr	-458(ra) # 5d74 <printf>
    exit(1);
    4f46:	4505                	li	a0,1
    4f48:	00001097          	auipc	ra,0x1
    4f4c:	ad2080e7          	jalr	-1326(ra) # 5a1a <exit>

0000000000004f50 <validatetest>:
{
    4f50:	7139                	add	sp,sp,-64
    4f52:	f822                	sd	s0,48(sp)
    4f54:	f426                	sd	s1,40(sp)
    4f56:	f04a                	sd	s2,32(sp)
    4f58:	ec4e                	sd	s3,24(sp)
    4f5a:	e852                	sd	s4,16(sp)
    4f5c:	e456                	sd	s5,8(sp)
    4f5e:	e05a                	sd	s6,0(sp)
    4f60:	fc06                	sd	ra,56(sp)
    4f62:	0080                	add	s0,sp,64
    4f64:	8b2a                	mv	s6,a0
  for(p = 0; p <= (uint)hi; p += PGSIZE){
    4f66:	4481                	li	s1,0
    if(link("nosuchfile", (char*)p) != -1){
    4f68:	00003997          	auipc	s3,0x3
    4f6c:	e7098993          	add	s3,s3,-400 # 7dd8 <malloc+0x1f94>
    4f70:	597d                	li	s2,-1
  for(p = 0; p <= (uint)hi; p += PGSIZE){
    4f72:	6a85                	lui	s5,0x1
    4f74:	00114a37          	lui	s4,0x114
    if(link("nosuchfile", (char*)p) != -1){
    4f78:	85a6                	mv	a1,s1
    4f7a:	854e                	mv	a0,s3
    4f7c:	00001097          	auipc	ra,0x1
    4f80:	afe080e7          	jalr	-1282(ra) # 5a7a <link>
    4f84:	01251f63          	bne	a0,s2,4fa2 <validatetest+0x52>
  for(p = 0; p <= (uint)hi; p += PGSIZE){
    4f88:	94d6                	add	s1,s1,s5
    4f8a:	ff4497e3          	bne	s1,s4,4f78 <validatetest+0x28>
}
    4f8e:	70e2                	ld	ra,56(sp)
    4f90:	7442                	ld	s0,48(sp)
    4f92:	74a2                	ld	s1,40(sp)
    4f94:	7902                	ld	s2,32(sp)
    4f96:	69e2                	ld	s3,24(sp)
    4f98:	6a42                	ld	s4,16(sp)
    4f9a:	6aa2                	ld	s5,8(sp)
    4f9c:	6b02                	ld	s6,0(sp)
    4f9e:	6121                	add	sp,sp,64
    4fa0:	8082                	ret
      printf("%s: link should not succeed\n", s);
    4fa2:	00003517          	auipc	a0,0x3
    4fa6:	e4650513          	add	a0,a0,-442 # 7de8 <malloc+0x1fa4>
    4faa:	85da                	mv	a1,s6
    4fac:	00001097          	auipc	ra,0x1
    4fb0:	dc8080e7          	jalr	-568(ra) # 5d74 <printf>
      exit(1);
    4fb4:	4505                	li	a0,1
    4fb6:	00001097          	auipc	ra,0x1
    4fba:	a64080e7          	jalr	-1436(ra) # 5a1a <exit>

0000000000004fbe <bigdir>:
{
    4fbe:	715d                	add	sp,sp,-80
    4fc0:	e0a2                	sd	s0,64(sp)
    4fc2:	ec56                	sd	s5,24(sp)
    4fc4:	e486                	sd	ra,72(sp)
    4fc6:	fc26                	sd	s1,56(sp)
    4fc8:	f84a                	sd	s2,48(sp)
    4fca:	f44e                	sd	s3,40(sp)
    4fcc:	f052                	sd	s4,32(sp)
    4fce:	e85a                	sd	s6,16(sp)
    4fd0:	0880                	add	s0,sp,80
    4fd2:	8aaa                	mv	s5,a0
  unlink("bd");
    4fd4:	00003517          	auipc	a0,0x3
    4fd8:	e3450513          	add	a0,a0,-460 # 7e08 <malloc+0x1fc4>
    4fdc:	00001097          	auipc	ra,0x1
    4fe0:	a8e080e7          	jalr	-1394(ra) # 5a6a <unlink>
  fd = open("bd", O_CREATE);
    4fe4:	20000593          	li	a1,512
    4fe8:	00003517          	auipc	a0,0x3
    4fec:	e2050513          	add	a0,a0,-480 # 7e08 <malloc+0x1fc4>
    4ff0:	00001097          	auipc	ra,0x1
    4ff4:	a6a080e7          	jalr	-1430(ra) # 5a5a <open>
  if(fd < 0){
    4ff8:	0e054963          	bltz	a0,50ea <bigdir+0x12c>
  close(fd);
    4ffc:	00001097          	auipc	ra,0x1
    5000:	a46080e7          	jalr	-1466(ra) # 5a42 <close>
  for(i = 0; i < N; i++){
    5004:	4b01                	li	s6,0
    name[0] = 'x';
    5006:	07800993          	li	s3,120
    if(link("bd", name) != 0){
    500a:	00003917          	auipc	s2,0x3
    500e:	dfe90913          	add	s2,s2,-514 # 7e08 <malloc+0x1fc4>
  for(i = 0; i < N; i++){
    5012:	1f400a13          	li	s4,500
    name[1] = '0' + (i / 64);
    5016:	406b571b          	sraw	a4,s6,0x6
    name[2] = '0' + (i % 64);
    501a:	03fb7793          	and	a5,s6,63
    name[1] = '0' + (i / 64);
    501e:	0307071b          	addw	a4,a4,48 # 3e800030 <base+0x3e7f03b8>
    name[2] = '0' + (i % 64);
    5022:	0307879b          	addw	a5,a5,48
    if(link("bd", name) != 0){
    5026:	fb040593          	add	a1,s0,-80
    502a:	854a                	mv	a0,s2
    name[0] = 'x';
    502c:	fb340823          	sb	s3,-80(s0)
    name[1] = '0' + (i / 64);
    5030:	fae408a3          	sb	a4,-79(s0)
    name[2] = '0' + (i % 64);
    5034:	faf40923          	sb	a5,-78(s0)
    name[3] = '\0';
    5038:	fa0409a3          	sb	zero,-77(s0)
    if(link("bd", name) != 0){
    503c:	00001097          	auipc	ra,0x1
    5040:	a3e080e7          	jalr	-1474(ra) # 5a7a <link>
    5044:	84aa                	mv	s1,a0
    5046:	e525                	bnez	a0,50ae <bigdir+0xf0>
  for(i = 0; i < N; i++){
    5048:	2b05                	addw	s6,s6,1
    504a:	fd4b16e3          	bne	s6,s4,5016 <bigdir+0x58>
  unlink("bd");
    504e:	00003517          	auipc	a0,0x3
    5052:	dba50513          	add	a0,a0,-582 # 7e08 <malloc+0x1fc4>
    5056:	00001097          	auipc	ra,0x1
    505a:	a14080e7          	jalr	-1516(ra) # 5a6a <unlink>
    name[0] = 'x';
    505e:	07800913          	li	s2,120
  for(i = 0; i < N; i++){
    5062:	1f400993          	li	s3,500
    name[1] = '0' + (i / 64);
    5066:	4064d71b          	sraw	a4,s1,0x6
    name[2] = '0' + (i % 64);
    506a:	03f4f793          	and	a5,s1,63
    name[1] = '0' + (i / 64);
    506e:	0307071b          	addw	a4,a4,48
    name[2] = '0' + (i % 64);
    5072:	0307879b          	addw	a5,a5,48
    if(unlink(name) != 0){
    5076:	fb040513          	add	a0,s0,-80
    name[0] = 'x';
    507a:	fb240823          	sb	s2,-80(s0)
    name[1] = '0' + (i / 64);
    507e:	fae408a3          	sb	a4,-79(s0)
    name[2] = '0' + (i % 64);
    5082:	faf40923          	sb	a5,-78(s0)
    name[3] = '\0';
    5086:	fa0409a3          	sb	zero,-77(s0)
    if(unlink(name) != 0){
    508a:	00001097          	auipc	ra,0x1
    508e:	9e0080e7          	jalr	-1568(ra) # 5a6a <unlink>
    5092:	ed15                	bnez	a0,50ce <bigdir+0x110>
  for(i = 0; i < N; i++){
    5094:	2485                	addw	s1,s1,1
    5096:	fd3498e3          	bne	s1,s3,5066 <bigdir+0xa8>
}
    509a:	60a6                	ld	ra,72(sp)
    509c:	6406                	ld	s0,64(sp)
    509e:	74e2                	ld	s1,56(sp)
    50a0:	7942                	ld	s2,48(sp)
    50a2:	79a2                	ld	s3,40(sp)
    50a4:	7a02                	ld	s4,32(sp)
    50a6:	6ae2                	ld	s5,24(sp)
    50a8:	6b42                	ld	s6,16(sp)
    50aa:	6161                	add	sp,sp,80
    50ac:	8082                	ret
      printf("%s: bigdir link(bd, %s) failed\n", s, name);
    50ae:	00003517          	auipc	a0,0x3
    50b2:	d8250513          	add	a0,a0,-638 # 7e30 <malloc+0x1fec>
    50b6:	fb040613          	add	a2,s0,-80
    50ba:	85d6                	mv	a1,s5
    50bc:	00001097          	auipc	ra,0x1
    50c0:	cb8080e7          	jalr	-840(ra) # 5d74 <printf>
      exit(1);
    50c4:	4505                	li	a0,1
    50c6:	00001097          	auipc	ra,0x1
    50ca:	954080e7          	jalr	-1708(ra) # 5a1a <exit>
      printf("%s: bigdir unlink failed", s);
    50ce:	00003517          	auipc	a0,0x3
    50d2:	d8250513          	add	a0,a0,-638 # 7e50 <malloc+0x200c>
    50d6:	85d6                	mv	a1,s5
    50d8:	00001097          	auipc	ra,0x1
    50dc:	c9c080e7          	jalr	-868(ra) # 5d74 <printf>
      exit(1);
    50e0:	4505                	li	a0,1
    50e2:	00001097          	auipc	ra,0x1
    50e6:	938080e7          	jalr	-1736(ra) # 5a1a <exit>
    printf("%s: bigdir create failed\n", s);
    50ea:	00003517          	auipc	a0,0x3
    50ee:	d2650513          	add	a0,a0,-730 # 7e10 <malloc+0x1fcc>
    50f2:	85d6                	mv	a1,s5
    50f4:	00001097          	auipc	ra,0x1
    50f8:	c80080e7          	jalr	-896(ra) # 5d74 <printf>
    exit(1);
    50fc:	4505                	li	a0,1
    50fe:	00001097          	auipc	ra,0x1
    5102:	91c080e7          	jalr	-1764(ra) # 5a1a <exit>

0000000000005106 <argptest>:
{
    5106:	1101                	add	sp,sp,-32
    5108:	e822                	sd	s0,16(sp)
    510a:	e04a                	sd	s2,0(sp)
    510c:	ec06                	sd	ra,24(sp)
    510e:	e426                	sd	s1,8(sp)
    5110:	1000                	add	s0,sp,32
    5112:	892a                	mv	s2,a0
  fd = open("init", O_RDONLY);
    5114:	4581                	li	a1,0
    5116:	00003517          	auipc	a0,0x3
    511a:	d5a50513          	add	a0,a0,-678 # 7e70 <malloc+0x202c>
    511e:	00001097          	auipc	ra,0x1
    5122:	93c080e7          	jalr	-1732(ra) # 5a5a <open>
  if (fd < 0) {
    5126:	02054a63          	bltz	a0,515a <argptest+0x54>
  read(fd, sbrk(0) - 1, -1);
    512a:	84aa                	mv	s1,a0
    512c:	4501                	li	a0,0
    512e:	00001097          	auipc	ra,0x1
    5132:	974080e7          	jalr	-1676(ra) # 5aa2 <sbrk>
    5136:	fff50593          	add	a1,a0,-1
    513a:	567d                	li	a2,-1
    513c:	8526                	mv	a0,s1
    513e:	00001097          	auipc	ra,0x1
    5142:	8f4080e7          	jalr	-1804(ra) # 5a32 <read>
}
    5146:	6442                	ld	s0,16(sp)
    5148:	60e2                	ld	ra,24(sp)
    514a:	6902                	ld	s2,0(sp)
  close(fd);
    514c:	8526                	mv	a0,s1
}
    514e:	64a2                	ld	s1,8(sp)
    5150:	6105                	add	sp,sp,32
  close(fd);
    5152:	00001317          	auipc	t1,0x1
    5156:	8f030067          	jr	-1808(t1) # 5a42 <close>
    printf("%s: open failed\n", s);
    515a:	00001517          	auipc	a0,0x1
    515e:	5ce50513          	add	a0,a0,1486 # 6728 <malloc+0x8e4>
    5162:	85ca                	mv	a1,s2
    5164:	00001097          	auipc	ra,0x1
    5168:	c10080e7          	jalr	-1008(ra) # 5d74 <printf>
    exit(1);
    516c:	4505                	li	a0,1
    516e:	00001097          	auipc	ra,0x1
    5172:	8ac080e7          	jalr	-1876(ra) # 5a1a <exit>

0000000000005176 <fsfull>:
{
    5176:	7135                	add	sp,sp,-160
    5178:	e922                	sd	s0,144(sp)
    517a:	fcce                	sd	s3,120(sp)
    517c:	f8d2                	sd	s4,112(sp)
    517e:	f4d6                	sd	s5,104(sp)
    5180:	f0da                	sd	s6,96(sp)
    5182:	ecde                	sd	s7,88(sp)
    5184:	e8e2                	sd	s8,80(sp)
    5186:	e4e6                	sd	s9,72(sp)
    5188:	e0ea                	sd	s10,64(sp)
    518a:	ed06                	sd	ra,152(sp)
    518c:	e526                	sd	s1,136(sp)
    518e:	e14a                	sd	s2,128(sp)
    5190:	1100                	add	s0,sp,160
  printf("fsfull test\n");
    5192:	00003517          	auipc	a0,0x3
    5196:	ce650513          	add	a0,a0,-794 # 7e78 <malloc+0x2034>
    519a:	00001097          	auipc	ra,0x1
    519e:	bda080e7          	jalr	-1062(ra) # 5d74 <printf>
  for(nfiles = 0; ; nfiles++){
    51a2:	4981                	li	s3,0
    name[0] = 'f';
    51a4:	06600d13          	li	s10,102
    name[1] = '0' + nfiles / 1000;
    51a8:	3e800c13          	li	s8,1000
    name[2] = '0' + (nfiles % 1000) / 100;
    51ac:	06400b93          	li	s7,100
    name[3] = '0' + (nfiles % 100) / 10;
    51b0:	4b29                	li	s6,10
    printf("writing %s\n", name);
    51b2:	00003c97          	auipc	s9,0x3
    51b6:	cd6c8c93          	add	s9,s9,-810 # 7e88 <malloc+0x2044>
      int cc = write(fd, buf, BSIZE);
    51ba:	00008a97          	auipc	s5,0x8
    51be:	abea8a93          	add	s5,s5,-1346 # cc78 <buf>
      if(cc < BSIZE)
    51c2:	3ff00a13          	li	s4,1023
    name[2] = '0' + (nfiles % 1000) / 100;
    51c6:	0389e7bb          	remw	a5,s3,s8
    printf("writing %s\n", name);
    51ca:	f6040593          	add	a1,s0,-160
    51ce:	8566                	mv	a0,s9
    name[0] = 'f';
    51d0:	f7a40023          	sb	s10,-160(s0)
    name[5] = '\0';
    51d4:	f60402a3          	sb	zero,-155(s0)
    name[2] = '0' + (nfiles % 1000) / 100;
    51d8:	0377c7bb          	divw	a5,a5,s7
    name[3] = '0' + (nfiles % 100) / 10;
    51dc:	0379e73b          	remw	a4,s3,s7
    name[2] = '0' + (nfiles % 1000) / 100;
    51e0:	0307879b          	addw	a5,a5,48
    51e4:	f6f40123          	sb	a5,-158(s0)
    name[1] = '0' + nfiles / 1000;
    51e8:	0389c6bb          	divw	a3,s3,s8
    name[3] = '0' + (nfiles % 100) / 10;
    51ec:	0367473b          	divw	a4,a4,s6
    name[1] = '0' + nfiles / 1000;
    51f0:	0306869b          	addw	a3,a3,48
    51f4:	f6d400a3          	sb	a3,-159(s0)
    name[4] = '0' + (nfiles % 10);
    51f8:	0369e7bb          	remw	a5,s3,s6
    name[3] = '0' + (nfiles % 100) / 10;
    51fc:	0307071b          	addw	a4,a4,48
    5200:	f6e401a3          	sb	a4,-157(s0)
    name[4] = '0' + (nfiles % 10);
    5204:	0307879b          	addw	a5,a5,48
    5208:	f6f40223          	sb	a5,-156(s0)
    printf("writing %s\n", name);
    520c:	00001097          	auipc	ra,0x1
    5210:	b68080e7          	jalr	-1176(ra) # 5d74 <printf>
    int fd = open(name, O_CREATE|O_RDWR);
    5214:	20200593          	li	a1,514
    5218:	f6040513          	add	a0,s0,-160
    521c:	00001097          	auipc	ra,0x1
    5220:	83e080e7          	jalr	-1986(ra) # 5a5a <open>
    5224:	892a                	mv	s2,a0
    if(fd < 0){
    5226:	04054263          	bltz	a0,526a <fsfull+0xf4>
    int total = 0;
    522a:	4481                	li	s1,0
    522c:	a011                	j	5230 <fsfull+0xba>
      total += cc;
    522e:	9ca9                	addw	s1,s1,a0
      int cc = write(fd, buf, BSIZE);
    5230:	40000613          	li	a2,1024
    5234:	85d6                	mv	a1,s5
    5236:	854a                	mv	a0,s2
    5238:	00001097          	auipc	ra,0x1
    523c:	802080e7          	jalr	-2046(ra) # 5a3a <write>
      if(cc < BSIZE)
    5240:	0005079b          	sext.w	a5,a0
    5244:	fefa65e3          	bltu	s4,a5,522e <fsfull+0xb8>
    printf("wrote %d bytes\n", total);
    5248:	00003517          	auipc	a0,0x3
    524c:	c6050513          	add	a0,a0,-928 # 7ea8 <malloc+0x2064>
    5250:	85a6                	mv	a1,s1
    5252:	00001097          	auipc	ra,0x1
    5256:	b22080e7          	jalr	-1246(ra) # 5d74 <printf>
    close(fd);
    525a:	854a                	mv	a0,s2
    525c:	00000097          	auipc	ra,0x0
    5260:	7e6080e7          	jalr	2022(ra) # 5a42 <close>
    if(total == 0)
    5264:	cc89                	beqz	s1,527e <fsfull+0x108>
  for(nfiles = 0; ; nfiles++){
    5266:	2985                	addw	s3,s3,1
    5268:	bfb9                	j	51c6 <fsfull+0x50>
      printf("open %s failed\n", name);
    526a:	f6040593          	add	a1,s0,-160
    526e:	00003517          	auipc	a0,0x3
    5272:	c2a50513          	add	a0,a0,-982 # 7e98 <malloc+0x2054>
    5276:	00001097          	auipc	ra,0x1
    527a:	afe080e7          	jalr	-1282(ra) # 5d74 <printf>
    name[0] = 'f';
    527e:	06600913          	li	s2,102
    name[1] = '0' + nfiles / 1000;
    5282:	3e800b13          	li	s6,1000
    name[2] = '0' + (nfiles % 1000) / 100;
    5286:	06400a93          	li	s5,100
    name[3] = '0' + (nfiles % 100) / 10;
    528a:	4a29                	li	s4,10
  while(nfiles >= 0){
    528c:	54fd                	li	s1,-1
    name[2] = '0' + (nfiles % 1000) / 100;
    528e:	0369e73b          	remw	a4,s3,s6
    unlink(name);
    5292:	f6040513          	add	a0,s0,-160
    name[0] = 'f';
    5296:	f7240023          	sb	s2,-160(s0)
    name[5] = '\0';
    529a:	f60402a3          	sb	zero,-155(s0)
    name[3] = '0' + (nfiles % 100) / 10;
    529e:	0359e7bb          	remw	a5,s3,s5
    name[2] = '0' + (nfiles % 1000) / 100;
    52a2:	0357473b          	divw	a4,a4,s5
    name[3] = '0' + (nfiles % 100) / 10;
    52a6:	0347c7bb          	divw	a5,a5,s4
    name[2] = '0' + (nfiles % 1000) / 100;
    52aa:	0307071b          	addw	a4,a4,48
    52ae:	f6e40123          	sb	a4,-158(s0)
    name[1] = '0' + nfiles / 1000;
    52b2:	0369c6bb          	divw	a3,s3,s6
    name[3] = '0' + (nfiles % 100) / 10;
    52b6:	0307879b          	addw	a5,a5,48
    52ba:	f6f401a3          	sb	a5,-157(s0)
    name[4] = '0' + (nfiles % 10);
    52be:	0349e73b          	remw	a4,s3,s4
    name[1] = '0' + nfiles / 1000;
    52c2:	0306869b          	addw	a3,a3,48
    nfiles--;
    52c6:	39fd                	addw	s3,s3,-1
    name[1] = '0' + nfiles / 1000;
    52c8:	f6d400a3          	sb	a3,-159(s0)
    name[4] = '0' + (nfiles % 10);
    52cc:	0307079b          	addw	a5,a4,48
    52d0:	f6f40223          	sb	a5,-156(s0)
    unlink(name);
    52d4:	00000097          	auipc	ra,0x0
    52d8:	796080e7          	jalr	1942(ra) # 5a6a <unlink>
  while(nfiles >= 0){
    52dc:	fa9999e3          	bne	s3,s1,528e <fsfull+0x118>
}
    52e0:	644a                	ld	s0,144(sp)
    52e2:	60ea                	ld	ra,152(sp)
    52e4:	64aa                	ld	s1,136(sp)
    52e6:	690a                	ld	s2,128(sp)
    52e8:	79e6                	ld	s3,120(sp)
    52ea:	7a46                	ld	s4,112(sp)
    52ec:	7aa6                	ld	s5,104(sp)
    52ee:	7b06                	ld	s6,96(sp)
    52f0:	6be6                	ld	s7,88(sp)
    52f2:	6c46                	ld	s8,80(sp)
    52f4:	6ca6                	ld	s9,72(sp)
    52f6:	6d06                	ld	s10,64(sp)
  printf("fsfull test finished\n");
    52f8:	00003517          	auipc	a0,0x3
    52fc:	bc050513          	add	a0,a0,-1088 # 7eb8 <malloc+0x2074>
}
    5300:	610d                	add	sp,sp,160
  printf("fsfull test finished\n");
    5302:	00001317          	auipc	t1,0x1
    5306:	a7230067          	jr	-1422(t1) # 5d74 <printf>

000000000000530a <run>:
//

// run each test in its own process. run returns 1 if child's exit()
// indicates success.
int
run(void f(char *), char *s) {
    530a:	7179                	add	sp,sp,-48
    530c:	f406                	sd	ra,40(sp)
    530e:	f022                	sd	s0,32(sp)
    5310:	ec26                	sd	s1,24(sp)
    5312:	e84a                	sd	s2,16(sp)
    5314:	1800                	add	s0,sp,48
    5316:	84aa                	mv	s1,a0
  int pid;
  int xstatus;

  printf("test %s: ", s);
    5318:	00003517          	auipc	a0,0x3
    531c:	bb850513          	add	a0,a0,-1096 # 7ed0 <malloc+0x208c>
run(void f(char *), char *s) {
    5320:	892e                	mv	s2,a1
  printf("test %s: ", s);
    5322:	00001097          	auipc	ra,0x1
    5326:	a52080e7          	jalr	-1454(ra) # 5d74 <printf>
  if((pid = fork()) < 0) {
    532a:	00000097          	auipc	ra,0x0
    532e:	6e8080e7          	jalr	1768(ra) # 5a12 <fork>
    5332:	06054763          	bltz	a0,53a0 <run+0x96>
    printf("runtest: fork error\n");
    exit(1);
  }
  if(pid == 0) {
    5336:	cd31                	beqz	a0,5392 <run+0x88>
    f(s);
    exit(0);
  } else {
    wait(&xstatus);
    5338:	fdc40513          	add	a0,s0,-36
    533c:	00000097          	auipc	ra,0x0
    5340:	6e6080e7          	jalr	1766(ra) # 5a22 <wait>
    if(xstatus != 0) 
    5344:	fdc42783          	lw	a5,-36(s0)
    5348:	e39d                	bnez	a5,536e <run+0x64>
      printf("FAILED\n");
    else
      printf("OK\n");
    534a:	00003517          	auipc	a0,0x3
    534e:	bb650513          	add	a0,a0,-1098 # 7f00 <malloc+0x20bc>
    5352:	00001097          	auipc	ra,0x1
    5356:	a22080e7          	jalr	-1502(ra) # 5d74 <printf>
    return xstatus == 0;
    535a:	fdc42503          	lw	a0,-36(s0)
  }
}
    535e:	70a2                	ld	ra,40(sp)
    5360:	7402                	ld	s0,32(sp)
    5362:	64e2                	ld	s1,24(sp)
    5364:	6942                	ld	s2,16(sp)
    5366:	00153513          	seqz	a0,a0
    536a:	6145                	add	sp,sp,48
    536c:	8082                	ret
      printf("FAILED\n");
    536e:	00003517          	auipc	a0,0x3
    5372:	b8a50513          	add	a0,a0,-1142 # 7ef8 <malloc+0x20b4>
    5376:	00001097          	auipc	ra,0x1
    537a:	9fe080e7          	jalr	-1538(ra) # 5d74 <printf>
    return xstatus == 0;
    537e:	fdc42503          	lw	a0,-36(s0)
}
    5382:	70a2                	ld	ra,40(sp)
    5384:	7402                	ld	s0,32(sp)
    5386:	64e2                	ld	s1,24(sp)
    5388:	6942                	ld	s2,16(sp)
    538a:	00153513          	seqz	a0,a0
    538e:	6145                	add	sp,sp,48
    5390:	8082                	ret
    f(s);
    5392:	854a                	mv	a0,s2
    5394:	9482                	jalr	s1
    exit(0);
    5396:	4501                	li	a0,0
    5398:	00000097          	auipc	ra,0x0
    539c:	682080e7          	jalr	1666(ra) # 5a1a <exit>
    printf("runtest: fork error\n");
    53a0:	00003517          	auipc	a0,0x3
    53a4:	b4050513          	add	a0,a0,-1216 # 7ee0 <malloc+0x209c>
    53a8:	00001097          	auipc	ra,0x1
    53ac:	9cc080e7          	jalr	-1588(ra) # 5d74 <printf>
    exit(1);
    53b0:	4505                	li	a0,1
    53b2:	00000097          	auipc	ra,0x0
    53b6:	668080e7          	jalr	1640(ra) # 5a1a <exit>

00000000000053ba <runtests>:

int
runtests(struct test *tests, char *justone) {
    53ba:	1101                	add	sp,sp,-32
    53bc:	e822                	sd	s0,16(sp)
    53be:	e426                	sd	s1,8(sp)
    53c0:	ec06                	sd	ra,24(sp)
    53c2:	1000                	add	s0,sp,32
    53c4:	84aa                	mv	s1,a0
  for (struct test *t = tests; t->s != 0; t++) {
    53c6:	6508                	ld	a0,8(a0)
    53c8:	c105                	beqz	a0,53e8 <runtests+0x2e>
    53ca:	e04a                	sd	s2,0(sp)
    53cc:	892e                	mv	s2,a1
    if((justone == 0) || strcmp(t->s, justone) == 0) {
    53ce:	02091363          	bnez	s2,53f4 <runtests+0x3a>
      if(!run(t->f, t->s)){
    53d2:	648c                	ld	a1,8(s1)
    53d4:	6088                	ld	a0,0(s1)
    53d6:	00000097          	auipc	ra,0x0
    53da:	f34080e7          	jalr	-204(ra) # 530a <run>
    53de:	c515                	beqz	a0,540a <runtests+0x50>
  for (struct test *t = tests; t->s != 0; t++) {
    53e0:	6c88                	ld	a0,24(s1)
    53e2:	04c1                	add	s1,s1,16
    53e4:	f56d                	bnez	a0,53ce <runtests+0x14>
    53e6:	6902                	ld	s2,0(sp)
        return 1;
      }
    }
  }
  return 0;
}
    53e8:	60e2                	ld	ra,24(sp)
    53ea:	6442                	ld	s0,16(sp)
    53ec:	64a2                	ld	s1,8(sp)
  return 0;
    53ee:	4501                	li	a0,0
}
    53f0:	6105                	add	sp,sp,32
    53f2:	8082                	ret
    if((justone == 0) || strcmp(t->s, justone) == 0) {
    53f4:	85ca                	mv	a1,s2
    53f6:	00000097          	auipc	ra,0x0
    53fa:	364080e7          	jalr	868(ra) # 575a <strcmp>
    53fe:	d971                	beqz	a0,53d2 <runtests+0x18>
  for (struct test *t = tests; t->s != 0; t++) {
    5400:	6c88                	ld	a0,24(s1)
    5402:	04c1                	add	s1,s1,16
    5404:	f965                	bnez	a0,53f4 <runtests+0x3a>
    5406:	6902                	ld	s2,0(sp)
    5408:	b7c5                	j	53e8 <runtests+0x2e>
        printf("SOME TESTS FAILED\n");
    540a:	00003517          	auipc	a0,0x3
    540e:	afe50513          	add	a0,a0,-1282 # 7f08 <malloc+0x20c4>
    5412:	00001097          	auipc	ra,0x1
    5416:	962080e7          	jalr	-1694(ra) # 5d74 <printf>
}
    541a:	60e2                	ld	ra,24(sp)
    541c:	6442                	ld	s0,16(sp)
        return 1;
    541e:	6902                	ld	s2,0(sp)
}
    5420:	64a2                	ld	s1,8(sp)
        return 1;
    5422:	4505                	li	a0,1
}
    5424:	6105                	add	sp,sp,32
    5426:	8082                	ret

0000000000005428 <countfree>:
// because out of memory with lazy allocation results in the process
// taking a fault and being killed, fork and report back.
//
int
countfree()
{
    5428:	7139                	add	sp,sp,-64
    542a:	f822                	sd	s0,48(sp)
    542c:	fc06                	sd	ra,56(sp)
    542e:	0080                	add	s0,sp,64
  int fds[2];

  if(pipe(fds) < 0){
    5430:	fc840513          	add	a0,s0,-56
    5434:	00000097          	auipc	ra,0x0
    5438:	5f6080e7          	jalr	1526(ra) # 5a2a <pipe>
    543c:	0e054563          	bltz	a0,5526 <countfree+0xfe>
    printf("pipe() failed in countfree()\n");
    exit(1);
  }
  
  int pid = fork();
    5440:	00000097          	auipc	ra,0x0
    5444:	5d2080e7          	jalr	1490(ra) # 5a12 <fork>

  if(pid < 0){
    5448:	f426                	sd	s1,40(sp)
    544a:	0e054e63          	bltz	a0,5546 <countfree+0x11e>
    printf("fork failed in countfree()\n");
    exit(1);
  }

  if(pid == 0){
    544e:	c539                	beqz	a0,549c <countfree+0x74>
    }

    exit(0);
  }

  close(fds[1]);
    5450:	fcc42503          	lw	a0,-52(s0)

  int n = 0;
    5454:	4481                	li	s1,0
  close(fds[1]);
    5456:	00000097          	auipc	ra,0x0
    545a:	5ec080e7          	jalr	1516(ra) # 5a42 <close>
  int n = 0;
    545e:	a011                	j	5462 <countfree+0x3a>
      printf("read() failed in countfree()\n");
      exit(1);
    }
    if(cc == 0)
      break;
    n += 1;
    5460:	2485                	addw	s1,s1,1
    int cc = read(fds[0], &c, 1);
    5462:	fc842503          	lw	a0,-56(s0)
    5466:	4605                	li	a2,1
    5468:	fc740593          	add	a1,s0,-57
    546c:	00000097          	auipc	ra,0x0
    5470:	5c6080e7          	jalr	1478(ra) # 5a32 <read>
    if(cc < 0){
    5474:	08054a63          	bltz	a0,5508 <countfree+0xe0>
    if(cc == 0)
    5478:	f565                	bnez	a0,5460 <countfree+0x38>
  }

  close(fds[0]);
    547a:	fc842503          	lw	a0,-56(s0)
    547e:	00000097          	auipc	ra,0x0
    5482:	5c4080e7          	jalr	1476(ra) # 5a42 <close>
  wait((int*)0);
    5486:	4501                	li	a0,0
    5488:	00000097          	auipc	ra,0x0
    548c:	59a080e7          	jalr	1434(ra) # 5a22 <wait>
  
  return n;
}
    5490:	70e2                	ld	ra,56(sp)
    5492:	7442                	ld	s0,48(sp)
    5494:	8526                	mv	a0,s1
    5496:	74a2                	ld	s1,40(sp)
    5498:	6121                	add	sp,sp,64
    549a:	8082                	ret
    close(fds[0]);
    549c:	fc842503          	lw	a0,-56(s0)
    54a0:	f04a                	sd	s2,32(sp)
    54a2:	ec4e                	sd	s3,24(sp)
      if(a == 0xffffffffffffffff){
    54a4:	597d                	li	s2,-1
    close(fds[0]);
    54a6:	00000097          	auipc	ra,0x0
    54aa:	59c080e7          	jalr	1436(ra) # 5a42 <close>
      *(char *)(a + 4096 - 1) = 1;
    54ae:	4485                	li	s1,1
      if(write(fds[1], "x", 1) != 1){
    54b0:	00001997          	auipc	s3,0x1
    54b4:	ad898993          	add	s3,s3,-1320 # 5f88 <malloc+0x144>
    54b8:	a839                	j	54d6 <countfree+0xae>
      *(char *)(a + 4096 - 1) = 1;
    54ba:	6785                	lui	a5,0x1
    54bc:	97aa                	add	a5,a5,a0
    54be:	fe978fa3          	sb	s1,-1(a5) # fff <linktest+0x221>
      if(write(fds[1], "x", 1) != 1){
    54c2:	fcc42503          	lw	a0,-52(s0)
    54c6:	4605                	li	a2,1
    54c8:	85ce                	mv	a1,s3
    54ca:	00000097          	auipc	ra,0x0
    54ce:	570080e7          	jalr	1392(ra) # 5a3a <write>
    54d2:	00951e63          	bne	a0,s1,54ee <countfree+0xc6>
      uint64 a = (uint64) sbrk(4096);
    54d6:	6505                	lui	a0,0x1
    54d8:	00000097          	auipc	ra,0x0
    54dc:	5ca080e7          	jalr	1482(ra) # 5aa2 <sbrk>
      if(a == 0xffffffffffffffff){
    54e0:	fd251de3          	bne	a0,s2,54ba <countfree+0x92>
    exit(0);
    54e4:	4501                	li	a0,0
    54e6:	00000097          	auipc	ra,0x0
    54ea:	534080e7          	jalr	1332(ra) # 5a1a <exit>
        printf("write() failed in countfree()\n");
    54ee:	00003517          	auipc	a0,0x3
    54f2:	a7250513          	add	a0,a0,-1422 # 7f60 <malloc+0x211c>
    54f6:	00001097          	auipc	ra,0x1
    54fa:	87e080e7          	jalr	-1922(ra) # 5d74 <printf>
        exit(1);
    54fe:	4505                	li	a0,1
    5500:	00000097          	auipc	ra,0x0
    5504:	51a080e7          	jalr	1306(ra) # 5a1a <exit>
      printf("read() failed in countfree()\n");
    5508:	00003517          	auipc	a0,0x3
    550c:	a7850513          	add	a0,a0,-1416 # 7f80 <malloc+0x213c>
    5510:	f04a                	sd	s2,32(sp)
    5512:	ec4e                	sd	s3,24(sp)
    5514:	00001097          	auipc	ra,0x1
    5518:	860080e7          	jalr	-1952(ra) # 5d74 <printf>
      exit(1);
    551c:	4505                	li	a0,1
    551e:	00000097          	auipc	ra,0x0
    5522:	4fc080e7          	jalr	1276(ra) # 5a1a <exit>
    printf("pipe() failed in countfree()\n");
    5526:	00003517          	auipc	a0,0x3
    552a:	9fa50513          	add	a0,a0,-1542 # 7f20 <malloc+0x20dc>
    552e:	f426                	sd	s1,40(sp)
    5530:	f04a                	sd	s2,32(sp)
    5532:	ec4e                	sd	s3,24(sp)
    5534:	00001097          	auipc	ra,0x1
    5538:	840080e7          	jalr	-1984(ra) # 5d74 <printf>
    exit(1);
    553c:	4505                	li	a0,1
    553e:	00000097          	auipc	ra,0x0
    5542:	4dc080e7          	jalr	1244(ra) # 5a1a <exit>
    printf("fork failed in countfree()\n");
    5546:	00003517          	auipc	a0,0x3
    554a:	9fa50513          	add	a0,a0,-1542 # 7f40 <malloc+0x20fc>
    554e:	f04a                	sd	s2,32(sp)
    5550:	ec4e                	sd	s3,24(sp)
    5552:	00001097          	auipc	ra,0x1
    5556:	822080e7          	jalr	-2014(ra) # 5d74 <printf>
    exit(1);
    555a:	4505                	li	a0,1
    555c:	00000097          	auipc	ra,0x0
    5560:	4be080e7          	jalr	1214(ra) # 5a1a <exit>

0000000000005564 <drivetests>:

int
drivetests(int quick, int continuous, char *justone) {
    5564:	711d                	add	sp,sp,-96
    5566:	e8a2                	sd	s0,80(sp)
    5568:	e0ca                	sd	s2,64(sp)
    556a:	fc4e                	sd	s3,56(sp)
    556c:	f852                	sd	s4,48(sp)
    556e:	f456                	sd	s5,40(sp)
    5570:	f05a                	sd	s6,32(sp)
    5572:	ec5e                	sd	s7,24(sp)
    5574:	e862                	sd	s8,16(sp)
    5576:	e466                	sd	s9,8(sp)
    5578:	e06a                	sd	s10,0(sp)
    557a:	ec86                	sd	ra,88(sp)
    557c:	e4a6                	sd	s1,72(sp)
    557e:	1080                	add	s0,sp,96
    5580:	8a2a                	mv	s4,a0
    5582:	89ae                	mv	s3,a1
    5584:	8932                	mv	s2,a2
  do {
    printf("usertests starting\n");
    5586:	00003b17          	auipc	s6,0x3
    558a:	a1ab0b13          	add	s6,s6,-1510 # 7fa0 <malloc+0x215c>
    int free0 = countfree();
    int free1 = 0;
    if (runtests(quicktests, justone)) {
    558e:	00004a97          	auipc	s5,0x4
    5592:	a82a8a93          	add	s5,s5,-1406 # 9010 <quicktests>
          return 1;
        }
      }
    }
    if((free1 = countfree()) < free0) {
      printf("FAILED -- lost some free pages %d (out of %d)\n", free1, free0);
    5596:	00003c97          	auipc	s9,0x3
    559a:	a42c8c93          	add	s9,s9,-1470 # 7fd8 <malloc+0x2194>
      if (runtests(slowtests, justone)) {
    559e:	00004c17          	auipc	s8,0x4
    55a2:	e42c0c13          	add	s8,s8,-446 # 93e0 <slowtests>
        if(continuous != 2) {
    55a6:	4b89                	li	s7,2
        printf("usertests slow tests starting\n");
    55a8:	00003d17          	auipc	s10,0x3
    55ac:	a10d0d13          	add	s10,s10,-1520 # 7fb8 <malloc+0x2174>
    printf("usertests starting\n");
    55b0:	855a                	mv	a0,s6
    55b2:	00000097          	auipc	ra,0x0
    55b6:	7c2080e7          	jalr	1986(ra) # 5d74 <printf>
    int free0 = countfree();
    55ba:	00000097          	auipc	ra,0x0
    55be:	e6e080e7          	jalr	-402(ra) # 5428 <countfree>
    55c2:	84aa                	mv	s1,a0
    if (runtests(quicktests, justone)) {
    55c4:	85ca                	mv	a1,s2
    55c6:	8556                	mv	a0,s5
    55c8:	00000097          	auipc	ra,0x0
    55cc:	df2080e7          	jalr	-526(ra) # 53ba <runtests>
    55d0:	cd15                	beqz	a0,560c <drivetests+0xa8>
      if(continuous != 2) {
    55d2:	07799f63          	bne	s3,s7,5650 <drivetests+0xec>
    if(!quick) {
    55d6:	000a1d63          	bnez	s4,55f0 <drivetests+0x8c>
      if (justone == 0)
    55da:	06090d63          	beqz	s2,5654 <drivetests+0xf0>
      if (runtests(slowtests, justone)) {
    55de:	85ca                	mv	a1,s2
    55e0:	8562                	mv	a0,s8
    55e2:	00000097          	auipc	ra,0x0
    55e6:	dd8080e7          	jalr	-552(ra) # 53ba <runtests>
    55ea:	c11d                	beqz	a0,5610 <drivetests+0xac>
        if(continuous != 2) {
    55ec:	07799263          	bne	s3,s7,5650 <drivetests+0xec>
    if((free1 = countfree()) < free0) {
    55f0:	00000097          	auipc	ra,0x0
    55f4:	e38080e7          	jalr	-456(ra) # 5428 <countfree>
    55f8:	fa955ce3          	bge	a0,s1,55b0 <drivetests+0x4c>
      printf("FAILED -- lost some free pages %d (out of %d)\n", free1, free0);
    55fc:	85aa                	mv	a1,a0
    55fe:	8626                	mv	a2,s1
    5600:	8566                	mv	a0,s9
    5602:	00000097          	auipc	ra,0x0
    5606:	772080e7          	jalr	1906(ra) # 5d74 <printf>
      if(continuous != 2) {
    560a:	b75d                	j	55b0 <drivetests+0x4c>
    if(!quick) {
    560c:	fc0a07e3          	beqz	s4,55da <drivetests+0x76>
    if((free1 = countfree()) < free0) {
    5610:	00000097          	auipc	ra,0x0
    5614:	e18080e7          	jalr	-488(ra) # 5428 <countfree>
    5618:	02954363          	blt	a0,s1,563e <drivetests+0xda>
        return 1;
      }
    }
  } while(continuous);
    561c:	f8099ae3          	bnez	s3,55b0 <drivetests+0x4c>
  return 0;
}
    5620:	60e6                	ld	ra,88(sp)
    5622:	6446                	ld	s0,80(sp)
    5624:	64a6                	ld	s1,72(sp)
    5626:	6906                	ld	s2,64(sp)
    5628:	7a42                	ld	s4,48(sp)
    562a:	7aa2                	ld	s5,40(sp)
    562c:	7b02                	ld	s6,32(sp)
    562e:	6be2                	ld	s7,24(sp)
    5630:	6c42                	ld	s8,16(sp)
    5632:	6ca2                	ld	s9,8(sp)
    5634:	6d02                	ld	s10,0(sp)
    5636:	854e                	mv	a0,s3
    5638:	79e2                	ld	s3,56(sp)
    563a:	6125                	add	sp,sp,96
    563c:	8082                	ret
      printf("FAILED -- lost some free pages %d (out of %d)\n", free1, free0);
    563e:	85aa                	mv	a1,a0
    5640:	8626                	mv	a2,s1
    5642:	8566                	mv	a0,s9
    5644:	00000097          	auipc	ra,0x0
    5648:	730080e7          	jalr	1840(ra) # 5d74 <printf>
      if(continuous != 2) {
    564c:	f77982e3          	beq	s3,s7,55b0 <drivetests+0x4c>
        return 1;
    5650:	4985                	li	s3,1
    5652:	b7f9                	j	5620 <drivetests+0xbc>
        printf("usertests slow tests starting\n");
    5654:	856a                	mv	a0,s10
    5656:	00000097          	auipc	ra,0x0
    565a:	71e080e7          	jalr	1822(ra) # 5d74 <printf>
    565e:	b741                	j	55de <drivetests+0x7a>

0000000000005660 <main>:

int
main(int argc, char *argv[])
{
    5660:	1101                	add	sp,sp,-32
    5662:	e822                	sd	s0,16(sp)
    5664:	ec06                	sd	ra,24(sp)
    5666:	e426                	sd	s1,8(sp)
    5668:	1000                	add	s0,sp,32
  int continuous = 0;
  int quick = 0;
  char *justone = 0;

  if(argc == 2 && strcmp(argv[1], "-q") == 0){
    566a:	4789                	li	a5,2
    566c:	02f50f63          	beq	a0,a5,56aa <main+0x4a>
    continuous = 1;
  } else if(argc == 2 && strcmp(argv[1], "-C") == 0){
    continuous = 2;
  } else if(argc == 2 && argv[1][0] != '-'){
    justone = argv[1];
  } else if(argc > 1){
    5670:	4785                	li	a5,1
  char *justone = 0;
    5672:	4601                	li	a2,0
  } else if(argc > 1){
    5674:	08a7c263          	blt	a5,a0,56f8 <main+0x98>
  int quick = 0;
    5678:	4501                	li	a0,0
  int continuous = 0;
    567a:	4581                	li	a1,0
    printf("Usage: usertests [-c] [-C] [-q] [testname]\n");
    exit(1);
  }
  if (drivetests(quick, continuous, justone)) {
    567c:	00000097          	auipc	ra,0x0
    5680:	ee8080e7          	jalr	-280(ra) # 5564 <drivetests>
    5684:	c511                	beqz	a0,5690 <main+0x30>
    exit(1);
    5686:	4505                	li	a0,1
    5688:	00000097          	auipc	ra,0x0
    568c:	392080e7          	jalr	914(ra) # 5a1a <exit>
  }
  printf("ALL TESTS PASSED\n");
    5690:	00003517          	auipc	a0,0x3
    5694:	9c050513          	add	a0,a0,-1600 # 8050 <malloc+0x220c>
    5698:	00000097          	auipc	ra,0x0
    569c:	6dc080e7          	jalr	1756(ra) # 5d74 <printf>
  exit(0);
    56a0:	4501                	li	a0,0
    56a2:	00000097          	auipc	ra,0x0
    56a6:	378080e7          	jalr	888(ra) # 5a1a <exit>
  if(argc == 2 && strcmp(argv[1], "-q") == 0){
    56aa:	6588                	ld	a0,8(a1)
    56ac:	84ae                	mv	s1,a1
    56ae:	00003597          	auipc	a1,0x3
    56b2:	98a58593          	add	a1,a1,-1654 # 8038 <malloc+0x21f4>
    56b6:	00000097          	auipc	ra,0x0
    56ba:	0a4080e7          	jalr	164(ra) # 575a <strcmp>
    56be:	85aa                	mv	a1,a0
    56c0:	c929                	beqz	a0,5712 <main+0xb2>
  } else if(argc == 2 && strcmp(argv[1], "-c") == 0){
    56c2:	6488                	ld	a0,8(s1)
    56c4:	00003597          	auipc	a1,0x3
    56c8:	97c58593          	add	a1,a1,-1668 # 8040 <malloc+0x21fc>
    56cc:	00000097          	auipc	ra,0x0
    56d0:	08e080e7          	jalr	142(ra) # 575a <strcmp>
    56d4:	c529                	beqz	a0,571e <main+0xbe>
  } else if(argc == 2 && strcmp(argv[1], "-C") == 0){
    56d6:	6488                	ld	a0,8(s1)
    56d8:	00003597          	auipc	a1,0x3
    56dc:	97058593          	add	a1,a1,-1680 # 8048 <malloc+0x2204>
    56e0:	00000097          	auipc	ra,0x0
    56e4:	07a080e7          	jalr	122(ra) # 575a <strcmp>
    56e8:	c905                	beqz	a0,5718 <main+0xb8>
  } else if(argc == 2 && argv[1][0] != '-'){
    56ea:	6490                	ld	a2,8(s1)
    56ec:	02d00793          	li	a5,45
    56f0:	00064703          	lbu	a4,0(a2) # 3000 <iputtest+0x6e>
    56f4:	f8f712e3          	bne	a4,a5,5678 <main+0x18>
    printf("Usage: usertests [-c] [-C] [-q] [testname]\n");
    56f8:	00003517          	auipc	a0,0x3
    56fc:	91050513          	add	a0,a0,-1776 # 8008 <malloc+0x21c4>
    5700:	00000097          	auipc	ra,0x0
    5704:	674080e7          	jalr	1652(ra) # 5d74 <printf>
    exit(1);
    5708:	4505                	li	a0,1
    570a:	00000097          	auipc	ra,0x0
    570e:	310080e7          	jalr	784(ra) # 5a1a <exit>
  char *justone = 0;
    5712:	4601                	li	a2,0
    quick = 1;
    5714:	4505                	li	a0,1
    5716:	b79d                	j	567c <main+0x1c>
    continuous = 2;
    5718:	4589                	li	a1,2
  char *justone = 0;
    571a:	4601                	li	a2,0
    571c:	b785                	j	567c <main+0x1c>
    571e:	4601                	li	a2,0
    continuous = 1;
    5720:	4585                	li	a1,1
    5722:	bfa9                	j	567c <main+0x1c>

0000000000005724 <_main>:
//
// wrapper so that it's OK if main() does not call exit().
//
void
_main()
{
    5724:	1141                	add	sp,sp,-16
    5726:	e022                	sd	s0,0(sp)
    5728:	e406                	sd	ra,8(sp)
    572a:	0800                	add	s0,sp,16
  extern int main();
  main();
    572c:	00000097          	auipc	ra,0x0
    5730:	f34080e7          	jalr	-204(ra) # 5660 <main>
  exit(0);
    5734:	4501                	li	a0,0
    5736:	00000097          	auipc	ra,0x0
    573a:	2e4080e7          	jalr	740(ra) # 5a1a <exit>

000000000000573e <strcpy>:
}

char*
strcpy(char *s, const char *t)
{
    573e:	1141                	add	sp,sp,-16
    5740:	e422                	sd	s0,8(sp)
    5742:	0800                	add	s0,sp,16
  char *os;

  os = s;
  while((*s++ = *t++) != 0)
    5744:	87aa                	mv	a5,a0
    5746:	0005c703          	lbu	a4,0(a1)
    574a:	0785                	add	a5,a5,1
    574c:	0585                	add	a1,a1,1
    574e:	fee78fa3          	sb	a4,-1(a5)
    5752:	fb75                	bnez	a4,5746 <strcpy+0x8>
    ;
  return os;
}
    5754:	6422                	ld	s0,8(sp)
    5756:	0141                	add	sp,sp,16
    5758:	8082                	ret

000000000000575a <strcmp>:

int
strcmp(const char *p, const char *q)
{
    575a:	1141                	add	sp,sp,-16
    575c:	e422                	sd	s0,8(sp)
    575e:	0800                	add	s0,sp,16
  while(*p && *p == *q)
    5760:	00054783          	lbu	a5,0(a0)
    5764:	e791                	bnez	a5,5770 <strcmp+0x16>
    5766:	a80d                	j	5798 <strcmp+0x3e>
    5768:	00054783          	lbu	a5,0(a0)
    576c:	cf99                	beqz	a5,578a <strcmp+0x30>
    576e:	85b6                	mv	a1,a3
    5770:	0005c703          	lbu	a4,0(a1)
    p++, q++;
    5774:	0505                	add	a0,a0,1
    5776:	00158693          	add	a3,a1,1
  while(*p && *p == *q)
    577a:	fef707e3          	beq	a4,a5,5768 <strcmp+0xe>
  return (uchar)*p - (uchar)*q;
    577e:	0007851b          	sext.w	a0,a5
}
    5782:	6422                	ld	s0,8(sp)
    5784:	9d19                	subw	a0,a0,a4
    5786:	0141                	add	sp,sp,16
    5788:	8082                	ret
  return (uchar)*p - (uchar)*q;
    578a:	0015c703          	lbu	a4,1(a1)
}
    578e:	6422                	ld	s0,8(sp)
  return (uchar)*p - (uchar)*q;
    5790:	4501                	li	a0,0
}
    5792:	9d19                	subw	a0,a0,a4
    5794:	0141                	add	sp,sp,16
    5796:	8082                	ret
  return (uchar)*p - (uchar)*q;
    5798:	0005c703          	lbu	a4,0(a1)
    579c:	4501                	li	a0,0
    579e:	b7d5                	j	5782 <strcmp+0x28>

00000000000057a0 <strlen>:

uint
strlen(const char *s)
{
    57a0:	1141                	add	sp,sp,-16
    57a2:	e422                	sd	s0,8(sp)
    57a4:	0800                	add	s0,sp,16
  int n;

  for(n = 0; s[n]; n++)
    57a6:	00054783          	lbu	a5,0(a0)
    57aa:	cf91                	beqz	a5,57c6 <strlen+0x26>
    57ac:	0505                	add	a0,a0,1
    57ae:	87aa                	mv	a5,a0
    57b0:	0007c703          	lbu	a4,0(a5)
    57b4:	86be                	mv	a3,a5
    57b6:	0785                	add	a5,a5,1
    57b8:	ff65                	bnez	a4,57b0 <strlen+0x10>
    ;
  return n;
}
    57ba:	6422                	ld	s0,8(sp)
    57bc:	40a6853b          	subw	a0,a3,a0
    57c0:	2505                	addw	a0,a0,1
    57c2:	0141                	add	sp,sp,16
    57c4:	8082                	ret
    57c6:	6422                	ld	s0,8(sp)
  for(n = 0; s[n]; n++)
    57c8:	4501                	li	a0,0
}
    57ca:	0141                	add	sp,sp,16
    57cc:	8082                	ret

00000000000057ce <memset>:

void*
memset(void *dst, int c, uint n)
{
    57ce:	1141                	add	sp,sp,-16
    57d0:	e422                	sd	s0,8(sp)
    57d2:	0800                	add	s0,sp,16
  char *cdst = (char *) dst;
  int i;
  for(i = 0; i < n; i++){
    57d4:	ce09                	beqz	a2,57ee <memset+0x20>
    57d6:	1602                	sll	a2,a2,0x20
    57d8:	9201                	srl	a2,a2,0x20
    cdst[i] = c;
    57da:	0ff5f593          	zext.b	a1,a1
    57de:	87aa                	mv	a5,a0
    57e0:	00a60733          	add	a4,a2,a0
    57e4:	00b78023          	sb	a1,0(a5)
  for(i = 0; i < n; i++){
    57e8:	0785                	add	a5,a5,1
    57ea:	fee79de3          	bne	a5,a4,57e4 <memset+0x16>
  }
  return dst;
}
    57ee:	6422                	ld	s0,8(sp)
    57f0:	0141                	add	sp,sp,16
    57f2:	8082                	ret

00000000000057f4 <strchr>:

char*
strchr(const char *s, char c)
{
    57f4:	1141                	add	sp,sp,-16
    57f6:	e422                	sd	s0,8(sp)
    57f8:	0800                	add	s0,sp,16
  for(; *s; s++)
    57fa:	00054783          	lbu	a5,0(a0)
    57fe:	c799                	beqz	a5,580c <strchr+0x18>
    if(*s == c)
    5800:	00f58763          	beq	a1,a5,580e <strchr+0x1a>
  for(; *s; s++)
    5804:	00154783          	lbu	a5,1(a0)
    5808:	0505                	add	a0,a0,1
    580a:	fbfd                	bnez	a5,5800 <strchr+0xc>
      return (char*)s;
  return 0;
    580c:	4501                	li	a0,0
}
    580e:	6422                	ld	s0,8(sp)
    5810:	0141                	add	sp,sp,16
    5812:	8082                	ret

0000000000005814 <gets>:

char*
gets(char *buf, int max)
{
    5814:	711d                	add	sp,sp,-96
    5816:	e8a2                	sd	s0,80(sp)
    5818:	e4a6                	sd	s1,72(sp)
    581a:	e0ca                	sd	s2,64(sp)
    581c:	fc4e                	sd	s3,56(sp)
    581e:	f852                	sd	s4,48(sp)
    5820:	f05a                	sd	s6,32(sp)
    5822:	ec5e                	sd	s7,24(sp)
    5824:	ec86                	sd	ra,88(sp)
    5826:	f456                	sd	s5,40(sp)
    5828:	1080                	add	s0,sp,96
    582a:	8baa                	mv	s7,a0
    582c:	89ae                	mv	s3,a1
    582e:	892a                	mv	s2,a0
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
    5830:	4481                	li	s1,0
    cc = read(0, &c, 1);
    if(cc < 1)
      break;
    buf[i++] = c;
    if(c == '\n' || c == '\r')
    5832:	4a29                	li	s4,10
    5834:	4b35                	li	s6,13
  for(i=0; i+1 < max; ){
    5836:	a005                	j	5856 <gets+0x42>
    cc = read(0, &c, 1);
    5838:	00000097          	auipc	ra,0x0
    583c:	1fa080e7          	jalr	506(ra) # 5a32 <read>
    if(cc < 1)
    5840:	02a05363          	blez	a0,5866 <gets+0x52>
    buf[i++] = c;
    5844:	faf44783          	lbu	a5,-81(s0)
    if(c == '\n' || c == '\r')
    5848:	0905                	add	s2,s2,1
    buf[i++] = c;
    584a:	fef90fa3          	sb	a5,-1(s2)
    if(c == '\n' || c == '\r')
    584e:	01478d63          	beq	a5,s4,5868 <gets+0x54>
    5852:	01678b63          	beq	a5,s6,5868 <gets+0x54>
  for(i=0; i+1 < max; ){
    5856:	8aa6                	mv	s5,s1
    5858:	2485                	addw	s1,s1,1
    cc = read(0, &c, 1);
    585a:	4605                	li	a2,1
    585c:	faf40593          	add	a1,s0,-81
    5860:	4501                	li	a0,0
  for(i=0; i+1 < max; ){
    5862:	fd34cbe3          	blt	s1,s3,5838 <gets+0x24>
    5866:	84d6                	mv	s1,s5
      break;
  }
  buf[i] = '\0';
    5868:	94de                	add	s1,s1,s7
    586a:	00048023          	sb	zero,0(s1)
  return buf;
}
    586e:	60e6                	ld	ra,88(sp)
    5870:	6446                	ld	s0,80(sp)
    5872:	64a6                	ld	s1,72(sp)
    5874:	6906                	ld	s2,64(sp)
    5876:	79e2                	ld	s3,56(sp)
    5878:	7a42                	ld	s4,48(sp)
    587a:	7aa2                	ld	s5,40(sp)
    587c:	7b02                	ld	s6,32(sp)
    587e:	855e                	mv	a0,s7
    5880:	6be2                	ld	s7,24(sp)
    5882:	6125                	add	sp,sp,96
    5884:	8082                	ret

0000000000005886 <stat>:

int
stat(const char *n, struct stat *st)
{
    5886:	1101                	add	sp,sp,-32
    5888:	e822                	sd	s0,16(sp)
    588a:	e04a                	sd	s2,0(sp)
    588c:	ec06                	sd	ra,24(sp)
    588e:	e426                	sd	s1,8(sp)
    5890:	1000                	add	s0,sp,32
    5892:	892e                	mv	s2,a1
  int fd;
  int r;

  fd = open(n, O_RDONLY);
    5894:	4581                	li	a1,0
    5896:	00000097          	auipc	ra,0x0
    589a:	1c4080e7          	jalr	452(ra) # 5a5a <open>
  if(fd < 0)
    589e:	02054663          	bltz	a0,58ca <stat+0x44>
    return -1;
  r = fstat(fd, st);
    58a2:	85ca                	mv	a1,s2
    58a4:	84aa                	mv	s1,a0
    58a6:	00000097          	auipc	ra,0x0
    58aa:	1cc080e7          	jalr	460(ra) # 5a72 <fstat>
    58ae:	87aa                	mv	a5,a0
  close(fd);
    58b0:	8526                	mv	a0,s1
  r = fstat(fd, st);
    58b2:	84be                	mv	s1,a5
  close(fd);
    58b4:	00000097          	auipc	ra,0x0
    58b8:	18e080e7          	jalr	398(ra) # 5a42 <close>
  return r;
}
    58bc:	60e2                	ld	ra,24(sp)
    58be:	6442                	ld	s0,16(sp)
    58c0:	6902                	ld	s2,0(sp)
    58c2:	8526                	mv	a0,s1
    58c4:	64a2                	ld	s1,8(sp)
    58c6:	6105                	add	sp,sp,32
    58c8:	8082                	ret
    return -1;
    58ca:	54fd                	li	s1,-1
    58cc:	bfc5                	j	58bc <stat+0x36>

00000000000058ce <atoi>:

int
atoi(const char *s)
{
    58ce:	1141                	add	sp,sp,-16
    58d0:	e422                	sd	s0,8(sp)
    58d2:	0800                	add	s0,sp,16
  int n;

  n = 0;
  while('0' <= *s && *s <= '9')
    58d4:	00054683          	lbu	a3,0(a0)
    58d8:	4625                	li	a2,9
    58da:	fd06879b          	addw	a5,a3,-48
    58de:	0ff7f793          	zext.b	a5,a5
    58e2:	02f66863          	bltu	a2,a5,5912 <atoi+0x44>
    58e6:	872a                	mv	a4,a0
  n = 0;
    58e8:	4501                	li	a0,0
    n = n*10 + *s++ - '0';
    58ea:	0025179b          	sllw	a5,a0,0x2
    58ee:	9fa9                	addw	a5,a5,a0
    58f0:	0705                	add	a4,a4,1
    58f2:	0017979b          	sllw	a5,a5,0x1
    58f6:	9fb5                	addw	a5,a5,a3
  while('0' <= *s && *s <= '9')
    58f8:	00074683          	lbu	a3,0(a4)
    n = n*10 + *s++ - '0';
    58fc:	fd07851b          	addw	a0,a5,-48
  while('0' <= *s && *s <= '9')
    5900:	fd06879b          	addw	a5,a3,-48
    5904:	0ff7f793          	zext.b	a5,a5
    5908:	fef671e3          	bgeu	a2,a5,58ea <atoi+0x1c>
  return n;
}
    590c:	6422                	ld	s0,8(sp)
    590e:	0141                	add	sp,sp,16
    5910:	8082                	ret
    5912:	6422                	ld	s0,8(sp)
  n = 0;
    5914:	4501                	li	a0,0
}
    5916:	0141                	add	sp,sp,16
    5918:	8082                	ret

000000000000591a <memmove>:

void*
memmove(void *vdst, const void *vsrc, int n)
{
    591a:	1141                	add	sp,sp,-16
    591c:	e422                	sd	s0,8(sp)
    591e:	0800                	add	s0,sp,16
  char *dst;
  const char *src;

  dst = vdst;
  src = vsrc;
  if (src > dst) {
    5920:	02b57463          	bgeu	a0,a1,5948 <memmove+0x2e>
    while(n-- > 0)
    5924:	00c05f63          	blez	a2,5942 <memmove+0x28>
    5928:	1602                	sll	a2,a2,0x20
    592a:	9201                	srl	a2,a2,0x20
    592c:	00c507b3          	add	a5,a0,a2
  dst = vdst;
    5930:	872a                	mv	a4,a0
      *dst++ = *src++;
    5932:	0005c683          	lbu	a3,0(a1)
    5936:	0705                	add	a4,a4,1
    5938:	0585                	add	a1,a1,1
    593a:	fed70fa3          	sb	a3,-1(a4)
    while(n-- > 0)
    593e:	fef71ae3          	bne	a4,a5,5932 <memmove+0x18>
    src += n;
    while(n-- > 0)
      *--dst = *--src;
  }
  return vdst;
}
    5942:	6422                	ld	s0,8(sp)
    5944:	0141                	add	sp,sp,16
    5946:	8082                	ret
    dst += n;
    5948:	00c50733          	add	a4,a0,a2
    src += n;
    594c:	95b2                	add	a1,a1,a2
    while(n-- > 0)
    594e:	fec05ae3          	blez	a2,5942 <memmove+0x28>
    5952:	fff6079b          	addw	a5,a2,-1
    5956:	1782                	sll	a5,a5,0x20
    5958:	9381                	srl	a5,a5,0x20
    595a:	fff7c793          	not	a5,a5
    595e:	97ae                	add	a5,a5,a1
      *--dst = *--src;
    5960:	fff5c683          	lbu	a3,-1(a1)
    5964:	15fd                	add	a1,a1,-1
    5966:	177d                	add	a4,a4,-1
    5968:	00d70023          	sb	a3,0(a4)
    while(n-- > 0)
    596c:	feb79ae3          	bne	a5,a1,5960 <memmove+0x46>
}
    5970:	6422                	ld	s0,8(sp)
    5972:	0141                	add	sp,sp,16
    5974:	8082                	ret

0000000000005976 <memcmp>:

int
memcmp(const void *s1, const void *s2, uint n)
{
    5976:	1141                	add	sp,sp,-16
    5978:	e422                	sd	s0,8(sp)
    597a:	0800                	add	s0,sp,16
  const char *p1 = s1, *p2 = s2;
  while (n-- > 0) {
    597c:	c61d                	beqz	a2,59aa <memcmp+0x34>
    597e:	fff6069b          	addw	a3,a2,-1
    5982:	1682                	sll	a3,a3,0x20
    5984:	9281                	srl	a3,a3,0x20
    5986:	0685                	add	a3,a3,1
    5988:	96aa                	add	a3,a3,a0
    598a:	a019                	j	5990 <memcmp+0x1a>
    598c:	00a68f63          	beq	a3,a0,59aa <memcmp+0x34>
    if (*p1 != *p2) {
    5990:	00054783          	lbu	a5,0(a0)
    5994:	0005c703          	lbu	a4,0(a1)
      return *p1 - *p2;
    }
    p1++;
    5998:	0505                	add	a0,a0,1
    p2++;
    599a:	0585                	add	a1,a1,1
    if (*p1 != *p2) {
    599c:	fee788e3          	beq	a5,a4,598c <memcmp+0x16>
  }
  return 0;
}
    59a0:	6422                	ld	s0,8(sp)
      return *p1 - *p2;
    59a2:	40e7853b          	subw	a0,a5,a4
}
    59a6:	0141                	add	sp,sp,16
    59a8:	8082                	ret
    59aa:	6422                	ld	s0,8(sp)
  return 0;
    59ac:	4501                	li	a0,0
}
    59ae:	0141                	add	sp,sp,16
    59b0:	8082                	ret

00000000000059b2 <memcpy>:

void *
memcpy(void *dst, const void *src, uint n)
{
    59b2:	1141                	add	sp,sp,-16
    59b4:	e422                	sd	s0,8(sp)
    59b6:	0800                	add	s0,sp,16
  return memmove(dst, src, n);
    59b8:	0006079b          	sext.w	a5,a2
  if (src > dst) {
    59bc:	02b57463          	bgeu	a0,a1,59e4 <memcpy+0x32>
    while(n-- > 0)
    59c0:	00f05f63          	blez	a5,59de <memcpy+0x2c>
    59c4:	1602                	sll	a2,a2,0x20
    59c6:	9201                	srl	a2,a2,0x20
    59c8:	00c587b3          	add	a5,a1,a2
  dst = vdst;
    59cc:	872a                	mv	a4,a0
      *dst++ = *src++;
    59ce:	0005c683          	lbu	a3,0(a1)
    59d2:	0585                	add	a1,a1,1
    59d4:	0705                	add	a4,a4,1
    59d6:	fed70fa3          	sb	a3,-1(a4)
    while(n-- > 0)
    59da:	fef59ae3          	bne	a1,a5,59ce <memcpy+0x1c>
}
    59de:	6422                	ld	s0,8(sp)
    59e0:	0141                	add	sp,sp,16
    59e2:	8082                	ret
    dst += n;
    59e4:	00f50733          	add	a4,a0,a5
    src += n;
    59e8:	95be                	add	a1,a1,a5
    while(n-- > 0)
    59ea:	fef05ae3          	blez	a5,59de <memcpy+0x2c>
    59ee:	fff6079b          	addw	a5,a2,-1
    59f2:	1782                	sll	a5,a5,0x20
    59f4:	9381                	srl	a5,a5,0x20
    59f6:	fff7c793          	not	a5,a5
    59fa:	97ae                	add	a5,a5,a1
      *--dst = *--src;
    59fc:	fff5c683          	lbu	a3,-1(a1)
    5a00:	15fd                	add	a1,a1,-1
    5a02:	177d                	add	a4,a4,-1
    5a04:	00d70023          	sb	a3,0(a4)
    while(n-- > 0)
    5a08:	fef59ae3          	bne	a1,a5,59fc <memcpy+0x4a>
}
    5a0c:	6422                	ld	s0,8(sp)
    5a0e:	0141                	add	sp,sp,16
    5a10:	8082                	ret

0000000000005a12 <fork>:
# generated by usys.pl - do not edit
#include "kern/syscall.h"
.global fork
fork:
 li a7, SYS_fork
    5a12:	4885                	li	a7,1
 ecall
    5a14:	00000073          	ecall
 ret
    5a18:	8082                	ret

0000000000005a1a <exit>:
.global exit
exit:
 li a7, SYS_exit
    5a1a:	4889                	li	a7,2
 ecall
    5a1c:	00000073          	ecall
 ret
    5a20:	8082                	ret

0000000000005a22 <wait>:
.global wait
wait:
 li a7, SYS_wait
    5a22:	488d                	li	a7,3
 ecall
    5a24:	00000073          	ecall
 ret
    5a28:	8082                	ret

0000000000005a2a <pipe>:
.global pipe
pipe:
 li a7, SYS_pipe
    5a2a:	4891                	li	a7,4
 ecall
    5a2c:	00000073          	ecall
 ret
    5a30:	8082                	ret

0000000000005a32 <read>:
.global read
read:
 li a7, SYS_read
    5a32:	4895                	li	a7,5
 ecall
    5a34:	00000073          	ecall
 ret
    5a38:	8082                	ret

0000000000005a3a <write>:
.global write
write:
 li a7, SYS_write
    5a3a:	48c1                	li	a7,16
 ecall
    5a3c:	00000073          	ecall
 ret
    5a40:	8082                	ret

0000000000005a42 <close>:
.global close
close:
 li a7, SYS_close
    5a42:	48d5                	li	a7,21
 ecall
    5a44:	00000073          	ecall
 ret
    5a48:	8082                	ret

0000000000005a4a <kill>:
.global kill
kill:
 li a7, SYS_kill
    5a4a:	4899                	li	a7,6
 ecall
    5a4c:	00000073          	ecall
 ret
    5a50:	8082                	ret

0000000000005a52 <exec>:
.global exec
exec:
 li a7, SYS_exec
    5a52:	489d                	li	a7,7
 ecall
    5a54:	00000073          	ecall
 ret
    5a58:	8082                	ret

0000000000005a5a <open>:
.global open
open:
 li a7, SYS_open
    5a5a:	48bd                	li	a7,15
 ecall
    5a5c:	00000073          	ecall
 ret
    5a60:	8082                	ret

0000000000005a62 <mknod>:
.global mknod
mknod:
 li a7, SYS_mknod
    5a62:	48c5                	li	a7,17
 ecall
    5a64:	00000073          	ecall
 ret
    5a68:	8082                	ret

0000000000005a6a <unlink>:
.global unlink
unlink:
 li a7, SYS_unlink
    5a6a:	48c9                	li	a7,18
 ecall
    5a6c:	00000073          	ecall
 ret
    5a70:	8082                	ret

0000000000005a72 <fstat>:
.global fstat
fstat:
 li a7, SYS_fstat
    5a72:	48a1                	li	a7,8
 ecall
    5a74:	00000073          	ecall
 ret
    5a78:	8082                	ret

0000000000005a7a <link>:
.global link
link:
 li a7, SYS_link
    5a7a:	48cd                	li	a7,19
 ecall
    5a7c:	00000073          	ecall
 ret
    5a80:	8082                	ret

0000000000005a82 <mkdir>:
.global mkdir
mkdir:
 li a7, SYS_mkdir
    5a82:	48d1                	li	a7,20
 ecall
    5a84:	00000073          	ecall
 ret
    5a88:	8082                	ret

0000000000005a8a <chdir>:
.global chdir
chdir:
 li a7, SYS_chdir
    5a8a:	48a5                	li	a7,9
 ecall
    5a8c:	00000073          	ecall
 ret
    5a90:	8082                	ret

0000000000005a92 <dup>:
.global dup
dup:
 li a7, SYS_dup
    5a92:	48a9                	li	a7,10
 ecall
    5a94:	00000073          	ecall
 ret
    5a98:	8082                	ret

0000000000005a9a <getpid>:
.global getpid
getpid:
 li a7, SYS_getpid
    5a9a:	48ad                	li	a7,11
 ecall
    5a9c:	00000073          	ecall
 ret
    5aa0:	8082                	ret

0000000000005aa2 <sbrk>:
.global sbrk
sbrk:
 li a7, SYS_sbrk
    5aa2:	48b1                	li	a7,12
 ecall
    5aa4:	00000073          	ecall
 ret
    5aa8:	8082                	ret

0000000000005aaa <sleep>:
.global sleep
sleep:
 li a7, SYS_sleep
    5aaa:	48b5                	li	a7,13
 ecall
    5aac:	00000073          	ecall
 ret
    5ab0:	8082                	ret

0000000000005ab2 <uptime>:
.global uptime
uptime:
 li a7, SYS_uptime
    5ab2:	48b9                	li	a7,14
 ecall
    5ab4:	00000073          	ecall
 ret
    5ab8:	8082                	ret

0000000000005aba <poweroff>:
.global poweroff
poweroff:
 li a7, SYS_poweroff
    5aba:	48d9                	li	a7,22
 ecall
    5abc:	00000073          	ecall
 ret
    5ac0:	8082                	ret

0000000000005ac2 <printint>:
  write(fd, &c, 1);
}

static void
printint(int fd, int xx, int base, int sgn)
{
    5ac2:	715d                	add	sp,sp,-80
    5ac4:	e0a2                	sd	s0,64(sp)
    5ac6:	f84a                	sd	s2,48(sp)
    5ac8:	e486                	sd	ra,72(sp)
    5aca:	fc26                	sd	s1,56(sp)
    5acc:	f44e                	sd	s3,40(sp)
    5ace:	0880                	add	s0,sp,80
    5ad0:	892a                	mv	s2,a0
  char buf[16];
  int i, neg;
  uint x;

  neg = 0;
  if(sgn && xx < 0){
    5ad2:	c299                	beqz	a3,5ad8 <printint+0x16>
    5ad4:	0805c263          	bltz	a1,5b58 <printint+0x96>
    neg = 1;
    x = -xx;
  } else {
    x = xx;
    5ad8:	2581                	sext.w	a1,a1
  neg = 0;
    5ada:	4681                	li	a3,0
  }

  i = 0;
  do{
    buf[i++] = digits[x % base];
    5adc:	2601                	sext.w	a2,a2
    5ade:	fc040713          	add	a4,s0,-64
  i = 0;
    5ae2:	4501                	li	a0,0
    5ae4:	00003897          	auipc	a7,0x3
    5ae8:	94488893          	add	a7,a7,-1724 # 8428 <digits>
    buf[i++] = digits[x % base];
    5aec:	02c5f7bb          	remuw	a5,a1,a2
  }while((x /= base) != 0);
    5af0:	0705                	add	a4,a4,1
    5af2:	0005881b          	sext.w	a6,a1
    5af6:	84aa                	mv	s1,a0
    buf[i++] = digits[x % base];
    5af8:	2505                	addw	a0,a0,1
    5afa:	1782                	sll	a5,a5,0x20
    5afc:	9381                	srl	a5,a5,0x20
    5afe:	97c6                	add	a5,a5,a7
    5b00:	0007c783          	lbu	a5,0(a5)
  }while((x /= base) != 0);
    5b04:	02c5d5bb          	divuw	a1,a1,a2
    buf[i++] = digits[x % base];
    5b08:	fef70fa3          	sb	a5,-1(a4)
  }while((x /= base) != 0);
    5b0c:	fec870e3          	bgeu	a6,a2,5aec <printint+0x2a>
  if(neg)
    5b10:	ca89                	beqz	a3,5b22 <printint+0x60>
    buf[i++] = '-';
    5b12:	fd050793          	add	a5,a0,-48
    5b16:	97a2                	add	a5,a5,s0
    5b18:	02d00713          	li	a4,45
    5b1c:	fee78823          	sb	a4,-16(a5)

  while(--i >= 0)
    5b20:	84aa                	mv	s1,a0
    5b22:	fc040793          	add	a5,s0,-64
    5b26:	94be                	add	s1,s1,a5
    5b28:	fff78993          	add	s3,a5,-1
    putc(fd, buf[i]);
    5b2c:	0004c783          	lbu	a5,0(s1)
  write(fd, &c, 1);
    5b30:	4605                	li	a2,1
    5b32:	fbf40593          	add	a1,s0,-65
    5b36:	854a                	mv	a0,s2
  while(--i >= 0)
    5b38:	14fd                	add	s1,s1,-1
    5b3a:	faf40fa3          	sb	a5,-65(s0)
  write(fd, &c, 1);
    5b3e:	00000097          	auipc	ra,0x0
    5b42:	efc080e7          	jalr	-260(ra) # 5a3a <write>
  while(--i >= 0)
    5b46:	ff3493e3          	bne	s1,s3,5b2c <printint+0x6a>
}
    5b4a:	60a6                	ld	ra,72(sp)
    5b4c:	6406                	ld	s0,64(sp)
    5b4e:	74e2                	ld	s1,56(sp)
    5b50:	7942                	ld	s2,48(sp)
    5b52:	79a2                	ld	s3,40(sp)
    5b54:	6161                	add	sp,sp,80
    5b56:	8082                	ret
    x = -xx;
    5b58:	40b005bb          	negw	a1,a1
    5b5c:	b741                	j	5adc <printint+0x1a>

0000000000005b5e <vprintf>:
}

// Print to the given fd. Only understands %d, %x, %p, %s.
void
vprintf(int fd, const char *fmt, va_list ap)
{
    5b5e:	7159                	add	sp,sp,-112
    5b60:	f0a2                	sd	s0,96(sp)
    5b62:	f486                	sd	ra,104(sp)
    5b64:	e8ca                	sd	s2,80(sp)
    5b66:	1880                	add	s0,sp,112
  char *s;
  int c, i, state;

  state = 0;
  for(i = 0; fmt[i]; i++){
    5b68:	0005c903          	lbu	s2,0(a1)
    5b6c:	04090f63          	beqz	s2,5bca <vprintf+0x6c>
    5b70:	eca6                	sd	s1,88(sp)
    5b72:	e4ce                	sd	s3,72(sp)
    5b74:	e0d2                	sd	s4,64(sp)
    5b76:	fc56                	sd	s5,56(sp)
    5b78:	f85a                	sd	s6,48(sp)
    5b7a:	f45e                	sd	s7,40(sp)
    5b7c:	f062                	sd	s8,32(sp)
    5b7e:	8a2a                	mv	s4,a0
    5b80:	8c32                	mv	s8,a2
    5b82:	00158493          	add	s1,a1,1
    5b86:	4981                	li	s3,0
      if(c == '%'){
        state = '%';
      } else {
        putc(fd, c);
      }
    } else if(state == '%'){
    5b88:	02500a93          	li	s5,37
    5b8c:	4bd5                	li	s7,21
    5b8e:	00003b17          	auipc	s6,0x3
    5b92:	842b0b13          	add	s6,s6,-1982 # 83d0 <malloc+0x258c>
    if(state == 0){
    5b96:	02099f63          	bnez	s3,5bd4 <vprintf+0x76>
      if(c == '%'){
    5b9a:	05590c63          	beq	s2,s5,5bf2 <vprintf+0x94>
  write(fd, &c, 1);
    5b9e:	4605                	li	a2,1
    5ba0:	f9f40593          	add	a1,s0,-97
    5ba4:	8552                	mv	a0,s4
    5ba6:	f9240fa3          	sb	s2,-97(s0)
    5baa:	00000097          	auipc	ra,0x0
    5bae:	e90080e7          	jalr	-368(ra) # 5a3a <write>
  for(i = 0; fmt[i]; i++){
    5bb2:	0004c903          	lbu	s2,0(s1)
    5bb6:	0485                	add	s1,s1,1
    5bb8:	fc091fe3          	bnez	s2,5b96 <vprintf+0x38>
    5bbc:	64e6                	ld	s1,88(sp)
    5bbe:	69a6                	ld	s3,72(sp)
    5bc0:	6a06                	ld	s4,64(sp)
    5bc2:	7ae2                	ld	s5,56(sp)
    5bc4:	7b42                	ld	s6,48(sp)
    5bc6:	7ba2                	ld	s7,40(sp)
    5bc8:	7c02                	ld	s8,32(sp)
        putc(fd, c);
      }
      state = 0;
    }
  }
}
    5bca:	70a6                	ld	ra,104(sp)
    5bcc:	7406                	ld	s0,96(sp)
    5bce:	6946                	ld	s2,80(sp)
    5bd0:	6165                	add	sp,sp,112
    5bd2:	8082                	ret
    } else if(state == '%'){
    5bd4:	fd599fe3          	bne	s3,s5,5bb2 <vprintf+0x54>
      if(c == 'd'){
    5bd8:	15590463          	beq	s2,s5,5d20 <vprintf+0x1c2>
    5bdc:	f9d9079b          	addw	a5,s2,-99
    5be0:	0ff7f793          	zext.b	a5,a5
    5be4:	00fbea63          	bltu	s7,a5,5bf8 <vprintf+0x9a>
    5be8:	078a                	sll	a5,a5,0x2
    5bea:	97da                	add	a5,a5,s6
    5bec:	439c                	lw	a5,0(a5)
    5bee:	97da                	add	a5,a5,s6
    5bf0:	8782                	jr	a5
        state = '%';
    5bf2:	02500993          	li	s3,37
    5bf6:	bf75                	j	5bb2 <vprintf+0x54>
  write(fd, &c, 1);
    5bf8:	f9f40993          	add	s3,s0,-97
    5bfc:	4605                	li	a2,1
    5bfe:	85ce                	mv	a1,s3
    5c00:	02500793          	li	a5,37
    5c04:	8552                	mv	a0,s4
    5c06:	f8f40fa3          	sb	a5,-97(s0)
    5c0a:	00000097          	auipc	ra,0x0
    5c0e:	e30080e7          	jalr	-464(ra) # 5a3a <write>
    5c12:	4605                	li	a2,1
    5c14:	85ce                	mv	a1,s3
    5c16:	8552                	mv	a0,s4
    5c18:	f9240fa3          	sb	s2,-97(s0)
    5c1c:	00000097          	auipc	ra,0x0
    5c20:	e1e080e7          	jalr	-482(ra) # 5a3a <write>
        while(*s != 0){
    5c24:	4981                	li	s3,0
    5c26:	b771                	j	5bb2 <vprintf+0x54>
        putc(fd, va_arg(ap, uint));
    5c28:	000c2783          	lw	a5,0(s8)
  write(fd, &c, 1);
    5c2c:	4605                	li	a2,1
    5c2e:	f9f40593          	add	a1,s0,-97
    5c32:	8552                	mv	a0,s4
        putc(fd, va_arg(ap, uint));
    5c34:	f8f40fa3          	sb	a5,-97(s0)
    5c38:	0c21                	add	s8,s8,8
  write(fd, &c, 1);
    5c3a:	00000097          	auipc	ra,0x0
    5c3e:	e00080e7          	jalr	-512(ra) # 5a3a <write>
    5c42:	4981                	li	s3,0
    5c44:	b7bd                	j	5bb2 <vprintf+0x54>
        printint(fd, va_arg(ap, int), 10, 1);
    5c46:	000c2583          	lw	a1,0(s8)
    5c4a:	4685                	li	a3,1
        printint(fd, va_arg(ap, uint64), 10, 0);
    5c4c:	4629                	li	a2,10
    5c4e:	8552                	mv	a0,s4
    5c50:	0c21                	add	s8,s8,8
    5c52:	00000097          	auipc	ra,0x0
    5c56:	e70080e7          	jalr	-400(ra) # 5ac2 <printint>
    5c5a:	4981                	li	s3,0
    5c5c:	bf99                	j	5bb2 <vprintf+0x54>
    5c5e:	000c2583          	lw	a1,0(s8)
    5c62:	4681                	li	a3,0
    5c64:	b7e5                	j	5c4c <vprintf+0xee>
  write(fd, &c, 1);
    5c66:	f9f40993          	add	s3,s0,-97
    5c6a:	03000793          	li	a5,48
    5c6e:	4605                	li	a2,1
    5c70:	85ce                	mv	a1,s3
    5c72:	8552                	mv	a0,s4
    5c74:	ec66                	sd	s9,24(sp)
    5c76:	e86a                	sd	s10,16(sp)
        printptr(fd, va_arg(ap, uint64));
    5c78:	f8f40fa3          	sb	a5,-97(s0)
    5c7c:	000c3d03          	ld	s10,0(s8)
  write(fd, &c, 1);
    5c80:	00000097          	auipc	ra,0x0
    5c84:	dba080e7          	jalr	-582(ra) # 5a3a <write>
    5c88:	07800793          	li	a5,120
    5c8c:	4605                	li	a2,1
    5c8e:	85ce                	mv	a1,s3
    5c90:	8552                	mv	a0,s4
    5c92:	f8f40fa3          	sb	a5,-97(s0)
        printptr(fd, va_arg(ap, uint64));
    5c96:	0c21                	add	s8,s8,8
  write(fd, &c, 1);
    5c98:	00000097          	auipc	ra,0x0
    5c9c:	da2080e7          	jalr	-606(ra) # 5a3a <write>
  putc(fd, 'x');
    5ca0:	4941                	li	s2,16
    5ca2:	00002c97          	auipc	s9,0x2
    5ca6:	786c8c93          	add	s9,s9,1926 # 8428 <digits>
    putc(fd, digits[x >> (sizeof(uint64) * 8 - 4)]);
    5caa:	03cd5793          	srl	a5,s10,0x3c
    5cae:	97e6                	add	a5,a5,s9
    5cb0:	0007c783          	lbu	a5,0(a5)
  write(fd, &c, 1);
    5cb4:	4605                	li	a2,1
    5cb6:	85ce                	mv	a1,s3
    5cb8:	8552                	mv	a0,s4
  for (i = 0; i < (sizeof(uint64) * 2); i++, x <<= 4)
    5cba:	397d                	addw	s2,s2,-1
    5cbc:	f8f40fa3          	sb	a5,-97(s0)
    5cc0:	0d12                	sll	s10,s10,0x4
  write(fd, &c, 1);
    5cc2:	00000097          	auipc	ra,0x0
    5cc6:	d78080e7          	jalr	-648(ra) # 5a3a <write>
  for (i = 0; i < (sizeof(uint64) * 2); i++, x <<= 4)
    5cca:	fe0910e3          	bnez	s2,5caa <vprintf+0x14c>
    5cce:	6ce2                	ld	s9,24(sp)
    5cd0:	6d42                	ld	s10,16(sp)
    5cd2:	4981                	li	s3,0
    5cd4:	bdf9                	j	5bb2 <vprintf+0x54>
        s = va_arg(ap, char*);
    5cd6:	000c3903          	ld	s2,0(s8)
    5cda:	0c21                	add	s8,s8,8
        if(s == 0)
    5cdc:	04090e63          	beqz	s2,5d38 <vprintf+0x1da>
        while(*s != 0){
    5ce0:	00094783          	lbu	a5,0(s2)
    5ce4:	d3a1                	beqz	a5,5c24 <vprintf+0xc6>
    5ce6:	f9f40993          	add	s3,s0,-97
  write(fd, &c, 1);
    5cea:	4605                	li	a2,1
    5cec:	85ce                	mv	a1,s3
    5cee:	8552                	mv	a0,s4
    5cf0:	f8f40fa3          	sb	a5,-97(s0)
    5cf4:	00000097          	auipc	ra,0x0
    5cf8:	d46080e7          	jalr	-698(ra) # 5a3a <write>
        while(*s != 0){
    5cfc:	00194783          	lbu	a5,1(s2)
          s++;
    5d00:	0905                	add	s2,s2,1
        while(*s != 0){
    5d02:	f7e5                	bnez	a5,5cea <vprintf+0x18c>
    5d04:	4981                	li	s3,0
    5d06:	b575                	j	5bb2 <vprintf+0x54>
        printint(fd, va_arg(ap, int), 16, 0);
    5d08:	000c2583          	lw	a1,0(s8)
    5d0c:	4681                	li	a3,0
    5d0e:	4641                	li	a2,16
    5d10:	8552                	mv	a0,s4
    5d12:	0c21                	add	s8,s8,8
    5d14:	00000097          	auipc	ra,0x0
    5d18:	dae080e7          	jalr	-594(ra) # 5ac2 <printint>
    5d1c:	4981                	li	s3,0
    5d1e:	bd51                	j	5bb2 <vprintf+0x54>
  write(fd, &c, 1);
    5d20:	4605                	li	a2,1
    5d22:	f9f40593          	add	a1,s0,-97
    5d26:	8552                	mv	a0,s4
    5d28:	f9540fa3          	sb	s5,-97(s0)
        while(*s != 0){
    5d2c:	4981                	li	s3,0
  write(fd, &c, 1);
    5d2e:	00000097          	auipc	ra,0x0
    5d32:	d0c080e7          	jalr	-756(ra) # 5a3a <write>
    5d36:	bdb5                	j	5bb2 <vprintf+0x54>
          s = "(null)";
    5d38:	00002917          	auipc	s2,0x2
    5d3c:	67090913          	add	s2,s2,1648 # 83a8 <malloc+0x2564>
    5d40:	02800793          	li	a5,40
    5d44:	b74d                	j	5ce6 <vprintf+0x188>

0000000000005d46 <fprintf>:

void
fprintf(int fd, const char *fmt, ...)
{
    5d46:	715d                	add	sp,sp,-80
    5d48:	e822                	sd	s0,16(sp)
    5d4a:	ec06                	sd	ra,24(sp)
    5d4c:	1000                	add	s0,sp,32
    5d4e:	e010                	sd	a2,0(s0)
  va_list ap;

  va_start(ap, fmt);
  vprintf(fd, fmt, ap);
    5d50:	8622                	mv	a2,s0
{
    5d52:	e414                	sd	a3,8(s0)
    5d54:	e818                	sd	a4,16(s0)
    5d56:	ec1c                	sd	a5,24(s0)
    5d58:	03043023          	sd	a6,32(s0)
    5d5c:	03143423          	sd	a7,40(s0)
  va_start(ap, fmt);
    5d60:	fe843423          	sd	s0,-24(s0)
  vprintf(fd, fmt, ap);
    5d64:	00000097          	auipc	ra,0x0
    5d68:	dfa080e7          	jalr	-518(ra) # 5b5e <vprintf>
}
    5d6c:	60e2                	ld	ra,24(sp)
    5d6e:	6442                	ld	s0,16(sp)
    5d70:	6161                	add	sp,sp,80
    5d72:	8082                	ret

0000000000005d74 <printf>:

void
printf(const char *fmt, ...)
{
    5d74:	711d                	add	sp,sp,-96
    5d76:	e822                	sd	s0,16(sp)
    5d78:	ec06                	sd	ra,24(sp)
    5d7a:	1000                	add	s0,sp,32
  va_list ap;

  va_start(ap, fmt);
    5d7c:	00840313          	add	t1,s0,8
{
    5d80:	e40c                	sd	a1,8(s0)
    5d82:	e810                	sd	a2,16(s0)
  vprintf(1, fmt, ap);
    5d84:	85aa                	mv	a1,a0
    5d86:	861a                	mv	a2,t1
    5d88:	4505                	li	a0,1
{
    5d8a:	ec14                	sd	a3,24(s0)
    5d8c:	f018                	sd	a4,32(s0)
    5d8e:	f41c                	sd	a5,40(s0)
    5d90:	03043823          	sd	a6,48(s0)
    5d94:	03143c23          	sd	a7,56(s0)
  va_start(ap, fmt);
    5d98:	fe643423          	sd	t1,-24(s0)
  vprintf(1, fmt, ap);
    5d9c:	00000097          	auipc	ra,0x0
    5da0:	dc2080e7          	jalr	-574(ra) # 5b5e <vprintf>
}
    5da4:	60e2                	ld	ra,24(sp)
    5da6:	6442                	ld	s0,16(sp)
    5da8:	6125                	add	sp,sp,96
    5daa:	8082                	ret

0000000000005dac <free>:
static Header base;
static Header *freep;

void
free(void *ap)
{
    5dac:	1141                	add	sp,sp,-16
    5dae:	e422                	sd	s0,8(sp)
    5db0:	0800                	add	s0,sp,16
  Header *bp, *p;

  bp = (Header*)ap - 1;
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
    5db2:	00003597          	auipc	a1,0x3
    5db6:	69e58593          	add	a1,a1,1694 # 9450 <freep>
    5dba:	619c                	ld	a5,0(a1)
  bp = (Header*)ap - 1;
    5dbc:	ff050693          	add	a3,a0,-16
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
    5dc0:	6398                	ld	a4,0(a5)
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
    5dc2:	02d7ff63          	bgeu	a5,a3,5e00 <free+0x54>
    5dc6:	00e6e463          	bltu	a3,a4,5dce <free+0x22>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
    5dca:	02e7ef63          	bltu	a5,a4,5e08 <free+0x5c>
      break;
  if(bp + bp->s.size == p->s.ptr){
    5dce:	ff852803          	lw	a6,-8(a0)
    5dd2:	02081893          	sll	a7,a6,0x20
    5dd6:	01c8d613          	srl	a2,a7,0x1c
    5dda:	9636                	add	a2,a2,a3
    5ddc:	02c70863          	beq	a4,a2,5e0c <free+0x60>
    bp->s.size += p->s.ptr->s.size;
    bp->s.ptr = p->s.ptr->s.ptr;
  } else
    bp->s.ptr = p->s.ptr;
  if(p + p->s.size == bp){
    5de0:	0087a803          	lw	a6,8(a5)
    5de4:	fee53823          	sd	a4,-16(a0)
    5de8:	02081893          	sll	a7,a6,0x20
    5dec:	01c8d613          	srl	a2,a7,0x1c
    5df0:	963e                	add	a2,a2,a5
    5df2:	02c68e63          	beq	a3,a2,5e2e <free+0x82>
    p->s.size += bp->s.size;
    p->s.ptr = bp->s.ptr;
  } else
    p->s.ptr = bp;
  freep = p;
}
    5df6:	6422                	ld	s0,8(sp)
    5df8:	e394                	sd	a3,0(a5)
  freep = p;
    5dfa:	e19c                	sd	a5,0(a1)
}
    5dfc:	0141                	add	sp,sp,16
    5dfe:	8082                	ret
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
    5e00:	00e7e463          	bltu	a5,a4,5e08 <free+0x5c>
    5e04:	fce6e5e3          	bltu	a3,a4,5dce <free+0x22>
{
    5e08:	87ba                	mv	a5,a4
    5e0a:	bf5d                	j	5dc0 <free+0x14>
    bp->s.size += p->s.ptr->s.size;
    5e0c:	4710                	lw	a2,8(a4)
    bp->s.ptr = p->s.ptr->s.ptr;
    5e0e:	6318                	ld	a4,0(a4)
    bp->s.size += p->s.ptr->s.size;
    5e10:	0106063b          	addw	a2,a2,a6
    5e14:	fec52c23          	sw	a2,-8(a0)
  if(p + p->s.size == bp){
    5e18:	0087a803          	lw	a6,8(a5)
    5e1c:	fee53823          	sd	a4,-16(a0)
    5e20:	02081893          	sll	a7,a6,0x20
    5e24:	01c8d613          	srl	a2,a7,0x1c
    5e28:	963e                	add	a2,a2,a5
    5e2a:	fcc696e3          	bne	a3,a2,5df6 <free+0x4a>
    p->s.size += bp->s.size;
    5e2e:	ff852603          	lw	a2,-8(a0)
}
    5e32:	6422                	ld	s0,8(sp)
    p->s.ptr = bp->s.ptr;
    5e34:	86ba                	mv	a3,a4
    p->s.size += bp->s.size;
    5e36:	0106073b          	addw	a4,a2,a6
    5e3a:	c798                	sw	a4,8(a5)
    p->s.ptr = bp->s.ptr;
    5e3c:	e394                	sd	a3,0(a5)
  freep = p;
    5e3e:	e19c                	sd	a5,0(a1)
}
    5e40:	0141                	add	sp,sp,16
    5e42:	8082                	ret

0000000000005e44 <malloc>:
  return freep;
}

void*
malloc(uint nbytes)
{
    5e44:	7139                	add	sp,sp,-64
    5e46:	f822                	sd	s0,48(sp)
    5e48:	f426                	sd	s1,40(sp)
    5e4a:	f04a                	sd	s2,32(sp)
    5e4c:	ec4e                	sd	s3,24(sp)
    5e4e:	fc06                	sd	ra,56(sp)
    5e50:	0080                	add	s0,sp,64
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
  if((prevp = freep) == 0){
    5e52:	00003917          	auipc	s2,0x3
    5e56:	5fe90913          	add	s2,s2,1534 # 9450 <freep>
  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
    5e5a:	02051493          	sll	s1,a0,0x20
    5e5e:	9081                	srl	s1,s1,0x20
  if((prevp = freep) == 0){
    5e60:	00093783          	ld	a5,0(s2)
  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
    5e64:	04bd                	add	s1,s1,15
    5e66:	8091                	srl	s1,s1,0x4
    5e68:	0014899b          	addw	s3,s1,1
    5e6c:	0485                	add	s1,s1,1
  if((prevp = freep) == 0){
    5e6e:	c3dd                	beqz	a5,5f14 <malloc+0xd0>
    base.s.ptr = freep = prevp = &base;
    base.s.size = 0;
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
    5e70:	6388                	ld	a0,0(a5)
    if(p->s.size >= nunits){
    5e72:	4518                	lw	a4,8(a0)
    5e74:	06977863          	bgeu	a4,s1,5ee4 <malloc+0xa0>
    5e78:	e852                	sd	s4,16(sp)
    5e7a:	e456                	sd	s5,8(sp)
    5e7c:	e05a                	sd	s6,0(sp)
  if(nu < 4096)
    5e7e:	6785                	lui	a5,0x1
    5e80:	8a4e                	mv	s4,s3
    5e82:	08f4e763          	bltu	s1,a5,5f10 <malloc+0xcc>
    5e86:	000a0b1b          	sext.w	s6,s4
  if(p == (char*)-1)
    5e8a:	5afd                	li	s5,-1
  p = sbrk(nu * sizeof(Header));
    5e8c:	004a1a1b          	sllw	s4,s4,0x4
    5e90:	a029                	j	5e9a <malloc+0x56>
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
    5e92:	6388                	ld	a0,0(a5)
    if(p->s.size >= nunits){
    5e94:	4518                	lw	a4,8(a0)
    5e96:	04977463          	bgeu	a4,s1,5ede <malloc+0x9a>
        p->s.size = nunits;
      }
      freep = prevp;
      return (void*)(p + 1);
    }
    if(p == freep)
    5e9a:	00093703          	ld	a4,0(s2)
    5e9e:	87aa                	mv	a5,a0
    5ea0:	fee519e3          	bne	a0,a4,5e92 <malloc+0x4e>
  p = sbrk(nu * sizeof(Header));
    5ea4:	8552                	mv	a0,s4
    5ea6:	00000097          	auipc	ra,0x0
    5eaa:	bfc080e7          	jalr	-1028(ra) # 5aa2 <sbrk>
    5eae:	87aa                	mv	a5,a0
  free((void*)(hp + 1));
    5eb0:	0541                	add	a0,a0,16
  if(p == (char*)-1)
    5eb2:	01578b63          	beq	a5,s5,5ec8 <malloc+0x84>
  hp->s.size = nu;
    5eb6:	0167a423          	sw	s6,8(a5) # 1008 <linktest+0x22a>
  free((void*)(hp + 1));
    5eba:	00000097          	auipc	ra,0x0
    5ebe:	ef2080e7          	jalr	-270(ra) # 5dac <free>
  return freep;
    5ec2:	00093783          	ld	a5,0(s2)
      if((p = morecore(nunits)) == 0)
    5ec6:	f7f1                	bnez	a5,5e92 <malloc+0x4e>
        return 0;
  }
}
    5ec8:	70e2                	ld	ra,56(sp)
    5eca:	7442                	ld	s0,48(sp)
        return 0;
    5ecc:	6a42                	ld	s4,16(sp)
    5ece:	6aa2                	ld	s5,8(sp)
    5ed0:	6b02                	ld	s6,0(sp)
}
    5ed2:	74a2                	ld	s1,40(sp)
    5ed4:	7902                	ld	s2,32(sp)
    5ed6:	69e2                	ld	s3,24(sp)
        return 0;
    5ed8:	4501                	li	a0,0
}
    5eda:	6121                	add	sp,sp,64
    5edc:	8082                	ret
    5ede:	6a42                	ld	s4,16(sp)
    5ee0:	6aa2                	ld	s5,8(sp)
    5ee2:	6b02                	ld	s6,0(sp)
      if(p->s.size == nunits)
    5ee4:	04e48763          	beq	s1,a4,5f32 <malloc+0xee>
        p->s.size -= nunits;
    5ee8:	4137073b          	subw	a4,a4,s3
        p += p->s.size;
    5eec:	02071613          	sll	a2,a4,0x20
    5ef0:	01c65693          	srl	a3,a2,0x1c
        p->s.size -= nunits;
    5ef4:	c518                	sw	a4,8(a0)
        p += p->s.size;
    5ef6:	9536                	add	a0,a0,a3
        p->s.size = nunits;
    5ef8:	01352423          	sw	s3,8(a0)
}
    5efc:	70e2                	ld	ra,56(sp)
    5efe:	7442                	ld	s0,48(sp)
      freep = prevp;
    5f00:	00f93023          	sd	a5,0(s2)
}
    5f04:	74a2                	ld	s1,40(sp)
    5f06:	7902                	ld	s2,32(sp)
    5f08:	69e2                	ld	s3,24(sp)
      return (void*)(p + 1);
    5f0a:	0541                	add	a0,a0,16
}
    5f0c:	6121                	add	sp,sp,64
    5f0e:	8082                	ret
  if(nu < 4096)
    5f10:	6a05                	lui	s4,0x1
    5f12:	bf95                	j	5e86 <malloc+0x42>
    5f14:	e852                	sd	s4,16(sp)
    5f16:	e456                	sd	s5,8(sp)
    5f18:	e05a                	sd	s6,0(sp)
    base.s.ptr = freep = prevp = &base;
    5f1a:	0000a517          	auipc	a0,0xa
    5f1e:	d5e50513          	add	a0,a0,-674 # fc78 <base>
    5f22:	00a93023          	sd	a0,0(s2)
    5f26:	e108                	sd	a0,0(a0)
    base.s.size = 0;
    5f28:	0000a797          	auipc	a5,0xa
    5f2c:	d407ac23          	sw	zero,-680(a5) # fc80 <base+0x8>
    if(p->s.size >= nunits){
    5f30:	b7b9                	j	5e7e <malloc+0x3a>
        prevp->s.ptr = p->s.ptr;
    5f32:	6118                	ld	a4,0(a0)
    5f34:	e398                	sd	a4,0(a5)
    5f36:	b7d9                	j	5efc <malloc+0xb8>
