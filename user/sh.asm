
user/_sh:     file format elf64-littleriscv


Disassembly of section .text:

0000000000000000 <getcmd>:
  exit(0);
}

int
getcmd(char *buf, int nbuf)
{
       0:	1101                	add	sp,sp,-32
       2:	ec06                	sd	ra,24(sp)
       4:	e822                	sd	s0,16(sp)
       6:	e426                	sd	s1,8(sp)
       8:	1000                	add	s0,sp,32
       a:	e04a                	sd	s2,0(sp)
       c:	84aa                	mv	s1,a0
       e:	892e                	mv	s2,a1
  write(2, "$ ", 2);
      10:	4609                	li	a2,2
      12:	00001597          	auipc	a1,0x1
      16:	48e58593          	add	a1,a1,1166 # 14a0 <malloc+0xfc>
      1a:	4509                	li	a0,2
      1c:	00001097          	auipc	ra,0x1
      20:	f7e080e7          	jalr	-130(ra) # f9a <write>
  memset(buf, 0, nbuf);
      24:	864a                	mv	a2,s2
      26:	4581                	li	a1,0
      28:	8526                	mv	a0,s1
      2a:	00001097          	auipc	ra,0x1
      2e:	d04080e7          	jalr	-764(ra) # d2e <memset>
  gets(buf, nbuf);
      32:	85ca                	mv	a1,s2
      34:	8526                	mv	a0,s1
      36:	00001097          	auipc	ra,0x1
      3a:	d3e080e7          	jalr	-706(ra) # d74 <gets>
  if(buf[0] == 0) // EOF
      3e:	0004c503          	lbu	a0,0(s1)
    return -1;
  return 0;
}
      42:	60e2                	ld	ra,24(sp)
      44:	6442                	ld	s0,16(sp)
  if(buf[0] == 0) // EOF
      46:	00153513          	seqz	a0,a0
}
      4a:	64a2                	ld	s1,8(sp)
      4c:	6902                	ld	s2,0(sp)
      4e:	40a00533          	neg	a0,a0
      52:	6105                	add	sp,sp,32
      54:	8082                	ret

0000000000000056 <panic>:
  exit(0);
}

void
panic(char *s)
{
      56:	1141                	add	sp,sp,-16
      58:	e022                	sd	s0,0(sp)
      5a:	e406                	sd	ra,8(sp)
      5c:	0800                	add	s0,sp,16
      5e:	862a                	mv	a2,a0
  fprintf(2, "%s\n", s);
      60:	4509                	li	a0,2
      62:	00001597          	auipc	a1,0x1
      66:	44e58593          	add	a1,a1,1102 # 14b0 <malloc+0x10c>
      6a:	00001097          	auipc	ra,0x1
      6e:	23c080e7          	jalr	572(ra) # 12a6 <fprintf>
  exit(1);
      72:	4505                	li	a0,1
      74:	00001097          	auipc	ra,0x1
      78:	f06080e7          	jalr	-250(ra) # f7a <exit>

000000000000007c <fork1>:
}

int
fork1(void)
{
      7c:	1141                	add	sp,sp,-16
      7e:	e022                	sd	s0,0(sp)
      80:	e406                	sd	ra,8(sp)
      82:	0800                	add	s0,sp,16
  int pid;

  pid = fork();
      84:	00001097          	auipc	ra,0x1
      88:	eee080e7          	jalr	-274(ra) # f72 <fork>
  if(pid == -1)
      8c:	57fd                	li	a5,-1
      8e:	00f50663          	beq	a0,a5,9a <fork1+0x1e>
    panic("fork");
  return pid;
}
      92:	60a2                	ld	ra,8(sp)
      94:	6402                	ld	s0,0(sp)
      96:	0141                	add	sp,sp,16
      98:	8082                	ret
    panic("fork");
      9a:	00001517          	auipc	a0,0x1
      9e:	41e50513          	add	a0,a0,1054 # 14b8 <malloc+0x114>
      a2:	00000097          	auipc	ra,0x0
      a6:	fb4080e7          	jalr	-76(ra) # 56 <panic>

00000000000000aa <runcmd>:
{
      aa:	7179                	add	sp,sp,-48
      ac:	f022                	sd	s0,32(sp)
      ae:	f406                	sd	ra,40(sp)
      b0:	ec26                	sd	s1,24(sp)
      b2:	1800                	add	s0,sp,48
  if(cmd == 0)
      b4:	c91d                	beqz	a0,ea <runcmd+0x40>
  switch(cmd->type){
      b6:	4118                	lw	a4,0(a0)
      b8:	4795                	li	a5,5
      ba:	84aa                	mv	s1,a0
      bc:	10e7e763          	bltu	a5,a4,1ca <runcmd+0x120>
      c0:	00056783          	lwu	a5,0(a0)
      c4:	00001717          	auipc	a4,0x1
      c8:	4f470713          	add	a4,a4,1268 # 15b8 <malloc+0x214>
      cc:	078a                	sll	a5,a5,0x2
      ce:	97ba                	add	a5,a5,a4
      d0:	439c                	lw	a5,0(a5)
      d2:	97ba                	add	a5,a5,a4
      d4:	8782                	jr	a5
      fprintf(2, "open %s failed\n", rcmd->file);
      d6:	6890                	ld	a2,16(s1)
      d8:	00001597          	auipc	a1,0x1
      dc:	40058593          	add	a1,a1,1024 # 14d8 <malloc+0x134>
      e0:	4509                	li	a0,2
      e2:	00001097          	auipc	ra,0x1
      e6:	1c4080e7          	jalr	452(ra) # 12a6 <fprintf>
      exit(1);
      ea:	4505                	li	a0,1
      ec:	00001097          	auipc	ra,0x1
      f0:	e8e080e7          	jalr	-370(ra) # f7a <exit>
    if(fork1() == 0)
      f4:	00000097          	auipc	ra,0x0
      f8:	f88080e7          	jalr	-120(ra) # 7c <fork1>
      fc:	c171                	beqz	a0,1c0 <runcmd+0x116>
  exit(0);
      fe:	4501                	li	a0,0
     100:	00001097          	auipc	ra,0x1
     104:	e7a080e7          	jalr	-390(ra) # f7a <exit>
    if(ecmd->argv[0] == 0)
     108:	6508                	ld	a0,8(a0)
     10a:	d165                	beqz	a0,ea <runcmd+0x40>
    exec(ecmd->argv[0], ecmd->argv);
     10c:	00848593          	add	a1,s1,8
     110:	00001097          	auipc	ra,0x1
     114:	ea2080e7          	jalr	-350(ra) # fb2 <exec>
    fprintf(2, "exec %s failed\n", ecmd->argv[0]);
     118:	6490                	ld	a2,8(s1)
     11a:	00001597          	auipc	a1,0x1
     11e:	3ae58593          	add	a1,a1,942 # 14c8 <malloc+0x124>
     122:	4509                	li	a0,2
     124:	00001097          	auipc	ra,0x1
     128:	182080e7          	jalr	386(ra) # 12a6 <fprintf>
    break;
     12c:	bfc9                	j	fe <runcmd+0x54>
    if(pipe(p) < 0)
     12e:	fd840513          	add	a0,s0,-40
     132:	00001097          	auipc	ra,0x1
     136:	e58080e7          	jalr	-424(ra) # f8a <pipe>
     13a:	0a054063          	bltz	a0,1da <runcmd+0x130>
    if(fork1() == 0){
     13e:	00000097          	auipc	ra,0x0
     142:	f3e080e7          	jalr	-194(ra) # 7c <fork1>
     146:	c155                	beqz	a0,1ea <runcmd+0x140>
    if(fork1() == 0){
     148:	00000097          	auipc	ra,0x0
     14c:	f34080e7          	jalr	-204(ra) # 7c <fork1>
     150:	e969                	bnez	a0,222 <runcmd+0x178>
      close(0);
     152:	00001097          	auipc	ra,0x1
     156:	e50080e7          	jalr	-432(ra) # fa2 <close>
      dup(p[0]);
     15a:	fd842503          	lw	a0,-40(s0)
     15e:	00001097          	auipc	ra,0x1
     162:	e94080e7          	jalr	-364(ra) # ff2 <dup>
      close(p[0]);
     166:	fd842503          	lw	a0,-40(s0)
     16a:	00001097          	auipc	ra,0x1
     16e:	e38080e7          	jalr	-456(ra) # fa2 <close>
      close(p[1]);
     172:	fdc42503          	lw	a0,-36(s0)
     176:	00001097          	auipc	ra,0x1
     17a:	e2c080e7          	jalr	-468(ra) # fa2 <close>
      runcmd(pcmd->right);
     17e:	6888                	ld	a0,16(s1)
     180:	00000097          	auipc	ra,0x0
     184:	f2a080e7          	jalr	-214(ra) # aa <runcmd>
    if(fork1() == 0)
     188:	00000097          	auipc	ra,0x0
     18c:	ef4080e7          	jalr	-268(ra) # 7c <fork1>
     190:	c905                	beqz	a0,1c0 <runcmd+0x116>
    wait(0);
     192:	4501                	li	a0,0
     194:	00001097          	auipc	ra,0x1
     198:	dee080e7          	jalr	-530(ra) # f82 <wait>
    runcmd(lcmd->right);
     19c:	6888                	ld	a0,16(s1)
     19e:	00000097          	auipc	ra,0x0
     1a2:	f0c080e7          	jalr	-244(ra) # aa <runcmd>
    close(rcmd->fd);
     1a6:	5148                	lw	a0,36(a0)
     1a8:	00001097          	auipc	ra,0x1
     1ac:	dfa080e7          	jalr	-518(ra) # fa2 <close>
    if(open(rcmd->file, rcmd->mode) < 0){
     1b0:	508c                	lw	a1,32(s1)
     1b2:	6888                	ld	a0,16(s1)
     1b4:	00001097          	auipc	ra,0x1
     1b8:	e06080e7          	jalr	-506(ra) # fba <open>
     1bc:	f0054de3          	bltz	a0,d6 <runcmd+0x2c>
      runcmd(bcmd->cmd);
     1c0:	6488                	ld	a0,8(s1)
     1c2:	00000097          	auipc	ra,0x0
     1c6:	ee8080e7          	jalr	-280(ra) # aa <runcmd>
    panic("runcmd");
     1ca:	00001517          	auipc	a0,0x1
     1ce:	2f650513          	add	a0,a0,758 # 14c0 <malloc+0x11c>
     1d2:	00000097          	auipc	ra,0x0
     1d6:	e84080e7          	jalr	-380(ra) # 56 <panic>
      panic("pipe");
     1da:	00001517          	auipc	a0,0x1
     1de:	30e50513          	add	a0,a0,782 # 14e8 <malloc+0x144>
     1e2:	00000097          	auipc	ra,0x0
     1e6:	e74080e7          	jalr	-396(ra) # 56 <panic>
      close(1);
     1ea:	4505                	li	a0,1
     1ec:	00001097          	auipc	ra,0x1
     1f0:	db6080e7          	jalr	-586(ra) # fa2 <close>
      dup(p[1]);
     1f4:	fdc42503          	lw	a0,-36(s0)
     1f8:	00001097          	auipc	ra,0x1
     1fc:	dfa080e7          	jalr	-518(ra) # ff2 <dup>
      close(p[0]);
     200:	fd842503          	lw	a0,-40(s0)
     204:	00001097          	auipc	ra,0x1
     208:	d9e080e7          	jalr	-610(ra) # fa2 <close>
      close(p[1]);
     20c:	fdc42503          	lw	a0,-36(s0)
     210:	00001097          	auipc	ra,0x1
     214:	d92080e7          	jalr	-622(ra) # fa2 <close>
      runcmd(pcmd->left);
     218:	6488                	ld	a0,8(s1)
     21a:	00000097          	auipc	ra,0x0
     21e:	e90080e7          	jalr	-368(ra) # aa <runcmd>
    close(p[0]);
     222:	fd842503          	lw	a0,-40(s0)
     226:	00001097          	auipc	ra,0x1
     22a:	d7c080e7          	jalr	-644(ra) # fa2 <close>
    close(p[1]);
     22e:	fdc42503          	lw	a0,-36(s0)
     232:	00001097          	auipc	ra,0x1
     236:	d70080e7          	jalr	-656(ra) # fa2 <close>
    wait(0);
     23a:	4501                	li	a0,0
     23c:	00001097          	auipc	ra,0x1
     240:	d46080e7          	jalr	-698(ra) # f82 <wait>
    wait(0);
     244:	4501                	li	a0,0
     246:	00001097          	auipc	ra,0x1
     24a:	d3c080e7          	jalr	-708(ra) # f82 <wait>
    break;
     24e:	bd45                	j	fe <runcmd+0x54>

0000000000000250 <execcmd>:
//PAGEBREAK!
// Constructors

struct cmd*
execcmd(void)
{
     250:	1101                	add	sp,sp,-32
     252:	ec06                	sd	ra,24(sp)
     254:	e822                	sd	s0,16(sp)
     256:	e426                	sd	s1,8(sp)
     258:	1000                	add	s0,sp,32
  struct execcmd *cmd;

  cmd = malloc(sizeof(*cmd));
     25a:	0a800513          	li	a0,168
     25e:	00001097          	auipc	ra,0x1
     262:	146080e7          	jalr	326(ra) # 13a4 <malloc>
  memset(cmd, 0, sizeof(*cmd));
     266:	0a800613          	li	a2,168
     26a:	4581                	li	a1,0
  cmd = malloc(sizeof(*cmd));
     26c:	84aa                	mv	s1,a0
  memset(cmd, 0, sizeof(*cmd));
     26e:	00001097          	auipc	ra,0x1
     272:	ac0080e7          	jalr	-1344(ra) # d2e <memset>
  cmd->type = EXEC;
  return (struct cmd*)cmd;
}
     276:	60e2                	ld	ra,24(sp)
     278:	6442                	ld	s0,16(sp)
  cmd->type = EXEC;
     27a:	4785                	li	a5,1
     27c:	c09c                	sw	a5,0(s1)
}
     27e:	8526                	mv	a0,s1
     280:	64a2                	ld	s1,8(sp)
     282:	6105                	add	sp,sp,32
     284:	8082                	ret

0000000000000286 <redircmd>:

struct cmd*
redircmd(struct cmd *subcmd, char *file, char *efile, int mode, int fd)
{
     286:	7139                	add	sp,sp,-64
     288:	fc06                	sd	ra,56(sp)
     28a:	f822                	sd	s0,48(sp)
     28c:	f426                	sd	s1,40(sp)
     28e:	f04a                	sd	s2,32(sp)
     290:	ec4e                	sd	s3,24(sp)
     292:	e852                	sd	s4,16(sp)
     294:	e456                	sd	s5,8(sp)
     296:	0080                	add	s0,sp,64
     298:	1682                	sll	a3,a3,0x20
     29a:	8aaa                	mv	s5,a0
     29c:	1702                	sll	a4,a4,0x20
     29e:	9281                	srl	a3,a3,0x20
  struct redircmd *cmd;

  cmd = malloc(sizeof(*cmd));
     2a0:	02800513          	li	a0,40
{
     2a4:	8a2e                	mv	s4,a1
     2a6:	89b2                	mv	s3,a2
     2a8:	00e6e933          	or	s2,a3,a4
  cmd = malloc(sizeof(*cmd));
     2ac:	00001097          	auipc	ra,0x1
     2b0:	0f8080e7          	jalr	248(ra) # 13a4 <malloc>
  memset(cmd, 0, sizeof(*cmd));
     2b4:	02800613          	li	a2,40
     2b8:	4581                	li	a1,0
  cmd = malloc(sizeof(*cmd));
     2ba:	84aa                	mv	s1,a0
  memset(cmd, 0, sizeof(*cmd));
     2bc:	00001097          	auipc	ra,0x1
     2c0:	a72080e7          	jalr	-1422(ra) # d2e <memset>
  cmd->file = file;
  cmd->efile = efile;
  cmd->mode = mode;
  cmd->fd = fd;
  return (struct cmd*)cmd;
}
     2c4:	70e2                	ld	ra,56(sp)
     2c6:	7442                	ld	s0,48(sp)
  cmd->type = REDIR;
     2c8:	4789                	li	a5,2
  cmd->cmd = subcmd;
     2ca:	0154b423          	sd	s5,8(s1)
  cmd->file = file;
     2ce:	0144b823          	sd	s4,16(s1)
  cmd->efile = efile;
     2d2:	0134bc23          	sd	s3,24(s1)
  cmd->mode = mode;
     2d6:	0324b023          	sd	s2,32(s1)
  cmd->type = REDIR;
     2da:	c09c                	sw	a5,0(s1)
}
     2dc:	7902                	ld	s2,32(sp)
     2de:	69e2                	ld	s3,24(sp)
     2e0:	6a42                	ld	s4,16(sp)
     2e2:	6aa2                	ld	s5,8(sp)
     2e4:	8526                	mv	a0,s1
     2e6:	74a2                	ld	s1,40(sp)
     2e8:	6121                	add	sp,sp,64
     2ea:	8082                	ret

00000000000002ec <pipecmd>:

struct cmd*
pipecmd(struct cmd *left, struct cmd *right)
{
     2ec:	7179                	add	sp,sp,-48
     2ee:	f406                	sd	ra,40(sp)
     2f0:	f022                	sd	s0,32(sp)
     2f2:	ec26                	sd	s1,24(sp)
     2f4:	e84a                	sd	s2,16(sp)
     2f6:	e44e                	sd	s3,8(sp)
     2f8:	1800                	add	s0,sp,48
     2fa:	89aa                	mv	s3,a0
  struct pipecmd *cmd;

  cmd = malloc(sizeof(*cmd));
     2fc:	4561                	li	a0,24
{
     2fe:	892e                	mv	s2,a1
  cmd = malloc(sizeof(*cmd));
     300:	00001097          	auipc	ra,0x1
     304:	0a4080e7          	jalr	164(ra) # 13a4 <malloc>
  memset(cmd, 0, sizeof(*cmd));
     308:	4661                	li	a2,24
     30a:	4581                	li	a1,0
  cmd = malloc(sizeof(*cmd));
     30c:	84aa                	mv	s1,a0
  memset(cmd, 0, sizeof(*cmd));
     30e:	00001097          	auipc	ra,0x1
     312:	a20080e7          	jalr	-1504(ra) # d2e <memset>
  cmd->type = PIPE;
  cmd->left = left;
  cmd->right = right;
  return (struct cmd*)cmd;
}
     316:	70a2                	ld	ra,40(sp)
     318:	7402                	ld	s0,32(sp)
  cmd->type = PIPE;
     31a:	478d                	li	a5,3
  cmd->left = left;
     31c:	0134b423          	sd	s3,8(s1)
  cmd->right = right;
     320:	0124b823          	sd	s2,16(s1)
  cmd->type = PIPE;
     324:	c09c                	sw	a5,0(s1)
}
     326:	6942                	ld	s2,16(sp)
     328:	69a2                	ld	s3,8(sp)
     32a:	8526                	mv	a0,s1
     32c:	64e2                	ld	s1,24(sp)
     32e:	6145                	add	sp,sp,48
     330:	8082                	ret

0000000000000332 <listcmd>:

struct cmd*
listcmd(struct cmd *left, struct cmd *right)
{
     332:	7179                	add	sp,sp,-48
     334:	f406                	sd	ra,40(sp)
     336:	f022                	sd	s0,32(sp)
     338:	ec26                	sd	s1,24(sp)
     33a:	e84a                	sd	s2,16(sp)
     33c:	e44e                	sd	s3,8(sp)
     33e:	1800                	add	s0,sp,48
     340:	89aa                	mv	s3,a0
  struct listcmd *cmd;

  cmd = malloc(sizeof(*cmd));
     342:	4561                	li	a0,24
{
     344:	892e                	mv	s2,a1
  cmd = malloc(sizeof(*cmd));
     346:	00001097          	auipc	ra,0x1
     34a:	05e080e7          	jalr	94(ra) # 13a4 <malloc>
  memset(cmd, 0, sizeof(*cmd));
     34e:	4661                	li	a2,24
     350:	4581                	li	a1,0
  cmd = malloc(sizeof(*cmd));
     352:	84aa                	mv	s1,a0
  memset(cmd, 0, sizeof(*cmd));
     354:	00001097          	auipc	ra,0x1
     358:	9da080e7          	jalr	-1574(ra) # d2e <memset>
  cmd->type = LIST;
  cmd->left = left;
  cmd->right = right;
  return (struct cmd*)cmd;
}
     35c:	70a2                	ld	ra,40(sp)
     35e:	7402                	ld	s0,32(sp)
  cmd->type = LIST;
     360:	4791                	li	a5,4
  cmd->left = left;
     362:	0134b423          	sd	s3,8(s1)
  cmd->right = right;
     366:	0124b823          	sd	s2,16(s1)
  cmd->type = LIST;
     36a:	c09c                	sw	a5,0(s1)
}
     36c:	6942                	ld	s2,16(sp)
     36e:	69a2                	ld	s3,8(sp)
     370:	8526                	mv	a0,s1
     372:	64e2                	ld	s1,24(sp)
     374:	6145                	add	sp,sp,48
     376:	8082                	ret

0000000000000378 <backcmd>:

struct cmd*
backcmd(struct cmd *subcmd)
{
     378:	1101                	add	sp,sp,-32
     37a:	ec06                	sd	ra,24(sp)
     37c:	e822                	sd	s0,16(sp)
     37e:	e426                	sd	s1,8(sp)
     380:	e04a                	sd	s2,0(sp)
     382:	1000                	add	s0,sp,32
     384:	892a                	mv	s2,a0
  struct backcmd *cmd;

  cmd = malloc(sizeof(*cmd));
     386:	4541                	li	a0,16
     388:	00001097          	auipc	ra,0x1
     38c:	01c080e7          	jalr	28(ra) # 13a4 <malloc>
  memset(cmd, 0, sizeof(*cmd));
     390:	4641                	li	a2,16
     392:	4581                	li	a1,0
  cmd = malloc(sizeof(*cmd));
     394:	84aa                	mv	s1,a0
  memset(cmd, 0, sizeof(*cmd));
     396:	00001097          	auipc	ra,0x1
     39a:	998080e7          	jalr	-1640(ra) # d2e <memset>
  cmd->type = BACK;
  cmd->cmd = subcmd;
  return (struct cmd*)cmd;
}
     39e:	60e2                	ld	ra,24(sp)
     3a0:	6442                	ld	s0,16(sp)
  cmd->type = BACK;
     3a2:	4795                	li	a5,5
  cmd->cmd = subcmd;
     3a4:	0124b423          	sd	s2,8(s1)
  cmd->type = BACK;
     3a8:	c09c                	sw	a5,0(s1)
}
     3aa:	6902                	ld	s2,0(sp)
     3ac:	8526                	mv	a0,s1
     3ae:	64a2                	ld	s1,8(sp)
     3b0:	6105                	add	sp,sp,32
     3b2:	8082                	ret

00000000000003b4 <gettoken>:
char whitespace[] = " \t\r\n\v";
char symbols[] = "<|>&;()";

int
gettoken(char **ps, char *es, char **q, char **eq)
{
     3b4:	7139                	add	sp,sp,-64
     3b6:	f822                	sd	s0,48(sp)
     3b8:	f426                	sd	s1,40(sp)
     3ba:	f04a                	sd	s2,32(sp)
     3bc:	ec4e                	sd	s3,24(sp)
     3be:	e852                	sd	s4,16(sp)
     3c0:	e456                	sd	s5,8(sp)
     3c2:	e05a                	sd	s6,0(sp)
     3c4:	fc06                	sd	ra,56(sp)
     3c6:	0080                	add	s0,sp,64
  char *s;
  int ret;

  s = *ps;
     3c8:	6104                	ld	s1,0(a0)
{
     3ca:	8aaa                	mv	s5,a0
     3cc:	892e                	mv	s2,a1
     3ce:	8a32                	mv	s4,a2
     3d0:	8b36                	mv	s6,a3
     3d2:	00002997          	auipc	s3,0x2
     3d6:	c3698993          	add	s3,s3,-970 # 2008 <whitespace>
  while(s < es && strchr(whitespace, *s))
     3da:	00b4e663          	bltu	s1,a1,3e6 <gettoken+0x32>
     3de:	a821                	j	3f6 <gettoken+0x42>
    s++;
     3e0:	0485                	add	s1,s1,1
  while(s < es && strchr(whitespace, *s))
     3e2:	00990a63          	beq	s2,s1,3f6 <gettoken+0x42>
     3e6:	0004c583          	lbu	a1,0(s1)
     3ea:	854e                	mv	a0,s3
     3ec:	00001097          	auipc	ra,0x1
     3f0:	968080e7          	jalr	-1688(ra) # d54 <strchr>
     3f4:	f575                	bnez	a0,3e0 <gettoken+0x2c>
  if(q)
     3f6:	000a0463          	beqz	s4,3fe <gettoken+0x4a>
    *q = s;
     3fa:	009a3023          	sd	s1,0(s4)
  ret = *s;
     3fe:	0004c783          	lbu	a5,0(s1)
  switch(*s){
     402:	03c00713          	li	a4,60
     406:	06f76a63          	bltu	a4,a5,47a <gettoken+0xc6>
     40a:	03a00713          	li	a4,58
     40e:	00f76e63          	bltu	a4,a5,42a <gettoken+0x76>
     412:	c3b5                	beqz	a5,476 <gettoken+0xc2>
     414:	02600713          	li	a4,38
     418:	00e78963          	beq	a5,a4,42a <gettoken+0x76>
     41c:	fd87871b          	addw	a4,a5,-40
     420:	0ff77713          	zext.b	a4,a4
     424:	4685                	li	a3,1
     426:	06e6ee63          	bltu	a3,a4,4a2 <gettoken+0xee>
  ret = *s;
     42a:	00078a1b          	sext.w	s4,a5
  case '(':
  case ')':
  case ';':
  case '&':
  case '<':
    s++;
     42e:	0485                	add	s1,s1,1
    ret = 'a';
    while(s < es && !strchr(whitespace, *s) && !strchr(symbols, *s))
      s++;
    break;
  }
  if(eq)
     430:	000b0463          	beqz	s6,438 <gettoken+0x84>
    *eq = s;
     434:	009b3023          	sd	s1,0(s6)

  while(s < es && strchr(whitespace, *s))
     438:	00002997          	auipc	s3,0x2
     43c:	bd098993          	add	s3,s3,-1072 # 2008 <whitespace>
     440:	0124e663          	bltu	s1,s2,44c <gettoken+0x98>
     444:	a821                	j	45c <gettoken+0xa8>
    s++;
     446:	0485                	add	s1,s1,1
  while(s < es && strchr(whitespace, *s))
     448:	00990a63          	beq	s2,s1,45c <gettoken+0xa8>
     44c:	0004c583          	lbu	a1,0(s1)
     450:	854e                	mv	a0,s3
     452:	00001097          	auipc	ra,0x1
     456:	902080e7          	jalr	-1790(ra) # d54 <strchr>
     45a:	f575                	bnez	a0,446 <gettoken+0x92>
  *ps = s;
  return ret;
}
     45c:	70e2                	ld	ra,56(sp)
     45e:	7442                	ld	s0,48(sp)
  *ps = s;
     460:	009ab023          	sd	s1,0(s5)
}
     464:	7902                	ld	s2,32(sp)
     466:	74a2                	ld	s1,40(sp)
     468:	69e2                	ld	s3,24(sp)
     46a:	6aa2                	ld	s5,8(sp)
     46c:	6b02                	ld	s6,0(sp)
     46e:	8552                	mv	a0,s4
     470:	6a42                	ld	s4,16(sp)
     472:	6121                	add	sp,sp,64
     474:	8082                	ret
  switch(*s){
     476:	4a01                	li	s4,0
     478:	bf65                	j	430 <gettoken+0x7c>
     47a:	03e00713          	li	a4,62
     47e:	00e79e63          	bne	a5,a4,49a <gettoken+0xe6>
    if(*s == '>'){
     482:	0014c703          	lbu	a4,1(s1)
     486:	00f70663          	beq	a4,a5,492 <gettoken+0xde>
    s++;
     48a:	0485                	add	s1,s1,1
  ret = *s;
     48c:	03e00a13          	li	s4,62
     490:	b745                	j	430 <gettoken+0x7c>
      s++;
     492:	0489                	add	s1,s1,2
      ret = '+';
     494:	02b00a13          	li	s4,43
     498:	bf61                	j	430 <gettoken+0x7c>
  switch(*s){
     49a:	07c00713          	li	a4,124
     49e:	f8e786e3          	beq	a5,a4,42a <gettoken+0x76>
    while(s < es && !strchr(whitespace, *s) && !strchr(symbols, *s))
     4a2:	00002a17          	auipc	s4,0x2
     4a6:	b66a0a13          	add	s4,s4,-1178 # 2008 <whitespace>
     4aa:	00002997          	auipc	s3,0x2
     4ae:	b5698993          	add	s3,s3,-1194 # 2000 <symbols>
     4b2:	0124ed63          	bltu	s1,s2,4cc <gettoken+0x118>
     4b6:	a081                	j	4f6 <gettoken+0x142>
     4b8:	0004c583          	lbu	a1,0(s1)
     4bc:	00001097          	auipc	ra,0x1
     4c0:	898080e7          	jalr	-1896(ra) # d54 <strchr>
     4c4:	ed11                	bnez	a0,4e0 <gettoken+0x12c>
      s++;
     4c6:	0485                	add	s1,s1,1
    while(s < es && !strchr(whitespace, *s) && !strchr(symbols, *s))
     4c8:	00990f63          	beq	s2,s1,4e6 <gettoken+0x132>
     4cc:	0004c583          	lbu	a1,0(s1)
     4d0:	8552                	mv	a0,s4
     4d2:	00001097          	auipc	ra,0x1
     4d6:	882080e7          	jalr	-1918(ra) # d54 <strchr>
     4da:	87aa                	mv	a5,a0
     4dc:	854e                	mv	a0,s3
     4de:	dfe9                	beqz	a5,4b8 <gettoken+0x104>
    ret = 'a';
     4e0:	06100a13          	li	s4,97
     4e4:	b7b1                	j	430 <gettoken+0x7c>
  if(eq)
     4e6:	000b0463          	beqz	s6,4ee <gettoken+0x13a>
    *eq = s;
     4ea:	012b3023          	sd	s2,0(s6)
  while(s < es && strchr(whitespace, *s))
     4ee:	84ca                	mv	s1,s2
    ret = 'a';
     4f0:	06100a13          	li	s4,97
     4f4:	b7a5                	j	45c <gettoken+0xa8>
  if(eq)
     4f6:	fe0b0de3          	beqz	s6,4f0 <gettoken+0x13c>
    *eq = s;
     4fa:	009b3023          	sd	s1,0(s6)
    ret = 'a';
     4fe:	06100a13          	li	s4,97
     502:	bfa9                	j	45c <gettoken+0xa8>

0000000000000504 <peek>:

int
peek(char **ps, char *es, char *toks)
{
     504:	7139                	add	sp,sp,-64
     506:	f822                	sd	s0,48(sp)
     508:	f426                	sd	s1,40(sp)
     50a:	e852                	sd	s4,16(sp)
     50c:	e456                	sd	s5,8(sp)
     50e:	fc06                	sd	ra,56(sp)
     510:	0080                	add	s0,sp,64
  char *s;

  s = *ps;
     512:	6104                	ld	s1,0(a0)
{
     514:	8a2a                	mv	s4,a0
     516:	8ab2                	mv	s5,a2
  while(s < es && strchr(whitespace, *s))
     518:	02b4f763          	bgeu	s1,a1,546 <peek+0x42>
     51c:	f04a                	sd	s2,32(sp)
     51e:	ec4e                	sd	s3,24(sp)
     520:	892e                	mv	s2,a1
     522:	00002997          	auipc	s3,0x2
     526:	ae698993          	add	s3,s3,-1306 # 2008 <whitespace>
     52a:	a021                	j	532 <peek+0x2e>
    s++;
     52c:	0485                	add	s1,s1,1
  while(s < es && strchr(whitespace, *s))
     52e:	00990a63          	beq	s2,s1,542 <peek+0x3e>
     532:	0004c583          	lbu	a1,0(s1)
     536:	854e                	mv	a0,s3
     538:	00001097          	auipc	ra,0x1
     53c:	81c080e7          	jalr	-2020(ra) # d54 <strchr>
     540:	f575                	bnez	a0,52c <peek+0x28>
     542:	7902                	ld	s2,32(sp)
     544:	69e2                	ld	s3,24(sp)
  *ps = s;
     546:	009a3023          	sd	s1,0(s4)
  return *s && strchr(toks, *s);
     54a:	0004c583          	lbu	a1,0(s1)
     54e:	4501                	li	a0,0
     550:	e981                	bnez	a1,560 <peek+0x5c>
}
     552:	70e2                	ld	ra,56(sp)
     554:	7442                	ld	s0,48(sp)
     556:	74a2                	ld	s1,40(sp)
     558:	6a42                	ld	s4,16(sp)
     55a:	6aa2                	ld	s5,8(sp)
     55c:	6121                	add	sp,sp,64
     55e:	8082                	ret
  return *s && strchr(toks, *s);
     560:	8556                	mv	a0,s5
     562:	00000097          	auipc	ra,0x0
     566:	7f2080e7          	jalr	2034(ra) # d54 <strchr>
}
     56a:	70e2                	ld	ra,56(sp)
     56c:	7442                	ld	s0,48(sp)
     56e:	74a2                	ld	s1,40(sp)
     570:	6a42                	ld	s4,16(sp)
     572:	6aa2                	ld	s5,8(sp)
  return *s && strchr(toks, *s);
     574:	00a03533          	snez	a0,a0
}
     578:	6121                	add	sp,sp,64
     57a:	8082                	ret

000000000000057c <parseredirs>:
  return cmd;
}

struct cmd*
parseredirs(struct cmd *cmd, char **ps, char *es)
{
     57c:	7159                	add	sp,sp,-112
     57e:	f45e                	sd	s7,40(sp)
  cmd->mode = mode;
     580:	4b85                	li	s7,1
{
     582:	f0a2                	sd	s0,96(sp)
     584:	e8ca                	sd	s2,80(sp)
     586:	e4ce                	sd	s3,72(sp)
     588:	e0d2                	sd	s4,64(sp)
     58a:	fc56                	sd	s5,56(sp)
     58c:	f85a                	sd	s6,48(sp)
     58e:	f486                	sd	ra,104(sp)
     590:	eca6                	sd	s1,88(sp)
     592:	f062                	sd	s8,32(sp)
     594:	ec66                	sd	s9,24(sp)
     596:	1880                	add	s0,sp,112
  cmd->mode = mode;
     598:	1b82                	sll	s7,s7,0x20
{
     59a:	8a2a                	mv	s4,a0
     59c:	89ae                	mv	s3,a1
     59e:	8932                	mv	s2,a2
  int tok;
  char *q, *eq;

  while(peek(ps, es, "<>")){
     5a0:	00001a97          	auipc	s5,0x1
     5a4:	f70a8a93          	add	s5,s5,-144 # 1510 <malloc+0x16c>
    tok = gettoken(ps, es, 0, 0);
    if(gettoken(ps, es, &q, &eq) != 'a')
     5a8:	06100b13          	li	s6,97
  cmd->mode = mode;
     5ac:	601b8b93          	add	s7,s7,1537
      panic("missing file for redirection");
    switch(tok){
     5b0:	03c00c13          	li	s8,60
  while(peek(ps, es, "<>")){
     5b4:	8656                	mv	a2,s5
     5b6:	85ca                	mv	a1,s2
     5b8:	854e                	mv	a0,s3
     5ba:	00000097          	auipc	ra,0x0
     5be:	f4a080e7          	jalr	-182(ra) # 504 <peek>
     5c2:	cd6d                	beqz	a0,6bc <parseredirs+0x140>
    tok = gettoken(ps, es, 0, 0);
     5c4:	4681                	li	a3,0
     5c6:	4601                	li	a2,0
     5c8:	85ca                	mv	a1,s2
     5ca:	854e                	mv	a0,s3
     5cc:	00000097          	auipc	ra,0x0
     5d0:	de8080e7          	jalr	-536(ra) # 3b4 <gettoken>
     5d4:	84aa                	mv	s1,a0
    if(gettoken(ps, es, &q, &eq) != 'a')
     5d6:	f9840693          	add	a3,s0,-104
     5da:	f9040613          	add	a2,s0,-112
     5de:	85ca                	mv	a1,s2
     5e0:	854e                	mv	a0,s3
     5e2:	00000097          	auipc	ra,0x0
     5e6:	dd2080e7          	jalr	-558(ra) # 3b4 <gettoken>
     5ea:	0f651763          	bne	a0,s6,6d8 <parseredirs+0x15c>
    switch(tok){
     5ee:	05848b63          	beq	s1,s8,644 <parseredirs+0xc8>
     5f2:	03e00793          	li	a5,62
     5f6:	08f48563          	beq	s1,a5,680 <parseredirs+0x104>
     5fa:	02b00793          	li	a5,43
     5fe:	faf49be3          	bne	s1,a5,5b4 <parseredirs+0x38>
  cmd = malloc(sizeof(*cmd));
     602:	02800513          	li	a0,40
      break;
    case '>':
      cmd = redircmd(cmd, q, eq, O_WRONLY|O_CREATE|O_TRUNC, 1);
      break;
    case '+':  // >>
      cmd = redircmd(cmd, q, eq, O_WRONLY|O_CREATE, 1);
     606:	f9043c83          	ld	s9,-112(s0)
     60a:	f9843c03          	ld	s8,-104(s0)
  cmd = malloc(sizeof(*cmd));
     60e:	00001097          	auipc	ra,0x1
     612:	d96080e7          	jalr	-618(ra) # 13a4 <malloc>
  memset(cmd, 0, sizeof(*cmd));
     616:	02800613          	li	a2,40
     61a:	4581                	li	a1,0
  cmd = malloc(sizeof(*cmd));
     61c:	84aa                	mv	s1,a0
  memset(cmd, 0, sizeof(*cmd));
     61e:	00000097          	auipc	ra,0x0
     622:	710080e7          	jalr	1808(ra) # d2e <memset>
  cmd->mode = mode;
     626:	4785                	li	a5,1
     628:	1782                	sll	a5,a5,0x20
     62a:	20178793          	add	a5,a5,513
  cmd->type = REDIR;
     62e:	4709                	li	a4,2
  cmd->cmd = subcmd;
     630:	0144b423          	sd	s4,8(s1)
  cmd->type = REDIR;
     634:	c098                	sw	a4,0(s1)
  cmd->file = file;
     636:	0194b823          	sd	s9,16(s1)
  cmd->efile = efile;
     63a:	0184bc23          	sd	s8,24(s1)
  cmd->mode = mode;
     63e:	f09c                	sd	a5,32(s1)
      cmd = redircmd(cmd, q, eq, O_WRONLY|O_CREATE, 1);
     640:	8a26                	mv	s4,s1
      break;
     642:	b7bd                	j	5b0 <parseredirs+0x34>
  cmd = malloc(sizeof(*cmd));
     644:	02800513          	li	a0,40
      cmd = redircmd(cmd, q, eq, O_RDONLY, 0);
     648:	f9043c83          	ld	s9,-112(s0)
     64c:	f9843c03          	ld	s8,-104(s0)
  cmd = malloc(sizeof(*cmd));
     650:	00001097          	auipc	ra,0x1
     654:	d54080e7          	jalr	-684(ra) # 13a4 <malloc>
  memset(cmd, 0, sizeof(*cmd));
     658:	02800613          	li	a2,40
     65c:	4581                	li	a1,0
  cmd = malloc(sizeof(*cmd));
     65e:	84aa                	mv	s1,a0
  memset(cmd, 0, sizeof(*cmd));
     660:	00000097          	auipc	ra,0x0
     664:	6ce080e7          	jalr	1742(ra) # d2e <memset>
  cmd->type = REDIR;
     668:	4789                	li	a5,2
  cmd->cmd = subcmd;
     66a:	0144b423          	sd	s4,8(s1)
  cmd->type = REDIR;
     66e:	c09c                	sw	a5,0(s1)
  cmd->file = file;
     670:	0194b823          	sd	s9,16(s1)
  cmd->efile = efile;
     674:	0184bc23          	sd	s8,24(s1)
  cmd->mode = mode;
     678:	0204b023          	sd	zero,32(s1)
      cmd = redircmd(cmd, q, eq, O_RDONLY, 0);
     67c:	8a26                	mv	s4,s1
      break;
     67e:	bf0d                	j	5b0 <parseredirs+0x34>
  cmd = malloc(sizeof(*cmd));
     680:	02800513          	li	a0,40
      cmd = redircmd(cmd, q, eq, O_WRONLY|O_CREATE|O_TRUNC, 1);
     684:	f9043c83          	ld	s9,-112(s0)
     688:	f9843c03          	ld	s8,-104(s0)
  cmd = malloc(sizeof(*cmd));
     68c:	00001097          	auipc	ra,0x1
     690:	d18080e7          	jalr	-744(ra) # 13a4 <malloc>
  memset(cmd, 0, sizeof(*cmd));
     694:	02800613          	li	a2,40
     698:	4581                	li	a1,0
  cmd = malloc(sizeof(*cmd));
     69a:	84aa                	mv	s1,a0
  memset(cmd, 0, sizeof(*cmd));
     69c:	00000097          	auipc	ra,0x0
     6a0:	692080e7          	jalr	1682(ra) # d2e <memset>
  cmd->type = REDIR;
     6a4:	4789                	li	a5,2
  cmd->cmd = subcmd;
     6a6:	0144b423          	sd	s4,8(s1)
  cmd->type = REDIR;
     6aa:	c09c                	sw	a5,0(s1)
  cmd->file = file;
     6ac:	0194b823          	sd	s9,16(s1)
  cmd->efile = efile;
     6b0:	0184bc23          	sd	s8,24(s1)
  cmd->mode = mode;
     6b4:	0374b023          	sd	s7,32(s1)
      cmd = redircmd(cmd, q, eq, O_WRONLY|O_CREATE|O_TRUNC, 1);
     6b8:	8a26                	mv	s4,s1
      break;
     6ba:	bddd                	j	5b0 <parseredirs+0x34>
    }
  }
  return cmd;
}
     6bc:	70a6                	ld	ra,104(sp)
     6be:	7406                	ld	s0,96(sp)
     6c0:	64e6                	ld	s1,88(sp)
     6c2:	6946                	ld	s2,80(sp)
     6c4:	69a6                	ld	s3,72(sp)
     6c6:	7ae2                	ld	s5,56(sp)
     6c8:	7b42                	ld	s6,48(sp)
     6ca:	7ba2                	ld	s7,40(sp)
     6cc:	7c02                	ld	s8,32(sp)
     6ce:	6ce2                	ld	s9,24(sp)
     6d0:	8552                	mv	a0,s4
     6d2:	6a06                	ld	s4,64(sp)
     6d4:	6165                	add	sp,sp,112
     6d6:	8082                	ret
      panic("missing file for redirection");
     6d8:	00001517          	auipc	a0,0x1
     6dc:	e1850513          	add	a0,a0,-488 # 14f0 <malloc+0x14c>
     6e0:	00000097          	auipc	ra,0x0
     6e4:	976080e7          	jalr	-1674(ra) # 56 <panic>

00000000000006e8 <parseexec>:
  return cmd;
}

struct cmd*
parseexec(char **ps, char *es)
{
     6e8:	7159                	add	sp,sp,-112
     6ea:	f0a2                	sd	s0,96(sp)
     6ec:	e0d2                	sd	s4,64(sp)
     6ee:	fc56                	sd	s5,56(sp)
     6f0:	f486                	sd	ra,104(sp)
     6f2:	1880                	add	s0,sp,112
  char *q, *eq;
  int tok, argc;
  struct execcmd *cmd;
  struct cmd *ret;

  if(peek(ps, es, "("))
     6f4:	00001617          	auipc	a2,0x1
     6f8:	e2460613          	add	a2,a2,-476 # 1518 <malloc+0x174>
{
     6fc:	8a2a                	mv	s4,a0
     6fe:	8aae                	mv	s5,a1
  if(peek(ps, es, "("))
     700:	00000097          	auipc	ra,0x0
     704:	e04080e7          	jalr	-508(ra) # 504 <peek>
     708:	ed4d                	bnez	a0,7c2 <parseexec+0xda>
     70a:	eca6                	sd	s1,88(sp)
     70c:	84aa                	mv	s1,a0
  cmd = malloc(sizeof(*cmd));
     70e:	0a800513          	li	a0,168
     712:	e8ca                	sd	s2,80(sp)
     714:	e4ce                	sd	s3,72(sp)
     716:	f85a                	sd	s6,48(sp)
     718:	f45e                	sd	s7,40(sp)
     71a:	f062                	sd	s8,32(sp)
     71c:	ec66                	sd	s9,24(sp)
     71e:	00001097          	auipc	ra,0x1
     722:	c86080e7          	jalr	-890(ra) # 13a4 <malloc>
  memset(cmd, 0, sizeof(*cmd));
     726:	0a800613          	li	a2,168
     72a:	4581                	li	a1,0
  cmd = malloc(sizeof(*cmd));
     72c:	8caa                	mv	s9,a0
  memset(cmd, 0, sizeof(*cmd));
     72e:	00000097          	auipc	ra,0x0
     732:	600080e7          	jalr	1536(ra) # d2e <memset>
  cmd->type = EXEC;
     736:	4785                	li	a5,1
     738:	00fca023          	sw	a5,0(s9)

  ret = execcmd();
  cmd = (struct execcmd*)ret;

  argc = 0;
  ret = parseredirs(ret, ps, es);
     73c:	8656                	mv	a2,s5
     73e:	85d2                	mv	a1,s4
     740:	8566                	mv	a0,s9
     742:	00000097          	auipc	ra,0x0
     746:	e3a080e7          	jalr	-454(ra) # 57c <parseredirs>
     74a:	89aa                	mv	s3,a0
  while(!peek(ps, es, "|)&;")){
     74c:	008c8913          	add	s2,s9,8
     750:	00001b17          	auipc	s6,0x1
     754:	de8b0b13          	add	s6,s6,-536 # 1538 <malloc+0x194>
    if((tok=gettoken(ps, es, &q, &eq)) == 0)
      break;
    if(tok != 'a')
     758:	06100c13          	li	s8,97
      panic("syntax");
    cmd->argv[argc] = q;
    cmd->eargv[argc] = eq;
    argc++;
    if(argc >= MAXARGS)
     75c:	4ba9                	li	s7,10
  while(!peek(ps, es, "|)&;")){
     75e:	a809                	j	770 <parseexec+0x88>
      panic("too many args");
    ret = parseredirs(ret, ps, es);
     760:	854e                	mv	a0,s3
     762:	8656                	mv	a2,s5
     764:	85d2                	mv	a1,s4
     766:	00000097          	auipc	ra,0x0
     76a:	e16080e7          	jalr	-490(ra) # 57c <parseredirs>
     76e:	89aa                	mv	s3,a0
  while(!peek(ps, es, "|)&;")){
     770:	865a                	mv	a2,s6
     772:	85d6                	mv	a1,s5
     774:	8552                	mv	a0,s4
     776:	00000097          	auipc	ra,0x0
     77a:	d8e080e7          	jalr	-626(ra) # 504 <peek>
     77e:	ed29                	bnez	a0,7d8 <parseexec+0xf0>
    if((tok=gettoken(ps, es, &q, &eq)) == 0)
     780:	f9840693          	add	a3,s0,-104
     784:	f9040613          	add	a2,s0,-112
     788:	85d6                	mv	a1,s5
     78a:	8552                	mv	a0,s4
     78c:	00000097          	auipc	ra,0x0
     790:	c28080e7          	jalr	-984(ra) # 3b4 <gettoken>
     794:	c131                	beqz	a0,7d8 <parseexec+0xf0>
    if(tok != 'a')
     796:	07851563          	bne	a0,s8,800 <parseexec+0x118>
    cmd->argv[argc] = q;
     79a:	f9043783          	ld	a5,-112(s0)
    argc++;
     79e:	2485                	addw	s1,s1,1
    if(argc >= MAXARGS)
     7a0:	0921                	add	s2,s2,8
    cmd->argv[argc] = q;
     7a2:	fef93c23          	sd	a5,-8(s2)
    cmd->eargv[argc] = eq;
     7a6:	f9843783          	ld	a5,-104(s0)
     7aa:	04f93423          	sd	a5,72(s2)
    if(argc >= MAXARGS)
     7ae:	fb7499e3          	bne	s1,s7,760 <parseexec+0x78>
      panic("too many args");
     7b2:	00001517          	auipc	a0,0x1
     7b6:	d7650513          	add	a0,a0,-650 # 1528 <malloc+0x184>
     7ba:	00000097          	auipc	ra,0x0
     7be:	89c080e7          	jalr	-1892(ra) # 56 <panic>
  }
  cmd->argv[argc] = 0;
  cmd->eargv[argc] = 0;
  return ret;
}
     7c2:	7406                	ld	s0,96(sp)
     7c4:	70a6                	ld	ra,104(sp)
    return parseblock(ps, es);
     7c6:	85d6                	mv	a1,s5
     7c8:	8552                	mv	a0,s4
}
     7ca:	7ae2                	ld	s5,56(sp)
     7cc:	6a06                	ld	s4,64(sp)
     7ce:	6165                	add	sp,sp,112
    return parseblock(ps, es);
     7d0:	00000317          	auipc	t1,0x0
     7d4:	1b830067          	jr	440(t1) # 988 <parseblock>
}
     7d8:	70a6                	ld	ra,104(sp)
     7da:	7406                	ld	s0,96(sp)
     7dc:	048e                	sll	s1,s1,0x3
     7de:	94e6                	add	s1,s1,s9
  cmd->argv[argc] = 0;
     7e0:	0004b423          	sd	zero,8(s1)
  cmd->eargv[argc] = 0;
     7e4:	0404bc23          	sd	zero,88(s1)
}
     7e8:	6946                	ld	s2,80(sp)
     7ea:	64e6                	ld	s1,88(sp)
     7ec:	7b42                	ld	s6,48(sp)
     7ee:	7ba2                	ld	s7,40(sp)
     7f0:	7c02                	ld	s8,32(sp)
     7f2:	6ce2                	ld	s9,24(sp)
     7f4:	6a06                	ld	s4,64(sp)
     7f6:	7ae2                	ld	s5,56(sp)
     7f8:	854e                	mv	a0,s3
     7fa:	69a6                	ld	s3,72(sp)
     7fc:	6165                	add	sp,sp,112
     7fe:	8082                	ret
      panic("syntax");
     800:	00001517          	auipc	a0,0x1
     804:	d2050513          	add	a0,a0,-736 # 1520 <malloc+0x17c>
     808:	00000097          	auipc	ra,0x0
     80c:	84e080e7          	jalr	-1970(ra) # 56 <panic>

0000000000000810 <parsepipe>:
{
     810:	7179                	add	sp,sp,-48
     812:	f022                	sd	s0,32(sp)
     814:	ec26                	sd	s1,24(sp)
     816:	e84a                	sd	s2,16(sp)
     818:	e44e                	sd	s3,8(sp)
     81a:	f406                	sd	ra,40(sp)
     81c:	1800                	add	s0,sp,48
     81e:	892a                	mv	s2,a0
     820:	89ae                	mv	s3,a1
  cmd = parseexec(ps, es);
     822:	00000097          	auipc	ra,0x0
     826:	ec6080e7          	jalr	-314(ra) # 6e8 <parseexec>
     82a:	84aa                	mv	s1,a0
  if(peek(ps, es, "|")){
     82c:	00001617          	auipc	a2,0x1
     830:	d1460613          	add	a2,a2,-748 # 1540 <malloc+0x19c>
     834:	85ce                	mv	a1,s3
     836:	854a                	mv	a0,s2
     838:	00000097          	auipc	ra,0x0
     83c:	ccc080e7          	jalr	-820(ra) # 504 <peek>
     840:	e909                	bnez	a0,852 <parsepipe+0x42>
}
     842:	70a2                	ld	ra,40(sp)
     844:	7402                	ld	s0,32(sp)
     846:	6942                	ld	s2,16(sp)
     848:	69a2                	ld	s3,8(sp)
     84a:	8526                	mv	a0,s1
     84c:	64e2                	ld	s1,24(sp)
     84e:	6145                	add	sp,sp,48
     850:	8082                	ret
    gettoken(ps, es, 0, 0);
     852:	4681                	li	a3,0
     854:	4601                	li	a2,0
     856:	85ce                	mv	a1,s3
     858:	854a                	mv	a0,s2
     85a:	00000097          	auipc	ra,0x0
     85e:	b5a080e7          	jalr	-1190(ra) # 3b4 <gettoken>
    cmd = pipecmd(cmd, parsepipe(ps, es));
     862:	85ce                	mv	a1,s3
     864:	854a                	mv	a0,s2
     866:	00000097          	auipc	ra,0x0
     86a:	faa080e7          	jalr	-86(ra) # 810 <parsepipe>
     86e:	89aa                	mv	s3,a0
  cmd = malloc(sizeof(*cmd));
     870:	4561                	li	a0,24
     872:	00001097          	auipc	ra,0x1
     876:	b32080e7          	jalr	-1230(ra) # 13a4 <malloc>
  memset(cmd, 0, sizeof(*cmd));
     87a:	4661                	li	a2,24
     87c:	4581                	li	a1,0
  cmd = malloc(sizeof(*cmd));
     87e:	892a                	mv	s2,a0
  memset(cmd, 0, sizeof(*cmd));
     880:	00000097          	auipc	ra,0x0
     884:	4ae080e7          	jalr	1198(ra) # d2e <memset>
}
     888:	70a2                	ld	ra,40(sp)
     88a:	7402                	ld	s0,32(sp)
  cmd->type = PIPE;
     88c:	478d                	li	a5,3
  cmd->left = left;
     88e:	00993423          	sd	s1,8(s2)
  cmd->right = right;
     892:	01393823          	sd	s3,16(s2)
    cmd = pipecmd(cmd, parsepipe(ps, es));
     896:	84ca                	mv	s1,s2
  cmd->type = PIPE;
     898:	00f92023          	sw	a5,0(s2)
}
     89c:	69a2                	ld	s3,8(sp)
     89e:	6942                	ld	s2,16(sp)
     8a0:	8526                	mv	a0,s1
     8a2:	64e2                	ld	s1,24(sp)
     8a4:	6145                	add	sp,sp,48
     8a6:	8082                	ret

00000000000008a8 <parseline>:
{
     8a8:	7139                	add	sp,sp,-64
     8aa:	f822                	sd	s0,48(sp)
     8ac:	f04a                	sd	s2,32(sp)
     8ae:	ec4e                	sd	s3,24(sp)
     8b0:	e852                	sd	s4,16(sp)
     8b2:	e456                	sd	s5,8(sp)
     8b4:	e05a                	sd	s6,0(sp)
     8b6:	fc06                	sd	ra,56(sp)
     8b8:	f426                	sd	s1,40(sp)
     8ba:	0080                	add	s0,sp,64
     8bc:	892a                	mv	s2,a0
     8be:	89ae                	mv	s3,a1
  cmd = parsepipe(ps, es);
     8c0:	00000097          	auipc	ra,0x0
     8c4:	f50080e7          	jalr	-176(ra) # 810 <parsepipe>
     8c8:	8a2a                	mv	s4,a0
  while(peek(ps, es, "&")){
     8ca:	00001a97          	auipc	s5,0x1
     8ce:	c7ea8a93          	add	s5,s5,-898 # 1548 <malloc+0x1a4>
  cmd->type = BACK;
     8d2:	4b15                	li	s6,5
  while(peek(ps, es, "&")){
     8d4:	a035                	j	900 <parseline+0x58>
    gettoken(ps, es, 0, 0);
     8d6:	00000097          	auipc	ra,0x0
     8da:	ade080e7          	jalr	-1314(ra) # 3b4 <gettoken>
  cmd = malloc(sizeof(*cmd));
     8de:	4541                	li	a0,16
     8e0:	00001097          	auipc	ra,0x1
     8e4:	ac4080e7          	jalr	-1340(ra) # 13a4 <malloc>
     8e8:	84aa                	mv	s1,a0
  memset(cmd, 0, sizeof(*cmd));
     8ea:	4641                	li	a2,16
     8ec:	4581                	li	a1,0
     8ee:	00000097          	auipc	ra,0x0
     8f2:	440080e7          	jalr	1088(ra) # d2e <memset>
  cmd->cmd = subcmd;
     8f6:	0144b423          	sd	s4,8(s1)
  cmd->type = BACK;
     8fa:	0164a023          	sw	s6,0(s1)
    cmd = backcmd(cmd);
     8fe:	8a26                	mv	s4,s1
  while(peek(ps, es, "&")){
     900:	8656                	mv	a2,s5
     902:	85ce                	mv	a1,s3
     904:	854a                	mv	a0,s2
     906:	00000097          	auipc	ra,0x0
     90a:	bfe080e7          	jalr	-1026(ra) # 504 <peek>
     90e:	87aa                	mv	a5,a0
    gettoken(ps, es, 0, 0);
     910:	4681                	li	a3,0
     912:	4601                	li	a2,0
     914:	85ce                	mv	a1,s3
     916:	854a                	mv	a0,s2
  while(peek(ps, es, "&")){
     918:	ffdd                	bnez	a5,8d6 <parseline+0x2e>
  if(peek(ps, es, ";")){
     91a:	00001617          	auipc	a2,0x1
     91e:	c3660613          	add	a2,a2,-970 # 1550 <malloc+0x1ac>
     922:	00000097          	auipc	ra,0x0
     926:	be2080e7          	jalr	-1054(ra) # 504 <peek>
     92a:	ed01                	bnez	a0,942 <parseline+0x9a>
}
     92c:	70e2                	ld	ra,56(sp)
     92e:	7442                	ld	s0,48(sp)
     930:	74a2                	ld	s1,40(sp)
     932:	7902                	ld	s2,32(sp)
     934:	69e2                	ld	s3,24(sp)
     936:	6aa2                	ld	s5,8(sp)
     938:	6b02                	ld	s6,0(sp)
     93a:	8552                	mv	a0,s4
     93c:	6a42                	ld	s4,16(sp)
     93e:	6121                	add	sp,sp,64
     940:	8082                	ret
    gettoken(ps, es, 0, 0);
     942:	4681                	li	a3,0
     944:	4601                	li	a2,0
     946:	85ce                	mv	a1,s3
     948:	854a                	mv	a0,s2
     94a:	00000097          	auipc	ra,0x0
     94e:	a6a080e7          	jalr	-1430(ra) # 3b4 <gettoken>
    cmd = listcmd(cmd, parseline(ps, es));
     952:	85ce                	mv	a1,s3
     954:	854a                	mv	a0,s2
     956:	00000097          	auipc	ra,0x0
     95a:	f52080e7          	jalr	-174(ra) # 8a8 <parseline>
     95e:	892a                	mv	s2,a0
  cmd = malloc(sizeof(*cmd));
     960:	4561                	li	a0,24
     962:	00001097          	auipc	ra,0x1
     966:	a42080e7          	jalr	-1470(ra) # 13a4 <malloc>
  memset(cmd, 0, sizeof(*cmd));
     96a:	4661                	li	a2,24
     96c:	4581                	li	a1,0
  cmd = malloc(sizeof(*cmd));
     96e:	84aa                	mv	s1,a0
  memset(cmd, 0, sizeof(*cmd));
     970:	00000097          	auipc	ra,0x0
     974:	3be080e7          	jalr	958(ra) # d2e <memset>
  cmd->type = LIST;
     978:	4791                	li	a5,4
  cmd->left = left;
     97a:	0144b423          	sd	s4,8(s1)
  cmd->type = LIST;
     97e:	c09c                	sw	a5,0(s1)
  cmd->right = right;
     980:	0124b823          	sd	s2,16(s1)
    cmd = listcmd(cmd, parseline(ps, es));
     984:	8a26                	mv	s4,s1
  return cmd;
     986:	b75d                	j	92c <parseline+0x84>

0000000000000988 <parseblock>:
{
     988:	7179                	add	sp,sp,-48
     98a:	f022                	sd	s0,32(sp)
     98c:	ec26                	sd	s1,24(sp)
     98e:	e84a                	sd	s2,16(sp)
     990:	f406                	sd	ra,40(sp)
     992:	e44e                	sd	s3,8(sp)
     994:	1800                	add	s0,sp,48
  if(!peek(ps, es, "("))
     996:	00001617          	auipc	a2,0x1
     99a:	b8260613          	add	a2,a2,-1150 # 1518 <malloc+0x174>
{
     99e:	84aa                	mv	s1,a0
     9a0:	892e                	mv	s2,a1
  if(!peek(ps, es, "("))
     9a2:	00000097          	auipc	ra,0x0
     9a6:	b62080e7          	jalr	-1182(ra) # 504 <peek>
     9aa:	c125                	beqz	a0,a0a <parseblock+0x82>
  gettoken(ps, es, 0, 0);
     9ac:	4601                	li	a2,0
     9ae:	4681                	li	a3,0
     9b0:	85ca                	mv	a1,s2
     9b2:	8526                	mv	a0,s1
     9b4:	00000097          	auipc	ra,0x0
     9b8:	a00080e7          	jalr	-1536(ra) # 3b4 <gettoken>
  cmd = parseline(ps, es);
     9bc:	85ca                	mv	a1,s2
     9be:	8526                	mv	a0,s1
     9c0:	00000097          	auipc	ra,0x0
     9c4:	ee8080e7          	jalr	-280(ra) # 8a8 <parseline>
     9c8:	89aa                	mv	s3,a0
  if(!peek(ps, es, ")"))
     9ca:	00001617          	auipc	a2,0x1
     9ce:	b9e60613          	add	a2,a2,-1122 # 1568 <malloc+0x1c4>
     9d2:	85ca                	mv	a1,s2
     9d4:	8526                	mv	a0,s1
     9d6:	00000097          	auipc	ra,0x0
     9da:	b2e080e7          	jalr	-1234(ra) # 504 <peek>
     9de:	cd15                	beqz	a0,a1a <parseblock+0x92>
  gettoken(ps, es, 0, 0);
     9e0:	85ca                	mv	a1,s2
     9e2:	4601                	li	a2,0
     9e4:	8526                	mv	a0,s1
     9e6:	4681                	li	a3,0
     9e8:	00000097          	auipc	ra,0x0
     9ec:	9cc080e7          	jalr	-1588(ra) # 3b4 <gettoken>
}
     9f0:	7402                	ld	s0,32(sp)
     9f2:	70a2                	ld	ra,40(sp)
  cmd = parseredirs(cmd, ps, es);
     9f4:	864a                	mv	a2,s2
     9f6:	85a6                	mv	a1,s1
}
     9f8:	6942                	ld	s2,16(sp)
     9fa:	64e2                	ld	s1,24(sp)
  cmd = parseredirs(cmd, ps, es);
     9fc:	854e                	mv	a0,s3
}
     9fe:	69a2                	ld	s3,8(sp)
     a00:	6145                	add	sp,sp,48
  cmd = parseredirs(cmd, ps, es);
     a02:	00000317          	auipc	t1,0x0
     a06:	b7a30067          	jr	-1158(t1) # 57c <parseredirs>
    panic("parseblock");
     a0a:	00001517          	auipc	a0,0x1
     a0e:	b4e50513          	add	a0,a0,-1202 # 1558 <malloc+0x1b4>
     a12:	fffff097          	auipc	ra,0xfffff
     a16:	644080e7          	jalr	1604(ra) # 56 <panic>
    panic("syntax - missing )");
     a1a:	00001517          	auipc	a0,0x1
     a1e:	b5650513          	add	a0,a0,-1194 # 1570 <malloc+0x1cc>
     a22:	fffff097          	auipc	ra,0xfffff
     a26:	634080e7          	jalr	1588(ra) # 56 <panic>

0000000000000a2a <nulterminate>:

// NUL-terminate all the counted strings.
struct cmd*
nulterminate(struct cmd *cmd)
{
     a2a:	1101                	add	sp,sp,-32
     a2c:	e822                	sd	s0,16(sp)
     a2e:	e426                	sd	s1,8(sp)
     a30:	ec06                	sd	ra,24(sp)
     a32:	1000                	add	s0,sp,32
     a34:	84aa                	mv	s1,a0
  struct execcmd *ecmd;
  struct listcmd *lcmd;
  struct pipecmd *pcmd;
  struct redircmd *rcmd;

  if(cmd == 0)
     a36:	c915                	beqz	a0,a6a <nulterminate+0x40>
    return 0;

  switch(cmd->type){
     a38:	4118                	lw	a4,0(a0)
     a3a:	4795                	li	a5,5
     a3c:	02e7e763          	bltu	a5,a4,a6a <nulterminate+0x40>
     a40:	00056783          	lwu	a5,0(a0)
     a44:	00001717          	auipc	a4,0x1
     a48:	b8c70713          	add	a4,a4,-1140 # 15d0 <malloc+0x22c>
     a4c:	078a                	sll	a5,a5,0x2
     a4e:	97ba                	add	a5,a5,a4
     a50:	439c                	lw	a5,0(a5)
     a52:	97ba                	add	a5,a5,a4
     a54:	8782                	jr	a5
    nulterminate(pcmd->right);
    break;

  case LIST:
    lcmd = (struct listcmd*)cmd;
    nulterminate(lcmd->left);
     a56:	6508                	ld	a0,8(a0)
     a58:	00000097          	auipc	ra,0x0
     a5c:	fd2080e7          	jalr	-46(ra) # a2a <nulterminate>
    nulterminate(lcmd->right);
     a60:	6888                	ld	a0,16(s1)
     a62:	00000097          	auipc	ra,0x0
     a66:	fc8080e7          	jalr	-56(ra) # a2a <nulterminate>
    bcmd = (struct backcmd*)cmd;
    nulterminate(bcmd->cmd);
    break;
  }
  return cmd;
}
     a6a:	60e2                	ld	ra,24(sp)
     a6c:	6442                	ld	s0,16(sp)
     a6e:	8526                	mv	a0,s1
     a70:	64a2                	ld	s1,8(sp)
     a72:	6105                	add	sp,sp,32
     a74:	8082                	ret
    nulterminate(bcmd->cmd);
     a76:	6508                	ld	a0,8(a0)
     a78:	00000097          	auipc	ra,0x0
     a7c:	fb2080e7          	jalr	-78(ra) # a2a <nulterminate>
}
     a80:	60e2                	ld	ra,24(sp)
     a82:	6442                	ld	s0,16(sp)
     a84:	8526                	mv	a0,s1
     a86:	64a2                	ld	s1,8(sp)
     a88:	6105                	add	sp,sp,32
     a8a:	8082                	ret
    for(i=0; ecmd->argv[i]; i++)
     a8c:	651c                	ld	a5,8(a0)
     a8e:	dff1                	beqz	a5,a6a <nulterminate+0x40>
     a90:	01050793          	add	a5,a0,16
      *ecmd->eargv[i] = 0;
     a94:	67b8                	ld	a4,72(a5)
    for(i=0; ecmd->argv[i]; i++)
     a96:	07a1                	add	a5,a5,8
      *ecmd->eargv[i] = 0;
     a98:	00070023          	sb	zero,0(a4)
    for(i=0; ecmd->argv[i]; i++)
     a9c:	ff87b703          	ld	a4,-8(a5)
     aa0:	fb75                	bnez	a4,a94 <nulterminate+0x6a>
}
     aa2:	60e2                	ld	ra,24(sp)
     aa4:	6442                	ld	s0,16(sp)
     aa6:	8526                	mv	a0,s1
     aa8:	64a2                	ld	s1,8(sp)
     aaa:	6105                	add	sp,sp,32
     aac:	8082                	ret
    nulterminate(rcmd->cmd);
     aae:	6508                	ld	a0,8(a0)
     ab0:	00000097          	auipc	ra,0x0
     ab4:	f7a080e7          	jalr	-134(ra) # a2a <nulterminate>
    *rcmd->efile = 0;
     ab8:	6c9c                	ld	a5,24(s1)
}
     aba:	8526                	mv	a0,s1
    *rcmd->efile = 0;
     abc:	00078023          	sb	zero,0(a5)
}
     ac0:	60e2                	ld	ra,24(sp)
     ac2:	6442                	ld	s0,16(sp)
     ac4:	64a2                	ld	s1,8(sp)
     ac6:	6105                	add	sp,sp,32
     ac8:	8082                	ret

0000000000000aca <parsecmd>:
{
     aca:	7179                	add	sp,sp,-48
     acc:	f406                	sd	ra,40(sp)
     ace:	f022                	sd	s0,32(sp)
     ad0:	ec26                	sd	s1,24(sp)
     ad2:	1800                	add	s0,sp,48
     ad4:	e84a                	sd	s2,16(sp)
  es = s + strlen(s);
     ad6:	84aa                	mv	s1,a0
{
     ad8:	fca43c23          	sd	a0,-40(s0)
  es = s + strlen(s);
     adc:	00000097          	auipc	ra,0x0
     ae0:	224080e7          	jalr	548(ra) # d00 <strlen>
     ae4:	94aa                	add	s1,s1,a0
  cmd = parseline(&s, es);
     ae6:	85a6                	mv	a1,s1
     ae8:	fd840513          	add	a0,s0,-40
     aec:	00000097          	auipc	ra,0x0
     af0:	dbc080e7          	jalr	-580(ra) # 8a8 <parseline>
  peek(&s, es, "");
     af4:	00001617          	auipc	a2,0x1
     af8:	9b460613          	add	a2,a2,-1612 # 14a8 <malloc+0x104>
  cmd = parseline(&s, es);
     afc:	892a                	mv	s2,a0
  peek(&s, es, "");
     afe:	85a6                	mv	a1,s1
     b00:	fd840513          	add	a0,s0,-40
     b04:	00000097          	auipc	ra,0x0
     b08:	a00080e7          	jalr	-1536(ra) # 504 <peek>
  if(s != es){
     b0c:	fd843603          	ld	a2,-40(s0)
     b10:	00961e63          	bne	a2,s1,b2c <parsecmd+0x62>
  nulterminate(cmd);
     b14:	854a                	mv	a0,s2
     b16:	00000097          	auipc	ra,0x0
     b1a:	f14080e7          	jalr	-236(ra) # a2a <nulterminate>
}
     b1e:	70a2                	ld	ra,40(sp)
     b20:	7402                	ld	s0,32(sp)
     b22:	64e2                	ld	s1,24(sp)
     b24:	854a                	mv	a0,s2
     b26:	6942                	ld	s2,16(sp)
     b28:	6145                	add	sp,sp,48
     b2a:	8082                	ret
    fprintf(2, "leftovers: %s\n", s);
     b2c:	4509                	li	a0,2
     b2e:	00001597          	auipc	a1,0x1
     b32:	a5a58593          	add	a1,a1,-1446 # 1588 <malloc+0x1e4>
     b36:	00000097          	auipc	ra,0x0
     b3a:	770080e7          	jalr	1904(ra) # 12a6 <fprintf>
    panic("syntax");
     b3e:	00001517          	auipc	a0,0x1
     b42:	9e250513          	add	a0,a0,-1566 # 1520 <malloc+0x17c>
     b46:	fffff097          	auipc	ra,0xfffff
     b4a:	510080e7          	jalr	1296(ra) # 56 <panic>

0000000000000b4e <main>:
{
     b4e:	7139                	add	sp,sp,-64
     b50:	f822                	sd	s0,48(sp)
     b52:	f426                	sd	s1,40(sp)
     b54:	fc06                	sd	ra,56(sp)
     b56:	f04a                	sd	s2,32(sp)
     b58:	ec4e                	sd	s3,24(sp)
     b5a:	e852                	sd	s4,16(sp)
     b5c:	e456                	sd	s5,8(sp)
     b5e:	0080                	add	s0,sp,64
  while((fd = open("console", O_RDWR)) >= 0){
     b60:	00001497          	auipc	s1,0x1
     b64:	a3848493          	add	s1,s1,-1480 # 1598 <malloc+0x1f4>
     b68:	a021                	j	b70 <main+0x22>
    if(fd >= 3){
     b6a:	4709                	li	a4,2
     b6c:	0ef74363          	blt	a4,a5,c52 <main+0x104>
  while((fd = open("console", O_RDWR)) >= 0){
     b70:	4589                	li	a1,2
     b72:	8526                	mv	a0,s1
     b74:	00000097          	auipc	ra,0x0
     b78:	446080e7          	jalr	1094(ra) # fba <open>
     b7c:	87aa                	mv	a5,a0
     b7e:	fe0556e3          	bgez	a0,b6a <main+0x1c>
     b82:	00001497          	auipc	s1,0x1
     b86:	49e48493          	add	s1,s1,1182 # 2020 <buf.0>
  write(2, "$ ", 2);
     b8a:	00001917          	auipc	s2,0x1
     b8e:	91690913          	add	s2,s2,-1770 # 14a0 <malloc+0xfc>
    if(buf[0] == 'c' && buf[1] == 'd' && buf[2] == ' '){
     b92:	06300993          	li	s3,99
  if(pid == -1)
     b96:	5a7d                	li	s4,-1
    if(buf[0] == 'c' && buf[1] == 'd' && buf[2] == ' '){
     b98:	02000a93          	li	s5,32
     b9c:	a829                	j	bb6 <main+0x68>
  pid = fork();
     b9e:	00000097          	auipc	ra,0x0
     ba2:	3d4080e7          	jalr	980(ra) # f72 <fork>
  if(pid == -1)
     ba6:	0d450763          	beq	a0,s4,c74 <main+0x126>
    if(fork1() == 0)
     baa:	c94d                	beqz	a0,c5c <main+0x10e>
    wait(0);
     bac:	4501                	li	a0,0
     bae:	00000097          	auipc	ra,0x0
     bb2:	3d4080e7          	jalr	980(ra) # f82 <wait>
  write(2, "$ ", 2);
     bb6:	4609                	li	a2,2
     bb8:	85ca                	mv	a1,s2
     bba:	4509                	li	a0,2
     bbc:	00000097          	auipc	ra,0x0
     bc0:	3de080e7          	jalr	990(ra) # f9a <write>
  memset(buf, 0, nbuf);
     bc4:	06400613          	li	a2,100
     bc8:	4581                	li	a1,0
     bca:	8526                	mv	a0,s1
     bcc:	00000097          	auipc	ra,0x0
     bd0:	162080e7          	jalr	354(ra) # d2e <memset>
  gets(buf, nbuf);
     bd4:	06400593          	li	a1,100
     bd8:	8526                	mv	a0,s1
     bda:	00000097          	auipc	ra,0x0
     bde:	19a080e7          	jalr	410(ra) # d74 <gets>
  if(buf[0] == 0) // EOF
     be2:	0004c783          	lbu	a5,0(s1)
     be6:	c3ad                	beqz	a5,c48 <main+0xfa>
    if(buf[0] == 'c' && buf[1] == 'd' && buf[2] == ' '){
     be8:	fb379be3          	bne	a5,s3,b9e <main+0x50>
     bec:	0014c703          	lbu	a4,1(s1)
     bf0:	06400793          	li	a5,100
     bf4:	faf715e3          	bne	a4,a5,b9e <main+0x50>
     bf8:	0024c783          	lbu	a5,2(s1)
     bfc:	fb5791e3          	bne	a5,s5,b9e <main+0x50>
      buf[strlen(buf)-1] = 0;  // chop \n
     c00:	00001517          	auipc	a0,0x1
     c04:	42050513          	add	a0,a0,1056 # 2020 <buf.0>
     c08:	00000097          	auipc	ra,0x0
     c0c:	0f8080e7          	jalr	248(ra) # d00 <strlen>
     c10:	00a487b3          	add	a5,s1,a0
      if(chdir(buf+3) < 0)
     c14:	00001517          	auipc	a0,0x1
     c18:	40f50513          	add	a0,a0,1039 # 2023 <buf.0+0x3>
      buf[strlen(buf)-1] = 0;  // chop \n
     c1c:	fe078fa3          	sb	zero,-1(a5)
      if(chdir(buf+3) < 0)
     c20:	00000097          	auipc	ra,0x0
     c24:	3ca080e7          	jalr	970(ra) # fea <chdir>
     c28:	f80557e3          	bgez	a0,bb6 <main+0x68>
        fprintf(2, "cannot cd %s\n", buf+3);
     c2c:	00001617          	auipc	a2,0x1
     c30:	3f760613          	add	a2,a2,1015 # 2023 <buf.0+0x3>
     c34:	00001597          	auipc	a1,0x1
     c38:	96c58593          	add	a1,a1,-1684 # 15a0 <malloc+0x1fc>
     c3c:	4509                	li	a0,2
     c3e:	00000097          	auipc	ra,0x0
     c42:	668080e7          	jalr	1640(ra) # 12a6 <fprintf>
     c46:	bf85                	j	bb6 <main+0x68>
  exit(0);
     c48:	4501                	li	a0,0
     c4a:	00000097          	auipc	ra,0x0
     c4e:	330080e7          	jalr	816(ra) # f7a <exit>
      close(fd);
     c52:	00000097          	auipc	ra,0x0
     c56:	350080e7          	jalr	848(ra) # fa2 <close>
      break;
     c5a:	b725                	j	b82 <main+0x34>
      runcmd(parsecmd(buf));
     c5c:	00001517          	auipc	a0,0x1
     c60:	3c450513          	add	a0,a0,964 # 2020 <buf.0>
     c64:	00000097          	auipc	ra,0x0
     c68:	e66080e7          	jalr	-410(ra) # aca <parsecmd>
     c6c:	fffff097          	auipc	ra,0xfffff
     c70:	43e080e7          	jalr	1086(ra) # aa <runcmd>
    panic("fork");
     c74:	00001517          	auipc	a0,0x1
     c78:	84450513          	add	a0,a0,-1980 # 14b8 <malloc+0x114>
     c7c:	fffff097          	auipc	ra,0xfffff
     c80:	3da080e7          	jalr	986(ra) # 56 <panic>

0000000000000c84 <_main>:
//
// wrapper so that it's OK if main() does not call exit().
//
void
_main()
{
     c84:	1141                	add	sp,sp,-16
     c86:	e022                	sd	s0,0(sp)
     c88:	e406                	sd	ra,8(sp)
     c8a:	0800                	add	s0,sp,16
  extern int main();
  main();
     c8c:	00000097          	auipc	ra,0x0
     c90:	ec2080e7          	jalr	-318(ra) # b4e <main>
  exit(0);
     c94:	4501                	li	a0,0
     c96:	00000097          	auipc	ra,0x0
     c9a:	2e4080e7          	jalr	740(ra) # f7a <exit>

0000000000000c9e <strcpy>:
}

char*
strcpy(char *s, const char *t)
{
     c9e:	1141                	add	sp,sp,-16
     ca0:	e422                	sd	s0,8(sp)
     ca2:	0800                	add	s0,sp,16
  char *os;

  os = s;
  while((*s++ = *t++) != 0)
     ca4:	87aa                	mv	a5,a0
     ca6:	0005c703          	lbu	a4,0(a1)
     caa:	0785                	add	a5,a5,1
     cac:	0585                	add	a1,a1,1
     cae:	fee78fa3          	sb	a4,-1(a5)
     cb2:	fb75                	bnez	a4,ca6 <strcpy+0x8>
    ;
  return os;
}
     cb4:	6422                	ld	s0,8(sp)
     cb6:	0141                	add	sp,sp,16
     cb8:	8082                	ret

0000000000000cba <strcmp>:

int
strcmp(const char *p, const char *q)
{
     cba:	1141                	add	sp,sp,-16
     cbc:	e422                	sd	s0,8(sp)
     cbe:	0800                	add	s0,sp,16
  while(*p && *p == *q)
     cc0:	00054783          	lbu	a5,0(a0)
     cc4:	e791                	bnez	a5,cd0 <strcmp+0x16>
     cc6:	a80d                	j	cf8 <strcmp+0x3e>
     cc8:	00054783          	lbu	a5,0(a0)
     ccc:	cf99                	beqz	a5,cea <strcmp+0x30>
     cce:	85b6                	mv	a1,a3
     cd0:	0005c703          	lbu	a4,0(a1)
    p++, q++;
     cd4:	0505                	add	a0,a0,1
     cd6:	00158693          	add	a3,a1,1
  while(*p && *p == *q)
     cda:	fef707e3          	beq	a4,a5,cc8 <strcmp+0xe>
  return (uchar)*p - (uchar)*q;
     cde:	0007851b          	sext.w	a0,a5
}
     ce2:	6422                	ld	s0,8(sp)
     ce4:	9d19                	subw	a0,a0,a4
     ce6:	0141                	add	sp,sp,16
     ce8:	8082                	ret
  return (uchar)*p - (uchar)*q;
     cea:	0015c703          	lbu	a4,1(a1)
}
     cee:	6422                	ld	s0,8(sp)
  return (uchar)*p - (uchar)*q;
     cf0:	4501                	li	a0,0
}
     cf2:	9d19                	subw	a0,a0,a4
     cf4:	0141                	add	sp,sp,16
     cf6:	8082                	ret
  return (uchar)*p - (uchar)*q;
     cf8:	0005c703          	lbu	a4,0(a1)
     cfc:	4501                	li	a0,0
     cfe:	b7d5                	j	ce2 <strcmp+0x28>

0000000000000d00 <strlen>:

uint
strlen(const char *s)
{
     d00:	1141                	add	sp,sp,-16
     d02:	e422                	sd	s0,8(sp)
     d04:	0800                	add	s0,sp,16
  int n;

  for(n = 0; s[n]; n++)
     d06:	00054783          	lbu	a5,0(a0)
     d0a:	cf91                	beqz	a5,d26 <strlen+0x26>
     d0c:	0505                	add	a0,a0,1
     d0e:	87aa                	mv	a5,a0
     d10:	0007c703          	lbu	a4,0(a5)
     d14:	86be                	mv	a3,a5
     d16:	0785                	add	a5,a5,1
     d18:	ff65                	bnez	a4,d10 <strlen+0x10>
    ;
  return n;
}
     d1a:	6422                	ld	s0,8(sp)
     d1c:	40a6853b          	subw	a0,a3,a0
     d20:	2505                	addw	a0,a0,1
     d22:	0141                	add	sp,sp,16
     d24:	8082                	ret
     d26:	6422                	ld	s0,8(sp)
  for(n = 0; s[n]; n++)
     d28:	4501                	li	a0,0
}
     d2a:	0141                	add	sp,sp,16
     d2c:	8082                	ret

0000000000000d2e <memset>:

void*
memset(void *dst, int c, uint n)
{
     d2e:	1141                	add	sp,sp,-16
     d30:	e422                	sd	s0,8(sp)
     d32:	0800                	add	s0,sp,16
  char *cdst = (char *) dst;
  int i;
  for(i = 0; i < n; i++){
     d34:	ce09                	beqz	a2,d4e <memset+0x20>
     d36:	1602                	sll	a2,a2,0x20
     d38:	9201                	srl	a2,a2,0x20
    cdst[i] = c;
     d3a:	0ff5f593          	zext.b	a1,a1
     d3e:	87aa                	mv	a5,a0
     d40:	00a60733          	add	a4,a2,a0
     d44:	00b78023          	sb	a1,0(a5)
  for(i = 0; i < n; i++){
     d48:	0785                	add	a5,a5,1
     d4a:	fee79de3          	bne	a5,a4,d44 <memset+0x16>
  }
  return dst;
}
     d4e:	6422                	ld	s0,8(sp)
     d50:	0141                	add	sp,sp,16
     d52:	8082                	ret

0000000000000d54 <strchr>:

char*
strchr(const char *s, char c)
{
     d54:	1141                	add	sp,sp,-16
     d56:	e422                	sd	s0,8(sp)
     d58:	0800                	add	s0,sp,16
  for(; *s; s++)
     d5a:	00054783          	lbu	a5,0(a0)
     d5e:	c799                	beqz	a5,d6c <strchr+0x18>
    if(*s == c)
     d60:	00f58763          	beq	a1,a5,d6e <strchr+0x1a>
  for(; *s; s++)
     d64:	00154783          	lbu	a5,1(a0)
     d68:	0505                	add	a0,a0,1
     d6a:	fbfd                	bnez	a5,d60 <strchr+0xc>
      return (char*)s;
  return 0;
     d6c:	4501                	li	a0,0
}
     d6e:	6422                	ld	s0,8(sp)
     d70:	0141                	add	sp,sp,16
     d72:	8082                	ret

0000000000000d74 <gets>:

char*
gets(char *buf, int max)
{
     d74:	711d                	add	sp,sp,-96
     d76:	e8a2                	sd	s0,80(sp)
     d78:	e4a6                	sd	s1,72(sp)
     d7a:	e0ca                	sd	s2,64(sp)
     d7c:	fc4e                	sd	s3,56(sp)
     d7e:	f852                	sd	s4,48(sp)
     d80:	f05a                	sd	s6,32(sp)
     d82:	ec5e                	sd	s7,24(sp)
     d84:	ec86                	sd	ra,88(sp)
     d86:	f456                	sd	s5,40(sp)
     d88:	1080                	add	s0,sp,96
     d8a:	8baa                	mv	s7,a0
     d8c:	89ae                	mv	s3,a1
     d8e:	892a                	mv	s2,a0
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
     d90:	4481                	li	s1,0
    cc = read(0, &c, 1);
    if(cc < 1)
      break;
    buf[i++] = c;
    if(c == '\n' || c == '\r')
     d92:	4a29                	li	s4,10
     d94:	4b35                	li	s6,13
  for(i=0; i+1 < max; ){
     d96:	a005                	j	db6 <gets+0x42>
    cc = read(0, &c, 1);
     d98:	00000097          	auipc	ra,0x0
     d9c:	1fa080e7          	jalr	506(ra) # f92 <read>
    if(cc < 1)
     da0:	02a05363          	blez	a0,dc6 <gets+0x52>
    buf[i++] = c;
     da4:	faf44783          	lbu	a5,-81(s0)
    if(c == '\n' || c == '\r')
     da8:	0905                	add	s2,s2,1
    buf[i++] = c;
     daa:	fef90fa3          	sb	a5,-1(s2)
    if(c == '\n' || c == '\r')
     dae:	01478d63          	beq	a5,s4,dc8 <gets+0x54>
     db2:	01678b63          	beq	a5,s6,dc8 <gets+0x54>
  for(i=0; i+1 < max; ){
     db6:	8aa6                	mv	s5,s1
     db8:	2485                	addw	s1,s1,1
    cc = read(0, &c, 1);
     dba:	4605                	li	a2,1
     dbc:	faf40593          	add	a1,s0,-81
     dc0:	4501                	li	a0,0
  for(i=0; i+1 < max; ){
     dc2:	fd34cbe3          	blt	s1,s3,d98 <gets+0x24>
     dc6:	84d6                	mv	s1,s5
      break;
  }
  buf[i] = '\0';
     dc8:	94de                	add	s1,s1,s7
     dca:	00048023          	sb	zero,0(s1)
  return buf;
}
     dce:	60e6                	ld	ra,88(sp)
     dd0:	6446                	ld	s0,80(sp)
     dd2:	64a6                	ld	s1,72(sp)
     dd4:	6906                	ld	s2,64(sp)
     dd6:	79e2                	ld	s3,56(sp)
     dd8:	7a42                	ld	s4,48(sp)
     dda:	7aa2                	ld	s5,40(sp)
     ddc:	7b02                	ld	s6,32(sp)
     dde:	855e                	mv	a0,s7
     de0:	6be2                	ld	s7,24(sp)
     de2:	6125                	add	sp,sp,96
     de4:	8082                	ret

0000000000000de6 <stat>:

int
stat(const char *n, struct stat *st)
{
     de6:	1101                	add	sp,sp,-32
     de8:	e822                	sd	s0,16(sp)
     dea:	e04a                	sd	s2,0(sp)
     dec:	ec06                	sd	ra,24(sp)
     dee:	e426                	sd	s1,8(sp)
     df0:	1000                	add	s0,sp,32
     df2:	892e                	mv	s2,a1
  int fd;
  int r;

  fd = open(n, O_RDONLY);
     df4:	4581                	li	a1,0
     df6:	00000097          	auipc	ra,0x0
     dfa:	1c4080e7          	jalr	452(ra) # fba <open>
  if(fd < 0)
     dfe:	02054663          	bltz	a0,e2a <stat+0x44>
    return -1;
  r = fstat(fd, st);
     e02:	85ca                	mv	a1,s2
     e04:	84aa                	mv	s1,a0
     e06:	00000097          	auipc	ra,0x0
     e0a:	1cc080e7          	jalr	460(ra) # fd2 <fstat>
     e0e:	87aa                	mv	a5,a0
  close(fd);
     e10:	8526                	mv	a0,s1
  r = fstat(fd, st);
     e12:	84be                	mv	s1,a5
  close(fd);
     e14:	00000097          	auipc	ra,0x0
     e18:	18e080e7          	jalr	398(ra) # fa2 <close>
  return r;
}
     e1c:	60e2                	ld	ra,24(sp)
     e1e:	6442                	ld	s0,16(sp)
     e20:	6902                	ld	s2,0(sp)
     e22:	8526                	mv	a0,s1
     e24:	64a2                	ld	s1,8(sp)
     e26:	6105                	add	sp,sp,32
     e28:	8082                	ret
    return -1;
     e2a:	54fd                	li	s1,-1
     e2c:	bfc5                	j	e1c <stat+0x36>

0000000000000e2e <atoi>:

int
atoi(const char *s)
{
     e2e:	1141                	add	sp,sp,-16
     e30:	e422                	sd	s0,8(sp)
     e32:	0800                	add	s0,sp,16
  int n;

  n = 0;
  while('0' <= *s && *s <= '9')
     e34:	00054683          	lbu	a3,0(a0)
     e38:	4625                	li	a2,9
     e3a:	fd06879b          	addw	a5,a3,-48
     e3e:	0ff7f793          	zext.b	a5,a5
     e42:	02f66863          	bltu	a2,a5,e72 <atoi+0x44>
     e46:	872a                	mv	a4,a0
  n = 0;
     e48:	4501                	li	a0,0
    n = n*10 + *s++ - '0';
     e4a:	0025179b          	sllw	a5,a0,0x2
     e4e:	9fa9                	addw	a5,a5,a0
     e50:	0705                	add	a4,a4,1
     e52:	0017979b          	sllw	a5,a5,0x1
     e56:	9fb5                	addw	a5,a5,a3
  while('0' <= *s && *s <= '9')
     e58:	00074683          	lbu	a3,0(a4)
    n = n*10 + *s++ - '0';
     e5c:	fd07851b          	addw	a0,a5,-48
  while('0' <= *s && *s <= '9')
     e60:	fd06879b          	addw	a5,a3,-48
     e64:	0ff7f793          	zext.b	a5,a5
     e68:	fef671e3          	bgeu	a2,a5,e4a <atoi+0x1c>
  return n;
}
     e6c:	6422                	ld	s0,8(sp)
     e6e:	0141                	add	sp,sp,16
     e70:	8082                	ret
     e72:	6422                	ld	s0,8(sp)
  n = 0;
     e74:	4501                	li	a0,0
}
     e76:	0141                	add	sp,sp,16
     e78:	8082                	ret

0000000000000e7a <memmove>:

void*
memmove(void *vdst, const void *vsrc, int n)
{
     e7a:	1141                	add	sp,sp,-16
     e7c:	e422                	sd	s0,8(sp)
     e7e:	0800                	add	s0,sp,16
  char *dst;
  const char *src;

  dst = vdst;
  src = vsrc;
  if (src > dst) {
     e80:	02b57463          	bgeu	a0,a1,ea8 <memmove+0x2e>
    while(n-- > 0)
     e84:	00c05f63          	blez	a2,ea2 <memmove+0x28>
     e88:	1602                	sll	a2,a2,0x20
     e8a:	9201                	srl	a2,a2,0x20
     e8c:	00c507b3          	add	a5,a0,a2
  dst = vdst;
     e90:	872a                	mv	a4,a0
      *dst++ = *src++;
     e92:	0005c683          	lbu	a3,0(a1)
     e96:	0705                	add	a4,a4,1
     e98:	0585                	add	a1,a1,1
     e9a:	fed70fa3          	sb	a3,-1(a4)
    while(n-- > 0)
     e9e:	fef71ae3          	bne	a4,a5,e92 <memmove+0x18>
    src += n;
    while(n-- > 0)
      *--dst = *--src;
  }
  return vdst;
}
     ea2:	6422                	ld	s0,8(sp)
     ea4:	0141                	add	sp,sp,16
     ea6:	8082                	ret
    dst += n;
     ea8:	00c50733          	add	a4,a0,a2
    src += n;
     eac:	95b2                	add	a1,a1,a2
    while(n-- > 0)
     eae:	fec05ae3          	blez	a2,ea2 <memmove+0x28>
     eb2:	fff6079b          	addw	a5,a2,-1
     eb6:	1782                	sll	a5,a5,0x20
     eb8:	9381                	srl	a5,a5,0x20
     eba:	fff7c793          	not	a5,a5
     ebe:	97ae                	add	a5,a5,a1
      *--dst = *--src;
     ec0:	fff5c683          	lbu	a3,-1(a1)
     ec4:	15fd                	add	a1,a1,-1
     ec6:	177d                	add	a4,a4,-1
     ec8:	00d70023          	sb	a3,0(a4)
    while(n-- > 0)
     ecc:	feb79ae3          	bne	a5,a1,ec0 <memmove+0x46>
}
     ed0:	6422                	ld	s0,8(sp)
     ed2:	0141                	add	sp,sp,16
     ed4:	8082                	ret

0000000000000ed6 <memcmp>:

int
memcmp(const void *s1, const void *s2, uint n)
{
     ed6:	1141                	add	sp,sp,-16
     ed8:	e422                	sd	s0,8(sp)
     eda:	0800                	add	s0,sp,16
  const char *p1 = s1, *p2 = s2;
  while (n-- > 0) {
     edc:	c61d                	beqz	a2,f0a <memcmp+0x34>
     ede:	fff6069b          	addw	a3,a2,-1
     ee2:	1682                	sll	a3,a3,0x20
     ee4:	9281                	srl	a3,a3,0x20
     ee6:	0685                	add	a3,a3,1
     ee8:	96aa                	add	a3,a3,a0
     eea:	a019                	j	ef0 <memcmp+0x1a>
     eec:	00a68f63          	beq	a3,a0,f0a <memcmp+0x34>
    if (*p1 != *p2) {
     ef0:	00054783          	lbu	a5,0(a0)
     ef4:	0005c703          	lbu	a4,0(a1)
      return *p1 - *p2;
    }
    p1++;
     ef8:	0505                	add	a0,a0,1
    p2++;
     efa:	0585                	add	a1,a1,1
    if (*p1 != *p2) {
     efc:	fee788e3          	beq	a5,a4,eec <memcmp+0x16>
  }
  return 0;
}
     f00:	6422                	ld	s0,8(sp)
      return *p1 - *p2;
     f02:	40e7853b          	subw	a0,a5,a4
}
     f06:	0141                	add	sp,sp,16
     f08:	8082                	ret
     f0a:	6422                	ld	s0,8(sp)
  return 0;
     f0c:	4501                	li	a0,0
}
     f0e:	0141                	add	sp,sp,16
     f10:	8082                	ret

0000000000000f12 <memcpy>:

void *
memcpy(void *dst, const void *src, uint n)
{
     f12:	1141                	add	sp,sp,-16
     f14:	e422                	sd	s0,8(sp)
     f16:	0800                	add	s0,sp,16
  return memmove(dst, src, n);
     f18:	0006079b          	sext.w	a5,a2
  if (src > dst) {
     f1c:	02b57463          	bgeu	a0,a1,f44 <memcpy+0x32>
    while(n-- > 0)
     f20:	00f05f63          	blez	a5,f3e <memcpy+0x2c>
     f24:	1602                	sll	a2,a2,0x20
     f26:	9201                	srl	a2,a2,0x20
     f28:	00c587b3          	add	a5,a1,a2
  dst = vdst;
     f2c:	872a                	mv	a4,a0
      *dst++ = *src++;
     f2e:	0005c683          	lbu	a3,0(a1)
     f32:	0585                	add	a1,a1,1
     f34:	0705                	add	a4,a4,1
     f36:	fed70fa3          	sb	a3,-1(a4)
    while(n-- > 0)
     f3a:	fef59ae3          	bne	a1,a5,f2e <memcpy+0x1c>
}
     f3e:	6422                	ld	s0,8(sp)
     f40:	0141                	add	sp,sp,16
     f42:	8082                	ret
    dst += n;
     f44:	00f50733          	add	a4,a0,a5
    src += n;
     f48:	95be                	add	a1,a1,a5
    while(n-- > 0)
     f4a:	fef05ae3          	blez	a5,f3e <memcpy+0x2c>
     f4e:	fff6079b          	addw	a5,a2,-1
     f52:	1782                	sll	a5,a5,0x20
     f54:	9381                	srl	a5,a5,0x20
     f56:	fff7c793          	not	a5,a5
     f5a:	97ae                	add	a5,a5,a1
      *--dst = *--src;
     f5c:	fff5c683          	lbu	a3,-1(a1)
     f60:	15fd                	add	a1,a1,-1
     f62:	177d                	add	a4,a4,-1
     f64:	00d70023          	sb	a3,0(a4)
    while(n-- > 0)
     f68:	fef59ae3          	bne	a1,a5,f5c <memcpy+0x4a>
}
     f6c:	6422                	ld	s0,8(sp)
     f6e:	0141                	add	sp,sp,16
     f70:	8082                	ret

0000000000000f72 <fork>:
# generated by usys.pl - do not edit
#include "kern/syscall.h"
.global fork
fork:
 li a7, SYS_fork
     f72:	4885                	li	a7,1
 ecall
     f74:	00000073          	ecall
 ret
     f78:	8082                	ret

0000000000000f7a <exit>:
.global exit
exit:
 li a7, SYS_exit
     f7a:	4889                	li	a7,2
 ecall
     f7c:	00000073          	ecall
 ret
     f80:	8082                	ret

0000000000000f82 <wait>:
.global wait
wait:
 li a7, SYS_wait
     f82:	488d                	li	a7,3
 ecall
     f84:	00000073          	ecall
 ret
     f88:	8082                	ret

0000000000000f8a <pipe>:
.global pipe
pipe:
 li a7, SYS_pipe
     f8a:	4891                	li	a7,4
 ecall
     f8c:	00000073          	ecall
 ret
     f90:	8082                	ret

0000000000000f92 <read>:
.global read
read:
 li a7, SYS_read
     f92:	4895                	li	a7,5
 ecall
     f94:	00000073          	ecall
 ret
     f98:	8082                	ret

0000000000000f9a <write>:
.global write
write:
 li a7, SYS_write
     f9a:	48c1                	li	a7,16
 ecall
     f9c:	00000073          	ecall
 ret
     fa0:	8082                	ret

0000000000000fa2 <close>:
.global close
close:
 li a7, SYS_close
     fa2:	48d5                	li	a7,21
 ecall
     fa4:	00000073          	ecall
 ret
     fa8:	8082                	ret

0000000000000faa <kill>:
.global kill
kill:
 li a7, SYS_kill
     faa:	4899                	li	a7,6
 ecall
     fac:	00000073          	ecall
 ret
     fb0:	8082                	ret

0000000000000fb2 <exec>:
.global exec
exec:
 li a7, SYS_exec
     fb2:	489d                	li	a7,7
 ecall
     fb4:	00000073          	ecall
 ret
     fb8:	8082                	ret

0000000000000fba <open>:
.global open
open:
 li a7, SYS_open
     fba:	48bd                	li	a7,15
 ecall
     fbc:	00000073          	ecall
 ret
     fc0:	8082                	ret

0000000000000fc2 <mknod>:
.global mknod
mknod:
 li a7, SYS_mknod
     fc2:	48c5                	li	a7,17
 ecall
     fc4:	00000073          	ecall
 ret
     fc8:	8082                	ret

0000000000000fca <unlink>:
.global unlink
unlink:
 li a7, SYS_unlink
     fca:	48c9                	li	a7,18
 ecall
     fcc:	00000073          	ecall
 ret
     fd0:	8082                	ret

0000000000000fd2 <fstat>:
.global fstat
fstat:
 li a7, SYS_fstat
     fd2:	48a1                	li	a7,8
 ecall
     fd4:	00000073          	ecall
 ret
     fd8:	8082                	ret

0000000000000fda <link>:
.global link
link:
 li a7, SYS_link
     fda:	48cd                	li	a7,19
 ecall
     fdc:	00000073          	ecall
 ret
     fe0:	8082                	ret

0000000000000fe2 <mkdir>:
.global mkdir
mkdir:
 li a7, SYS_mkdir
     fe2:	48d1                	li	a7,20
 ecall
     fe4:	00000073          	ecall
 ret
     fe8:	8082                	ret

0000000000000fea <chdir>:
.global chdir
chdir:
 li a7, SYS_chdir
     fea:	48a5                	li	a7,9
 ecall
     fec:	00000073          	ecall
 ret
     ff0:	8082                	ret

0000000000000ff2 <dup>:
.global dup
dup:
 li a7, SYS_dup
     ff2:	48a9                	li	a7,10
 ecall
     ff4:	00000073          	ecall
 ret
     ff8:	8082                	ret

0000000000000ffa <getpid>:
.global getpid
getpid:
 li a7, SYS_getpid
     ffa:	48ad                	li	a7,11
 ecall
     ffc:	00000073          	ecall
 ret
    1000:	8082                	ret

0000000000001002 <sbrk>:
.global sbrk
sbrk:
 li a7, SYS_sbrk
    1002:	48b1                	li	a7,12
 ecall
    1004:	00000073          	ecall
 ret
    1008:	8082                	ret

000000000000100a <sleep>:
.global sleep
sleep:
 li a7, SYS_sleep
    100a:	48b5                	li	a7,13
 ecall
    100c:	00000073          	ecall
 ret
    1010:	8082                	ret

0000000000001012 <uptime>:
.global uptime
uptime:
 li a7, SYS_uptime
    1012:	48b9                	li	a7,14
 ecall
    1014:	00000073          	ecall
 ret
    1018:	8082                	ret

000000000000101a <poweroff>:
.global poweroff
poweroff:
 li a7, SYS_poweroff
    101a:	48d9                	li	a7,22
 ecall
    101c:	00000073          	ecall
 ret
    1020:	8082                	ret

0000000000001022 <printint>:
  write(fd, &c, 1);
}

static void
printint(int fd, int xx, int base, int sgn)
{
    1022:	715d                	add	sp,sp,-80
    1024:	e0a2                	sd	s0,64(sp)
    1026:	f84a                	sd	s2,48(sp)
    1028:	e486                	sd	ra,72(sp)
    102a:	fc26                	sd	s1,56(sp)
    102c:	f44e                	sd	s3,40(sp)
    102e:	0880                	add	s0,sp,80
    1030:	892a                	mv	s2,a0
  char buf[16];
  int i, neg;
  uint x;

  neg = 0;
  if(sgn && xx < 0){
    1032:	c299                	beqz	a3,1038 <printint+0x16>
    1034:	0805c263          	bltz	a1,10b8 <printint+0x96>
    neg = 1;
    x = -xx;
  } else {
    x = xx;
    1038:	2581                	sext.w	a1,a1
  neg = 0;
    103a:	4681                	li	a3,0
  }

  i = 0;
  do{
    buf[i++] = digits[x % base];
    103c:	2601                	sext.w	a2,a2
    103e:	fc040713          	add	a4,s0,-64
  i = 0;
    1042:	4501                	li	a0,0
    1044:	00000897          	auipc	a7,0x0
    1048:	5fc88893          	add	a7,a7,1532 # 1640 <digits>
    buf[i++] = digits[x % base];
    104c:	02c5f7bb          	remuw	a5,a1,a2
  }while((x /= base) != 0);
    1050:	0705                	add	a4,a4,1
    1052:	0005881b          	sext.w	a6,a1
    1056:	84aa                	mv	s1,a0
    buf[i++] = digits[x % base];
    1058:	2505                	addw	a0,a0,1
    105a:	1782                	sll	a5,a5,0x20
    105c:	9381                	srl	a5,a5,0x20
    105e:	97c6                	add	a5,a5,a7
    1060:	0007c783          	lbu	a5,0(a5)
  }while((x /= base) != 0);
    1064:	02c5d5bb          	divuw	a1,a1,a2
    buf[i++] = digits[x % base];
    1068:	fef70fa3          	sb	a5,-1(a4)
  }while((x /= base) != 0);
    106c:	fec870e3          	bgeu	a6,a2,104c <printint+0x2a>
  if(neg)
    1070:	ca89                	beqz	a3,1082 <printint+0x60>
    buf[i++] = '-';
    1072:	fd050793          	add	a5,a0,-48
    1076:	97a2                	add	a5,a5,s0
    1078:	02d00713          	li	a4,45
    107c:	fee78823          	sb	a4,-16(a5)

  while(--i >= 0)
    1080:	84aa                	mv	s1,a0
    1082:	fc040793          	add	a5,s0,-64
    1086:	94be                	add	s1,s1,a5
    1088:	fff78993          	add	s3,a5,-1
    putc(fd, buf[i]);
    108c:	0004c783          	lbu	a5,0(s1)
  write(fd, &c, 1);
    1090:	4605                	li	a2,1
    1092:	fbf40593          	add	a1,s0,-65
    1096:	854a                	mv	a0,s2
  while(--i >= 0)
    1098:	14fd                	add	s1,s1,-1
    109a:	faf40fa3          	sb	a5,-65(s0)
  write(fd, &c, 1);
    109e:	00000097          	auipc	ra,0x0
    10a2:	efc080e7          	jalr	-260(ra) # f9a <write>
  while(--i >= 0)
    10a6:	ff3493e3          	bne	s1,s3,108c <printint+0x6a>
}
    10aa:	60a6                	ld	ra,72(sp)
    10ac:	6406                	ld	s0,64(sp)
    10ae:	74e2                	ld	s1,56(sp)
    10b0:	7942                	ld	s2,48(sp)
    10b2:	79a2                	ld	s3,40(sp)
    10b4:	6161                	add	sp,sp,80
    10b6:	8082                	ret
    x = -xx;
    10b8:	40b005bb          	negw	a1,a1
    10bc:	b741                	j	103c <printint+0x1a>

00000000000010be <vprintf>:
}

// Print to the given fd. Only understands %d, %x, %p, %s.
void
vprintf(int fd, const char *fmt, va_list ap)
{
    10be:	7159                	add	sp,sp,-112
    10c0:	f0a2                	sd	s0,96(sp)
    10c2:	f486                	sd	ra,104(sp)
    10c4:	e8ca                	sd	s2,80(sp)
    10c6:	1880                	add	s0,sp,112
  char *s;
  int c, i, state;

  state = 0;
  for(i = 0; fmt[i]; i++){
    10c8:	0005c903          	lbu	s2,0(a1)
    10cc:	04090f63          	beqz	s2,112a <vprintf+0x6c>
    10d0:	eca6                	sd	s1,88(sp)
    10d2:	e4ce                	sd	s3,72(sp)
    10d4:	e0d2                	sd	s4,64(sp)
    10d6:	fc56                	sd	s5,56(sp)
    10d8:	f85a                	sd	s6,48(sp)
    10da:	f45e                	sd	s7,40(sp)
    10dc:	f062                	sd	s8,32(sp)
    10de:	8a2a                	mv	s4,a0
    10e0:	8c32                	mv	s8,a2
    10e2:	00158493          	add	s1,a1,1
    10e6:	4981                	li	s3,0
      if(c == '%'){
        state = '%';
      } else {
        putc(fd, c);
      }
    } else if(state == '%'){
    10e8:	02500a93          	li	s5,37
    10ec:	4bd5                	li	s7,21
    10ee:	00000b17          	auipc	s6,0x0
    10f2:	4fab0b13          	add	s6,s6,1274 # 15e8 <malloc+0x244>
    if(state == 0){
    10f6:	02099f63          	bnez	s3,1134 <vprintf+0x76>
      if(c == '%'){
    10fa:	05590c63          	beq	s2,s5,1152 <vprintf+0x94>
  write(fd, &c, 1);
    10fe:	4605                	li	a2,1
    1100:	f9f40593          	add	a1,s0,-97
    1104:	8552                	mv	a0,s4
    1106:	f9240fa3          	sb	s2,-97(s0)
    110a:	00000097          	auipc	ra,0x0
    110e:	e90080e7          	jalr	-368(ra) # f9a <write>
  for(i = 0; fmt[i]; i++){
    1112:	0004c903          	lbu	s2,0(s1)
    1116:	0485                	add	s1,s1,1
    1118:	fc091fe3          	bnez	s2,10f6 <vprintf+0x38>
    111c:	64e6                	ld	s1,88(sp)
    111e:	69a6                	ld	s3,72(sp)
    1120:	6a06                	ld	s4,64(sp)
    1122:	7ae2                	ld	s5,56(sp)
    1124:	7b42                	ld	s6,48(sp)
    1126:	7ba2                	ld	s7,40(sp)
    1128:	7c02                	ld	s8,32(sp)
        putc(fd, c);
      }
      state = 0;
    }
  }
}
    112a:	70a6                	ld	ra,104(sp)
    112c:	7406                	ld	s0,96(sp)
    112e:	6946                	ld	s2,80(sp)
    1130:	6165                	add	sp,sp,112
    1132:	8082                	ret
    } else if(state == '%'){
    1134:	fd599fe3          	bne	s3,s5,1112 <vprintf+0x54>
      if(c == 'd'){
    1138:	15590463          	beq	s2,s5,1280 <vprintf+0x1c2>
    113c:	f9d9079b          	addw	a5,s2,-99
    1140:	0ff7f793          	zext.b	a5,a5
    1144:	00fbea63          	bltu	s7,a5,1158 <vprintf+0x9a>
    1148:	078a                	sll	a5,a5,0x2
    114a:	97da                	add	a5,a5,s6
    114c:	439c                	lw	a5,0(a5)
    114e:	97da                	add	a5,a5,s6
    1150:	8782                	jr	a5
        state = '%';
    1152:	02500993          	li	s3,37
    1156:	bf75                	j	1112 <vprintf+0x54>
  write(fd, &c, 1);
    1158:	f9f40993          	add	s3,s0,-97
    115c:	4605                	li	a2,1
    115e:	85ce                	mv	a1,s3
    1160:	02500793          	li	a5,37
    1164:	8552                	mv	a0,s4
    1166:	f8f40fa3          	sb	a5,-97(s0)
    116a:	00000097          	auipc	ra,0x0
    116e:	e30080e7          	jalr	-464(ra) # f9a <write>
    1172:	4605                	li	a2,1
    1174:	85ce                	mv	a1,s3
    1176:	8552                	mv	a0,s4
    1178:	f9240fa3          	sb	s2,-97(s0)
    117c:	00000097          	auipc	ra,0x0
    1180:	e1e080e7          	jalr	-482(ra) # f9a <write>
        while(*s != 0){
    1184:	4981                	li	s3,0
    1186:	b771                	j	1112 <vprintf+0x54>
        putc(fd, va_arg(ap, uint));
    1188:	000c2783          	lw	a5,0(s8)
  write(fd, &c, 1);
    118c:	4605                	li	a2,1
    118e:	f9f40593          	add	a1,s0,-97
    1192:	8552                	mv	a0,s4
        putc(fd, va_arg(ap, uint));
    1194:	f8f40fa3          	sb	a5,-97(s0)
    1198:	0c21                	add	s8,s8,8
  write(fd, &c, 1);
    119a:	00000097          	auipc	ra,0x0
    119e:	e00080e7          	jalr	-512(ra) # f9a <write>
    11a2:	4981                	li	s3,0
    11a4:	b7bd                	j	1112 <vprintf+0x54>
        printint(fd, va_arg(ap, int), 10, 1);
    11a6:	000c2583          	lw	a1,0(s8)
    11aa:	4685                	li	a3,1
        printint(fd, va_arg(ap, uint64), 10, 0);
    11ac:	4629                	li	a2,10
    11ae:	8552                	mv	a0,s4
    11b0:	0c21                	add	s8,s8,8
    11b2:	00000097          	auipc	ra,0x0
    11b6:	e70080e7          	jalr	-400(ra) # 1022 <printint>
    11ba:	4981                	li	s3,0
    11bc:	bf99                	j	1112 <vprintf+0x54>
    11be:	000c2583          	lw	a1,0(s8)
    11c2:	4681                	li	a3,0
    11c4:	b7e5                	j	11ac <vprintf+0xee>
  write(fd, &c, 1);
    11c6:	f9f40993          	add	s3,s0,-97
    11ca:	03000793          	li	a5,48
    11ce:	4605                	li	a2,1
    11d0:	85ce                	mv	a1,s3
    11d2:	8552                	mv	a0,s4
    11d4:	ec66                	sd	s9,24(sp)
    11d6:	e86a                	sd	s10,16(sp)
        printptr(fd, va_arg(ap, uint64));
    11d8:	f8f40fa3          	sb	a5,-97(s0)
    11dc:	000c3d03          	ld	s10,0(s8)
  write(fd, &c, 1);
    11e0:	00000097          	auipc	ra,0x0
    11e4:	dba080e7          	jalr	-582(ra) # f9a <write>
    11e8:	07800793          	li	a5,120
    11ec:	4605                	li	a2,1
    11ee:	85ce                	mv	a1,s3
    11f0:	8552                	mv	a0,s4
    11f2:	f8f40fa3          	sb	a5,-97(s0)
        printptr(fd, va_arg(ap, uint64));
    11f6:	0c21                	add	s8,s8,8
  write(fd, &c, 1);
    11f8:	00000097          	auipc	ra,0x0
    11fc:	da2080e7          	jalr	-606(ra) # f9a <write>
  putc(fd, 'x');
    1200:	4941                	li	s2,16
    1202:	00000c97          	auipc	s9,0x0
    1206:	43ec8c93          	add	s9,s9,1086 # 1640 <digits>
    putc(fd, digits[x >> (sizeof(uint64) * 8 - 4)]);
    120a:	03cd5793          	srl	a5,s10,0x3c
    120e:	97e6                	add	a5,a5,s9
    1210:	0007c783          	lbu	a5,0(a5)
  write(fd, &c, 1);
    1214:	4605                	li	a2,1
    1216:	85ce                	mv	a1,s3
    1218:	8552                	mv	a0,s4
  for (i = 0; i < (sizeof(uint64) * 2); i++, x <<= 4)
    121a:	397d                	addw	s2,s2,-1
    121c:	f8f40fa3          	sb	a5,-97(s0)
    1220:	0d12                	sll	s10,s10,0x4
  write(fd, &c, 1);
    1222:	00000097          	auipc	ra,0x0
    1226:	d78080e7          	jalr	-648(ra) # f9a <write>
  for (i = 0; i < (sizeof(uint64) * 2); i++, x <<= 4)
    122a:	fe0910e3          	bnez	s2,120a <vprintf+0x14c>
    122e:	6ce2                	ld	s9,24(sp)
    1230:	6d42                	ld	s10,16(sp)
    1232:	4981                	li	s3,0
    1234:	bdf9                	j	1112 <vprintf+0x54>
        s = va_arg(ap, char*);
    1236:	000c3903          	ld	s2,0(s8)
    123a:	0c21                	add	s8,s8,8
        if(s == 0)
    123c:	04090e63          	beqz	s2,1298 <vprintf+0x1da>
        while(*s != 0){
    1240:	00094783          	lbu	a5,0(s2)
    1244:	d3a1                	beqz	a5,1184 <vprintf+0xc6>
    1246:	f9f40993          	add	s3,s0,-97
  write(fd, &c, 1);
    124a:	4605                	li	a2,1
    124c:	85ce                	mv	a1,s3
    124e:	8552                	mv	a0,s4
    1250:	f8f40fa3          	sb	a5,-97(s0)
    1254:	00000097          	auipc	ra,0x0
    1258:	d46080e7          	jalr	-698(ra) # f9a <write>
        while(*s != 0){
    125c:	00194783          	lbu	a5,1(s2)
          s++;
    1260:	0905                	add	s2,s2,1
        while(*s != 0){
    1262:	f7e5                	bnez	a5,124a <vprintf+0x18c>
    1264:	4981                	li	s3,0
    1266:	b575                	j	1112 <vprintf+0x54>
        printint(fd, va_arg(ap, int), 16, 0);
    1268:	000c2583          	lw	a1,0(s8)
    126c:	4681                	li	a3,0
    126e:	4641                	li	a2,16
    1270:	8552                	mv	a0,s4
    1272:	0c21                	add	s8,s8,8
    1274:	00000097          	auipc	ra,0x0
    1278:	dae080e7          	jalr	-594(ra) # 1022 <printint>
    127c:	4981                	li	s3,0
    127e:	bd51                	j	1112 <vprintf+0x54>
  write(fd, &c, 1);
    1280:	4605                	li	a2,1
    1282:	f9f40593          	add	a1,s0,-97
    1286:	8552                	mv	a0,s4
    1288:	f9540fa3          	sb	s5,-97(s0)
        while(*s != 0){
    128c:	4981                	li	s3,0
  write(fd, &c, 1);
    128e:	00000097          	auipc	ra,0x0
    1292:	d0c080e7          	jalr	-756(ra) # f9a <write>
    1296:	bdb5                	j	1112 <vprintf+0x54>
          s = "(null)";
    1298:	00000917          	auipc	s2,0x0
    129c:	31890913          	add	s2,s2,792 # 15b0 <malloc+0x20c>
    12a0:	02800793          	li	a5,40
    12a4:	b74d                	j	1246 <vprintf+0x188>

00000000000012a6 <fprintf>:

void
fprintf(int fd, const char *fmt, ...)
{
    12a6:	715d                	add	sp,sp,-80
    12a8:	e822                	sd	s0,16(sp)
    12aa:	ec06                	sd	ra,24(sp)
    12ac:	1000                	add	s0,sp,32
    12ae:	e010                	sd	a2,0(s0)
  va_list ap;

  va_start(ap, fmt);
  vprintf(fd, fmt, ap);
    12b0:	8622                	mv	a2,s0
{
    12b2:	e414                	sd	a3,8(s0)
    12b4:	e818                	sd	a4,16(s0)
    12b6:	ec1c                	sd	a5,24(s0)
    12b8:	03043023          	sd	a6,32(s0)
    12bc:	03143423          	sd	a7,40(s0)
  va_start(ap, fmt);
    12c0:	fe843423          	sd	s0,-24(s0)
  vprintf(fd, fmt, ap);
    12c4:	00000097          	auipc	ra,0x0
    12c8:	dfa080e7          	jalr	-518(ra) # 10be <vprintf>
}
    12cc:	60e2                	ld	ra,24(sp)
    12ce:	6442                	ld	s0,16(sp)
    12d0:	6161                	add	sp,sp,80
    12d2:	8082                	ret

00000000000012d4 <printf>:

void
printf(const char *fmt, ...)
{
    12d4:	711d                	add	sp,sp,-96
    12d6:	e822                	sd	s0,16(sp)
    12d8:	ec06                	sd	ra,24(sp)
    12da:	1000                	add	s0,sp,32
  va_list ap;

  va_start(ap, fmt);
    12dc:	00840313          	add	t1,s0,8
{
    12e0:	e40c                	sd	a1,8(s0)
    12e2:	e810                	sd	a2,16(s0)
  vprintf(1, fmt, ap);
    12e4:	85aa                	mv	a1,a0
    12e6:	861a                	mv	a2,t1
    12e8:	4505                	li	a0,1
{
    12ea:	ec14                	sd	a3,24(s0)
    12ec:	f018                	sd	a4,32(s0)
    12ee:	f41c                	sd	a5,40(s0)
    12f0:	03043823          	sd	a6,48(s0)
    12f4:	03143c23          	sd	a7,56(s0)
  va_start(ap, fmt);
    12f8:	fe643423          	sd	t1,-24(s0)
  vprintf(1, fmt, ap);
    12fc:	00000097          	auipc	ra,0x0
    1300:	dc2080e7          	jalr	-574(ra) # 10be <vprintf>
}
    1304:	60e2                	ld	ra,24(sp)
    1306:	6442                	ld	s0,16(sp)
    1308:	6125                	add	sp,sp,96
    130a:	8082                	ret

000000000000130c <free>:
static Header base;
static Header *freep;

void
free(void *ap)
{
    130c:	1141                	add	sp,sp,-16
    130e:	e422                	sd	s0,8(sp)
    1310:	0800                	add	s0,sp,16
  Header *bp, *p;

  bp = (Header*)ap - 1;
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
    1312:	00001597          	auipc	a1,0x1
    1316:	cfe58593          	add	a1,a1,-770 # 2010 <freep>
    131a:	619c                	ld	a5,0(a1)
  bp = (Header*)ap - 1;
    131c:	ff050693          	add	a3,a0,-16
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
    1320:	6398                	ld	a4,0(a5)
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
    1322:	02d7ff63          	bgeu	a5,a3,1360 <free+0x54>
    1326:	00e6e463          	bltu	a3,a4,132e <free+0x22>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
    132a:	02e7ef63          	bltu	a5,a4,1368 <free+0x5c>
      break;
  if(bp + bp->s.size == p->s.ptr){
    132e:	ff852803          	lw	a6,-8(a0)
    1332:	02081893          	sll	a7,a6,0x20
    1336:	01c8d613          	srl	a2,a7,0x1c
    133a:	9636                	add	a2,a2,a3
    133c:	02c70863          	beq	a4,a2,136c <free+0x60>
    bp->s.size += p->s.ptr->s.size;
    bp->s.ptr = p->s.ptr->s.ptr;
  } else
    bp->s.ptr = p->s.ptr;
  if(p + p->s.size == bp){
    1340:	0087a803          	lw	a6,8(a5)
    1344:	fee53823          	sd	a4,-16(a0)
    1348:	02081893          	sll	a7,a6,0x20
    134c:	01c8d613          	srl	a2,a7,0x1c
    1350:	963e                	add	a2,a2,a5
    1352:	02c68e63          	beq	a3,a2,138e <free+0x82>
    p->s.size += bp->s.size;
    p->s.ptr = bp->s.ptr;
  } else
    p->s.ptr = bp;
  freep = p;
}
    1356:	6422                	ld	s0,8(sp)
    1358:	e394                	sd	a3,0(a5)
  freep = p;
    135a:	e19c                	sd	a5,0(a1)
}
    135c:	0141                	add	sp,sp,16
    135e:	8082                	ret
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
    1360:	00e7e463          	bltu	a5,a4,1368 <free+0x5c>
    1364:	fce6e5e3          	bltu	a3,a4,132e <free+0x22>
{
    1368:	87ba                	mv	a5,a4
    136a:	bf5d                	j	1320 <free+0x14>
    bp->s.size += p->s.ptr->s.size;
    136c:	4710                	lw	a2,8(a4)
    bp->s.ptr = p->s.ptr->s.ptr;
    136e:	6318                	ld	a4,0(a4)
    bp->s.size += p->s.ptr->s.size;
    1370:	0106063b          	addw	a2,a2,a6
    1374:	fec52c23          	sw	a2,-8(a0)
  if(p + p->s.size == bp){
    1378:	0087a803          	lw	a6,8(a5)
    137c:	fee53823          	sd	a4,-16(a0)
    1380:	02081893          	sll	a7,a6,0x20
    1384:	01c8d613          	srl	a2,a7,0x1c
    1388:	963e                	add	a2,a2,a5
    138a:	fcc696e3          	bne	a3,a2,1356 <free+0x4a>
    p->s.size += bp->s.size;
    138e:	ff852603          	lw	a2,-8(a0)
}
    1392:	6422                	ld	s0,8(sp)
    p->s.ptr = bp->s.ptr;
    1394:	86ba                	mv	a3,a4
    p->s.size += bp->s.size;
    1396:	0106073b          	addw	a4,a2,a6
    139a:	c798                	sw	a4,8(a5)
    p->s.ptr = bp->s.ptr;
    139c:	e394                	sd	a3,0(a5)
  freep = p;
    139e:	e19c                	sd	a5,0(a1)
}
    13a0:	0141                	add	sp,sp,16
    13a2:	8082                	ret

00000000000013a4 <malloc>:
  return freep;
}

void*
malloc(uint nbytes)
{
    13a4:	7139                	add	sp,sp,-64
    13a6:	f822                	sd	s0,48(sp)
    13a8:	f426                	sd	s1,40(sp)
    13aa:	f04a                	sd	s2,32(sp)
    13ac:	ec4e                	sd	s3,24(sp)
    13ae:	fc06                	sd	ra,56(sp)
    13b0:	0080                	add	s0,sp,64
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
  if((prevp = freep) == 0){
    13b2:	00001917          	auipc	s2,0x1
    13b6:	c5e90913          	add	s2,s2,-930 # 2010 <freep>
  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
    13ba:	02051493          	sll	s1,a0,0x20
    13be:	9081                	srl	s1,s1,0x20
  if((prevp = freep) == 0){
    13c0:	00093783          	ld	a5,0(s2)
  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
    13c4:	04bd                	add	s1,s1,15
    13c6:	8091                	srl	s1,s1,0x4
    13c8:	0014899b          	addw	s3,s1,1
    13cc:	0485                	add	s1,s1,1
  if((prevp = freep) == 0){
    13ce:	c3dd                	beqz	a5,1474 <malloc+0xd0>
    base.s.ptr = freep = prevp = &base;
    base.s.size = 0;
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
    13d0:	6388                	ld	a0,0(a5)
    if(p->s.size >= nunits){
    13d2:	4518                	lw	a4,8(a0)
    13d4:	06977863          	bgeu	a4,s1,1444 <malloc+0xa0>
    13d8:	e852                	sd	s4,16(sp)
    13da:	e456                	sd	s5,8(sp)
    13dc:	e05a                	sd	s6,0(sp)
  if(nu < 4096)
    13de:	6785                	lui	a5,0x1
    13e0:	8a4e                	mv	s4,s3
    13e2:	08f4e763          	bltu	s1,a5,1470 <malloc+0xcc>
    13e6:	000a0b1b          	sext.w	s6,s4
  if(p == (char*)-1)
    13ea:	5afd                	li	s5,-1
  p = sbrk(nu * sizeof(Header));
    13ec:	004a1a1b          	sllw	s4,s4,0x4
    13f0:	a029                	j	13fa <malloc+0x56>
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
    13f2:	6388                	ld	a0,0(a5)
    if(p->s.size >= nunits){
    13f4:	4518                	lw	a4,8(a0)
    13f6:	04977463          	bgeu	a4,s1,143e <malloc+0x9a>
        p->s.size = nunits;
      }
      freep = prevp;
      return (void*)(p + 1);
    }
    if(p == freep)
    13fa:	00093703          	ld	a4,0(s2)
    13fe:	87aa                	mv	a5,a0
    1400:	fee519e3          	bne	a0,a4,13f2 <malloc+0x4e>
  p = sbrk(nu * sizeof(Header));
    1404:	8552                	mv	a0,s4
    1406:	00000097          	auipc	ra,0x0
    140a:	bfc080e7          	jalr	-1028(ra) # 1002 <sbrk>
    140e:	87aa                	mv	a5,a0
  free((void*)(hp + 1));
    1410:	0541                	add	a0,a0,16
  if(p == (char*)-1)
    1412:	01578b63          	beq	a5,s5,1428 <malloc+0x84>
  hp->s.size = nu;
    1416:	0167a423          	sw	s6,8(a5) # 1008 <sbrk+0x6>
  free((void*)(hp + 1));
    141a:	00000097          	auipc	ra,0x0
    141e:	ef2080e7          	jalr	-270(ra) # 130c <free>
  return freep;
    1422:	00093783          	ld	a5,0(s2)
      if((p = morecore(nunits)) == 0)
    1426:	f7f1                	bnez	a5,13f2 <malloc+0x4e>
        return 0;
  }
}
    1428:	70e2                	ld	ra,56(sp)
    142a:	7442                	ld	s0,48(sp)
        return 0;
    142c:	6a42                	ld	s4,16(sp)
    142e:	6aa2                	ld	s5,8(sp)
    1430:	6b02                	ld	s6,0(sp)
}
    1432:	74a2                	ld	s1,40(sp)
    1434:	7902                	ld	s2,32(sp)
    1436:	69e2                	ld	s3,24(sp)
        return 0;
    1438:	4501                	li	a0,0
}
    143a:	6121                	add	sp,sp,64
    143c:	8082                	ret
    143e:	6a42                	ld	s4,16(sp)
    1440:	6aa2                	ld	s5,8(sp)
    1442:	6b02                	ld	s6,0(sp)
      if(p->s.size == nunits)
    1444:	04e48763          	beq	s1,a4,1492 <malloc+0xee>
        p->s.size -= nunits;
    1448:	4137073b          	subw	a4,a4,s3
        p += p->s.size;
    144c:	02071613          	sll	a2,a4,0x20
    1450:	01c65693          	srl	a3,a2,0x1c
        p->s.size -= nunits;
    1454:	c518                	sw	a4,8(a0)
        p += p->s.size;
    1456:	9536                	add	a0,a0,a3
        p->s.size = nunits;
    1458:	01352423          	sw	s3,8(a0)
}
    145c:	70e2                	ld	ra,56(sp)
    145e:	7442                	ld	s0,48(sp)
      freep = prevp;
    1460:	00f93023          	sd	a5,0(s2)
}
    1464:	74a2                	ld	s1,40(sp)
    1466:	7902                	ld	s2,32(sp)
    1468:	69e2                	ld	s3,24(sp)
      return (void*)(p + 1);
    146a:	0541                	add	a0,a0,16
}
    146c:	6121                	add	sp,sp,64
    146e:	8082                	ret
  if(nu < 4096)
    1470:	6a05                	lui	s4,0x1
    1472:	bf95                	j	13e6 <malloc+0x42>
    1474:	e852                	sd	s4,16(sp)
    1476:	e456                	sd	s5,8(sp)
    1478:	e05a                	sd	s6,0(sp)
    base.s.ptr = freep = prevp = &base;
    147a:	00001517          	auipc	a0,0x1
    147e:	c0e50513          	add	a0,a0,-1010 # 2088 <base>
    1482:	00a93023          	sd	a0,0(s2)
    1486:	e108                	sd	a0,0(a0)
    base.s.size = 0;
    1488:	00001797          	auipc	a5,0x1
    148c:	c007a423          	sw	zero,-1016(a5) # 2090 <base+0x8>
    if(p->s.size >= nunits){
    1490:	b7b9                	j	13de <malloc+0x3a>
        prevp->s.ptr = p->s.ptr;
    1492:	6118                	ld	a4,0(a0)
    1494:	e398                	sd	a4,0(a5)
    1496:	b7d9                	j	145c <malloc+0xb8>
