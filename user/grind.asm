
user/_grind:     file format elf64-littleriscv


Disassembly of section .text:

0000000000000000 <do_rand>:
#include <C/string.h>

// from FreeBSD.
int
do_rand(unsigned long *ctx)
{
       0:	1141                	add	sp,sp,-16
       2:	e422                	sd	s0,8(sp)
       4:	0800                	add	s0,sp,16
 * October 1988, p. 1195.
 */
    long hi, lo, x;

    /* Transform to [1, 0x7ffffffe] range. */
    x = (*ctx % 0x7ffffffe) + 1;
       6:	611c                	ld	a5,0(a0)
       8:	80000737          	lui	a4,0x80000
       c:	ffe74713          	xor	a4,a4,-2
      10:	02e7f7b3          	remu	a5,a5,a4
    hi = x / 127773;
    lo = x % 127773;
      14:	66fd                	lui	a3,0x1f
      16:	31d68693          	add	a3,a3,797 # 1f31d <base+0x1cf15>
    x = 16807 * lo - 2836 * hi;
      1a:	6591                	lui	a1,0x4
      1c:	767d                	lui	a2,0xfffff
      1e:	1a758593          	add	a1,a1,423 # 41a7 <base+0x1d9f>
      22:	4ec60613          	add	a2,a2,1260 # fffffffffffff4ec <base+0xffffffffffffd0e4>
    x = (*ctx % 0x7ffffffe) + 1;
      26:	0785                	add	a5,a5,1
    lo = x % 127773;
      28:	02d7e733          	rem	a4,a5,a3
    hi = x / 127773;
      2c:	02d7c7b3          	div	a5,a5,a3
    x = 16807 * lo - 2836 * hi;
      30:	02b70733          	mul	a4,a4,a1
      34:	02c787b3          	mul	a5,a5,a2
      38:	97ba                	add	a5,a5,a4
    if (x < 0)
      3a:	0007d763          	bgez	a5,48 <do_rand+0x48>
        x += 0x7fffffff;
      3e:	80000737          	lui	a4,0x80000
      42:	fff74713          	not	a4,a4
      46:	97ba                	add	a5,a5,a4
    /* Transform to [0, 0x7ffffffd] range. */
    x--;
    *ctx = x;
    return (x);
}
      48:	6422                	ld	s0,8(sp)
    x--;
      4a:	17fd                	add	a5,a5,-1
    *ctx = x;
      4c:	e11c                	sd	a5,0(a0)
}
      4e:	0007851b          	sext.w	a0,a5
      52:	0141                	add	sp,sp,16
      54:	8082                	ret

0000000000000056 <rand>:

unsigned long rand_next = 1;

int
rand(void)
{
      56:	1141                	add	sp,sp,-16
      58:	e422                	sd	s0,8(sp)
      5a:	0800                	add	s0,sp,16
    x = (*ctx % 0x7ffffffe) + 1;
      5c:	00002597          	auipc	a1,0x2
      60:	fa458593          	add	a1,a1,-92 # 2000 <rand_next>
      64:	619c                	ld	a5,0(a1)
      66:	80000737          	lui	a4,0x80000
      6a:	ffe74713          	xor	a4,a4,-2
      6e:	02e7f7b3          	remu	a5,a5,a4
    lo = x % 127773;
      72:	677d                	lui	a4,0x1f
      74:	31d70713          	add	a4,a4,797 # 1f31d <base+0x1cf15>
    x = 16807 * lo - 2836 * hi;
      78:	6611                	lui	a2,0x4
      7a:	76fd                	lui	a3,0xfffff
      7c:	1a760613          	add	a2,a2,423 # 41a7 <base+0x1d9f>
      80:	4ec68693          	add	a3,a3,1260 # fffffffffffff4ec <base+0xffffffffffffd0e4>
    x = (*ctx % 0x7ffffffe) + 1;
      84:	0785                	add	a5,a5,1
    lo = x % 127773;
      86:	02e7e533          	rem	a0,a5,a4
    hi = x / 127773;
      8a:	02e7c7b3          	div	a5,a5,a4
    x = 16807 * lo - 2836 * hi;
      8e:	02c50533          	mul	a0,a0,a2
      92:	02d787b3          	mul	a5,a5,a3
      96:	953e                	add	a0,a0,a5
    if (x < 0)
      98:	00055763          	bgez	a0,a6 <rand+0x50>
        x += 0x7fffffff;
      9c:	800007b7          	lui	a5,0x80000
      a0:	fff7c793          	not	a5,a5
      a4:	953e                	add	a0,a0,a5
    return (do_rand(&rand_next));
}
      a6:	6422                	ld	s0,8(sp)
    x--;
      a8:	157d                	add	a0,a0,-1
    *ctx = x;
      aa:	e188                	sd	a0,0(a1)
}
      ac:	2501                	sext.w	a0,a0
      ae:	0141                	add	sp,sp,16
      b0:	8082                	ret

00000000000000b2 <go>:

void
go(int which_child)
{
      b2:	7171                	add	sp,sp,-176
      b4:	f506                	sd	ra,168(sp)
      b6:	f122                	sd	s0,160(sp)
      b8:	ed26                	sd	s1,152(sp)
      ba:	1900                	add	s0,sp,176
      bc:	e94a                	sd	s2,144(sp)
      be:	e54e                	sd	s3,136(sp)
      c0:	e152                	sd	s4,128(sp)
      c2:	fcd6                	sd	s5,120(sp)
      c4:	f8da                	sd	s6,112(sp)
      c6:	f4de                	sd	s7,104(sp)
      c8:	f0e2                	sd	s8,96(sp)
      ca:	ece6                	sd	s9,88(sp)
      cc:	e8ea                	sd	s10,80(sp)
      ce:	e4ee                	sd	s11,72(sp)
      d0:	84aa                	mv	s1,a0
  int fd = -1;
  static char buf[999];
  char *break0 = sbrk(0);
      d2:	4501                	li	a0,0
      d4:	00001097          	auipc	ra,0x1
      d8:	df2080e7          	jalr	-526(ra) # ec6 <sbrk>
      dc:	87aa                	mv	a5,a0
  uint64 iters = 0;

  mkdir("grindir");
      de:	00001517          	auipc	a0,0x1
      e2:	28250513          	add	a0,a0,642 # 1360 <malloc+0xf8>
  char *break0 = sbrk(0);
      e6:	f4f43c23          	sd	a5,-168(s0)
  mkdir("grindir");
      ea:	00001097          	auipc	ra,0x1
      ee:	dbc080e7          	jalr	-580(ra) # ea6 <mkdir>
  if(chdir("grindir") != 0){
      f2:	00001517          	auipc	a0,0x1
      f6:	26e50513          	add	a0,a0,622 # 1360 <malloc+0xf8>
      fa:	00001097          	auipc	ra,0x1
      fe:	db4080e7          	jalr	-588(ra) # eae <chdir>
     102:	cd11                	beqz	a0,11e <go+0x6c>
    printf("grind: chdir grindir failed\n");
     104:	00001517          	auipc	a0,0x1
     108:	26450513          	add	a0,a0,612 # 1368 <malloc+0x100>
     10c:	00001097          	auipc	ra,0x1
     110:	08c080e7          	jalr	140(ra) # 1198 <printf>
    exit(1);
     114:	4505                	li	a0,1
     116:	00001097          	auipc	ra,0x1
     11a:	d28080e7          	jalr	-728(ra) # e3e <exit>
  }
  chdir("/");
     11e:	00001517          	auipc	a0,0x1
     122:	27250513          	add	a0,a0,626 # 1390 <malloc+0x128>
     126:	00001097          	auipc	ra,0x1
     12a:	d88080e7          	jalr	-632(ra) # eae <chdir>
     12e:	00001c17          	auipc	s8,0x1
     132:	272c0c13          	add	s8,s8,626 # 13a0 <malloc+0x138>
     136:	52049763          	bnez	s1,664 <go+0x5b2>
    x = (*ctx % 0x7ffffffe) + 1;
     13a:	80000bb7          	lui	s7,0x80000
    lo = x % 127773;
     13e:	697d                	lui	s2,0x1f
    x = 16807 * lo - 2836 * hi;
     140:	6b11                	lui	s6,0x4
     142:	7afd                	lui	s5,0xfffff
        x += 0x7fffffff;
     144:	80000cb7          	lui	s9,0x80000
  uint64 iters = 0;
     148:	4481                	li	s1,0
  int fd = -1;
     14a:	5d7d                	li	s10,-1
     14c:	00002a17          	auipc	s4,0x2
     150:	eb4a0a13          	add	s4,s4,-332 # 2000 <rand_next>
     154:	00001997          	auipc	s3,0x1
     158:	51c98993          	add	s3,s3,1308 # 1670 <malloc+0x408>
    x = (*ctx % 0x7ffffffe) + 1;
     15c:	ffebcb93          	xor	s7,s7,-2
    lo = x % 127773;
     160:	31d90913          	add	s2,s2,797 # 1f31d <base+0x1cf15>
    x = 16807 * lo - 2836 * hi;
     164:	1a7b0b13          	add	s6,s6,423 # 41a7 <base+0x1d9f>
     168:	4eca8a93          	add	s5,s5,1260 # fffffffffffff4ec <base+0xffffffffffffd0e4>
        x += 0x7fffffff;
     16c:	fffccc93          	not	s9,s9
  
  while(1){
    iters++;
     170:	0485                	add	s1,s1,1
     172:	1f400793          	li	a5,500
     176:	02f4f7b3          	remu	a5,s1,a5
    if((iters % 500) == 0)
     17a:	eb81                	bnez	a5,18a <go+0xd8>
      write(1, which_child?"B":"A", 1);
     17c:	4605                	li	a2,1
     17e:	85e2                	mv	a1,s8
     180:	4505                	li	a0,1
     182:	00001097          	auipc	ra,0x1
     186:	cdc080e7          	jalr	-804(ra) # e5e <write>
    x = (*ctx % 0x7ffffffe) + 1;
     18a:	000a3783          	ld	a5,0(s4)
     18e:	0377f7b3          	remu	a5,a5,s7
     192:	0785                	add	a5,a5,1 # ffffffff80000001 <base+0xffffffff7fffdbf9>
    lo = x % 127773;
     194:	0327e733          	rem	a4,a5,s2
    hi = x / 127773;
     198:	0327c7b3          	div	a5,a5,s2
    x = 16807 * lo - 2836 * hi;
     19c:	03670733          	mul	a4,a4,s6
     1a0:	035787b3          	mul	a5,a5,s5
     1a4:	97ba                	add	a5,a5,a4
    if (x < 0)
     1a6:	0007d363          	bgez	a5,1ac <go+0xfa>
        x += 0x7fffffff;
     1aa:	97e6                	add	a5,a5,s9
    x--;
     1ac:	17fd                	add	a5,a5,-1
    int what = rand() % 23;
     1ae:	475d                	li	a4,23
     1b0:	02e7e73b          	remw	a4,a5,a4
    *ctx = x;
     1b4:	00fa3023          	sd	a5,0(s4)
    if(what == 1){
     1b8:	47d9                	li	a5,22
     1ba:	0007069b          	sext.w	a3,a4
     1be:	fad7e9e3          	bltu	a5,a3,170 <go+0xbe>
     1c2:	02071793          	sll	a5,a4,0x20
     1c6:	01e7d713          	srl	a4,a5,0x1e
     1ca:	974e                	add	a4,a4,s3
     1cc:	431c                	lw	a5,0(a4)
     1ce:	97ce                	add	a5,a5,s3
     1d0:	8782                	jr	a5
      close(fd1);
      unlink("c");
    } else if(what == 22){
      // echo hi | cat
      int aa[2], bb[2];
      if(pipe(aa) < 0){
     1d2:	f6840513          	add	a0,s0,-152
     1d6:	00001097          	auipc	ra,0x1
     1da:	c78080e7          	jalr	-904(ra) # e4e <pipe>
     1de:	50054c63          	bltz	a0,6f6 <go+0x644>
        fprintf(2, "grind: pipe failed\n");
        exit(1);
      }
      if(pipe(bb) < 0){
     1e2:	f7040513          	add	a0,s0,-144
     1e6:	00001097          	auipc	ra,0x1
     1ea:	c68080e7          	jalr	-920(ra) # e4e <pipe>
     1ee:	50054463          	bltz	a0,6f6 <go+0x644>
        fprintf(2, "grind: pipe failed\n");
        exit(1);
      }
      int pid1 = fork();
     1f2:	00001097          	auipc	ra,0x1
     1f6:	c44080e7          	jalr	-956(ra) # e36 <fork>
      if(pid1 == 0){
     1fa:	64050163          	beqz	a0,83c <go+0x78a>
        close(aa[1]);
        char *args[3] = { "echo", "hi", 0 };
        exec("grindir/../echo", args);
        fprintf(2, "grind: echo: not found\n");
        exit(2);
      } else if(pid1 < 0){
     1fe:	62054163          	bltz	a0,820 <go+0x76e>
        fprintf(2, "grind: fork failed\n");
        exit(3);
      }
      int pid2 = fork();
     202:	00001097          	auipc	ra,0x1
     206:	c34080e7          	jalr	-972(ra) # e36 <fork>
      if(pid2 == 0){
     20a:	6c050363          	beqz	a0,8d0 <go+0x81e>
        close(bb[1]);
        char *args[2] = { "cat", 0 };
        exec("/cat", args);
        fprintf(2, "grind: cat: not found\n");
        exit(6);
      } else if(pid2 < 0){
     20e:	6a054363          	bltz	a0,8b4 <go+0x802>
        fprintf(2, "grind: fork failed\n");
        exit(7);
      }
      close(aa[0]);
     212:	f6842503          	lw	a0,-152(s0)
     216:	00001097          	auipc	ra,0x1
     21a:	c50080e7          	jalr	-944(ra) # e66 <close>
      close(aa[1]);
     21e:	f6c42503          	lw	a0,-148(s0)
     222:	00001097          	auipc	ra,0x1
     226:	c44080e7          	jalr	-956(ra) # e66 <close>
      close(bb[1]);
     22a:	f7442503          	lw	a0,-140(s0)
     22e:	00001097          	auipc	ra,0x1
     232:	c38080e7          	jalr	-968(ra) # e66 <close>
      char buf[4] = { 0, 0, 0, 0 };
      read(bb[0], buf+0, 1);
     236:	f7042503          	lw	a0,-144(s0)
     23a:	4605                	li	a2,1
     23c:	f6040593          	add	a1,s0,-160
      char buf[4] = { 0, 0, 0, 0 };
     240:	f6042023          	sw	zero,-160(s0)
      read(bb[0], buf+0, 1);
     244:	00001097          	auipc	ra,0x1
     248:	c12080e7          	jalr	-1006(ra) # e56 <read>
      read(bb[0], buf+1, 1);
     24c:	f7042503          	lw	a0,-144(s0)
     250:	4605                	li	a2,1
     252:	f6140593          	add	a1,s0,-159
     256:	00001097          	auipc	ra,0x1
     25a:	c00080e7          	jalr	-1024(ra) # e56 <read>
      read(bb[0], buf+2, 1);
     25e:	f7042503          	lw	a0,-144(s0)
     262:	4605                	li	a2,1
     264:	f6240593          	add	a1,s0,-158
     268:	00001097          	auipc	ra,0x1
     26c:	bee080e7          	jalr	-1042(ra) # e56 <read>
      close(bb[0]);
     270:	f7042503          	lw	a0,-144(s0)
     274:	00001097          	auipc	ra,0x1
     278:	bf2080e7          	jalr	-1038(ra) # e66 <close>
      int st1, st2;
      wait(&st1);
     27c:	f6440513          	add	a0,s0,-156
     280:	00001097          	auipc	ra,0x1
     284:	bc6080e7          	jalr	-1082(ra) # e46 <wait>
      wait(&st2);
     288:	f7840513          	add	a0,s0,-136
     28c:	00001097          	auipc	ra,0x1
     290:	bba080e7          	jalr	-1094(ra) # e46 <wait>
      if(st1 != 0 || st2 != 0 || strcmp(buf, "hi\n") != 0){
     294:	f6442583          	lw	a1,-156(s0)
     298:	f7842603          	lw	a2,-136(s0)
     29c:	00c5e7b3          	or	a5,a1,a2
     2a0:	e38d                	bnez	a5,2c2 <go+0x210>
     2a2:	00001597          	auipc	a1,0x1
     2a6:	3be58593          	add	a1,a1,958 # 1660 <malloc+0x3f8>
     2aa:	f6040513          	add	a0,s0,-160
     2ae:	00001097          	auipc	ra,0x1
     2b2:	8d0080e7          	jalr	-1840(ra) # b7e <strcmp>
     2b6:	ea050de3          	beqz	a0,170 <go+0xbe>
     2ba:	f6442583          	lw	a1,-156(s0)
     2be:	f7842603          	lw	a2,-136(s0)
        printf("grind: exec pipeline failed %d %d \"%s\"\n", st1, st2, buf);
     2c2:	00001517          	auipc	a0,0x1
     2c6:	37650513          	add	a0,a0,886 # 1638 <malloc+0x3d0>
     2ca:	f6040693          	add	a3,s0,-160
     2ce:	00001097          	auipc	ra,0x1
     2d2:	eca080e7          	jalr	-310(ra) # 1198 <printf>
        exit(1);
     2d6:	4505                	li	a0,1
     2d8:	00001097          	auipc	ra,0x1
     2dc:	b66080e7          	jalr	-1178(ra) # e3e <exit>
      unlink("c");
     2e0:	00001517          	auipc	a0,0x1
     2e4:	24050513          	add	a0,a0,576 # 1520 <malloc+0x2b8>
     2e8:	00001097          	auipc	ra,0x1
     2ec:	ba6080e7          	jalr	-1114(ra) # e8e <unlink>
      int fd1 = open("c", O_CREATE|O_RDWR);
     2f0:	20200593          	li	a1,514
     2f4:	00001517          	auipc	a0,0x1
     2f8:	22c50513          	add	a0,a0,556 # 1520 <malloc+0x2b8>
     2fc:	00001097          	auipc	ra,0x1
     300:	b82080e7          	jalr	-1150(ra) # e7e <open>
     304:	8daa                	mv	s11,a0
      if(fd1 < 0){
     306:	4c054663          	bltz	a0,7d2 <go+0x720>
      if(write(fd1, "x", 1) != 1){
     30a:	4605                	li	a2,1
     30c:	00001597          	auipc	a1,0x1
     310:	1c458593          	add	a1,a1,452 # 14d0 <malloc+0x268>
     314:	00001097          	auipc	ra,0x1
     318:	b4a080e7          	jalr	-1206(ra) # e5e <write>
     31c:	4705                	li	a4,1
     31e:	48e51d63          	bne	a0,a4,7b8 <go+0x706>
      if(fstat(fd1, &st) != 0){
     322:	f4a43823          	sd	a0,-176(s0)
     326:	f7840593          	add	a1,s0,-136
     32a:	856e                	mv	a0,s11
     32c:	00001097          	auipc	ra,0x1
     330:	b6a080e7          	jalr	-1174(ra) # e96 <fstat>
     334:	f5043783          	ld	a5,-176(s0)
     338:	5e051263          	bnez	a0,91c <go+0x86a>
      if(st.size != 1){
     33c:	f8843583          	ld	a1,-120(s0)
     340:	54f59c63          	bne	a1,a5,898 <go+0x7e6>
      if(st.ino > 200){
     344:	f7c42583          	lw	a1,-132(s0)
     348:	0c800793          	li	a5,200
     34c:	4ab7e063          	bltu	a5,a1,7ec <go+0x73a>
      close(fd1);
     350:	856e                	mv	a0,s11
     352:	00001097          	auipc	ra,0x1
     356:	b14080e7          	jalr	-1260(ra) # e66 <close>
      unlink("c");
     35a:	00001517          	auipc	a0,0x1
     35e:	1c650513          	add	a0,a0,454 # 1520 <malloc+0x2b8>
     362:	00001097          	auipc	ra,0x1
     366:	b2c080e7          	jalr	-1236(ra) # e8e <unlink>
     36a:	b519                	j	170 <go+0xbe>
      int pid = fork();
     36c:	00001097          	auipc	ra,0x1
     370:	aca080e7          	jalr	-1334(ra) # e36 <fork>
      if(pid == 0){
     374:	30050a63          	beqz	a0,688 <go+0x5d6>
      } else if(pid < 0){
     378:	2e054b63          	bltz	a0,66e <go+0x5bc>
      wait(0);
     37c:	4501                	li	a0,0
     37e:	00001097          	auipc	ra,0x1
     382:	ac8080e7          	jalr	-1336(ra) # e46 <wait>
     386:	b3ed                	j	170 <go+0xbe>
      if(pipe(fds) < 0){
     388:	f7840513          	add	a0,s0,-136
     38c:	00001097          	auipc	ra,0x1
     390:	ac2080e7          	jalr	-1342(ra) # e4e <pipe>
     394:	40054563          	bltz	a0,79e <go+0x6ec>
      int pid = fork();
     398:	00001097          	auipc	ra,0x1
     39c:	a9e080e7          	jalr	-1378(ra) # e36 <fork>
      if(pid == 0){
     3a0:	38050c63          	beqz	a0,738 <go+0x686>
      } else if(pid < 0){
     3a4:	2c054563          	bltz	a0,66e <go+0x5bc>
      close(fds[0]);
     3a8:	f7842503          	lw	a0,-136(s0)
     3ac:	00001097          	auipc	ra,0x1
     3b0:	aba080e7          	jalr	-1350(ra) # e66 <close>
      close(fds[1]);
     3b4:	f7c42503          	lw	a0,-132(s0)
     3b8:	00001097          	auipc	ra,0x1
     3bc:	aae080e7          	jalr	-1362(ra) # e66 <close>
      wait(0);
     3c0:	4501                	li	a0,0
     3c2:	00001097          	auipc	ra,0x1
     3c6:	a84080e7          	jalr	-1404(ra) # e46 <wait>
     3ca:	b35d                	j	170 <go+0xbe>
      int pid = fork();
     3cc:	00001097          	auipc	ra,0x1
     3d0:	a6a080e7          	jalr	-1430(ra) # e36 <fork>
      if(pid == 0){
     3d4:	f155                	bnez	a0,378 <go+0x2c6>
        kill(getpid());
     3d6:	00001097          	auipc	ra,0x1
     3da:	ae8080e7          	jalr	-1304(ra) # ebe <getpid>
     3de:	00001097          	auipc	ra,0x1
     3e2:	a90080e7          	jalr	-1392(ra) # e6e <kill>
        exit(0);
     3e6:	4501                	li	a0,0
     3e8:	00001097          	auipc	ra,0x1
     3ec:	a56080e7          	jalr	-1450(ra) # e3e <exit>
      int pid = fork();
     3f0:	00001097          	auipc	ra,0x1
     3f4:	a46080e7          	jalr	-1466(ra) # e36 <fork>
     3f8:	8daa                	mv	s11,a0
      if(pid == 0){
     3fa:	30050c63          	beqz	a0,712 <go+0x660>
      } else if(pid < 0){
     3fe:	26054863          	bltz	a0,66e <go+0x5bc>
      if(chdir("../grindir/..") != 0){
     402:	00001517          	auipc	a0,0x1
     406:	08e50513          	add	a0,a0,142 # 1490 <malloc+0x228>
     40a:	00001097          	auipc	ra,0x1
     40e:	aa4080e7          	jalr	-1372(ra) # eae <chdir>
     412:	3e051a63          	bnez	a0,806 <go+0x754>
      kill(pid);
     416:	856e                	mv	a0,s11
     418:	00001097          	auipc	ra,0x1
     41c:	a56080e7          	jalr	-1450(ra) # e6e <kill>
      wait(0);
     420:	4501                	li	a0,0
     422:	00001097          	auipc	ra,0x1
     426:	a24080e7          	jalr	-1500(ra) # e46 <wait>
     42a:	b399                	j	170 <go+0xbe>
      if(sbrk(0) > break0)
     42c:	4501                	li	a0,0
     42e:	00001097          	auipc	ra,0x1
     432:	a98080e7          	jalr	-1384(ra) # ec6 <sbrk>
     436:	f5843783          	ld	a5,-168(s0)
     43a:	d2a7fbe3          	bgeu	a5,a0,170 <go+0xbe>
        sbrk(-(sbrk(0) - break0));
     43e:	4501                	li	a0,0
     440:	00001097          	auipc	ra,0x1
     444:	a86080e7          	jalr	-1402(ra) # ec6 <sbrk>
     448:	f5843783          	ld	a5,-168(s0)
     44c:	40a7853b          	subw	a0,a5,a0
     450:	00001097          	auipc	ra,0x1
     454:	a76080e7          	jalr	-1418(ra) # ec6 <sbrk>
     458:	bb21                	j	170 <go+0xbe>
      sbrk(6011);
     45a:	6505                	lui	a0,0x1
     45c:	77b50513          	add	a0,a0,1915 # 177b <digits+0x53>
     460:	00001097          	auipc	ra,0x1
     464:	a66080e7          	jalr	-1434(ra) # ec6 <sbrk>
     468:	b321                	j	170 <go+0xbe>
      int pid = fork();
     46a:	00001097          	auipc	ra,0x1
     46e:	9cc080e7          	jalr	-1588(ra) # e36 <fork>
      if(pid == 0){
     472:	f119                	bnez	a0,378 <go+0x2c6>
        fork();
     474:	00001097          	auipc	ra,0x1
     478:	9c2080e7          	jalr	-1598(ra) # e36 <fork>
        fork();
     47c:	00001097          	auipc	ra,0x1
     480:	9ba080e7          	jalr	-1606(ra) # e36 <fork>
        exit(0);
     484:	4501                	li	a0,0
     486:	00001097          	auipc	ra,0x1
     48a:	9b8080e7          	jalr	-1608(ra) # e3e <exit>
      int pid = fork();
     48e:	00001097          	auipc	ra,0x1
     492:	9a8080e7          	jalr	-1624(ra) # e36 <fork>
      if(pid == 0){
     496:	ee0511e3          	bnez	a0,378 <go+0x2c6>
     49a:	b7ed                	j	484 <go+0x3d2>
      unlink("../grindir/../a");
     49c:	00001517          	auipc	a0,0x1
     4a0:	fbc50513          	add	a0,a0,-68 # 1458 <malloc+0x1f0>
     4a4:	00001097          	auipc	ra,0x1
     4a8:	9ea080e7          	jalr	-1558(ra) # e8e <unlink>
      link(".././b", "/grindir/../a");
     4ac:	00001597          	auipc	a1,0x1
     4b0:	f2c58593          	add	a1,a1,-212 # 13d8 <malloc+0x170>
     4b4:	00001517          	auipc	a0,0x1
     4b8:	fb450513          	add	a0,a0,-76 # 1468 <malloc+0x200>
     4bc:	00001097          	auipc	ra,0x1
     4c0:	9e2080e7          	jalr	-1566(ra) # e9e <link>
     4c4:	b175                	j	170 <go+0xbe>
      unlink("b");
     4c6:	00001517          	auipc	a0,0x1
     4ca:	f7250513          	add	a0,a0,-142 # 1438 <malloc+0x1d0>
     4ce:	00001097          	auipc	ra,0x1
     4d2:	9c0080e7          	jalr	-1600(ra) # e8e <unlink>
      link("../grindir/./../a", "../b");
     4d6:	00001597          	auipc	a1,0x1
     4da:	efa58593          	add	a1,a1,-262 # 13d0 <malloc+0x168>
     4de:	00001517          	auipc	a0,0x1
     4e2:	f6250513          	add	a0,a0,-158 # 1440 <malloc+0x1d8>
     4e6:	00001097          	auipc	ra,0x1
     4ea:	9b8080e7          	jalr	-1608(ra) # e9e <link>
     4ee:	b149                	j	170 <go+0xbe>
      mkdir("/../b");
     4f0:	00001517          	auipc	a0,0x1
     4f4:	f2850513          	add	a0,a0,-216 # 1418 <malloc+0x1b0>
     4f8:	00001097          	auipc	ra,0x1
     4fc:	9ae080e7          	jalr	-1618(ra) # ea6 <mkdir>
      close(open("grindir/../b/b", O_CREATE|O_RDWR));
     500:	20200593          	li	a1,514
     504:	00001517          	auipc	a0,0x1
     508:	f1c50513          	add	a0,a0,-228 # 1420 <malloc+0x1b8>
     50c:	00001097          	auipc	ra,0x1
     510:	972080e7          	jalr	-1678(ra) # e7e <open>
     514:	00001097          	auipc	ra,0x1
     518:	952080e7          	jalr	-1710(ra) # e66 <close>
      unlink("b/b");
     51c:	00001517          	auipc	a0,0x1
     520:	f1450513          	add	a0,a0,-236 # 1430 <malloc+0x1c8>
     524:	00001097          	auipc	ra,0x1
     528:	96a080e7          	jalr	-1686(ra) # e8e <unlink>
     52c:	b191                	j	170 <go+0xbe>
      mkdir("grindir/../a");
     52e:	00001517          	auipc	a0,0x1
     532:	e7a50513          	add	a0,a0,-390 # 13a8 <malloc+0x140>
     536:	00001097          	auipc	ra,0x1
     53a:	970080e7          	jalr	-1680(ra) # ea6 <mkdir>
      close(open("a/../a/./a", O_CREATE|O_RDWR));
     53e:	20200593          	li	a1,514
     542:	00001517          	auipc	a0,0x1
     546:	ebe50513          	add	a0,a0,-322 # 1400 <malloc+0x198>
     54a:	00001097          	auipc	ra,0x1
     54e:	934080e7          	jalr	-1740(ra) # e7e <open>
     552:	00001097          	auipc	ra,0x1
     556:	914080e7          	jalr	-1772(ra) # e66 <close>
      unlink("a/a");
     55a:	00001517          	auipc	a0,0x1
     55e:	eb650513          	add	a0,a0,-330 # 1410 <malloc+0x1a8>
     562:	00001097          	auipc	ra,0x1
     566:	92c080e7          	jalr	-1748(ra) # e8e <unlink>
     56a:	b119                	j	170 <go+0xbe>
      read(fd, buf, sizeof(buf));
     56c:	3e700613          	li	a2,999
     570:	00002597          	auipc	a1,0x2
     574:	ab058593          	add	a1,a1,-1360 # 2020 <buf.0>
     578:	856a                	mv	a0,s10
     57a:	00001097          	auipc	ra,0x1
     57e:	8dc080e7          	jalr	-1828(ra) # e56 <read>
     582:	b6fd                	j	170 <go+0xbe>
      write(fd, buf, sizeof(buf));
     584:	3e700613          	li	a2,999
     588:	00002597          	auipc	a1,0x2
     58c:	a9858593          	add	a1,a1,-1384 # 2020 <buf.0>
     590:	856a                	mv	a0,s10
     592:	00001097          	auipc	ra,0x1
     596:	8cc080e7          	jalr	-1844(ra) # e5e <write>
     59a:	bed9                	j	170 <go+0xbe>
      close(fd);
     59c:	856a                	mv	a0,s10
     59e:	00001097          	auipc	ra,0x1
     5a2:	8c8080e7          	jalr	-1848(ra) # e66 <close>
      fd = open("/./grindir/./../b", O_CREATE|O_RDWR);
     5a6:	20200593          	li	a1,514
     5aa:	00001517          	auipc	a0,0x1
     5ae:	e3e50513          	add	a0,a0,-450 # 13e8 <malloc+0x180>
     5b2:	00001097          	auipc	ra,0x1
     5b6:	8cc080e7          	jalr	-1844(ra) # e7e <open>
     5ba:	8d2a                	mv	s10,a0
     5bc:	be55                	j	170 <go+0xbe>
      close(fd);
     5be:	856a                	mv	a0,s10
     5c0:	00001097          	auipc	ra,0x1
     5c4:	8a6080e7          	jalr	-1882(ra) # e66 <close>
      fd = open("/grindir/../a", O_CREATE|O_RDWR);
     5c8:	20200593          	li	a1,514
     5cc:	00001517          	auipc	a0,0x1
     5d0:	e0c50513          	add	a0,a0,-500 # 13d8 <malloc+0x170>
     5d4:	00001097          	auipc	ra,0x1
     5d8:	8aa080e7          	jalr	-1878(ra) # e7e <open>
     5dc:	8d2a                	mv	s10,a0
     5de:	be49                	j	170 <go+0xbe>
      if(chdir("grindir") != 0){
     5e0:	00001517          	auipc	a0,0x1
     5e4:	d8050513          	add	a0,a0,-640 # 1360 <malloc+0xf8>
     5e8:	00001097          	auipc	ra,0x1
     5ec:	8c6080e7          	jalr	-1850(ra) # eae <chdir>
     5f0:	b0051ae3          	bnez	a0,104 <go+0x52>
      unlink("../b");
     5f4:	00001517          	auipc	a0,0x1
     5f8:	ddc50513          	add	a0,a0,-548 # 13d0 <malloc+0x168>
     5fc:	00001097          	auipc	ra,0x1
     600:	892080e7          	jalr	-1902(ra) # e8e <unlink>
      chdir("/");
     604:	00001517          	auipc	a0,0x1
     608:	d8c50513          	add	a0,a0,-628 # 1390 <malloc+0x128>
     60c:	00001097          	auipc	ra,0x1
     610:	8a2080e7          	jalr	-1886(ra) # eae <chdir>
     614:	beb1                	j	170 <go+0xbe>
      unlink("grindir/../a");
     616:	00001517          	auipc	a0,0x1
     61a:	d9250513          	add	a0,a0,-622 # 13a8 <malloc+0x140>
     61e:	00001097          	auipc	ra,0x1
     622:	870080e7          	jalr	-1936(ra) # e8e <unlink>
     626:	b6a9                	j	170 <go+0xbe>
      close(open("grindir/../grindir/../b", O_CREATE|O_RDWR));
     628:	20200593          	li	a1,514
     62c:	00001517          	auipc	a0,0x1
     630:	d8c50513          	add	a0,a0,-628 # 13b8 <malloc+0x150>
     634:	00001097          	auipc	ra,0x1
     638:	84a080e7          	jalr	-1974(ra) # e7e <open>
     63c:	00001097          	auipc	ra,0x1
     640:	82a080e7          	jalr	-2006(ra) # e66 <close>
     644:	b635                	j	170 <go+0xbe>
      close(open("grindir/../a", O_CREATE|O_RDWR));
     646:	20200593          	li	a1,514
     64a:	00001517          	auipc	a0,0x1
     64e:	d5e50513          	add	a0,a0,-674 # 13a8 <malloc+0x140>
     652:	00001097          	auipc	ra,0x1
     656:	82c080e7          	jalr	-2004(ra) # e7e <open>
     65a:	00001097          	auipc	ra,0x1
     65e:	80c080e7          	jalr	-2036(ra) # e66 <close>
     662:	b639                	j	170 <go+0xbe>
     664:	00001c17          	auipc	s8,0x1
     668:	d34c0c13          	add	s8,s8,-716 # 1398 <malloc+0x130>
     66c:	b4f9                	j	13a <go+0x88>
        printf("grind: fork failed\n");
     66e:	00001517          	auipc	a0,0x1
     672:	e0250513          	add	a0,a0,-510 # 1470 <malloc+0x208>
     676:	00001097          	auipc	ra,0x1
     67a:	b22080e7          	jalr	-1246(ra) # 1198 <printf>
        exit(1);
     67e:	4505                	li	a0,1
     680:	00000097          	auipc	ra,0x0
     684:	7be080e7          	jalr	1982(ra) # e3e <exit>
        unlink("a");
     688:	00001517          	auipc	a0,0x1
     68c:	e0050513          	add	a0,a0,-512 # 1488 <malloc+0x220>
     690:	00000097          	auipc	ra,0x0
     694:	7fe080e7          	jalr	2046(ra) # e8e <unlink>
        mkdir("a");
     698:	00001517          	auipc	a0,0x1
     69c:	df050513          	add	a0,a0,-528 # 1488 <malloc+0x220>
     6a0:	00001097          	auipc	ra,0x1
     6a4:	806080e7          	jalr	-2042(ra) # ea6 <mkdir>
        chdir("a");
     6a8:	00001517          	auipc	a0,0x1
     6ac:	de050513          	add	a0,a0,-544 # 1488 <malloc+0x220>
     6b0:	00000097          	auipc	ra,0x0
     6b4:	7fe080e7          	jalr	2046(ra) # eae <chdir>
        unlink("../a");
     6b8:	00001517          	auipc	a0,0x1
     6bc:	e6050513          	add	a0,a0,-416 # 1518 <malloc+0x2b0>
     6c0:	00000097          	auipc	ra,0x0
     6c4:	7ce080e7          	jalr	1998(ra) # e8e <unlink>
        fd = open("x", O_CREATE|O_RDWR);
     6c8:	20200593          	li	a1,514
     6cc:	00001517          	auipc	a0,0x1
     6d0:	e0450513          	add	a0,a0,-508 # 14d0 <malloc+0x268>
     6d4:	00000097          	auipc	ra,0x0
     6d8:	7aa080e7          	jalr	1962(ra) # e7e <open>
        unlink("x");
     6dc:	00001517          	auipc	a0,0x1
     6e0:	df450513          	add	a0,a0,-524 # 14d0 <malloc+0x268>
     6e4:	00000097          	auipc	ra,0x0
     6e8:	7aa080e7          	jalr	1962(ra) # e8e <unlink>
        exit(0);
     6ec:	4501                	li	a0,0
     6ee:	00000097          	auipc	ra,0x0
     6f2:	750080e7          	jalr	1872(ra) # e3e <exit>
        fprintf(2, "grind: pipe failed\n");
     6f6:	4509                	li	a0,2
     6f8:	00001597          	auipc	a1,0x1
     6fc:	dc058593          	add	a1,a1,-576 # 14b8 <malloc+0x250>
     700:	00001097          	auipc	ra,0x1
     704:	a6a080e7          	jalr	-1430(ra) # 116a <fprintf>
        exit(1);
     708:	4505                	li	a0,1
     70a:	00000097          	auipc	ra,0x0
     70e:	734080e7          	jalr	1844(ra) # e3e <exit>
        close(open("a", O_CREATE|O_RDWR));
     712:	20200593          	li	a1,514
     716:	00001517          	auipc	a0,0x1
     71a:	d7250513          	add	a0,a0,-654 # 1488 <malloc+0x220>
     71e:	00000097          	auipc	ra,0x0
     722:	760080e7          	jalr	1888(ra) # e7e <open>
     726:	00000097          	auipc	ra,0x0
     72a:	740080e7          	jalr	1856(ra) # e66 <close>
        exit(0);
     72e:	4501                	li	a0,0
     730:	00000097          	auipc	ra,0x0
     734:	70e080e7          	jalr	1806(ra) # e3e <exit>
        fork();
     738:	00000097          	auipc	ra,0x0
     73c:	6fe080e7          	jalr	1790(ra) # e36 <fork>
        fork();
     740:	00000097          	auipc	ra,0x0
     744:	6f6080e7          	jalr	1782(ra) # e36 <fork>
        if(write(fds[1], "x", 1) != 1)
     748:	f7c42503          	lw	a0,-132(s0)
     74c:	4605                	li	a2,1
     74e:	00001597          	auipc	a1,0x1
     752:	d8258593          	add	a1,a1,-638 # 14d0 <malloc+0x268>
     756:	00000097          	auipc	ra,0x0
     75a:	708080e7          	jalr	1800(ra) # e5e <write>
     75e:	4785                	li	a5,1
     760:	00f50a63          	beq	a0,a5,774 <go+0x6c2>
          printf("grind: pipe write failed\n");
     764:	00001517          	auipc	a0,0x1
     768:	d7450513          	add	a0,a0,-652 # 14d8 <malloc+0x270>
     76c:	00001097          	auipc	ra,0x1
     770:	a2c080e7          	jalr	-1492(ra) # 1198 <printf>
        if(read(fds[0], &c, 1) != 1)
     774:	f7842503          	lw	a0,-136(s0)
     778:	4605                	li	a2,1
     77a:	f7040593          	add	a1,s0,-144
     77e:	00000097          	auipc	ra,0x0
     782:	6d8080e7          	jalr	1752(ra) # e56 <read>
     786:	4785                	li	a5,1
     788:	cef50ee3          	beq	a0,a5,484 <go+0x3d2>
          printf("grind: pipe read failed\n");
     78c:	00001517          	auipc	a0,0x1
     790:	d6c50513          	add	a0,a0,-660 # 14f8 <malloc+0x290>
     794:	00001097          	auipc	ra,0x1
     798:	a04080e7          	jalr	-1532(ra) # 1198 <printf>
     79c:	b1e5                	j	484 <go+0x3d2>
        printf("grind: pipe failed\n");
     79e:	00001517          	auipc	a0,0x1
     7a2:	d1a50513          	add	a0,a0,-742 # 14b8 <malloc+0x250>
     7a6:	00001097          	auipc	ra,0x1
     7aa:	9f2080e7          	jalr	-1550(ra) # 1198 <printf>
        exit(1);
     7ae:	4505                	li	a0,1
     7b0:	00000097          	auipc	ra,0x0
     7b4:	68e080e7          	jalr	1678(ra) # e3e <exit>
        printf("grind: write c failed\n");
     7b8:	00001517          	auipc	a0,0x1
     7bc:	d8850513          	add	a0,a0,-632 # 1540 <malloc+0x2d8>
     7c0:	00001097          	auipc	ra,0x1
     7c4:	9d8080e7          	jalr	-1576(ra) # 1198 <printf>
        exit(1);
     7c8:	4505                	li	a0,1
     7ca:	00000097          	auipc	ra,0x0
     7ce:	674080e7          	jalr	1652(ra) # e3e <exit>
        printf("grind: create c failed\n");
     7d2:	00001517          	auipc	a0,0x1
     7d6:	d5650513          	add	a0,a0,-682 # 1528 <malloc+0x2c0>
     7da:	00001097          	auipc	ra,0x1
     7de:	9be080e7          	jalr	-1602(ra) # 1198 <printf>
        exit(1);
     7e2:	4505                	li	a0,1
     7e4:	00000097          	auipc	ra,0x0
     7e8:	65a080e7          	jalr	1626(ra) # e3e <exit>
        printf("grind: fstat reports crazy i-number %d\n", st.ino);
     7ec:	00001517          	auipc	a0,0x1
     7f0:	dac50513          	add	a0,a0,-596 # 1598 <malloc+0x330>
     7f4:	00001097          	auipc	ra,0x1
     7f8:	9a4080e7          	jalr	-1628(ra) # 1198 <printf>
        exit(1);
     7fc:	4505                	li	a0,1
     7fe:	00000097          	auipc	ra,0x0
     802:	640080e7          	jalr	1600(ra) # e3e <exit>
        printf("grind: chdir failed\n");
     806:	00001517          	auipc	a0,0x1
     80a:	c9a50513          	add	a0,a0,-870 # 14a0 <malloc+0x238>
     80e:	00001097          	auipc	ra,0x1
     812:	98a080e7          	jalr	-1654(ra) # 1198 <printf>
        exit(1);
     816:	4505                	li	a0,1
     818:	00000097          	auipc	ra,0x0
     81c:	626080e7          	jalr	1574(ra) # e3e <exit>
        fprintf(2, "grind: fork failed\n");
     820:	4509                	li	a0,2
     822:	00001597          	auipc	a1,0x1
     826:	c4e58593          	add	a1,a1,-946 # 1470 <malloc+0x208>
     82a:	00001097          	auipc	ra,0x1
     82e:	940080e7          	jalr	-1728(ra) # 116a <fprintf>
        exit(3);
     832:	450d                	li	a0,3
     834:	00000097          	auipc	ra,0x0
     838:	60a080e7          	jalr	1546(ra) # e3e <exit>
        close(bb[0]);
     83c:	f7042503          	lw	a0,-144(s0)
     840:	00000097          	auipc	ra,0x0
     844:	626080e7          	jalr	1574(ra) # e66 <close>
        close(bb[1]);
     848:	f7442503          	lw	a0,-140(s0)
     84c:	00000097          	auipc	ra,0x0
     850:	61a080e7          	jalr	1562(ra) # e66 <close>
        close(aa[0]);
     854:	f6842503          	lw	a0,-152(s0)
     858:	00000097          	auipc	ra,0x0
     85c:	60e080e7          	jalr	1550(ra) # e66 <close>
        close(1);
     860:	4505                	li	a0,1
     862:	00000097          	auipc	ra,0x0
     866:	604080e7          	jalr	1540(ra) # e66 <close>
        if(dup(aa[1]) != 1){
     86a:	f6c42503          	lw	a0,-148(s0)
     86e:	00000097          	auipc	ra,0x0
     872:	648080e7          	jalr	1608(ra) # eb6 <dup>
     876:	4785                	li	a5,1
     878:	10f50163          	beq	a0,a5,97a <go+0x8c8>
          fprintf(2, "grind: dup failed\n");
     87c:	4509                	li	a0,2
     87e:	00001597          	auipc	a1,0x1
     882:	d4258593          	add	a1,a1,-702 # 15c0 <malloc+0x358>
     886:	00001097          	auipc	ra,0x1
     88a:	8e4080e7          	jalr	-1820(ra) # 116a <fprintf>
          exit(1);
     88e:	4505                	li	a0,1
     890:	00000097          	auipc	ra,0x0
     894:	5ae080e7          	jalr	1454(ra) # e3e <exit>
        printf("grind: fstat reports wrong size %d\n", (int)st.size);
     898:	00001517          	auipc	a0,0x1
     89c:	cd850513          	add	a0,a0,-808 # 1570 <malloc+0x308>
     8a0:	2581                	sext.w	a1,a1
     8a2:	00001097          	auipc	ra,0x1
     8a6:	8f6080e7          	jalr	-1802(ra) # 1198 <printf>
        exit(1);
     8aa:	4505                	li	a0,1
     8ac:	00000097          	auipc	ra,0x0
     8b0:	592080e7          	jalr	1426(ra) # e3e <exit>
        fprintf(2, "grind: fork failed\n");
     8b4:	4509                	li	a0,2
     8b6:	00001597          	auipc	a1,0x1
     8ba:	bba58593          	add	a1,a1,-1094 # 1470 <malloc+0x208>
     8be:	00001097          	auipc	ra,0x1
     8c2:	8ac080e7          	jalr	-1876(ra) # 116a <fprintf>
        exit(7);
     8c6:	451d                	li	a0,7
     8c8:	00000097          	auipc	ra,0x0
     8cc:	576080e7          	jalr	1398(ra) # e3e <exit>
        close(aa[1]);
     8d0:	f6c42503          	lw	a0,-148(s0)
     8d4:	00000097          	auipc	ra,0x0
     8d8:	592080e7          	jalr	1426(ra) # e66 <close>
        close(bb[0]);
     8dc:	f7042503          	lw	a0,-144(s0)
     8e0:	00000097          	auipc	ra,0x0
     8e4:	586080e7          	jalr	1414(ra) # e66 <close>
        close(0);
     8e8:	4501                	li	a0,0
     8ea:	00000097          	auipc	ra,0x0
     8ee:	57c080e7          	jalr	1404(ra) # e66 <close>
        if(dup(aa[0]) != 0){
     8f2:	f6842503          	lw	a0,-152(s0)
     8f6:	00000097          	auipc	ra,0x0
     8fa:	5c0080e7          	jalr	1472(ra) # eb6 <dup>
     8fe:	cd05                	beqz	a0,936 <go+0x884>
          fprintf(2, "grind: dup failed\n");
     900:	4509                	li	a0,2
     902:	00001597          	auipc	a1,0x1
     906:	cbe58593          	add	a1,a1,-834 # 15c0 <malloc+0x358>
     90a:	00001097          	auipc	ra,0x1
     90e:	860080e7          	jalr	-1952(ra) # 116a <fprintf>
          exit(4);
     912:	4511                	li	a0,4
     914:	00000097          	auipc	ra,0x0
     918:	52a080e7          	jalr	1322(ra) # e3e <exit>
        printf("grind: fstat failed\n");
     91c:	00001517          	auipc	a0,0x1
     920:	c3c50513          	add	a0,a0,-964 # 1558 <malloc+0x2f0>
     924:	00001097          	auipc	ra,0x1
     928:	874080e7          	jalr	-1932(ra) # 1198 <printf>
        exit(1);
     92c:	4505                	li	a0,1
     92e:	00000097          	auipc	ra,0x0
     932:	510080e7          	jalr	1296(ra) # e3e <exit>
        close(aa[0]);
     936:	f6842503          	lw	a0,-152(s0)
     93a:	00000097          	auipc	ra,0x0
     93e:	52c080e7          	jalr	1324(ra) # e66 <close>
        close(1);
     942:	4505                	li	a0,1
     944:	00000097          	auipc	ra,0x0
     948:	522080e7          	jalr	1314(ra) # e66 <close>
        if(dup(bb[1]) != 1){
     94c:	f7442503          	lw	a0,-140(s0)
     950:	00000097          	auipc	ra,0x0
     954:	566080e7          	jalr	1382(ra) # eb6 <dup>
     958:	4785                	li	a5,1
     95a:	06f50c63          	beq	a0,a5,9d2 <go+0x920>
          fprintf(2, "grind: dup failed\n");
     95e:	4509                	li	a0,2
     960:	00001597          	auipc	a1,0x1
     964:	c6058593          	add	a1,a1,-928 # 15c0 <malloc+0x358>
     968:	00001097          	auipc	ra,0x1
     96c:	802080e7          	jalr	-2046(ra) # 116a <fprintf>
          exit(5);
     970:	4515                	li	a0,5
     972:	00000097          	auipc	ra,0x0
     976:	4cc080e7          	jalr	1228(ra) # e3e <exit>
        close(aa[1]);
     97a:	f6c42503          	lw	a0,-148(s0)
     97e:	00000097          	auipc	ra,0x0
     982:	4e8080e7          	jalr	1256(ra) # e66 <close>
        char *args[3] = { "echo", "hi", 0 };
     986:	00001797          	auipc	a5,0x1
     98a:	c5278793          	add	a5,a5,-942 # 15d8 <malloc+0x370>
        exec("grindir/../echo", args);
     98e:	f7840593          	add	a1,s0,-136
        char *args[3] = { "echo", "hi", 0 };
     992:	f6f43c23          	sd	a5,-136(s0)
        exec("grindir/../echo", args);
     996:	00001517          	auipc	a0,0x1
     99a:	c5250513          	add	a0,a0,-942 # 15e8 <malloc+0x380>
        char *args[3] = { "echo", "hi", 0 };
     99e:	00001797          	auipc	a5,0x1
     9a2:	c4278793          	add	a5,a5,-958 # 15e0 <malloc+0x378>
     9a6:	f8f43023          	sd	a5,-128(s0)
     9aa:	f8043423          	sd	zero,-120(s0)
        exec("grindir/../echo", args);
     9ae:	00000097          	auipc	ra,0x0
     9b2:	4c8080e7          	jalr	1224(ra) # e76 <exec>
        fprintf(2, "grind: echo: not found\n");
     9b6:	4509                	li	a0,2
     9b8:	00001597          	auipc	a1,0x1
     9bc:	c4058593          	add	a1,a1,-960 # 15f8 <malloc+0x390>
     9c0:	00000097          	auipc	ra,0x0
     9c4:	7aa080e7          	jalr	1962(ra) # 116a <fprintf>
        exit(2);
     9c8:	4509                	li	a0,2
     9ca:	00000097          	auipc	ra,0x0
     9ce:	474080e7          	jalr	1140(ra) # e3e <exit>
        close(bb[1]);
     9d2:	f7442503          	lw	a0,-140(s0)
     9d6:	00000097          	auipc	ra,0x0
     9da:	490080e7          	jalr	1168(ra) # e66 <close>
        char *args[2] = { "cat", 0 };
     9de:	00001797          	auipc	a5,0x1
     9e2:	c3278793          	add	a5,a5,-974 # 1610 <malloc+0x3a8>
        exec("/cat", args);
     9e6:	f7840593          	add	a1,s0,-136
     9ea:	00001517          	auipc	a0,0x1
     9ee:	c2e50513          	add	a0,a0,-978 # 1618 <malloc+0x3b0>
        char *args[2] = { "cat", 0 };
     9f2:	f6f43c23          	sd	a5,-136(s0)
     9f6:	f8043023          	sd	zero,-128(s0)
        exec("/cat", args);
     9fa:	00000097          	auipc	ra,0x0
     9fe:	47c080e7          	jalr	1148(ra) # e76 <exec>
        fprintf(2, "grind: cat: not found\n");
     a02:	4509                	li	a0,2
     a04:	00001597          	auipc	a1,0x1
     a08:	c1c58593          	add	a1,a1,-996 # 1620 <malloc+0x3b8>
     a0c:	00000097          	auipc	ra,0x0
     a10:	75e080e7          	jalr	1886(ra) # 116a <fprintf>
        exit(6);
     a14:	4519                	li	a0,6
     a16:	00000097          	auipc	ra,0x0
     a1a:	428080e7          	jalr	1064(ra) # e3e <exit>

0000000000000a1e <iter>:
  }
}

void
iter()
{
     a1e:	7179                	add	sp,sp,-48
     a20:	f406                	sd	ra,40(sp)
     a22:	f022                	sd	s0,32(sp)
     a24:	ec26                	sd	s1,24(sp)
     a26:	1800                	add	s0,sp,48
     a28:	e84a                	sd	s2,16(sp)
  unlink("a");
     a2a:	00001517          	auipc	a0,0x1
     a2e:	a5e50513          	add	a0,a0,-1442 # 1488 <malloc+0x220>
     a32:	00000097          	auipc	ra,0x0
     a36:	45c080e7          	jalr	1116(ra) # e8e <unlink>
  unlink("b");
     a3a:	00001517          	auipc	a0,0x1
     a3e:	9fe50513          	add	a0,a0,-1538 # 1438 <malloc+0x1d0>
     a42:	00000097          	auipc	ra,0x0
     a46:	44c080e7          	jalr	1100(ra) # e8e <unlink>
  
  int pid1 = fork();
     a4a:	00000097          	auipc	ra,0x0
     a4e:	3ec080e7          	jalr	1004(ra) # e36 <fork>
  if(pid1 < 0){
     a52:	06054263          	bltz	a0,ab6 <iter+0x98>
     a56:	84aa                	mv	s1,a0
    printf("grind: fork failed\n");
    exit(1);
  }
  if(pid1 == 0){
     a58:	c139                	beqz	a0,a9e <iter+0x80>
    rand_next ^= 31;
    go(0);
    exit(0);
  }

  int pid2 = fork();
     a5a:	00000097          	auipc	ra,0x0
     a5e:	3dc080e7          	jalr	988(ra) # e36 <fork>
     a62:	892a                	mv	s2,a0
  if(pid2 < 0){
     a64:	04054963          	bltz	a0,ab6 <iter+0x98>
    printf("grind: fork failed\n");
    exit(1);
  }
  if(pid2 == 0){
     a68:	c525                	beqz	a0,ad0 <iter+0xb2>
    rand_next ^= 7177;
    go(1);
    exit(0);
  }

  int st1 = -1;
     a6a:	57fd                	li	a5,-1
  wait(&st1);
     a6c:	fd840513          	add	a0,s0,-40
  int st1 = -1;
     a70:	fcf42c23          	sw	a5,-40(s0)
  wait(&st1);
     a74:	00000097          	auipc	ra,0x0
     a78:	3d2080e7          	jalr	978(ra) # e46 <wait>
  if(st1 != 0){
     a7c:	fd842783          	lw	a5,-40(s0)
     a80:	e7bd                	bnez	a5,aee <iter+0xd0>
    kill(pid1);
    kill(pid2);
  }
  int st2 = -1;
     a82:	57fd                	li	a5,-1
  wait(&st2);
     a84:	fdc40513          	add	a0,s0,-36
  int st2 = -1;
     a88:	fcf42e23          	sw	a5,-36(s0)
  wait(&st2);
     a8c:	00000097          	auipc	ra,0x0
     a90:	3ba080e7          	jalr	954(ra) # e46 <wait>

  exit(0);
     a94:	4501                	li	a0,0
     a96:	00000097          	auipc	ra,0x0
     a9a:	3a8080e7          	jalr	936(ra) # e3e <exit>
    rand_next ^= 31;
     a9e:	00001717          	auipc	a4,0x1
     aa2:	56270713          	add	a4,a4,1378 # 2000 <rand_next>
     aa6:	631c                	ld	a5,0(a4)
     aa8:	01f7c793          	xor	a5,a5,31
     aac:	e31c                	sd	a5,0(a4)
    go(0);
     aae:	fffff097          	auipc	ra,0xfffff
     ab2:	604080e7          	jalr	1540(ra) # b2 <go>
    printf("grind: fork failed\n");
     ab6:	00001517          	auipc	a0,0x1
     aba:	9ba50513          	add	a0,a0,-1606 # 1470 <malloc+0x208>
     abe:	00000097          	auipc	ra,0x0
     ac2:	6da080e7          	jalr	1754(ra) # 1198 <printf>
    exit(1);
     ac6:	4505                	li	a0,1
     ac8:	00000097          	auipc	ra,0x0
     acc:	376080e7          	jalr	886(ra) # e3e <exit>
    rand_next ^= 7177;
     ad0:	00001697          	auipc	a3,0x1
     ad4:	53068693          	add	a3,a3,1328 # 2000 <rand_next>
     ad8:	629c                	ld	a5,0(a3)
     ada:	6709                	lui	a4,0x2
     adc:	c0970713          	add	a4,a4,-1015 # 1c09 <digits+0x4e1>
     ae0:	8fb9                	xor	a5,a5,a4
    go(1);
     ae2:	4505                	li	a0,1
    rand_next ^= 7177;
     ae4:	e29c                	sd	a5,0(a3)
    go(1);
     ae6:	fffff097          	auipc	ra,0xfffff
     aea:	5cc080e7          	jalr	1484(ra) # b2 <go>
    kill(pid1);
     aee:	8526                	mv	a0,s1
     af0:	00000097          	auipc	ra,0x0
     af4:	37e080e7          	jalr	894(ra) # e6e <kill>
    kill(pid2);
     af8:	854a                	mv	a0,s2
     afa:	00000097          	auipc	ra,0x0
     afe:	374080e7          	jalr	884(ra) # e6e <kill>
     b02:	b741                	j	a82 <iter+0x64>

0000000000000b04 <main>:
}

int
main()
{
     b04:	1101                	add	sp,sp,-32
     b06:	e822                	sd	s0,16(sp)
     b08:	e426                	sd	s1,8(sp)
     b0a:	ec06                	sd	ra,24(sp)
     b0c:	1000                	add	s0,sp,32
    }
    if(pid > 0){
      wait(0);
    }
    sleep(20);
    rand_next += 1;
     b0e:	00001497          	auipc	s1,0x1
     b12:	4f248493          	add	s1,s1,1266 # 2000 <rand_next>
     b16:	a005                	j	b36 <main+0x32>
    if(pid > 0){
     b18:	00a05763          	blez	a0,b26 <main+0x22>
      wait(0);
     b1c:	4501                	li	a0,0
     b1e:	00000097          	auipc	ra,0x0
     b22:	328080e7          	jalr	808(ra) # e46 <wait>
    sleep(20);
     b26:	4551                	li	a0,20
     b28:	00000097          	auipc	ra,0x0
     b2c:	3a6080e7          	jalr	934(ra) # ece <sleep>
    rand_next += 1;
     b30:	609c                	ld	a5,0(s1)
     b32:	0785                	add	a5,a5,1
     b34:	e09c                	sd	a5,0(s1)
    int pid = fork();
     b36:	00000097          	auipc	ra,0x0
     b3a:	300080e7          	jalr	768(ra) # e36 <fork>
    if(pid == 0){
     b3e:	fd69                	bnez	a0,b18 <main+0x14>
      iter();
     b40:	00000097          	auipc	ra,0x0
     b44:	ede080e7          	jalr	-290(ra) # a1e <iter>

0000000000000b48 <_main>:
//
// wrapper so that it's OK if main() does not call exit().
//
void
_main()
{
     b48:	1141                	add	sp,sp,-16
     b4a:	e022                	sd	s0,0(sp)
     b4c:	e406                	sd	ra,8(sp)
     b4e:	0800                	add	s0,sp,16
  extern int main();
  main();
     b50:	00000097          	auipc	ra,0x0
     b54:	fb4080e7          	jalr	-76(ra) # b04 <main>
  exit(0);
     b58:	4501                	li	a0,0
     b5a:	00000097          	auipc	ra,0x0
     b5e:	2e4080e7          	jalr	740(ra) # e3e <exit>

0000000000000b62 <strcpy>:
}

char*
strcpy(char *s, const char *t)
{
     b62:	1141                	add	sp,sp,-16
     b64:	e422                	sd	s0,8(sp)
     b66:	0800                	add	s0,sp,16
  char *os;

  os = s;
  while((*s++ = *t++) != 0)
     b68:	87aa                	mv	a5,a0
     b6a:	0005c703          	lbu	a4,0(a1)
     b6e:	0785                	add	a5,a5,1
     b70:	0585                	add	a1,a1,1
     b72:	fee78fa3          	sb	a4,-1(a5)
     b76:	fb75                	bnez	a4,b6a <strcpy+0x8>
    ;
  return os;
}
     b78:	6422                	ld	s0,8(sp)
     b7a:	0141                	add	sp,sp,16
     b7c:	8082                	ret

0000000000000b7e <strcmp>:

int
strcmp(const char *p, const char *q)
{
     b7e:	1141                	add	sp,sp,-16
     b80:	e422                	sd	s0,8(sp)
     b82:	0800                	add	s0,sp,16
  while(*p && *p == *q)
     b84:	00054783          	lbu	a5,0(a0)
     b88:	e791                	bnez	a5,b94 <strcmp+0x16>
     b8a:	a80d                	j	bbc <strcmp+0x3e>
     b8c:	00054783          	lbu	a5,0(a0)
     b90:	cf99                	beqz	a5,bae <strcmp+0x30>
     b92:	85b6                	mv	a1,a3
     b94:	0005c703          	lbu	a4,0(a1)
    p++, q++;
     b98:	0505                	add	a0,a0,1
     b9a:	00158693          	add	a3,a1,1
  while(*p && *p == *q)
     b9e:	fef707e3          	beq	a4,a5,b8c <strcmp+0xe>
  return (uchar)*p - (uchar)*q;
     ba2:	0007851b          	sext.w	a0,a5
}
     ba6:	6422                	ld	s0,8(sp)
     ba8:	9d19                	subw	a0,a0,a4
     baa:	0141                	add	sp,sp,16
     bac:	8082                	ret
  return (uchar)*p - (uchar)*q;
     bae:	0015c703          	lbu	a4,1(a1)
}
     bb2:	6422                	ld	s0,8(sp)
  return (uchar)*p - (uchar)*q;
     bb4:	4501                	li	a0,0
}
     bb6:	9d19                	subw	a0,a0,a4
     bb8:	0141                	add	sp,sp,16
     bba:	8082                	ret
  return (uchar)*p - (uchar)*q;
     bbc:	0005c703          	lbu	a4,0(a1)
     bc0:	4501                	li	a0,0
     bc2:	b7d5                	j	ba6 <strcmp+0x28>

0000000000000bc4 <strlen>:

uint
strlen(const char *s)
{
     bc4:	1141                	add	sp,sp,-16
     bc6:	e422                	sd	s0,8(sp)
     bc8:	0800                	add	s0,sp,16
  int n;

  for(n = 0; s[n]; n++)
     bca:	00054783          	lbu	a5,0(a0)
     bce:	cf91                	beqz	a5,bea <strlen+0x26>
     bd0:	0505                	add	a0,a0,1
     bd2:	87aa                	mv	a5,a0
     bd4:	0007c703          	lbu	a4,0(a5)
     bd8:	86be                	mv	a3,a5
     bda:	0785                	add	a5,a5,1
     bdc:	ff65                	bnez	a4,bd4 <strlen+0x10>
    ;
  return n;
}
     bde:	6422                	ld	s0,8(sp)
     be0:	40a6853b          	subw	a0,a3,a0
     be4:	2505                	addw	a0,a0,1
     be6:	0141                	add	sp,sp,16
     be8:	8082                	ret
     bea:	6422                	ld	s0,8(sp)
  for(n = 0; s[n]; n++)
     bec:	4501                	li	a0,0
}
     bee:	0141                	add	sp,sp,16
     bf0:	8082                	ret

0000000000000bf2 <memset>:

void*
memset(void *dst, int c, uint n)
{
     bf2:	1141                	add	sp,sp,-16
     bf4:	e422                	sd	s0,8(sp)
     bf6:	0800                	add	s0,sp,16
  char *cdst = (char *) dst;
  int i;
  for(i = 0; i < n; i++){
     bf8:	ce09                	beqz	a2,c12 <memset+0x20>
     bfa:	1602                	sll	a2,a2,0x20
     bfc:	9201                	srl	a2,a2,0x20
    cdst[i] = c;
     bfe:	0ff5f593          	zext.b	a1,a1
     c02:	87aa                	mv	a5,a0
     c04:	00a60733          	add	a4,a2,a0
     c08:	00b78023          	sb	a1,0(a5)
  for(i = 0; i < n; i++){
     c0c:	0785                	add	a5,a5,1
     c0e:	fee79de3          	bne	a5,a4,c08 <memset+0x16>
  }
  return dst;
}
     c12:	6422                	ld	s0,8(sp)
     c14:	0141                	add	sp,sp,16
     c16:	8082                	ret

0000000000000c18 <strchr>:

char*
strchr(const char *s, char c)
{
     c18:	1141                	add	sp,sp,-16
     c1a:	e422                	sd	s0,8(sp)
     c1c:	0800                	add	s0,sp,16
  for(; *s; s++)
     c1e:	00054783          	lbu	a5,0(a0)
     c22:	c799                	beqz	a5,c30 <strchr+0x18>
    if(*s == c)
     c24:	00f58763          	beq	a1,a5,c32 <strchr+0x1a>
  for(; *s; s++)
     c28:	00154783          	lbu	a5,1(a0)
     c2c:	0505                	add	a0,a0,1
     c2e:	fbfd                	bnez	a5,c24 <strchr+0xc>
      return (char*)s;
  return 0;
     c30:	4501                	li	a0,0
}
     c32:	6422                	ld	s0,8(sp)
     c34:	0141                	add	sp,sp,16
     c36:	8082                	ret

0000000000000c38 <gets>:

char*
gets(char *buf, int max)
{
     c38:	711d                	add	sp,sp,-96
     c3a:	e8a2                	sd	s0,80(sp)
     c3c:	e4a6                	sd	s1,72(sp)
     c3e:	e0ca                	sd	s2,64(sp)
     c40:	fc4e                	sd	s3,56(sp)
     c42:	f852                	sd	s4,48(sp)
     c44:	f05a                	sd	s6,32(sp)
     c46:	ec5e                	sd	s7,24(sp)
     c48:	ec86                	sd	ra,88(sp)
     c4a:	f456                	sd	s5,40(sp)
     c4c:	1080                	add	s0,sp,96
     c4e:	8baa                	mv	s7,a0
     c50:	89ae                	mv	s3,a1
     c52:	892a                	mv	s2,a0
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
     c54:	4481                	li	s1,0
    cc = read(0, &c, 1);
    if(cc < 1)
      break;
    buf[i++] = c;
    if(c == '\n' || c == '\r')
     c56:	4a29                	li	s4,10
     c58:	4b35                	li	s6,13
  for(i=0; i+1 < max; ){
     c5a:	a005                	j	c7a <gets+0x42>
    cc = read(0, &c, 1);
     c5c:	00000097          	auipc	ra,0x0
     c60:	1fa080e7          	jalr	506(ra) # e56 <read>
    if(cc < 1)
     c64:	02a05363          	blez	a0,c8a <gets+0x52>
    buf[i++] = c;
     c68:	faf44783          	lbu	a5,-81(s0)
    if(c == '\n' || c == '\r')
     c6c:	0905                	add	s2,s2,1
    buf[i++] = c;
     c6e:	fef90fa3          	sb	a5,-1(s2)
    if(c == '\n' || c == '\r')
     c72:	01478d63          	beq	a5,s4,c8c <gets+0x54>
     c76:	01678b63          	beq	a5,s6,c8c <gets+0x54>
  for(i=0; i+1 < max; ){
     c7a:	8aa6                	mv	s5,s1
     c7c:	2485                	addw	s1,s1,1
    cc = read(0, &c, 1);
     c7e:	4605                	li	a2,1
     c80:	faf40593          	add	a1,s0,-81
     c84:	4501                	li	a0,0
  for(i=0; i+1 < max; ){
     c86:	fd34cbe3          	blt	s1,s3,c5c <gets+0x24>
     c8a:	84d6                	mv	s1,s5
      break;
  }
  buf[i] = '\0';
     c8c:	94de                	add	s1,s1,s7
     c8e:	00048023          	sb	zero,0(s1)
  return buf;
}
     c92:	60e6                	ld	ra,88(sp)
     c94:	6446                	ld	s0,80(sp)
     c96:	64a6                	ld	s1,72(sp)
     c98:	6906                	ld	s2,64(sp)
     c9a:	79e2                	ld	s3,56(sp)
     c9c:	7a42                	ld	s4,48(sp)
     c9e:	7aa2                	ld	s5,40(sp)
     ca0:	7b02                	ld	s6,32(sp)
     ca2:	855e                	mv	a0,s7
     ca4:	6be2                	ld	s7,24(sp)
     ca6:	6125                	add	sp,sp,96
     ca8:	8082                	ret

0000000000000caa <stat>:

int
stat(const char *n, struct stat *st)
{
     caa:	1101                	add	sp,sp,-32
     cac:	e822                	sd	s0,16(sp)
     cae:	e04a                	sd	s2,0(sp)
     cb0:	ec06                	sd	ra,24(sp)
     cb2:	e426                	sd	s1,8(sp)
     cb4:	1000                	add	s0,sp,32
     cb6:	892e                	mv	s2,a1
  int fd;
  int r;

  fd = open(n, O_RDONLY);
     cb8:	4581                	li	a1,0
     cba:	00000097          	auipc	ra,0x0
     cbe:	1c4080e7          	jalr	452(ra) # e7e <open>
  if(fd < 0)
     cc2:	02054663          	bltz	a0,cee <stat+0x44>
    return -1;
  r = fstat(fd, st);
     cc6:	85ca                	mv	a1,s2
     cc8:	84aa                	mv	s1,a0
     cca:	00000097          	auipc	ra,0x0
     cce:	1cc080e7          	jalr	460(ra) # e96 <fstat>
     cd2:	87aa                	mv	a5,a0
  close(fd);
     cd4:	8526                	mv	a0,s1
  r = fstat(fd, st);
     cd6:	84be                	mv	s1,a5
  close(fd);
     cd8:	00000097          	auipc	ra,0x0
     cdc:	18e080e7          	jalr	398(ra) # e66 <close>
  return r;
}
     ce0:	60e2                	ld	ra,24(sp)
     ce2:	6442                	ld	s0,16(sp)
     ce4:	6902                	ld	s2,0(sp)
     ce6:	8526                	mv	a0,s1
     ce8:	64a2                	ld	s1,8(sp)
     cea:	6105                	add	sp,sp,32
     cec:	8082                	ret
    return -1;
     cee:	54fd                	li	s1,-1
     cf0:	bfc5                	j	ce0 <stat+0x36>

0000000000000cf2 <atoi>:

int
atoi(const char *s)
{
     cf2:	1141                	add	sp,sp,-16
     cf4:	e422                	sd	s0,8(sp)
     cf6:	0800                	add	s0,sp,16
  int n;

  n = 0;
  while('0' <= *s && *s <= '9')
     cf8:	00054683          	lbu	a3,0(a0)
     cfc:	4625                	li	a2,9
     cfe:	fd06879b          	addw	a5,a3,-48
     d02:	0ff7f793          	zext.b	a5,a5
     d06:	02f66863          	bltu	a2,a5,d36 <atoi+0x44>
     d0a:	872a                	mv	a4,a0
  n = 0;
     d0c:	4501                	li	a0,0
    n = n*10 + *s++ - '0';
     d0e:	0025179b          	sllw	a5,a0,0x2
     d12:	9fa9                	addw	a5,a5,a0
     d14:	0705                	add	a4,a4,1
     d16:	0017979b          	sllw	a5,a5,0x1
     d1a:	9fb5                	addw	a5,a5,a3
  while('0' <= *s && *s <= '9')
     d1c:	00074683          	lbu	a3,0(a4)
    n = n*10 + *s++ - '0';
     d20:	fd07851b          	addw	a0,a5,-48
  while('0' <= *s && *s <= '9')
     d24:	fd06879b          	addw	a5,a3,-48
     d28:	0ff7f793          	zext.b	a5,a5
     d2c:	fef671e3          	bgeu	a2,a5,d0e <atoi+0x1c>
  return n;
}
     d30:	6422                	ld	s0,8(sp)
     d32:	0141                	add	sp,sp,16
     d34:	8082                	ret
     d36:	6422                	ld	s0,8(sp)
  n = 0;
     d38:	4501                	li	a0,0
}
     d3a:	0141                	add	sp,sp,16
     d3c:	8082                	ret

0000000000000d3e <memmove>:

void*
memmove(void *vdst, const void *vsrc, int n)
{
     d3e:	1141                	add	sp,sp,-16
     d40:	e422                	sd	s0,8(sp)
     d42:	0800                	add	s0,sp,16
  char *dst;
  const char *src;

  dst = vdst;
  src = vsrc;
  if (src > dst) {
     d44:	02b57463          	bgeu	a0,a1,d6c <memmove+0x2e>
    while(n-- > 0)
     d48:	00c05f63          	blez	a2,d66 <memmove+0x28>
     d4c:	1602                	sll	a2,a2,0x20
     d4e:	9201                	srl	a2,a2,0x20
     d50:	00c507b3          	add	a5,a0,a2
  dst = vdst;
     d54:	872a                	mv	a4,a0
      *dst++ = *src++;
     d56:	0005c683          	lbu	a3,0(a1)
     d5a:	0705                	add	a4,a4,1
     d5c:	0585                	add	a1,a1,1
     d5e:	fed70fa3          	sb	a3,-1(a4)
    while(n-- > 0)
     d62:	fef71ae3          	bne	a4,a5,d56 <memmove+0x18>
    src += n;
    while(n-- > 0)
      *--dst = *--src;
  }
  return vdst;
}
     d66:	6422                	ld	s0,8(sp)
     d68:	0141                	add	sp,sp,16
     d6a:	8082                	ret
    dst += n;
     d6c:	00c50733          	add	a4,a0,a2
    src += n;
     d70:	95b2                	add	a1,a1,a2
    while(n-- > 0)
     d72:	fec05ae3          	blez	a2,d66 <memmove+0x28>
     d76:	fff6079b          	addw	a5,a2,-1
     d7a:	1782                	sll	a5,a5,0x20
     d7c:	9381                	srl	a5,a5,0x20
     d7e:	fff7c793          	not	a5,a5
     d82:	97ae                	add	a5,a5,a1
      *--dst = *--src;
     d84:	fff5c683          	lbu	a3,-1(a1)
     d88:	15fd                	add	a1,a1,-1
     d8a:	177d                	add	a4,a4,-1
     d8c:	00d70023          	sb	a3,0(a4)
    while(n-- > 0)
     d90:	feb79ae3          	bne	a5,a1,d84 <memmove+0x46>
}
     d94:	6422                	ld	s0,8(sp)
     d96:	0141                	add	sp,sp,16
     d98:	8082                	ret

0000000000000d9a <memcmp>:

int
memcmp(const void *s1, const void *s2, uint n)
{
     d9a:	1141                	add	sp,sp,-16
     d9c:	e422                	sd	s0,8(sp)
     d9e:	0800                	add	s0,sp,16
  const char *p1 = s1, *p2 = s2;
  while (n-- > 0) {
     da0:	c61d                	beqz	a2,dce <memcmp+0x34>
     da2:	fff6069b          	addw	a3,a2,-1
     da6:	1682                	sll	a3,a3,0x20
     da8:	9281                	srl	a3,a3,0x20
     daa:	0685                	add	a3,a3,1
     dac:	96aa                	add	a3,a3,a0
     dae:	a019                	j	db4 <memcmp+0x1a>
     db0:	00a68f63          	beq	a3,a0,dce <memcmp+0x34>
    if (*p1 != *p2) {
     db4:	00054783          	lbu	a5,0(a0)
     db8:	0005c703          	lbu	a4,0(a1)
      return *p1 - *p2;
    }
    p1++;
     dbc:	0505                	add	a0,a0,1
    p2++;
     dbe:	0585                	add	a1,a1,1
    if (*p1 != *p2) {
     dc0:	fee788e3          	beq	a5,a4,db0 <memcmp+0x16>
  }
  return 0;
}
     dc4:	6422                	ld	s0,8(sp)
      return *p1 - *p2;
     dc6:	40e7853b          	subw	a0,a5,a4
}
     dca:	0141                	add	sp,sp,16
     dcc:	8082                	ret
     dce:	6422                	ld	s0,8(sp)
  return 0;
     dd0:	4501                	li	a0,0
}
     dd2:	0141                	add	sp,sp,16
     dd4:	8082                	ret

0000000000000dd6 <memcpy>:

void *
memcpy(void *dst, const void *src, uint n)
{
     dd6:	1141                	add	sp,sp,-16
     dd8:	e422                	sd	s0,8(sp)
     dda:	0800                	add	s0,sp,16
  return memmove(dst, src, n);
     ddc:	0006079b          	sext.w	a5,a2
  if (src > dst) {
     de0:	02b57463          	bgeu	a0,a1,e08 <memcpy+0x32>
    while(n-- > 0)
     de4:	00f05f63          	blez	a5,e02 <memcpy+0x2c>
     de8:	1602                	sll	a2,a2,0x20
     dea:	9201                	srl	a2,a2,0x20
     dec:	00c587b3          	add	a5,a1,a2
  dst = vdst;
     df0:	872a                	mv	a4,a0
      *dst++ = *src++;
     df2:	0005c683          	lbu	a3,0(a1)
     df6:	0585                	add	a1,a1,1
     df8:	0705                	add	a4,a4,1
     dfa:	fed70fa3          	sb	a3,-1(a4)
    while(n-- > 0)
     dfe:	fef59ae3          	bne	a1,a5,df2 <memcpy+0x1c>
}
     e02:	6422                	ld	s0,8(sp)
     e04:	0141                	add	sp,sp,16
     e06:	8082                	ret
    dst += n;
     e08:	00f50733          	add	a4,a0,a5
    src += n;
     e0c:	95be                	add	a1,a1,a5
    while(n-- > 0)
     e0e:	fef05ae3          	blez	a5,e02 <memcpy+0x2c>
     e12:	fff6079b          	addw	a5,a2,-1
     e16:	1782                	sll	a5,a5,0x20
     e18:	9381                	srl	a5,a5,0x20
     e1a:	fff7c793          	not	a5,a5
     e1e:	97ae                	add	a5,a5,a1
      *--dst = *--src;
     e20:	fff5c683          	lbu	a3,-1(a1)
     e24:	15fd                	add	a1,a1,-1
     e26:	177d                	add	a4,a4,-1
     e28:	00d70023          	sb	a3,0(a4)
    while(n-- > 0)
     e2c:	fef59ae3          	bne	a1,a5,e20 <memcpy+0x4a>
}
     e30:	6422                	ld	s0,8(sp)
     e32:	0141                	add	sp,sp,16
     e34:	8082                	ret

0000000000000e36 <fork>:
# generated by usys.pl - do not edit
#include "kern/syscall.h"
.global fork
fork:
 li a7, SYS_fork
     e36:	4885                	li	a7,1
 ecall
     e38:	00000073          	ecall
 ret
     e3c:	8082                	ret

0000000000000e3e <exit>:
.global exit
exit:
 li a7, SYS_exit
     e3e:	4889                	li	a7,2
 ecall
     e40:	00000073          	ecall
 ret
     e44:	8082                	ret

0000000000000e46 <wait>:
.global wait
wait:
 li a7, SYS_wait
     e46:	488d                	li	a7,3
 ecall
     e48:	00000073          	ecall
 ret
     e4c:	8082                	ret

0000000000000e4e <pipe>:
.global pipe
pipe:
 li a7, SYS_pipe
     e4e:	4891                	li	a7,4
 ecall
     e50:	00000073          	ecall
 ret
     e54:	8082                	ret

0000000000000e56 <read>:
.global read
read:
 li a7, SYS_read
     e56:	4895                	li	a7,5
 ecall
     e58:	00000073          	ecall
 ret
     e5c:	8082                	ret

0000000000000e5e <write>:
.global write
write:
 li a7, SYS_write
     e5e:	48c1                	li	a7,16
 ecall
     e60:	00000073          	ecall
 ret
     e64:	8082                	ret

0000000000000e66 <close>:
.global close
close:
 li a7, SYS_close
     e66:	48d5                	li	a7,21
 ecall
     e68:	00000073          	ecall
 ret
     e6c:	8082                	ret

0000000000000e6e <kill>:
.global kill
kill:
 li a7, SYS_kill
     e6e:	4899                	li	a7,6
 ecall
     e70:	00000073          	ecall
 ret
     e74:	8082                	ret

0000000000000e76 <exec>:
.global exec
exec:
 li a7, SYS_exec
     e76:	489d                	li	a7,7
 ecall
     e78:	00000073          	ecall
 ret
     e7c:	8082                	ret

0000000000000e7e <open>:
.global open
open:
 li a7, SYS_open
     e7e:	48bd                	li	a7,15
 ecall
     e80:	00000073          	ecall
 ret
     e84:	8082                	ret

0000000000000e86 <mknod>:
.global mknod
mknod:
 li a7, SYS_mknod
     e86:	48c5                	li	a7,17
 ecall
     e88:	00000073          	ecall
 ret
     e8c:	8082                	ret

0000000000000e8e <unlink>:
.global unlink
unlink:
 li a7, SYS_unlink
     e8e:	48c9                	li	a7,18
 ecall
     e90:	00000073          	ecall
 ret
     e94:	8082                	ret

0000000000000e96 <fstat>:
.global fstat
fstat:
 li a7, SYS_fstat
     e96:	48a1                	li	a7,8
 ecall
     e98:	00000073          	ecall
 ret
     e9c:	8082                	ret

0000000000000e9e <link>:
.global link
link:
 li a7, SYS_link
     e9e:	48cd                	li	a7,19
 ecall
     ea0:	00000073          	ecall
 ret
     ea4:	8082                	ret

0000000000000ea6 <mkdir>:
.global mkdir
mkdir:
 li a7, SYS_mkdir
     ea6:	48d1                	li	a7,20
 ecall
     ea8:	00000073          	ecall
 ret
     eac:	8082                	ret

0000000000000eae <chdir>:
.global chdir
chdir:
 li a7, SYS_chdir
     eae:	48a5                	li	a7,9
 ecall
     eb0:	00000073          	ecall
 ret
     eb4:	8082                	ret

0000000000000eb6 <dup>:
.global dup
dup:
 li a7, SYS_dup
     eb6:	48a9                	li	a7,10
 ecall
     eb8:	00000073          	ecall
 ret
     ebc:	8082                	ret

0000000000000ebe <getpid>:
.global getpid
getpid:
 li a7, SYS_getpid
     ebe:	48ad                	li	a7,11
 ecall
     ec0:	00000073          	ecall
 ret
     ec4:	8082                	ret

0000000000000ec6 <sbrk>:
.global sbrk
sbrk:
 li a7, SYS_sbrk
     ec6:	48b1                	li	a7,12
 ecall
     ec8:	00000073          	ecall
 ret
     ecc:	8082                	ret

0000000000000ece <sleep>:
.global sleep
sleep:
 li a7, SYS_sleep
     ece:	48b5                	li	a7,13
 ecall
     ed0:	00000073          	ecall
 ret
     ed4:	8082                	ret

0000000000000ed6 <uptime>:
.global uptime
uptime:
 li a7, SYS_uptime
     ed6:	48b9                	li	a7,14
 ecall
     ed8:	00000073          	ecall
 ret
     edc:	8082                	ret

0000000000000ede <poweroff>:
.global poweroff
poweroff:
 li a7, SYS_poweroff
     ede:	48d9                	li	a7,22
 ecall
     ee0:	00000073          	ecall
 ret
     ee4:	8082                	ret

0000000000000ee6 <printint>:
  write(fd, &c, 1);
}

static void
printint(int fd, int xx, int base, int sgn)
{
     ee6:	715d                	add	sp,sp,-80
     ee8:	e0a2                	sd	s0,64(sp)
     eea:	f84a                	sd	s2,48(sp)
     eec:	e486                	sd	ra,72(sp)
     eee:	fc26                	sd	s1,56(sp)
     ef0:	f44e                	sd	s3,40(sp)
     ef2:	0880                	add	s0,sp,80
     ef4:	892a                	mv	s2,a0
  char buf[16];
  int i, neg;
  uint x;

  neg = 0;
  if(sgn && xx < 0){
     ef6:	c299                	beqz	a3,efc <printint+0x16>
     ef8:	0805c263          	bltz	a1,f7c <printint+0x96>
    neg = 1;
    x = -xx;
  } else {
    x = xx;
     efc:	2581                	sext.w	a1,a1
  neg = 0;
     efe:	4681                	li	a3,0
  }

  i = 0;
  do{
    buf[i++] = digits[x % base];
     f00:	2601                	sext.w	a2,a2
     f02:	fc040713          	add	a4,s0,-64
  i = 0;
     f06:	4501                	li	a0,0
     f08:	00001897          	auipc	a7,0x1
     f0c:	82088893          	add	a7,a7,-2016 # 1728 <digits>
    buf[i++] = digits[x % base];
     f10:	02c5f7bb          	remuw	a5,a1,a2
  }while((x /= base) != 0);
     f14:	0705                	add	a4,a4,1
     f16:	0005881b          	sext.w	a6,a1
     f1a:	84aa                	mv	s1,a0
    buf[i++] = digits[x % base];
     f1c:	2505                	addw	a0,a0,1
     f1e:	1782                	sll	a5,a5,0x20
     f20:	9381                	srl	a5,a5,0x20
     f22:	97c6                	add	a5,a5,a7
     f24:	0007c783          	lbu	a5,0(a5)
  }while((x /= base) != 0);
     f28:	02c5d5bb          	divuw	a1,a1,a2
    buf[i++] = digits[x % base];
     f2c:	fef70fa3          	sb	a5,-1(a4)
  }while((x /= base) != 0);
     f30:	fec870e3          	bgeu	a6,a2,f10 <printint+0x2a>
  if(neg)
     f34:	ca89                	beqz	a3,f46 <printint+0x60>
    buf[i++] = '-';
     f36:	fd050793          	add	a5,a0,-48
     f3a:	97a2                	add	a5,a5,s0
     f3c:	02d00713          	li	a4,45
     f40:	fee78823          	sb	a4,-16(a5)

  while(--i >= 0)
     f44:	84aa                	mv	s1,a0
     f46:	fc040793          	add	a5,s0,-64
     f4a:	94be                	add	s1,s1,a5
     f4c:	fff78993          	add	s3,a5,-1
    putc(fd, buf[i]);
     f50:	0004c783          	lbu	a5,0(s1)
  write(fd, &c, 1);
     f54:	4605                	li	a2,1
     f56:	fbf40593          	add	a1,s0,-65
     f5a:	854a                	mv	a0,s2
  while(--i >= 0)
     f5c:	14fd                	add	s1,s1,-1
     f5e:	faf40fa3          	sb	a5,-65(s0)
  write(fd, &c, 1);
     f62:	00000097          	auipc	ra,0x0
     f66:	efc080e7          	jalr	-260(ra) # e5e <write>
  while(--i >= 0)
     f6a:	ff3493e3          	bne	s1,s3,f50 <printint+0x6a>
}
     f6e:	60a6                	ld	ra,72(sp)
     f70:	6406                	ld	s0,64(sp)
     f72:	74e2                	ld	s1,56(sp)
     f74:	7942                	ld	s2,48(sp)
     f76:	79a2                	ld	s3,40(sp)
     f78:	6161                	add	sp,sp,80
     f7a:	8082                	ret
    x = -xx;
     f7c:	40b005bb          	negw	a1,a1
     f80:	b741                	j	f00 <printint+0x1a>

0000000000000f82 <vprintf>:
}

// Print to the given fd. Only understands %d, %x, %p, %s.
void
vprintf(int fd, const char *fmt, va_list ap)
{
     f82:	7159                	add	sp,sp,-112
     f84:	f0a2                	sd	s0,96(sp)
     f86:	f486                	sd	ra,104(sp)
     f88:	e8ca                	sd	s2,80(sp)
     f8a:	1880                	add	s0,sp,112
  char *s;
  int c, i, state;

  state = 0;
  for(i = 0; fmt[i]; i++){
     f8c:	0005c903          	lbu	s2,0(a1)
     f90:	04090f63          	beqz	s2,fee <vprintf+0x6c>
     f94:	eca6                	sd	s1,88(sp)
     f96:	e4ce                	sd	s3,72(sp)
     f98:	e0d2                	sd	s4,64(sp)
     f9a:	fc56                	sd	s5,56(sp)
     f9c:	f85a                	sd	s6,48(sp)
     f9e:	f45e                	sd	s7,40(sp)
     fa0:	f062                	sd	s8,32(sp)
     fa2:	8a2a                	mv	s4,a0
     fa4:	8c32                	mv	s8,a2
     fa6:	00158493          	add	s1,a1,1
     faa:	4981                	li	s3,0
      if(c == '%'){
        state = '%';
      } else {
        putc(fd, c);
      }
    } else if(state == '%'){
     fac:	02500a93          	li	s5,37
     fb0:	4bd5                	li	s7,21
     fb2:	00000b17          	auipc	s6,0x0
     fb6:	71eb0b13          	add	s6,s6,1822 # 16d0 <malloc+0x468>
    if(state == 0){
     fba:	02099f63          	bnez	s3,ff8 <vprintf+0x76>
      if(c == '%'){
     fbe:	05590c63          	beq	s2,s5,1016 <vprintf+0x94>
  write(fd, &c, 1);
     fc2:	4605                	li	a2,1
     fc4:	f9f40593          	add	a1,s0,-97
     fc8:	8552                	mv	a0,s4
     fca:	f9240fa3          	sb	s2,-97(s0)
     fce:	00000097          	auipc	ra,0x0
     fd2:	e90080e7          	jalr	-368(ra) # e5e <write>
  for(i = 0; fmt[i]; i++){
     fd6:	0004c903          	lbu	s2,0(s1)
     fda:	0485                	add	s1,s1,1
     fdc:	fc091fe3          	bnez	s2,fba <vprintf+0x38>
     fe0:	64e6                	ld	s1,88(sp)
     fe2:	69a6                	ld	s3,72(sp)
     fe4:	6a06                	ld	s4,64(sp)
     fe6:	7ae2                	ld	s5,56(sp)
     fe8:	7b42                	ld	s6,48(sp)
     fea:	7ba2                	ld	s7,40(sp)
     fec:	7c02                	ld	s8,32(sp)
        putc(fd, c);
      }
      state = 0;
    }
  }
}
     fee:	70a6                	ld	ra,104(sp)
     ff0:	7406                	ld	s0,96(sp)
     ff2:	6946                	ld	s2,80(sp)
     ff4:	6165                	add	sp,sp,112
     ff6:	8082                	ret
    } else if(state == '%'){
     ff8:	fd599fe3          	bne	s3,s5,fd6 <vprintf+0x54>
      if(c == 'd'){
     ffc:	15590463          	beq	s2,s5,1144 <vprintf+0x1c2>
    1000:	f9d9079b          	addw	a5,s2,-99
    1004:	0ff7f793          	zext.b	a5,a5
    1008:	00fbea63          	bltu	s7,a5,101c <vprintf+0x9a>
    100c:	078a                	sll	a5,a5,0x2
    100e:	97da                	add	a5,a5,s6
    1010:	439c                	lw	a5,0(a5)
    1012:	97da                	add	a5,a5,s6
    1014:	8782                	jr	a5
        state = '%';
    1016:	02500993          	li	s3,37
    101a:	bf75                	j	fd6 <vprintf+0x54>
  write(fd, &c, 1);
    101c:	f9f40993          	add	s3,s0,-97
    1020:	4605                	li	a2,1
    1022:	85ce                	mv	a1,s3
    1024:	02500793          	li	a5,37
    1028:	8552                	mv	a0,s4
    102a:	f8f40fa3          	sb	a5,-97(s0)
    102e:	00000097          	auipc	ra,0x0
    1032:	e30080e7          	jalr	-464(ra) # e5e <write>
    1036:	4605                	li	a2,1
    1038:	85ce                	mv	a1,s3
    103a:	8552                	mv	a0,s4
    103c:	f9240fa3          	sb	s2,-97(s0)
    1040:	00000097          	auipc	ra,0x0
    1044:	e1e080e7          	jalr	-482(ra) # e5e <write>
        while(*s != 0){
    1048:	4981                	li	s3,0
    104a:	b771                	j	fd6 <vprintf+0x54>
        putc(fd, va_arg(ap, uint));
    104c:	000c2783          	lw	a5,0(s8)
  write(fd, &c, 1);
    1050:	4605                	li	a2,1
    1052:	f9f40593          	add	a1,s0,-97
    1056:	8552                	mv	a0,s4
        putc(fd, va_arg(ap, uint));
    1058:	f8f40fa3          	sb	a5,-97(s0)
    105c:	0c21                	add	s8,s8,8
  write(fd, &c, 1);
    105e:	00000097          	auipc	ra,0x0
    1062:	e00080e7          	jalr	-512(ra) # e5e <write>
    1066:	4981                	li	s3,0
    1068:	b7bd                	j	fd6 <vprintf+0x54>
        printint(fd, va_arg(ap, int), 10, 1);
    106a:	000c2583          	lw	a1,0(s8)
    106e:	4685                	li	a3,1
        printint(fd, va_arg(ap, uint64), 10, 0);
    1070:	4629                	li	a2,10
    1072:	8552                	mv	a0,s4
    1074:	0c21                	add	s8,s8,8
    1076:	00000097          	auipc	ra,0x0
    107a:	e70080e7          	jalr	-400(ra) # ee6 <printint>
    107e:	4981                	li	s3,0
    1080:	bf99                	j	fd6 <vprintf+0x54>
    1082:	000c2583          	lw	a1,0(s8)
    1086:	4681                	li	a3,0
    1088:	b7e5                	j	1070 <vprintf+0xee>
  write(fd, &c, 1);
    108a:	f9f40993          	add	s3,s0,-97
    108e:	03000793          	li	a5,48
    1092:	4605                	li	a2,1
    1094:	85ce                	mv	a1,s3
    1096:	8552                	mv	a0,s4
    1098:	ec66                	sd	s9,24(sp)
    109a:	e86a                	sd	s10,16(sp)
        printptr(fd, va_arg(ap, uint64));
    109c:	f8f40fa3          	sb	a5,-97(s0)
    10a0:	000c3d03          	ld	s10,0(s8)
  write(fd, &c, 1);
    10a4:	00000097          	auipc	ra,0x0
    10a8:	dba080e7          	jalr	-582(ra) # e5e <write>
    10ac:	07800793          	li	a5,120
    10b0:	4605                	li	a2,1
    10b2:	85ce                	mv	a1,s3
    10b4:	8552                	mv	a0,s4
    10b6:	f8f40fa3          	sb	a5,-97(s0)
        printptr(fd, va_arg(ap, uint64));
    10ba:	0c21                	add	s8,s8,8
  write(fd, &c, 1);
    10bc:	00000097          	auipc	ra,0x0
    10c0:	da2080e7          	jalr	-606(ra) # e5e <write>
  putc(fd, 'x');
    10c4:	4941                	li	s2,16
    10c6:	00000c97          	auipc	s9,0x0
    10ca:	662c8c93          	add	s9,s9,1634 # 1728 <digits>
    putc(fd, digits[x >> (sizeof(uint64) * 8 - 4)]);
    10ce:	03cd5793          	srl	a5,s10,0x3c
    10d2:	97e6                	add	a5,a5,s9
    10d4:	0007c783          	lbu	a5,0(a5)
  write(fd, &c, 1);
    10d8:	4605                	li	a2,1
    10da:	85ce                	mv	a1,s3
    10dc:	8552                	mv	a0,s4
  for (i = 0; i < (sizeof(uint64) * 2); i++, x <<= 4)
    10de:	397d                	addw	s2,s2,-1
    10e0:	f8f40fa3          	sb	a5,-97(s0)
    10e4:	0d12                	sll	s10,s10,0x4
  write(fd, &c, 1);
    10e6:	00000097          	auipc	ra,0x0
    10ea:	d78080e7          	jalr	-648(ra) # e5e <write>
  for (i = 0; i < (sizeof(uint64) * 2); i++, x <<= 4)
    10ee:	fe0910e3          	bnez	s2,10ce <vprintf+0x14c>
    10f2:	6ce2                	ld	s9,24(sp)
    10f4:	6d42                	ld	s10,16(sp)
    10f6:	4981                	li	s3,0
    10f8:	bdf9                	j	fd6 <vprintf+0x54>
        s = va_arg(ap, char*);
    10fa:	000c3903          	ld	s2,0(s8)
    10fe:	0c21                	add	s8,s8,8
        if(s == 0)
    1100:	04090e63          	beqz	s2,115c <vprintf+0x1da>
        while(*s != 0){
    1104:	00094783          	lbu	a5,0(s2)
    1108:	d3a1                	beqz	a5,1048 <vprintf+0xc6>
    110a:	f9f40993          	add	s3,s0,-97
  write(fd, &c, 1);
    110e:	4605                	li	a2,1
    1110:	85ce                	mv	a1,s3
    1112:	8552                	mv	a0,s4
    1114:	f8f40fa3          	sb	a5,-97(s0)
    1118:	00000097          	auipc	ra,0x0
    111c:	d46080e7          	jalr	-698(ra) # e5e <write>
        while(*s != 0){
    1120:	00194783          	lbu	a5,1(s2)
          s++;
    1124:	0905                	add	s2,s2,1
        while(*s != 0){
    1126:	f7e5                	bnez	a5,110e <vprintf+0x18c>
    1128:	4981                	li	s3,0
    112a:	b575                	j	fd6 <vprintf+0x54>
        printint(fd, va_arg(ap, int), 16, 0);
    112c:	000c2583          	lw	a1,0(s8)
    1130:	4681                	li	a3,0
    1132:	4641                	li	a2,16
    1134:	8552                	mv	a0,s4
    1136:	0c21                	add	s8,s8,8
    1138:	00000097          	auipc	ra,0x0
    113c:	dae080e7          	jalr	-594(ra) # ee6 <printint>
    1140:	4981                	li	s3,0
    1142:	bd51                	j	fd6 <vprintf+0x54>
  write(fd, &c, 1);
    1144:	4605                	li	a2,1
    1146:	f9f40593          	add	a1,s0,-97
    114a:	8552                	mv	a0,s4
    114c:	f9540fa3          	sb	s5,-97(s0)
        while(*s != 0){
    1150:	4981                	li	s3,0
  write(fd, &c, 1);
    1152:	00000097          	auipc	ra,0x0
    1156:	d0c080e7          	jalr	-756(ra) # e5e <write>
    115a:	bdb5                	j	fd6 <vprintf+0x54>
          s = "(null)";
    115c:	00000917          	auipc	s2,0x0
    1160:	50c90913          	add	s2,s2,1292 # 1668 <malloc+0x400>
    1164:	02800793          	li	a5,40
    1168:	b74d                	j	110a <vprintf+0x188>

000000000000116a <fprintf>:

void
fprintf(int fd, const char *fmt, ...)
{
    116a:	715d                	add	sp,sp,-80
    116c:	e822                	sd	s0,16(sp)
    116e:	ec06                	sd	ra,24(sp)
    1170:	1000                	add	s0,sp,32
    1172:	e010                	sd	a2,0(s0)
  va_list ap;

  va_start(ap, fmt);
  vprintf(fd, fmt, ap);
    1174:	8622                	mv	a2,s0
{
    1176:	e414                	sd	a3,8(s0)
    1178:	e818                	sd	a4,16(s0)
    117a:	ec1c                	sd	a5,24(s0)
    117c:	03043023          	sd	a6,32(s0)
    1180:	03143423          	sd	a7,40(s0)
  va_start(ap, fmt);
    1184:	fe843423          	sd	s0,-24(s0)
  vprintf(fd, fmt, ap);
    1188:	00000097          	auipc	ra,0x0
    118c:	dfa080e7          	jalr	-518(ra) # f82 <vprintf>
}
    1190:	60e2                	ld	ra,24(sp)
    1192:	6442                	ld	s0,16(sp)
    1194:	6161                	add	sp,sp,80
    1196:	8082                	ret

0000000000001198 <printf>:

void
printf(const char *fmt, ...)
{
    1198:	711d                	add	sp,sp,-96
    119a:	e822                	sd	s0,16(sp)
    119c:	ec06                	sd	ra,24(sp)
    119e:	1000                	add	s0,sp,32
  va_list ap;

  va_start(ap, fmt);
    11a0:	00840313          	add	t1,s0,8
{
    11a4:	e40c                	sd	a1,8(s0)
    11a6:	e810                	sd	a2,16(s0)
  vprintf(1, fmt, ap);
    11a8:	85aa                	mv	a1,a0
    11aa:	861a                	mv	a2,t1
    11ac:	4505                	li	a0,1
{
    11ae:	ec14                	sd	a3,24(s0)
    11b0:	f018                	sd	a4,32(s0)
    11b2:	f41c                	sd	a5,40(s0)
    11b4:	03043823          	sd	a6,48(s0)
    11b8:	03143c23          	sd	a7,56(s0)
  va_start(ap, fmt);
    11bc:	fe643423          	sd	t1,-24(s0)
  vprintf(1, fmt, ap);
    11c0:	00000097          	auipc	ra,0x0
    11c4:	dc2080e7          	jalr	-574(ra) # f82 <vprintf>
}
    11c8:	60e2                	ld	ra,24(sp)
    11ca:	6442                	ld	s0,16(sp)
    11cc:	6125                	add	sp,sp,96
    11ce:	8082                	ret

00000000000011d0 <free>:
static Header base;
static Header *freep;

void
free(void *ap)
{
    11d0:	1141                	add	sp,sp,-16
    11d2:	e422                	sd	s0,8(sp)
    11d4:	0800                	add	s0,sp,16
  Header *bp, *p;

  bp = (Header*)ap - 1;
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
    11d6:	00001597          	auipc	a1,0x1
    11da:	e3a58593          	add	a1,a1,-454 # 2010 <freep>
    11de:	619c                	ld	a5,0(a1)
  bp = (Header*)ap - 1;
    11e0:	ff050693          	add	a3,a0,-16
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
    11e4:	6398                	ld	a4,0(a5)
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
    11e6:	02d7ff63          	bgeu	a5,a3,1224 <free+0x54>
    11ea:	00e6e463          	bltu	a3,a4,11f2 <free+0x22>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
    11ee:	02e7ef63          	bltu	a5,a4,122c <free+0x5c>
      break;
  if(bp + bp->s.size == p->s.ptr){
    11f2:	ff852803          	lw	a6,-8(a0)
    11f6:	02081893          	sll	a7,a6,0x20
    11fa:	01c8d613          	srl	a2,a7,0x1c
    11fe:	9636                	add	a2,a2,a3
    1200:	02c70863          	beq	a4,a2,1230 <free+0x60>
    bp->s.size += p->s.ptr->s.size;
    bp->s.ptr = p->s.ptr->s.ptr;
  } else
    bp->s.ptr = p->s.ptr;
  if(p + p->s.size == bp){
    1204:	0087a803          	lw	a6,8(a5)
    1208:	fee53823          	sd	a4,-16(a0)
    120c:	02081893          	sll	a7,a6,0x20
    1210:	01c8d613          	srl	a2,a7,0x1c
    1214:	963e                	add	a2,a2,a5
    1216:	02c68e63          	beq	a3,a2,1252 <free+0x82>
    p->s.size += bp->s.size;
    p->s.ptr = bp->s.ptr;
  } else
    p->s.ptr = bp;
  freep = p;
}
    121a:	6422                	ld	s0,8(sp)
    121c:	e394                	sd	a3,0(a5)
  freep = p;
    121e:	e19c                	sd	a5,0(a1)
}
    1220:	0141                	add	sp,sp,16
    1222:	8082                	ret
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
    1224:	00e7e463          	bltu	a5,a4,122c <free+0x5c>
    1228:	fce6e5e3          	bltu	a3,a4,11f2 <free+0x22>
{
    122c:	87ba                	mv	a5,a4
    122e:	bf5d                	j	11e4 <free+0x14>
    bp->s.size += p->s.ptr->s.size;
    1230:	4710                	lw	a2,8(a4)
    bp->s.ptr = p->s.ptr->s.ptr;
    1232:	6318                	ld	a4,0(a4)
    bp->s.size += p->s.ptr->s.size;
    1234:	0106063b          	addw	a2,a2,a6
    1238:	fec52c23          	sw	a2,-8(a0)
  if(p + p->s.size == bp){
    123c:	0087a803          	lw	a6,8(a5)
    1240:	fee53823          	sd	a4,-16(a0)
    1244:	02081893          	sll	a7,a6,0x20
    1248:	01c8d613          	srl	a2,a7,0x1c
    124c:	963e                	add	a2,a2,a5
    124e:	fcc696e3          	bne	a3,a2,121a <free+0x4a>
    p->s.size += bp->s.size;
    1252:	ff852603          	lw	a2,-8(a0)
}
    1256:	6422                	ld	s0,8(sp)
    p->s.ptr = bp->s.ptr;
    1258:	86ba                	mv	a3,a4
    p->s.size += bp->s.size;
    125a:	0106073b          	addw	a4,a2,a6
    125e:	c798                	sw	a4,8(a5)
    p->s.ptr = bp->s.ptr;
    1260:	e394                	sd	a3,0(a5)
  freep = p;
    1262:	e19c                	sd	a5,0(a1)
}
    1264:	0141                	add	sp,sp,16
    1266:	8082                	ret

0000000000001268 <malloc>:
  return freep;
}

void*
malloc(uint nbytes)
{
    1268:	7139                	add	sp,sp,-64
    126a:	f822                	sd	s0,48(sp)
    126c:	f426                	sd	s1,40(sp)
    126e:	f04a                	sd	s2,32(sp)
    1270:	ec4e                	sd	s3,24(sp)
    1272:	fc06                	sd	ra,56(sp)
    1274:	0080                	add	s0,sp,64
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
  if((prevp = freep) == 0){
    1276:	00001917          	auipc	s2,0x1
    127a:	d9a90913          	add	s2,s2,-614 # 2010 <freep>
  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
    127e:	02051493          	sll	s1,a0,0x20
    1282:	9081                	srl	s1,s1,0x20
  if((prevp = freep) == 0){
    1284:	00093783          	ld	a5,0(s2)
  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
    1288:	04bd                	add	s1,s1,15
    128a:	8091                	srl	s1,s1,0x4
    128c:	0014899b          	addw	s3,s1,1
    1290:	0485                	add	s1,s1,1
  if((prevp = freep) == 0){
    1292:	c3dd                	beqz	a5,1338 <malloc+0xd0>
    base.s.ptr = freep = prevp = &base;
    base.s.size = 0;
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
    1294:	6388                	ld	a0,0(a5)
    if(p->s.size >= nunits){
    1296:	4518                	lw	a4,8(a0)
    1298:	06977863          	bgeu	a4,s1,1308 <malloc+0xa0>
    129c:	e852                	sd	s4,16(sp)
    129e:	e456                	sd	s5,8(sp)
    12a0:	e05a                	sd	s6,0(sp)
  if(nu < 4096)
    12a2:	6785                	lui	a5,0x1
    12a4:	8a4e                	mv	s4,s3
    12a6:	08f4e763          	bltu	s1,a5,1334 <malloc+0xcc>
    12aa:	000a0b1b          	sext.w	s6,s4
  if(p == (char*)-1)
    12ae:	5afd                	li	s5,-1
  p = sbrk(nu * sizeof(Header));
    12b0:	004a1a1b          	sllw	s4,s4,0x4
    12b4:	a029                	j	12be <malloc+0x56>
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
    12b6:	6388                	ld	a0,0(a5)
    if(p->s.size >= nunits){
    12b8:	4518                	lw	a4,8(a0)
    12ba:	04977463          	bgeu	a4,s1,1302 <malloc+0x9a>
        p->s.size = nunits;
      }
      freep = prevp;
      return (void*)(p + 1);
    }
    if(p == freep)
    12be:	00093703          	ld	a4,0(s2)
    12c2:	87aa                	mv	a5,a0
    12c4:	fee519e3          	bne	a0,a4,12b6 <malloc+0x4e>
  p = sbrk(nu * sizeof(Header));
    12c8:	8552                	mv	a0,s4
    12ca:	00000097          	auipc	ra,0x0
    12ce:	bfc080e7          	jalr	-1028(ra) # ec6 <sbrk>
    12d2:	87aa                	mv	a5,a0
  free((void*)(hp + 1));
    12d4:	0541                	add	a0,a0,16
  if(p == (char*)-1)
    12d6:	01578b63          	beq	a5,s5,12ec <malloc+0x84>
  hp->s.size = nu;
    12da:	0167a423          	sw	s6,8(a5) # 1008 <vprintf+0x86>
  free((void*)(hp + 1));
    12de:	00000097          	auipc	ra,0x0
    12e2:	ef2080e7          	jalr	-270(ra) # 11d0 <free>
  return freep;
    12e6:	00093783          	ld	a5,0(s2)
      if((p = morecore(nunits)) == 0)
    12ea:	f7f1                	bnez	a5,12b6 <malloc+0x4e>
        return 0;
  }
}
    12ec:	70e2                	ld	ra,56(sp)
    12ee:	7442                	ld	s0,48(sp)
        return 0;
    12f0:	6a42                	ld	s4,16(sp)
    12f2:	6aa2                	ld	s5,8(sp)
    12f4:	6b02                	ld	s6,0(sp)
}
    12f6:	74a2                	ld	s1,40(sp)
    12f8:	7902                	ld	s2,32(sp)
    12fa:	69e2                	ld	s3,24(sp)
        return 0;
    12fc:	4501                	li	a0,0
}
    12fe:	6121                	add	sp,sp,64
    1300:	8082                	ret
    1302:	6a42                	ld	s4,16(sp)
    1304:	6aa2                	ld	s5,8(sp)
    1306:	6b02                	ld	s6,0(sp)
      if(p->s.size == nunits)
    1308:	04e48763          	beq	s1,a4,1356 <malloc+0xee>
        p->s.size -= nunits;
    130c:	4137073b          	subw	a4,a4,s3
        p += p->s.size;
    1310:	02071613          	sll	a2,a4,0x20
    1314:	01c65693          	srl	a3,a2,0x1c
        p->s.size -= nunits;
    1318:	c518                	sw	a4,8(a0)
        p += p->s.size;
    131a:	9536                	add	a0,a0,a3
        p->s.size = nunits;
    131c:	01352423          	sw	s3,8(a0)
}
    1320:	70e2                	ld	ra,56(sp)
    1322:	7442                	ld	s0,48(sp)
      freep = prevp;
    1324:	00f93023          	sd	a5,0(s2)
}
    1328:	74a2                	ld	s1,40(sp)
    132a:	7902                	ld	s2,32(sp)
    132c:	69e2                	ld	s3,24(sp)
      return (void*)(p + 1);
    132e:	0541                	add	a0,a0,16
}
    1330:	6121                	add	sp,sp,64
    1332:	8082                	ret
  if(nu < 4096)
    1334:	6a05                	lui	s4,0x1
    1336:	bf95                	j	12aa <malloc+0x42>
    1338:	e852                	sd	s4,16(sp)
    133a:	e456                	sd	s5,8(sp)
    133c:	e05a                	sd	s6,0(sp)
    base.s.ptr = freep = prevp = &base;
    133e:	00001517          	auipc	a0,0x1
    1342:	0ca50513          	add	a0,a0,202 # 2408 <base>
    1346:	00a93023          	sd	a0,0(s2)
    134a:	e108                	sd	a0,0(a0)
    base.s.size = 0;
    134c:	00001797          	auipc	a5,0x1
    1350:	0c07a223          	sw	zero,196(a5) # 2410 <base+0x8>
    if(p->s.size >= nunits){
    1354:	b7b9                	j	12a2 <malloc+0x3a>
        prevp->s.ptr = p->s.ptr;
    1356:	6118                	ld	a4,0(a0)
    1358:	e398                	sd	a4,0(a5)
    135a:	b7d9                	j	1320 <malloc+0xb8>
