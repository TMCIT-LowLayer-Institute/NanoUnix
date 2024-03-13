
sys/kern/kernel:     file format elf64-littleriscv


Disassembly of section .text:

0000000080000000 <_entry>:
    80000000:	00009117          	auipc	sp,0x9
    80000004:	e9010113          	add	sp,sp,-368 # 80008e90 <stack0>
    80000008:	6505                	lui	a0,0x1
    8000000a:	f14025f3          	csrr	a1,mhartid
    8000000e:	0585                	add	a1,a1,1
    80000010:	02b50533          	mul	a0,a0,a1
    80000014:	912a                	add	sp,sp,a0
    80000016:	076000ef          	jal	8000008c <start>

000000008000001a <spin>:
    8000001a:	a001                	j	8000001a <spin>

000000008000001c <timerinit>:
 * which turns them into software interrupts for
 * devintr() in trap.c.
 */
void
timerinit()
{
    8000001c:	1141                	add	sp,sp,-16
    8000001e:	e422                	sd	s0,8(sp)
    80000020:	0800                	add	s0,sp,16
 */
static inline uint64
r_mhartid()
{
  uint64 x;
  __asm__ volatile("csrr %0, mhartid" : "=r" (x) );
    80000022:	f14027f3          	csrr	a5,mhartid
        /* each CPU has a separate source of timer interrupts. */
        int id = r_mhartid();

        /* ask the CLINT for a timer interrupt. */
        int interval = 1000000; // cycles; about 1/10th second in qemu.
        *(uint64*)CLINT_MTIMECMP(id) = *(uint64*)CLINT_MTIME + interval;
    80000026:	0200c5b7          	lui	a1,0x200c
    8000002a:	ff85b703          	ld	a4,-8(a1) # 200bff8 <_entry-0x7dff4008>
        int id = r_mhartid();
    8000002e:	0007851b          	sext.w	a0,a5
         * prepare information in scratch[] for timervec.
         * scratch[0..2] : space for timervec to save registers.
         * scratch[3] : address of CLINT MTIMECMP register.
         * scratch[4] : desired interval (in cycles) between timer interrupts.
         */
        uint64 *scratch = &timer_scratch[id][0];
    80000032:	00251693          	sll	a3,a0,0x2
        *(uint64*)CLINT_MTIMECMP(id) = *(uint64*)CLINT_MTIME + interval;
    80000036:	000f4637          	lui	a2,0xf4
    8000003a:	24060613          	add	a2,a2,576 # f4240 <_entry-0x7ff0bdc0>
        uint64 *scratch = &timer_scratch[id][0];
    8000003e:	96aa                	add	a3,a3,a0
        *(uint64*)CLINT_MTIMECMP(id) = *(uint64*)CLINT_MTIME + interval;
    80000040:	0037979b          	sllw	a5,a5,0x3
    80000044:	02004537          	lui	a0,0x2004
    80000048:	97aa                	add	a5,a5,a0
    8000004a:	9732                	add	a4,a4,a2
    8000004c:	e398                	sd	a4,0(a5)
        uint64 *scratch = &timer_scratch[id][0];
    8000004e:	068e                	sll	a3,a3,0x3
    80000050:	00009717          	auipc	a4,0x9
    80000054:	d0070713          	add	a4,a4,-768 # 80008d50 <timer_scratch>
    80000058:	9736                	add	a4,a4,a3
        scratch[3] = CLINT_MTIMECMP(id);
    8000005a:	ef1c                	sd	a5,24(a4)
        scratch[4] = interval;
    8000005c:	f310                	sd	a2,32(a4)
}

static inline void 
w_mscratch(uint64 x)
{
  __asm__ volatile("csrw mscratch, %0" : : "r" (x));
    8000005e:	34071073          	csrw	mscratch,a4
  __asm__ volatile("csrw mtvec, %0" : : "r" (x));
    80000062:	00006797          	auipc	a5,0x6
    80000066:	4fe78793          	add	a5,a5,1278 # 80006560 <timervec>
    8000006a:	30579073          	csrw	mtvec,a5
  __asm__ volatile("csrr %0, mstatus" : "=r" (x) );
    8000006e:	300027f3          	csrr	a5,mstatus

        /* set the machine-mode trap handler. */
        w_mtvec((uint64)timervec);

        /* enable machine-mode interrupts. */
        w_mstatus(r_mstatus() | MSTATUS_MIE);
    80000072:	0087e793          	or	a5,a5,8
  __asm__ volatile("csrw mstatus, %0" : : "r" (x));
    80000076:	30079073          	csrw	mstatus,a5
  __asm__ volatile("csrr %0, mie" : "=r" (x) );
    8000007a:	304027f3          	csrr	a5,mie

        /* enable machine-mode timer interrupts. */
        w_mie(r_mie() | MIE_MTIE);
    8000007e:	0807e793          	or	a5,a5,128
  __asm__ volatile("csrw mie, %0" : : "r" (x));
    80000082:	30479073          	csrw	mie,a5
}
    80000086:	6422                	ld	s0,8(sp)
    80000088:	0141                	add	sp,sp,16
    8000008a:	8082                	ret

000000008000008c <start>:
{
    8000008c:	1141                	add	sp,sp,-16
    8000008e:	e022                	sd	s0,0(sp)
    80000090:	e406                	sd	ra,8(sp)
    80000092:	0800                	add	s0,sp,16
  __asm__ volatile("csrr %0, mstatus" : "=r" (x) );
    80000094:	300027f3          	csrr	a5,mstatus
        x &= ~MSTATUS_MPP_MASK;
    80000098:	76f9                	lui	a3,0xffffe
    8000009a:	7ff68693          	add	a3,a3,2047 # ffffffffffffe7ff <end+0xffffffff7ffdc63f>
        x |= MSTATUS_MPP_S;
    8000009e:	6705                	lui	a4,0x1
        x &= ~MSTATUS_MPP_MASK;
    800000a0:	8ff5                	and	a5,a5,a3
        x |= MSTATUS_MPP_S;
    800000a2:	80070713          	add	a4,a4,-2048 # 800 <_entry-0x7ffff800>
    800000a6:	8fd9                	or	a5,a5,a4
  __asm__ volatile("csrw mstatus, %0" : : "r" (x));
    800000a8:	30079073          	csrw	mstatus,a5
  __asm__ volatile("csrw mepc, %0" : : "r" (x));
    800000ac:	00001797          	auipc	a5,0x1
    800000b0:	ed878793          	add	a5,a5,-296 # 80000f84 <main>
    800000b4:	34179073          	csrw	mepc,a5
  __asm__ volatile("csrw satp, %0" : : "r" (x));
    800000b8:	4781                	li	a5,0
    800000ba:	18079073          	csrw	satp,a5
  __asm__ volatile("csrw medeleg, %0" : : "r" (x));
    800000be:	67c1                	lui	a5,0x10
    800000c0:	17fd                	add	a5,a5,-1 # ffff <_entry-0x7fff0001>
    800000c2:	30279073          	csrw	medeleg,a5
  __asm__ volatile("csrw mideleg, %0" : : "r" (x));
    800000c6:	30379073          	csrw	mideleg,a5
  __asm__ volatile("csrr %0, sie" : "=r" (x) );
    800000ca:	104027f3          	csrr	a5,sie
        w_sie(r_sie() | SIE_SEIE | SIE_STIE | SIE_SSIE);
    800000ce:	2227e793          	or	a5,a5,546
  __asm__ volatile("csrw sie, %0" : : "r" (x));
    800000d2:	10479073          	csrw	sie,a5
  __asm__ volatile("csrw pmpaddr0, %0" : : "r" (x));
    800000d6:	57fd                	li	a5,-1
    800000d8:	83a9                	srl	a5,a5,0xa
    800000da:	3b079073          	csrw	pmpaddr0,a5
  __asm__ volatile("csrw pmpcfg0, %0" : : "r" (x));
    800000de:	47bd                	li	a5,15
    800000e0:	3a079073          	csrw	pmpcfg0,a5
        timerinit();
    800000e4:	00000097          	auipc	ra,0x0
    800000e8:	f38080e7          	jalr	-200(ra) # 8000001c <timerinit>
  __asm__ volatile("csrr %0, mhartid" : "=r" (x) );
    800000ec:	f14027f3          	csrr	a5,mhartid
        w_tp(id);
    800000f0:	2781                	sext.w	a5,a5
}

static inline void 
w_tp(uint64 x)
{
  __asm__ volatile("mv tp, %0" : : "r" (x));
    800000f2:	823e                	mv	tp,a5
        __asm__ __volatile__("mret");
    800000f4:	30200073          	mret
}
    800000f8:	60a2                	ld	ra,8(sp)
    800000fa:	6402                	ld	s0,0(sp)
    800000fc:	0141                	add	sp,sp,16
    800000fe:	8082                	ret

0000000080000100 <consolewrite>:
/*
 * user write()s to the console go here.
 */
int
consolewrite(int const user_src, uint64 const src, int const n)
{
    80000100:	715d                	add	sp,sp,-80
    80000102:	e0a2                	sd	s0,64(sp)
    80000104:	e486                	sd	ra,72(sp)
    80000106:	f84a                	sd	s2,48(sp)
    80000108:	0880                	add	s0,sp,80
        int i = 0;
        for(i = 0; i < n; i++){
    8000010a:	04c05b63          	blez	a2,80000160 <consolewrite+0x60>
    8000010e:	fc26                	sd	s1,56(sp)
    80000110:	f44e                	sd	s3,40(sp)
    80000112:	f052                	sd	s4,32(sp)
    80000114:	ec56                	sd	s5,24(sp)
    80000116:	89b2                	mv	s3,a2
    80000118:	8a2a                	mv	s4,a0
    8000011a:	84ae                	mv	s1,a1
    8000011c:	4901                	li	s2,0
                char c;
                if(either_copyin(&c, user_src, src+i, 1) == -1)
    8000011e:	5afd                	li	s5,-1
    80000120:	a819                	j	80000136 <consolewrite+0x36>
                        break;
                uartputc(c);
    80000122:	fbf44503          	lbu	a0,-65(s0)
        for(i = 0; i < n; i++){
    80000126:	2905                	addw	s2,s2,1
    80000128:	0485                	add	s1,s1,1
                uartputc(c);
    8000012a:	00000097          	auipc	ra,0x0
    8000012e:	7f0080e7          	jalr	2032(ra) # 8000091a <uartputc>
        for(i = 0; i < n; i++){
    80000132:	01298d63          	beq	s3,s2,8000014c <consolewrite+0x4c>
                if(either_copyin(&c, user_src, src+i, 1) == -1)
    80000136:	4685                	li	a3,1
    80000138:	8626                	mv	a2,s1
    8000013a:	85d2                	mv	a1,s4
    8000013c:	fbf40513          	add	a0,s0,-65
    80000140:	00003097          	auipc	ra,0x3
    80000144:	85a080e7          	jalr	-1958(ra) # 8000299a <either_copyin>
    80000148:	fd551de3          	bne	a0,s5,80000122 <consolewrite+0x22>
    8000014c:	74e2                	ld	s1,56(sp)
    8000014e:	79a2                	ld	s3,40(sp)
    80000150:	7a02                	ld	s4,32(sp)
    80000152:	6ae2                	ld	s5,24(sp)
        }

        return i;
}
    80000154:	60a6                	ld	ra,72(sp)
    80000156:	6406                	ld	s0,64(sp)
    80000158:	854a                	mv	a0,s2
    8000015a:	7942                	ld	s2,48(sp)
    8000015c:	6161                	add	sp,sp,80
    8000015e:	8082                	ret
        for(i = 0; i < n; i++){
    80000160:	4901                	li	s2,0
    80000162:	bfcd                	j	80000154 <consolewrite+0x54>

0000000080000164 <consoleread>:
 * user_dist indicates whether dst is a user
 * or kernel address.
 */
int
consoleread(int const user_dst, uint64 dst, int n)
{
    80000164:	711d                	add	sp,sp,-96
    80000166:	e8a2                	sd	s0,80(sp)
    80000168:	e4a6                	sd	s1,72(sp)
    8000016a:	e0ca                	sd	s2,64(sp)
    8000016c:	fc4e                	sd	s3,56(sp)
    8000016e:	f852                	sd	s4,48(sp)
    80000170:	f456                	sd	s5,40(sp)
    80000172:	f05a                	sd	s6,32(sp)
    80000174:	1080                	add	s0,sp,96
    80000176:	ec86                	sd	ra,88(sp)
    80000178:	8aaa                	mv	s5,a0
        uint target = undefined;
        int c = undefined;
        char cbuf = undefined;

        target = n;
        acquire(&cons.lock);
    8000017a:	00011517          	auipc	a0,0x11
    8000017e:	d1650513          	add	a0,a0,-746 # 80010e90 <cons>
{
    80000182:	89b2                	mv	s3,a2
    80000184:	8a2e                	mv	s4,a1
        char cbuf = undefined;
    80000186:	fa0407a3          	sb	zero,-81(s0)
        target = n;
    8000018a:	00060b1b          	sext.w	s6,a2
        while(n > 0){
                /*
                 * wait until interrupt handler has put some
                 * input into cons.buffer.
                 */
                while(cons.r == cons.w){
    8000018e:	00011497          	auipc	s1,0x11
    80000192:	d0248493          	add	s1,s1,-766 # 80010e90 <cons>
        acquire(&cons.lock);
    80000196:	00001097          	auipc	ra,0x1
    8000019a:	aca080e7          	jalr	-1334(ra) # 80000c60 <acquire>
                        if(killed(myproc())){
                                release(&cons.lock);
                                return -1;
                        }
                        sleep(&cons.r, &cons.lock);
    8000019e:	00011917          	auipc	s2,0x11
    800001a2:	d8a90913          	add	s2,s2,-630 # 80010f28 <cons+0x98>
        while(n > 0){
    800001a6:	03304363          	bgtz	s3,800001cc <consoleread+0x68>
    800001aa:	a871                	j	80000246 <consoleread+0xe2>
                        if(killed(myproc())){
    800001ac:	00002097          	auipc	ra,0x2
    800001b0:	c44080e7          	jalr	-956(ra) # 80001df0 <myproc>
    800001b4:	00002097          	auipc	ra,0x2
    800001b8:	732080e7          	jalr	1842(ra) # 800028e6 <killed>
    800001bc:	87aa                	mv	a5,a0
                        sleep(&cons.r, &cons.lock);
    800001be:	85a6                	mv	a1,s1
    800001c0:	854a                	mv	a0,s2
                        if(killed(myproc())){
    800001c2:	efb9                	bnez	a5,80000220 <consoleread+0xbc>
                        sleep(&cons.r, &cons.lock);
    800001c4:	00002097          	auipc	ra,0x2
    800001c8:	42a080e7          	jalr	1066(ra) # 800025ee <sleep>
                while(cons.r == cons.w){
    800001cc:	0984a783          	lw	a5,152(s1)
    800001d0:	09c4a703          	lw	a4,156(s1)
    800001d4:	fcf70ce3          	beq	a4,a5,800001ac <consoleread+0x48>
                }

                c = cons.buf[cons.r++ % INPUT_BUF_SIZE];
    800001d8:	07f7f713          	and	a4,a5,127
    800001dc:	ec5e                	sd	s7,24(sp)
    800001de:	9726                	add	a4,a4,s1
    800001e0:	01874703          	lbu	a4,24(a4)
    800001e4:	0017869b          	addw	a3,a5,1
    800001e8:	08d4ac23          	sw	a3,152(s1)

                if(c == C('D')){  /* end-of-file */
    800001ec:	4691                	li	a3,4
                c = cons.buf[cons.r++ % INPUT_BUF_SIZE];
    800001ee:	00070b9b          	sext.w	s7,a4
                if(c == C('D')){  /* end-of-file */
    800001f2:	06d70e63          	beq	a4,a3,8000026e <consoleread+0x10a>
                        break;
                }

                /* copy the input byte to the user-space buffer. */
                cbuf = c;
                if(either_copyout(user_dst, dst, &cbuf, 1) == -1)
    800001f6:	4685                	li	a3,1
    800001f8:	faf40613          	add	a2,s0,-81
    800001fc:	85d2                	mv	a1,s4
    800001fe:	8556                	mv	a0,s5
                cbuf = c;
    80000200:	fae407a3          	sb	a4,-81(s0)
                if(either_copyout(user_dst, dst, &cbuf, 1) == -1)
    80000204:	00002097          	auipc	ra,0x2
    80000208:	70e080e7          	jalr	1806(ra) # 80002912 <either_copyout>
    8000020c:	57fd                	li	a5,-1
    8000020e:	04f50c63          	beq	a0,a5,80000266 <consoleread+0x102>
                        break;

                dst++;
                --n;

                if(c == '\n'){
    80000212:	47a9                	li	a5,10
                dst++;
    80000214:	0a05                	add	s4,s4,1
                --n;
    80000216:	39fd                	addw	s3,s3,-1
                if(c == '\n'){
    80000218:	04fb8463          	beq	s7,a5,80000260 <consoleread+0xfc>
    8000021c:	6be2                	ld	s7,24(sp)
    8000021e:	b761                	j	800001a6 <consoleread+0x42>
                                release(&cons.lock);
    80000220:	00011517          	auipc	a0,0x11
    80000224:	c7050513          	add	a0,a0,-912 # 80010e90 <cons>
    80000228:	00001097          	auipc	ra,0x1
    8000022c:	af8080e7          	jalr	-1288(ra) # 80000d20 <release>
                                return -1;
    80000230:	557d                	li	a0,-1
                }
        }
        release(&cons.lock);

        return target - n;
}
    80000232:	60e6                	ld	ra,88(sp)
    80000234:	6446                	ld	s0,80(sp)
    80000236:	64a6                	ld	s1,72(sp)
    80000238:	6906                	ld	s2,64(sp)
    8000023a:	79e2                	ld	s3,56(sp)
    8000023c:	7a42                	ld	s4,48(sp)
    8000023e:	7aa2                	ld	s5,40(sp)
    80000240:	7b02                	ld	s6,32(sp)
    80000242:	6125                	add	sp,sp,96
    80000244:	8082                	ret
                        if(n < target){
    80000246:	0009891b          	sext.w	s2,s3
        release(&cons.lock);
    8000024a:	00011517          	auipc	a0,0x11
    8000024e:	c4650513          	add	a0,a0,-954 # 80010e90 <cons>
    80000252:	00001097          	auipc	ra,0x1
    80000256:	ace080e7          	jalr	-1330(ra) # 80000d20 <release>
        return target - n;
    8000025a:	412b053b          	subw	a0,s6,s2
    8000025e:	bfd1                	j	80000232 <consoleread+0xce>
    80000260:	6be2                	ld	s7,24(sp)
    80000262:	894e                	mv	s2,s3
    80000264:	b7dd                	j	8000024a <consoleread+0xe6>
    80000266:	6be2                	ld	s7,24(sp)
                        if(n < target){
    80000268:	0009891b          	sext.w	s2,s3
    8000026c:	bff9                	j	8000024a <consoleread+0xe6>
    8000026e:	0009891b          	sext.w	s2,s3
    80000272:	0169f663          	bgeu	s3,s6,8000027e <consoleread+0x11a>
                                cons.r--;
    80000276:	6be2                	ld	s7,24(sp)
    80000278:	08f4ac23          	sw	a5,152(s1)
    8000027c:	b7f9                	j	8000024a <consoleread+0xe6>
    8000027e:	6be2                	ld	s7,24(sp)
    80000280:	b7e9                	j	8000024a <consoleread+0xe6>

0000000080000282 <consputc>:
        if(c == BACKSPACE){
    80000282:	10000793          	li	a5,256
    80000286:	00f50663          	beq	a0,a5,80000292 <consputc+0x10>
                uartputc_sync(c);
    8000028a:	00000317          	auipc	t1,0x0
    8000028e:	5bc30067          	jr	1468(t1) # 80000846 <uartputc_sync>
{
    80000292:	1141                	add	sp,sp,-16
    80000294:	e406                	sd	ra,8(sp)
    80000296:	e022                	sd	s0,0(sp)
    80000298:	0800                	add	s0,sp,16
                uartputc_sync('\b'); uartputc_sync(' '); uartputc_sync('\b');
    8000029a:	4521                	li	a0,8
    8000029c:	00000097          	auipc	ra,0x0
    800002a0:	5aa080e7          	jalr	1450(ra) # 80000846 <uartputc_sync>
    800002a4:	02000513          	li	a0,32
    800002a8:	00000097          	auipc	ra,0x0
    800002ac:	59e080e7          	jalr	1438(ra) # 80000846 <uartputc_sync>
}
    800002b0:	6402                	ld	s0,0(sp)
    800002b2:	60a2                	ld	ra,8(sp)
                uartputc_sync('\b'); uartputc_sync(' '); uartputc_sync('\b');
    800002b4:	4521                	li	a0,8
}
    800002b6:	0141                	add	sp,sp,16
                uartputc_sync('\b'); uartputc_sync(' '); uartputc_sync('\b');
    800002b8:	00000317          	auipc	t1,0x0
    800002bc:	58e30067          	jr	1422(t1) # 80000846 <uartputc_sync>

00000000800002c0 <consoleintr>:
 * do erase/kill processing, append to cons.buf,
 * wake up consoleread() if a whole line has arrived.
 */
void
consoleintr(int c)
{
    800002c0:	1101                	add	sp,sp,-32
    800002c2:	e822                	sd	s0,16(sp)
    800002c4:	e426                	sd	s1,8(sp)
    800002c6:	e04a                	sd	s2,0(sp)
    800002c8:	ec06                	sd	ra,24(sp)
    800002ca:	1000                	add	s0,sp,32
        acquire(&cons.lock);
    800002cc:	00011497          	auipc	s1,0x11
    800002d0:	bc448493          	add	s1,s1,-1084 # 80010e90 <cons>
{
    800002d4:	892a                	mv	s2,a0
        acquire(&cons.lock);
    800002d6:	8526                	mv	a0,s1
    800002d8:	00001097          	auipc	ra,0x1
    800002dc:	988080e7          	jalr	-1656(ra) # 80000c60 <acquire>

        switch(c){
    800002e0:	47d5                	li	a5,21
    800002e2:	0ef90e63          	beq	s2,a5,800003de <consoleintr+0x11e>
    800002e6:	0327c963          	blt	a5,s2,80000318 <consoleintr+0x58>
    800002ea:	47a1                	li	a5,8
    800002ec:	0af90363          	beq	s2,a5,80000392 <consoleintr+0xd2>
    800002f0:	47c1                	li	a5,16
    800002f2:	14f91b63          	bne	s2,a5,80000448 <consoleintr+0x188>
                case C('P'):  /* Print process list. */
                        procdump();
    800002f6:	00002097          	auipc	ra,0x2
    800002fa:	72c080e7          	jalr	1836(ra) # 80002a22 <procdump>
                        }
                        break;
        }

        release(&cons.lock);
}
    800002fe:	6442                	ld	s0,16(sp)
    80000300:	60e2                	ld	ra,24(sp)
    80000302:	64a2                	ld	s1,8(sp)
    80000304:	6902                	ld	s2,0(sp)
        release(&cons.lock);
    80000306:	00011517          	auipc	a0,0x11
    8000030a:	b8a50513          	add	a0,a0,-1142 # 80010e90 <cons>
}
    8000030e:	6105                	add	sp,sp,32
        release(&cons.lock);
    80000310:	00001317          	auipc	t1,0x1
    80000314:	a1030067          	jr	-1520(t1) # 80000d20 <release>
        switch(c){
    80000318:	07f00793          	li	a5,127
    8000031c:	06f90b63          	beq	s2,a5,80000392 <consoleintr+0xd2>
                        if(c != 0 && cons.e-cons.r < INPUT_BUF_SIZE){
    80000320:	0a04a703          	lw	a4,160(s1)
    80000324:	0984a683          	lw	a3,152(s1)
    80000328:	9f15                	subw	a4,a4,a3
    8000032a:	fce7eae3          	bltu	a5,a4,800002fe <consoleintr+0x3e>
        if(c == BACKSPACE){
    8000032e:	10000793          	li	a5,256
    80000332:	14f91b63          	bne	s2,a5,80000488 <consoleintr+0x1c8>
                uartputc_sync('\b'); uartputc_sync(' '); uartputc_sync('\b');
    80000336:	4521                	li	a0,8
    80000338:	00000097          	auipc	ra,0x0
    8000033c:	50e080e7          	jalr	1294(ra) # 80000846 <uartputc_sync>
    80000340:	02000513          	li	a0,32
    80000344:	00000097          	auipc	ra,0x0
    80000348:	502080e7          	jalr	1282(ra) # 80000846 <uartputc_sync>
    8000034c:	4521                	li	a0,8
    8000034e:	00000097          	auipc	ra,0x0
    80000352:	4f8080e7          	jalr	1272(ra) # 80000846 <uartputc_sync>
                                cons.buf[cons.e++ % INPUT_BUF_SIZE] = c;
    80000356:	0a04a703          	lw	a4,160(s1)
    8000035a:	07f77693          	and	a3,a4,127
    8000035e:	0017079b          	addw	a5,a4,1
    80000362:	96a6                	add	a3,a3,s1
    80000364:	0af4a023          	sw	a5,160(s1)
    80000368:	00068c23          	sb	zero,24(a3)
                                if(c == '\n' || c == C('D') || cons.e-cons.r == INPUT_BUF_SIZE){
    8000036c:	0984a703          	lw	a4,152(s1)
    80000370:	08000693          	li	a3,128
    80000374:	40e7873b          	subw	a4,a5,a4
    80000378:	f8d713e3          	bne	a4,a3,800002fe <consoleintr+0x3e>
                                        wakeup(&cons.r);
    8000037c:	00011517          	auipc	a0,0x11
    80000380:	bac50513          	add	a0,a0,-1108 # 80010f28 <cons+0x98>
                                        cons.w = cons.e;
    80000384:	08f4ae23          	sw	a5,156(s1)
                                        wakeup(&cons.r);
    80000388:	00002097          	auipc	ra,0x2
    8000038c:	2e2080e7          	jalr	738(ra) # 8000266a <wakeup>
    80000390:	b7bd                	j	800002fe <consoleintr+0x3e>
                        if(cons.e != cons.w){
    80000392:	0a04a783          	lw	a5,160(s1)
    80000396:	09c4a703          	lw	a4,156(s1)
    8000039a:	f6f702e3          	beq	a4,a5,800002fe <consoleintr+0x3e>
                                cons.e--;
    8000039e:	37fd                	addw	a5,a5,-1
                uartputc_sync('\b'); uartputc_sync(' '); uartputc_sync('\b');
    800003a0:	4521                	li	a0,8
                                cons.e--;
    800003a2:	0af4a023          	sw	a5,160(s1)
                uartputc_sync('\b'); uartputc_sync(' '); uartputc_sync('\b');
    800003a6:	00000097          	auipc	ra,0x0
    800003aa:	4a0080e7          	jalr	1184(ra) # 80000846 <uartputc_sync>
    800003ae:	02000513          	li	a0,32
    800003b2:	00000097          	auipc	ra,0x0
    800003b6:	494080e7          	jalr	1172(ra) # 80000846 <uartputc_sync>
    800003ba:	4521                	li	a0,8
    800003bc:	00000097          	auipc	ra,0x0
    800003c0:	48a080e7          	jalr	1162(ra) # 80000846 <uartputc_sync>
}
    800003c4:	6442                	ld	s0,16(sp)
    800003c6:	60e2                	ld	ra,24(sp)
    800003c8:	64a2                	ld	s1,8(sp)
    800003ca:	6902                	ld	s2,0(sp)
        release(&cons.lock);
    800003cc:	00011517          	auipc	a0,0x11
    800003d0:	ac450513          	add	a0,a0,-1340 # 80010e90 <cons>
}
    800003d4:	6105                	add	sp,sp,32
        release(&cons.lock);
    800003d6:	00001317          	auipc	t1,0x1
    800003da:	94a30067          	jr	-1718(t1) # 80000d20 <release>
                        while(cons.e != cons.w &&
    800003de:	0a04a783          	lw	a5,160(s1)
    800003e2:	09c4a703          	lw	a4,156(s1)
    800003e6:	4929                	li	s2,10
    800003e8:	02f71a63          	bne	a4,a5,8000041c <consoleintr+0x15c>
    800003ec:	bf09                	j	800002fe <consoleintr+0x3e>
                                cons.e--;
    800003ee:	0af4a023          	sw	a5,160(s1)
                uartputc_sync('\b'); uartputc_sync(' '); uartputc_sync('\b');
    800003f2:	00000097          	auipc	ra,0x0
    800003f6:	454080e7          	jalr	1108(ra) # 80000846 <uartputc_sync>
    800003fa:	02000513          	li	a0,32
    800003fe:	00000097          	auipc	ra,0x0
    80000402:	448080e7          	jalr	1096(ra) # 80000846 <uartputc_sync>
    80000406:	4521                	li	a0,8
    80000408:	00000097          	auipc	ra,0x0
    8000040c:	43e080e7          	jalr	1086(ra) # 80000846 <uartputc_sync>
                        while(cons.e != cons.w &&
    80000410:	0a04a783          	lw	a5,160(s1)
    80000414:	09c4a703          	lw	a4,156(s1)
    80000418:	eef703e3          	beq	a4,a5,800002fe <consoleintr+0x3e>
                                        cons.buf[(cons.e-1) % INPUT_BUF_SIZE] != '\n'){
    8000041c:	37fd                	addw	a5,a5,-1
    8000041e:	07f7f713          	and	a4,a5,127
    80000422:	9726                	add	a4,a4,s1
                        while(cons.e != cons.w &&
    80000424:	01874703          	lbu	a4,24(a4)
                uartputc_sync('\b'); uartputc_sync(' '); uartputc_sync('\b');
    80000428:	4521                	li	a0,8
                        while(cons.e != cons.w &&
    8000042a:	fd2712e3          	bne	a4,s2,800003ee <consoleintr+0x12e>
}
    8000042e:	6442                	ld	s0,16(sp)
    80000430:	60e2                	ld	ra,24(sp)
    80000432:	64a2                	ld	s1,8(sp)
    80000434:	6902                	ld	s2,0(sp)
        release(&cons.lock);
    80000436:	00011517          	auipc	a0,0x11
    8000043a:	a5a50513          	add	a0,a0,-1446 # 80010e90 <cons>
}
    8000043e:	6105                	add	sp,sp,32
        release(&cons.lock);
    80000440:	00001317          	auipc	t1,0x1
    80000444:	8e030067          	jr	-1824(t1) # 80000d20 <release>
                        if(c != 0 && cons.e-cons.r < INPUT_BUF_SIZE){
    80000448:	ea090be3          	beqz	s2,800002fe <consoleintr+0x3e>
    8000044c:	0a04a783          	lw	a5,160(s1)
    80000450:	0984a683          	lw	a3,152(s1)
    80000454:	07f00713          	li	a4,127
    80000458:	9f95                	subw	a5,a5,a3
    8000045a:	eaf762e3          	bltu	a4,a5,800002fe <consoleintr+0x3e>
                                c = (c == '\r') ? '\n' : c;
    8000045e:	47b5                	li	a5,13
    80000460:	02f91463          	bne	s2,a5,80000488 <consoleintr+0x1c8>
                uartputc_sync(c);
    80000464:	4529                	li	a0,10
    80000466:	00000097          	auipc	ra,0x0
    8000046a:	3e0080e7          	jalr	992(ra) # 80000846 <uartputc_sync>
                                cons.buf[cons.e++ % INPUT_BUF_SIZE] = c;
    8000046e:	0a04a703          	lw	a4,160(s1)
    80000472:	07f77693          	and	a3,a4,127
    80000476:	0017079b          	addw	a5,a4,1
    8000047a:	96a6                	add	a3,a3,s1
    8000047c:	4729                	li	a4,10
    8000047e:	0af4a023          	sw	a5,160(s1)
    80000482:	00e68c23          	sb	a4,24(a3)
                                if(c == '\n' || c == C('D') || cons.e-cons.r == INPUT_BUF_SIZE){
    80000486:	bddd                	j	8000037c <consoleintr+0xbc>
                uartputc_sync(c);
    80000488:	854a                	mv	a0,s2
    8000048a:	00000097          	auipc	ra,0x0
    8000048e:	3bc080e7          	jalr	956(ra) # 80000846 <uartputc_sync>
                                cons.buf[cons.e++ % INPUT_BUF_SIZE] = c;
    80000492:	0a04a783          	lw	a5,160(s1)
                                if(c == '\n' || c == C('D') || cons.e-cons.r == INPUT_BUF_SIZE){
    80000496:	46a9                	li	a3,10
                                cons.buf[cons.e++ % INPUT_BUF_SIZE] = c;
    80000498:	07f7f713          	and	a4,a5,127
    8000049c:	9726                	add	a4,a4,s1
    8000049e:	2785                	addw	a5,a5,1
    800004a0:	0af4a023          	sw	a5,160(s1)
    800004a4:	01270c23          	sb	s2,24(a4)
                                if(c == '\n' || c == C('D') || cons.e-cons.r == INPUT_BUF_SIZE){
    800004a8:	ecd90ae3          	beq	s2,a3,8000037c <consoleintr+0xbc>
    800004ac:	4711                	li	a4,4
    800004ae:	ece907e3          	beq	s2,a4,8000037c <consoleintr+0xbc>
    800004b2:	bd6d                	j	8000036c <consoleintr+0xac>

00000000800004b4 <consoleinit>:

void
consoleinit(void)
{
    800004b4:	1141                	add	sp,sp,-16
    800004b6:	e406                	sd	ra,8(sp)
    800004b8:	e022                	sd	s0,0(sp)
    800004ba:	0800                	add	s0,sp,16
        initlock(&cons.lock, "cons");
    800004bc:	00008597          	auipc	a1,0x8
    800004c0:	b5458593          	add	a1,a1,-1196 # 80008010 <etext+0x10>
    800004c4:	00011517          	auipc	a0,0x11
    800004c8:	9cc50513          	add	a0,a0,-1588 # 80010e90 <cons>
    800004cc:	00000097          	auipc	ra,0x0
    800004d0:	704080e7          	jalr	1796(ra) # 80000bd0 <initlock>

        uartinit();
    800004d4:	00000097          	auipc	ra,0x0
    800004d8:	320080e7          	jalr	800(ra) # 800007f4 <uartinit>
         * connect read and write system calls
         * to consoleread and consolewrite.
         */
        devsw[CONSOLE].read = consoleread;
        devsw[CONSOLE].write = consolewrite;
}
    800004dc:	60a2                	ld	ra,8(sp)
    800004de:	6402                	ld	s0,0(sp)
        devsw[CONSOLE].read = consoleread;
    800004e0:	00021797          	auipc	a5,0x21
    800004e4:	b4878793          	add	a5,a5,-1208 # 80021028 <devsw>
    800004e8:	00000717          	auipc	a4,0x0
    800004ec:	c7c70713          	add	a4,a4,-900 # 80000164 <consoleread>
    800004f0:	eb98                	sd	a4,16(a5)
        devsw[CONSOLE].write = consolewrite;
    800004f2:	00000717          	auipc	a4,0x0
    800004f6:	c0e70713          	add	a4,a4,-1010 # 80000100 <consolewrite>
    800004fa:	ef98                	sd	a4,24(a5)
}
    800004fc:	0141                	add	sp,sp,16
    800004fe:	8082                	ret

0000000080000500 <printint.constprop.0>:
}      pr;

static char digits[] = "0123456789abcdef";

static void
printint(int xx, int base, int sign)
    80000500:	7179                	add	sp,sp,-48
    80000502:	f022                	sd	s0,32(sp)
    80000504:	f406                	sd	ra,40(sp)
    80000506:	1800                	add	s0,sp,48
    80000508:	ec26                	sd	s1,24(sp)
    8000050a:	e84a                	sd	s2,16(sp)
{
	char buf[16] = {};
    8000050c:	fc043823          	sd	zero,-48(s0)
    80000510:	fc043c23          	sd	zero,-40(s0)
	int i = undefined;
	uint x = undefined;

	if (sign && (sign = xx < 0))
    80000514:	0005071b          	sext.w	a4,a0
    80000518:	4881                	li	a7,0
    8000051a:	06054a63          	bltz	a0,8000058e <printint.constprop.0+0x8e>
	else
		x = xx;

	i = 0;
	do {
		buf[i++] = digits[x % base];
    8000051e:	2581                	sext.w	a1,a1
    80000520:	fd040693          	add	a3,s0,-48
	i = 0;
    80000524:	4601                	li	a2,0
    80000526:	00008817          	auipc	a6,0x8
    8000052a:	65280813          	add	a6,a6,1618 # 80008b78 <digits>
		buf[i++] = digits[x % base];
    8000052e:	02b777bb          	remuw	a5,a4,a1
	} while ((x /= base) != 0);
    80000532:	0685                	add	a3,a3,1
    80000534:	0007051b          	sext.w	a0,a4
    80000538:	84b2                	mv	s1,a2
		buf[i++] = digits[x % base];
    8000053a:	2605                	addw	a2,a2,1
    8000053c:	1782                	sll	a5,a5,0x20
    8000053e:	9381                	srl	a5,a5,0x20
    80000540:	97c2                	add	a5,a5,a6
    80000542:	0007c783          	lbu	a5,0(a5)
	} while ((x /= base) != 0);
    80000546:	02b7573b          	divuw	a4,a4,a1
		buf[i++] = digits[x % base];
    8000054a:	fef68fa3          	sb	a5,-1(a3)
	} while ((x /= base) != 0);
    8000054e:	feb570e3          	bgeu	a0,a1,8000052e <printint.constprop.0+0x2e>

	if (sign)
    80000552:	00088a63          	beqz	a7,80000566 <printint.constprop.0+0x66>
		buf[i++] = '-';
    80000556:	fe060793          	add	a5,a2,-32
    8000055a:	97a2                	add	a5,a5,s0
    8000055c:	02d00713          	li	a4,45
    80000560:	fee78823          	sb	a4,-16(a5)

	while (--i >= 0)
    80000564:	84b2                	mv	s1,a2
    80000566:	fd040793          	add	a5,s0,-48
    8000056a:	94be                	add	s1,s1,a5
    8000056c:	fff78913          	add	s2,a5,-1
		consputc(buf[i]);
    80000570:	0004c503          	lbu	a0,0(s1)
	while (--i >= 0)
    80000574:	14fd                	add	s1,s1,-1
		consputc(buf[i]);
    80000576:	00000097          	auipc	ra,0x0
    8000057a:	d0c080e7          	jalr	-756(ra) # 80000282 <consputc>
	while (--i >= 0)
    8000057e:	ff2499e3          	bne	s1,s2,80000570 <printint.constprop.0+0x70>
}
    80000582:	70a2                	ld	ra,40(sp)
    80000584:	7402                	ld	s0,32(sp)
    80000586:	64e2                	ld	s1,24(sp)
    80000588:	6942                	ld	s2,16(sp)
    8000058a:	6145                	add	sp,sp,48
    8000058c:	8082                	ret
		x = -xx;
    8000058e:	40a0073b          	negw	a4,a0
	if (sign && (sign = xx < 0))
    80000592:	4885                	li	a7,1
		x = -xx;
    80000594:	b769                	j	8000051e <printint.constprop.0+0x1e>

0000000080000596 <panic>:
		release(&pr.lock);
}

void
panic(char *s)
{
    80000596:	1101                	add	sp,sp,-32
    80000598:	ec06                	sd	ra,24(sp)
    8000059a:	e822                	sd	s0,16(sp)
    8000059c:	e426                	sd	s1,8(sp)
    8000059e:	1000                	add	s0,sp,32
    800005a0:	84aa                	mv	s1,a0
	pr.locking = 0;
	printf("panic: ");
    800005a2:	00008517          	auipc	a0,0x8
    800005a6:	a7650513          	add	a0,a0,-1418 # 80008018 <etext+0x18>
	pr.locking = 0;
    800005aa:	00011797          	auipc	a5,0x11
    800005ae:	9a07a323          	sw	zero,-1626(a5) # 80010f50 <pr+0x18>
	printf("panic: ");
    800005b2:	00000097          	auipc	ra,0x0
    800005b6:	02e080e7          	jalr	46(ra) # 800005e0 <printf>
	printf(s);
    800005ba:	8526                	mv	a0,s1
    800005bc:	00000097          	auipc	ra,0x0
    800005c0:	024080e7          	jalr	36(ra) # 800005e0 <printf>
	printf("\n");
    800005c4:	00008517          	auipc	a0,0x8
    800005c8:	a5c50513          	add	a0,a0,-1444 # 80008020 <etext+0x20>
    800005cc:	00000097          	auipc	ra,0x0
    800005d0:	014080e7          	jalr	20(ra) # 800005e0 <printf>
	panicked = 1;		/* freeze uart output from other CPUs */
    800005d4:	4785                	li	a5,1
    800005d6:	00008717          	auipc	a4,0x8
    800005da:	72f72d23          	sw	a5,1850(a4) # 80008d10 <panicked>
	for (;;)
    800005de:	a001                	j	800005de <panic+0x48>

00000000800005e0 <printf>:
{
    800005e0:	7171                	add	sp,sp,-176
    800005e2:	f0a2                	sd	s0,96(sp)
    800005e4:	e4ce                	sd	s3,72(sp)
    800005e6:	1880                	add	s0,sp,112
    800005e8:	f062                	sd	s8,32(sp)
    800005ea:	f486                	sd	ra,104(sp)
	locking = pr.locking;
    800005ec:	00011317          	auipc	t1,0x11
    800005f0:	94c30313          	add	t1,t1,-1716 # 80010f38 <pr>
    800005f4:	01832c03          	lw	s8,24(t1)
{
    800005f8:	e40c                	sd	a1,8(s0)
    800005fa:	e810                	sd	a2,16(s0)
    800005fc:	ec14                	sd	a3,24(s0)
    800005fe:	f018                	sd	a4,32(s0)
    80000600:	f41c                	sd	a5,40(s0)
    80000602:	03043823          	sd	a6,48(s0)
    80000606:	03143c23          	sd	a7,56(s0)
	va_list ap = nullptr;
    8000060a:	f8043c23          	sd	zero,-104(s0)
{
    8000060e:	89aa                	mv	s3,a0
	if (locking)
    80000610:	140c1d63          	bnez	s8,8000076a <printf+0x18a>
	if (fmt == 0)
    80000614:	18098763          	beqz	s3,800007a2 <printf+0x1c2>
	va_start(ap, fmt);
    80000618:	e8ca                	sd	s2,80(sp)
	for (i = 0; (c = fmt[i] & 0xff) != 0; i++) {
    8000061a:	0009c503          	lbu	a0,0(s3)
	va_start(ap, fmt);
    8000061e:	00840793          	add	a5,s0,8
    80000622:	f8f43c23          	sd	a5,-104(s0)
	for (i = 0; (c = fmt[i] & 0xff) != 0; i++) {
    80000626:	4901                	li	s2,0
    80000628:	cd35                	beqz	a0,800006a4 <printf+0xc4>
    8000062a:	e0d2                	sd	s4,64(sp)
    8000062c:	fc56                	sd	s5,56(sp)
    8000062e:	f85a                	sd	s6,48(sp)
    80000630:	f45e                	sd	s7,40(sp)
    80000632:	ec66                	sd	s9,24(sp)
    80000634:	eca6                	sd	s1,88(sp)
    80000636:	e86a                	sd	s10,16(sp)
		if (c != '%') {
    80000638:	02500a93          	li	s5,37
		switch (c) {
    8000063c:	07000b13          	li	s6,112
    80000640:	00008a17          	auipc	s4,0x8
    80000644:	538a0a13          	add	s4,s4,1336 # 80008b78 <digits>
    80000648:	07300b93          	li	s7,115
    8000064c:	06400c93          	li	s9,100
		if (c != '%') {
    80000650:	07551a63          	bne	a0,s5,800006c4 <printf+0xe4>
		c = fmt[++i] & 0xff;
    80000654:	2905                	addw	s2,s2,1
    80000656:	012987b3          	add	a5,s3,s2
    8000065a:	0007c783          	lbu	a5,0(a5)
    8000065e:	0007849b          	sext.w	s1,a5
		if (c == 0)
    80000662:	cb95                	beqz	a5,80000696 <printf+0xb6>
		switch (c) {
    80000664:	09678763          	beq	a5,s6,800006f2 <printf+0x112>
    80000668:	06fb6363          	bltu	s6,a5,800006ce <printf+0xee>
    8000066c:	0f578863          	beq	a5,s5,8000075c <printf+0x17c>
    80000670:	05979363          	bne	a5,s9,800006b6 <printf+0xd6>
			printint(va_arg(ap, int), 10, 1);
    80000674:	f9843783          	ld	a5,-104(s0)
    80000678:	45a9                	li	a1,10
    8000067a:	4388                	lw	a0,0(a5)
    8000067c:	07a1                	add	a5,a5,8
    8000067e:	f8f43c23          	sd	a5,-104(s0)
    80000682:	00000097          	auipc	ra,0x0
    80000686:	e7e080e7          	jalr	-386(ra) # 80000500 <printint.constprop.0>
	for (i = 0; (c = fmt[i] & 0xff) != 0; i++) {
    8000068a:	2905                	addw	s2,s2,1
    8000068c:	012987b3          	add	a5,s3,s2
    80000690:	0007c503          	lbu	a0,0(a5)
    80000694:	fd55                	bnez	a0,80000650 <printf+0x70>
    80000696:	64e6                	ld	s1,88(sp)
    80000698:	6a06                	ld	s4,64(sp)
    8000069a:	7ae2                	ld	s5,56(sp)
    8000069c:	7b42                	ld	s6,48(sp)
    8000069e:	7ba2                	ld	s7,40(sp)
    800006a0:	6ce2                	ld	s9,24(sp)
    800006a2:	6d42                	ld	s10,16(sp)
	if (locking)
    800006a4:	0e0c1063          	bnez	s8,80000784 <printf+0x1a4>
}
    800006a8:	70a6                	ld	ra,104(sp)
    800006aa:	7406                	ld	s0,96(sp)
    800006ac:	6946                	ld	s2,80(sp)
    800006ae:	69a6                	ld	s3,72(sp)
    800006b0:	7c02                	ld	s8,32(sp)
    800006b2:	614d                	add	sp,sp,176
    800006b4:	8082                	ret
			consputc('%');
    800006b6:	02500513          	li	a0,37
    800006ba:	00000097          	auipc	ra,0x0
    800006be:	bc8080e7          	jalr	-1080(ra) # 80000282 <consputc>
			consputc(c);
    800006c2:	8526                	mv	a0,s1
    800006c4:	00000097          	auipc	ra,0x0
    800006c8:	bbe080e7          	jalr	-1090(ra) # 80000282 <consputc>
			break;
    800006cc:	bf7d                	j	8000068a <printf+0xaa>
		switch (c) {
    800006ce:	07778463          	beq	a5,s7,80000736 <printf+0x156>
    800006d2:	07800713          	li	a4,120
    800006d6:	fee790e3          	bne	a5,a4,800006b6 <printf+0xd6>
			printint(va_arg(ap, int), 16, 1);
    800006da:	f9843783          	ld	a5,-104(s0)
    800006de:	45c1                	li	a1,16
    800006e0:	4388                	lw	a0,0(a5)
    800006e2:	07a1                	add	a5,a5,8
    800006e4:	f8f43c23          	sd	a5,-104(s0)
    800006e8:	00000097          	auipc	ra,0x0
    800006ec:	e18080e7          	jalr	-488(ra) # 80000500 <printint.constprop.0>
			break;
    800006f0:	bf69                	j	8000068a <printf+0xaa>
			printptr(va_arg(ap, uint64));
    800006f2:	f9843783          	ld	a5,-104(s0)
	consputc('0');
    800006f6:	03000513          	li	a0,48
	consputc('x');
    800006fa:	44c1                	li	s1,16
			printptr(va_arg(ap, uint64));
    800006fc:	00878713          	add	a4,a5,8
    80000700:	0007bd03          	ld	s10,0(a5)
    80000704:	f8e43c23          	sd	a4,-104(s0)
	consputc('0');
    80000708:	00000097          	auipc	ra,0x0
    8000070c:	b7a080e7          	jalr	-1158(ra) # 80000282 <consputc>
	consputc('x');
    80000710:	07800513          	li	a0,120
    80000714:	00000097          	auipc	ra,0x0
    80000718:	b6e080e7          	jalr	-1170(ra) # 80000282 <consputc>
		consputc(digits[x >> (sizeof(uint64) * 8 - 4)]);
    8000071c:	03cd5793          	srl	a5,s10,0x3c
    80000720:	97d2                	add	a5,a5,s4
    80000722:	0007c503          	lbu	a0,0(a5)
	for (i = 0; i < (sizeof(uint64) * 2); i++, x <<= 4)
    80000726:	34fd                	addw	s1,s1,-1
    80000728:	0d12                	sll	s10,s10,0x4
		consputc(digits[x >> (sizeof(uint64) * 8 - 4)]);
    8000072a:	00000097          	auipc	ra,0x0
    8000072e:	b58080e7          	jalr	-1192(ra) # 80000282 <consputc>
	for (i = 0; i < (sizeof(uint64) * 2); i++, x <<= 4)
    80000732:	f4ed                	bnez	s1,8000071c <printf+0x13c>
    80000734:	bf99                	j	8000068a <printf+0xaa>
			if ((s = va_arg(ap, char *)) == 0)
    80000736:	f9843783          	ld	a5,-104(s0)
    8000073a:	6384                	ld	s1,0(a5)
    8000073c:	07a1                	add	a5,a5,8
    8000073e:	f8f43c23          	sd	a5,-104(s0)
    80000742:	c895                	beqz	s1,80000776 <printf+0x196>
			for (; *s; s++)
    80000744:	0004c503          	lbu	a0,0(s1)
    80000748:	d129                	beqz	a0,8000068a <printf+0xaa>
				consputc(*s);
    8000074a:	00000097          	auipc	ra,0x0
    8000074e:	b38080e7          	jalr	-1224(ra) # 80000282 <consputc>
			for (; *s; s++)
    80000752:	0014c503          	lbu	a0,1(s1)
    80000756:	0485                	add	s1,s1,1
    80000758:	f96d                	bnez	a0,8000074a <printf+0x16a>
    8000075a:	bf05                	j	8000068a <printf+0xaa>
			consputc('%');
    8000075c:	02500513          	li	a0,37
    80000760:	00000097          	auipc	ra,0x0
    80000764:	b22080e7          	jalr	-1246(ra) # 80000282 <consputc>
			break;
    80000768:	b70d                	j	8000068a <printf+0xaa>
		acquire(&pr.lock);
    8000076a:	851a                	mv	a0,t1
    8000076c:	00000097          	auipc	ra,0x0
    80000770:	4f4080e7          	jalr	1268(ra) # 80000c60 <acquire>
    80000774:	b545                	j	80000614 <printf+0x34>
    80000776:	02800513          	li	a0,40
				s = "(null)";
    8000077a:	00008497          	auipc	s1,0x8
    8000077e:	8ae48493          	add	s1,s1,-1874 # 80008028 <etext+0x28>
    80000782:	b7e1                	j	8000074a <printf+0x16a>
		release(&pr.lock);
    80000784:	00010517          	auipc	a0,0x10
    80000788:	7b450513          	add	a0,a0,1972 # 80010f38 <pr>
    8000078c:	00000097          	auipc	ra,0x0
    80000790:	594080e7          	jalr	1428(ra) # 80000d20 <release>
}
    80000794:	70a6                	ld	ra,104(sp)
    80000796:	7406                	ld	s0,96(sp)
    80000798:	6946                	ld	s2,80(sp)
    8000079a:	69a6                	ld	s3,72(sp)
    8000079c:	7c02                	ld	s8,32(sp)
    8000079e:	614d                	add	sp,sp,176
    800007a0:	8082                	ret
		panic("null fmt");
    800007a2:	00008517          	auipc	a0,0x8
    800007a6:	88e50513          	add	a0,a0,-1906 # 80008030 <etext+0x30>
    800007aa:	eca6                	sd	s1,88(sp)
    800007ac:	e8ca                	sd	s2,80(sp)
    800007ae:	e0d2                	sd	s4,64(sp)
    800007b0:	fc56                	sd	s5,56(sp)
    800007b2:	f85a                	sd	s6,48(sp)
    800007b4:	f45e                	sd	s7,40(sp)
    800007b6:	ec66                	sd	s9,24(sp)
    800007b8:	e86a                	sd	s10,16(sp)
    800007ba:	00000097          	auipc	ra,0x0
    800007be:	ddc080e7          	jalr	-548(ra) # 80000596 <panic>

00000000800007c2 <printfinit>:
		;
}

void
printfinit(void)
{
    800007c2:	1101                	add	sp,sp,-32
    800007c4:	e822                	sd	s0,16(sp)
    800007c6:	e426                	sd	s1,8(sp)
    800007c8:	ec06                	sd	ra,24(sp)
    800007ca:	1000                	add	s0,sp,32
	initlock(&pr.lock, "pr");
    800007cc:	00010497          	auipc	s1,0x10
    800007d0:	76c48493          	add	s1,s1,1900 # 80010f38 <pr>
    800007d4:	8526                	mv	a0,s1
    800007d6:	00008597          	auipc	a1,0x8
    800007da:	86a58593          	add	a1,a1,-1942 # 80008040 <etext+0x40>
    800007de:	00000097          	auipc	ra,0x0
    800007e2:	3f2080e7          	jalr	1010(ra) # 80000bd0 <initlock>
	pr.locking = 1;
}
    800007e6:	60e2                	ld	ra,24(sp)
    800007e8:	6442                	ld	s0,16(sp)
	pr.locking = 1;
    800007ea:	4785                	li	a5,1
    800007ec:	cc9c                	sw	a5,24(s1)
}
    800007ee:	64a2                	ld	s1,8(sp)
    800007f0:	6105                	add	sp,sp,32
    800007f2:	8082                	ret

00000000800007f4 <uartinit>:

void uartstart();

void
uartinit(void)
{
    800007f4:	1141                	add	sp,sp,-16
    800007f6:	e422                	sd	s0,8(sp)
    800007f8:	0800                	add	s0,sp,16
        /* disable interrupts. */
        WriteReg(IER, 0x00);
    800007fa:	100007b7          	lui	a5,0x10000
    800007fe:	000780a3          	sb	zero,1(a5) # 10000001 <_entry-0x6fffffff>

        /* special mode to set baud rate. */
        WriteReg(LCR, LCR_BAUD_LATCH);
    80000802:	10000737          	lui	a4,0x10000
    80000806:	f8000693          	li	a3,-128
    8000080a:	00d701a3          	sb	a3,3(a4) # 10000003 <_entry-0x6ffffffd>
        WriteReg(IER, 0x00);
    8000080e:	10000637          	lui	a2,0x10000

        /* LSB for baud rate of 38.4K. */
        WriteReg(0, 0x03);
    80000812:	468d                	li	a3,3
    80000814:	00d60023          	sb	a3,0(a2) # 10000000 <_entry-0x70000000>

        /* MSB for baud rate of 38.4K. */
        WriteReg(1, 0x00);
    80000818:	000780a3          	sb	zero,1(a5)

        /*
         * leave set-baud mode,
         * and set word length to 8 bits, no parity.
         */
        WriteReg(LCR, LCR_EIGHT_BITS);
    8000081c:	00d701a3          	sb	a3,3(a4)

        /* enable transmit and receive interrupts. */
        WriteReg(IER, IER_TX_ENABLE | IER_RX_ENABLE);

        initlock(&uart_tx_lock, "uart");
}
    80000820:	6422                	ld	s0,8(sp)
        WriteReg(FCR, FCR_FIFO_ENABLE | FCR_FIFO_CLEAR);
    80000822:	471d                	li	a4,7
    80000824:	00e60123          	sb	a4,2(a2)
        WriteReg(IER, IER_TX_ENABLE | IER_RX_ENABLE);
    80000828:	00d780a3          	sb	a3,1(a5)
        initlock(&uart_tx_lock, "uart");
    8000082c:	00008597          	auipc	a1,0x8
    80000830:	81c58593          	add	a1,a1,-2020 # 80008048 <etext+0x48>
    80000834:	00010517          	auipc	a0,0x10
    80000838:	72450513          	add	a0,a0,1828 # 80010f58 <uart_tx_lock>
}
    8000083c:	0141                	add	sp,sp,16
        initlock(&uart_tx_lock, "uart");
    8000083e:	00000317          	auipc	t1,0x0
    80000842:	39230067          	jr	914(t1) # 80000bd0 <initlock>

0000000080000846 <uartputc_sync>:
 * to echo characters. it spins waiting for the uart's
 * output register to be empty.
 */
void
uartputc_sync(int c)
{
    80000846:	1101                	add	sp,sp,-32
    80000848:	e822                	sd	s0,16(sp)
    8000084a:	e426                	sd	s1,8(sp)
    8000084c:	ec06                	sd	ra,24(sp)
    8000084e:	1000                	add	s0,sp,32
    80000850:	84aa                	mv	s1,a0
        push_off();
    80000852:	00000097          	auipc	ra,0x0
    80000856:	3c2080e7          	jalr	962(ra) # 80000c14 <push_off>

        if(panicked){
    8000085a:	00008797          	auipc	a5,0x8
    8000085e:	4b67a783          	lw	a5,1206(a5) # 80008d10 <panicked>
    80000862:	e79d                	bnez	a5,80000890 <uartputc_sync+0x4a>
                for(;;)
                        ;
        }

        /* wait for Transmit Holding Empty to be set in LSR. */
        while((ReadReg(LSR) & LSR_TX_IDLE) == 0)
    80000864:	10000737          	lui	a4,0x10000
    80000868:	0715                	add	a4,a4,5 # 10000005 <_entry-0x6ffffffb>
    8000086a:	00074783          	lbu	a5,0(a4)
    8000086e:	0207f793          	and	a5,a5,32
    80000872:	dfe5                	beqz	a5,8000086a <uartputc_sync+0x24>
                ;
        WriteReg(THR, c);

        pop_off();
}
    80000874:	6442                	ld	s0,16(sp)
    80000876:	60e2                	ld	ra,24(sp)
        WriteReg(THR, c);
    80000878:	0ff4f513          	zext.b	a0,s1
    8000087c:	100007b7          	lui	a5,0x10000
}
    80000880:	64a2                	ld	s1,8(sp)
        WriteReg(THR, c);
    80000882:	00a78023          	sb	a0,0(a5) # 10000000 <_entry-0x70000000>
}
    80000886:	6105                	add	sp,sp,32
        pop_off();
    80000888:	00000317          	auipc	t1,0x0
    8000088c:	43a30067          	jr	1082(t1) # 80000cc2 <pop_off>
                for(;;)
    80000890:	a001                	j	80000890 <uartputc_sync+0x4a>

0000000080000892 <uartstart>:
 * caller must hold uart_tx_lock.
 * called from both the top- and bottom-half.
 */
void
uartstart()
{
    80000892:	7139                	add	sp,sp,-64
    80000894:	f822                	sd	s0,48(sp)
    80000896:	f426                	sd	s1,40(sp)
    80000898:	e05a                	sd	s6,0(sp)
    8000089a:	fc06                	sd	ra,56(sp)
    8000089c:	0080                	add	s0,sp,64
        while(1){
                if(uart_tx_w == uart_tx_r){
    8000089e:	00008497          	auipc	s1,0x8
    800008a2:	47a48493          	add	s1,s1,1146 # 80008d18 <uart_tx_r>
    800008a6:	00008b17          	auipc	s6,0x8
    800008aa:	47ab0b13          	add	s6,s6,1146 # 80008d20 <uart_tx_w>
    800008ae:	609c                	ld	a5,0(s1)
    800008b0:	000b3703          	ld	a4,0(s6)
    800008b4:	04f70d63          	beq	a4,a5,8000090e <uartstart+0x7c>
    800008b8:	f04a                	sd	s2,32(sp)
                        /* transmit buffer is empty. */
                        return;
                }

                if((ReadReg(LSR) & LSR_TX_IDLE) == 0){
    800008ba:	10000937          	lui	s2,0x10000
    800008be:	ec4e                	sd	s3,24(sp)
    800008c0:	e852                	sd	s4,16(sp)
    800008c2:	e456                	sd	s5,8(sp)
    800008c4:	10000a37          	lui	s4,0x10000
    800008c8:	0915                	add	s2,s2,5 # 10000005 <_entry-0x6ffffffb>
                         * it will interrupt when it's ready for a new byte.
                         */
                        return;
                }

                int c = uart_tx_buf[uart_tx_r % UART_TX_BUF_SIZE];
    800008ca:	00010997          	auipc	s3,0x10
    800008ce:	68e98993          	add	s3,s3,1678 # 80010f58 <uart_tx_lock>
    800008d2:	a839                	j	800008f0 <uartstart+0x5e>
    800008d4:	0186ca83          	lbu	s5,24(a3)
                uart_tx_r += 1;
    800008d8:	e09c                	sd	a5,0(s1)

                /* maybe uartputc() is waiting for space in the buffer. */
                wakeup(&uart_tx_r);
    800008da:	00002097          	auipc	ra,0x2
    800008de:	d90080e7          	jalr	-624(ra) # 8000266a <wakeup>
                if(uart_tx_w == uart_tx_r){
    800008e2:	609c                	ld	a5,0(s1)
    800008e4:	000b3703          	ld	a4,0(s6)

                WriteReg(THR, c);
    800008e8:	015a0023          	sb	s5,0(s4) # 10000000 <_entry-0x70000000>
                if(uart_tx_w == uart_tx_r){
    800008ec:	00f70d63          	beq	a4,a5,80000906 <uartstart+0x74>
                int c = uart_tx_buf[uart_tx_r % UART_TX_BUF_SIZE];
    800008f0:	01f7f713          	and	a4,a5,31
    800008f4:	00e986b3          	add	a3,s3,a4
                if((ReadReg(LSR) & LSR_TX_IDLE) == 0){
    800008f8:	00094703          	lbu	a4,0(s2)
                uart_tx_r += 1;
    800008fc:	0785                	add	a5,a5,1
                wakeup(&uart_tx_r);
    800008fe:	8526                	mv	a0,s1
                if((ReadReg(LSR) & LSR_TX_IDLE) == 0){
    80000900:	02077713          	and	a4,a4,32
    80000904:	fb61                	bnez	a4,800008d4 <uartstart+0x42>
    80000906:	7902                	ld	s2,32(sp)
    80000908:	69e2                	ld	s3,24(sp)
    8000090a:	6a42                	ld	s4,16(sp)
    8000090c:	6aa2                	ld	s5,8(sp)
        }
}
    8000090e:	70e2                	ld	ra,56(sp)
    80000910:	7442                	ld	s0,48(sp)
    80000912:	74a2                	ld	s1,40(sp)
    80000914:	6b02                	ld	s6,0(sp)
    80000916:	6121                	add	sp,sp,64
    80000918:	8082                	ret

000000008000091a <uartputc>:
{
    8000091a:	7179                	add	sp,sp,-48
    8000091c:	f022                	sd	s0,32(sp)
    8000091e:	e052                	sd	s4,0(sp)
    80000920:	f406                	sd	ra,40(sp)
    80000922:	ec26                	sd	s1,24(sp)
    80000924:	e84a                	sd	s2,16(sp)
    80000926:	e44e                	sd	s3,8(sp)
    80000928:	1800                	add	s0,sp,48
    8000092a:	8a2a                	mv	s4,a0
        acquire(&uart_tx_lock);
    8000092c:	00010517          	auipc	a0,0x10
    80000930:	62c50513          	add	a0,a0,1580 # 80010f58 <uart_tx_lock>
    80000934:	00000097          	auipc	ra,0x0
    80000938:	32c080e7          	jalr	812(ra) # 80000c60 <acquire>
        if(panicked){
    8000093c:	00008797          	auipc	a5,0x8
    80000940:	3d47a783          	lw	a5,980(a5) # 80008d10 <panicked>
    80000944:	efad                	bnez	a5,800009be <uartputc+0xa4>
        while(uart_tx_w == uart_tx_r + UART_TX_BUF_SIZE){
    80000946:	00008497          	auipc	s1,0x8
    8000094a:	3d248493          	add	s1,s1,978 # 80008d18 <uart_tx_r>
    8000094e:	609c                	ld	a5,0(s1)
    80000950:	00008917          	auipc	s2,0x8
    80000954:	3d090913          	add	s2,s2,976 # 80008d20 <uart_tx_w>
    80000958:	00093703          	ld	a4,0(s2)
    8000095c:	02078793          	add	a5,a5,32
                sleep(&uart_tx_r, &uart_tx_lock);
    80000960:	00010997          	auipc	s3,0x10
    80000964:	5f898993          	add	s3,s3,1528 # 80010f58 <uart_tx_lock>
        while(uart_tx_w == uart_tx_r + UART_TX_BUF_SIZE){
    80000968:	00e79f63          	bne	a5,a4,80000986 <uartputc+0x6c>
                sleep(&uart_tx_r, &uart_tx_lock);
    8000096c:	85ce                	mv	a1,s3
    8000096e:	8526                	mv	a0,s1
    80000970:	00002097          	auipc	ra,0x2
    80000974:	c7e080e7          	jalr	-898(ra) # 800025ee <sleep>
        while(uart_tx_w == uart_tx_r + UART_TX_BUF_SIZE){
    80000978:	609c                	ld	a5,0(s1)
    8000097a:	00093703          	ld	a4,0(s2)
    8000097e:	02078793          	add	a5,a5,32
    80000982:	fee785e3          	beq	a5,a4,8000096c <uartputc+0x52>
        uart_tx_buf[uart_tx_w % UART_TX_BUF_SIZE] = c;
    80000986:	00010497          	auipc	s1,0x10
    8000098a:	5d248493          	add	s1,s1,1490 # 80010f58 <uart_tx_lock>
    8000098e:	01f77793          	and	a5,a4,31
    80000992:	97a6                	add	a5,a5,s1
        uart_tx_w += 1;
    80000994:	0705                	add	a4,a4,1
        uart_tx_buf[uart_tx_w % UART_TX_BUF_SIZE] = c;
    80000996:	01478c23          	sb	s4,24(a5)
        uart_tx_w += 1;
    8000099a:	00e93023          	sd	a4,0(s2)
        uartstart();
    8000099e:	00000097          	auipc	ra,0x0
    800009a2:	ef4080e7          	jalr	-268(ra) # 80000892 <uartstart>
}
    800009a6:	7402                	ld	s0,32(sp)
    800009a8:	70a2                	ld	ra,40(sp)
    800009aa:	6942                	ld	s2,16(sp)
    800009ac:	69a2                	ld	s3,8(sp)
    800009ae:	6a02                	ld	s4,0(sp)
        release(&uart_tx_lock);
    800009b0:	8526                	mv	a0,s1
}
    800009b2:	64e2                	ld	s1,24(sp)
    800009b4:	6145                	add	sp,sp,48
        release(&uart_tx_lock);
    800009b6:	00000317          	auipc	t1,0x0
    800009ba:	36a30067          	jr	874(t1) # 80000d20 <release>
                for(;;)
    800009be:	a001                	j	800009be <uartputc+0xa4>

00000000800009c0 <uartgetc>:
 * read one input character from the UART.
 * return -1 if none is waiting.
 */
int
uartgetc(void)
{
    800009c0:	1141                	add	sp,sp,-16
    800009c2:	e422                	sd	s0,8(sp)
    800009c4:	0800                	add	s0,sp,16
        if(ReadReg(LSR) & 0x01){
    800009c6:	10000737          	lui	a4,0x10000
    800009ca:	00574783          	lbu	a5,5(a4) # 10000005 <_entry-0x6ffffffb>
    800009ce:	8b85                	and	a5,a5,1
    800009d0:	cb81                	beqz	a5,800009e0 <uartgetc+0x20>
                /* input data is ready. */
                return ReadReg(RHR);
    800009d2:	100007b7          	lui	a5,0x10000
    800009d6:	0007c503          	lbu	a0,0(a5) # 10000000 <_entry-0x70000000>
        } else {
                return -1;
        }
}
    800009da:	6422                	ld	s0,8(sp)
    800009dc:	0141                	add	sp,sp,16
    800009de:	8082                	ret
                return -1;
    800009e0:	557d                	li	a0,-1
    800009e2:	bfe5                	j	800009da <uartgetc+0x1a>

00000000800009e4 <uartintr>:
 * arrived, or the uart is ready for more output, or
 * both. called from devintr().
 */
void
uartintr(void)
{
    800009e4:	1101                	add	sp,sp,-32
    800009e6:	e822                	sd	s0,16(sp)
    800009e8:	e426                	sd	s1,8(sp)
    800009ea:	ec06                	sd	ra,24(sp)
    800009ec:	1000                	add	s0,sp,32
        if(ReadReg(LSR) & 0x01){
    800009ee:	100004b7          	lui	s1,0x10000
    800009f2:	0054c783          	lbu	a5,5(s1) # 10000005 <_entry-0x6ffffffb>
    800009f6:	8b85                	and	a5,a5,1
    800009f8:	c385                	beqz	a5,80000a18 <uartintr+0x34>
    800009fa:	e04a                	sd	s2,0(sp)
    800009fc:	0495                	add	s1,s1,5
    800009fe:	10000937          	lui	s2,0x10000
                return ReadReg(RHR);
    80000a02:	00094503          	lbu	a0,0(s2) # 10000000 <_entry-0x70000000>
        /* read and process incoming characters. */
        while(1){
                int c = uartgetc();
                if(c == -1)
                        break;
                consoleintr(c);
    80000a06:	00000097          	auipc	ra,0x0
    80000a0a:	8ba080e7          	jalr	-1862(ra) # 800002c0 <consoleintr>
        if(ReadReg(LSR) & 0x01){
    80000a0e:	0004c783          	lbu	a5,0(s1)
    80000a12:	8b85                	and	a5,a5,1
    80000a14:	f7fd                	bnez	a5,80000a02 <uartintr+0x1e>
    80000a16:	6902                	ld	s2,0(sp)
        }

        /* send buffered characters. */
        acquire(&uart_tx_lock);
    80000a18:	00010517          	auipc	a0,0x10
    80000a1c:	54050513          	add	a0,a0,1344 # 80010f58 <uart_tx_lock>
    80000a20:	00000097          	auipc	ra,0x0
    80000a24:	240080e7          	jalr	576(ra) # 80000c60 <acquire>
        uartstart();
    80000a28:	00000097          	auipc	ra,0x0
    80000a2c:	e6a080e7          	jalr	-406(ra) # 80000892 <uartstart>
        release(&uart_tx_lock);
}
    80000a30:	6442                	ld	s0,16(sp)
    80000a32:	60e2                	ld	ra,24(sp)
    80000a34:	64a2                	ld	s1,8(sp)
        release(&uart_tx_lock);
    80000a36:	00010517          	auipc	a0,0x10
    80000a3a:	52250513          	add	a0,a0,1314 # 80010f58 <uart_tx_lock>
}
    80000a3e:	6105                	add	sp,sp,32
        release(&uart_tx_lock);
    80000a40:	00000317          	auipc	t1,0x0
    80000a44:	2e030067          	jr	736(t1) # 80000d20 <release>

0000000080000a48 <kfree>:
 * call to kalloc().(The exception is when
 * initializing the allocator; see kinit above.)
 */
void
kfree(void *pa)
{
    80000a48:	1101                	add	sp,sp,-32
    80000a4a:	e822                	sd	s0,16(sp)
    80000a4c:	ec06                	sd	ra,24(sp)
    80000a4e:	e426                	sd	s1,8(sp)
    80000a50:	e04a                	sd	s2,0(sp)
    80000a52:	1000                	add	s0,sp,32
	struct run *r = nullptr;

	if (((uint64) pa % PGSIZE) != 0 || (char *)pa < end || (uint64) pa >= PHYSTOP)
    80000a54:	03451793          	sll	a5,a0,0x34
    80000a58:	ebb1                	bnez	a5,80000aac <kfree+0x64>
    80000a5a:	00021797          	auipc	a5,0x21
    80000a5e:	76678793          	add	a5,a5,1894 # 800221c0 <end>
    80000a62:	84aa                	mv	s1,a0
    80000a64:	04f56463          	bltu	a0,a5,80000aac <kfree+0x64>
    80000a68:	47c5                	li	a5,17
    80000a6a:	07ee                	sll	a5,a5,0x1b
    80000a6c:	04f57063          	bgeu	a0,a5,80000aac <kfree+0x64>
		panic("kfree");

	/* Fill with junk to catch dangling refs. */
	memset(pa, 1, PGSIZE);
    80000a70:	6605                	lui	a2,0x1
    80000a72:	4585                	li	a1,1
    80000a74:	00000097          	auipc	ra,0x0
    80000a78:	300080e7          	jalr	768(ra) # 80000d74 <memset>

	r = (struct run *)pa;

	acquire(&kmem.lock);
    80000a7c:	00010917          	auipc	s2,0x10
    80000a80:	51490913          	add	s2,s2,1300 # 80010f90 <kmem>
    80000a84:	854a                	mv	a0,s2
    80000a86:	00000097          	auipc	ra,0x0
    80000a8a:	1da080e7          	jalr	474(ra) # 80000c60 <acquire>
	r->next = kmem.freelist;
    80000a8e:	01893783          	ld	a5,24(s2)
	kmem.freelist = r;
	release(&kmem.lock);
}
    80000a92:	6442                	ld	s0,16(sp)
    80000a94:	60e2                	ld	ra,24(sp)
	r->next = kmem.freelist;
    80000a96:	e09c                	sd	a5,0(s1)
	kmem.freelist = r;
    80000a98:	00993c23          	sd	s1,24(s2)
	release(&kmem.lock);
    80000a9c:	854a                	mv	a0,s2
}
    80000a9e:	64a2                	ld	s1,8(sp)
    80000aa0:	6902                	ld	s2,0(sp)
    80000aa2:	6105                	add	sp,sp,32
	release(&kmem.lock);
    80000aa4:	00000317          	auipc	t1,0x0
    80000aa8:	27c30067          	jr	636(t1) # 80000d20 <release>
		panic("kfree");
    80000aac:	00007517          	auipc	a0,0x7
    80000ab0:	5a450513          	add	a0,a0,1444 # 80008050 <etext+0x50>
    80000ab4:	00000097          	auipc	ra,0x0
    80000ab8:	ae2080e7          	jalr	-1310(ra) # 80000596 <panic>

0000000080000abc <freerange>:
	p = (char *)PGROUNDUP((uint64) pa_start);
    80000abc:	6785                	lui	a5,0x1
    80000abe:	fff78713          	add	a4,a5,-1 # fff <_entry-0x7ffff001>
{
    80000ac2:	7179                	add	sp,sp,-48
	p = (char *)PGROUNDUP((uint64) pa_start);
    80000ac4:	953a                	add	a0,a0,a4
    80000ac6:	777d                	lui	a4,0xfffff
{
    80000ac8:	f022                	sd	s0,32(sp)
    80000aca:	ec26                	sd	s1,24(sp)
    80000acc:	f406                	sd	ra,40(sp)
    80000ace:	1800                	add	s0,sp,48
	p = (char *)PGROUNDUP((uint64) pa_start);
    80000ad0:	8d79                	and	a0,a0,a4
	for (; p + PGSIZE <= (char *)pa_end; p += PGSIZE)
    80000ad2:	00f504b3          	add	s1,a0,a5
    80000ad6:	0295e463          	bltu	a1,s1,80000afe <freerange+0x42>
    80000ada:	e84a                	sd	s2,16(sp)
    80000adc:	e44e                	sd	s3,8(sp)
    80000ade:	e052                	sd	s4,0(sp)
    80000ae0:	892e                	mv	s2,a1
	kfree(p);
    80000ae2:	7a7d                	lui	s4,0xfffff
	for (; p + PGSIZE <= (char *)pa_end; p += PGSIZE)
    80000ae4:	6985                	lui	s3,0x1
	kfree(p);
    80000ae6:	01448533          	add	a0,s1,s4
	for (; p + PGSIZE <= (char *)pa_end; p += PGSIZE)
    80000aea:	94ce                	add	s1,s1,s3
	kfree(p);
    80000aec:	00000097          	auipc	ra,0x0
    80000af0:	f5c080e7          	jalr	-164(ra) # 80000a48 <kfree>
	for (; p + PGSIZE <= (char *)pa_end; p += PGSIZE)
    80000af4:	fe9979e3          	bgeu	s2,s1,80000ae6 <freerange+0x2a>
    80000af8:	6942                	ld	s2,16(sp)
    80000afa:	69a2                	ld	s3,8(sp)
    80000afc:	6a02                	ld	s4,0(sp)
}
    80000afe:	70a2                	ld	ra,40(sp)
    80000b00:	7402                	ld	s0,32(sp)
    80000b02:	64e2                	ld	s1,24(sp)
    80000b04:	6145                	add	sp,sp,48
    80000b06:	8082                	ret

0000000080000b08 <kinit>:
{
    80000b08:	7179                	add	sp,sp,-48
    80000b0a:	f022                	sd	s0,32(sp)
    80000b0c:	ec26                	sd	s1,24(sp)
    80000b0e:	e84a                	sd	s2,16(sp)
    80000b10:	f406                	sd	ra,40(sp)
    80000b12:	1800                	add	s0,sp,48
	initlock(&kmem.lock, "kmem");
    80000b14:	00007597          	auipc	a1,0x7
    80000b18:	54458593          	add	a1,a1,1348 # 80008058 <etext+0x58>
    80000b1c:	00010517          	auipc	a0,0x10
    80000b20:	47450513          	add	a0,a0,1140 # 80010f90 <kmem>
    80000b24:	00000097          	auipc	ra,0x0
    80000b28:	0ac080e7          	jalr	172(ra) # 80000bd0 <initlock>
	p = (char *)PGROUNDUP((uint64) pa_start);
    80000b2c:	77fd                	lui	a5,0xfffff
    80000b2e:	00022497          	auipc	s1,0x22
    80000b32:	69148493          	add	s1,s1,1681 # 800231bf <end+0xfff>
    80000b36:	8cfd                	and	s1,s1,a5
	for (; p + PGSIZE <= (char *)pa_end; p += PGSIZE)
    80000b38:	4945                	li	s2,17
    80000b3a:	6785                	lui	a5,0x1
    80000b3c:	97a6                	add	a5,a5,s1
    80000b3e:	096e                	sll	s2,s2,0x1b
    80000b40:	00f96d63          	bltu	s2,a5,80000b5a <kinit+0x52>
    80000b44:	e44e                	sd	s3,8(sp)
    80000b46:	6985                	lui	s3,0x1
	kfree(p);
    80000b48:	8526                	mv	a0,s1
	for (; p + PGSIZE <= (char *)pa_end; p += PGSIZE)
    80000b4a:	94ce                	add	s1,s1,s3
	kfree(p);
    80000b4c:	00000097          	auipc	ra,0x0
    80000b50:	efc080e7          	jalr	-260(ra) # 80000a48 <kfree>
	for (; p + PGSIZE <= (char *)pa_end; p += PGSIZE)
    80000b54:	ff249ae3          	bne	s1,s2,80000b48 <kinit+0x40>
    80000b58:	69a2                	ld	s3,8(sp)
}
    80000b5a:	70a2                	ld	ra,40(sp)
    80000b5c:	7402                	ld	s0,32(sp)
    80000b5e:	64e2                	ld	s1,24(sp)
    80000b60:	6942                	ld	s2,16(sp)
    80000b62:	6145                	add	sp,sp,48
    80000b64:	8082                	ret

0000000080000b66 <kalloc>:
 * Returns a pointer that the kernel can use.
 * Returns 0 if the memory cannot be allocated.
 */
void *
kalloc(void)
{
    80000b66:	1101                	add	sp,sp,-32
    80000b68:	e822                	sd	s0,16(sp)
    80000b6a:	e426                	sd	s1,8(sp)
    80000b6c:	e04a                	sd	s2,0(sp)
    80000b6e:	ec06                	sd	ra,24(sp)
    80000b70:	1000                	add	s0,sp,32
        struct run *r = nullptr;

	acquire(&kmem.lock);
    80000b72:	00010497          	auipc	s1,0x10
    80000b76:	41e48493          	add	s1,s1,1054 # 80010f90 <kmem>
    80000b7a:	8526                	mv	a0,s1
    80000b7c:	00000097          	auipc	ra,0x0
    80000b80:	0e4080e7          	jalr	228(ra) # 80000c60 <acquire>
	r = kmem.freelist;
    80000b84:	0184b903          	ld	s2,24(s1)
	if (r)
    80000b88:	02090863          	beqz	s2,80000bb8 <kalloc+0x52>
		kmem.freelist = r->next;
    80000b8c:	00093783          	ld	a5,0(s2)
	release(&kmem.lock);
    80000b90:	8526                	mv	a0,s1
		kmem.freelist = r->next;
    80000b92:	ec9c                	sd	a5,24(s1)
	release(&kmem.lock);
    80000b94:	00000097          	auipc	ra,0x0
    80000b98:	18c080e7          	jalr	396(ra) # 80000d20 <release>

	if (r)
		memset((char *)r, 5, PGSIZE);   /* fill with junk */
    80000b9c:	854a                	mv	a0,s2
    80000b9e:	6605                	lui	a2,0x1
    80000ba0:	4595                	li	a1,5
    80000ba2:	00000097          	auipc	ra,0x0
    80000ba6:	1d2080e7          	jalr	466(ra) # 80000d74 <memset>
	return (void *)r;
}
    80000baa:	60e2                	ld	ra,24(sp)
    80000bac:	6442                	ld	s0,16(sp)
    80000bae:	64a2                	ld	s1,8(sp)
    80000bb0:	854a                	mv	a0,s2
    80000bb2:	6902                	ld	s2,0(sp)
    80000bb4:	6105                	add	sp,sp,32
    80000bb6:	8082                	ret
	release(&kmem.lock);
    80000bb8:	8526                	mv	a0,s1
    80000bba:	00000097          	auipc	ra,0x0
    80000bbe:	166080e7          	jalr	358(ra) # 80000d20 <release>
}
    80000bc2:	60e2                	ld	ra,24(sp)
    80000bc4:	6442                	ld	s0,16(sp)
    80000bc6:	64a2                	ld	s1,8(sp)
    80000bc8:	854a                	mv	a0,s2
    80000bca:	6902                	ld	s2,0(sp)
    80000bcc:	6105                	add	sp,sp,32
    80000bce:	8082                	ret

0000000080000bd0 <initlock>:
#include "proc.h"
#include "defs.h"

void
initlock(struct spinlock *lk, char *name)
{
    80000bd0:	1141                	add	sp,sp,-16
    80000bd2:	e422                	sd	s0,8(sp)
    80000bd4:	0800                	add	s0,sp,16
	lk->name = name;
	lk->locked = 0;
	lk->cpu = 0;
}
    80000bd6:	6422                	ld	s0,8(sp)
	lk->name = name;
    80000bd8:	e50c                	sd	a1,8(a0)
	lk->locked = 0;
    80000bda:	00052023          	sw	zero,0(a0)
	lk->cpu = 0;
    80000bde:	00053823          	sd	zero,16(a0)
}
    80000be2:	0141                	add	sp,sp,16
    80000be4:	8082                	ret

0000000080000be6 <holding>:
 */
int
holding(struct spinlock *lk)
{
	int r = undefined;
	r = (lk->locked && lk->cpu == mycpu());
    80000be6:	411c                	lw	a5,0(a0)
    80000be8:	e399                	bnez	a5,80000bee <holding+0x8>
    80000bea:	4501                	li	a0,0
	return r;
}
    80000bec:	8082                	ret
{
    80000bee:	1101                	add	sp,sp,-32
    80000bf0:	e822                	sd	s0,16(sp)
    80000bf2:	e426                	sd	s1,8(sp)
    80000bf4:	ec06                	sd	ra,24(sp)
    80000bf6:	1000                	add	s0,sp,32
	r = (lk->locked && lk->cpu == mycpu());
    80000bf8:	6904                	ld	s1,16(a0)
    80000bfa:	00001097          	auipc	ra,0x1
    80000bfe:	1da080e7          	jalr	474(ra) # 80001dd4 <mycpu>
}
    80000c02:	60e2                	ld	ra,24(sp)
    80000c04:	6442                	ld	s0,16(sp)
	r = (lk->locked && lk->cpu == mycpu());
    80000c06:	40a48533          	sub	a0,s1,a0
    80000c0a:	00153513          	seqz	a0,a0
}
    80000c0e:	64a2                	ld	s1,8(sp)
    80000c10:	6105                	add	sp,sp,32
    80000c12:	8082                	ret

0000000080000c14 <push_off>:
 * it takes two pop_off()s to undo two push_off()s.  Also, if interrupts
 * are initially off, then push_off, pop_off leaves them off.
 */
void
push_off(void)
{
    80000c14:	1101                	add	sp,sp,-32
    80000c16:	e822                	sd	s0,16(sp)
    80000c18:	ec06                	sd	ra,24(sp)
    80000c1a:	e426                	sd	s1,8(sp)
    80000c1c:	1000                	add	s0,sp,32
  __asm__ volatile("csrr %0, sstatus" : "=r" (x) );
    80000c1e:	100024f3          	csrr	s1,sstatus
    80000c22:	100027f3          	csrr	a5,sstatus
  w_sstatus(r_sstatus() & ~SSTATUS_SIE);
    80000c26:	9bf5                	and	a5,a5,-3
  __asm__ volatile("csrw sstatus, %0" : : "r" (x));
    80000c28:	10079073          	csrw	sstatus,a5
	int old = intr_get();

	intr_off();
	if (mycpu()->noff == 0)
    80000c2c:	00001097          	auipc	ra,0x1
    80000c30:	1a8080e7          	jalr	424(ra) # 80001dd4 <mycpu>
    80000c34:	5d3c                	lw	a5,120(a0)
    80000c36:	cf89                	beqz	a5,80000c50 <push_off+0x3c>
		mycpu()->intena = old;
	mycpu()->noff += 1;
    80000c38:	00001097          	auipc	ra,0x1
    80000c3c:	19c080e7          	jalr	412(ra) # 80001dd4 <mycpu>
    80000c40:	5d3c                	lw	a5,120(a0)
}
    80000c42:	60e2                	ld	ra,24(sp)
    80000c44:	6442                	ld	s0,16(sp)
	mycpu()->noff += 1;
    80000c46:	2785                	addw	a5,a5,1 # 1001 <_entry-0x7fffefff>
    80000c48:	dd3c                	sw	a5,120(a0)
}
    80000c4a:	64a2                	ld	s1,8(sp)
    80000c4c:	6105                	add	sp,sp,32
    80000c4e:	8082                	ret
  return (x & SSTATUS_SIE) != 0;
    80000c50:	8085                	srl	s1,s1,0x1
		mycpu()->intena = old;
    80000c52:	00001097          	auipc	ra,0x1
    80000c56:	182080e7          	jalr	386(ra) # 80001dd4 <mycpu>
    80000c5a:	8885                	and	s1,s1,1
    80000c5c:	dd64                	sw	s1,124(a0)
    80000c5e:	bfe9                	j	80000c38 <push_off+0x24>

0000000080000c60 <acquire>:
{
    80000c60:	1101                	add	sp,sp,-32
    80000c62:	e822                	sd	s0,16(sp)
    80000c64:	e426                	sd	s1,8(sp)
    80000c66:	ec06                	sd	ra,24(sp)
    80000c68:	1000                	add	s0,sp,32
    80000c6a:	84aa                	mv	s1,a0
	push_off();		/* disable interrupts to avoid deadlock. */
    80000c6c:	00000097          	auipc	ra,0x0
    80000c70:	fa8080e7          	jalr	-88(ra) # 80000c14 <push_off>
	r = (lk->locked && lk->cpu == mycpu());
    80000c74:	409c                	lw	a5,0(s1)
    80000c76:	e39d                	bnez	a5,80000c9c <acquire+0x3c>
	while (__sync_lock_test_and_set(&lk->locked, 1) != 0)
    80000c78:	4705                	li	a4,1
    80000c7a:	87ba                	mv	a5,a4
    80000c7c:	0cf4a7af          	amoswap.w.aq	a5,a5,(s1)
    80000c80:	2781                	sext.w	a5,a5
    80000c82:	ffe5                	bnez	a5,80000c7a <acquire+0x1a>
	__sync_synchronize();
    80000c84:	0ff0000f          	fence
	lk->cpu = mycpu();
    80000c88:	00001097          	auipc	ra,0x1
    80000c8c:	14c080e7          	jalr	332(ra) # 80001dd4 <mycpu>
}
    80000c90:	60e2                	ld	ra,24(sp)
    80000c92:	6442                	ld	s0,16(sp)
	lk->cpu = mycpu();
    80000c94:	e888                	sd	a0,16(s1)
}
    80000c96:	64a2                	ld	s1,8(sp)
    80000c98:	6105                	add	sp,sp,32
    80000c9a:	8082                	ret
    80000c9c:	e04a                	sd	s2,0(sp)
	r = (lk->locked && lk->cpu == mycpu());
    80000c9e:	0104b903          	ld	s2,16(s1)
    80000ca2:	00001097          	auipc	ra,0x1
    80000ca6:	132080e7          	jalr	306(ra) # 80001dd4 <mycpu>
    80000caa:	00a90463          	beq	s2,a0,80000cb2 <acquire+0x52>
    80000cae:	6902                	ld	s2,0(sp)
    80000cb0:	b7e1                	j	80000c78 <acquire+0x18>
		panic("acquire");
    80000cb2:	00007517          	auipc	a0,0x7
    80000cb6:	3ae50513          	add	a0,a0,942 # 80008060 <etext+0x60>
    80000cba:	00000097          	auipc	ra,0x0
    80000cbe:	8dc080e7          	jalr	-1828(ra) # 80000596 <panic>

0000000080000cc2 <pop_off>:

void
pop_off(void)
{
    80000cc2:	1141                	add	sp,sp,-16
    80000cc4:	e022                	sd	s0,0(sp)
    80000cc6:	e406                	sd	ra,8(sp)
    80000cc8:	0800                	add	s0,sp,16
	struct cpu *c = mycpu();
    80000cca:	00001097          	auipc	ra,0x1
    80000cce:	10a080e7          	jalr	266(ra) # 80001dd4 <mycpu>
  __asm__ volatile("csrr %0, sstatus" : "=r" (x) );
    80000cd2:	100027f3          	csrr	a5,sstatus
  return (x & SSTATUS_SIE) != 0;
    80000cd6:	8b89                	and	a5,a5,2
	if (intr_get())
    80000cd8:	ef85                	bnez	a5,80000d10 <pop_off+0x4e>
		panic("pop_off - interruptible");
	if (c->noff < 1)
    80000cda:	5d3c                	lw	a5,120(a0)
    80000cdc:	02f05263          	blez	a5,80000d00 <pop_off+0x3e>
		panic("pop_off");
	c->noff -= 1;
    80000ce0:	fff7871b          	addw	a4,a5,-1
    80000ce4:	dd38                	sw	a4,120(a0)
	if (c->noff == 0 && c->intena)
    80000ce6:	eb09                	bnez	a4,80000cf8 <pop_off+0x36>
    80000ce8:	5d7c                	lw	a5,124(a0)
    80000cea:	c799                	beqz	a5,80000cf8 <pop_off+0x36>
  __asm__ volatile("csrr %0, sstatus" : "=r" (x) );
    80000cec:	100027f3          	csrr	a5,sstatus
  w_sstatus(r_sstatus() | SSTATUS_SIE);
    80000cf0:	0027e793          	or	a5,a5,2
  __asm__ volatile("csrw sstatus, %0" : : "r" (x));
    80000cf4:	10079073          	csrw	sstatus,a5
		intr_on();
}
    80000cf8:	60a2                	ld	ra,8(sp)
    80000cfa:	6402                	ld	s0,0(sp)
    80000cfc:	0141                	add	sp,sp,16
    80000cfe:	8082                	ret
		panic("pop_off");
    80000d00:	00007517          	auipc	a0,0x7
    80000d04:	38050513          	add	a0,a0,896 # 80008080 <etext+0x80>
    80000d08:	00000097          	auipc	ra,0x0
    80000d0c:	88e080e7          	jalr	-1906(ra) # 80000596 <panic>
		panic("pop_off - interruptible");
    80000d10:	00007517          	auipc	a0,0x7
    80000d14:	35850513          	add	a0,a0,856 # 80008068 <etext+0x68>
    80000d18:	00000097          	auipc	ra,0x0
    80000d1c:	87e080e7          	jalr	-1922(ra) # 80000596 <panic>

0000000080000d20 <release>:
{
    80000d20:	1101                	add	sp,sp,-32
    80000d22:	e822                	sd	s0,16(sp)
    80000d24:	ec06                	sd	ra,24(sp)
    80000d26:	e426                	sd	s1,8(sp)
    80000d28:	e04a                	sd	s2,0(sp)
    80000d2a:	1000                	add	s0,sp,32
	r = (lk->locked && lk->cpu == mycpu());
    80000d2c:	411c                	lw	a5,0(a0)
    80000d2e:	eb89                	bnez	a5,80000d40 <release+0x20>
		panic("release");
    80000d30:	00007517          	auipc	a0,0x7
    80000d34:	35850513          	add	a0,a0,856 # 80008088 <etext+0x88>
    80000d38:	00000097          	auipc	ra,0x0
    80000d3c:	85e080e7          	jalr	-1954(ra) # 80000596 <panic>
	r = (lk->locked && lk->cpu == mycpu());
    80000d40:	01053903          	ld	s2,16(a0)
    80000d44:	84aa                	mv	s1,a0
    80000d46:	00001097          	auipc	ra,0x1
    80000d4a:	08e080e7          	jalr	142(ra) # 80001dd4 <mycpu>
    80000d4e:	fea911e3          	bne	s2,a0,80000d30 <release+0x10>
	lk->cpu = 0;
    80000d52:	0004b823          	sd	zero,16(s1)
	__sync_synchronize();
    80000d56:	0ff0000f          	fence
	__sync_lock_release(&lk->locked);
    80000d5a:	0f50000f          	fence	iorw,ow
    80000d5e:	0804a02f          	amoswap.w	zero,zero,(s1)
}
    80000d62:	6442                	ld	s0,16(sp)
    80000d64:	60e2                	ld	ra,24(sp)
    80000d66:	64a2                	ld	s1,8(sp)
    80000d68:	6902                	ld	s2,0(sp)
    80000d6a:	6105                	add	sp,sp,32
	pop_off();
    80000d6c:	00000317          	auipc	t1,0x0
    80000d70:	f5630067          	jr	-170(t1) # 80000cc2 <pop_off>

0000000080000d74 <memset>:
#define VAL c0
#define WIDEVAL c

void *
memset(void *dst0, int c0, uint length)
{
    80000d74:	1141                	add	sp,sp,-16
    80000d76:	e422                	sd	s0,8(sp)
    80000d78:	0800                	add	s0,sp,16
        ulong c = undefined;
        uchar *dst = nullptr;

        dst = dst0;

        if (length < 3 * wsize) {
    80000d7a:	47dd                	li	a5,23
    80000d7c:	04c7fb63          	bgeu	a5,a2,80000dd2 <memset+0x5e>
                }
                RETURN;
        }

        /* Align destination by filling in bytes. */
        if ((t = (long)dst & wmask) != 0) {
    80000d80:	00757713          	and	a4,a0,7
        dst = dst0;
    80000d84:	87aa                	mv	a5,a0
        if ((t = (long)dst & wmask) != 0) {
    80000d86:	c305                	beqz	a4,80000da6 <memset+0x32>
                t = wsize - t;
                length -= t;
    80000d88:	47a1                	li	a5,8
    80000d8a:	9f99                	subw	a5,a5,a4
    80000d8c:	1782                	sll	a5,a5,0x20
    80000d8e:	3661                	addw	a2,a2,-8 # ff8 <_entry-0x7ffff008>
    80000d90:	9381                	srl	a5,a5,0x20
    80000d92:	9e39                	addw	a2,a2,a4
                        *dst++ = VAL;
    80000d94:	0ff5f693          	zext.b	a3,a1
    80000d98:	97aa                	add	a5,a5,a0
        dst = dst0;
    80000d9a:	872a                	mv	a4,a0
                do {
                        *dst++ = VAL;
    80000d9c:	0705                	add	a4,a4,1 # fffffffffffff001 <end+0xffffffff7ffdce41>
    80000d9e:	fed70fa3          	sb	a3,-1(a4)
                } while (--t != 0);
    80000da2:	fef71de3          	bne	a4,a5,80000d9c <memset+0x28>
        }

        /* Fill words. Length was >= 2*words so we know t >= 1 here. */
        t = length / wsize;
    80000da6:	0036571b          	srlw	a4,a2,0x3
    80000daa:	070e                	sll	a4,a4,0x3
    80000dac:	973e                	add	a4,a4,a5
        do {
                *(u_long *)(void *)dst = WIDEVAL;
    80000dae:	0007b023          	sd	zero,0(a5)
                dst += wsize;
    80000db2:	07a1                	add	a5,a5,8
        } while (--t != 0);
    80000db4:	fee79de3          	bne	a5,a4,80000dae <memset+0x3a>

        /* Mop up trailing bytes, if any. */
        t = length & wmask;
    80000db8:	8a1d                	and	a2,a2,7
        if (t != 0)
    80000dba:	ca09                	beqz	a2,80000dcc <memset+0x58>
                        *dst++ = VAL;
    80000dbc:	0ff5f793          	zext.b	a5,a1
    80000dc0:	963a                	add	a2,a2,a4
                do {
                        *dst++ = VAL;
    80000dc2:	0705                	add	a4,a4,1
    80000dc4:	fef70fa3          	sb	a5,-1(a4)
                } while (--t != 0);
    80000dc8:	fec71de3          	bne	a4,a2,80000dc2 <memset+0x4e>

        RETURN;
}
    80000dcc:	6422                	ld	s0,8(sp)
    80000dce:	0141                	add	sp,sp,16
    80000dd0:	8082                	ret
                while (length != 0) {
    80000dd2:	de6d                	beqz	a2,80000dcc <memset+0x58>
    80000dd4:	1602                	sll	a2,a2,0x20
    80000dd6:	9201                	srl	a2,a2,0x20
                        *dst++ = VAL;
    80000dd8:	0ff5f713          	zext.b	a4,a1
    80000ddc:	962a                	add	a2,a2,a0
        dst = dst0;
    80000dde:	87aa                	mv	a5,a0
                        *dst++ = VAL;
    80000de0:	0785                	add	a5,a5,1
    80000de2:	fee78fa3          	sb	a4,-1(a5)
                while (length != 0) {
    80000de6:	fec79de3          	bne	a5,a2,80000de0 <memset+0x6c>
}
    80000dea:	6422                	ld	s0,8(sp)
    80000dec:	0141                	add	sp,sp,16
    80000dee:	8082                	ret

0000000080000df0 <memcmp>:
/*
 * Compare memory regions.
 */
int
memcmp(const void *s1, const void *s2, uint n)
{
    80000df0:	1141                	add	sp,sp,-16
    80000df2:	e422                	sd	s0,8(sp)
    80000df4:	0800                	add	s0,sp,16
	if (n != 0) {
    80000df6:	c60d                	beqz	a2,80000e20 <memcmp+0x30>
    80000df8:	1602                	sll	a2,a2,0x20
    80000dfa:	9201                	srl	a2,a2,0x20
    80000dfc:	00c50733          	add	a4,a0,a2
    80000e00:	a019                	j	80000e06 <memcmp+0x16>
		const unsigned char *p1 = s1, *p2 = s2;

		do {
			if (*p1++ != *p2++)
				return (*--p1 - *--p2);
		} while (--n != 0);
    80000e02:	00e50f63          	beq	a0,a4,80000e20 <memcmp+0x30>
			if (*p1++ != *p2++)
    80000e06:	00054783          	lbu	a5,0(a0)
    80000e0a:	0005c683          	lbu	a3,0(a1)
    80000e0e:	0505                	add	a0,a0,1
    80000e10:	0585                	add	a1,a1,1
    80000e12:	fed788e3          	beq	a5,a3,80000e02 <memcmp+0x12>
	}
	return (0);
}
    80000e16:	6422                	ld	s0,8(sp)
				return (*--p1 - *--p2);
    80000e18:	40d7853b          	subw	a0,a5,a3
}
    80000e1c:	0141                	add	sp,sp,16
    80000e1e:	8082                	ret
    80000e20:	6422                	ld	s0,8(sp)
	return (0);
    80000e22:	4501                	li	a0,0
}
    80000e24:	0141                	add	sp,sp,16
    80000e26:	8082                	ret

0000000080000e28 <memmove>:
/*
 * This is designed to be small, not fast.
 */
void *
memmove(void *s1, const void *s2, uint n)
{
    80000e28:	1141                	add	sp,sp,-16
    80000e2a:	e422                	sd	s0,8(sp)
    80000e2c:	0800                	add	s0,sp,16
		f += n;
		t += n;
		while (n-- > 0)
			*--t = *--f;
	} else
		while (n-- > 0)
    80000e2e:	fff6079b          	addw	a5,a2,-1
	if (f < t) {
    80000e32:	02a5e363          	bltu	a1,a0,80000e58 <memmove+0x30>
		while (n-- > 0)
    80000e36:	ce11                	beqz	a2,80000e52 <memmove+0x2a>
    80000e38:	1782                	sll	a5,a5,0x20
    80000e3a:	9381                	srl	a5,a5,0x20
    80000e3c:	0785                	add	a5,a5,1
    80000e3e:	97ae                	add	a5,a5,a1
	char *t = s1;
    80000e40:	872a                	mv	a4,a0
			*t++ = *f++;
    80000e42:	0005c683          	lbu	a3,0(a1)
    80000e46:	0585                	add	a1,a1,1
    80000e48:	0705                	add	a4,a4,1
    80000e4a:	fed70fa3          	sb	a3,-1(a4)
		while (n-- > 0)
    80000e4e:	feb79ae3          	bne	a5,a1,80000e42 <memmove+0x1a>
	return s1;
}
    80000e52:	6422                	ld	s0,8(sp)
    80000e54:	0141                	add	sp,sp,16
    80000e56:	8082                	ret
		f += n;
    80000e58:	02061713          	sll	a4,a2,0x20
    80000e5c:	9301                	srl	a4,a4,0x20
    80000e5e:	95ba                	add	a1,a1,a4
		t += n;
    80000e60:	972a                	add	a4,a4,a0
		while (n-- > 0)
    80000e62:	da65                	beqz	a2,80000e52 <memmove+0x2a>
    80000e64:	1782                	sll	a5,a5,0x20
    80000e66:	9381                	srl	a5,a5,0x20
    80000e68:	fff7c793          	not	a5,a5
    80000e6c:	97ae                	add	a5,a5,a1
			*--t = *--f;
    80000e6e:	fff5c683          	lbu	a3,-1(a1)
    80000e72:	15fd                	add	a1,a1,-1
    80000e74:	177d                	add	a4,a4,-1
    80000e76:	00d70023          	sb	a3,0(a4)
		while (n-- > 0)
    80000e7a:	feb79ae3          	bne	a5,a1,80000e6e <memmove+0x46>
}
    80000e7e:	6422                	ld	s0,8(sp)
    80000e80:	0141                	add	sp,sp,16
    80000e82:	8082                	ret

0000000080000e84 <memcpy>:
/*
 * This is designed to be small, not fast.
 */
void *
memcpy(void *s1, const void *s2, uint n)
{
    80000e84:	1141                	add	sp,sp,-16
    80000e86:	e422                	sd	s0,8(sp)
    80000e88:	0800                	add	s0,sp,16
	const char *f = s2;
	char *t = s1;

	while (n-- > 0)
    80000e8a:	c205                	beqz	a2,80000eaa <memcpy+0x26>
    80000e8c:	fff6069b          	addw	a3,a2,-1
    80000e90:	1682                	sll	a3,a3,0x20
    80000e92:	9281                	srl	a3,a3,0x20
    80000e94:	0685                	add	a3,a3,1
    80000e96:	96ae                	add	a3,a3,a1
	char *t = s1;
    80000e98:	87aa                	mv	a5,a0
		*t++ = *f++;
    80000e9a:	0005c703          	lbu	a4,0(a1)
    80000e9e:	0585                	add	a1,a1,1
    80000ea0:	0785                	add	a5,a5,1
    80000ea2:	fee78fa3          	sb	a4,-1(a5)
	while (n-- > 0)
    80000ea6:	fed59ae3          	bne	a1,a3,80000e9a <memcpy+0x16>
	return s1;
}
    80000eaa:	6422                	ld	s0,8(sp)
    80000eac:	0141                	add	sp,sp,16
    80000eae:	8082                	ret

0000000080000eb0 <strncmp>:

int
strncmp(const char *s1, const char *s2, uint n)
{
    80000eb0:	1141                	add	sp,sp,-16
    80000eb2:	e422                	sd	s0,8(sp)
    80000eb4:	0800                	add	s0,sp,16

	if (n == 0)
    80000eb6:	c615                	beqz	a2,80000ee2 <strncmp+0x32>
    80000eb8:	1602                	sll	a2,a2,0x20
    80000eba:	9201                	srl	a2,a2,0x20
    80000ebc:	00c506b3          	add	a3,a0,a2
    80000ec0:	a021                	j	80000ec8 <strncmp+0x18>
		return (0);
	do {
		if (*s1 != *s2++)
			return (*(unsigned char *)s1 - *(unsigned char *)--s2);
		if (*s1++ == 0)
    80000ec2:	c385                	beqz	a5,80000ee2 <strncmp+0x32>
			break;
	} while (--n != 0);
    80000ec4:	00d50f63          	beq	a0,a3,80000ee2 <strncmp+0x32>
		if (*s1 != *s2++)
    80000ec8:	00054783          	lbu	a5,0(a0)
    80000ecc:	0005c703          	lbu	a4,0(a1)
		if (*s1++ == 0)
    80000ed0:	0505                	add	a0,a0,1
		if (*s1 != *s2++)
    80000ed2:	0585                	add	a1,a1,1
    80000ed4:	fee787e3          	beq	a5,a4,80000ec2 <strncmp+0x12>
	return (0);
}
    80000ed8:	6422                	ld	s0,8(sp)
			return (*(unsigned char *)s1 - *(unsigned char *)--s2);
    80000eda:	40e7853b          	subw	a0,a5,a4
}
    80000ede:	0141                	add	sp,sp,16
    80000ee0:	8082                	ret
    80000ee2:	6422                	ld	s0,8(sp)
		return (0);
    80000ee4:	4501                	li	a0,0
}
    80000ee6:	0141                	add	sp,sp,16
    80000ee8:	8082                	ret

0000000080000eea <strncpy>:
 * Copy src to dst, truncating or null-padding to always copy n bytes.
 * Return dst.
 */
char *
strncpy(char *dst, const char *src, uint n)
{
    80000eea:	1141                	add	sp,sp,-16
    80000eec:	e422                	sd	s0,8(sp)
    80000eee:	0800                	add	s0,sp,16
	if (n != 0) {
    80000ef0:	ca05                	beqz	a2,80000f20 <strncpy+0x36>
		char *d = dst;
    80000ef2:	87aa                	mv	a5,a0
    80000ef4:	a011                	j	80000ef8 <strncpy+0xe>
				/* NUL pad the remaining n-1 bytes */
				while (--n != 0)
					*d++ = 0;
				break;
			}
		} while (--n != 0);
    80000ef6:	c60d                	beqz	a2,80000f20 <strncpy+0x36>
			if ((*d++ = *s++) == 0) {
    80000ef8:	0005c703          	lbu	a4,0(a1)
				while (--n != 0)
    80000efc:	fff6069b          	addw	a3,a2,-1
			if ((*d++ = *s++) == 0) {
    80000f00:	0585                	add	a1,a1,1
    80000f02:	00e78023          	sb	a4,0(a5)
				while (--n != 0)
    80000f06:	0006861b          	sext.w	a2,a3
			if ((*d++ = *s++) == 0) {
    80000f0a:	0785                	add	a5,a5,1
    80000f0c:	f76d                	bnez	a4,80000ef6 <strncpy+0xc>
				while (--n != 0)
    80000f0e:	ca09                	beqz	a2,80000f20 <strncpy+0x36>
    80000f10:	1682                	sll	a3,a3,0x20
    80000f12:	9281                	srl	a3,a3,0x20
    80000f14:	96be                	add	a3,a3,a5
					*d++ = 0;
    80000f16:	0785                	add	a5,a5,1
    80000f18:	fe078fa3          	sb	zero,-1(a5)
				while (--n != 0)
    80000f1c:	fed79de3          	bne	a5,a3,80000f16 <strncpy+0x2c>
	}
	return (dst);
}
    80000f20:	6422                	ld	s0,8(sp)
    80000f22:	0141                	add	sp,sp,16
    80000f24:	8082                	ret

0000000080000f26 <safestrcpy>:
 * chars will be copied.  Always NUL terminates (unless dsize == 0).
 * Returns strlen(src); if retval >= dsize, truncation occurred.
 */
uint
safestrcpy(char *dst, const char *src, uint dsize)
{
    80000f26:	1141                	add	sp,sp,-16
    80000f28:	e422                	sd	s0,8(sp)
    80000f2a:	0800                	add	s0,sp,16
    80000f2c:	87ae                	mv	a5,a1
	const char *osrc = src;
	uint nleft = dsize;

	/* Copy as many bytes as will fit. */
	if (nleft != 0) {
    80000f2e:	ea09                	bnez	a2,80000f40 <safestrcpy+0x1a>
    80000f30:	a821                	j	80000f48 <safestrcpy+0x22>
		while (--nleft != 0) {
			if ((*dst++ = *src++) == '\0')
    80000f32:	0007c703          	lbu	a4,0(a5)
    80000f36:	0505                	add	a0,a0,1
    80000f38:	0785                	add	a5,a5,1
    80000f3a:	fee50fa3          	sb	a4,-1(a0)
    80000f3e:	cb09                	beqz	a4,80000f50 <safestrcpy+0x2a>
		while (--nleft != 0) {
    80000f40:	367d                	addw	a2,a2,-1
    80000f42:	fa65                	bnez	a2,80000f32 <safestrcpy+0xc>
	}

	/* Not enough room in dst, add NUL and traverse rest of src. */
	if (nleft == 0) {
		if (dsize != 0)
			*dst = '\0';		/* NUL-terminate dst */
    80000f44:	00050023          	sb	zero,0(a0)
		while (*src++)
    80000f48:	0007c703          	lbu	a4,0(a5)
    80000f4c:	0785                	add	a5,a5,1
    80000f4e:	ff6d                	bnez	a4,80000f48 <safestrcpy+0x22>
			;
	}

	return(src - osrc - 1);	/* count does not include NUL */
}
    80000f50:	6422                	ld	s0,8(sp)
	return(src - osrc - 1);	/* count does not include NUL */
    80000f52:	40b78533          	sub	a0,a5,a1
}
    80000f56:	357d                	addw	a0,a0,-1
    80000f58:	0141                	add	sp,sp,16
    80000f5a:	8082                	ret

0000000080000f5c <strlen>:

uint
strlen(const char *str)
{
    80000f5c:	1141                	add	sp,sp,-16
    80000f5e:	e422                	sd	s0,8(sp)
    80000f60:	0800                	add	s0,sp,16
	const char *s = nullptr;

	for (s = str; *s; ++s)
    80000f62:	00054783          	lbu	a5,0(a0)
    80000f66:	cb99                	beqz	a5,80000f7c <strlen+0x20>
    80000f68:	87aa                	mv	a5,a0
    80000f6a:	0017c703          	lbu	a4,1(a5)
    80000f6e:	0785                	add	a5,a5,1
    80000f70:	ff6d                	bnez	a4,80000f6a <strlen+0xe>
		;
	return (s - str);
}
    80000f72:	6422                	ld	s0,8(sp)
	return (s - str);
    80000f74:	40a7853b          	subw	a0,a5,a0
}
    80000f78:	0141                	add	sp,sp,16
    80000f7a:	8082                	ret
    80000f7c:	6422                	ld	s0,8(sp)
	for (s = str; *s; ++s)
    80000f7e:	4501                	li	a0,0
}
    80000f80:	0141                	add	sp,sp,16
    80000f82:	8082                	ret

0000000080000f84 <main>:
/*
 * start() jumps here in supervisor mode on all CPUs.
 */
int
main(void) 
{
    80000f84:	1101                	add	sp,sp,-32
    80000f86:	e822                	sd	s0,16(sp)
    80000f88:	e426                	sd	s1,8(sp)
    80000f8a:	ec06                	sd	ra,24(sp)
    80000f8c:	1000                	add	s0,sp,32
	if (cpuid() == 0) {
    80000f8e:	00001097          	auipc	ra,0x1
    80000f92:	e36080e7          	jalr	-458(ra) # 80001dc4 <cpuid>
    80000f96:	00008497          	auipc	s1,0x8
    80000f9a:	d9248493          	add	s1,s1,-622 # 80008d28 <started>
    80000f9e:	c131                	beqz	a0,80000fe2 <main+0x5e>
                virtio_disk_init();     /* emulated hard disk*/
                userinit();     /* first user process */
                __sync_synchronize();
                started = 1;
	} else {
		while (started == 0)
    80000fa0:	409c                	lw	a5,0(s1)
    80000fa2:	dffd                	beqz	a5,80000fa0 <main+0x1c>
			;
		__sync_synchronize();
    80000fa4:	0ff0000f          	fence
		printf("hart %d starting\n", cpuid());
    80000fa8:	00001097          	auipc	ra,0x1
    80000fac:	e1c080e7          	jalr	-484(ra) # 80001dc4 <cpuid>
    80000fb0:	85aa                	mv	a1,a0
    80000fb2:	00007517          	auipc	a0,0x7
    80000fb6:	53650513          	add	a0,a0,1334 # 800084e8 <etext+0x4e8>
    80000fba:	fffff097          	auipc	ra,0xfffff
    80000fbe:	626080e7          	jalr	1574(ra) # 800005e0 <printf>
		kvminithart();  /* turn on paging */
    80000fc2:	00000097          	auipc	ra,0x0
    80000fc6:	152080e7          	jalr	338(ra) # 80001114 <kvminithart>
                trapinithart(); /* install kernel trap vector */
    80000fca:	00002097          	auipc	ra,0x2
    80000fce:	b94080e7          	jalr	-1132(ra) # 80002b5e <trapinithart>
                plicinithart(); /* ask PLIC for device interrupts */
    80000fd2:	00005097          	auipc	ra,0x5
    80000fd6:	5d2080e7          	jalr	1490(ra) # 800065a4 <plicinithart>
        }

		scheduler();
    80000fda:	00001097          	auipc	ra,0x1
    80000fde:	2b2080e7          	jalr	690(ra) # 8000228c <scheduler>
		consoleinit();
    80000fe2:	fffff097          	auipc	ra,0xfffff
    80000fe6:	4d2080e7          	jalr	1234(ra) # 800004b4 <consoleinit>
		printfinit();
    80000fea:	fffff097          	auipc	ra,0xfffff
    80000fee:	7d8080e7          	jalr	2008(ra) # 800007c2 <printfinit>
		printf("\n");
    80000ff2:	00007517          	auipc	a0,0x7
    80000ff6:	02e50513          	add	a0,a0,46 # 80008020 <etext+0x20>
    80000ffa:	fffff097          	auipc	ra,0xfffff
    80000ffe:	5e6080e7          	jalr	1510(ra) # 800005e0 <printf>
		printf("xv6 kernel is booting\n");
    80001002:	00007517          	auipc	a0,0x7
    80001006:	08e50513          	add	a0,a0,142 # 80008090 <etext+0x90>
    8000100a:	fffff097          	auipc	ra,0xfffff
    8000100e:	5d6080e7          	jalr	1494(ra) # 800005e0 <printf>
		printf("    ________  ________ _____ _____      _                   _                                _____          _   _ _         _       \n");
    80001012:	00007517          	auipc	a0,0x7
    80001016:	09650513          	add	a0,a0,150 # 800080a8 <etext+0xa8>
    8000101a:	fffff097          	auipc	ra,0xfffff
    8000101e:	5c6080e7          	jalr	1478(ra) # 800005e0 <printf>
		printf("   |_   _|  \\/  /  __ \\_   _|_   _|    | |                 | |                              |_   _|        | | (_) |       | |      \n");
    80001022:	00007517          	auipc	a0,0x7
    80001026:	10e50513          	add	a0,a0,270 # 80008130 <etext+0x130>
    8000102a:	fffff097          	auipc	ra,0xfffff
    8000102e:	5b6080e7          	jalr	1462(ra) # 800005e0 <printf>
		printf("     | | | .  . | /  \\/ | |   | |______| |     _____      _| |     __ _ _   _  ___ _ __ ______| | _ __  ___| |_ _| |_ _   _| |_ ___ \n");
    80001032:	00007517          	auipc	a0,0x7
    80001036:	18650513          	add	a0,a0,390 # 800081b8 <etext+0x1b8>
    8000103a:	fffff097          	auipc	ra,0xfffff
    8000103e:	5a6080e7          	jalr	1446(ra) # 800005e0 <printf>
		printf("     | | | |\\/| | |     | |   | |______| |    / _ \\ \\ /\\ / / |    / _` | | | |/ _ \\ '__|______| || '_ \\/ __| __| | __| | | | __/ _ \\\n");
    80001042:	00007517          	auipc	a0,0x7
    80001046:	1fe50513          	add	a0,a0,510 # 80008240 <etext+0x240>
    8000104a:	fffff097          	auipc	ra,0xfffff
    8000104e:	596080e7          	jalr	1430(ra) # 800005e0 <printf>
		printf("     | | | |  | | \\__/\\_| |_  | |      | |___| (_) \\ V  V /| |___| (_| | |_| |  __/ |        _| || | | \\__ \\ |_| | |_| |_| | ||  __/\n");
    80001052:	00007517          	auipc	a0,0x7
    80001056:	27650513          	add	a0,a0,630 # 800082c8 <etext+0x2c8>
    8000105a:	fffff097          	auipc	ra,0xfffff
    8000105e:	586080e7          	jalr	1414(ra) # 800005e0 <printf>
		printf("     \\_/ \\_|  |_/\\____/\\___/  \\_/      \\_____/\\___/ \\_/\\_/ \\_____/\\__,_|\\__, |\\___/_|        \\___/_| |_|___/\\__|_|\\__|\\__,_|\\__\\___|\n");
    80001062:	00007517          	auipc	a0,0x7
    80001066:	2ee50513          	add	a0,a0,750 # 80008350 <etext+0x350>
    8000106a:	fffff097          	auipc	ra,0xfffff
    8000106e:	576080e7          	jalr	1398(ra) # 800005e0 <printf>
		printf("                                                                         __/ |                                                      \n");
    80001072:	00007517          	auipc	a0,0x7
    80001076:	36650513          	add	a0,a0,870 # 800083d8 <etext+0x3d8>
    8000107a:	fffff097          	auipc	ra,0xfffff
    8000107e:	566080e7          	jalr	1382(ra) # 800005e0 <printf>
		printf("                                                                        |___/                                                       \n");
    80001082:	00007517          	auipc	a0,0x7
    80001086:	3de50513          	add	a0,a0,990 # 80008460 <etext+0x460>
    8000108a:	fffff097          	auipc	ra,0xfffff
    8000108e:	556080e7          	jalr	1366(ra) # 800005e0 <printf>
                printf("\n");
    80001092:	00007517          	auipc	a0,0x7
    80001096:	f8e50513          	add	a0,a0,-114 # 80008020 <etext+0x20>
    8000109a:	fffff097          	auipc	ra,0xfffff
    8000109e:	546080e7          	jalr	1350(ra) # 800005e0 <printf>
                kinit();        /* physical page allocator */
    800010a2:	00000097          	auipc	ra,0x0
    800010a6:	a66080e7          	jalr	-1434(ra) # 80000b08 <kinit>
                kvminit();      /* create kernel page table */
    800010aa:	00000097          	auipc	ra,0x0
    800010ae:	3fe080e7          	jalr	1022(ra) # 800014a8 <kvminit>
                kvminithart();  /* turn on paging */
    800010b2:	00000097          	auipc	ra,0x0
    800010b6:	062080e7          	jalr	98(ra) # 80001114 <kvminithart>
                procinit();     /* process table */
    800010ba:	00001097          	auipc	ra,0x1
    800010be:	c46080e7          	jalr	-954(ra) # 80001d00 <procinit>
                trapinit();     /* trap vectors */
    800010c2:	00002097          	auipc	ra,0x2
    800010c6:	a7a080e7          	jalr	-1414(ra) # 80002b3c <trapinit>
                trapinithart(); /* install kernel trap vector */
    800010ca:	00002097          	auipc	ra,0x2
    800010ce:	a94080e7          	jalr	-1388(ra) # 80002b5e <trapinithart>
                plicinit();     /* set up interrupt controller */
    800010d2:	00005097          	auipc	ra,0x5
    800010d6:	4b8080e7          	jalr	1208(ra) # 8000658a <plicinit>
                plicinithart(); /* ask PLIC for device interrupts */
    800010da:	00005097          	auipc	ra,0x5
    800010de:	4ca080e7          	jalr	1226(ra) # 800065a4 <plicinithart>
                binit();        /* buffer cache */
    800010e2:	00002097          	auipc	ra,0x2
    800010e6:	396080e7          	jalr	918(ra) # 80003478 <binit>
                iinit();        /* inode table */
    800010ea:	00003097          	auipc	ra,0x3
    800010ee:	a50080e7          	jalr	-1456(ra) # 80003b3a <iinit>
                fileinit();     /* file table */
    800010f2:	00004097          	auipc	ra,0x4
    800010f6:	aa4080e7          	jalr	-1372(ra) # 80004b96 <fileinit>
                virtio_disk_init();     /* emulated hard disk*/
    800010fa:	00005097          	auipc	ra,0x5
    800010fe:	59a080e7          	jalr	1434(ra) # 80006694 <virtio_disk_init>
                userinit();     /* first user process */
    80001102:	00001097          	auipc	ra,0x1
    80001106:	f40080e7          	jalr	-192(ra) # 80002042 <userinit>
                __sync_synchronize();
    8000110a:	0ff0000f          	fence
                started = 1;
    8000110e:	4785                	li	a5,1
    80001110:	c09c                	sw	a5,0(s1)
    80001112:	b5e1                	j	80000fda <main+0x56>

0000000080001114 <kvminithart>:
 * Switch h/w page table register to the kernel's page table,
 * and enable paging.
 */
void
kvminithart()
{
    80001114:	1141                	add	sp,sp,-16
    80001116:	e422                	sd	s0,8(sp)
    80001118:	0800                	add	s0,sp,16
sfence_vma()
{
  /*
   * the zero, zero means flush all TLB entries.
   */
  __asm__ __volatile__("sfence.vma zero, zero");
    8000111a:	12000073          	sfence.vma
        /* wait for any previous writes to the page table memory to finish. */
        sfence_vma();

        w_satp(MAKE_SATP(kernel_pagetable));
    8000111e:	00008797          	auipc	a5,0x8
    80001122:	c127b783          	ld	a5,-1006(a5) # 80008d30 <kernel_pagetable>
    80001126:	577d                	li	a4,-1
    80001128:	177e                	sll	a4,a4,0x3f
    8000112a:	83b1                	srl	a5,a5,0xc
    8000112c:	8fd9                	or	a5,a5,a4
  __asm__ volatile("csrw satp, %0" : : "r" (x));
    8000112e:	18079073          	csrw	satp,a5
  __asm__ __volatile__("sfence.vma zero, zero");
    80001132:	12000073          	sfence.vma

        /* flush stale entries from the TLB. */
        sfence_vma();
}
    80001136:	6422                	ld	s0,8(sp)
    80001138:	0141                	add	sp,sp,16
    8000113a:	8082                	ret

000000008000113c <walk>:
 *   12..20 -- 9 bits of level-0 index.
 *    0..11 -- 12 bits of byte offset within the page.
 */
pte_t *
walk(pagetable_t pagetable, uint64 va, int alloc)
{
    8000113c:	7139                	add	sp,sp,-64
    8000113e:	f822                	sd	s0,48(sp)
    80001140:	fc06                	sd	ra,56(sp)
    80001142:	f426                	sd	s1,40(sp)
    80001144:	f04a                	sd	s2,32(sp)
    80001146:	ec4e                	sd	s3,24(sp)
    80001148:	e852                	sd	s4,16(sp)
    8000114a:	e456                	sd	s5,8(sp)
    8000114c:	e05a                	sd	s6,0(sp)
    8000114e:	0080                	add	s0,sp,64
        if(va >= MAXVA)
    80001150:	577d                	li	a4,-1
    80001152:	8369                	srl	a4,a4,0x1a
    80001154:	08b76963          	bltu	a4,a1,800011e6 <walk+0xaa>
    80001158:	8aae                	mv	s5,a1
    8000115a:	892a                	mv	s2,a0
    8000115c:	89b2                	mv	s3,a2
    8000115e:	4b09                	li	s6,2
    80001160:	4789                	li	a5,2
    80001162:	4a05                	li	s4,1
                panic("walk");

        for(int level = 2; level > 0; level--) {
                pte_t *pte = &pagetable[PX(level, va)];
    80001164:	0037949b          	sllw	s1,a5,0x3
    80001168:	9cbd                	addw	s1,s1,a5
    8000116a:	24b1                	addw	s1,s1,12
    8000116c:	009ad4b3          	srl	s1,s5,s1
    80001170:	1ff4f493          	and	s1,s1,511
    80001174:	048e                	sll	s1,s1,0x3
    80001176:	94ca                	add	s1,s1,s2
                if(*pte & PTE_V) {
    80001178:	0004b903          	ld	s2,0(s1)
    8000117c:	00197793          	and	a5,s2,1
    80001180:	cb89                	beqz	a5,80001192 <walk+0x56>
                        pagetable = (pagetable_t)PTE2PA(*pte);
    80001182:	00a95913          	srl	s2,s2,0xa
    80001186:	0932                	sll	s2,s2,0xc
        for(int level = 2; level > 0; level--) {
    80001188:	4785                	li	a5,1
    8000118a:	034b0b63          	beq	s6,s4,800011c0 <walk+0x84>
    8000118e:	4b05                	li	s6,1
    80001190:	bfd1                	j	80001164 <walk+0x28>
                } else {
                        if(!alloc || (pagetable = (pde_t*)kalloc()) == 0)
    80001192:	04098863          	beqz	s3,800011e2 <walk+0xa6>
    80001196:	00000097          	auipc	ra,0x0
    8000119a:	9d0080e7          	jalr	-1584(ra) # 80000b66 <kalloc>
    8000119e:	892a                	mv	s2,a0
    800011a0:	c129                	beqz	a0,800011e2 <walk+0xa6>
                                return 0;
                        memset(pagetable, 0, PGSIZE);
    800011a2:	6605                	lui	a2,0x1
    800011a4:	4581                	li	a1,0
    800011a6:	00000097          	auipc	ra,0x0
    800011aa:	bce080e7          	jalr	-1074(ra) # 80000d74 <memset>
                        *pte = PA2PTE(pagetable) | PTE_V;
    800011ae:	00c95793          	srl	a5,s2,0xc
    800011b2:	07aa                	sll	a5,a5,0xa
    800011b4:	0017e793          	or	a5,a5,1
    800011b8:	e09c                	sd	a5,0(s1)
        for(int level = 2; level > 0; level--) {
    800011ba:	4785                	li	a5,1
    800011bc:	fd4b19e3          	bne	s6,s4,8000118e <walk+0x52>
                }
        }
        return &pagetable[PX(0, va)];
    800011c0:	00cada93          	srl	s5,s5,0xc
    800011c4:	1ffafa93          	and	s5,s5,511
    800011c8:	0a8e                	sll	s5,s5,0x3
    800011ca:	01590533          	add	a0,s2,s5
}
    800011ce:	70e2                	ld	ra,56(sp)
    800011d0:	7442                	ld	s0,48(sp)
    800011d2:	74a2                	ld	s1,40(sp)
    800011d4:	7902                	ld	s2,32(sp)
    800011d6:	69e2                	ld	s3,24(sp)
    800011d8:	6a42                	ld	s4,16(sp)
    800011da:	6aa2                	ld	s5,8(sp)
    800011dc:	6b02                	ld	s6,0(sp)
    800011de:	6121                	add	sp,sp,64
    800011e0:	8082                	ret
                                return 0;
    800011e2:	4501                	li	a0,0
    800011e4:	b7ed                	j	800011ce <walk+0x92>
                panic("walk");
    800011e6:	00007517          	auipc	a0,0x7
    800011ea:	31a50513          	add	a0,a0,794 # 80008500 <etext+0x500>
    800011ee:	fffff097          	auipc	ra,0xfffff
    800011f2:	3a8080e7          	jalr	936(ra) # 80000596 <panic>

00000000800011f6 <uvmunmap.part.0>:
 * Remove npages of mappings starting from va. va must be
 * page-aligned. The mappings must exist.
 * Optionally free the physical memory.
 */
void
uvmunmap(pagetable_t pagetable, uint64 va, uint64 npages, int do_free)
    800011f6:	715d                	add	sp,sp,-80
    800011f8:	e0a2                	sd	s0,64(sp)
    800011fa:	f44e                	sd	s3,40(sp)
    800011fc:	e486                	sd	ra,72(sp)
    800011fe:	0880                	add	s0,sp,80
        pte_t *pte = nullptr;

        if((va % PGSIZE) != 0)
                panic("uvmunmap: not aligned");

        for(a = va; a < va + npages*PGSIZE; a += PGSIZE){
    80001200:	00c61993          	sll	s3,a2,0xc
    80001204:	99ae                	add	s3,s3,a1
    80001206:	0735f763          	bgeu	a1,s3,80001274 <uvmunmap.part.0+0x7e>
    8000120a:	f84a                	sd	s2,48(sp)
    8000120c:	f052                	sd	s4,32(sp)
    8000120e:	ec56                	sd	s5,24(sp)
    80001210:	e85a                	sd	s6,16(sp)
    80001212:	e45e                	sd	s7,8(sp)
    80001214:	fc26                	sd	s1,56(sp)
    80001216:	892e                	mv	s2,a1
    80001218:	8a2a                	mv	s4,a0
    8000121a:	8ab6                	mv	s5,a3
                if((pte = walk(pagetable, a, 0)) == 0)
                        panic("uvmunmap: walk");
                if((*pte & PTE_V) == 0)
                        panic("uvmunmap: not mapped");
                if(PTE_FLAGS(*pte) == PTE_V)
    8000121c:	4b85                	li	s7,1
        for(a = va; a < va + npages*PGSIZE; a += PGSIZE){
    8000121e:	6b05                	lui	s6,0x1
    80001220:	a031                	j	8000122c <uvmunmap.part.0+0x36>
                        panic("uvmunmap: not a leaf");
                if(do_free){
                        uint64 pa = PTE2PA(*pte);
                        kfree((void*)pa);
                }
                *pte = 0;
    80001222:	0004b023          	sd	zero,0(s1)
        for(a = va; a < va + npages*PGSIZE; a += PGSIZE){
    80001226:	995a                	add	s2,s2,s6
    80001228:	05397063          	bgeu	s2,s3,80001268 <uvmunmap.part.0+0x72>
                if((pte = walk(pagetable, a, 0)) == 0)
    8000122c:	4601                	li	a2,0
    8000122e:	85ca                	mv	a1,s2
    80001230:	8552                	mv	a0,s4
    80001232:	00000097          	auipc	ra,0x0
    80001236:	f0a080e7          	jalr	-246(ra) # 8000113c <walk>
    8000123a:	84aa                	mv	s1,a0
    8000123c:	c129                	beqz	a0,8000127e <uvmunmap.part.0+0x88>
                if((*pte & PTE_V) == 0)
    8000123e:	6108                	ld	a0,0(a0)
    80001240:	00157793          	and	a5,a0,1
    80001244:	cfa9                	beqz	a5,8000129e <uvmunmap.part.0+0xa8>
                if(PTE_FLAGS(*pte) == PTE_V)
    80001246:	3ff57793          	and	a5,a0,1023
    8000124a:	05778263          	beq	a5,s7,8000128e <uvmunmap.part.0+0x98>
                if(do_free){
    8000124e:	fc0a8ae3          	beqz	s5,80001222 <uvmunmap.part.0+0x2c>
                        uint64 pa = PTE2PA(*pte);
    80001252:	8129                	srl	a0,a0,0xa
                        kfree((void*)pa);
    80001254:	0532                	sll	a0,a0,0xc
    80001256:	fffff097          	auipc	ra,0xfffff
    8000125a:	7f2080e7          	jalr	2034(ra) # 80000a48 <kfree>
        for(a = va; a < va + npages*PGSIZE; a += PGSIZE){
    8000125e:	995a                	add	s2,s2,s6
                *pte = 0;
    80001260:	0004b023          	sd	zero,0(s1)
        for(a = va; a < va + npages*PGSIZE; a += PGSIZE){
    80001264:	fd3964e3          	bltu	s2,s3,8000122c <uvmunmap.part.0+0x36>
    80001268:	74e2                	ld	s1,56(sp)
    8000126a:	7942                	ld	s2,48(sp)
    8000126c:	7a02                	ld	s4,32(sp)
    8000126e:	6ae2                	ld	s5,24(sp)
    80001270:	6b42                	ld	s6,16(sp)
    80001272:	6ba2                	ld	s7,8(sp)
        }
}
    80001274:	60a6                	ld	ra,72(sp)
    80001276:	6406                	ld	s0,64(sp)
    80001278:	79a2                	ld	s3,40(sp)
    8000127a:	6161                	add	sp,sp,80
    8000127c:	8082                	ret
                        panic("uvmunmap: walk");
    8000127e:	00007517          	auipc	a0,0x7
    80001282:	28a50513          	add	a0,a0,650 # 80008508 <etext+0x508>
    80001286:	fffff097          	auipc	ra,0xfffff
    8000128a:	310080e7          	jalr	784(ra) # 80000596 <panic>
                        panic("uvmunmap: not a leaf");
    8000128e:	00007517          	auipc	a0,0x7
    80001292:	2a250513          	add	a0,a0,674 # 80008530 <etext+0x530>
    80001296:	fffff097          	auipc	ra,0xfffff
    8000129a:	300080e7          	jalr	768(ra) # 80000596 <panic>
                        panic("uvmunmap: not mapped");
    8000129e:	00007517          	auipc	a0,0x7
    800012a2:	27a50513          	add	a0,a0,634 # 80008518 <etext+0x518>
    800012a6:	fffff097          	auipc	ra,0xfffff
    800012aa:	2f0080e7          	jalr	752(ra) # 80000596 <panic>

00000000800012ae <walkaddr>:
        if(va >= MAXVA)
    800012ae:	57fd                	li	a5,-1
    800012b0:	83e9                	srl	a5,a5,0x1a
    800012b2:	00b7f463          	bgeu	a5,a1,800012ba <walkaddr+0xc>
                return 0;
    800012b6:	4501                	li	a0,0
}
    800012b8:	8082                	ret
{
    800012ba:	1141                	add	sp,sp,-16
    800012bc:	e022                	sd	s0,0(sp)
    800012be:	e406                	sd	ra,8(sp)
    800012c0:	0800                	add	s0,sp,16
        pte = walk(pagetable, va, 0);
    800012c2:	4601                	li	a2,0
    800012c4:	00000097          	auipc	ra,0x0
    800012c8:	e78080e7          	jalr	-392(ra) # 8000113c <walk>
        if(pte == 0)
    800012cc:	c519                	beqz	a0,800012da <walkaddr+0x2c>
        if((*pte & PTE_V) == 0)
    800012ce:	6108                	ld	a0,0(a0)
        if((*pte & PTE_U) == 0)
    800012d0:	47c5                	li	a5,17
    800012d2:	01157713          	and	a4,a0,17
    800012d6:	00f70763          	beq	a4,a5,800012e4 <walkaddr+0x36>
}
    800012da:	60a2                	ld	ra,8(sp)
    800012dc:	6402                	ld	s0,0(sp)
                return 0;
    800012de:	4501                	li	a0,0
}
    800012e0:	0141                	add	sp,sp,16
    800012e2:	8082                	ret
    800012e4:	60a2                	ld	ra,8(sp)
    800012e6:	6402                	ld	s0,0(sp)
        pa = PTE2PA(*pte);
    800012e8:	8129                	srl	a0,a0,0xa
    800012ea:	0532                	sll	a0,a0,0xc
}
    800012ec:	0141                	add	sp,sp,16
    800012ee:	8082                	ret

00000000800012f0 <mappages>:
{
    800012f0:	715d                	add	sp,sp,-80
    800012f2:	e0a2                	sd	s0,64(sp)
    800012f4:	e486                	sd	ra,72(sp)
    800012f6:	fc26                	sd	s1,56(sp)
    800012f8:	f84a                	sd	s2,48(sp)
    800012fa:	f44e                	sd	s3,40(sp)
    800012fc:	f052                	sd	s4,32(sp)
    800012fe:	ec56                	sd	s5,24(sp)
    80001300:	e85a                	sd	s6,16(sp)
    80001302:	e45e                	sd	s7,8(sp)
    80001304:	0880                	add	s0,sp,80
        if(size == 0)
    80001306:	ce25                	beqz	a2,8000137e <mappages+0x8e>
        a = PGROUNDDOWN(va);
    80001308:	77fd                	lui	a5,0xfffff
        last = PGROUNDDOWN(va + size - 1);
    8000130a:	fff58993          	add	s3,a1,-1
    8000130e:	99b2                	add	s3,s3,a2
        a = PGROUNDDOWN(va);
    80001310:	00f5fbb3          	and	s7,a1,a5
    80001314:	8a2a                	mv	s4,a0
    80001316:	8aba                	mv	s5,a4
        last = PGROUNDDOWN(va + size - 1);
    80001318:	00f9f9b3          	and	s3,s3,a5
    8000131c:	41768933          	sub	s2,a3,s7
                a += PGSIZE;
    80001320:	6b05                	lui	s6,0x1
    80001322:	a831                	j	8000133e <mappages+0x4e>
                if(*pte & PTE_V)
    80001324:	611c                	ld	a5,0(a0)
    80001326:	8b85                	and	a5,a5,1
    80001328:	e3b9                	bnez	a5,8000136e <mappages+0x7e>
                *pte = PA2PTE(pa) | perm | PTE_V;
    8000132a:	80b1                	srl	s1,s1,0xc
    8000132c:	04aa                	sll	s1,s1,0xa
    8000132e:	0154e4b3          	or	s1,s1,s5
    80001332:	0014e493          	or	s1,s1,1
    80001336:	e104                	sd	s1,0(a0)
                if(a == last)
    80001338:	033b8963          	beq	s7,s3,8000136a <mappages+0x7a>
                a += PGSIZE;
    8000133c:	9bda                	add	s7,s7,s6
                if((pte = walk(pagetable, a, 1)) == 0)
    8000133e:	4605                	li	a2,1
    80001340:	85de                	mv	a1,s7
    80001342:	8552                	mv	a0,s4
    80001344:	012b84b3          	add	s1,s7,s2
    80001348:	00000097          	auipc	ra,0x0
    8000134c:	df4080e7          	jalr	-524(ra) # 8000113c <walk>
    80001350:	f971                	bnez	a0,80001324 <mappages+0x34>
                        return -1;
    80001352:	557d                	li	a0,-1
}
    80001354:	60a6                	ld	ra,72(sp)
    80001356:	6406                	ld	s0,64(sp)
    80001358:	74e2                	ld	s1,56(sp)
    8000135a:	7942                	ld	s2,48(sp)
    8000135c:	79a2                	ld	s3,40(sp)
    8000135e:	7a02                	ld	s4,32(sp)
    80001360:	6ae2                	ld	s5,24(sp)
    80001362:	6b42                	ld	s6,16(sp)
    80001364:	6ba2                	ld	s7,8(sp)
    80001366:	6161                	add	sp,sp,80
    80001368:	8082                	ret
        return 0;
    8000136a:	4501                	li	a0,0
    8000136c:	b7e5                	j	80001354 <mappages+0x64>
                        panic("mappages: remap");
    8000136e:	00007517          	auipc	a0,0x7
    80001372:	1ea50513          	add	a0,a0,490 # 80008558 <etext+0x558>
    80001376:	fffff097          	auipc	ra,0xfffff
    8000137a:	220080e7          	jalr	544(ra) # 80000596 <panic>
                panic("mappages: size");
    8000137e:	00007517          	auipc	a0,0x7
    80001382:	1ca50513          	add	a0,a0,458 # 80008548 <etext+0x548>
    80001386:	fffff097          	auipc	ra,0xfffff
    8000138a:	210080e7          	jalr	528(ra) # 80000596 <panic>

000000008000138e <kvmmap>:
{
    8000138e:	1141                	add	sp,sp,-16
    80001390:	e022                	sd	s0,0(sp)
    80001392:	e406                	sd	ra,8(sp)
    80001394:	0800                	add	s0,sp,16
    80001396:	87b2                	mv	a5,a2
        if(mappages(kpgtbl, va, sz, pa, perm) != 0)
    80001398:	8636                	mv	a2,a3
    8000139a:	86be                	mv	a3,a5
    8000139c:	00000097          	auipc	ra,0x0
    800013a0:	f54080e7          	jalr	-172(ra) # 800012f0 <mappages>
    800013a4:	e509                	bnez	a0,800013ae <kvmmap+0x20>
}
    800013a6:	60a2                	ld	ra,8(sp)
    800013a8:	6402                	ld	s0,0(sp)
    800013aa:	0141                	add	sp,sp,16
    800013ac:	8082                	ret
                panic("kvmmap");
    800013ae:	00007517          	auipc	a0,0x7
    800013b2:	1ba50513          	add	a0,a0,442 # 80008568 <etext+0x568>
    800013b6:	fffff097          	auipc	ra,0xfffff
    800013ba:	1e0080e7          	jalr	480(ra) # 80000596 <panic>

00000000800013be <kvmmake>:
{
    800013be:	1101                	add	sp,sp,-32
    800013c0:	ec06                	sd	ra,24(sp)
    800013c2:	e822                	sd	s0,16(sp)
    800013c4:	e426                	sd	s1,8(sp)
    800013c6:	1000                	add	s0,sp,32
        kpgtbl = (pagetable_t) kalloc();
    800013c8:	fffff097          	auipc	ra,0xfffff
    800013cc:	79e080e7          	jalr	1950(ra) # 80000b66 <kalloc>
        memset(kpgtbl, 0, PGSIZE);
    800013d0:	6605                	lui	a2,0x1
    800013d2:	4581                	li	a1,0
        kpgtbl = (pagetable_t) kalloc();
    800013d4:	84aa                	mv	s1,a0
        memset(kpgtbl, 0, PGSIZE);
    800013d6:	00000097          	auipc	ra,0x0
    800013da:	99e080e7          	jalr	-1634(ra) # 80000d74 <memset>
        if(mappages(kpgtbl, va, sz, pa, perm) != 0)
    800013de:	4719                	li	a4,6
    800013e0:	100006b7          	lui	a3,0x10000
    800013e4:	6605                	lui	a2,0x1
    800013e6:	100005b7          	lui	a1,0x10000
    800013ea:	8526                	mv	a0,s1
    800013ec:	00000097          	auipc	ra,0x0
    800013f0:	f04080e7          	jalr	-252(ra) # 800012f0 <mappages>
    800013f4:	e155                	bnez	a0,80001498 <kvmmake+0xda>
    800013f6:	4719                	li	a4,6
    800013f8:	100016b7          	lui	a3,0x10001
    800013fc:	6605                	lui	a2,0x1
    800013fe:	100015b7          	lui	a1,0x10001
    80001402:	8526                	mv	a0,s1
    80001404:	00000097          	auipc	ra,0x0
    80001408:	eec080e7          	jalr	-276(ra) # 800012f0 <mappages>
    8000140c:	e551                	bnez	a0,80001498 <kvmmake+0xda>
    8000140e:	4719                	li	a4,6
    80001410:	0c0006b7          	lui	a3,0xc000
    80001414:	00400637          	lui	a2,0x400
    80001418:	0c0005b7          	lui	a1,0xc000
    8000141c:	8526                	mv	a0,s1
    8000141e:	00000097          	auipc	ra,0x0
    80001422:	ed2080e7          	jalr	-302(ra) # 800012f0 <mappages>
    80001426:	e92d                	bnez	a0,80001498 <kvmmake+0xda>
    80001428:	4685                	li	a3,1
    8000142a:	06fe                	sll	a3,a3,0x1f
    8000142c:	4729                	li	a4,10
    8000142e:	80007617          	auipc	a2,0x80007
    80001432:	bd260613          	add	a2,a2,-1070 # 8000 <_entry-0x7fff8000>
    80001436:	85b6                	mv	a1,a3
    80001438:	8526                	mv	a0,s1
    8000143a:	00000097          	auipc	ra,0x0
    8000143e:	eb6080e7          	jalr	-330(ra) # 800012f0 <mappages>
    80001442:	e939                	bnez	a0,80001498 <kvmmake+0xda>
        kvmmap(kpgtbl, (uint64)etext, (uint64)etext, PHYSTOP-(uint64)etext, PTE_R | PTE_W);
    80001444:	4645                	li	a2,17
        if(mappages(kpgtbl, va, sz, pa, perm) != 0)
    80001446:	00007697          	auipc	a3,0x7
    8000144a:	bba68693          	add	a3,a3,-1094 # 80008000 <etext>
        kvmmap(kpgtbl, (uint64)etext, (uint64)etext, PHYSTOP-(uint64)etext, PTE_R | PTE_W);
    8000144e:	066e                	sll	a2,a2,0x1b
        if(mappages(kpgtbl, va, sz, pa, perm) != 0)
    80001450:	4719                	li	a4,6
    80001452:	8e15                	sub	a2,a2,a3
    80001454:	85b6                	mv	a1,a3
    80001456:	8526                	mv	a0,s1
    80001458:	00000097          	auipc	ra,0x0
    8000145c:	e98080e7          	jalr	-360(ra) # 800012f0 <mappages>
    80001460:	ed05                	bnez	a0,80001498 <kvmmake+0xda>
    80001462:	040005b7          	lui	a1,0x4000
    80001466:	15fd                	add	a1,a1,-1 # 3ffffff <_entry-0x7c000001>
    80001468:	4729                	li	a4,10
    8000146a:	00006697          	auipc	a3,0x6
    8000146e:	b9668693          	add	a3,a3,-1130 # 80007000 <_trampoline>
    80001472:	6605                	lui	a2,0x1
    80001474:	05b2                	sll	a1,a1,0xc
    80001476:	8526                	mv	a0,s1
    80001478:	00000097          	auipc	ra,0x0
    8000147c:	e78080e7          	jalr	-392(ra) # 800012f0 <mappages>
    80001480:	ed01                	bnez	a0,80001498 <kvmmake+0xda>
        proc_mapstacks(kpgtbl);
    80001482:	8526                	mv	a0,s1
    80001484:	00000097          	auipc	ra,0x0
    80001488:	7d8080e7          	jalr	2008(ra) # 80001c5c <proc_mapstacks>
}
    8000148c:	60e2                	ld	ra,24(sp)
    8000148e:	6442                	ld	s0,16(sp)
    80001490:	8526                	mv	a0,s1
    80001492:	64a2                	ld	s1,8(sp)
    80001494:	6105                	add	sp,sp,32
    80001496:	8082                	ret
                panic("kvmmap");
    80001498:	00007517          	auipc	a0,0x7
    8000149c:	0d050513          	add	a0,a0,208 # 80008568 <etext+0x568>
    800014a0:	fffff097          	auipc	ra,0xfffff
    800014a4:	0f6080e7          	jalr	246(ra) # 80000596 <panic>

00000000800014a8 <kvminit>:
{
    800014a8:	1141                	add	sp,sp,-16
    800014aa:	e022                	sd	s0,0(sp)
    800014ac:	e406                	sd	ra,8(sp)
    800014ae:	0800                	add	s0,sp,16
        kernel_pagetable = kvmmake();
    800014b0:	00000097          	auipc	ra,0x0
    800014b4:	f0e080e7          	jalr	-242(ra) # 800013be <kvmmake>
}
    800014b8:	60a2                	ld	ra,8(sp)
    800014ba:	6402                	ld	s0,0(sp)
        kernel_pagetable = kvmmake();
    800014bc:	00008797          	auipc	a5,0x8
    800014c0:	86a7ba23          	sd	a0,-1932(a5) # 80008d30 <kernel_pagetable>
}
    800014c4:	0141                	add	sp,sp,16
    800014c6:	8082                	ret

00000000800014c8 <uvmunmap>:
        if((va % PGSIZE) != 0)
    800014c8:	03459793          	sll	a5,a1,0x34
    800014cc:	e789                	bnez	a5,800014d6 <uvmunmap+0xe>
    800014ce:	00000317          	auipc	t1,0x0
    800014d2:	d2830067          	jr	-728(t1) # 800011f6 <uvmunmap.part.0>
{
    800014d6:	1141                	add	sp,sp,-16
    800014d8:	e022                	sd	s0,0(sp)
    800014da:	e406                	sd	ra,8(sp)
    800014dc:	0800                	add	s0,sp,16
                panic("uvmunmap: not aligned");
    800014de:	00007517          	auipc	a0,0x7
    800014e2:	09250513          	add	a0,a0,146 # 80008570 <etext+0x570>
    800014e6:	fffff097          	auipc	ra,0xfffff
    800014ea:	0b0080e7          	jalr	176(ra) # 80000596 <panic>

00000000800014ee <uvmcreate>:
 * create an empty user page table.
 * returns 0 if out of memory.
 */
pagetable_t
uvmcreate()
{
    800014ee:	1101                	add	sp,sp,-32
    800014f0:	e822                	sd	s0,16(sp)
    800014f2:	e426                	sd	s1,8(sp)
    800014f4:	ec06                	sd	ra,24(sp)
    800014f6:	1000                	add	s0,sp,32
        pagetable_t pagetable = nullptr;
        pagetable = (pagetable_t) kalloc();
    800014f8:	fffff097          	auipc	ra,0xfffff
    800014fc:	66e080e7          	jalr	1646(ra) # 80000b66 <kalloc>
    80001500:	84aa                	mv	s1,a0
        if(pagetable == 0)
    80001502:	c519                	beqz	a0,80001510 <uvmcreate+0x22>
                return 0;
        memset(pagetable, 0, PGSIZE);
    80001504:	6605                	lui	a2,0x1
    80001506:	4581                	li	a1,0
    80001508:	00000097          	auipc	ra,0x0
    8000150c:	86c080e7          	jalr	-1940(ra) # 80000d74 <memset>
        return pagetable;
}
    80001510:	60e2                	ld	ra,24(sp)
    80001512:	6442                	ld	s0,16(sp)
    80001514:	8526                	mv	a0,s1
    80001516:	64a2                	ld	s1,8(sp)
    80001518:	6105                	add	sp,sp,32
    8000151a:	8082                	ret

000000008000151c <uvmfirst>:
 * for the very first process.
 * sz must be less than a page.
 */
void
uvmfirst(pagetable_t pagetable, uchar *src, uint sz)
{
    8000151c:	7179                	add	sp,sp,-48
    8000151e:	f022                	sd	s0,32(sp)
    80001520:	f406                	sd	ra,40(sp)
    80001522:	ec26                	sd	s1,24(sp)
    80001524:	e84a                	sd	s2,16(sp)
    80001526:	e44e                	sd	s3,8(sp)
    80001528:	e052                	sd	s4,0(sp)
    8000152a:	1800                	add	s0,sp,48
        char *mem = nullptr;

        if(sz >= PGSIZE)
    8000152c:	6785                	lui	a5,0x1
    8000152e:	04f67763          	bgeu	a2,a5,8000157c <uvmfirst+0x60>
    80001532:	84b2                	mv	s1,a2
    80001534:	89ae                	mv	s3,a1
                panic("uvmfirst: more than a page");
        mem = kalloc();
    80001536:	8a2a                	mv	s4,a0
    80001538:	fffff097          	auipc	ra,0xfffff
    8000153c:	62e080e7          	jalr	1582(ra) # 80000b66 <kalloc>
        memset(mem, 0, PGSIZE);
    80001540:	6605                	lui	a2,0x1
    80001542:	4581                	li	a1,0
        mem = kalloc();
    80001544:	892a                	mv	s2,a0
        memset(mem, 0, PGSIZE);
    80001546:	00000097          	auipc	ra,0x0
    8000154a:	82e080e7          	jalr	-2002(ra) # 80000d74 <memset>
        mappages(pagetable, 0, PGSIZE, (uint64)mem, PTE_W|PTE_R|PTE_X|PTE_U);
    8000154e:	86ca                	mv	a3,s2
    80001550:	6605                	lui	a2,0x1
    80001552:	4581                	li	a1,0
    80001554:	8552                	mv	a0,s4
    80001556:	4779                	li	a4,30
    80001558:	00000097          	auipc	ra,0x0
    8000155c:	d98080e7          	jalr	-616(ra) # 800012f0 <mappages>
        memmove(mem, src, sz);
}
    80001560:	7402                	ld	s0,32(sp)
    80001562:	70a2                	ld	ra,40(sp)
    80001564:	6a02                	ld	s4,0(sp)
        memmove(mem, src, sz);
    80001566:	8626                	mv	a2,s1
    80001568:	85ce                	mv	a1,s3
}
    8000156a:	64e2                	ld	s1,24(sp)
    8000156c:	69a2                	ld	s3,8(sp)
        memmove(mem, src, sz);
    8000156e:	854a                	mv	a0,s2
}
    80001570:	6942                	ld	s2,16(sp)
    80001572:	6145                	add	sp,sp,48
        memmove(mem, src, sz);
    80001574:	00000317          	auipc	t1,0x0
    80001578:	8b430067          	jr	-1868(t1) # 80000e28 <memmove>
                panic("uvmfirst: more than a page");
    8000157c:	00007517          	auipc	a0,0x7
    80001580:	00c50513          	add	a0,a0,12 # 80008588 <etext+0x588>
    80001584:	fffff097          	auipc	ra,0xfffff
    80001588:	012080e7          	jalr	18(ra) # 80000596 <panic>

000000008000158c <uvmalloc>:
uvmalloc(pagetable_t pagetable, uint64 oldsz, uint64 newsz, int xperm)
{
        char *mem = nullptr;
        uint64 a = undefined;

        if(newsz < oldsz)
    8000158c:	08b66363          	bltu	a2,a1,80001612 <uvmalloc+0x86>
                return oldsz;

        oldsz = PGROUNDUP(oldsz);
    80001590:	6785                	lui	a5,0x1
{
    80001592:	7139                	add	sp,sp,-64
        oldsz = PGROUNDUP(oldsz);
    80001594:	17fd                	add	a5,a5,-1 # fff <_entry-0x7ffff001>
{
    80001596:	f822                	sd	s0,48(sp)
    80001598:	f04a                	sd	s2,32(sp)
    8000159a:	ec4e                	sd	s3,24(sp)
    8000159c:	e852                	sd	s4,16(sp)
    8000159e:	e456                	sd	s5,8(sp)
    800015a0:	e05a                	sd	s6,0(sp)
        oldsz = PGROUNDUP(oldsz);
    800015a2:	95be                	add	a1,a1,a5
{
    800015a4:	fc06                	sd	ra,56(sp)
    800015a6:	0080                	add	s0,sp,64
        oldsz = PGROUNDUP(oldsz);
    800015a8:	77fd                	lui	a5,0xfffff
    800015aa:	00f5fb33          	and	s6,a1,a5
{
    800015ae:	8ab2                	mv	s5,a2
    800015b0:	8a2a                	mv	s4,a0
        for(a = oldsz; a < newsz; a += PGSIZE){
    800015b2:	895a                	mv	s2,s6
                if(mem == 0){
                        uvmdealloc(pagetable, a, oldsz);
                        return 0;
                }
                memset(mem, 0, PGSIZE);
                if(mappages(pagetable, a, PGSIZE, (uint64)mem, PTE_R|PTE_U|xperm) != 0){
    800015b4:	0126e993          	or	s3,a3,18
        for(a = oldsz; a < newsz; a += PGSIZE){
    800015b8:	06cb7063          	bgeu	s6,a2,80001618 <uvmalloc+0x8c>
    800015bc:	f426                	sd	s1,40(sp)
    800015be:	a01d                	j	800015e4 <uvmalloc+0x58>
                memset(mem, 0, PGSIZE);
    800015c0:	fffff097          	auipc	ra,0xfffff
    800015c4:	7b4080e7          	jalr	1972(ra) # 80000d74 <memset>
                if(mappages(pagetable, a, PGSIZE, (uint64)mem, PTE_R|PTE_U|xperm) != 0){
    800015c8:	874e                	mv	a4,s3
    800015ca:	86a6                	mv	a3,s1
    800015cc:	6605                	lui	a2,0x1
    800015ce:	85ca                	mv	a1,s2
    800015d0:	8552                	mv	a0,s4
    800015d2:	00000097          	auipc	ra,0x0
    800015d6:	d1e080e7          	jalr	-738(ra) # 800012f0 <mappages>
    800015da:	e929                	bnez	a0,8000162c <uvmalloc+0xa0>
        for(a = oldsz; a < newsz; a += PGSIZE){
    800015dc:	6785                	lui	a5,0x1
    800015de:	993e                	add	s2,s2,a5
    800015e0:	03597b63          	bgeu	s2,s5,80001616 <uvmalloc+0x8a>
                mem = kalloc();
    800015e4:	fffff097          	auipc	ra,0xfffff
    800015e8:	582080e7          	jalr	1410(ra) # 80000b66 <kalloc>
                memset(mem, 0, PGSIZE);
    800015ec:	6605                	lui	a2,0x1
    800015ee:	4581                	li	a1,0
                mem = kalloc();
    800015f0:	84aa                	mv	s1,a0
                if(mem == 0){
    800015f2:	f579                	bnez	a0,800015c0 <uvmalloc+0x34>
 * process size.  Returns the new process size.
 */
uint64
uvmdealloc(pagetable_t pagetable, uint64 oldsz, uint64 newsz)
{
        if(newsz >= oldsz)
    800015f4:	012b7c63          	bgeu	s6,s2,8000160c <uvmalloc+0x80>
                return oldsz;

        if(PGROUNDUP(newsz) < PGROUNDUP(oldsz)){
    800015f8:	6785                	lui	a5,0x1
    800015fa:	17fd                	add	a5,a5,-1 # fff <_entry-0x7ffff001>
    800015fc:	777d                	lui	a4,0xfffff
    800015fe:	00fb05b3          	add	a1,s6,a5
    80001602:	97ca                	add	a5,a5,s2
    80001604:	8df9                	and	a1,a1,a4
    80001606:	8ff9                	and	a5,a5,a4
    80001608:	04f5ef63          	bltu	a1,a5,80001666 <uvmalloc+0xda>
    8000160c:	74a2                	ld	s1,40(sp)
                        return 0;
    8000160e:	4501                	li	a0,0
    80001610:	a029                	j	8000161a <uvmalloc+0x8e>
                return oldsz;
    80001612:	852e                	mv	a0,a1
}
    80001614:	8082                	ret
    80001616:	74a2                	ld	s1,40(sp)
        return newsz;
    80001618:	8556                	mv	a0,s5
}
    8000161a:	70e2                	ld	ra,56(sp)
    8000161c:	7442                	ld	s0,48(sp)
    8000161e:	7902                	ld	s2,32(sp)
    80001620:	69e2                	ld	s3,24(sp)
    80001622:	6a42                	ld	s4,16(sp)
    80001624:	6aa2                	ld	s5,8(sp)
    80001626:	6b02                	ld	s6,0(sp)
    80001628:	6121                	add	sp,sp,64
    8000162a:	8082                	ret
                        kfree(mem);
    8000162c:	8526                	mv	a0,s1
    8000162e:	fffff097          	auipc	ra,0xfffff
    80001632:	41a080e7          	jalr	1050(ra) # 80000a48 <kfree>
        if(newsz >= oldsz)
    80001636:	fd2b7be3          	bgeu	s6,s2,8000160c <uvmalloc+0x80>
        if(PGROUNDUP(newsz) < PGROUNDUP(oldsz)){
    8000163a:	6785                	lui	a5,0x1
    8000163c:	17fd                	add	a5,a5,-1 # fff <_entry-0x7ffff001>
    8000163e:	777d                	lui	a4,0xfffff
    80001640:	00fb05b3          	add	a1,s6,a5
    80001644:	993e                	add	s2,s2,a5
    80001646:	8df9                	and	a1,a1,a4
    80001648:	00e97933          	and	s2,s2,a4
    8000164c:	fd25f0e3          	bgeu	a1,s2,8000160c <uvmalloc+0x80>
                int npages = (PGROUNDUP(oldsz) - PGROUNDUP(newsz)) / PGSIZE;
    80001650:	40b90633          	sub	a2,s2,a1
    80001654:	8231                	srl	a2,a2,0xc
    80001656:	4685                	li	a3,1
    80001658:	2601                	sext.w	a2,a2
    8000165a:	8552                	mv	a0,s4
    8000165c:	00000097          	auipc	ra,0x0
    80001660:	b9a080e7          	jalr	-1126(ra) # 800011f6 <uvmunmap.part.0>
}
    80001664:	b765                	j	8000160c <uvmalloc+0x80>
                int npages = (PGROUNDUP(oldsz) - PGROUNDUP(newsz)) / PGSIZE;
    80001666:	8f8d                	sub	a5,a5,a1
    80001668:	00c7d613          	srl	a2,a5,0xc
    8000166c:	4685                	li	a3,1
    8000166e:	2601                	sext.w	a2,a2
    80001670:	8552                	mv	a0,s4
    80001672:	00000097          	auipc	ra,0x0
    80001676:	b84080e7          	jalr	-1148(ra) # 800011f6 <uvmunmap.part.0>
}
    8000167a:	bf49                	j	8000160c <uvmalloc+0x80>

000000008000167c <uvmdealloc>:
        if(newsz >= oldsz)
    8000167c:	04b67863          	bgeu	a2,a1,800016cc <uvmdealloc+0x50>
        if(PGROUNDUP(newsz) < PGROUNDUP(oldsz)){
    80001680:	6785                	lui	a5,0x1
{
    80001682:	1101                	add	sp,sp,-32
        if(PGROUNDUP(newsz) < PGROUNDUP(oldsz)){
    80001684:	17fd                	add	a5,a5,-1 # fff <_entry-0x7ffff001>
{
    80001686:	e822                	sd	s0,16(sp)
    80001688:	e426                	sd	s1,8(sp)
        if(PGROUNDUP(newsz) < PGROUNDUP(oldsz)){
    8000168a:	76fd                	lui	a3,0xfffff
    8000168c:	00f60733          	add	a4,a2,a5
{
    80001690:	ec06                	sd	ra,24(sp)
        if(PGROUNDUP(newsz) < PGROUNDUP(oldsz)){
    80001692:	97ae                	add	a5,a5,a1
{
    80001694:	1000                	add	s0,sp,32
        if(PGROUNDUP(newsz) < PGROUNDUP(oldsz)){
    80001696:	00d775b3          	and	a1,a4,a3
    8000169a:	8ff5                	and	a5,a5,a3
    8000169c:	84b2                	mv	s1,a2
    8000169e:	00f5e863          	bltu	a1,a5,800016ae <uvmdealloc+0x32>
                uvmunmap(pagetable, PGROUNDUP(newsz), npages, 1);
        }

        return newsz;
}
    800016a2:	60e2                	ld	ra,24(sp)
    800016a4:	6442                	ld	s0,16(sp)
                return oldsz;
    800016a6:	8526                	mv	a0,s1
}
    800016a8:	64a2                	ld	s1,8(sp)
    800016aa:	6105                	add	sp,sp,32
    800016ac:	8082                	ret
                int npages = (PGROUNDUP(oldsz) - PGROUNDUP(newsz)) / PGSIZE;
    800016ae:	8f8d                	sub	a5,a5,a1
    800016b0:	83b1                	srl	a5,a5,0xc
    800016b2:	4685                	li	a3,1
    800016b4:	0007861b          	sext.w	a2,a5
    800016b8:	00000097          	auipc	ra,0x0
    800016bc:	b3e080e7          	jalr	-1218(ra) # 800011f6 <uvmunmap.part.0>
}
    800016c0:	60e2                	ld	ra,24(sp)
    800016c2:	6442                	ld	s0,16(sp)
                return oldsz;
    800016c4:	8526                	mv	a0,s1
}
    800016c6:	64a2                	ld	s1,8(sp)
    800016c8:	6105                	add	sp,sp,32
    800016ca:	8082                	ret
                return oldsz;
    800016cc:	852e                	mv	a0,a1
}
    800016ce:	8082                	ret

00000000800016d0 <freewalk>:
 * Recursively free page-table pages.
 * All leaf mappings must already have been removed.
 */
void
freewalk(pagetable_t pagetable)
{
    800016d0:	7179                	add	sp,sp,-48
    800016d2:	f022                	sd	s0,32(sp)
    800016d4:	ec26                	sd	s1,24(sp)
    800016d6:	e84a                	sd	s2,16(sp)
    800016d8:	e44e                	sd	s3,8(sp)
    800016da:	e052                	sd	s4,0(sp)
    800016dc:	f406                	sd	ra,40(sp)
    800016de:	1800                	add	s0,sp,48
    800016e0:	6905                	lui	s2,0x1
    800016e2:	8a2a                	mv	s4,a0
    800016e4:	84aa                	mv	s1,a0
    800016e6:	992a                	add	s2,s2,a0
        /* there are 2^9 = 512 PTEs in a page table. */
        for(int i = 0; i < 512; i++){
                pte_t pte = pagetable[i];
                if((pte & PTE_V) && (pte & (PTE_R|PTE_W|PTE_X)) == 0){
    800016e8:	4985                	li	s3,1
    800016ea:	a031                	j	800016f6 <freewalk+0x26>
                        /* this PTE points to a lower-level page table. */
                        uint64 child = PTE2PA(pte);
                        freewalk((pagetable_t)child);
                        pagetable[i] = 0;
                } else if(pte & PTE_V){
    800016ec:	8b85                	and	a5,a5,1
    800016ee:	e3a9                	bnez	a5,80001730 <freewalk+0x60>
        for(int i = 0; i < 512; i++){
    800016f0:	04a1                	add	s1,s1,8
    800016f2:	03248363          	beq	s1,s2,80001718 <freewalk+0x48>
                pte_t pte = pagetable[i];
    800016f6:	609c                	ld	a5,0(s1)
                if((pte & PTE_V) && (pte & (PTE_R|PTE_W|PTE_X)) == 0){
    800016f8:	00f7f713          	and	a4,a5,15
    800016fc:	ff3718e3          	bne	a4,s3,800016ec <freewalk+0x1c>
                        uint64 child = PTE2PA(pte);
    80001700:	83a9                	srl	a5,a5,0xa
                        freewalk((pagetable_t)child);
    80001702:	00c79513          	sll	a0,a5,0xc
    80001706:	00000097          	auipc	ra,0x0
    8000170a:	fca080e7          	jalr	-54(ra) # 800016d0 <freewalk>
        for(int i = 0; i < 512; i++){
    8000170e:	04a1                	add	s1,s1,8
                        pagetable[i] = 0;
    80001710:	fe04bc23          	sd	zero,-8(s1)
        for(int i = 0; i < 512; i++){
    80001714:	ff2491e3          	bne	s1,s2,800016f6 <freewalk+0x26>
                        panic("freewalk: leaf");
                }
        }
        kfree((void*)pagetable);
}
    80001718:	7402                	ld	s0,32(sp)
    8000171a:	70a2                	ld	ra,40(sp)
    8000171c:	64e2                	ld	s1,24(sp)
    8000171e:	6942                	ld	s2,16(sp)
    80001720:	69a2                	ld	s3,8(sp)
        kfree((void*)pagetable);
    80001722:	8552                	mv	a0,s4
}
    80001724:	6a02                	ld	s4,0(sp)
    80001726:	6145                	add	sp,sp,48
        kfree((void*)pagetable);
    80001728:	fffff317          	auipc	t1,0xfffff
    8000172c:	32030067          	jr	800(t1) # 80000a48 <kfree>
                        panic("freewalk: leaf");
    80001730:	00007517          	auipc	a0,0x7
    80001734:	e7850513          	add	a0,a0,-392 # 800085a8 <etext+0x5a8>
    80001738:	fffff097          	auipc	ra,0xfffff
    8000173c:	e5e080e7          	jalr	-418(ra) # 80000596 <panic>

0000000080001740 <uvmfree>:
 * Free user memory pages,
 * then free page-table pages.
 */
void
uvmfree(pagetable_t pagetable, uint64 sz)
{
    80001740:	1101                	add	sp,sp,-32
    80001742:	e822                	sd	s0,16(sp)
    80001744:	e426                	sd	s1,8(sp)
    80001746:	ec06                	sd	ra,24(sp)
    80001748:	1000                	add	s0,sp,32
    8000174a:	84aa                	mv	s1,a0
        if(sz > 0)
    8000174c:	e991                	bnez	a1,80001760 <uvmfree+0x20>
                uvmunmap(pagetable, 0, PGROUNDUP(sz)/PGSIZE, 1);
        freewalk(pagetable);
}
    8000174e:	6442                	ld	s0,16(sp)
    80001750:	60e2                	ld	ra,24(sp)
        freewalk(pagetable);
    80001752:	8526                	mv	a0,s1
}
    80001754:	64a2                	ld	s1,8(sp)
    80001756:	6105                	add	sp,sp,32
        freewalk(pagetable);
    80001758:	00000317          	auipc	t1,0x0
    8000175c:	f7830067          	jr	-136(t1) # 800016d0 <freewalk>
                uvmunmap(pagetable, 0, PGROUNDUP(sz)/PGSIZE, 1);
    80001760:	6785                	lui	a5,0x1
    80001762:	17fd                	add	a5,a5,-1 # fff <_entry-0x7ffff001>
    80001764:	95be                	add	a1,a1,a5
    80001766:	00c5d613          	srl	a2,a1,0xc
    8000176a:	4685                	li	a3,1
    8000176c:	4581                	li	a1,0
    8000176e:	00000097          	auipc	ra,0x0
    80001772:	a88080e7          	jalr	-1400(ra) # 800011f6 <uvmunmap.part.0>
}
    80001776:	6442                	ld	s0,16(sp)
    80001778:	60e2                	ld	ra,24(sp)
        freewalk(pagetable);
    8000177a:	8526                	mv	a0,s1
}
    8000177c:	64a2                	ld	s1,8(sp)
    8000177e:	6105                	add	sp,sp,32
        freewalk(pagetable);
    80001780:	00000317          	auipc	t1,0x0
    80001784:	f5030067          	jr	-176(t1) # 800016d0 <freewalk>

0000000080001788 <uvmcopy>:
        pte_t *pte = nullptr;
        uint64 pa = undefined, i = undefined;
        uint flags = undefined;
        char *mem = nullptr;

        for(i = 0; i < sz; i += PGSIZE){
    80001788:	ca55                	beqz	a2,8000183c <uvmcopy+0xb4>
{
    8000178a:	715d                	add	sp,sp,-80
    8000178c:	e0a2                	sd	s0,64(sp)
    8000178e:	f44e                	sd	s3,40(sp)
    80001790:	f052                	sd	s4,32(sp)
    80001792:	ec56                	sd	s5,24(sp)
    80001794:	e85a                	sd	s6,16(sp)
    80001796:	e486                	sd	ra,72(sp)
    80001798:	fc26                	sd	s1,56(sp)
    8000179a:	f84a                	sd	s2,48(sp)
    8000179c:	e45e                	sd	s7,8(sp)
    8000179e:	0880                	add	s0,sp,80
    800017a0:	8a32                	mv	s4,a2
    800017a2:	8b2a                	mv	s6,a0
    800017a4:	8aae                	mv	s5,a1
    800017a6:	4981                	li	s3,0
    800017a8:	a02d                	j	800017d2 <uvmcopy+0x4a>
                        panic("uvmcopy: page not present");
                pa = PTE2PA(*pte);
                flags = PTE_FLAGS(*pte);
                if((mem = kalloc()) == 0)
                        goto err;
                memmove(mem, (char*)pa, PGSIZE);
    800017aa:	6605                	lui	a2,0x1
    800017ac:	85de                	mv	a1,s7
    800017ae:	fffff097          	auipc	ra,0xfffff
    800017b2:	67a080e7          	jalr	1658(ra) # 80000e28 <memmove>
                if(mappages(new, i, PGSIZE, (uint64)mem, flags) != 0){
    800017b6:	8726                	mv	a4,s1
    800017b8:	86ca                	mv	a3,s2
    800017ba:	6605                	lui	a2,0x1
    800017bc:	85ce                	mv	a1,s3
    800017be:	8556                	mv	a0,s5
    800017c0:	00000097          	auipc	ra,0x0
    800017c4:	b30080e7          	jalr	-1232(ra) # 800012f0 <mappages>
    800017c8:	e525                	bnez	a0,80001830 <uvmcopy+0xa8>
        for(i = 0; i < sz; i += PGSIZE){
    800017ca:	6785                	lui	a5,0x1
    800017cc:	99be                	add	s3,s3,a5
    800017ce:	0549ff63          	bgeu	s3,s4,8000182c <uvmcopy+0xa4>
                if((pte = walk(old, i, 0)) == 0)
    800017d2:	4601                	li	a2,0
    800017d4:	85ce                	mv	a1,s3
    800017d6:	855a                	mv	a0,s6
    800017d8:	00000097          	auipc	ra,0x0
    800017dc:	964080e7          	jalr	-1692(ra) # 8000113c <walk>
    800017e0:	c925                	beqz	a0,80001850 <uvmcopy+0xc8>
                if((*pte & PTE_V) == 0)
    800017e2:	6118                	ld	a4,0(a0)
    800017e4:	00177793          	and	a5,a4,1
    800017e8:	cfa1                	beqz	a5,80001840 <uvmcopy+0xb8>
                pa = PTE2PA(*pte);
    800017ea:	00a75593          	srl	a1,a4,0xa
    800017ee:	00c59b93          	sll	s7,a1,0xc
                flags = PTE_FLAGS(*pte);
    800017f2:	3ff77493          	and	s1,a4,1023
                if((mem = kalloc()) == 0)
    800017f6:	fffff097          	auipc	ra,0xfffff
    800017fa:	370080e7          	jalr	880(ra) # 80000b66 <kalloc>
    800017fe:	892a                	mv	s2,a0
    80001800:	f54d                	bnez	a0,800017aa <uvmcopy+0x22>
        if((va % PGSIZE) != 0)
    80001802:	8556                	mv	a0,s5
    80001804:	4685                	li	a3,1
    80001806:	00c9d613          	srl	a2,s3,0xc
    8000180a:	4581                	li	a1,0
    8000180c:	00000097          	auipc	ra,0x0
    80001810:	9ea080e7          	jalr	-1558(ra) # 800011f6 <uvmunmap.part.0>
        }
        return 0;

err:
        uvmunmap(new, 0, i / PGSIZE, 1);
        return -1;
    80001814:	557d                	li	a0,-1
}
    80001816:	60a6                	ld	ra,72(sp)
    80001818:	6406                	ld	s0,64(sp)
    8000181a:	74e2                	ld	s1,56(sp)
    8000181c:	7942                	ld	s2,48(sp)
    8000181e:	79a2                	ld	s3,40(sp)
    80001820:	7a02                	ld	s4,32(sp)
    80001822:	6ae2                	ld	s5,24(sp)
    80001824:	6b42                	ld	s6,16(sp)
    80001826:	6ba2                	ld	s7,8(sp)
    80001828:	6161                	add	sp,sp,80
    8000182a:	8082                	ret
        return 0;
    8000182c:	4501                	li	a0,0
    8000182e:	b7e5                	j	80001816 <uvmcopy+0x8e>
                        kfree(mem);
    80001830:	854a                	mv	a0,s2
    80001832:	fffff097          	auipc	ra,0xfffff
    80001836:	216080e7          	jalr	534(ra) # 80000a48 <kfree>
                        goto err;
    8000183a:	b7e1                	j	80001802 <uvmcopy+0x7a>
        return 0;
    8000183c:	4501                	li	a0,0
}
    8000183e:	8082                	ret
                        panic("uvmcopy: page not present");
    80001840:	00007517          	auipc	a0,0x7
    80001844:	d9850513          	add	a0,a0,-616 # 800085d8 <etext+0x5d8>
    80001848:	fffff097          	auipc	ra,0xfffff
    8000184c:	d4e080e7          	jalr	-690(ra) # 80000596 <panic>
                        panic("uvmcopy: pte should exist");
    80001850:	00007517          	auipc	a0,0x7
    80001854:	d6850513          	add	a0,a0,-664 # 800085b8 <etext+0x5b8>
    80001858:	fffff097          	auipc	ra,0xfffff
    8000185c:	d3e080e7          	jalr	-706(ra) # 80000596 <panic>

0000000080001860 <uvmclear>:
 * mark a PTE invalid for user access.
 * used by exec for the user stack guard page.
 */
void
uvmclear(pagetable_t pagetable, uint64 va)
{
    80001860:	1141                	add	sp,sp,-16
    80001862:	e022                	sd	s0,0(sp)
    80001864:	e406                	sd	ra,8(sp)
    80001866:	0800                	add	s0,sp,16
        if(va >= MAXVA)
    80001868:	57fd                	li	a5,-1
    8000186a:	83e9                	srl	a5,a5,0x1a
    8000186c:	04b7ed63          	bltu	a5,a1,800018c6 <uvmclear+0x66>
                pte_t *pte = &pagetable[PX(level, va)];
    80001870:	01e5d793          	srl	a5,a1,0x1e
                if(*pte & PTE_V) {
    80001874:	078e                	sll	a5,a5,0x3
    80001876:	953e                	add	a0,a0,a5
    80001878:	6118                	ld	a4,0(a0)
    8000187a:	00177793          	and	a5,a4,1
    8000187e:	cf85                	beqz	a5,800018b6 <uvmclear+0x56>
                pte_t *pte = &pagetable[PX(level, va)];
    80001880:	0155d793          	srl	a5,a1,0x15
                        pagetable = (pagetable_t)PTE2PA(*pte);
    80001884:	8329                	srl	a4,a4,0xa
                pte_t *pte = &pagetable[PX(level, va)];
    80001886:	1ff7f793          	and	a5,a5,511
                        pagetable = (pagetable_t)PTE2PA(*pte);
    8000188a:	0732                	sll	a4,a4,0xc
                if(*pte & PTE_V) {
    8000188c:	078e                	sll	a5,a5,0x3
    8000188e:	97ba                	add	a5,a5,a4
    80001890:	639c                	ld	a5,0(a5)
    80001892:	0017f713          	and	a4,a5,1
    80001896:	c305                	beqz	a4,800018b6 <uvmclear+0x56>
        return &pagetable[PX(0, va)];
    80001898:	81b1                	srl	a1,a1,0xc
                        pagetable = (pagetable_t)PTE2PA(*pte);
    8000189a:	83a9                	srl	a5,a5,0xa
        return &pagetable[PX(0, va)];
    8000189c:	1ff5f593          	and	a1,a1,511
                        pagetable = (pagetable_t)PTE2PA(*pte);
    800018a0:	07b2                	sll	a5,a5,0xc
        return &pagetable[PX(0, va)];
    800018a2:	058e                	sll	a1,a1,0x3
    800018a4:	97ae                	add	a5,a5,a1
        pte_t *pte = nullptr;

        pte = walk(pagetable, va, 0);
        if(pte == 0)
    800018a6:	cb81                	beqz	a5,800018b6 <uvmclear+0x56>
                panic("uvmclear");
        *pte &= ~PTE_U;
    800018a8:	6398                	ld	a4,0(a5)
}
    800018aa:	60a2                	ld	ra,8(sp)
    800018ac:	6402                	ld	s0,0(sp)
        *pte &= ~PTE_U;
    800018ae:	9b3d                	and	a4,a4,-17
    800018b0:	e398                	sd	a4,0(a5)
}
    800018b2:	0141                	add	sp,sp,16
    800018b4:	8082                	ret
                panic("uvmclear");
    800018b6:	00007517          	auipc	a0,0x7
    800018ba:	d4250513          	add	a0,a0,-702 # 800085f8 <etext+0x5f8>
    800018be:	fffff097          	auipc	ra,0xfffff
    800018c2:	cd8080e7          	jalr	-808(ra) # 80000596 <panic>
                panic("walk");
    800018c6:	00007517          	auipc	a0,0x7
    800018ca:	c3a50513          	add	a0,a0,-966 # 80008500 <etext+0x500>
    800018ce:	fffff097          	auipc	ra,0xfffff
    800018d2:	cc8080e7          	jalr	-824(ra) # 80000596 <panic>

00000000800018d6 <copyout>:
int
copyout(pagetable_t pagetable, uint64 dstva, char *src, uint64 len)
{
        uint64 n = undefined, va0 = undefined, pa0 = undefined;

        while(len > 0){
    800018d6:	c6e1                	beqz	a3,8000199e <copyout+0xc8>
{
    800018d8:	711d                	add	sp,sp,-96
    800018da:	e8a2                	sd	s0,80(sp)
    800018dc:	e4a6                	sd	s1,72(sp)
    800018de:	fc4e                	sd	s3,56(sp)
    800018e0:	f05a                	sd	s6,32(sp)
    800018e2:	ec86                	sd	ra,88(sp)
    800018e4:	1080                	add	s0,sp,96
                va0 = PGROUNDDOWN(dstva);
    800018e6:	79fd                	lui	s3,0xfffff
        if(va >= MAXVA)
    800018e8:	5b7d                	li	s6,-1
                va0 = PGROUNDDOWN(dstva);
    800018ea:	0135f9b3          	and	s3,a1,s3
        if(va >= MAXVA)
    800018ee:	01ab5b13          	srl	s6,s6,0x1a
    800018f2:	84ae                	mv	s1,a1
    800018f4:	013b7a63          	bgeu	s6,s3,80001908 <copyout+0x32>
                len -= n;
                src += n;
                dstva = va0 + PGSIZE;
        }
        return 0;
}
    800018f8:	60e6                	ld	ra,88(sp)
    800018fa:	6446                	ld	s0,80(sp)
    800018fc:	64a6                	ld	s1,72(sp)
    800018fe:	79e2                	ld	s3,56(sp)
    80001900:	7b02                	ld	s6,32(sp)
                        return -1;
    80001902:	557d                	li	a0,-1
}
    80001904:	6125                	add	sp,sp,96
    80001906:	8082                	ret
    80001908:	e0ca                	sd	s2,64(sp)
    8000190a:	f456                	sd	s5,40(sp)
    8000190c:	ec5e                	sd	s7,24(sp)
    8000190e:	e862                	sd	s8,16(sp)
    80001910:	e466                	sd	s9,8(sp)
    80001912:	f852                	sd	s4,48(sp)
    80001914:	8936                	mv	s2,a3
    80001916:	8baa                	mv	s7,a0
    80001918:	8ab2                	mv	s5,a2
        if((*pte & PTE_U) == 0)
    8000191a:	4cc5                	li	s9,17
    8000191c:	6c05                	lui	s8,0x1
        pte = walk(pagetable, va, 0);
    8000191e:	4601                	li	a2,0
    80001920:	85ce                	mv	a1,s3
    80001922:	855e                	mv	a0,s7
    80001924:	00000097          	auipc	ra,0x0
    80001928:	818080e7          	jalr	-2024(ra) # 8000113c <walk>
        if(pte == 0)
    8000192c:	c105                	beqz	a0,8000194c <copyout+0x76>
        if((*pte & PTE_V) == 0)
    8000192e:	611c                	ld	a5,0(a0)
        if((*pte & PTE_U) == 0)
    80001930:	01898a33          	add	s4,s3,s8
                memmove((void *)(pa0 + (dstva - va0)), src, n);
    80001934:	41348533          	sub	a0,s1,s3
        pa = PTE2PA(*pte);
    80001938:	00a7d713          	srl	a4,a5,0xa
    8000193c:	0732                	sll	a4,a4,0xc
        if((*pte & PTE_U) == 0)
    8000193e:	8bc5                	and	a5,a5,17
                memmove((void *)(pa0 + (dstva - va0)), src, n);
    80001940:	85d6                	mv	a1,s5
    80001942:	953a                	add	a0,a0,a4
                n = PGSIZE - (dstva - va0);
    80001944:	409a04b3          	sub	s1,s4,s1
        if((*pte & PTE_U) == 0)
    80001948:	01978963          	beq	a5,s9,8000195a <copyout+0x84>
    8000194c:	6906                	ld	s2,64(sp)
    8000194e:	7a42                	ld	s4,48(sp)
    80001950:	7aa2                	ld	s5,40(sp)
    80001952:	6be2                	ld	s7,24(sp)
    80001954:	6c42                	ld	s8,16(sp)
    80001956:	6ca2                	ld	s9,8(sp)
    80001958:	b745                	j	800018f8 <copyout+0x22>
                if(pa0 == 0)
    8000195a:	db6d                	beqz	a4,8000194c <copyout+0x76>
                if(n > len)
    8000195c:	00997363          	bgeu	s2,s1,80001962 <copyout+0x8c>
    80001960:	84ca                	mv	s1,s2
                memmove((void *)(pa0 + (dstva - va0)), src, n);
    80001962:	0004861b          	sext.w	a2,s1
                len -= n;
    80001966:	40990933          	sub	s2,s2,s1
                memmove((void *)(pa0 + (dstva - va0)), src, n);
    8000196a:	fffff097          	auipc	ra,0xfffff
    8000196e:	4be080e7          	jalr	1214(ra) # 80000e28 <memmove>
                src += n;
    80001972:	89d2                	mv	s3,s4
    80001974:	9aa6                	add	s5,s5,s1
        while(len > 0){
    80001976:	00090663          	beqz	s2,80001982 <copyout+0xac>
        if(va >= MAXVA)
    8000197a:	fd4b69e3          	bltu	s6,s4,8000194c <copyout+0x76>
    8000197e:	84ce                	mv	s1,s3
    80001980:	bf79                	j	8000191e <copyout+0x48>
}
    80001982:	60e6                	ld	ra,88(sp)
    80001984:	6446                	ld	s0,80(sp)
    80001986:	6906                	ld	s2,64(sp)
    80001988:	7a42                	ld	s4,48(sp)
    8000198a:	7aa2                	ld	s5,40(sp)
    8000198c:	6be2                	ld	s7,24(sp)
    8000198e:	6c42                	ld	s8,16(sp)
    80001990:	6ca2                	ld	s9,8(sp)
    80001992:	64a6                	ld	s1,72(sp)
    80001994:	79e2                	ld	s3,56(sp)
    80001996:	7b02                	ld	s6,32(sp)
        return 0;
    80001998:	4501                	li	a0,0
}
    8000199a:	6125                	add	sp,sp,96
    8000199c:	8082                	ret
        return 0;
    8000199e:	4501                	li	a0,0
}
    800019a0:	8082                	ret

00000000800019a2 <copyin>:
int
copyin(pagetable_t pagetable, char *dst, uint64 srcva, uint64 len)
{
        uint64 n = undefined, va0 = undefined, pa0 = undefined;

        while(len > 0){
    800019a2:	c6e1                	beqz	a3,80001a6a <copyin+0xc8>
{
    800019a4:	711d                	add	sp,sp,-96
    800019a6:	e8a2                	sd	s0,80(sp)
    800019a8:	e4a6                	sd	s1,72(sp)
    800019aa:	fc4e                	sd	s3,56(sp)
    800019ac:	f05a                	sd	s6,32(sp)
    800019ae:	ec86                	sd	ra,88(sp)
    800019b0:	1080                	add	s0,sp,96
                va0 = PGROUNDDOWN(srcva);
    800019b2:	79fd                	lui	s3,0xfffff
        if(va >= MAXVA)
    800019b4:	5b7d                	li	s6,-1
                va0 = PGROUNDDOWN(srcva);
    800019b6:	013679b3          	and	s3,a2,s3
        if(va >= MAXVA)
    800019ba:	01ab5b13          	srl	s6,s6,0x1a
    800019be:	84b2                	mv	s1,a2
    800019c0:	013b7a63          	bgeu	s6,s3,800019d4 <copyin+0x32>
                len -= n;
                dst += n;
                srcva = va0 + PGSIZE;
        }
        return 0;
}
    800019c4:	60e6                	ld	ra,88(sp)
    800019c6:	6446                	ld	s0,80(sp)
    800019c8:	64a6                	ld	s1,72(sp)
    800019ca:	79e2                	ld	s3,56(sp)
    800019cc:	7b02                	ld	s6,32(sp)
                        return -1;
    800019ce:	557d                	li	a0,-1
}
    800019d0:	6125                	add	sp,sp,96
    800019d2:	8082                	ret
    800019d4:	e0ca                	sd	s2,64(sp)
    800019d6:	f456                	sd	s5,40(sp)
    800019d8:	ec5e                	sd	s7,24(sp)
    800019da:	e862                	sd	s8,16(sp)
    800019dc:	e466                	sd	s9,8(sp)
    800019de:	f852                	sd	s4,48(sp)
    800019e0:	8936                	mv	s2,a3
    800019e2:	8baa                	mv	s7,a0
    800019e4:	8aae                	mv	s5,a1
        if((*pte & PTE_U) == 0)
    800019e6:	4cc5                	li	s9,17
    800019e8:	6c05                	lui	s8,0x1
        pte = walk(pagetable, va, 0);
    800019ea:	4601                	li	a2,0
    800019ec:	85ce                	mv	a1,s3
    800019ee:	855e                	mv	a0,s7
    800019f0:	fffff097          	auipc	ra,0xfffff
    800019f4:	74c080e7          	jalr	1868(ra) # 8000113c <walk>
        if(pte == 0)
    800019f8:	c105                	beqz	a0,80001a18 <copyin+0x76>
        if((*pte & PTE_V) == 0)
    800019fa:	611c                	ld	a5,0(a0)
                memmove(dst, (void *)(pa0 + (srcva - va0)), n);
    800019fc:	413485b3          	sub	a1,s1,s3
    80001a00:	01898a33          	add	s4,s3,s8
        pa = PTE2PA(*pte);
    80001a04:	00a7d713          	srl	a4,a5,0xa
    80001a08:	0732                	sll	a4,a4,0xc
        if((*pte & PTE_U) == 0)
    80001a0a:	8bc5                	and	a5,a5,17
                memmove(dst, (void *)(pa0 + (srcva - va0)), n);
    80001a0c:	8556                	mv	a0,s5
    80001a0e:	95ba                	add	a1,a1,a4
                n = PGSIZE - (srcva - va0);
    80001a10:	409a04b3          	sub	s1,s4,s1
        if((*pte & PTE_U) == 0)
    80001a14:	01978963          	beq	a5,s9,80001a26 <copyin+0x84>
    80001a18:	6906                	ld	s2,64(sp)
    80001a1a:	7a42                	ld	s4,48(sp)
    80001a1c:	7aa2                	ld	s5,40(sp)
    80001a1e:	6be2                	ld	s7,24(sp)
    80001a20:	6c42                	ld	s8,16(sp)
    80001a22:	6ca2                	ld	s9,8(sp)
    80001a24:	b745                	j	800019c4 <copyin+0x22>
                if(pa0 == 0)
    80001a26:	db6d                	beqz	a4,80001a18 <copyin+0x76>
                if(n > len)
    80001a28:	00997363          	bgeu	s2,s1,80001a2e <copyin+0x8c>
    80001a2c:	84ca                	mv	s1,s2
                memmove(dst, (void *)(pa0 + (srcva - va0)), n);
    80001a2e:	0004861b          	sext.w	a2,s1
                len -= n;
    80001a32:	40990933          	sub	s2,s2,s1
                memmove(dst, (void *)(pa0 + (srcva - va0)), n);
    80001a36:	fffff097          	auipc	ra,0xfffff
    80001a3a:	3f2080e7          	jalr	1010(ra) # 80000e28 <memmove>
                dst += n;
    80001a3e:	89d2                	mv	s3,s4
    80001a40:	9aa6                	add	s5,s5,s1
        while(len > 0){
    80001a42:	00090663          	beqz	s2,80001a4e <copyin+0xac>
        if(va >= MAXVA)
    80001a46:	fd4b69e3          	bltu	s6,s4,80001a18 <copyin+0x76>
    80001a4a:	84ce                	mv	s1,s3
    80001a4c:	bf79                	j	800019ea <copyin+0x48>
}
    80001a4e:	60e6                	ld	ra,88(sp)
    80001a50:	6446                	ld	s0,80(sp)
    80001a52:	6906                	ld	s2,64(sp)
    80001a54:	7a42                	ld	s4,48(sp)
    80001a56:	7aa2                	ld	s5,40(sp)
    80001a58:	6be2                	ld	s7,24(sp)
    80001a5a:	6c42                	ld	s8,16(sp)
    80001a5c:	6ca2                	ld	s9,8(sp)
    80001a5e:	64a6                	ld	s1,72(sp)
    80001a60:	79e2                	ld	s3,56(sp)
    80001a62:	7b02                	ld	s6,32(sp)
        return 0;
    80001a64:	4501                	li	a0,0
}
    80001a66:	6125                	add	sp,sp,96
    80001a68:	8082                	ret
        return 0;
    80001a6a:	4501                	li	a0,0
}
    80001a6c:	8082                	ret

0000000080001a6e <copyinstr>:
copyinstr(pagetable_t pagetable, char *dst, uint64 srcva, uint64 max)
{
        uint64 n = undefined, va0 = undefined, pa0 = undefined;
        int got_null = 0;

        while(got_null == 0 && max > 0){
    80001a6e:	c2fd                	beqz	a3,80001b54 <copyinstr+0xe6>
{
    80001a70:	715d                	add	sp,sp,-80
    80001a72:	e0a2                	sd	s0,64(sp)
    80001a74:	fc26                	sd	s1,56(sp)
    80001a76:	f84a                	sd	s2,48(sp)
    80001a78:	e85a                	sd	s6,16(sp)
    80001a7a:	e486                	sd	ra,72(sp)
    80001a7c:	0880                	add	s0,sp,80
                va0 = PGROUNDDOWN(srcva);
    80001a7e:	7b7d                	lui	s6,0xfffff
        if(va >= MAXVA)
    80001a80:	597d                	li	s2,-1
                va0 = PGROUNDDOWN(srcva);
    80001a82:	01667b33          	and	s6,a2,s6
        if(va >= MAXVA)
    80001a86:	01a95913          	srl	s2,s2,0x1a
    80001a8a:	84b2                	mv	s1,a2
    80001a8c:	01697a63          	bgeu	s2,s6,80001aa0 <copyinstr+0x32>
        if(got_null){
                return 0;
        } else {
                return -1;
        }
}
    80001a90:	60a6                	ld	ra,72(sp)
    80001a92:	6406                	ld	s0,64(sp)
    80001a94:	74e2                	ld	s1,56(sp)
    80001a96:	7942                	ld	s2,48(sp)
    80001a98:	6b42                	ld	s6,16(sp)
                        return -1;
    80001a9a:	557d                	li	a0,-1
}
    80001a9c:	6161                	add	sp,sp,80
    80001a9e:	8082                	ret
    80001aa0:	f44e                	sd	s3,40(sp)
    80001aa2:	f052                	sd	s4,32(sp)
    80001aa4:	ec56                	sd	s5,24(sp)
    80001aa6:	e45e                	sd	s7,8(sp)
    80001aa8:	e062                	sd	s8,0(sp)
    80001aaa:	8bb6                	mv	s7,a3
    80001aac:	89aa                	mv	s3,a0
    80001aae:	8aae                	mv	s5,a1
        if((*pte & PTE_U) == 0)
    80001ab0:	4a45                	li	s4,17
    80001ab2:	6c05                	lui	s8,0x1
        pte = walk(pagetable, va, 0);
    80001ab4:	4601                	li	a2,0
    80001ab6:	85da                	mv	a1,s6
    80001ab8:	854e                	mv	a0,s3
    80001aba:	fffff097          	auipc	ra,0xfffff
    80001abe:	682080e7          	jalr	1666(ra) # 8000113c <walk>
        if(pte == 0)
    80001ac2:	c511                	beqz	a0,80001ace <copyinstr+0x60>
        if((*pte & PTE_V) == 0)
    80001ac4:	611c                	ld	a5,0(a0)
        if((*pte & PTE_U) == 0)
    80001ac6:	0117f713          	and	a4,a5,17
    80001aca:	01470863          	beq	a4,s4,80001ada <copyinstr+0x6c>
    80001ace:	79a2                	ld	s3,40(sp)
    80001ad0:	7a02                	ld	s4,32(sp)
    80001ad2:	6ae2                	ld	s5,24(sp)
    80001ad4:	6ba2                	ld	s7,8(sp)
    80001ad6:	6c02                	ld	s8,0(sp)
    80001ad8:	bf65                	j	80001a90 <copyinstr+0x22>
        pa = PTE2PA(*pte);
    80001ada:	83a9                	srl	a5,a5,0xa
    80001adc:	07b2                	sll	a5,a5,0xc
                if(pa0 == 0)
    80001ade:	dbe5                	beqz	a5,80001ace <copyinstr+0x60>
                n = PGSIZE - (srcva - va0);
    80001ae0:	018b06b3          	add	a3,s6,s8
    80001ae4:	40968833          	sub	a6,a3,s1
                if(n > max)
    80001ae8:	010bf363          	bgeu	s7,a6,80001aee <copyinstr+0x80>
    80001aec:	885e                	mv	a6,s7
                char *p = (char *) (pa0 + (srcva - va0));
    80001aee:	416484b3          	sub	s1,s1,s6
    80001af2:	94be                	add	s1,s1,a5
                while(n > 0){
    80001af4:	87d6                	mv	a5,s5
    80001af6:	04080763          	beqz	a6,80001b44 <copyinstr+0xd6>
    80001afa:	41548633          	sub	a2,s1,s5
    80001afe:	9856                	add	a6,a6,s5
    80001b00:	a031                	j	80001b0c <copyinstr+0x9e>
                                *dst = *p;
    80001b02:	00e78023          	sb	a4,0(a5) # 1000 <_entry-0x7ffff000>
                        dst++;
    80001b06:	0785                	add	a5,a5,1
                while(n > 0){
    80001b08:	03078763          	beq	a5,a6,80001b36 <copyinstr+0xc8>
                        if(*p == '\0'){
    80001b0c:	00c78733          	add	a4,a5,a2
    80001b10:	00074703          	lbu	a4,0(a4) # fffffffffffff000 <end+0xffffffff7ffdce40>
    80001b14:	853e                	mv	a0,a5
    80001b16:	f775                	bnez	a4,80001b02 <copyinstr+0x94>
                                *dst = '\0';
    80001b18:	00078023          	sb	zero,0(a5)
    80001b1c:	4501                	li	a0,0
}
    80001b1e:	60a6                	ld	ra,72(sp)
    80001b20:	6406                	ld	s0,64(sp)
    80001b22:	79a2                	ld	s3,40(sp)
    80001b24:	7a02                	ld	s4,32(sp)
    80001b26:	6ae2                	ld	s5,24(sp)
    80001b28:	6ba2                	ld	s7,8(sp)
    80001b2a:	6c02                	ld	s8,0(sp)
    80001b2c:	74e2                	ld	s1,56(sp)
    80001b2e:	7942                	ld	s2,48(sp)
    80001b30:	6b42                	ld	s6,16(sp)
    80001b32:	6161                	add	sp,sp,80
    80001b34:	8082                	ret
    80001b36:	fffb8713          	add	a4,s7,-1
    80001b3a:	9756                	add	a4,a4,s5
                        --max;
    80001b3c:	40a70bb3          	sub	s7,a4,a0
        while(got_null == 0 && max > 0){
    80001b40:	00e50863          	beq	a0,a4,80001b50 <copyinstr+0xe2>
        if(va >= MAXVA)
    80001b44:	f8d965e3          	bltu	s2,a3,80001ace <copyinstr+0x60>
    80001b48:	8b36                	mv	s6,a3
    80001b4a:	84b6                	mv	s1,a3
    80001b4c:	8abe                	mv	s5,a5
    80001b4e:	b79d                	j	80001ab4 <copyinstr+0x46>
                                *dst = '\0';
    80001b50:	557d                	li	a0,-1
    80001b52:	b7f1                	j	80001b1e <copyinstr+0xb0>
    80001b54:	557d                	li	a0,-1
}
    80001b56:	8082                	ret

0000000080001b58 <forkret>:
 * A fork child's very first scheduling by scheduler()
 * will swtch to forkret.
 */
void
forkret(void)
{
    80001b58:	1101                	add	sp,sp,-32
    80001b5a:	e822                	sd	s0,16(sp)
    80001b5c:	ec06                	sd	ra,24(sp)
    80001b5e:	e426                	sd	s1,8(sp)
    80001b60:	1000                	add	s0,sp,32
	push_off();
    80001b62:	fffff097          	auipc	ra,0xfffff
    80001b66:	0b2080e7          	jalr	178(ra) # 80000c14 <push_off>
  __asm__ volatile("mv %0, tp" : "=r" (x) );
    80001b6a:	8792                	mv	a5,tp
	struct proc *p = c->proc;
    80001b6c:	2781                	sext.w	a5,a5
    80001b6e:	0000f717          	auipc	a4,0xf
    80001b72:	44270713          	add	a4,a4,1090 # 80010fb0 <cpus>
    80001b76:	079e                	sll	a5,a5,0x7
    80001b78:	97ba                	add	a5,a5,a4
    80001b7a:	6384                	ld	s1,0(a5)
	pop_off();
    80001b7c:	fffff097          	auipc	ra,0xfffff
    80001b80:	146080e7          	jalr	326(ra) # 80000cc2 <pop_off>
	static int first = 1;

	/* Still holding p->lock from scheduler. */
	release(&myproc()->lock);
    80001b84:	8526                	mv	a0,s1
    80001b86:	fffff097          	auipc	ra,0xfffff
    80001b8a:	19a080e7          	jalr	410(ra) # 80000d20 <release>

	if (first) {
    80001b8e:	00007797          	auipc	a5,0x7
    80001b92:	1327a783          	lw	a5,306(a5) # 80008cc0 <first.1>
    80001b96:	eb89                	bnez	a5,80001ba8 <forkret+0x50>
		 * cannot be run from main(). */
		first = 0;
		fsinit(ROOTDEV);
	}
	usertrapret();
}
    80001b98:	6442                	ld	s0,16(sp)
    80001b9a:	60e2                	ld	ra,24(sp)
    80001b9c:	64a2                	ld	s1,8(sp)
    80001b9e:	6105                	add	sp,sp,32
	usertrapret();
    80001ba0:	00001317          	auipc	t1,0x1
    80001ba4:	fd630067          	jr	-42(t1) # 80002b76 <usertrapret>
		fsinit(ROOTDEV);
    80001ba8:	4505                	li	a0,1
		first = 0;
    80001baa:	00007797          	auipc	a5,0x7
    80001bae:	1007ab23          	sw	zero,278(a5) # 80008cc0 <first.1>
		fsinit(ROOTDEV);
    80001bb2:	00002097          	auipc	ra,0x2
    80001bb6:	f10080e7          	jalr	-240(ra) # 80003ac2 <fsinit>
}
    80001bba:	6442                	ld	s0,16(sp)
    80001bbc:	60e2                	ld	ra,24(sp)
    80001bbe:	64a2                	ld	s1,8(sp)
    80001bc0:	6105                	add	sp,sp,32
	usertrapret();
    80001bc2:	00001317          	auipc	t1,0x1
    80001bc6:	fb430067          	jr	-76(t1) # 80002b76 <usertrapret>

0000000080001bca <freeproc>:
{
    80001bca:	7179                	add	sp,sp,-48
    80001bcc:	f022                	sd	s0,32(sp)
    80001bce:	ec26                	sd	s1,24(sp)
    80001bd0:	f406                	sd	ra,40(sp)
    80001bd2:	e84a                	sd	s2,16(sp)
    80001bd4:	1800                	add	s0,sp,48
    80001bd6:	84aa                	mv	s1,a0
	if (p->trapframe)
    80001bd8:	6d28                	ld	a0,88(a0)
    80001bda:	c509                	beqz	a0,80001be4 <freeproc+0x1a>
		kfree((void *)p->trapframe);
    80001bdc:	fffff097          	auipc	ra,0xfffff
    80001be0:	e6c080e7          	jalr	-404(ra) # 80000a48 <kfree>
	if (p->pagetable)
    80001be4:	0504b903          	ld	s2,80(s1)
	p->trapframe = 0;
    80001be8:	0404bc23          	sd	zero,88(s1)
	if (p->pagetable)
    80001bec:	04090263          	beqz	s2,80001c30 <freeproc+0x66>
	uvmunmap(pagetable, TRAMPOLINE, 1, 0);
    80001bf0:	040005b7          	lui	a1,0x4000
    80001bf4:	15fd                	add	a1,a1,-1 # 3ffffff <_entry-0x7c000001>
    80001bf6:	4681                	li	a3,0
    80001bf8:	4605                	li	a2,1
    80001bfa:	05b2                	sll	a1,a1,0xc
    80001bfc:	854a                	mv	a0,s2
    80001bfe:	e44e                	sd	s3,8(sp)
		proc_freepagetable(p->pagetable, p->sz);
    80001c00:	0484b983          	ld	s3,72(s1)
	uvmunmap(pagetable, TRAMPOLINE, 1, 0);
    80001c04:	00000097          	auipc	ra,0x0
    80001c08:	8c4080e7          	jalr	-1852(ra) # 800014c8 <uvmunmap>
	uvmunmap(pagetable, TRAPFRAME, 1, 0);
    80001c0c:	020005b7          	lui	a1,0x2000
    80001c10:	15fd                	add	a1,a1,-1 # 1ffffff <_entry-0x7e000001>
    80001c12:	4681                	li	a3,0
    80001c14:	4605                	li	a2,1
    80001c16:	05b6                	sll	a1,a1,0xd
    80001c18:	854a                	mv	a0,s2
    80001c1a:	00000097          	auipc	ra,0x0
    80001c1e:	8ae080e7          	jalr	-1874(ra) # 800014c8 <uvmunmap>
	uvmfree(pagetable, sz);
    80001c22:	85ce                	mv	a1,s3
    80001c24:	854a                	mv	a0,s2
    80001c26:	00000097          	auipc	ra,0x0
    80001c2a:	b1a080e7          	jalr	-1254(ra) # 80001740 <uvmfree>
    80001c2e:	69a2                	ld	s3,8(sp)
	p->name[0] = 0;
    80001c30:	14048c23          	sb	zero,344(s1)
}
    80001c34:	70a2                	ld	ra,40(sp)
    80001c36:	7402                	ld	s0,32(sp)
	p->pagetable = 0;
    80001c38:	0404b823          	sd	zero,80(s1)
	p->sz = 0;
    80001c3c:	0404b423          	sd	zero,72(s1)
	p->pid = 0;
    80001c40:	0204a823          	sw	zero,48(s1)
	p->parent = 0;
    80001c44:	0204bc23          	sd	zero,56(s1)
	p->chan = 0;
    80001c48:	0204b023          	sd	zero,32(s1)
	p->killed = 0;
    80001c4c:	0204b423          	sd	zero,40(s1)
	p->state = UNUSED;
    80001c50:	0004ac23          	sw	zero,24(s1)
}
    80001c54:	6942                	ld	s2,16(sp)
    80001c56:	64e2                	ld	s1,24(sp)
    80001c58:	6145                	add	sp,sp,48
    80001c5a:	8082                	ret

0000000080001c5c <proc_mapstacks>:
{
    80001c5c:	7139                	add	sp,sp,-64
    80001c5e:	f426                	sd	s1,40(sp)
		uint64 va = KSTACK((int)(p - proc));
    80001c60:	04fa54b7          	lui	s1,0x4fa5
    80001c64:	fa548493          	add	s1,s1,-91 # 4fa4fa5 <_entry-0x7b05b05b>
    80001c68:	04b2                	sll	s1,s1,0xc
    80001c6a:	fa548493          	add	s1,s1,-91
    80001c6e:	04b2                	sll	s1,s1,0xc
{
    80001c70:	f04a                	sd	s2,32(sp)
		uint64 va = KSTACK((int)(p - proc));
    80001c72:	fa548493          	add	s1,s1,-91
    80001c76:	04000937          	lui	s2,0x4000
{
    80001c7a:	f822                	sd	s0,48(sp)
    80001c7c:	ec4e                	sd	s3,24(sp)
    80001c7e:	e852                	sd	s4,16(sp)
    80001c80:	e456                	sd	s5,8(sp)
    80001c82:	e05a                	sd	s6,0(sp)
    80001c84:	fc06                	sd	ra,56(sp)
    80001c86:	0080                	add	s0,sp,64
	for (p = proc; p < &proc[NPROC]; p++) {
    80001c88:	0000fa17          	auipc	s4,0xf
    80001c8c:	758a0a13          	add	s4,s4,1880 # 800113e0 <proc>
		uint64 va = KSTACK((int)(p - proc));
    80001c90:	04b2                	sll	s1,s1,0xc
    80001c92:	197d                	add	s2,s2,-1 # 3ffffff <_entry-0x7c000001>
{
    80001c94:	89aa                	mv	s3,a0
	for (p = proc; p < &proc[NPROC]; p++) {
    80001c96:	8b52                	mv	s6,s4
		uint64 va = KSTACK((int)(p - proc));
    80001c98:	fa548493          	add	s1,s1,-91
    80001c9c:	0932                	sll	s2,s2,0xc
	for (p = proc; p < &proc[NPROC]; p++) {
    80001c9e:	00015a97          	auipc	s5,0x15
    80001ca2:	142a8a93          	add	s5,s5,322 # 80016de0 <tickslock>
		char *pa = kalloc();
    80001ca6:	fffff097          	auipc	ra,0xfffff
    80001caa:	ec0080e7          	jalr	-320(ra) # 80000b66 <kalloc>
    80001cae:	862a                	mv	a2,a0
		if (pa == 0)
    80001cb0:	c121                	beqz	a0,80001cf0 <proc_mapstacks+0x94>
		uint64 va = KSTACK((int)(p - proc));
    80001cb2:	414b05b3          	sub	a1,s6,s4
    80001cb6:	858d                	sra	a1,a1,0x3
    80001cb8:	029585b3          	mul	a1,a1,s1
		kvmmap(kpgtbl, va, (uint64) pa, PGSIZE, PTE_R | PTE_W);
    80001cbc:	4719                	li	a4,6
    80001cbe:	6685                	lui	a3,0x1
    80001cc0:	854e                	mv	a0,s3
	for (p = proc; p < &proc[NPROC]; p++) {
    80001cc2:	168b0b13          	add	s6,s6,360 # fffffffffffff168 <end+0xffffffff7ffdcfa8>
		uint64 va = KSTACK((int)(p - proc));
    80001cc6:	2585                	addw	a1,a1,1
    80001cc8:	00d5959b          	sllw	a1,a1,0xd
		kvmmap(kpgtbl, va, (uint64) pa, PGSIZE, PTE_R | PTE_W);
    80001ccc:	40b905b3          	sub	a1,s2,a1
    80001cd0:	fffff097          	auipc	ra,0xfffff
    80001cd4:	6be080e7          	jalr	1726(ra) # 8000138e <kvmmap>
	for (p = proc; p < &proc[NPROC]; p++) {
    80001cd8:	fd5b17e3          	bne	s6,s5,80001ca6 <proc_mapstacks+0x4a>
}
    80001cdc:	70e2                	ld	ra,56(sp)
    80001cde:	7442                	ld	s0,48(sp)
    80001ce0:	74a2                	ld	s1,40(sp)
    80001ce2:	7902                	ld	s2,32(sp)
    80001ce4:	69e2                	ld	s3,24(sp)
    80001ce6:	6a42                	ld	s4,16(sp)
    80001ce8:	6aa2                	ld	s5,8(sp)
    80001cea:	6b02                	ld	s6,0(sp)
    80001cec:	6121                	add	sp,sp,64
    80001cee:	8082                	ret
			panic("kalloc");
    80001cf0:	00007517          	auipc	a0,0x7
    80001cf4:	91850513          	add	a0,a0,-1768 # 80008608 <etext+0x608>
    80001cf8:	fffff097          	auipc	ra,0xfffff
    80001cfc:	89e080e7          	jalr	-1890(ra) # 80000596 <panic>

0000000080001d00 <procinit>:
{
    80001d00:	7139                	add	sp,sp,-64
    80001d02:	f426                	sd	s1,40(sp)
		p->kstack = KSTACK((int)(p - proc));
    80001d04:	04fa54b7          	lui	s1,0x4fa5
    80001d08:	fa548493          	add	s1,s1,-91 # 4fa4fa5 <_entry-0x7b05b05b>
    80001d0c:	04b2                	sll	s1,s1,0xc
{
    80001d0e:	fc06                	sd	ra,56(sp)
    80001d10:	f822                	sd	s0,48(sp)
    80001d12:	f04a                	sd	s2,32(sp)
    80001d14:	ec4e                	sd	s3,24(sp)
    80001d16:	e852                	sd	s4,16(sp)
    80001d18:	e456                	sd	s5,8(sp)
    80001d1a:	e05a                	sd	s6,0(sp)
    80001d1c:	0080                	add	s0,sp,64
		p->kstack = KSTACK((int)(p - proc));
    80001d1e:	fa548493          	add	s1,s1,-91
	initlock(&pid_lock, "nextpid");
    80001d22:	00007597          	auipc	a1,0x7
    80001d26:	8ee58593          	add	a1,a1,-1810 # 80008610 <etext+0x610>
    80001d2a:	0000f517          	auipc	a0,0xf
    80001d2e:	68650513          	add	a0,a0,1670 # 800113b0 <pid_lock>
		p->kstack = KSTACK((int)(p - proc));
    80001d32:	04b2                	sll	s1,s1,0xc
	initlock(&pid_lock, "nextpid");
    80001d34:	fffff097          	auipc	ra,0xfffff
    80001d38:	e9c080e7          	jalr	-356(ra) # 80000bd0 <initlock>
		p->kstack = KSTACK((int)(p - proc));
    80001d3c:	fa548493          	add	s1,s1,-91
    80001d40:	04000937          	lui	s2,0x4000
	initlock(&wait_lock, "wait_lock");
    80001d44:	00007597          	auipc	a1,0x7
    80001d48:	8d458593          	add	a1,a1,-1836 # 80008618 <etext+0x618>
    80001d4c:	0000f517          	auipc	a0,0xf
    80001d50:	67c50513          	add	a0,a0,1660 # 800113c8 <wait_lock>
	for (p = proc; p < &proc[NPROC]; p++) {
    80001d54:	0000f997          	auipc	s3,0xf
    80001d58:	68c98993          	add	s3,s3,1676 # 800113e0 <proc>
		p->kstack = KSTACK((int)(p - proc));
    80001d5c:	04b2                	sll	s1,s1,0xc
    80001d5e:	197d                	add	s2,s2,-1 # 3ffffff <_entry-0x7c000001>
	initlock(&wait_lock, "wait_lock");
    80001d60:	fffff097          	auipc	ra,0xfffff
    80001d64:	e70080e7          	jalr	-400(ra) # 80000bd0 <initlock>
	for (p = proc; p < &proc[NPROC]; p++) {
    80001d68:	8b4e                	mv	s6,s3
    80001d6a:	00015a97          	auipc	s5,0x15
    80001d6e:	076a8a93          	add	s5,s5,118 # 80016de0 <tickslock>
		initlock(&p->lock, "proc");
    80001d72:	00007a17          	auipc	s4,0x7
    80001d76:	8b6a0a13          	add	s4,s4,-1866 # 80008628 <etext+0x628>
		p->kstack = KSTACK((int)(p - proc));
    80001d7a:	fa548493          	add	s1,s1,-91
    80001d7e:	0932                	sll	s2,s2,0xc
		initlock(&p->lock, "proc");
    80001d80:	855a                	mv	a0,s6
    80001d82:	85d2                	mv	a1,s4
    80001d84:	fffff097          	auipc	ra,0xfffff
    80001d88:	e4c080e7          	jalr	-436(ra) # 80000bd0 <initlock>
		p->kstack = KSTACK((int)(p - proc));
    80001d8c:	413b07b3          	sub	a5,s6,s3
    80001d90:	878d                	sra	a5,a5,0x3
    80001d92:	029787b3          	mul	a5,a5,s1
		p->state = UNUSED;
    80001d96:	000b2c23          	sw	zero,24(s6)
	for (p = proc; p < &proc[NPROC]; p++) {
    80001d9a:	168b0b13          	add	s6,s6,360
		p->kstack = KSTACK((int)(p - proc));
    80001d9e:	2785                	addw	a5,a5,1
    80001da0:	00d7979b          	sllw	a5,a5,0xd
    80001da4:	40f907b3          	sub	a5,s2,a5
    80001da8:	ecfb3c23          	sd	a5,-296(s6)
	for (p = proc; p < &proc[NPROC]; p++) {
    80001dac:	fd5b1ae3          	bne	s6,s5,80001d80 <procinit+0x80>
}
    80001db0:	70e2                	ld	ra,56(sp)
    80001db2:	7442                	ld	s0,48(sp)
    80001db4:	74a2                	ld	s1,40(sp)
    80001db6:	7902                	ld	s2,32(sp)
    80001db8:	69e2                	ld	s3,24(sp)
    80001dba:	6a42                	ld	s4,16(sp)
    80001dbc:	6aa2                	ld	s5,8(sp)
    80001dbe:	6b02                	ld	s6,0(sp)
    80001dc0:	6121                	add	sp,sp,64
    80001dc2:	8082                	ret

0000000080001dc4 <cpuid>:
{
    80001dc4:	1141                	add	sp,sp,-16
    80001dc6:	e422                	sd	s0,8(sp)
    80001dc8:	0800                	add	s0,sp,16
    80001dca:	8512                	mv	a0,tp
}
    80001dcc:	6422                	ld	s0,8(sp)
    80001dce:	2501                	sext.w	a0,a0
    80001dd0:	0141                	add	sp,sp,16
    80001dd2:	8082                	ret

0000000080001dd4 <mycpu>:
{
    80001dd4:	1141                	add	sp,sp,-16
    80001dd6:	e422                	sd	s0,8(sp)
    80001dd8:	0800                	add	s0,sp,16
    80001dda:	8792                	mv	a5,tp
}
    80001ddc:	6422                	ld	s0,8(sp)
	struct cpu *c = &cpus[id];
    80001dde:	2781                	sext.w	a5,a5
    80001de0:	079e                	sll	a5,a5,0x7
}
    80001de2:	0000f517          	auipc	a0,0xf
    80001de6:	1ce50513          	add	a0,a0,462 # 80010fb0 <cpus>
    80001dea:	953e                	add	a0,a0,a5
    80001dec:	0141                	add	sp,sp,16
    80001dee:	8082                	ret

0000000080001df0 <myproc>:
{
    80001df0:	1101                	add	sp,sp,-32
    80001df2:	e822                	sd	s0,16(sp)
    80001df4:	ec06                	sd	ra,24(sp)
    80001df6:	e426                	sd	s1,8(sp)
    80001df8:	1000                	add	s0,sp,32
	push_off();
    80001dfa:	fffff097          	auipc	ra,0xfffff
    80001dfe:	e1a080e7          	jalr	-486(ra) # 80000c14 <push_off>
    80001e02:	8792                	mv	a5,tp
	struct proc *p = c->proc;
    80001e04:	2781                	sext.w	a5,a5
    80001e06:	0000f717          	auipc	a4,0xf
    80001e0a:	1aa70713          	add	a4,a4,426 # 80010fb0 <cpus>
    80001e0e:	079e                	sll	a5,a5,0x7
    80001e10:	97ba                	add	a5,a5,a4
    80001e12:	6384                	ld	s1,0(a5)
	pop_off();
    80001e14:	fffff097          	auipc	ra,0xfffff
    80001e18:	eae080e7          	jalr	-338(ra) # 80000cc2 <pop_off>
}
    80001e1c:	60e2                	ld	ra,24(sp)
    80001e1e:	6442                	ld	s0,16(sp)
    80001e20:	8526                	mv	a0,s1
    80001e22:	64a2                	ld	s1,8(sp)
    80001e24:	6105                	add	sp,sp,32
    80001e26:	8082                	ret

0000000080001e28 <allocpid>:
{
    80001e28:	1101                	add	sp,sp,-32
    80001e2a:	ec06                	sd	ra,24(sp)
    80001e2c:	e822                	sd	s0,16(sp)
    80001e2e:	e426                	sd	s1,8(sp)
    80001e30:	e04a                	sd	s2,0(sp)
    80001e32:	1000                	add	s0,sp,32
	acquire(&pid_lock);
    80001e34:	0000f917          	auipc	s2,0xf
    80001e38:	57c90913          	add	s2,s2,1404 # 800113b0 <pid_lock>
    80001e3c:	854a                	mv	a0,s2
    80001e3e:	fffff097          	auipc	ra,0xfffff
    80001e42:	e22080e7          	jalr	-478(ra) # 80000c60 <acquire>
	pid = nextpid;
    80001e46:	00007797          	auipc	a5,0x7
    80001e4a:	e7e78793          	add	a5,a5,-386 # 80008cc4 <nextpid>
    80001e4e:	4384                	lw	s1,0(a5)
	release(&pid_lock);
    80001e50:	854a                	mv	a0,s2
	nextpid = nextpid + 1;
    80001e52:	0014871b          	addw	a4,s1,1
    80001e56:	c398                	sw	a4,0(a5)
	release(&pid_lock);
    80001e58:	fffff097          	auipc	ra,0xfffff
    80001e5c:	ec8080e7          	jalr	-312(ra) # 80000d20 <release>
}
    80001e60:	60e2                	ld	ra,24(sp)
    80001e62:	6442                	ld	s0,16(sp)
    80001e64:	6902                	ld	s2,0(sp)
    80001e66:	8526                	mv	a0,s1
    80001e68:	64a2                	ld	s1,8(sp)
    80001e6a:	6105                	add	sp,sp,32
    80001e6c:	8082                	ret

0000000080001e6e <proc_pagetable>:
{
    80001e6e:	1101                	add	sp,sp,-32
    80001e70:	e822                	sd	s0,16(sp)
    80001e72:	e04a                	sd	s2,0(sp)
    80001e74:	ec06                	sd	ra,24(sp)
    80001e76:	e426                	sd	s1,8(sp)
    80001e78:	1000                	add	s0,sp,32
    80001e7a:	892a                	mv	s2,a0
	pagetable = uvmcreate();
    80001e7c:	fffff097          	auipc	ra,0xfffff
    80001e80:	672080e7          	jalr	1650(ra) # 800014ee <uvmcreate>
	if (pagetable == 0)
    80001e84:	cd31                	beqz	a0,80001ee0 <proc_pagetable+0x72>
	if (mappages(pagetable, TRAMPOLINE, PGSIZE,
    80001e86:	040005b7          	lui	a1,0x4000
    80001e8a:	15fd                	add	a1,a1,-1 # 3ffffff <_entry-0x7c000001>
    80001e8c:	4729                	li	a4,10
    80001e8e:	00005697          	auipc	a3,0x5
    80001e92:	17268693          	add	a3,a3,370 # 80007000 <_trampoline>
    80001e96:	6605                	lui	a2,0x1
    80001e98:	05b2                	sll	a1,a1,0xc
    80001e9a:	84aa                	mv	s1,a0
    80001e9c:	fffff097          	auipc	ra,0xfffff
    80001ea0:	454080e7          	jalr	1108(ra) # 800012f0 <mappages>
    80001ea4:	02054863          	bltz	a0,80001ed4 <proc_pagetable+0x66>
	if (mappages(pagetable, TRAPFRAME, PGSIZE,
    80001ea8:	020005b7          	lui	a1,0x2000
    80001eac:	05893683          	ld	a3,88(s2)
    80001eb0:	15fd                	add	a1,a1,-1 # 1ffffff <_entry-0x7e000001>
    80001eb2:	4719                	li	a4,6
    80001eb4:	6605                	lui	a2,0x1
    80001eb6:	05b6                	sll	a1,a1,0xd
    80001eb8:	8526                	mv	a0,s1
    80001eba:	fffff097          	auipc	ra,0xfffff
    80001ebe:	436080e7          	jalr	1078(ra) # 800012f0 <mappages>
    80001ec2:	02054763          	bltz	a0,80001ef0 <proc_pagetable+0x82>
}
    80001ec6:	60e2                	ld	ra,24(sp)
    80001ec8:	6442                	ld	s0,16(sp)
    80001eca:	6902                	ld	s2,0(sp)
    80001ecc:	8526                	mv	a0,s1
    80001ece:	64a2                	ld	s1,8(sp)
    80001ed0:	6105                	add	sp,sp,32
    80001ed2:	8082                	ret
		uvmfree(pagetable, 0);
    80001ed4:	4581                	li	a1,0
    80001ed6:	8526                	mv	a0,s1
    80001ed8:	00000097          	auipc	ra,0x0
    80001edc:	868080e7          	jalr	-1944(ra) # 80001740 <uvmfree>
		return 0;
    80001ee0:	4481                	li	s1,0
}
    80001ee2:	60e2                	ld	ra,24(sp)
    80001ee4:	6442                	ld	s0,16(sp)
    80001ee6:	6902                	ld	s2,0(sp)
    80001ee8:	8526                	mv	a0,s1
    80001eea:	64a2                	ld	s1,8(sp)
    80001eec:	6105                	add	sp,sp,32
    80001eee:	8082                	ret
		uvmunmap(pagetable, TRAMPOLINE, 1, 0);
    80001ef0:	040005b7          	lui	a1,0x4000
    80001ef4:	15fd                	add	a1,a1,-1 # 3ffffff <_entry-0x7c000001>
    80001ef6:	8526                	mv	a0,s1
    80001ef8:	4681                	li	a3,0
    80001efa:	4605                	li	a2,1
    80001efc:	05b2                	sll	a1,a1,0xc
    80001efe:	fffff097          	auipc	ra,0xfffff
    80001f02:	5ca080e7          	jalr	1482(ra) # 800014c8 <uvmunmap>
		uvmfree(pagetable, 0);
    80001f06:	8526                	mv	a0,s1
    80001f08:	4581                	li	a1,0
    80001f0a:	00000097          	auipc	ra,0x0
    80001f0e:	836080e7          	jalr	-1994(ra) # 80001740 <uvmfree>
		return 0;
    80001f12:	4481                	li	s1,0
    80001f14:	b7f9                	j	80001ee2 <proc_pagetable+0x74>

0000000080001f16 <allocproc>:
{
    80001f16:	1101                	add	sp,sp,-32
    80001f18:	e822                	sd	s0,16(sp)
    80001f1a:	e426                	sd	s1,8(sp)
    80001f1c:	e04a                	sd	s2,0(sp)
    80001f1e:	ec06                	sd	ra,24(sp)
    80001f20:	1000                	add	s0,sp,32
	for (p = proc; p < &proc[NPROC]; p++) {
    80001f22:	0000f497          	auipc	s1,0xf
    80001f26:	4be48493          	add	s1,s1,1214 # 800113e0 <proc>
    80001f2a:	00015917          	auipc	s2,0x15
    80001f2e:	eb690913          	add	s2,s2,-330 # 80016de0 <tickslock>
    80001f32:	a809                	j	80001f44 <allocproc+0x2e>
    80001f34:	16848493          	add	s1,s1,360
			release(&p->lock);
    80001f38:	fffff097          	auipc	ra,0xfffff
    80001f3c:	de8080e7          	jalr	-536(ra) # 80000d20 <release>
	for (p = proc; p < &proc[NPROC]; p++) {
    80001f40:	0b248763          	beq	s1,s2,80001fee <allocproc+0xd8>
		acquire(&p->lock);
    80001f44:	8526                	mv	a0,s1
    80001f46:	fffff097          	auipc	ra,0xfffff
    80001f4a:	d1a080e7          	jalr	-742(ra) # 80000c60 <acquire>
		if (p->state == UNUSED) {
    80001f4e:	4c9c                	lw	a5,24(s1)
			release(&p->lock);
    80001f50:	8526                	mv	a0,s1
		if (p->state == UNUSED) {
    80001f52:	f3ed                	bnez	a5,80001f34 <allocproc+0x1e>
	acquire(&pid_lock);
    80001f54:	0000f517          	auipc	a0,0xf
    80001f58:	45c50513          	add	a0,a0,1116 # 800113b0 <pid_lock>
    80001f5c:	fffff097          	auipc	ra,0xfffff
    80001f60:	d04080e7          	jalr	-764(ra) # 80000c60 <acquire>
	pid = nextpid;
    80001f64:	00007797          	auipc	a5,0x7
    80001f68:	d6078793          	add	a5,a5,-672 # 80008cc4 <nextpid>
    80001f6c:	0007a903          	lw	s2,0(a5)
	release(&pid_lock);
    80001f70:	0000f517          	auipc	a0,0xf
    80001f74:	44050513          	add	a0,a0,1088 # 800113b0 <pid_lock>
	nextpid = nextpid + 1;
    80001f78:	0019071b          	addw	a4,s2,1
    80001f7c:	c398                	sw	a4,0(a5)
	release(&pid_lock);
    80001f7e:	fffff097          	auipc	ra,0xfffff
    80001f82:	da2080e7          	jalr	-606(ra) # 80000d20 <release>
	p->state = USED;
    80001f86:	4785                	li	a5,1
	p->pid = allocpid();
    80001f88:	0324a823          	sw	s2,48(s1)
	p->state = USED;
    80001f8c:	cc9c                	sw	a5,24(s1)
	if ((p->trapframe = (struct trapframe *)kalloc()) == 0) {
    80001f8e:	fffff097          	auipc	ra,0xfffff
    80001f92:	bd8080e7          	jalr	-1064(ra) # 80000b66 <kalloc>
    80001f96:	eca8                	sd	a0,88(s1)
    80001f98:	c129                	beqz	a0,80001fda <allocproc+0xc4>
	p->pagetable = proc_pagetable(p);
    80001f9a:	8526                	mv	a0,s1
    80001f9c:	00000097          	auipc	ra,0x0
    80001fa0:	ed2080e7          	jalr	-302(ra) # 80001e6e <proc_pagetable>
    80001fa4:	e8a8                	sd	a0,80(s1)
	if (p->pagetable == 0) {
    80001fa6:	c915                	beqz	a0,80001fda <allocproc+0xc4>
	memset(&p->context, 0, sizeof(p->context));
    80001fa8:	07000613          	li	a2,112
    80001fac:	4581                	li	a1,0
    80001fae:	06048513          	add	a0,s1,96
    80001fb2:	fffff097          	auipc	ra,0xfffff
    80001fb6:	dc2080e7          	jalr	-574(ra) # 80000d74 <memset>
	p->context.sp = p->kstack + PGSIZE;
    80001fba:	60bc                	ld	a5,64(s1)
    80001fbc:	6705                	lui	a4,0x1
    80001fbe:	97ba                	add	a5,a5,a4
	p->context.ra = (uint64) forkret;
    80001fc0:	00000717          	auipc	a4,0x0
    80001fc4:	b9870713          	add	a4,a4,-1128 # 80001b58 <forkret>
    80001fc8:	f0b8                	sd	a4,96(s1)
	p->context.sp = p->kstack + PGSIZE;
    80001fca:	f4bc                	sd	a5,104(s1)
}
    80001fcc:	60e2                	ld	ra,24(sp)
    80001fce:	6442                	ld	s0,16(sp)
    80001fd0:	6902                	ld	s2,0(sp)
    80001fd2:	8526                	mv	a0,s1
    80001fd4:	64a2                	ld	s1,8(sp)
    80001fd6:	6105                	add	sp,sp,32
    80001fd8:	8082                	ret
		freeproc(p);
    80001fda:	8526                	mv	a0,s1
    80001fdc:	00000097          	auipc	ra,0x0
    80001fe0:	bee080e7          	jalr	-1042(ra) # 80001bca <freeproc>
		release(&p->lock);
    80001fe4:	8526                	mv	a0,s1
    80001fe6:	fffff097          	auipc	ra,0xfffff
    80001fea:	d3a080e7          	jalr	-710(ra) # 80000d20 <release>
	return 0;
    80001fee:	4481                	li	s1,0
    80001ff0:	bff1                	j	80001fcc <allocproc+0xb6>

0000000080001ff2 <proc_freepagetable>:
{
    80001ff2:	1101                	add	sp,sp,-32
    80001ff4:	e04a                	sd	s2,0(sp)
    80001ff6:	892e                	mv	s2,a1
	uvmunmap(pagetable, TRAMPOLINE, 1, 0);
    80001ff8:	040005b7          	lui	a1,0x4000
{
    80001ffc:	ec06                	sd	ra,24(sp)
    80001ffe:	e822                	sd	s0,16(sp)
    80002000:	e426                	sd	s1,8(sp)
    80002002:	1000                	add	s0,sp,32
	uvmunmap(pagetable, TRAMPOLINE, 1, 0);
    80002004:	15fd                	add	a1,a1,-1 # 3ffffff <_entry-0x7c000001>
    80002006:	4681                	li	a3,0
    80002008:	4605                	li	a2,1
    8000200a:	05b2                	sll	a1,a1,0xc
{
    8000200c:	84aa                	mv	s1,a0
	uvmunmap(pagetable, TRAMPOLINE, 1, 0);
    8000200e:	fffff097          	auipc	ra,0xfffff
    80002012:	4ba080e7          	jalr	1210(ra) # 800014c8 <uvmunmap>
	uvmunmap(pagetable, TRAPFRAME, 1, 0);
    80002016:	020005b7          	lui	a1,0x2000
    8000201a:	15fd                	add	a1,a1,-1 # 1ffffff <_entry-0x7e000001>
    8000201c:	8526                	mv	a0,s1
    8000201e:	05b6                	sll	a1,a1,0xd
    80002020:	4681                	li	a3,0
    80002022:	4605                	li	a2,1
    80002024:	fffff097          	auipc	ra,0xfffff
    80002028:	4a4080e7          	jalr	1188(ra) # 800014c8 <uvmunmap>
}
    8000202c:	6442                	ld	s0,16(sp)
    8000202e:	60e2                	ld	ra,24(sp)
	uvmfree(pagetable, sz);
    80002030:	85ca                	mv	a1,s2
    80002032:	8526                	mv	a0,s1
}
    80002034:	6902                	ld	s2,0(sp)
    80002036:	64a2                	ld	s1,8(sp)
    80002038:	6105                	add	sp,sp,32
	uvmfree(pagetable, sz);
    8000203a:	fffff317          	auipc	t1,0xfffff
    8000203e:	70630067          	jr	1798(t1) # 80001740 <uvmfree>

0000000080002042 <userinit>:
{
    80002042:	1101                	add	sp,sp,-32
    80002044:	ec06                	sd	ra,24(sp)
    80002046:	e822                	sd	s0,16(sp)
    80002048:	e426                	sd	s1,8(sp)
    8000204a:	1000                	add	s0,sp,32
	p = allocproc();
    8000204c:	00000097          	auipc	ra,0x0
    80002050:	eca080e7          	jalr	-310(ra) # 80001f16 <allocproc>
    80002054:	84aa                	mv	s1,a0
	uvmfirst(p->pagetable, initcode, sizeof(initcode));
    80002056:	6928                	ld	a0,80(a0)
    80002058:	03400613          	li	a2,52
    8000205c:	00007597          	auipc	a1,0x7
    80002060:	c7458593          	add	a1,a1,-908 # 80008cd0 <initcode>
	initproc = p;
    80002064:	00007797          	auipc	a5,0x7
    80002068:	cc97ba23          	sd	s1,-812(a5) # 80008d38 <initproc>
	uvmfirst(p->pagetable, initcode, sizeof(initcode));
    8000206c:	fffff097          	auipc	ra,0xfffff
    80002070:	4b0080e7          	jalr	1200(ra) # 8000151c <uvmfirst>
	p->trapframe->epc = 0;	/* user program counter */
    80002074:	6cbc                	ld	a5,88(s1)
	p->sz = PGSIZE;
    80002076:	6705                	lui	a4,0x1
    80002078:	e4b8                	sd	a4,72(s1)
	p->trapframe->epc = 0;	/* user program counter */
    8000207a:	0007bc23          	sd	zero,24(a5)
	p->trapframe->sp = PGSIZE;	/* user stack pointer */
    8000207e:	fb98                	sd	a4,48(a5)
	safestrcpy(p->name, "initcode", sizeof(p->name));
    80002080:	4641                	li	a2,16
    80002082:	00006597          	auipc	a1,0x6
    80002086:	5ae58593          	add	a1,a1,1454 # 80008630 <etext+0x630>
    8000208a:	15848513          	add	a0,s1,344
    8000208e:	fffff097          	auipc	ra,0xfffff
    80002092:	e98080e7          	jalr	-360(ra) # 80000f26 <safestrcpy>
	p->cwd = namei("/");
    80002096:	00006517          	auipc	a0,0x6
    8000209a:	5aa50513          	add	a0,a0,1450 # 80008640 <etext+0x640>
    8000209e:	00002097          	auipc	ra,0x2
    800020a2:	53a080e7          	jalr	1338(ra) # 800045d8 <namei>
	p->state = RUNNABLE;
    800020a6:	478d                	li	a5,3
}
    800020a8:	6442                	ld	s0,16(sp)
	p->cwd = namei("/");
    800020aa:	14a4b823          	sd	a0,336(s1)
}
    800020ae:	60e2                	ld	ra,24(sp)
	p->state = RUNNABLE;
    800020b0:	cc9c                	sw	a5,24(s1)
	release(&p->lock);
    800020b2:	8526                	mv	a0,s1
}
    800020b4:	64a2                	ld	s1,8(sp)
    800020b6:	6105                	add	sp,sp,32
	release(&p->lock);
    800020b8:	fffff317          	auipc	t1,0xfffff
    800020bc:	c6830067          	jr	-920(t1) # 80000d20 <release>

00000000800020c0 <growproc>:
{
    800020c0:	1101                	add	sp,sp,-32
    800020c2:	e822                	sd	s0,16(sp)
    800020c4:	e426                	sd	s1,8(sp)
    800020c6:	ec06                	sd	ra,24(sp)
    800020c8:	e04a                	sd	s2,0(sp)
    800020ca:	1000                	add	s0,sp,32
    800020cc:	84aa                	mv	s1,a0
	push_off();
    800020ce:	fffff097          	auipc	ra,0xfffff
    800020d2:	b46080e7          	jalr	-1210(ra) # 80000c14 <push_off>
    800020d6:	8792                	mv	a5,tp
	struct proc *p = c->proc;
    800020d8:	2781                	sext.w	a5,a5
    800020da:	0000f717          	auipc	a4,0xf
    800020de:	ed670713          	add	a4,a4,-298 # 80010fb0 <cpus>
    800020e2:	079e                	sll	a5,a5,0x7
    800020e4:	97ba                	add	a5,a5,a4
    800020e6:	0007b903          	ld	s2,0(a5)
	pop_off();
    800020ea:	fffff097          	auipc	ra,0xfffff
    800020ee:	bd8080e7          	jalr	-1064(ra) # 80000cc2 <pop_off>
	sz = p->sz;
    800020f2:	04893583          	ld	a1,72(s2)
	if (n > 0) {
    800020f6:	00904c63          	bgtz	s1,8000210e <growproc+0x4e>
	} else if (n < 0) {
    800020fa:	e49d                	bnez	s1,80002128 <growproc+0x68>
	p->sz = sz;
    800020fc:	04b93423          	sd	a1,72(s2)
	return 0;
    80002100:	4501                	li	a0,0
}
    80002102:	60e2                	ld	ra,24(sp)
    80002104:	6442                	ld	s0,16(sp)
    80002106:	64a2                	ld	s1,8(sp)
    80002108:	6902                	ld	s2,0(sp)
    8000210a:	6105                	add	sp,sp,32
    8000210c:	8082                	ret
		if ((sz = uvmalloc(p->pagetable, sz, sz + n, PTE_W)) == 0) {
    8000210e:	05093503          	ld	a0,80(s2)
    80002112:	00b48633          	add	a2,s1,a1
    80002116:	4691                	li	a3,4
    80002118:	fffff097          	auipc	ra,0xfffff
    8000211c:	474080e7          	jalr	1140(ra) # 8000158c <uvmalloc>
    80002120:	85aa                	mv	a1,a0
    80002122:	fd69                	bnez	a0,800020fc <growproc+0x3c>
			return -1;
    80002124:	557d                	li	a0,-1
    80002126:	bff1                	j	80002102 <growproc+0x42>
		sz = uvmdealloc(p->pagetable, sz, sz + n);
    80002128:	05093503          	ld	a0,80(s2)
    8000212c:	00b48633          	add	a2,s1,a1
    80002130:	fffff097          	auipc	ra,0xfffff
    80002134:	54c080e7          	jalr	1356(ra) # 8000167c <uvmdealloc>
    80002138:	85aa                	mv	a1,a0
    8000213a:	b7c9                	j	800020fc <growproc+0x3c>

000000008000213c <fork>:
{
    8000213c:	7139                	add	sp,sp,-64
    8000213e:	f822                	sd	s0,48(sp)
    80002140:	fc06                	sd	ra,56(sp)
    80002142:	f426                	sd	s1,40(sp)
    80002144:	e456                	sd	s5,8(sp)
    80002146:	0080                	add	s0,sp,64
	push_off();
    80002148:	fffff097          	auipc	ra,0xfffff
    8000214c:	acc080e7          	jalr	-1332(ra) # 80000c14 <push_off>
    80002150:	8792                	mv	a5,tp
	struct proc *p = c->proc;
    80002152:	2781                	sext.w	a5,a5
    80002154:	0000f717          	auipc	a4,0xf
    80002158:	e5c70713          	add	a4,a4,-420 # 80010fb0 <cpus>
    8000215c:	079e                	sll	a5,a5,0x7
    8000215e:	97ba                	add	a5,a5,a4
    80002160:	0007ba83          	ld	s5,0(a5)
	pop_off();
    80002164:	fffff097          	auipc	ra,0xfffff
    80002168:	b5e080e7          	jalr	-1186(ra) # 80000cc2 <pop_off>
	if ((np = allocproc()) == 0) {
    8000216c:	00000097          	auipc	ra,0x0
    80002170:	daa080e7          	jalr	-598(ra) # 80001f16 <allocproc>
    80002174:	10050a63          	beqz	a0,80002288 <fork+0x14c>
	if (uvmcopy(p->pagetable, np->pagetable, p->sz) < 0) {
    80002178:	e852                	sd	s4,16(sp)
    8000217a:	692c                	ld	a1,80(a0)
    8000217c:	8a2a                	mv	s4,a0
    8000217e:	048ab603          	ld	a2,72(s5)
    80002182:	050ab503          	ld	a0,80(s5)
    80002186:	fffff097          	auipc	ra,0xfffff
    8000218a:	602080e7          	jalr	1538(ra) # 80001788 <uvmcopy>
    8000218e:	0e054263          	bltz	a0,80002272 <fork+0x136>
	np->sz = p->sz;
    80002192:	048ab703          	ld	a4,72(s5)
	*(np->trapframe) = *(p->trapframe);
    80002196:	058ab783          	ld	a5,88(s5)
    8000219a:	058a3883          	ld	a7,88(s4)
    8000219e:	f04a                	sd	s2,32(sp)
    800021a0:	ec4e                	sd	s3,24(sp)
	np->sz = p->sz;
    800021a2:	04ea3423          	sd	a4,72(s4)
	*(np->trapframe) = *(p->trapframe);
    800021a6:	12078813          	add	a6,a5,288
    800021aa:	8746                	mv	a4,a7
    800021ac:	6388                	ld	a0,0(a5)
    800021ae:	678c                	ld	a1,8(a5)
    800021b0:	6b90                	ld	a2,16(a5)
    800021b2:	6f94                	ld	a3,24(a5)
    800021b4:	e308                	sd	a0,0(a4)
    800021b6:	e70c                	sd	a1,8(a4)
    800021b8:	eb10                	sd	a2,16(a4)
    800021ba:	ef14                	sd	a3,24(a4)
    800021bc:	02078793          	add	a5,a5,32
    800021c0:	02070713          	add	a4,a4,32
    800021c4:	ff0794e3          	bne	a5,a6,800021ac <fork+0x70>
	np->trapframe->a0 = 0;
    800021c8:	0608b823          	sd	zero,112(a7)
	for (i = 0; i < NOFILE; i++)
    800021cc:	0d0a8493          	add	s1,s5,208
    800021d0:	0d0a0913          	add	s2,s4,208
    800021d4:	150a8993          	add	s3,s5,336
		if (p->ofile[i])
    800021d8:	6088                	ld	a0,0(s1)
    800021da:	c519                	beqz	a0,800021e8 <fork+0xac>
			np->ofile[i] = filedup(p->ofile[i]);
    800021dc:	00003097          	auipc	ra,0x3
    800021e0:	a52080e7          	jalr	-1454(ra) # 80004c2e <filedup>
    800021e4:	00a93023          	sd	a0,0(s2)
	for (i = 0; i < NOFILE; i++)
    800021e8:	04a1                	add	s1,s1,8
    800021ea:	0921                	add	s2,s2,8
    800021ec:	ff3496e3          	bne	s1,s3,800021d8 <fork+0x9c>
	np->cwd = idup(p->cwd);
    800021f0:	150ab503          	ld	a0,336(s5)
    800021f4:	00002097          	auipc	ra,0x2
    800021f8:	b12080e7          	jalr	-1262(ra) # 80003d06 <idup>
	safestrcpy(np->name, p->name, sizeof(p->name));
    800021fc:	4641                	li	a2,16
    800021fe:	158a8593          	add	a1,s5,344
	np->cwd = idup(p->cwd);
    80002202:	14aa3823          	sd	a0,336(s4)
	safestrcpy(np->name, p->name, sizeof(p->name));
    80002206:	158a0513          	add	a0,s4,344
    8000220a:	fffff097          	auipc	ra,0xfffff
    8000220e:	d1c080e7          	jalr	-740(ra) # 80000f26 <safestrcpy>
	release(&np->lock);
    80002212:	8552                	mv	a0,s4
	pid = np->pid;
    80002214:	030a2483          	lw	s1,48(s4)
	release(&np->lock);
    80002218:	fffff097          	auipc	ra,0xfffff
    8000221c:	b08080e7          	jalr	-1272(ra) # 80000d20 <release>
	acquire(&wait_lock);
    80002220:	0000f517          	auipc	a0,0xf
    80002224:	1a850513          	add	a0,a0,424 # 800113c8 <wait_lock>
    80002228:	fffff097          	auipc	ra,0xfffff
    8000222c:	a38080e7          	jalr	-1480(ra) # 80000c60 <acquire>
	release(&wait_lock);
    80002230:	0000f517          	auipc	a0,0xf
    80002234:	19850513          	add	a0,a0,408 # 800113c8 <wait_lock>
	np->parent = p;
    80002238:	035a3c23          	sd	s5,56(s4)
	release(&wait_lock);
    8000223c:	fffff097          	auipc	ra,0xfffff
    80002240:	ae4080e7          	jalr	-1308(ra) # 80000d20 <release>
	acquire(&np->lock);
    80002244:	8552                	mv	a0,s4
    80002246:	fffff097          	auipc	ra,0xfffff
    8000224a:	a1a080e7          	jalr	-1510(ra) # 80000c60 <acquire>
	np->state = RUNNABLE;
    8000224e:	478d                	li	a5,3
    80002250:	00fa2c23          	sw	a5,24(s4)
	release(&np->lock);
    80002254:	8552                	mv	a0,s4
    80002256:	fffff097          	auipc	ra,0xfffff
    8000225a:	aca080e7          	jalr	-1334(ra) # 80000d20 <release>
    8000225e:	7902                	ld	s2,32(sp)
    80002260:	69e2                	ld	s3,24(sp)
    80002262:	6a42                	ld	s4,16(sp)
}
    80002264:	70e2                	ld	ra,56(sp)
    80002266:	7442                	ld	s0,48(sp)
    80002268:	6aa2                	ld	s5,8(sp)
    8000226a:	8526                	mv	a0,s1
    8000226c:	74a2                	ld	s1,40(sp)
    8000226e:	6121                	add	sp,sp,64
    80002270:	8082                	ret
		freeproc(np);
    80002272:	8552                	mv	a0,s4
    80002274:	00000097          	auipc	ra,0x0
    80002278:	956080e7          	jalr	-1706(ra) # 80001bca <freeproc>
		release(&np->lock);
    8000227c:	8552                	mv	a0,s4
    8000227e:	fffff097          	auipc	ra,0xfffff
    80002282:	aa2080e7          	jalr	-1374(ra) # 80000d20 <release>
    80002286:	6a42                	ld	s4,16(sp)
		return -1;
    80002288:	54fd                	li	s1,-1
    8000228a:	bfe9                	j	80002264 <fork+0x128>

000000008000228c <scheduler>:
{
    8000228c:	7139                	add	sp,sp,-64
    8000228e:	f822                	sd	s0,48(sp)
    80002290:	fc06                	sd	ra,56(sp)
    80002292:	f426                	sd	s1,40(sp)
    80002294:	f04a                	sd	s2,32(sp)
    80002296:	ec4e                	sd	s3,24(sp)
    80002298:	e852                	sd	s4,16(sp)
    8000229a:	e456                	sd	s5,8(sp)
    8000229c:	e05a                	sd	s6,0(sp)
    8000229e:	0080                	add	s0,sp,64
    800022a0:	8792                	mv	a5,tp
	int id = r_tp();
    800022a2:	2781                	sext.w	a5,a5
	c->proc = 0;
    800022a4:	0000fa97          	auipc	s5,0xf
    800022a8:	d0ca8a93          	add	s5,s5,-756 # 80010fb0 <cpus>
    800022ac:	079e                	sll	a5,a5,0x7
    800022ae:	00fa8a33          	add	s4,s5,a5
				swtch(&c->context, &p->context);
    800022b2:	07a1                	add	a5,a5,8
	c->proc = 0;
    800022b4:	000a3023          	sd	zero,0(s4)
				swtch(&c->context, &p->context);
    800022b8:	9abe                	add	s5,s5,a5
    800022ba:	00015997          	auipc	s3,0x15
    800022be:	b2698993          	add	s3,s3,-1242 # 80016de0 <tickslock>
			if (p->state == RUNNABLE) {
    800022c2:	490d                	li	s2,3
				p->state = RUNNING;
    800022c4:	4b11                	li	s6,4
  __asm__ volatile("csrr %0, sstatus" : "=r" (x) );
    800022c6:	100027f3          	csrr	a5,sstatus
  w_sstatus(r_sstatus() | SSTATUS_SIE);
    800022ca:	0027e793          	or	a5,a5,2
  __asm__ volatile("csrw sstatus, %0" : : "r" (x));
    800022ce:	10079073          	csrw	sstatus,a5
		for (p = proc; p < &proc[NPROC]; p++) {
    800022d2:	0000f497          	auipc	s1,0xf
    800022d6:	10e48493          	add	s1,s1,270 # 800113e0 <proc>
    800022da:	a811                	j	800022ee <scheduler+0x62>
			release(&p->lock);
    800022dc:	8526                	mv	a0,s1
		for (p = proc; p < &proc[NPROC]; p++) {
    800022de:	16848493          	add	s1,s1,360
			release(&p->lock);
    800022e2:	fffff097          	auipc	ra,0xfffff
    800022e6:	a3e080e7          	jalr	-1474(ra) # 80000d20 <release>
		for (p = proc; p < &proc[NPROC]; p++) {
    800022ea:	fd348ee3          	beq	s1,s3,800022c6 <scheduler+0x3a>
			acquire(&p->lock);
    800022ee:	8526                	mv	a0,s1
    800022f0:	fffff097          	auipc	ra,0xfffff
    800022f4:	970080e7          	jalr	-1680(ra) # 80000c60 <acquire>
			if (p->state == RUNNABLE) {
    800022f8:	4c9c                	lw	a5,24(s1)
    800022fa:	ff2791e3          	bne	a5,s2,800022dc <scheduler+0x50>
				swtch(&c->context, &p->context);
    800022fe:	06048593          	add	a1,s1,96
    80002302:	8556                	mv	a0,s5
				p->state = RUNNING;
    80002304:	0164ac23          	sw	s6,24(s1)
				c->proc = p;
    80002308:	009a3023          	sd	s1,0(s4)
				swtch(&c->context, &p->context);
    8000230c:	00000097          	auipc	ra,0x0
    80002310:	7c6080e7          	jalr	1990(ra) # 80002ad2 <swtch>
				c->proc = 0;
    80002314:	000a3023          	sd	zero,0(s4)
    80002318:	b7d1                	j	800022dc <scheduler+0x50>

000000008000231a <sched>:
{
    8000231a:	7179                	add	sp,sp,-48
    8000231c:	f022                	sd	s0,32(sp)
    8000231e:	f406                	sd	ra,40(sp)
    80002320:	ec26                	sd	s1,24(sp)
    80002322:	e84a                	sd	s2,16(sp)
    80002324:	e44e                	sd	s3,8(sp)
    80002326:	1800                	add	s0,sp,48
	push_off();
    80002328:	fffff097          	auipc	ra,0xfffff
    8000232c:	8ec080e7          	jalr	-1812(ra) # 80000c14 <push_off>
  __asm__ volatile("mv %0, tp" : "=r" (x) );
    80002330:	8792                	mv	a5,tp
	struct proc *p = c->proc;
    80002332:	2781                	sext.w	a5,a5
    80002334:	0000f497          	auipc	s1,0xf
    80002338:	c7c48493          	add	s1,s1,-900 # 80010fb0 <cpus>
    8000233c:	079e                	sll	a5,a5,0x7
    8000233e:	97a6                	add	a5,a5,s1
    80002340:	0007b903          	ld	s2,0(a5)
	pop_off();
    80002344:	fffff097          	auipc	ra,0xfffff
    80002348:	97e080e7          	jalr	-1666(ra) # 80000cc2 <pop_off>
	if (!holding(&p->lock))
    8000234c:	854a                	mv	a0,s2
    8000234e:	fffff097          	auipc	ra,0xfffff
    80002352:	898080e7          	jalr	-1896(ra) # 80000be6 <holding>
    80002356:	c125                	beqz	a0,800023b6 <sched+0x9c>
    80002358:	8792                	mv	a5,tp
	if (mycpu()->noff != 1)
    8000235a:	2781                	sext.w	a5,a5
    8000235c:	079e                	sll	a5,a5,0x7
    8000235e:	97a6                	add	a5,a5,s1
    80002360:	5fb8                	lw	a4,120(a5)
    80002362:	4785                	li	a5,1
    80002364:	08f71163          	bne	a4,a5,800023e6 <sched+0xcc>
	if (p->state == RUNNING)
    80002368:	01892703          	lw	a4,24(s2)
    8000236c:	4791                	li	a5,4
    8000236e:	06f70463          	beq	a4,a5,800023d6 <sched+0xbc>
  __asm__ volatile("csrr %0, sstatus" : "=r" (x) );
    80002372:	100027f3          	csrr	a5,sstatus
  return (x & SSTATUS_SIE) != 0;
    80002376:	8b89                	and	a5,a5,2
	if (intr_get())
    80002378:	e7b9                	bnez	a5,800023c6 <sched+0xac>
  __asm__ volatile("mv %0, tp" : "=r" (x) );
    8000237a:	8792                	mv	a5,tp
	intena = mycpu()->intena;
    8000237c:	2781                	sext.w	a5,a5
    8000237e:	079e                	sll	a5,a5,0x7
    80002380:	97a6                	add	a5,a5,s1
    80002382:	07c7a983          	lw	s3,124(a5)
    80002386:	8592                	mv	a1,tp
	swtch(&p->context, &mycpu()->context);
    80002388:	2581                	sext.w	a1,a1
    8000238a:	059e                	sll	a1,a1,0x7
    8000238c:	05a1                	add	a1,a1,8
    8000238e:	95a6                	add	a1,a1,s1
    80002390:	06090513          	add	a0,s2,96
    80002394:	00000097          	auipc	ra,0x0
    80002398:	73e080e7          	jalr	1854(ra) # 80002ad2 <swtch>
    8000239c:	8792                	mv	a5,tp
	mycpu()->intena = intena;
    8000239e:	2781                	sext.w	a5,a5
}
    800023a0:	70a2                	ld	ra,40(sp)
    800023a2:	7402                	ld	s0,32(sp)
	mycpu()->intena = intena;
    800023a4:	079e                	sll	a5,a5,0x7
    800023a6:	94be                	add	s1,s1,a5
    800023a8:	0734ae23          	sw	s3,124(s1)
}
    800023ac:	6942                	ld	s2,16(sp)
    800023ae:	64e2                	ld	s1,24(sp)
    800023b0:	69a2                	ld	s3,8(sp)
    800023b2:	6145                	add	sp,sp,48
    800023b4:	8082                	ret
		panic("sched p->lock");
    800023b6:	00006517          	auipc	a0,0x6
    800023ba:	29250513          	add	a0,a0,658 # 80008648 <etext+0x648>
    800023be:	ffffe097          	auipc	ra,0xffffe
    800023c2:	1d8080e7          	jalr	472(ra) # 80000596 <panic>
		panic("sched interruptible");
    800023c6:	00006517          	auipc	a0,0x6
    800023ca:	2b250513          	add	a0,a0,690 # 80008678 <etext+0x678>
    800023ce:	ffffe097          	auipc	ra,0xffffe
    800023d2:	1c8080e7          	jalr	456(ra) # 80000596 <panic>
		panic("sched running");
    800023d6:	00006517          	auipc	a0,0x6
    800023da:	29250513          	add	a0,a0,658 # 80008668 <etext+0x668>
    800023de:	ffffe097          	auipc	ra,0xffffe
    800023e2:	1b8080e7          	jalr	440(ra) # 80000596 <panic>
		panic("sched locks");
    800023e6:	00006517          	auipc	a0,0x6
    800023ea:	27250513          	add	a0,a0,626 # 80008658 <etext+0x658>
    800023ee:	ffffe097          	auipc	ra,0xffffe
    800023f2:	1a8080e7          	jalr	424(ra) # 80000596 <panic>

00000000800023f6 <wait>:
{
    800023f6:	715d                	add	sp,sp,-80
    800023f8:	e0a2                	sd	s0,64(sp)
    800023fa:	ec56                	sd	s5,24(sp)
    800023fc:	e486                	sd	ra,72(sp)
    800023fe:	fc26                	sd	s1,56(sp)
    80002400:	f84a                	sd	s2,48(sp)
    80002402:	f44e                	sd	s3,40(sp)
    80002404:	f052                	sd	s4,32(sp)
    80002406:	e85a                	sd	s6,16(sp)
    80002408:	e45e                	sd	s7,8(sp)
    8000240a:	e062                	sd	s8,0(sp)
    8000240c:	0880                	add	s0,sp,80
    8000240e:	8aaa                	mv	s5,a0
	push_off();
    80002410:	fffff097          	auipc	ra,0xfffff
    80002414:	804080e7          	jalr	-2044(ra) # 80000c14 <push_off>
    80002418:	8792                	mv	a5,tp
	struct proc *p = c->proc;
    8000241a:	2781                	sext.w	a5,a5
    8000241c:	0000fb97          	auipc	s7,0xf
    80002420:	b94b8b93          	add	s7,s7,-1132 # 80010fb0 <cpus>
    80002424:	079e                	sll	a5,a5,0x7
    80002426:	97de                	add	a5,a5,s7
    80002428:	0007b903          	ld	s2,0(a5)
	pop_off();
    8000242c:	fffff097          	auipc	ra,0xfffff
    80002430:	896080e7          	jalr	-1898(ra) # 80000cc2 <pop_off>
	acquire(&wait_lock);
    80002434:	0000f517          	auipc	a0,0xf
    80002438:	f9450513          	add	a0,a0,-108 # 800113c8 <wait_lock>
    8000243c:	fffff097          	auipc	ra,0xfffff
    80002440:	824080e7          	jalr	-2012(ra) # 80000c60 <acquire>
				if (pp->state == ZOMBIE) {
    80002444:	4a15                	li	s4,5
		for (pp = proc; pp < &proc[NPROC]; pp++) {
    80002446:	00015997          	auipc	s3,0x15
    8000244a:	99a98993          	add	s3,s3,-1638 # 80016de0 <tickslock>
	/* Must acquire p->lock in order to change p->state and then call
	 * sched. Once we hold p->lock, we can be guaranteed that we won't
	 * miss any wakeup (wakeup locks p->lock), so it's okay to release lk. */

	acquire(&p->lock);	/* DOC: sleeplock1 */
	release(lk);
    8000244e:	0000fb17          	auipc	s6,0xf
    80002452:	f7ab0b13          	add	s6,s6,-134 # 800113c8 <wait_lock>

	/* Go to sleep. */
	p->chan = chan;
	p->state = SLEEPING;
    80002456:	4c09                	li	s8,2
		havekids = 0;
    80002458:	4701                	li	a4,0
		for (pp = proc; pp < &proc[NPROC]; pp++) {
    8000245a:	0000f497          	auipc	s1,0xf
    8000245e:	f8648493          	add	s1,s1,-122 # 800113e0 <proc>
    80002462:	a029                	j	8000246c <wait+0x76>
    80002464:	16848493          	add	s1,s1,360
    80002468:	03348763          	beq	s1,s3,80002496 <wait+0xa0>
			if (pp->parent == p) {
    8000246c:	7c9c                	ld	a5,56(s1)
    8000246e:	ff279be3          	bne	a5,s2,80002464 <wait+0x6e>
				acquire(&pp->lock);
    80002472:	8526                	mv	a0,s1
    80002474:	ffffe097          	auipc	ra,0xffffe
    80002478:	7ec080e7          	jalr	2028(ra) # 80000c60 <acquire>
				if (pp->state == ZOMBIE) {
    8000247c:	4c9c                	lw	a5,24(s1)
				release(&pp->lock);
    8000247e:	8526                	mv	a0,s1
				if (pp->state == ZOMBIE) {
    80002480:	09478563          	beq	a5,s4,8000250a <wait+0x114>
				release(&pp->lock);
    80002484:	fffff097          	auipc	ra,0xfffff
    80002488:	89c080e7          	jalr	-1892(ra) # 80000d20 <release>
		for (pp = proc; pp < &proc[NPROC]; pp++) {
    8000248c:	16848493          	add	s1,s1,360
				havekids = 1;
    80002490:	4705                	li	a4,1
		for (pp = proc; pp < &proc[NPROC]; pp++) {
    80002492:	fd349de3          	bne	s1,s3,8000246c <wait+0x76>
		if (!havekids || killed(p)) {
    80002496:	cb69                	beqz	a4,80002568 <wait+0x172>
int
killed(struct proc *p)
{
	int k = undefined;

	acquire(&p->lock);
    80002498:	854a                	mv	a0,s2
    8000249a:	ffffe097          	auipc	ra,0xffffe
    8000249e:	7c6080e7          	jalr	1990(ra) # 80000c60 <acquire>
	k = p->killed;
    800024a2:	02892483          	lw	s1,40(s2)
	release(&p->lock);
    800024a6:	854a                	mv	a0,s2
    800024a8:	fffff097          	auipc	ra,0xfffff
    800024ac:	878080e7          	jalr	-1928(ra) # 80000d20 <release>
		if (!havekids || killed(p)) {
    800024b0:	ecc5                	bnez	s1,80002568 <wait+0x172>
	push_off();
    800024b2:	ffffe097          	auipc	ra,0xffffe
    800024b6:	762080e7          	jalr	1890(ra) # 80000c14 <push_off>
    800024ba:	8792                	mv	a5,tp
	struct proc *p = c->proc;
    800024bc:	2781                	sext.w	a5,a5
    800024be:	079e                	sll	a5,a5,0x7
    800024c0:	97de                	add	a5,a5,s7
    800024c2:	6384                	ld	s1,0(a5)
	pop_off();
    800024c4:	ffffe097          	auipc	ra,0xffffe
    800024c8:	7fe080e7          	jalr	2046(ra) # 80000cc2 <pop_off>
	acquire(&p->lock);	/* DOC: sleeplock1 */
    800024cc:	8526                	mv	a0,s1
    800024ce:	ffffe097          	auipc	ra,0xffffe
    800024d2:	792080e7          	jalr	1938(ra) # 80000c60 <acquire>
	release(lk);
    800024d6:	855a                	mv	a0,s6
    800024d8:	fffff097          	auipc	ra,0xfffff
    800024dc:	848080e7          	jalr	-1976(ra) # 80000d20 <release>
	p->chan = chan;
    800024e0:	0324b023          	sd	s2,32(s1)
	p->state = SLEEPING;
    800024e4:	0184ac23          	sw	s8,24(s1)
	sched();
    800024e8:	00000097          	auipc	ra,0x0
    800024ec:	e32080e7          	jalr	-462(ra) # 8000231a <sched>
	release(&p->lock);
    800024f0:	8526                	mv	a0,s1
	p->chan = 0;
    800024f2:	0204b023          	sd	zero,32(s1)
	release(&p->lock);
    800024f6:	fffff097          	auipc	ra,0xfffff
    800024fa:	82a080e7          	jalr	-2006(ra) # 80000d20 <release>
	acquire(lk);
    800024fe:	855a                	mv	a0,s6
    80002500:	ffffe097          	auipc	ra,0xffffe
    80002504:	760080e7          	jalr	1888(ra) # 80000c60 <acquire>
}
    80002508:	bf81                	j	80002458 <wait+0x62>
					pid = pp->pid;
    8000250a:	0304a983          	lw	s3,48(s1)
					if (addr != 0 && copyout(p->pagetable, addr, (char *)&pp->xstate,
    8000250e:	000a8e63          	beqz	s5,8000252a <wait+0x134>
    80002512:	05093503          	ld	a0,80(s2)
    80002516:	4691                	li	a3,4
    80002518:	02c48613          	add	a2,s1,44
    8000251c:	85d6                	mv	a1,s5
    8000251e:	fffff097          	auipc	ra,0xfffff
    80002522:	3b8080e7          	jalr	952(ra) # 800018d6 <copyout>
    80002526:	04054b63          	bltz	a0,8000257c <wait+0x186>
					freeproc(pp);
    8000252a:	8526                	mv	a0,s1
    8000252c:	fffff097          	auipc	ra,0xfffff
    80002530:	69e080e7          	jalr	1694(ra) # 80001bca <freeproc>
					release(&pp->lock);
    80002534:	8526                	mv	a0,s1
    80002536:	ffffe097          	auipc	ra,0xffffe
    8000253a:	7ea080e7          	jalr	2026(ra) # 80000d20 <release>
					release(&wait_lock);
    8000253e:	0000f517          	auipc	a0,0xf
    80002542:	e8a50513          	add	a0,a0,-374 # 800113c8 <wait_lock>
    80002546:	ffffe097          	auipc	ra,0xffffe
    8000254a:	7da080e7          	jalr	2010(ra) # 80000d20 <release>
}
    8000254e:	60a6                	ld	ra,72(sp)
    80002550:	6406                	ld	s0,64(sp)
    80002552:	74e2                	ld	s1,56(sp)
    80002554:	7942                	ld	s2,48(sp)
    80002556:	7a02                	ld	s4,32(sp)
    80002558:	6ae2                	ld	s5,24(sp)
    8000255a:	6b42                	ld	s6,16(sp)
    8000255c:	6ba2                	ld	s7,8(sp)
    8000255e:	6c02                	ld	s8,0(sp)
    80002560:	854e                	mv	a0,s3
    80002562:	79a2                	ld	s3,40(sp)
    80002564:	6161                	add	sp,sp,80
    80002566:	8082                	ret
			release(&wait_lock);
    80002568:	0000f517          	auipc	a0,0xf
    8000256c:	e6050513          	add	a0,a0,-416 # 800113c8 <wait_lock>
    80002570:	ffffe097          	auipc	ra,0xffffe
    80002574:	7b0080e7          	jalr	1968(ra) # 80000d20 <release>
						return -1;
    80002578:	59fd                	li	s3,-1
    8000257a:	bfd1                	j	8000254e <wait+0x158>
						release(&pp->lock);
    8000257c:	8526                	mv	a0,s1
    8000257e:	ffffe097          	auipc	ra,0xffffe
    80002582:	7a2080e7          	jalr	1954(ra) # 80000d20 <release>
						release(&wait_lock);
    80002586:	0000f517          	auipc	a0,0xf
    8000258a:	e4250513          	add	a0,a0,-446 # 800113c8 <wait_lock>
    8000258e:	ffffe097          	auipc	ra,0xffffe
    80002592:	792080e7          	jalr	1938(ra) # 80000d20 <release>
						return -1;
    80002596:	59fd                	li	s3,-1
    80002598:	bf5d                	j	8000254e <wait+0x158>

000000008000259a <yield>:
{
    8000259a:	1101                	add	sp,sp,-32
    8000259c:	e822                	sd	s0,16(sp)
    8000259e:	ec06                	sd	ra,24(sp)
    800025a0:	e426                	sd	s1,8(sp)
    800025a2:	1000                	add	s0,sp,32
	push_off();
    800025a4:	ffffe097          	auipc	ra,0xffffe
    800025a8:	670080e7          	jalr	1648(ra) # 80000c14 <push_off>
    800025ac:	8792                	mv	a5,tp
	struct proc *p = c->proc;
    800025ae:	2781                	sext.w	a5,a5
    800025b0:	0000f717          	auipc	a4,0xf
    800025b4:	a0070713          	add	a4,a4,-1536 # 80010fb0 <cpus>
    800025b8:	079e                	sll	a5,a5,0x7
    800025ba:	97ba                	add	a5,a5,a4
    800025bc:	6384                	ld	s1,0(a5)
	pop_off();
    800025be:	ffffe097          	auipc	ra,0xffffe
    800025c2:	704080e7          	jalr	1796(ra) # 80000cc2 <pop_off>
	acquire(&p->lock);
    800025c6:	8526                	mv	a0,s1
    800025c8:	ffffe097          	auipc	ra,0xffffe
    800025cc:	698080e7          	jalr	1688(ra) # 80000c60 <acquire>
	p->state = RUNNABLE;
    800025d0:	478d                	li	a5,3
    800025d2:	cc9c                	sw	a5,24(s1)
	sched();
    800025d4:	00000097          	auipc	ra,0x0
    800025d8:	d46080e7          	jalr	-698(ra) # 8000231a <sched>
}
    800025dc:	6442                	ld	s0,16(sp)
    800025de:	60e2                	ld	ra,24(sp)
	release(&p->lock);
    800025e0:	8526                	mv	a0,s1
}
    800025e2:	64a2                	ld	s1,8(sp)
    800025e4:	6105                	add	sp,sp,32
	release(&p->lock);
    800025e6:	ffffe317          	auipc	t1,0xffffe
    800025ea:	73a30067          	jr	1850(t1) # 80000d20 <release>

00000000800025ee <sleep>:
{
    800025ee:	7179                	add	sp,sp,-48
    800025f0:	f022                	sd	s0,32(sp)
    800025f2:	e84a                	sd	s2,16(sp)
    800025f4:	e44e                	sd	s3,8(sp)
    800025f6:	f406                	sd	ra,40(sp)
    800025f8:	ec26                	sd	s1,24(sp)
    800025fa:	1800                	add	s0,sp,48
    800025fc:	89aa                	mv	s3,a0
    800025fe:	892e                	mv	s2,a1
	push_off();
    80002600:	ffffe097          	auipc	ra,0xffffe
    80002604:	614080e7          	jalr	1556(ra) # 80000c14 <push_off>
    80002608:	8792                	mv	a5,tp
	struct proc *p = c->proc;
    8000260a:	2781                	sext.w	a5,a5
    8000260c:	0000f717          	auipc	a4,0xf
    80002610:	9a470713          	add	a4,a4,-1628 # 80010fb0 <cpus>
    80002614:	079e                	sll	a5,a5,0x7
    80002616:	97ba                	add	a5,a5,a4
    80002618:	6384                	ld	s1,0(a5)
	pop_off();
    8000261a:	ffffe097          	auipc	ra,0xffffe
    8000261e:	6a8080e7          	jalr	1704(ra) # 80000cc2 <pop_off>
	acquire(&p->lock);	/* DOC: sleeplock1 */
    80002622:	8526                	mv	a0,s1
    80002624:	ffffe097          	auipc	ra,0xffffe
    80002628:	63c080e7          	jalr	1596(ra) # 80000c60 <acquire>
	release(lk);
    8000262c:	854a                	mv	a0,s2
    8000262e:	ffffe097          	auipc	ra,0xffffe
    80002632:	6f2080e7          	jalr	1778(ra) # 80000d20 <release>
	p->state = SLEEPING;
    80002636:	4789                	li	a5,2
	p->chan = chan;
    80002638:	0334b023          	sd	s3,32(s1)
	p->state = SLEEPING;
    8000263c:	cc9c                	sw	a5,24(s1)
	sched();
    8000263e:	00000097          	auipc	ra,0x0
    80002642:	cdc080e7          	jalr	-804(ra) # 8000231a <sched>
	release(&p->lock);
    80002646:	8526                	mv	a0,s1
	p->chan = 0;
    80002648:	0204b023          	sd	zero,32(s1)
	release(&p->lock);
    8000264c:	ffffe097          	auipc	ra,0xffffe
    80002650:	6d4080e7          	jalr	1748(ra) # 80000d20 <release>
}
    80002654:	7402                	ld	s0,32(sp)
    80002656:	70a2                	ld	ra,40(sp)
    80002658:	64e2                	ld	s1,24(sp)
    8000265a:	69a2                	ld	s3,8(sp)
	acquire(lk);
    8000265c:	854a                	mv	a0,s2
}
    8000265e:	6942                	ld	s2,16(sp)
    80002660:	6145                	add	sp,sp,48
	acquire(lk);
    80002662:	ffffe317          	auipc	t1,0xffffe
    80002666:	5fe30067          	jr	1534(t1) # 80000c60 <acquire>

000000008000266a <wakeup>:
{
    8000266a:	715d                	add	sp,sp,-80
    8000266c:	e0a2                	sd	s0,64(sp)
    8000266e:	fc26                	sd	s1,56(sp)
    80002670:	f44e                	sd	s3,40(sp)
    80002672:	f052                	sd	s4,32(sp)
    80002674:	ec56                	sd	s5,24(sp)
    80002676:	e85a                	sd	s6,16(sp)
    80002678:	e45e                	sd	s7,8(sp)
    8000267a:	e486                	sd	ra,72(sp)
    8000267c:	f84a                	sd	s2,48(sp)
    8000267e:	0880                	add	s0,sp,80
    80002680:	8b2a                	mv	s6,a0
	for (p = proc; p < &proc[NPROC]; p++) {
    80002682:	0000f497          	auipc	s1,0xf
    80002686:	d5e48493          	add	s1,s1,-674 # 800113e0 <proc>
    8000268a:	0000fa17          	auipc	s4,0xf
    8000268e:	926a0a13          	add	s4,s4,-1754 # 80010fb0 <cpus>
    80002692:	00014997          	auipc	s3,0x14
    80002696:	74e98993          	add	s3,s3,1870 # 80016de0 <tickslock>
			if (p->state == SLEEPING && p->chan == chan) {
    8000269a:	4a89                	li	s5,2
				p->state = RUNNABLE;
    8000269c:	4b8d                	li	s7,3
    8000269e:	a809                	j	800026b0 <wakeup+0x46>
			release(&p->lock);
    800026a0:	ffffe097          	auipc	ra,0xffffe
    800026a4:	680080e7          	jalr	1664(ra) # 80000d20 <release>
	for (p = proc; p < &proc[NPROC]; p++) {
    800026a8:	16848493          	add	s1,s1,360
    800026ac:	05348163          	beq	s1,s3,800026ee <wakeup+0x84>
	push_off();
    800026b0:	ffffe097          	auipc	ra,0xffffe
    800026b4:	564080e7          	jalr	1380(ra) # 80000c14 <push_off>
    800026b8:	8792                	mv	a5,tp
	struct proc *p = c->proc;
    800026ba:	2781                	sext.w	a5,a5
    800026bc:	079e                	sll	a5,a5,0x7
    800026be:	97d2                	add	a5,a5,s4
    800026c0:	0007b903          	ld	s2,0(a5)
	pop_off();
    800026c4:	ffffe097          	auipc	ra,0xffffe
    800026c8:	5fe080e7          	jalr	1534(ra) # 80000cc2 <pop_off>
			acquire(&p->lock);
    800026cc:	8526                	mv	a0,s1
		if (p != myproc()) {
    800026ce:	fd248de3          	beq	s1,s2,800026a8 <wakeup+0x3e>
			acquire(&p->lock);
    800026d2:	ffffe097          	auipc	ra,0xffffe
    800026d6:	58e080e7          	jalr	1422(ra) # 80000c60 <acquire>
			if (p->state == SLEEPING && p->chan == chan) {
    800026da:	4c9c                	lw	a5,24(s1)
			release(&p->lock);
    800026dc:	8526                	mv	a0,s1
			if (p->state == SLEEPING && p->chan == chan) {
    800026de:	fd5791e3          	bne	a5,s5,800026a0 <wakeup+0x36>
    800026e2:	709c                	ld	a5,32(s1)
    800026e4:	fb679ee3          	bne	a5,s6,800026a0 <wakeup+0x36>
				p->state = RUNNABLE;
    800026e8:	0174ac23          	sw	s7,24(s1)
    800026ec:	bf55                	j	800026a0 <wakeup+0x36>
}
    800026ee:	60a6                	ld	ra,72(sp)
    800026f0:	6406                	ld	s0,64(sp)
    800026f2:	74e2                	ld	s1,56(sp)
    800026f4:	7942                	ld	s2,48(sp)
    800026f6:	79a2                	ld	s3,40(sp)
    800026f8:	7a02                	ld	s4,32(sp)
    800026fa:	6ae2                	ld	s5,24(sp)
    800026fc:	6b42                	ld	s6,16(sp)
    800026fe:	6ba2                	ld	s7,8(sp)
    80002700:	6161                	add	sp,sp,80
    80002702:	8082                	ret

0000000080002704 <reparent>:
{
    80002704:	7179                	add	sp,sp,-48
    80002706:	f022                	sd	s0,32(sp)
    80002708:	ec26                	sd	s1,24(sp)
    8000270a:	e84a                	sd	s2,16(sp)
    8000270c:	e44e                	sd	s3,8(sp)
    8000270e:	e052                	sd	s4,0(sp)
    80002710:	f406                	sd	ra,40(sp)
    80002712:	1800                	add	s0,sp,48
    80002714:	892a                	mv	s2,a0
	for (pp = proc; pp < &proc[NPROC]; pp++) {
    80002716:	0000f497          	auipc	s1,0xf
    8000271a:	cca48493          	add	s1,s1,-822 # 800113e0 <proc>
    8000271e:	00014997          	auipc	s3,0x14
    80002722:	6c298993          	add	s3,s3,1730 # 80016de0 <tickslock>
			pp->parent = initproc;
    80002726:	00006a17          	auipc	s4,0x6
    8000272a:	612a0a13          	add	s4,s4,1554 # 80008d38 <initproc>
    8000272e:	a029                	j	80002738 <reparent+0x34>
	for (pp = proc; pp < &proc[NPROC]; pp++) {
    80002730:	16848493          	add	s1,s1,360
    80002734:	03348163          	beq	s1,s3,80002756 <reparent+0x52>
		if (pp->parent == p) {
    80002738:	7c9c                	ld	a5,56(s1)
    8000273a:	ff279be3          	bne	a5,s2,80002730 <reparent+0x2c>
			pp->parent = initproc;
    8000273e:	000a3503          	ld	a0,0(s4)
	for (pp = proc; pp < &proc[NPROC]; pp++) {
    80002742:	16848493          	add	s1,s1,360
			pp->parent = initproc;
    80002746:	eca4b823          	sd	a0,-304(s1)
			wakeup(initproc);
    8000274a:	00000097          	auipc	ra,0x0
    8000274e:	f20080e7          	jalr	-224(ra) # 8000266a <wakeup>
	for (pp = proc; pp < &proc[NPROC]; pp++) {
    80002752:	ff3493e3          	bne	s1,s3,80002738 <reparent+0x34>
}
    80002756:	70a2                	ld	ra,40(sp)
    80002758:	7402                	ld	s0,32(sp)
    8000275a:	64e2                	ld	s1,24(sp)
    8000275c:	6942                	ld	s2,16(sp)
    8000275e:	69a2                	ld	s3,8(sp)
    80002760:	6a02                	ld	s4,0(sp)
    80002762:	6145                	add	sp,sp,48
    80002764:	8082                	ret

0000000080002766 <exit>:
{
    80002766:	7179                	add	sp,sp,-48
    80002768:	f022                	sd	s0,32(sp)
    8000276a:	e052                	sd	s4,0(sp)
    8000276c:	f406                	sd	ra,40(sp)
    8000276e:	1800                	add	s0,sp,48
    80002770:	8a2a                	mv	s4,a0
	struct proc *p = myproc();
    80002772:	fffff097          	auipc	ra,0xfffff
    80002776:	67e080e7          	jalr	1662(ra) # 80001df0 <myproc>
	if (p == initproc)
    8000277a:	00006797          	auipc	a5,0x6
    8000277e:	5be7b783          	ld	a5,1470(a5) # 80008d38 <initproc>
    80002782:	ec26                	sd	s1,24(sp)
    80002784:	e84a                	sd	s2,16(sp)
    80002786:	e44e                	sd	s3,8(sp)
    80002788:	0aa78363          	beq	a5,a0,8000282e <exit+0xc8>
    8000278c:	89aa                	mv	s3,a0
    8000278e:	0d050493          	add	s1,a0,208
    80002792:	15050913          	add	s2,a0,336
		if (p->ofile[fd]) {
    80002796:	6088                	ld	a0,0(s1)
    80002798:	c519                	beqz	a0,800027a6 <exit+0x40>
			fileclose(f);
    8000279a:	00002097          	auipc	ra,0x2
    8000279e:	4e6080e7          	jalr	1254(ra) # 80004c80 <fileclose>
			p->ofile[fd] = 0;
    800027a2:	0004b023          	sd	zero,0(s1)
	for (int fd = 0; fd < NOFILE; fd++) {
    800027a6:	04a1                	add	s1,s1,8
    800027a8:	ff2497e3          	bne	s1,s2,80002796 <exit+0x30>
	begin_op();
    800027ac:	00002097          	auipc	ra,0x2
    800027b0:	028080e7          	jalr	40(ra) # 800047d4 <begin_op>
	iput(p->cwd);
    800027b4:	1509b503          	ld	a0,336(s3)
    800027b8:	00001097          	auipc	ra,0x1
    800027bc:	756080e7          	jalr	1878(ra) # 80003f0e <iput>
	end_op();
    800027c0:	00002097          	auipc	ra,0x2
    800027c4:	084080e7          	jalr	132(ra) # 80004844 <end_op>
	acquire(&wait_lock);
    800027c8:	0000f517          	auipc	a0,0xf
    800027cc:	c0050513          	add	a0,a0,-1024 # 800113c8 <wait_lock>
	p->cwd = 0;
    800027d0:	1409b823          	sd	zero,336(s3)
	acquire(&wait_lock);
    800027d4:	ffffe097          	auipc	ra,0xffffe
    800027d8:	48c080e7          	jalr	1164(ra) # 80000c60 <acquire>
	reparent(p);
    800027dc:	854e                	mv	a0,s3
    800027de:	00000097          	auipc	ra,0x0
    800027e2:	f26080e7          	jalr	-218(ra) # 80002704 <reparent>
	wakeup(p->parent);
    800027e6:	0389b503          	ld	a0,56(s3)
    800027ea:	00000097          	auipc	ra,0x0
    800027ee:	e80080e7          	jalr	-384(ra) # 8000266a <wakeup>
	acquire(&p->lock);
    800027f2:	854e                	mv	a0,s3
    800027f4:	ffffe097          	auipc	ra,0xffffe
    800027f8:	46c080e7          	jalr	1132(ra) # 80000c60 <acquire>
	p->state = ZOMBIE;
    800027fc:	4795                	li	a5,5
	release(&wait_lock);
    800027fe:	0000f517          	auipc	a0,0xf
    80002802:	bca50513          	add	a0,a0,-1078 # 800113c8 <wait_lock>
	p->state = ZOMBIE;
    80002806:	00f9ac23          	sw	a5,24(s3)
	p->xstate = status;
    8000280a:	0349a623          	sw	s4,44(s3)
	release(&wait_lock);
    8000280e:	ffffe097          	auipc	ra,0xffffe
    80002812:	512080e7          	jalr	1298(ra) # 80000d20 <release>
	sched();
    80002816:	00000097          	auipc	ra,0x0
    8000281a:	b04080e7          	jalr	-1276(ra) # 8000231a <sched>
	panic("zombie exit");
    8000281e:	00006517          	auipc	a0,0x6
    80002822:	e8250513          	add	a0,a0,-382 # 800086a0 <etext+0x6a0>
    80002826:	ffffe097          	auipc	ra,0xffffe
    8000282a:	d70080e7          	jalr	-656(ra) # 80000596 <panic>
		panic("init exiting");
    8000282e:	00006517          	auipc	a0,0x6
    80002832:	e6250513          	add	a0,a0,-414 # 80008690 <etext+0x690>
    80002836:	ffffe097          	auipc	ra,0xffffe
    8000283a:	d60080e7          	jalr	-672(ra) # 80000596 <panic>

000000008000283e <kill>:
{
    8000283e:	7179                	add	sp,sp,-48
    80002840:	f022                	sd	s0,32(sp)
    80002842:	ec26                	sd	s1,24(sp)
    80002844:	e84a                	sd	s2,16(sp)
    80002846:	e44e                	sd	s3,8(sp)
    80002848:	f406                	sd	ra,40(sp)
    8000284a:	1800                	add	s0,sp,48
    8000284c:	892a                	mv	s2,a0
	for (p = proc; p < &proc[NPROC]; p++) {
    8000284e:	0000f497          	auipc	s1,0xf
    80002852:	b9248493          	add	s1,s1,-1134 # 800113e0 <proc>
    80002856:	00014997          	auipc	s3,0x14
    8000285a:	58a98993          	add	s3,s3,1418 # 80016de0 <tickslock>
    8000285e:	a809                	j	80002870 <kill+0x32>
    80002860:	16848493          	add	s1,s1,360
		release(&p->lock);
    80002864:	ffffe097          	auipc	ra,0xffffe
    80002868:	4bc080e7          	jalr	1212(ra) # 80000d20 <release>
	for (p = proc; p < &proc[NPROC]; p++) {
    8000286c:	05348063          	beq	s1,s3,800028ac <kill+0x6e>
		acquire(&p->lock);
    80002870:	8526                	mv	a0,s1
    80002872:	ffffe097          	auipc	ra,0xffffe
    80002876:	3ee080e7          	jalr	1006(ra) # 80000c60 <acquire>
		if (p->pid == pid) {
    8000287a:	589c                	lw	a5,48(s1)
		release(&p->lock);
    8000287c:	8526                	mv	a0,s1
		if (p->pid == pid) {
    8000287e:	ff2791e3          	bne	a5,s2,80002860 <kill+0x22>
			if (p->state == SLEEPING) {
    80002882:	4c98                	lw	a4,24(s1)
			p->killed = 1;
    80002884:	4785                	li	a5,1
    80002886:	d49c                	sw	a5,40(s1)
			if (p->state == SLEEPING) {
    80002888:	4789                	li	a5,2
    8000288a:	00f71463          	bne	a4,a5,80002892 <kill+0x54>
				p->state = RUNNABLE;
    8000288e:	478d                	li	a5,3
    80002890:	cc9c                	sw	a5,24(s1)
			release(&p->lock);
    80002892:	8526                	mv	a0,s1
    80002894:	ffffe097          	auipc	ra,0xffffe
    80002898:	48c080e7          	jalr	1164(ra) # 80000d20 <release>
}
    8000289c:	70a2                	ld	ra,40(sp)
    8000289e:	7402                	ld	s0,32(sp)
    800028a0:	64e2                	ld	s1,24(sp)
    800028a2:	6942                	ld	s2,16(sp)
    800028a4:	69a2                	ld	s3,8(sp)
			return 0;
    800028a6:	4501                	li	a0,0
}
    800028a8:	6145                	add	sp,sp,48
    800028aa:	8082                	ret
    800028ac:	70a2                	ld	ra,40(sp)
    800028ae:	7402                	ld	s0,32(sp)
    800028b0:	64e2                	ld	s1,24(sp)
    800028b2:	6942                	ld	s2,16(sp)
    800028b4:	69a2                	ld	s3,8(sp)
	return -1;
    800028b6:	557d                	li	a0,-1
}
    800028b8:	6145                	add	sp,sp,48
    800028ba:	8082                	ret

00000000800028bc <setkilled>:
{
    800028bc:	1101                	add	sp,sp,-32
    800028be:	e822                	sd	s0,16(sp)
    800028c0:	e426                	sd	s1,8(sp)
    800028c2:	ec06                	sd	ra,24(sp)
    800028c4:	1000                	add	s0,sp,32
    800028c6:	84aa                	mv	s1,a0
	acquire(&p->lock);
    800028c8:	ffffe097          	auipc	ra,0xffffe
    800028cc:	398080e7          	jalr	920(ra) # 80000c60 <acquire>
	p->killed = 1;
    800028d0:	4785                	li	a5,1
}
    800028d2:	6442                	ld	s0,16(sp)
    800028d4:	60e2                	ld	ra,24(sp)
	p->killed = 1;
    800028d6:	d49c                	sw	a5,40(s1)
	release(&p->lock);
    800028d8:	8526                	mv	a0,s1
}
    800028da:	64a2                	ld	s1,8(sp)
    800028dc:	6105                	add	sp,sp,32
	release(&p->lock);
    800028de:	ffffe317          	auipc	t1,0xffffe
    800028e2:	44230067          	jr	1090(t1) # 80000d20 <release>

00000000800028e6 <killed>:
{
    800028e6:	1101                	add	sp,sp,-32
    800028e8:	ec06                	sd	ra,24(sp)
    800028ea:	e822                	sd	s0,16(sp)
    800028ec:	e426                	sd	s1,8(sp)
    800028ee:	1000                	add	s0,sp,32
    800028f0:	84aa                	mv	s1,a0
	acquire(&p->lock);
    800028f2:	ffffe097          	auipc	ra,0xffffe
    800028f6:	36e080e7          	jalr	878(ra) # 80000c60 <acquire>
	release(&p->lock);
    800028fa:	8526                	mv	a0,s1
	k = p->killed;
    800028fc:	5484                	lw	s1,40(s1)
	release(&p->lock);
    800028fe:	ffffe097          	auipc	ra,0xffffe
    80002902:	422080e7          	jalr	1058(ra) # 80000d20 <release>
	return k;
}
    80002906:	60e2                	ld	ra,24(sp)
    80002908:	6442                	ld	s0,16(sp)
    8000290a:	8526                	mv	a0,s1
    8000290c:	64a2                	ld	s1,8(sp)
    8000290e:	6105                	add	sp,sp,32
    80002910:	8082                	ret

0000000080002912 <either_copyout>:
 * depending on usr_dst.
 * Returns 0 on success, -1 on error.
 */
int
either_copyout(int user_dst, uint64 dst, void *src, uint64 len)
{
    80002912:	7139                	add	sp,sp,-64
    80002914:	f822                	sd	s0,48(sp)
    80002916:	f426                	sd	s1,40(sp)
    80002918:	f04a                	sd	s2,32(sp)
    8000291a:	ec4e                	sd	s3,24(sp)
    8000291c:	e852                	sd	s4,16(sp)
    8000291e:	fc06                	sd	ra,56(sp)
    80002920:	e456                	sd	s5,8(sp)
    80002922:	0080                	add	s0,sp,64
    80002924:	8a2a                	mv	s4,a0
    80002926:	84ae                	mv	s1,a1
    80002928:	8932                	mv	s2,a2
    8000292a:	89b6                	mv	s3,a3
	push_off();
    8000292c:	ffffe097          	auipc	ra,0xffffe
    80002930:	2e8080e7          	jalr	744(ra) # 80000c14 <push_off>
    80002934:	8792                	mv	a5,tp
	struct proc *p = c->proc;
    80002936:	2781                	sext.w	a5,a5
    80002938:	079e                	sll	a5,a5,0x7
    8000293a:	0000e717          	auipc	a4,0xe
    8000293e:	67670713          	add	a4,a4,1654 # 80010fb0 <cpus>
    80002942:	97ba                	add	a5,a5,a4
    80002944:	0007ba83          	ld	s5,0(a5)
	pop_off();
    80002948:	ffffe097          	auipc	ra,0xffffe
    8000294c:	37a080e7          	jalr	890(ra) # 80000cc2 <pop_off>
	struct proc *p = myproc();
	if (user_dst) {
    80002950:	020a0363          	beqz	s4,80002976 <either_copyout+0x64>
		return copyout(p->pagetable, dst, src, len);
	} else {
		memmove((char *)dst, src, len);
		return 0;
	}
}
    80002954:	7442                	ld	s0,48(sp)
		return copyout(p->pagetable, dst, src, len);
    80002956:	050ab503          	ld	a0,80(s5)
}
    8000295a:	70e2                	ld	ra,56(sp)
    8000295c:	6a42                	ld	s4,16(sp)
    8000295e:	6aa2                	ld	s5,8(sp)
		return copyout(p->pagetable, dst, src, len);
    80002960:	86ce                	mv	a3,s3
    80002962:	864a                	mv	a2,s2
}
    80002964:	69e2                	ld	s3,24(sp)
    80002966:	7902                	ld	s2,32(sp)
		return copyout(p->pagetable, dst, src, len);
    80002968:	85a6                	mv	a1,s1
}
    8000296a:	74a2                	ld	s1,40(sp)
    8000296c:	6121                	add	sp,sp,64
		return copyout(p->pagetable, dst, src, len);
    8000296e:	fffff317          	auipc	t1,0xfffff
    80002972:	f6830067          	jr	-152(t1) # 800018d6 <copyout>
		memmove((char *)dst, src, len);
    80002976:	0009861b          	sext.w	a2,s3
    8000297a:	85ca                	mv	a1,s2
    8000297c:	8526                	mv	a0,s1
    8000297e:	ffffe097          	auipc	ra,0xffffe
    80002982:	4aa080e7          	jalr	1194(ra) # 80000e28 <memmove>
}
    80002986:	70e2                	ld	ra,56(sp)
    80002988:	7442                	ld	s0,48(sp)
    8000298a:	74a2                	ld	s1,40(sp)
    8000298c:	7902                	ld	s2,32(sp)
    8000298e:	69e2                	ld	s3,24(sp)
    80002990:	6a42                	ld	s4,16(sp)
    80002992:	6aa2                	ld	s5,8(sp)
    80002994:	4501                	li	a0,0
    80002996:	6121                	add	sp,sp,64
    80002998:	8082                	ret

000000008000299a <either_copyin>:
 * depending on usr_src.
 * Returns 0 on success, -1 on error.
 */
int
either_copyin(void *dst, int user_src, uint64 src, uint64 len)
{
    8000299a:	7139                	add	sp,sp,-64
    8000299c:	f822                	sd	s0,48(sp)
    8000299e:	f426                	sd	s1,40(sp)
    800029a0:	f04a                	sd	s2,32(sp)
    800029a2:	ec4e                	sd	s3,24(sp)
    800029a4:	e852                	sd	s4,16(sp)
    800029a6:	fc06                	sd	ra,56(sp)
    800029a8:	e456                	sd	s5,8(sp)
    800029aa:	0080                	add	s0,sp,64
    800029ac:	84aa                	mv	s1,a0
    800029ae:	8a2e                	mv	s4,a1
    800029b0:	8932                	mv	s2,a2
    800029b2:	89b6                	mv	s3,a3
	push_off();
    800029b4:	ffffe097          	auipc	ra,0xffffe
    800029b8:	260080e7          	jalr	608(ra) # 80000c14 <push_off>
    800029bc:	8792                	mv	a5,tp
	struct proc *p = c->proc;
    800029be:	2781                	sext.w	a5,a5
    800029c0:	079e                	sll	a5,a5,0x7
    800029c2:	0000e717          	auipc	a4,0xe
    800029c6:	5ee70713          	add	a4,a4,1518 # 80010fb0 <cpus>
    800029ca:	97ba                	add	a5,a5,a4
    800029cc:	0007ba83          	ld	s5,0(a5)
	pop_off();
    800029d0:	ffffe097          	auipc	ra,0xffffe
    800029d4:	2f2080e7          	jalr	754(ra) # 80000cc2 <pop_off>
	struct proc *p = myproc();
	if (user_src) {
    800029d8:	020a0363          	beqz	s4,800029fe <either_copyin+0x64>
		return copyin(p->pagetable, dst, src, len);
	} else {
		memmove(dst, (char *)src, len);
		return 0;
	}
}
    800029dc:	7442                	ld	s0,48(sp)
		return copyin(p->pagetable, dst, src, len);
    800029de:	050ab503          	ld	a0,80(s5)
}
    800029e2:	70e2                	ld	ra,56(sp)
    800029e4:	6a42                	ld	s4,16(sp)
    800029e6:	6aa2                	ld	s5,8(sp)
		return copyin(p->pagetable, dst, src, len);
    800029e8:	86ce                	mv	a3,s3
    800029ea:	864a                	mv	a2,s2
}
    800029ec:	69e2                	ld	s3,24(sp)
    800029ee:	7902                	ld	s2,32(sp)
		return copyin(p->pagetable, dst, src, len);
    800029f0:	85a6                	mv	a1,s1
}
    800029f2:	74a2                	ld	s1,40(sp)
    800029f4:	6121                	add	sp,sp,64
		return copyin(p->pagetable, dst, src, len);
    800029f6:	fffff317          	auipc	t1,0xfffff
    800029fa:	fac30067          	jr	-84(t1) # 800019a2 <copyin>
		memmove(dst, (char *)src, len);
    800029fe:	0009861b          	sext.w	a2,s3
    80002a02:	85ca                	mv	a1,s2
    80002a04:	8526                	mv	a0,s1
    80002a06:	ffffe097          	auipc	ra,0xffffe
    80002a0a:	422080e7          	jalr	1058(ra) # 80000e28 <memmove>
}
    80002a0e:	70e2                	ld	ra,56(sp)
    80002a10:	7442                	ld	s0,48(sp)
    80002a12:	74a2                	ld	s1,40(sp)
    80002a14:	7902                	ld	s2,32(sp)
    80002a16:	69e2                	ld	s3,24(sp)
    80002a18:	6a42                	ld	s4,16(sp)
    80002a1a:	6aa2                	ld	s5,8(sp)
    80002a1c:	4501                	li	a0,0
    80002a1e:	6121                	add	sp,sp,64
    80002a20:	8082                	ret

0000000080002a22 <procdump>:
 * Runs when user types ^P on console.
 * No lock to avoid wedging a stuck machine further.
 */
void
procdump(void)
{
    80002a22:	715d                	add	sp,sp,-80
    80002a24:	e0a2                	sd	s0,64(sp)
    80002a26:	fc26                	sd	s1,56(sp)
    80002a28:	f84a                	sd	s2,48(sp)
    80002a2a:	f44e                	sd	s3,40(sp)
    80002a2c:	f052                	sd	s4,32(sp)
    80002a2e:	ec56                	sd	s5,24(sp)
    80002a30:	e85a                	sd	s6,16(sp)
    80002a32:	e45e                	sd	s7,8(sp)
    80002a34:	e486                	sd	ra,72(sp)
    80002a36:	0880                	add	s0,sp,80
		[ZOMBIE]         = "zombie"
	};
	struct proc const* p = nullptr;
	char const* state = nullptr;

	printf("\n");
    80002a38:	00005517          	auipc	a0,0x5
    80002a3c:	5e850513          	add	a0,a0,1512 # 80008020 <etext+0x20>
    80002a40:	ffffe097          	auipc	ra,0xffffe
    80002a44:	ba0080e7          	jalr	-1120(ra) # 800005e0 <printf>
	for (p = proc; p < &proc[NPROC]; p++) {
    80002a48:	0000f497          	auipc	s1,0xf
    80002a4c:	af048493          	add	s1,s1,-1296 # 80011538 <proc+0x158>
    80002a50:	00014997          	auipc	s3,0x14
    80002a54:	4e898993          	add	s3,s3,1256 # 80016f38 <bcache+0x140>
		if (p->state == UNUSED)
			continue;
		if (p->state >= 0 && p->state < NELEM(states) && states[p->state])
    80002a58:	4b95                	li	s7,5
			state = states[p->state];
		else
			state = "???";
    80002a5a:	00006a17          	auipc	s4,0x6
    80002a5e:	c56a0a13          	add	s4,s4,-938 # 800086b0 <etext+0x6b0>
		printf("%d %s %s", p->pid, state, p->name);
    80002a62:	00006917          	auipc	s2,0x6
    80002a66:	c5690913          	add	s2,s2,-938 # 800086b8 <etext+0x6b8>
		printf("\n");
    80002a6a:	00005b17          	auipc	s6,0x5
    80002a6e:	5b6b0b13          	add	s6,s6,1462 # 80008020 <etext+0x20>
		if (p->state >= 0 && p->state < NELEM(states) && states[p->state])
    80002a72:	00006a97          	auipc	s5,0x6
    80002a76:	11ea8a93          	add	s5,s5,286 # 80008b90 <states.0>
    80002a7a:	a005                	j	80002a9a <procdump+0x78>
		printf("%d %s %s", p->pid, state, p->name);
    80002a7c:	ed84a583          	lw	a1,-296(s1)
    80002a80:	ffffe097          	auipc	ra,0xffffe
    80002a84:	b60080e7          	jalr	-1184(ra) # 800005e0 <printf>
		printf("\n");
    80002a88:	855a                	mv	a0,s6
    80002a8a:	ffffe097          	auipc	ra,0xffffe
    80002a8e:	b56080e7          	jalr	-1194(ra) # 800005e0 <printf>
	for (p = proc; p < &proc[NPROC]; p++) {
    80002a92:	16848493          	add	s1,s1,360
    80002a96:	03348363          	beq	s1,s3,80002abc <procdump+0x9a>
		if (p->state == UNUSED)
    80002a9a:	ec04a783          	lw	a5,-320(s1)
		printf("%d %s %s", p->pid, state, p->name);
    80002a9e:	86a6                	mv	a3,s1
    80002aa0:	854a                	mv	a0,s2
		if (p->state == UNUSED)
    80002aa2:	dbe5                	beqz	a5,80002a92 <procdump+0x70>
		if (p->state >= 0 && p->state < NELEM(states) && states[p->state])
    80002aa4:	02079613          	sll	a2,a5,0x20
    80002aa8:	01d65713          	srl	a4,a2,0x1d
    80002aac:	9756                	add	a4,a4,s5
			state = "???";
    80002aae:	8652                	mv	a2,s4
		if (p->state >= 0 && p->state < NELEM(states) && states[p->state])
    80002ab0:	fcfbe6e3          	bltu	s7,a5,80002a7c <procdump+0x5a>
    80002ab4:	6310                	ld	a2,0(a4)
    80002ab6:	f279                	bnez	a2,80002a7c <procdump+0x5a>
			state = "???";
    80002ab8:	8652                	mv	a2,s4
    80002aba:	b7c9                	j	80002a7c <procdump+0x5a>
	}
}
    80002abc:	60a6                	ld	ra,72(sp)
    80002abe:	6406                	ld	s0,64(sp)
    80002ac0:	74e2                	ld	s1,56(sp)
    80002ac2:	7942                	ld	s2,48(sp)
    80002ac4:	79a2                	ld	s3,40(sp)
    80002ac6:	7a02                	ld	s4,32(sp)
    80002ac8:	6ae2                	ld	s5,24(sp)
    80002aca:	6b42                	ld	s6,16(sp)
    80002acc:	6ba2                	ld	s7,8(sp)
    80002ace:	6161                	add	sp,sp,80
    80002ad0:	8082                	ret

0000000080002ad2 <swtch>:
    80002ad2:	00153023          	sd	ra,0(a0)
    80002ad6:	00253423          	sd	sp,8(a0)
    80002ada:	e900                	sd	s0,16(a0)
    80002adc:	ed04                	sd	s1,24(a0)
    80002ade:	03253023          	sd	s2,32(a0)
    80002ae2:	03353423          	sd	s3,40(a0)
    80002ae6:	03453823          	sd	s4,48(a0)
    80002aea:	03553c23          	sd	s5,56(a0)
    80002aee:	05653023          	sd	s6,64(a0)
    80002af2:	05753423          	sd	s7,72(a0)
    80002af6:	05853823          	sd	s8,80(a0)
    80002afa:	05953c23          	sd	s9,88(a0)
    80002afe:	07a53023          	sd	s10,96(a0)
    80002b02:	07b53423          	sd	s11,104(a0)
    80002b06:	0005b083          	ld	ra,0(a1)
    80002b0a:	0085b103          	ld	sp,8(a1)
    80002b0e:	6980                	ld	s0,16(a1)
    80002b10:	6d84                	ld	s1,24(a1)
    80002b12:	0205b903          	ld	s2,32(a1)
    80002b16:	0285b983          	ld	s3,40(a1)
    80002b1a:	0305ba03          	ld	s4,48(a1)
    80002b1e:	0385ba83          	ld	s5,56(a1)
    80002b22:	0405bb03          	ld	s6,64(a1)
    80002b26:	0485bb83          	ld	s7,72(a1)
    80002b2a:	0505bc03          	ld	s8,80(a1)
    80002b2e:	0585bc83          	ld	s9,88(a1)
    80002b32:	0605bd03          	ld	s10,96(a1)
    80002b36:	0685bd83          	ld	s11,104(a1)
    80002b3a:	8082                	ret

0000000080002b3c <trapinit>:

extern int devintr();

void
trapinit(void)
{
    80002b3c:	1141                	add	sp,sp,-16
    80002b3e:	e422                	sd	s0,8(sp)
    80002b40:	0800                	add	s0,sp,16
        initlock(&tickslock, "time");
}
    80002b42:	6422                	ld	s0,8(sp)
        initlock(&tickslock, "time");
    80002b44:	00006597          	auipc	a1,0x6
    80002b48:	bb458593          	add	a1,a1,-1100 # 800086f8 <etext+0x6f8>
    80002b4c:	00014517          	auipc	a0,0x14
    80002b50:	29450513          	add	a0,a0,660 # 80016de0 <tickslock>
}
    80002b54:	0141                	add	sp,sp,16
        initlock(&tickslock, "time");
    80002b56:	ffffe317          	auipc	t1,0xffffe
    80002b5a:	07a30067          	jr	122(t1) # 80000bd0 <initlock>

0000000080002b5e <trapinithart>:
/*
 * set up to take exceptions and traps while in the kernel.
 */
void
trapinithart(void)
{
    80002b5e:	1141                	add	sp,sp,-16
    80002b60:	e422                	sd	s0,8(sp)
    80002b62:	0800                	add	s0,sp,16
  __asm__ volatile("csrw stvec, %0" : : "r" (x));
    80002b64:	00004797          	auipc	a5,0x4
    80002b68:	96c78793          	add	a5,a5,-1684 # 800064d0 <kernelvec>
    80002b6c:	10579073          	csrw	stvec,a5
        w_stvec((uint64)kernelvec);
}
    80002b70:	6422                	ld	s0,8(sp)
    80002b72:	0141                	add	sp,sp,16
    80002b74:	8082                	ret

0000000080002b76 <usertrapret>:
/*
 * return to user space
 */
void
usertrapret(void)
{
    80002b76:	1141                	add	sp,sp,-16
    80002b78:	e022                	sd	s0,0(sp)
    80002b7a:	e406                	sd	ra,8(sp)
    80002b7c:	0800                	add	s0,sp,16
        struct proc *p = myproc();
    80002b7e:	fffff097          	auipc	ra,0xfffff
    80002b82:	272080e7          	jalr	626(ra) # 80001df0 <myproc>
  __asm__ volatile("csrr %0, sstatus" : "=r" (x) );
    80002b86:	100027f3          	csrr	a5,sstatus
  w_sstatus(r_sstatus() & ~SSTATUS_SIE);
    80002b8a:	9bf5                	and	a5,a5,-3
  __asm__ volatile("csrw sstatus, %0" : : "r" (x));
    80002b8c:	10079073          	csrw	sstatus,a5
         * we're back in user space, where usertrap() is correct.
         */
        intr_off();

        /* send syscalls, interrupts, and exceptions to uservec in trampoline.S */
        uint64 trampoline_uservec = TRAMPOLINE + (uservec - trampoline);
    80002b90:	040007b7          	lui	a5,0x4000
    80002b94:	00004617          	auipc	a2,0x4
    80002b98:	46c60613          	add	a2,a2,1132 # 80007000 <_trampoline>
    80002b9c:	17fd                	add	a5,a5,-1 # 3ffffff <_entry-0x7c000001>
    80002b9e:	00004717          	auipc	a4,0x4
    80002ba2:	46270713          	add	a4,a4,1122 # 80007000 <_trampoline>
    80002ba6:	8f11                	sub	a4,a4,a2
    80002ba8:	07b2                	sll	a5,a5,0xc
    80002baa:	973e                	add	a4,a4,a5
  __asm__ volatile("csrw stvec, %0" : : "r" (x));
    80002bac:	10571073          	csrw	stvec,a4

        /*
         * set up trapframe values that uservec will need when
         * the process next traps into the kernel.
         */
        p->trapframe->kernel_satp = r_satp();         /* kernel page table */
    80002bb0:	6d38                	ld	a4,88(a0)
  __asm__ volatile("csrr %0, satp" : "=r" (x) );
    80002bb2:	180025f3          	csrr	a1,satp
        p->trapframe->kernel_sp = p->kstack + PGSIZE; /* process's kernel stack */
    80002bb6:	6134                	ld	a3,64(a0)
    80002bb8:	6805                	lui	a6,0x1
        p->trapframe->kernel_satp = r_satp();         /* kernel page table */
    80002bba:	e30c                	sd	a1,0(a4)
        p->trapframe->kernel_sp = p->kstack + PGSIZE; /* process's kernel stack */
    80002bbc:	96c2                	add	a3,a3,a6
    80002bbe:	e714                	sd	a3,8(a4)
        p->trapframe->kernel_trap = (uint64)usertrap;
    80002bc0:	00000697          	auipc	a3,0x0
    80002bc4:	15868693          	add	a3,a3,344 # 80002d18 <usertrap>
    80002bc8:	eb14                	sd	a3,16(a4)
  __asm__ volatile("mv %0, tp" : "=r" (x) );
    80002bca:	8692                	mv	a3,tp
        p->trapframe->kernel_hartid = r_tp();         /* hartid for cpuid() */
    80002bcc:	f314                	sd	a3,32(a4)
  __asm__ volatile("csrr %0, sstatus" : "=r" (x) );
    80002bce:	100026f3          	csrr	a3,sstatus
         * to get to user space.
         */

        /* set S Previous Privilege mode to User. */
        unsigned long x = r_sstatus();
        x &= ~SSTATUS_SPP; /* clear SPP to 0 for user mode */
    80002bd2:	eff6f693          	and	a3,a3,-257
        x |= SSTATUS_SPIE; /* enable interrupts in user mode */
    80002bd6:	0206e693          	or	a3,a3,32
  __asm__ volatile("csrw sstatus, %0" : : "r" (x));
    80002bda:	10069073          	csrw	sstatus,a3
  __asm__ volatile("csrw sepc, %0" : : "r" (x));
    80002bde:	6f18                	ld	a4,24(a4)
    80002be0:	14171073          	csrw	sepc,a4
        /*
         * jump to userret in trampoline.S at the top of memory, which 
         * switches to the user page table, restores user registers,
         * and switches to user mode with sret.
         */
        uint64 trampoline_userret = TRAMPOLINE + (userret - trampoline);
    80002be4:	00004717          	auipc	a4,0x4
    80002be8:	4b870713          	add	a4,a4,1208 # 8000709c <userret>
        uint64 satp = MAKE_SATP(p->pagetable);
    80002bec:	6928                	ld	a0,80(a0)
        ((void (*)(uint64))trampoline_userret)(satp);
}
    80002bee:	6402                	ld	s0,0(sp)
        uint64 trampoline_userret = TRAMPOLINE + (userret - trampoline);
    80002bf0:	8f11                	sub	a4,a4,a2
}
    80002bf2:	60a2                	ld	ra,8(sp)
        uint64 trampoline_userret = TRAMPOLINE + (userret - trampoline);
    80002bf4:	97ba                	add	a5,a5,a4
        ((void (*)(uint64))trampoline_userret)(satp);
    80002bf6:	577d                	li	a4,-1
        uint64 satp = MAKE_SATP(p->pagetable);
    80002bf8:	8131                	srl	a0,a0,0xc
        ((void (*)(uint64))trampoline_userret)(satp);
    80002bfa:	177e                	sll	a4,a4,0x3f
    80002bfc:	8d59                	or	a0,a0,a4
}
    80002bfe:	0141                	add	sp,sp,16
        ((void (*)(uint64))trampoline_userret)(satp);
    80002c00:	8782                	jr	a5

0000000080002c02 <clockintr>:
        w_sstatus(sstatus);
}

void
clockintr()
{
    80002c02:	1101                	add	sp,sp,-32
    80002c04:	ec06                	sd	ra,24(sp)
    80002c06:	e822                	sd	s0,16(sp)
    80002c08:	e426                	sd	s1,8(sp)
    80002c0a:	1000                	add	s0,sp,32
        acquire(&tickslock);
    80002c0c:	00014497          	auipc	s1,0x14
    80002c10:	1d448493          	add	s1,s1,468 # 80016de0 <tickslock>
    80002c14:	8526                	mv	a0,s1
    80002c16:	ffffe097          	auipc	ra,0xffffe
    80002c1a:	04a080e7          	jalr	74(ra) # 80000c60 <acquire>
        ticks++;
    80002c1e:	00006517          	auipc	a0,0x6
    80002c22:	12250513          	add	a0,a0,290 # 80008d40 <ticks>
    80002c26:	411c                	lw	a5,0(a0)
    80002c28:	2785                	addw	a5,a5,1
    80002c2a:	c11c                	sw	a5,0(a0)
        wakeup(&ticks);
    80002c2c:	00000097          	auipc	ra,0x0
    80002c30:	a3e080e7          	jalr	-1474(ra) # 8000266a <wakeup>
        release(&tickslock);
}
    80002c34:	6442                	ld	s0,16(sp)
    80002c36:	60e2                	ld	ra,24(sp)
        release(&tickslock);
    80002c38:	8526                	mv	a0,s1
}
    80002c3a:	64a2                	ld	s1,8(sp)
    80002c3c:	6105                	add	sp,sp,32
        release(&tickslock);
    80002c3e:	ffffe317          	auipc	t1,0xffffe
    80002c42:	0e230067          	jr	226(t1) # 80000d20 <release>

0000000080002c46 <devintr>:
  __asm__ volatile("csrr %0, scause" : "=r" (x) );
    80002c46:	142027f3          	csrr	a5,scause
                 */
                w_sip(r_sip() & ~2);

                return 2;
        } else {
                return 0;
    80002c4a:	4501                	li	a0,0
        if((scause & 0x8000000000000000L) &&
    80002c4c:	0207d463          	bgez	a5,80002c74 <devintr+0x2e>
{
    80002c50:	1101                	add	sp,sp,-32
    80002c52:	e822                	sd	s0,16(sp)
    80002c54:	ec06                	sd	ra,24(sp)
    80002c56:	1000                	add	s0,sp,32
                        (scause & 0xff) == 9){
    80002c58:	0ff7f713          	zext.b	a4,a5
        if((scause & 0x8000000000000000L) &&
    80002c5c:	46a5                	li	a3,9
    80002c5e:	02d70863          	beq	a4,a3,80002c8e <devintr+0x48>
        } else if(scause == 0x8000000000000001L){
    80002c62:	577d                	li	a4,-1
    80002c64:	177e                	sll	a4,a4,0x3f
    80002c66:	0705                	add	a4,a4,1
    80002c68:	00e78763          	beq	a5,a4,80002c76 <devintr+0x30>
        }
}
    80002c6c:	60e2                	ld	ra,24(sp)
    80002c6e:	6442                	ld	s0,16(sp)
    80002c70:	6105                	add	sp,sp,32
    80002c72:	8082                	ret
    80002c74:	8082                	ret
                if(cpuid() == 0){
    80002c76:	fffff097          	auipc	ra,0xfffff
    80002c7a:	14e080e7          	jalr	334(ra) # 80001dc4 <cpuid>
    80002c7e:	c905                	beqz	a0,80002cae <devintr+0x68>
  __asm__ volatile("csrr %0, sip" : "=r" (x) );
    80002c80:	144027f3          	csrr	a5,sip
                w_sip(r_sip() & ~2);
    80002c84:	9bf5                	and	a5,a5,-3
  __asm__ volatile("csrw sip, %0" : : "r" (x));
    80002c86:	14479073          	csrw	sip,a5
                return 2;
    80002c8a:	4509                	li	a0,2
    80002c8c:	b7c5                	j	80002c6c <devintr+0x26>
    80002c8e:	e426                	sd	s1,8(sp)
                int irq = plic_claim();
    80002c90:	00004097          	auipc	ra,0x4
    80002c94:	94c080e7          	jalr	-1716(ra) # 800065dc <plic_claim>
                if(irq == UART0_IRQ){
    80002c98:	47a9                	li	a5,10
                int irq = plic_claim();
    80002c9a:	84aa                	mv	s1,a0
                if(irq == UART0_IRQ){
    80002c9c:	06f50963          	beq	a0,a5,80002d0e <devintr+0xc8>
                } else if(irq == VIRTIO0_IRQ){
    80002ca0:	4785                	li	a5,1
    80002ca2:	04f50263          	beq	a0,a5,80002ce6 <devintr+0xa0>
                } else if(irq){
    80002ca6:	e931                	bnez	a0,80002cfa <devintr+0xb4>
    80002ca8:	64a2                	ld	s1,8(sp)
{
    80002caa:	4505                	li	a0,1
    80002cac:	b7c1                	j	80002c6c <devintr+0x26>
        acquire(&tickslock);
    80002cae:	00014517          	auipc	a0,0x14
    80002cb2:	13250513          	add	a0,a0,306 # 80016de0 <tickslock>
    80002cb6:	ffffe097          	auipc	ra,0xffffe
    80002cba:	faa080e7          	jalr	-86(ra) # 80000c60 <acquire>
        ticks++;
    80002cbe:	00006517          	auipc	a0,0x6
    80002cc2:	08250513          	add	a0,a0,130 # 80008d40 <ticks>
    80002cc6:	411c                	lw	a5,0(a0)
    80002cc8:	2785                	addw	a5,a5,1
    80002cca:	c11c                	sw	a5,0(a0)
        wakeup(&ticks);
    80002ccc:	00000097          	auipc	ra,0x0
    80002cd0:	99e080e7          	jalr	-1634(ra) # 8000266a <wakeup>
        release(&tickslock);
    80002cd4:	00014517          	auipc	a0,0x14
    80002cd8:	10c50513          	add	a0,a0,268 # 80016de0 <tickslock>
    80002cdc:	ffffe097          	auipc	ra,0xffffe
    80002ce0:	044080e7          	jalr	68(ra) # 80000d20 <release>
}
    80002ce4:	bf71                	j	80002c80 <devintr+0x3a>
                        virtio_disk_intr();
    80002ce6:	00004097          	auipc	ra,0x4
    80002cea:	db2080e7          	jalr	-590(ra) # 80006a98 <virtio_disk_intr>
                        plic_complete(irq);
    80002cee:	8526                	mv	a0,s1
    80002cf0:	00004097          	auipc	ra,0x4
    80002cf4:	910080e7          	jalr	-1776(ra) # 80006600 <plic_complete>
    80002cf8:	bf45                	j	80002ca8 <devintr+0x62>
                        printf("unexpected interrupt irq=%d\n", irq);
    80002cfa:	85aa                	mv	a1,a0
    80002cfc:	00006517          	auipc	a0,0x6
    80002d00:	a0450513          	add	a0,a0,-1532 # 80008700 <etext+0x700>
    80002d04:	ffffe097          	auipc	ra,0xffffe
    80002d08:	8dc080e7          	jalr	-1828(ra) # 800005e0 <printf>
                if(irq)
    80002d0c:	b7cd                	j	80002cee <devintr+0xa8>
                        uartintr();
    80002d0e:	ffffe097          	auipc	ra,0xffffe
    80002d12:	cd6080e7          	jalr	-810(ra) # 800009e4 <uartintr>
                if(irq)
    80002d16:	bfe1                	j	80002cee <devintr+0xa8>

0000000080002d18 <usertrap>:
{
    80002d18:	1101                	add	sp,sp,-32
    80002d1a:	e822                	sd	s0,16(sp)
    80002d1c:	ec06                	sd	ra,24(sp)
    80002d1e:	1000                	add	s0,sp,32
  __asm__ volatile("csrr %0, sstatus" : "=r" (x) );
    80002d20:	100027f3          	csrr	a5,sstatus
        if((r_sstatus() & SSTATUS_SPP) != 0)
    80002d24:	1007f793          	and	a5,a5,256
    80002d28:	e426                	sd	s1,8(sp)
    80002d2a:	12079963          	bnez	a5,80002e5c <usertrap+0x144>
  __asm__ volatile("csrw stvec, %0" : : "r" (x));
    80002d2e:	00003797          	auipc	a5,0x3
    80002d32:	7a278793          	add	a5,a5,1954 # 800064d0 <kernelvec>
    80002d36:	10579073          	csrw	stvec,a5
        struct proc *p = myproc();
    80002d3a:	fffff097          	auipc	ra,0xfffff
    80002d3e:	0b6080e7          	jalr	182(ra) # 80001df0 <myproc>
    80002d42:	84aa                	mv	s1,a0
  __asm__ volatile("csrr %0, sepc" : "=r" (x) );
    80002d44:	14102773          	csrr	a4,sepc
        p->trapframe->epc = r_sepc();
    80002d48:	6d3c                	ld	a5,88(a0)
    80002d4a:	ef98                	sd	a4,24(a5)
  __asm__ volatile("csrr %0, scause" : "=r" (x) );
    80002d4c:	14202773          	csrr	a4,scause
        if(r_scause() == 8){
    80002d50:	47a1                	li	a5,8
    80002d52:	08f70f63          	beq	a4,a5,80002df0 <usertrap+0xd8>
    80002d56:	e04a                	sd	s2,0(sp)
        } else if((which_dev = devintr()) != 0){
    80002d58:	00000097          	auipc	ra,0x0
    80002d5c:	eee080e7          	jalr	-274(ra) # 80002c46 <devintr>
    80002d60:	892a                	mv	s2,a0
    80002d62:	c51d                	beqz	a0,80002d90 <usertrap+0x78>
        if(killed(p))
    80002d64:	8526                	mv	a0,s1
    80002d66:	00000097          	auipc	ra,0x0
    80002d6a:	b80080e7          	jalr	-1152(ra) # 800028e6 <killed>
    80002d6e:	e979                	bnez	a0,80002e44 <usertrap+0x12c>
        if(which_dev == 2)
    80002d70:	4789                	li	a5,2
    80002d72:	0cf91063          	bne	s2,a5,80002e32 <usertrap+0x11a>
                yield();
    80002d76:	00000097          	auipc	ra,0x0
    80002d7a:	824080e7          	jalr	-2012(ra) # 8000259a <yield>
    80002d7e:	6902                	ld	s2,0(sp)
}
    80002d80:	6442                	ld	s0,16(sp)
        usertrapret();
    80002d82:	64a2                	ld	s1,8(sp)
}
    80002d84:	60e2                	ld	ra,24(sp)
    80002d86:	6105                	add	sp,sp,32
        usertrapret();
    80002d88:	00000317          	auipc	t1,0x0
    80002d8c:	dee30067          	jr	-530(t1) # 80002b76 <usertrapret>
    80002d90:	142025f3          	csrr	a1,scause
                printf("usertrap(): unexpected scause %p pid=%d\n", r_scause(), p->pid);
    80002d94:	5890                	lw	a2,48(s1)
    80002d96:	00006517          	auipc	a0,0x6
    80002d9a:	9aa50513          	add	a0,a0,-1622 # 80008740 <etext+0x740>
    80002d9e:	ffffe097          	auipc	ra,0xffffe
    80002da2:	842080e7          	jalr	-1982(ra) # 800005e0 <printf>
  __asm__ volatile("csrr %0, sepc" : "=r" (x) );
    80002da6:	141025f3          	csrr	a1,sepc
  __asm__ volatile("csrr %0, stval" : "=r" (x) );
    80002daa:	14302673          	csrr	a2,stval
                printf("            sepc=%p stval=%p\n", r_sepc(), r_stval());
    80002dae:	00006517          	auipc	a0,0x6
    80002db2:	9c250513          	add	a0,a0,-1598 # 80008770 <etext+0x770>
    80002db6:	ffffe097          	auipc	ra,0xffffe
    80002dba:	82a080e7          	jalr	-2006(ra) # 800005e0 <printf>
                setkilled(p);
    80002dbe:	8526                	mv	a0,s1
    80002dc0:	00000097          	auipc	ra,0x0
    80002dc4:	afc080e7          	jalr	-1284(ra) # 800028bc <setkilled>
        if(killed(p))
    80002dc8:	8526                	mv	a0,s1
    80002dca:	00000097          	auipc	ra,0x0
    80002dce:	b1c080e7          	jalr	-1252(ra) # 800028e6 <killed>
    80002dd2:	6902                	ld	s2,0(sp)
    80002dd4:	d555                	beqz	a0,80002d80 <usertrap+0x68>
                exit(-1);
    80002dd6:	557d                	li	a0,-1
    80002dd8:	00000097          	auipc	ra,0x0
    80002ddc:	98e080e7          	jalr	-1650(ra) # 80002766 <exit>
}
    80002de0:	6442                	ld	s0,16(sp)
        usertrapret();
    80002de2:	64a2                	ld	s1,8(sp)
}
    80002de4:	60e2                	ld	ra,24(sp)
    80002de6:	6105                	add	sp,sp,32
        usertrapret();
    80002de8:	00000317          	auipc	t1,0x0
    80002dec:	d8e30067          	jr	-626(t1) # 80002b76 <usertrapret>
                if(killed(p))
    80002df0:	00000097          	auipc	ra,0x0
    80002df4:	af6080e7          	jalr	-1290(ra) # 800028e6 <killed>
    80002df8:	ed21                	bnez	a0,80002e50 <usertrap+0x138>
                p->trapframe->epc += 4;
    80002dfa:	6cb8                	ld	a4,88(s1)
    80002dfc:	6f1c                	ld	a5,24(a4)
    80002dfe:	0791                	add	a5,a5,4
    80002e00:	ef1c                	sd	a5,24(a4)
  __asm__ volatile("csrr %0, sstatus" : "=r" (x) );
    80002e02:	100027f3          	csrr	a5,sstatus
  w_sstatus(r_sstatus() | SSTATUS_SIE);
    80002e06:	0027e793          	or	a5,a5,2
  __asm__ volatile("csrw sstatus, %0" : : "r" (x));
    80002e0a:	10079073          	csrw	sstatus,a5
                syscall();
    80002e0e:	00000097          	auipc	ra,0x0
    80002e12:	3e8080e7          	jalr	1000(ra) # 800031f6 <syscall>
        if(killed(p))
    80002e16:	8526                	mv	a0,s1
    80002e18:	00000097          	auipc	ra,0x0
    80002e1c:	ace080e7          	jalr	-1330(ra) # 800028e6 <killed>
    80002e20:	f95d                	bnez	a0,80002dd6 <usertrap+0xbe>
}
    80002e22:	6442                	ld	s0,16(sp)
        usertrapret();
    80002e24:	64a2                	ld	s1,8(sp)
}
    80002e26:	60e2                	ld	ra,24(sp)
    80002e28:	6105                	add	sp,sp,32
        usertrapret();
    80002e2a:	00000317          	auipc	t1,0x0
    80002e2e:	d4c30067          	jr	-692(t1) # 80002b76 <usertrapret>
}
    80002e32:	6442                	ld	s0,16(sp)
    80002e34:	6902                	ld	s2,0(sp)
        usertrapret();
    80002e36:	64a2                	ld	s1,8(sp)
}
    80002e38:	60e2                	ld	ra,24(sp)
    80002e3a:	6105                	add	sp,sp,32
        usertrapret();
    80002e3c:	00000317          	auipc	t1,0x0
    80002e40:	d3a30067          	jr	-710(t1) # 80002b76 <usertrapret>
                exit(-1);
    80002e44:	557d                	li	a0,-1
    80002e46:	00000097          	auipc	ra,0x0
    80002e4a:	920080e7          	jalr	-1760(ra) # 80002766 <exit>
    80002e4e:	b70d                	j	80002d70 <usertrap+0x58>
                        exit(-1);
    80002e50:	557d                	li	a0,-1
    80002e52:	00000097          	auipc	ra,0x0
    80002e56:	914080e7          	jalr	-1772(ra) # 80002766 <exit>
    80002e5a:	b745                	j	80002dfa <usertrap+0xe2>
                panic("usertrap: not from user mode");
    80002e5c:	00006517          	auipc	a0,0x6
    80002e60:	8c450513          	add	a0,a0,-1852 # 80008720 <etext+0x720>
    80002e64:	e04a                	sd	s2,0(sp)
    80002e66:	ffffd097          	auipc	ra,0xffffd
    80002e6a:	730080e7          	jalr	1840(ra) # 80000596 <panic>

0000000080002e6e <kerneltrap>:
{
    80002e6e:	7179                	add	sp,sp,-48
    80002e70:	f022                	sd	s0,32(sp)
    80002e72:	f406                	sd	ra,40(sp)
    80002e74:	ec26                	sd	s1,24(sp)
    80002e76:	e84a                	sd	s2,16(sp)
    80002e78:	e44e                	sd	s3,8(sp)
    80002e7a:	1800                	add	s0,sp,48
  __asm__ volatile("csrr %0, sepc" : "=r" (x) );
    80002e7c:	14102973          	csrr	s2,sepc
  __asm__ volatile("csrr %0, sstatus" : "=r" (x) );
    80002e80:	100024f3          	csrr	s1,sstatus
  __asm__ volatile("csrr %0, scause" : "=r" (x) );
    80002e84:	142029f3          	csrr	s3,scause
        if((sstatus & SSTATUS_SPP) == 0)
    80002e88:	1004f793          	and	a5,s1,256
    80002e8c:	cfd9                	beqz	a5,80002f2a <kerneltrap+0xbc>
  __asm__ volatile("csrr %0, sstatus" : "=r" (x) );
    80002e8e:	100027f3          	csrr	a5,sstatus
  return (x & SSTATUS_SIE) != 0;
    80002e92:	8b89                	and	a5,a5,2
        if(intr_get() != 0)
    80002e94:	e3d9                	bnez	a5,80002f1a <kerneltrap+0xac>
        if((which_dev = devintr()) == 0){
    80002e96:	00000097          	auipc	ra,0x0
    80002e9a:	db0080e7          	jalr	-592(ra) # 80002c46 <devintr>
    80002e9e:	c129                	beqz	a0,80002ee0 <kerneltrap+0x72>
        if(which_dev == 2 && myproc() != 0 && myproc()->state == RUNNING)
    80002ea0:	4789                	li	a5,2
    80002ea2:	00f50d63          	beq	a0,a5,80002ebc <kerneltrap+0x4e>
  __asm__ volatile("csrw sepc, %0" : : "r" (x));
    80002ea6:	14191073          	csrw	sepc,s2
  __asm__ volatile("csrw sstatus, %0" : : "r" (x));
    80002eaa:	10049073          	csrw	sstatus,s1
}
    80002eae:	70a2                	ld	ra,40(sp)
    80002eb0:	7402                	ld	s0,32(sp)
    80002eb2:	64e2                	ld	s1,24(sp)
    80002eb4:	6942                	ld	s2,16(sp)
    80002eb6:	69a2                	ld	s3,8(sp)
    80002eb8:	6145                	add	sp,sp,48
    80002eba:	8082                	ret
        if(which_dev == 2 && myproc() != 0 && myproc()->state == RUNNING)
    80002ebc:	fffff097          	auipc	ra,0xfffff
    80002ec0:	f34080e7          	jalr	-204(ra) # 80001df0 <myproc>
    80002ec4:	d16d                	beqz	a0,80002ea6 <kerneltrap+0x38>
    80002ec6:	fffff097          	auipc	ra,0xfffff
    80002eca:	f2a080e7          	jalr	-214(ra) # 80001df0 <myproc>
    80002ece:	4d18                	lw	a4,24(a0)
    80002ed0:	4791                	li	a5,4
    80002ed2:	fcf71ae3          	bne	a4,a5,80002ea6 <kerneltrap+0x38>
                yield();
    80002ed6:	fffff097          	auipc	ra,0xfffff
    80002eda:	6c4080e7          	jalr	1732(ra) # 8000259a <yield>
    80002ede:	b7e1                	j	80002ea6 <kerneltrap+0x38>
                printf("scause %p\n", scause);
    80002ee0:	85ce                	mv	a1,s3
    80002ee2:	00006517          	auipc	a0,0x6
    80002ee6:	8f650513          	add	a0,a0,-1802 # 800087d8 <etext+0x7d8>
    80002eea:	ffffd097          	auipc	ra,0xffffd
    80002eee:	6f6080e7          	jalr	1782(ra) # 800005e0 <printf>
  __asm__ volatile("csrr %0, sepc" : "=r" (x) );
    80002ef2:	141025f3          	csrr	a1,sepc
  __asm__ volatile("csrr %0, stval" : "=r" (x) );
    80002ef6:	14302673          	csrr	a2,stval
                printf("sepc=%p stval=%p\n", r_sepc(), r_stval());
    80002efa:	00006517          	auipc	a0,0x6
    80002efe:	8ee50513          	add	a0,a0,-1810 # 800087e8 <etext+0x7e8>
    80002f02:	ffffd097          	auipc	ra,0xffffd
    80002f06:	6de080e7          	jalr	1758(ra) # 800005e0 <printf>
                panic("kerneltrap");
    80002f0a:	00006517          	auipc	a0,0x6
    80002f0e:	8f650513          	add	a0,a0,-1802 # 80008800 <etext+0x800>
    80002f12:	ffffd097          	auipc	ra,0xffffd
    80002f16:	684080e7          	jalr	1668(ra) # 80000596 <panic>
                panic("kerneltrap: interrupts enabled");
    80002f1a:	00006517          	auipc	a0,0x6
    80002f1e:	89e50513          	add	a0,a0,-1890 # 800087b8 <etext+0x7b8>
    80002f22:	ffffd097          	auipc	ra,0xffffd
    80002f26:	674080e7          	jalr	1652(ra) # 80000596 <panic>
                panic("kerneltrap: not from supervisor mode");
    80002f2a:	00006517          	auipc	a0,0x6
    80002f2e:	86650513          	add	a0,a0,-1946 # 80008790 <etext+0x790>
    80002f32:	ffffd097          	auipc	ra,0xffffd
    80002f36:	664080e7          	jalr	1636(ra) # 80000596 <panic>

0000000080002f3a <fetchaddr>:
/*
 * Fetch the uint64 at addr from the current process.
 */
int
fetchaddr(uint64 addr, uint64 * ip)
{
    80002f3a:	1101                	add	sp,sp,-32
    80002f3c:	e822                	sd	s0,16(sp)
    80002f3e:	e426                	sd	s1,8(sp)
    80002f40:	e04a                	sd	s2,0(sp)
    80002f42:	ec06                	sd	ra,24(sp)
    80002f44:	1000                	add	s0,sp,32
    80002f46:	84aa                	mv	s1,a0
    80002f48:	892e                	mv	s2,a1
	struct proc *p = myproc();
    80002f4a:	fffff097          	auipc	ra,0xfffff
    80002f4e:	ea6080e7          	jalr	-346(ra) # 80001df0 <myproc>
	if (addr >= p->sz || addr + sizeof(uint64) > p->sz)	/* both tests needed, in case of overflow */
    80002f52:	653c                	ld	a5,72(a0)
    80002f54:	02f4f863          	bgeu	s1,a5,80002f84 <fetchaddr+0x4a>
    80002f58:	00848713          	add	a4,s1,8
    80002f5c:	02e7e463          	bltu	a5,a4,80002f84 <fetchaddr+0x4a>
		return -1;
	if (copyin(p->pagetable, (char *)ip, addr, sizeof(*ip)) != 0)
    80002f60:	6928                	ld	a0,80(a0)
    80002f62:	46a1                	li	a3,8
    80002f64:	8626                	mv	a2,s1
    80002f66:	85ca                	mv	a1,s2
    80002f68:	fffff097          	auipc	ra,0xfffff
    80002f6c:	a3a080e7          	jalr	-1478(ra) # 800019a2 <copyin>
    80002f70:	00a03533          	snez	a0,a0
    80002f74:	40a00533          	neg	a0,a0
		return -1;
	return 0;
}
    80002f78:	60e2                	ld	ra,24(sp)
    80002f7a:	6442                	ld	s0,16(sp)
    80002f7c:	64a2                	ld	s1,8(sp)
    80002f7e:	6902                	ld	s2,0(sp)
    80002f80:	6105                	add	sp,sp,32
    80002f82:	8082                	ret
		return -1;
    80002f84:	557d                	li	a0,-1
    80002f86:	bfcd                	j	80002f78 <fetchaddr+0x3e>

0000000080002f88 <fetchstr>:
 * Fetch the nul-terminated string at addr from the current process.
 * Returns length of string, not including nul, or -1 for error.
 */
int
fetchstr(uint64 addr, char *buf, int max)
{
    80002f88:	7179                	add	sp,sp,-48
    80002f8a:	f022                	sd	s0,32(sp)
    80002f8c:	ec26                	sd	s1,24(sp)
    80002f8e:	e84a                	sd	s2,16(sp)
    80002f90:	e44e                	sd	s3,8(sp)
    80002f92:	f406                	sd	ra,40(sp)
    80002f94:	1800                	add	s0,sp,48
    80002f96:	89b2                	mv	s3,a2
    80002f98:	892a                	mv	s2,a0
    80002f9a:	84ae                	mv	s1,a1
	struct proc *p = myproc();
    80002f9c:	fffff097          	auipc	ra,0xfffff
    80002fa0:	e54080e7          	jalr	-428(ra) # 80001df0 <myproc>
	if (copyinstr(p->pagetable, buf, addr, max) < 0)
    80002fa4:	6928                	ld	a0,80(a0)
    80002fa6:	86ce                	mv	a3,s3
    80002fa8:	864a                	mv	a2,s2
    80002faa:	85a6                	mv	a1,s1
    80002fac:	fffff097          	auipc	ra,0xfffff
    80002fb0:	ac2080e7          	jalr	-1342(ra) # 80001a6e <copyinstr>
    80002fb4:	00054d63          	bltz	a0,80002fce <fetchstr+0x46>
		return -1;
	return strlen(buf);
}
    80002fb8:	7402                	ld	s0,32(sp)
    80002fba:	70a2                	ld	ra,40(sp)
    80002fbc:	6942                	ld	s2,16(sp)
    80002fbe:	69a2                	ld	s3,8(sp)
	return strlen(buf);
    80002fc0:	8526                	mv	a0,s1
}
    80002fc2:	64e2                	ld	s1,24(sp)
    80002fc4:	6145                	add	sp,sp,48
	return strlen(buf);
    80002fc6:	ffffe317          	auipc	t1,0xffffe
    80002fca:	f9630067          	jr	-106(t1) # 80000f5c <strlen>
}
    80002fce:	70a2                	ld	ra,40(sp)
    80002fd0:	7402                	ld	s0,32(sp)
    80002fd2:	64e2                	ld	s1,24(sp)
    80002fd4:	6942                	ld	s2,16(sp)
    80002fd6:	69a2                	ld	s3,8(sp)
    80002fd8:	557d                	li	a0,-1
    80002fda:	6145                	add	sp,sp,48
    80002fdc:	8082                	ret

0000000080002fde <argint>:
/*
 * Fetch the nth 32-bit system call argument.
 */
void
argint(int n, int *ip)
{
    80002fde:	1101                	add	sp,sp,-32
    80002fe0:	e822                	sd	s0,16(sp)
    80002fe2:	e426                	sd	s1,8(sp)
    80002fe4:	e04a                	sd	s2,0(sp)
    80002fe6:	ec06                	sd	ra,24(sp)
    80002fe8:	1000                	add	s0,sp,32
    80002fea:	84aa                	mv	s1,a0
    80002fec:	892e                	mv	s2,a1
	struct proc *p = myproc();
    80002fee:	fffff097          	auipc	ra,0xfffff
    80002ff2:	e02080e7          	jalr	-510(ra) # 80001df0 <myproc>
	switch (n) {
    80002ff6:	4795                	li	a5,5
    80002ff8:	0897e763          	bltu	a5,s1,80003086 <argint+0xa8>
    80002ffc:	00006717          	auipc	a4,0x6
    80003000:	bc470713          	add	a4,a4,-1084 # 80008bc0 <states.0+0x30>
    80003004:	048a                	sll	s1,s1,0x2
    80003006:	94ba                	add	s1,s1,a4
    80003008:	409c                	lw	a5,0(s1)
    8000300a:	97ba                	add	a5,a5,a4
    8000300c:	8782                	jr	a5
		return p->trapframe->a4;
    8000300e:	6d3c                	ld	a5,88(a0)
	*ip = argraw(n);
}
    80003010:	60e2                	ld	ra,24(sp)
    80003012:	6442                	ld	s0,16(sp)
		return p->trapframe->a4;
    80003014:	6bdc                	ld	a5,144(a5)
}
    80003016:	64a2                	ld	s1,8(sp)
	*ip = argraw(n);
    80003018:	00f92023          	sw	a5,0(s2)
}
    8000301c:	6902                	ld	s2,0(sp)
    8000301e:	6105                	add	sp,sp,32
    80003020:	8082                	ret
		return p->trapframe->a5;
    80003022:	6d3c                	ld	a5,88(a0)
}
    80003024:	60e2                	ld	ra,24(sp)
    80003026:	6442                	ld	s0,16(sp)
		return p->trapframe->a5;
    80003028:	6fdc                	ld	a5,152(a5)
}
    8000302a:	64a2                	ld	s1,8(sp)
	*ip = argraw(n);
    8000302c:	00f92023          	sw	a5,0(s2)
}
    80003030:	6902                	ld	s2,0(sp)
    80003032:	6105                	add	sp,sp,32
    80003034:	8082                	ret
		return p->trapframe->a0;
    80003036:	6d3c                	ld	a5,88(a0)
}
    80003038:	60e2                	ld	ra,24(sp)
    8000303a:	6442                	ld	s0,16(sp)
		return p->trapframe->a0;
    8000303c:	7bbc                	ld	a5,112(a5)
}
    8000303e:	64a2                	ld	s1,8(sp)
	*ip = argraw(n);
    80003040:	00f92023          	sw	a5,0(s2)
}
    80003044:	6902                	ld	s2,0(sp)
    80003046:	6105                	add	sp,sp,32
    80003048:	8082                	ret
		return p->trapframe->a1;
    8000304a:	6d3c                	ld	a5,88(a0)
}
    8000304c:	60e2                	ld	ra,24(sp)
    8000304e:	6442                	ld	s0,16(sp)
		return p->trapframe->a1;
    80003050:	7fbc                	ld	a5,120(a5)
}
    80003052:	64a2                	ld	s1,8(sp)
	*ip = argraw(n);
    80003054:	00f92023          	sw	a5,0(s2)
}
    80003058:	6902                	ld	s2,0(sp)
    8000305a:	6105                	add	sp,sp,32
    8000305c:	8082                	ret
		return p->trapframe->a2;
    8000305e:	6d3c                	ld	a5,88(a0)
}
    80003060:	60e2                	ld	ra,24(sp)
    80003062:	6442                	ld	s0,16(sp)
		return p->trapframe->a2;
    80003064:	63dc                	ld	a5,128(a5)
}
    80003066:	64a2                	ld	s1,8(sp)
	*ip = argraw(n);
    80003068:	00f92023          	sw	a5,0(s2)
}
    8000306c:	6902                	ld	s2,0(sp)
    8000306e:	6105                	add	sp,sp,32
    80003070:	8082                	ret
		return p->trapframe->a3;
    80003072:	6d3c                	ld	a5,88(a0)
}
    80003074:	60e2                	ld	ra,24(sp)
    80003076:	6442                	ld	s0,16(sp)
		return p->trapframe->a3;
    80003078:	67dc                	ld	a5,136(a5)
}
    8000307a:	64a2                	ld	s1,8(sp)
	*ip = argraw(n);
    8000307c:	00f92023          	sw	a5,0(s2)
}
    80003080:	6902                	ld	s2,0(sp)
    80003082:	6105                	add	sp,sp,32
    80003084:	8082                	ret
	panic("argraw");
    80003086:	00005517          	auipc	a0,0x5
    8000308a:	78a50513          	add	a0,a0,1930 # 80008810 <etext+0x810>
    8000308e:	ffffd097          	auipc	ra,0xffffd
    80003092:	508080e7          	jalr	1288(ra) # 80000596 <panic>

0000000080003096 <argaddr>:
 * Doesn't check for legality, since
 * copyin/copyout will do that.
 */
void
argaddr(int n, uint64 * ip)
{
    80003096:	1101                	add	sp,sp,-32
    80003098:	e822                	sd	s0,16(sp)
    8000309a:	e426                	sd	s1,8(sp)
    8000309c:	e04a                	sd	s2,0(sp)
    8000309e:	ec06                	sd	ra,24(sp)
    800030a0:	1000                	add	s0,sp,32
    800030a2:	84aa                	mv	s1,a0
    800030a4:	892e                	mv	s2,a1
	struct proc *p = myproc();
    800030a6:	fffff097          	auipc	ra,0xfffff
    800030aa:	d4a080e7          	jalr	-694(ra) # 80001df0 <myproc>
	switch (n) {
    800030ae:	4795                	li	a5,5
    800030b0:	0897e763          	bltu	a5,s1,8000313e <argaddr+0xa8>
    800030b4:	00006717          	auipc	a4,0x6
    800030b8:	b2470713          	add	a4,a4,-1244 # 80008bd8 <states.0+0x48>
    800030bc:	048a                	sll	s1,s1,0x2
    800030be:	94ba                	add	s1,s1,a4
    800030c0:	409c                	lw	a5,0(s1)
    800030c2:	97ba                	add	a5,a5,a4
    800030c4:	8782                	jr	a5
		return p->trapframe->a4;
    800030c6:	6d3c                	ld	a5,88(a0)
	*ip = argraw(n);
}
    800030c8:	60e2                	ld	ra,24(sp)
    800030ca:	6442                	ld	s0,16(sp)
		return p->trapframe->a4;
    800030cc:	6bdc                	ld	a5,144(a5)
}
    800030ce:	64a2                	ld	s1,8(sp)
	*ip = argraw(n);
    800030d0:	00f93023          	sd	a5,0(s2)
}
    800030d4:	6902                	ld	s2,0(sp)
    800030d6:	6105                	add	sp,sp,32
    800030d8:	8082                	ret
		return p->trapframe->a5;
    800030da:	6d3c                	ld	a5,88(a0)
}
    800030dc:	60e2                	ld	ra,24(sp)
    800030de:	6442                	ld	s0,16(sp)
		return p->trapframe->a5;
    800030e0:	6fdc                	ld	a5,152(a5)
}
    800030e2:	64a2                	ld	s1,8(sp)
	*ip = argraw(n);
    800030e4:	00f93023          	sd	a5,0(s2)
}
    800030e8:	6902                	ld	s2,0(sp)
    800030ea:	6105                	add	sp,sp,32
    800030ec:	8082                	ret
		return p->trapframe->a0;
    800030ee:	6d3c                	ld	a5,88(a0)
}
    800030f0:	60e2                	ld	ra,24(sp)
    800030f2:	6442                	ld	s0,16(sp)
		return p->trapframe->a0;
    800030f4:	7bbc                	ld	a5,112(a5)
}
    800030f6:	64a2                	ld	s1,8(sp)
	*ip = argraw(n);
    800030f8:	00f93023          	sd	a5,0(s2)
}
    800030fc:	6902                	ld	s2,0(sp)
    800030fe:	6105                	add	sp,sp,32
    80003100:	8082                	ret
		return p->trapframe->a1;
    80003102:	6d3c                	ld	a5,88(a0)
}
    80003104:	60e2                	ld	ra,24(sp)
    80003106:	6442                	ld	s0,16(sp)
		return p->trapframe->a1;
    80003108:	7fbc                	ld	a5,120(a5)
}
    8000310a:	64a2                	ld	s1,8(sp)
	*ip = argraw(n);
    8000310c:	00f93023          	sd	a5,0(s2)
}
    80003110:	6902                	ld	s2,0(sp)
    80003112:	6105                	add	sp,sp,32
    80003114:	8082                	ret
		return p->trapframe->a2;
    80003116:	6d3c                	ld	a5,88(a0)
}
    80003118:	60e2                	ld	ra,24(sp)
    8000311a:	6442                	ld	s0,16(sp)
		return p->trapframe->a2;
    8000311c:	63dc                	ld	a5,128(a5)
}
    8000311e:	64a2                	ld	s1,8(sp)
	*ip = argraw(n);
    80003120:	00f93023          	sd	a5,0(s2)
}
    80003124:	6902                	ld	s2,0(sp)
    80003126:	6105                	add	sp,sp,32
    80003128:	8082                	ret
		return p->trapframe->a3;
    8000312a:	6d3c                	ld	a5,88(a0)
}
    8000312c:	60e2                	ld	ra,24(sp)
    8000312e:	6442                	ld	s0,16(sp)
		return p->trapframe->a3;
    80003130:	67dc                	ld	a5,136(a5)
}
    80003132:	64a2                	ld	s1,8(sp)
	*ip = argraw(n);
    80003134:	00f93023          	sd	a5,0(s2)
}
    80003138:	6902                	ld	s2,0(sp)
    8000313a:	6105                	add	sp,sp,32
    8000313c:	8082                	ret
	panic("argraw");
    8000313e:	00005517          	auipc	a0,0x5
    80003142:	6d250513          	add	a0,a0,1746 # 80008810 <etext+0x810>
    80003146:	ffffd097          	auipc	ra,0xffffd
    8000314a:	450080e7          	jalr	1104(ra) # 80000596 <panic>

000000008000314e <argstr>:
 * Copies into buf, at most max.
 * Returns string length if OK (including nul), -1 if error.
 */
int
argstr(int n, char *buf, int max)
{
    8000314e:	7179                	add	sp,sp,-48
    80003150:	f022                	sd	s0,32(sp)
    80003152:	ec26                	sd	s1,24(sp)
    80003154:	e84a                	sd	s2,16(sp)
    80003156:	e44e                	sd	s3,8(sp)
    80003158:	f406                	sd	ra,40(sp)
    8000315a:	1800                	add	s0,sp,48
    8000315c:	84aa                	mv	s1,a0
    8000315e:	892e                	mv	s2,a1
    80003160:	89b2                	mv	s3,a2
	struct proc *p = myproc();
    80003162:	fffff097          	auipc	ra,0xfffff
    80003166:	c8e080e7          	jalr	-882(ra) # 80001df0 <myproc>
	switch (n) {
    8000316a:	4795                	li	a5,5
    8000316c:	0697ed63          	bltu	a5,s1,800031e6 <argstr+0x98>
    80003170:	00006717          	auipc	a4,0x6
    80003174:	a8070713          	add	a4,a4,-1408 # 80008bf0 <states.0+0x60>
    80003178:	048a                	sll	s1,s1,0x2
    8000317a:	94ba                	add	s1,s1,a4
    8000317c:	409c                	lw	a5,0(s1)
    8000317e:	97ba                	add	a5,a5,a4
    80003180:	8782                	jr	a5
		return p->trapframe->a4;
    80003182:	6d3c                	ld	a5,88(a0)
    80003184:	6bc4                	ld	s1,144(a5)
	struct proc *p = myproc();
    80003186:	fffff097          	auipc	ra,0xfffff
    8000318a:	c6a080e7          	jalr	-918(ra) # 80001df0 <myproc>
	if (copyinstr(p->pagetable, buf, addr, max) < 0)
    8000318e:	6928                	ld	a0,80(a0)
    80003190:	86ce                	mv	a3,s3
    80003192:	8626                	mv	a2,s1
    80003194:	85ca                	mv	a1,s2
    80003196:	fffff097          	auipc	ra,0xfffff
    8000319a:	8d8080e7          	jalr	-1832(ra) # 80001a6e <copyinstr>
    8000319e:	02054c63          	bltz	a0,800031d6 <argstr+0x88>
	uint64 addr = undefined;
	argaddr(n, &addr);
	return fetchstr(addr, buf, max);
}
    800031a2:	7402                	ld	s0,32(sp)
    800031a4:	70a2                	ld	ra,40(sp)
    800031a6:	64e2                	ld	s1,24(sp)
    800031a8:	69a2                	ld	s3,8(sp)
	return strlen(buf);
    800031aa:	854a                	mv	a0,s2
}
    800031ac:	6942                	ld	s2,16(sp)
    800031ae:	6145                	add	sp,sp,48
	return strlen(buf);
    800031b0:	ffffe317          	auipc	t1,0xffffe
    800031b4:	dac30067          	jr	-596(t1) # 80000f5c <strlen>
		return p->trapframe->a5;
    800031b8:	6d3c                	ld	a5,88(a0)
    800031ba:	6fc4                	ld	s1,152(a5)
    800031bc:	b7e9                	j	80003186 <argstr+0x38>
		return p->trapframe->a0;
    800031be:	6d3c                	ld	a5,88(a0)
    800031c0:	7ba4                	ld	s1,112(a5)
    800031c2:	b7d1                	j	80003186 <argstr+0x38>
		return p->trapframe->a1;
    800031c4:	6d3c                	ld	a5,88(a0)
    800031c6:	7fa4                	ld	s1,120(a5)
    800031c8:	bf7d                	j	80003186 <argstr+0x38>
		return p->trapframe->a2;
    800031ca:	6d3c                	ld	a5,88(a0)
    800031cc:	63c4                	ld	s1,128(a5)
    800031ce:	bf65                	j	80003186 <argstr+0x38>
		return p->trapframe->a3;
    800031d0:	6d3c                	ld	a5,88(a0)
    800031d2:	67c4                	ld	s1,136(a5)
    800031d4:	bf4d                	j	80003186 <argstr+0x38>
}
    800031d6:	70a2                	ld	ra,40(sp)
    800031d8:	7402                	ld	s0,32(sp)
    800031da:	64e2                	ld	s1,24(sp)
    800031dc:	6942                	ld	s2,16(sp)
    800031de:	69a2                	ld	s3,8(sp)
    800031e0:	557d                	li	a0,-1
    800031e2:	6145                	add	sp,sp,48
    800031e4:	8082                	ret
	panic("argraw");
    800031e6:	00005517          	auipc	a0,0x5
    800031ea:	62a50513          	add	a0,a0,1578 # 80008810 <etext+0x810>
    800031ee:	ffffd097          	auipc	ra,0xffffd
    800031f2:	3a8080e7          	jalr	936(ra) # 80000596 <panic>

00000000800031f6 <syscall>:
	    [SYS_close] = sys_close,
};

void
syscall(void)
{
    800031f6:	1101                	add	sp,sp,-32
    800031f8:	e822                	sd	s0,16(sp)
    800031fa:	e426                	sd	s1,8(sp)
    800031fc:	e04a                	sd	s2,0(sp)
    800031fe:	ec06                	sd	ra,24(sp)
    80003200:	1000                	add	s0,sp,32
	int num = undefined;
	struct proc *p = myproc();
    80003202:	fffff097          	auipc	ra,0xfffff
    80003206:	bee080e7          	jalr	-1042(ra) # 80001df0 <myproc>

	num = p->trapframe->a7;
    8000320a:	05853903          	ld	s2,88(a0)
	if (num > 0 && num < NELEM(syscalls) && syscalls[num]) {
    8000320e:	47d1                	li	a5,20
	struct proc *p = myproc();
    80003210:	84aa                	mv	s1,a0
	num = p->trapframe->a7;
    80003212:	0a893683          	ld	a3,168(s2)
	if (num > 0 && num < NELEM(syscalls) && syscalls[num]) {
    80003216:	fff6871b          	addw	a4,a3,-1
	num = p->trapframe->a7;
    8000321a:	2681                	sext.w	a3,a3
	if (num > 0 && num < NELEM(syscalls) && syscalls[num]) {
    8000321c:	02e7e463          	bltu	a5,a4,80003244 <syscall+0x4e>
    80003220:	00369713          	sll	a4,a3,0x3
    80003224:	00006797          	auipc	a5,0x6
    80003228:	9e478793          	add	a5,a5,-1564 # 80008c08 <syscalls>
    8000322c:	97ba                	add	a5,a5,a4
    8000322e:	639c                	ld	a5,0(a5)
    80003230:	cb91                	beqz	a5,80003244 <syscall+0x4e>
		/* Use num to lookup the system call function for num, call
		 * it, and store its return value in p->trapframe->a0 
                 */
		p->trapframe->a0 = syscalls[num] ();
    80003232:	9782                	jalr	a5
	} else {
		printf("%d %s: unknown sys call %d\n",
		    p->pid, p->name, num);
		p->trapframe->a0 = -1;
	}
}
    80003234:	60e2                	ld	ra,24(sp)
    80003236:	6442                	ld	s0,16(sp)
		p->trapframe->a0 = syscalls[num] ();
    80003238:	06a93823          	sd	a0,112(s2)
}
    8000323c:	64a2                	ld	s1,8(sp)
    8000323e:	6902                	ld	s2,0(sp)
    80003240:	6105                	add	sp,sp,32
    80003242:	8082                	ret
		printf("%d %s: unknown sys call %d\n",
    80003244:	588c                	lw	a1,48(s1)
    80003246:	15848613          	add	a2,s1,344
    8000324a:	00005517          	auipc	a0,0x5
    8000324e:	5ce50513          	add	a0,a0,1486 # 80008818 <etext+0x818>
    80003252:	ffffd097          	auipc	ra,0xffffd
    80003256:	38e080e7          	jalr	910(ra) # 800005e0 <printf>
		p->trapframe->a0 = -1;
    8000325a:	6cbc                	ld	a5,88(s1)
}
    8000325c:	60e2                	ld	ra,24(sp)
    8000325e:	6442                	ld	s0,16(sp)
		p->trapframe->a0 = -1;
    80003260:	577d                	li	a4,-1
    80003262:	fbb8                	sd	a4,112(a5)
}
    80003264:	64a2                	ld	s1,8(sp)
    80003266:	6902                	ld	s2,0(sp)
    80003268:	6105                	add	sp,sp,32
    8000326a:	8082                	ret

000000008000326c <sys_exit>:
#include "spinlock.h"
#include "proc.h"

uint64
sys_exit(void)
{
    8000326c:	1101                	add	sp,sp,-32
    8000326e:	ec06                	sd	ra,24(sp)
    80003270:	e822                	sd	s0,16(sp)
    80003272:	1000                	add	s0,sp,32
        int n = undefined;
        argint(0, &n);
    80003274:	fec40593          	add	a1,s0,-20
    80003278:	4501                	li	a0,0
        int n = undefined;
    8000327a:	fe042623          	sw	zero,-20(s0)
        argint(0, &n);
    8000327e:	00000097          	auipc	ra,0x0
    80003282:	d60080e7          	jalr	-672(ra) # 80002fde <argint>
        exit(n);
    80003286:	fec42503          	lw	a0,-20(s0)
    8000328a:	fffff097          	auipc	ra,0xfffff
    8000328e:	4dc080e7          	jalr	1244(ra) # 80002766 <exit>
        return 0;  /* not reached */
}
    80003292:	60e2                	ld	ra,24(sp)
    80003294:	6442                	ld	s0,16(sp)
    80003296:	4501                	li	a0,0
    80003298:	6105                	add	sp,sp,32
    8000329a:	8082                	ret

000000008000329c <sys_getpid>:

uint64
sys_getpid(void)
{
    8000329c:	1141                	add	sp,sp,-16
    8000329e:	e022                	sd	s0,0(sp)
    800032a0:	e406                	sd	ra,8(sp)
    800032a2:	0800                	add	s0,sp,16
        return myproc()->pid;
    800032a4:	fffff097          	auipc	ra,0xfffff
    800032a8:	b4c080e7          	jalr	-1204(ra) # 80001df0 <myproc>
}
    800032ac:	60a2                	ld	ra,8(sp)
    800032ae:	6402                	ld	s0,0(sp)
    800032b0:	5908                	lw	a0,48(a0)
    800032b2:	0141                	add	sp,sp,16
    800032b4:	8082                	ret

00000000800032b6 <sys_fork>:

uint64
sys_fork(void)
{
    800032b6:	1141                	add	sp,sp,-16
    800032b8:	e022                	sd	s0,0(sp)
    800032ba:	e406                	sd	ra,8(sp)
    800032bc:	0800                	add	s0,sp,16
        return fork();
    800032be:	fffff097          	auipc	ra,0xfffff
    800032c2:	e7e080e7          	jalr	-386(ra) # 8000213c <fork>
}
    800032c6:	60a2                	ld	ra,8(sp)
    800032c8:	6402                	ld	s0,0(sp)
    800032ca:	0141                	add	sp,sp,16
    800032cc:	8082                	ret

00000000800032ce <sys_wait>:

uint64
sys_wait(void)
{
    800032ce:	1101                	add	sp,sp,-32
    800032d0:	ec06                	sd	ra,24(sp)
    800032d2:	e822                	sd	s0,16(sp)
    800032d4:	1000                	add	s0,sp,32
        uint64 p = undefined;
        argaddr(0, &p);
    800032d6:	fe840593          	add	a1,s0,-24
    800032da:	4501                	li	a0,0
        uint64 p = undefined;
    800032dc:	fe043423          	sd	zero,-24(s0)
        argaddr(0, &p);
    800032e0:	00000097          	auipc	ra,0x0
    800032e4:	db6080e7          	jalr	-586(ra) # 80003096 <argaddr>
        return wait(p);
    800032e8:	fe843503          	ld	a0,-24(s0)
    800032ec:	fffff097          	auipc	ra,0xfffff
    800032f0:	10a080e7          	jalr	266(ra) # 800023f6 <wait>
}
    800032f4:	60e2                	ld	ra,24(sp)
    800032f6:	6442                	ld	s0,16(sp)
    800032f8:	6105                	add	sp,sp,32
    800032fa:	8082                	ret

00000000800032fc <sys_sbrk>:

uint64
sys_sbrk(void)
{
    800032fc:	7179                	add	sp,sp,-48
    800032fe:	f406                	sd	ra,40(sp)
    80003300:	f022                	sd	s0,32(sp)
    80003302:	ec26                	sd	s1,24(sp)
    80003304:	1800                	add	s0,sp,48
        uint64 addr = undefined;
        int n = undefined;

        argint(0, &n);
    80003306:	fdc40593          	add	a1,s0,-36
    8000330a:	4501                	li	a0,0
        int n = undefined;
    8000330c:	fc042e23          	sw	zero,-36(s0)
        argint(0, &n);
    80003310:	00000097          	auipc	ra,0x0
    80003314:	cce080e7          	jalr	-818(ra) # 80002fde <argint>
        addr = myproc()->sz;
    80003318:	fffff097          	auipc	ra,0xfffff
    8000331c:	ad8080e7          	jalr	-1320(ra) # 80001df0 <myproc>
    80003320:	87aa                	mv	a5,a0
        if(growproc(n) < 0)
    80003322:	fdc42503          	lw	a0,-36(s0)
        addr = myproc()->sz;
    80003326:	67a4                	ld	s1,72(a5)
        if(growproc(n) < 0)
    80003328:	fffff097          	auipc	ra,0xfffff
    8000332c:	d98080e7          	jalr	-616(ra) # 800020c0 <growproc>
    80003330:	00054863          	bltz	a0,80003340 <sys_sbrk+0x44>
                return -1;
        return addr;
}
    80003334:	70a2                	ld	ra,40(sp)
    80003336:	7402                	ld	s0,32(sp)
    80003338:	8526                	mv	a0,s1
    8000333a:	64e2                	ld	s1,24(sp)
    8000333c:	6145                	add	sp,sp,48
    8000333e:	8082                	ret
    80003340:	70a2                	ld	ra,40(sp)
    80003342:	7402                	ld	s0,32(sp)
                return -1;
    80003344:	54fd                	li	s1,-1
}
    80003346:	8526                	mv	a0,s1
    80003348:	64e2                	ld	s1,24(sp)
    8000334a:	6145                	add	sp,sp,48
    8000334c:	8082                	ret

000000008000334e <sys_sleep>:

uint64
sys_sleep(void)
{
    8000334e:	7139                	add	sp,sp,-64
    80003350:	fc06                	sd	ra,56(sp)
    80003352:	f822                	sd	s0,48(sp)
    80003354:	f426                	sd	s1,40(sp)
    80003356:	0080                	add	s0,sp,64
    80003358:	ec4e                	sd	s3,24(sp)
        int n = undefined;
        uint ticks0 = undefined;

        argint(0, &n);
    8000335a:	fcc40593          	add	a1,s0,-52
    8000335e:	4501                	li	a0,0
        int n = undefined;
    80003360:	fc042623          	sw	zero,-52(s0)
        argint(0, &n);
    80003364:	00000097          	auipc	ra,0x0
    80003368:	c7a080e7          	jalr	-902(ra) # 80002fde <argint>
        acquire(&tickslock);
    8000336c:	00014517          	auipc	a0,0x14
    80003370:	a7450513          	add	a0,a0,-1420 # 80016de0 <tickslock>
    80003374:	ffffe097          	auipc	ra,0xffffe
    80003378:	8ec080e7          	jalr	-1812(ra) # 80000c60 <acquire>
        ticks0 = ticks;
        while(ticks - ticks0 < n){
    8000337c:	fcc42783          	lw	a5,-52(s0)
        ticks0 = ticks;
    80003380:	00006497          	auipc	s1,0x6
    80003384:	9c048493          	add	s1,s1,-1600 # 80008d40 <ticks>
    80003388:	0004a983          	lw	s3,0(s1)
        while(ticks - ticks0 < n){
    8000338c:	cfb9                	beqz	a5,800033ea <sys_sleep+0x9c>
    8000338e:	f04a                	sd	s2,32(sp)
                if(killed(myproc())){
                        release(&tickslock);
                        return -1;
                }
                sleep(&ticks, &tickslock);
    80003390:	00014917          	auipc	s2,0x14
    80003394:	a5090913          	add	s2,s2,-1456 # 80016de0 <tickslock>
    80003398:	a821                	j	800033b0 <sys_sleep+0x62>
    8000339a:	fffff097          	auipc	ra,0xfffff
    8000339e:	254080e7          	jalr	596(ra) # 800025ee <sleep>
        while(ticks - ticks0 < n){
    800033a2:	409c                	lw	a5,0(s1)
    800033a4:	fcc42703          	lw	a4,-52(s0)
    800033a8:	413787bb          	subw	a5,a5,s3
    800033ac:	02e7fe63          	bgeu	a5,a4,800033e8 <sys_sleep+0x9a>
                if(killed(myproc())){
    800033b0:	fffff097          	auipc	ra,0xfffff
    800033b4:	a40080e7          	jalr	-1472(ra) # 80001df0 <myproc>
    800033b8:	fffff097          	auipc	ra,0xfffff
    800033bc:	52e080e7          	jalr	1326(ra) # 800028e6 <killed>
    800033c0:	87aa                	mv	a5,a0
                sleep(&ticks, &tickslock);
    800033c2:	85ca                	mv	a1,s2
    800033c4:	8526                	mv	a0,s1
                if(killed(myproc())){
    800033c6:	dbf1                	beqz	a5,8000339a <sys_sleep+0x4c>
                        release(&tickslock);
    800033c8:	00014517          	auipc	a0,0x14
    800033cc:	a1850513          	add	a0,a0,-1512 # 80016de0 <tickslock>
    800033d0:	ffffe097          	auipc	ra,0xffffe
    800033d4:	950080e7          	jalr	-1712(ra) # 80000d20 <release>
        }
        release(&tickslock);
        return 0;
}
    800033d8:	70e2                	ld	ra,56(sp)
    800033da:	7442                	ld	s0,48(sp)
                        return -1;
    800033dc:	7902                	ld	s2,32(sp)
}
    800033de:	74a2                	ld	s1,40(sp)
    800033e0:	69e2                	ld	s3,24(sp)
                        return -1;
    800033e2:	557d                	li	a0,-1
}
    800033e4:	6121                	add	sp,sp,64
    800033e6:	8082                	ret
    800033e8:	7902                	ld	s2,32(sp)
        release(&tickslock);
    800033ea:	00014517          	auipc	a0,0x14
    800033ee:	9f650513          	add	a0,a0,-1546 # 80016de0 <tickslock>
    800033f2:	ffffe097          	auipc	ra,0xffffe
    800033f6:	92e080e7          	jalr	-1746(ra) # 80000d20 <release>
}
    800033fa:	70e2                	ld	ra,56(sp)
    800033fc:	7442                	ld	s0,48(sp)
    800033fe:	74a2                	ld	s1,40(sp)
    80003400:	69e2                	ld	s3,24(sp)
        return 0;
    80003402:	4501                	li	a0,0
}
    80003404:	6121                	add	sp,sp,64
    80003406:	8082                	ret

0000000080003408 <sys_kill>:

uint64
sys_kill(void)
{
    80003408:	1101                	add	sp,sp,-32
    8000340a:	ec06                	sd	ra,24(sp)
    8000340c:	e822                	sd	s0,16(sp)
    8000340e:	1000                	add	s0,sp,32
        int pid = undefined;

        argint(0, &pid);
    80003410:	fec40593          	add	a1,s0,-20
    80003414:	4501                	li	a0,0
        int pid = undefined;
    80003416:	fe042623          	sw	zero,-20(s0)
        argint(0, &pid);
    8000341a:	00000097          	auipc	ra,0x0
    8000341e:	bc4080e7          	jalr	-1084(ra) # 80002fde <argint>
        return kill(pid);
    80003422:	fec42503          	lw	a0,-20(s0)
    80003426:	fffff097          	auipc	ra,0xfffff
    8000342a:	418080e7          	jalr	1048(ra) # 8000283e <kill>
}
    8000342e:	60e2                	ld	ra,24(sp)
    80003430:	6442                	ld	s0,16(sp)
    80003432:	6105                	add	sp,sp,32
    80003434:	8082                	ret

0000000080003436 <sys_uptime>:
 * return how many clock tick interrupts have occurred
 * since start.
 */
uint64
sys_uptime(void)
{
    80003436:	1101                	add	sp,sp,-32
    80003438:	ec06                	sd	ra,24(sp)
    8000343a:	e822                	sd	s0,16(sp)
    8000343c:	e426                	sd	s1,8(sp)
    8000343e:	1000                	add	s0,sp,32
        uint xticks = undefined;

        acquire(&tickslock);
    80003440:	00014517          	auipc	a0,0x14
    80003444:	9a050513          	add	a0,a0,-1632 # 80016de0 <tickslock>
    80003448:	ffffe097          	auipc	ra,0xffffe
    8000344c:	818080e7          	jalr	-2024(ra) # 80000c60 <acquire>
        xticks = ticks;
        release(&tickslock);
    80003450:	00014517          	auipc	a0,0x14
    80003454:	99050513          	add	a0,a0,-1648 # 80016de0 <tickslock>
        xticks = ticks;
    80003458:	00006497          	auipc	s1,0x6
    8000345c:	8e84a483          	lw	s1,-1816(s1) # 80008d40 <ticks>
        release(&tickslock);
    80003460:	ffffe097          	auipc	ra,0xffffe
    80003464:	8c0080e7          	jalr	-1856(ra) # 80000d20 <release>
        return xticks;
}
    80003468:	60e2                	ld	ra,24(sp)
    8000346a:	6442                	ld	s0,16(sp)
    8000346c:	02049513          	sll	a0,s1,0x20
    80003470:	9101                	srl	a0,a0,0x20
    80003472:	64a2                	ld	s1,8(sp)
    80003474:	6105                	add	sp,sp,32
    80003476:	8082                	ret

0000000080003478 <binit>:

struct bcache bcache = {};

void
binit(void)
{
    80003478:	7139                	add	sp,sp,-64
    8000347a:	f822                	sd	s0,48(sp)
    8000347c:	f426                	sd	s1,40(sp)
    8000347e:	f04a                	sd	s2,32(sp)
    80003480:	ec4e                	sd	s3,24(sp)
    80003482:	e852                	sd	s4,16(sp)
    80003484:	e456                	sd	s5,8(sp)
    80003486:	fc06                	sd	ra,56(sp)
    80003488:	0080                	add	s0,sp,64
	struct buf *b = nullptr;

	initlock(&bcache.lock, "bcache");
    8000348a:	00005597          	auipc	a1,0x5
    8000348e:	3ae58593          	add	a1,a1,942 # 80008838 <etext+0x838>
    80003492:	00014517          	auipc	a0,0x14
    80003496:	96650513          	add	a0,a0,-1690 # 80016df8 <bcache>

	/* Create linked list of buffers */
	bcache.head.prev = &bcache.head;
    8000349a:	0001c997          	auipc	s3,0x1c
    8000349e:	bc698993          	add	s3,s3,-1082 # 8001f060 <bcache+0x8268>
	initlock(&bcache.lock, "bcache");
    800034a2:	ffffd097          	auipc	ra,0xffffd
    800034a6:	72e080e7          	jalr	1838(ra) # 80000bd0 <initlock>
	bcache.head.prev = &bcache.head;
    800034aa:	0001c917          	auipc	s2,0x1c
    800034ae:	94e90913          	add	s2,s2,-1714 # 8001edf8 <bcache+0x8000>
    800034b2:	2b393823          	sd	s3,688(s2)
	bcache.head.next = &bcache.head;
    800034b6:	2b393c23          	sd	s3,696(s2)
    800034ba:	8ace                	mv	s5,s3
    800034bc:	874e                	mv	a4,s3
	for (b = bcache.buf; b < bcache.buf + NBUF; b++) {
    800034be:	00014497          	auipc	s1,0x14
    800034c2:	95248493          	add	s1,s1,-1710 # 80016e10 <bcache+0x18>
		b->next = bcache.head.next;
		b->prev = &bcache.head;
		initsleeplock(&b->lock, "buffer");
    800034c6:	00005a17          	auipc	s4,0x5
    800034ca:	37aa0a13          	add	s4,s4,890 # 80008840 <etext+0x840>
    800034ce:	a011                	j	800034d2 <binit+0x5a>
    800034d0:	84be                	mv	s1,a5
		b->next = bcache.head.next;
    800034d2:	e8b8                	sd	a4,80(s1)
		b->prev = &bcache.head;
    800034d4:	0534b423          	sd	s3,72(s1)
		initsleeplock(&b->lock, "buffer");
    800034d8:	85d2                	mv	a1,s4
    800034da:	01048513          	add	a0,s1,16
    800034de:	00001097          	auipc	ra,0x1
    800034e2:	592080e7          	jalr	1426(ra) # 80004a70 <initsleeplock>
		bcache.head.next->prev = b;
    800034e6:	2b893683          	ld	a3,696(s2)
	for (b = bcache.buf; b < bcache.buf + NBUF; b++) {
    800034ea:	45848793          	add	a5,s1,1112
    800034ee:	8726                	mv	a4,s1
		bcache.head.next->prev = b;
    800034f0:	e6a4                	sd	s1,72(a3)
		bcache.head.next = b;
    800034f2:	2a993c23          	sd	s1,696(s2)
	for (b = bcache.buf; b < bcache.buf + NBUF; b++) {
    800034f6:	fd579de3          	bne	a5,s5,800034d0 <binit+0x58>
	}
}
    800034fa:	70e2                	ld	ra,56(sp)
    800034fc:	7442                	ld	s0,48(sp)
    800034fe:	74a2                	ld	s1,40(sp)
    80003500:	7902                	ld	s2,32(sp)
    80003502:	69e2                	ld	s3,24(sp)
    80003504:	6a42                	ld	s4,16(sp)
    80003506:	6aa2                	ld	s5,8(sp)
    80003508:	6121                	add	sp,sp,64
    8000350a:	8082                	ret

000000008000350c <bread>:
/*
 * Return a locked buf with the contents of the indicated block.
 */
struct buf *
bread(uint dev, uint blockno)
{
    8000350c:	7179                	add	sp,sp,-48
    8000350e:	f022                	sd	s0,32(sp)
    80003510:	ec26                	sd	s1,24(sp)
    80003512:	e84a                	sd	s2,16(sp)
    80003514:	e44e                	sd	s3,8(sp)
    80003516:	e052                	sd	s4,0(sp)
    80003518:	f406                	sd	ra,40(sp)
    8000351a:	1800                	add	s0,sp,48
    8000351c:	02051793          	sll	a5,a0,0x20
    80003520:	9381                	srl	a5,a5,0x20
    80003522:	02059713          	sll	a4,a1,0x20
    80003526:	892a                	mv	s2,a0
	acquire(&bcache.lock);
    80003528:	00014517          	auipc	a0,0x14
    8000352c:	8d050513          	add	a0,a0,-1840 # 80016df8 <bcache>
    80003530:	00e7ea33          	or	s4,a5,a4
{
    80003534:	89ae                	mv	s3,a1
	acquire(&bcache.lock);
    80003536:	ffffd097          	auipc	ra,0xffffd
    8000353a:	72a080e7          	jalr	1834(ra) # 80000c60 <acquire>
	for (b = bcache.head.next; b != &bcache.head; b = b->next) {
    8000353e:	0001c697          	auipc	a3,0x1c
    80003542:	8ba68693          	add	a3,a3,-1862 # 8001edf8 <bcache+0x8000>
    80003546:	2b86b483          	ld	s1,696(a3)
    8000354a:	0001c797          	auipc	a5,0x1c
    8000354e:	b1678793          	add	a5,a5,-1258 # 8001f060 <bcache+0x8268>
    80003552:	00f49663          	bne	s1,a5,8000355e <bread+0x52>
    80003556:	a0b1                	j	800035a2 <bread+0x96>
    80003558:	68a4                	ld	s1,80(s1)
    8000355a:	04f48463          	beq	s1,a5,800035a2 <bread+0x96>
		if (b->dev == dev && b->blockno == blockno) {
    8000355e:	4498                	lw	a4,8(s1)
    80003560:	ff271ce3          	bne	a4,s2,80003558 <bread+0x4c>
    80003564:	44d8                	lw	a4,12(s1)
    80003566:	ff3719e3          	bne	a4,s3,80003558 <bread+0x4c>
			b->refcnt++;
    8000356a:	40bc                	lw	a5,64(s1)
			release(&bcache.lock);
    8000356c:	00014517          	auipc	a0,0x14
    80003570:	88c50513          	add	a0,a0,-1908 # 80016df8 <bcache>
			b->refcnt++;
    80003574:	2785                	addw	a5,a5,1
    80003576:	c0bc                	sw	a5,64(s1)
			release(&bcache.lock);
    80003578:	ffffd097          	auipc	ra,0xffffd
    8000357c:	7a8080e7          	jalr	1960(ra) # 80000d20 <release>
			acquiresleep(&b->lock);
    80003580:	01048513          	add	a0,s1,16
    80003584:	00001097          	auipc	ra,0x1
    80003588:	526080e7          	jalr	1318(ra) # 80004aaa <acquiresleep>
	struct buf *b = nullptr;

	b = bget(dev, blockno);
	if (!b->valid) {
    8000358c:	409c                	lw	a5,0(s1)
    8000358e:	ebb1                	bnez	a5,800035e2 <bread+0xd6>
		virtio_disk_rw(b, 0);
    80003590:	4581                	li	a1,0
    80003592:	8526                	mv	a0,s1
    80003594:	00003097          	auipc	ra,0x3
    80003598:	2f8080e7          	jalr	760(ra) # 8000688c <virtio_disk_rw>
		b->valid = 1;
    8000359c:	4785                	li	a5,1
    8000359e:	c09c                	sw	a5,0(s1)
	}
	return b;
    800035a0:	a089                	j	800035e2 <bread+0xd6>
	for (b = bcache.head.prev; b != &bcache.head; b = b->prev) {
    800035a2:	2b06b483          	ld	s1,688(a3)
    800035a6:	00f49663          	bne	s1,a5,800035b2 <bread+0xa6>
    800035aa:	a0a9                	j	800035f4 <bread+0xe8>
    800035ac:	64a4                	ld	s1,72(s1)
    800035ae:	04f48363          	beq	s1,a5,800035f4 <bread+0xe8>
		if (b->refcnt == 0) {
    800035b2:	40b8                	lw	a4,64(s1)
    800035b4:	ff65                	bnez	a4,800035ac <bread+0xa0>
			b->refcnt = 1;
    800035b6:	4785                	li	a5,1
    800035b8:	c0bc                	sw	a5,64(s1)
			release(&bcache.lock);
    800035ba:	00014517          	auipc	a0,0x14
    800035be:	83e50513          	add	a0,a0,-1986 # 80016df8 <bcache>
			b->dev = dev;
    800035c2:	0144b423          	sd	s4,8(s1)
			b->valid = 0;
    800035c6:	0004a023          	sw	zero,0(s1)
			release(&bcache.lock);
    800035ca:	ffffd097          	auipc	ra,0xffffd
    800035ce:	756080e7          	jalr	1878(ra) # 80000d20 <release>
			acquiresleep(&b->lock);
    800035d2:	01048513          	add	a0,s1,16
    800035d6:	00001097          	auipc	ra,0x1
    800035da:	4d4080e7          	jalr	1236(ra) # 80004aaa <acquiresleep>
	if (!b->valid) {
    800035de:	409c                	lw	a5,0(s1)
    800035e0:	dbc5                	beqz	a5,80003590 <bread+0x84>
}
    800035e2:	70a2                	ld	ra,40(sp)
    800035e4:	7402                	ld	s0,32(sp)
    800035e6:	6942                	ld	s2,16(sp)
    800035e8:	69a2                	ld	s3,8(sp)
    800035ea:	6a02                	ld	s4,0(sp)
    800035ec:	8526                	mv	a0,s1
    800035ee:	64e2                	ld	s1,24(sp)
    800035f0:	6145                	add	sp,sp,48
    800035f2:	8082                	ret
	panic("bget: no buffers");
    800035f4:	00005517          	auipc	a0,0x5
    800035f8:	25450513          	add	a0,a0,596 # 80008848 <etext+0x848>
    800035fc:	ffffd097          	auipc	ra,0xffffd
    80003600:	f9a080e7          	jalr	-102(ra) # 80000596 <panic>

0000000080003604 <bwrite>:
/*
 * Write b's contents to disk.  Must be locked.
 */
void
bwrite(struct buf *b)
{
    80003604:	1101                	add	sp,sp,-32
    80003606:	e822                	sd	s0,16(sp)
    80003608:	e426                	sd	s1,8(sp)
    8000360a:	ec06                	sd	ra,24(sp)
    8000360c:	1000                	add	s0,sp,32
    8000360e:	84aa                	mv	s1,a0
	if (!holdingsleep(&b->lock))
    80003610:	0541                	add	a0,a0,16
    80003612:	00001097          	auipc	ra,0x1
    80003616:	52e080e7          	jalr	1326(ra) # 80004b40 <holdingsleep>
    8000361a:	c919                	beqz	a0,80003630 <bwrite+0x2c>
		panic("bwrite");
	virtio_disk_rw(b, 1);
}
    8000361c:	6442                	ld	s0,16(sp)
    8000361e:	60e2                	ld	ra,24(sp)
	virtio_disk_rw(b, 1);
    80003620:	8526                	mv	a0,s1
}
    80003622:	64a2                	ld	s1,8(sp)
	virtio_disk_rw(b, 1);
    80003624:	4585                	li	a1,1
}
    80003626:	6105                	add	sp,sp,32
	virtio_disk_rw(b, 1);
    80003628:	00003317          	auipc	t1,0x3
    8000362c:	26430067          	jr	612(t1) # 8000688c <virtio_disk_rw>
		panic("bwrite");
    80003630:	00005517          	auipc	a0,0x5
    80003634:	23050513          	add	a0,a0,560 # 80008860 <etext+0x860>
    80003638:	ffffd097          	auipc	ra,0xffffd
    8000363c:	f5e080e7          	jalr	-162(ra) # 80000596 <panic>

0000000080003640 <brelse>:
 * Release a locked buffer.
 * Move to the head of the most-recently-used list.
 */
void
brelse(struct buf *b)
{
    80003640:	1101                	add	sp,sp,-32
    80003642:	e822                	sd	s0,16(sp)
    80003644:	e426                	sd	s1,8(sp)
    80003646:	e04a                	sd	s2,0(sp)
    80003648:	ec06                	sd	ra,24(sp)
    8000364a:	1000                	add	s0,sp,32
	if (!holdingsleep(&b->lock))
    8000364c:	01050913          	add	s2,a0,16
{
    80003650:	84aa                	mv	s1,a0
	if (!holdingsleep(&b->lock))
    80003652:	854a                	mv	a0,s2
    80003654:	00001097          	auipc	ra,0x1
    80003658:	4ec080e7          	jalr	1260(ra) # 80004b40 <holdingsleep>
    8000365c:	c13d                	beqz	a0,800036c2 <brelse+0x82>
		panic("brelse");

	releasesleep(&b->lock);
    8000365e:	854a                	mv	a0,s2
    80003660:	00001097          	auipc	ra,0x1
    80003664:	49e080e7          	jalr	1182(ra) # 80004afe <releasesleep>

	acquire(&bcache.lock);
    80003668:	00013517          	auipc	a0,0x13
    8000366c:	79050513          	add	a0,a0,1936 # 80016df8 <bcache>
    80003670:	ffffd097          	auipc	ra,0xffffd
    80003674:	5f0080e7          	jalr	1520(ra) # 80000c60 <acquire>
	b->refcnt--;
    80003678:	40bc                	lw	a5,64(s1)
    8000367a:	fff7871b          	addw	a4,a5,-1
    8000367e:	c0b8                	sw	a4,64(s1)
	if (b->refcnt == 0) {
    80003680:	e705                	bnez	a4,800036a8 <brelse+0x68>
		/* no one is waiting for it. */
		b->next->prev = b->prev;
    80003682:	68b4                	ld	a3,80(s1)
    80003684:	64b8                	ld	a4,72(s1)
		b->prev->next = b->next;
		b->next = bcache.head.next;
    80003686:	0001b797          	auipc	a5,0x1b
    8000368a:	77278793          	add	a5,a5,1906 # 8001edf8 <bcache+0x8000>
		b->next->prev = b->prev;
    8000368e:	e6b8                	sd	a4,72(a3)
		b->prev->next = b->next;
    80003690:	eb34                	sd	a3,80(a4)
		b->next = bcache.head.next;
    80003692:	2b87b703          	ld	a4,696(a5)
		b->prev = &bcache.head;
    80003696:	0001c697          	auipc	a3,0x1c
    8000369a:	9ca68693          	add	a3,a3,-1590 # 8001f060 <bcache+0x8268>
    8000369e:	e4b4                	sd	a3,72(s1)
		b->next = bcache.head.next;
    800036a0:	e8b8                	sd	a4,80(s1)
		bcache.head.next->prev = b;
    800036a2:	e724                	sd	s1,72(a4)
		bcache.head.next = b;
    800036a4:	2a97bc23          	sd	s1,696(a5)
	}
	release(&bcache.lock);
}
    800036a8:	6442                	ld	s0,16(sp)
    800036aa:	60e2                	ld	ra,24(sp)
    800036ac:	64a2                	ld	s1,8(sp)
    800036ae:	6902                	ld	s2,0(sp)
	release(&bcache.lock);
    800036b0:	00013517          	auipc	a0,0x13
    800036b4:	74850513          	add	a0,a0,1864 # 80016df8 <bcache>
}
    800036b8:	6105                	add	sp,sp,32
	release(&bcache.lock);
    800036ba:	ffffd317          	auipc	t1,0xffffd
    800036be:	66630067          	jr	1638(t1) # 80000d20 <release>
		panic("brelse");
    800036c2:	00005517          	auipc	a0,0x5
    800036c6:	1a650513          	add	a0,a0,422 # 80008868 <etext+0x868>
    800036ca:	ffffd097          	auipc	ra,0xffffd
    800036ce:	ecc080e7          	jalr	-308(ra) # 80000596 <panic>

00000000800036d2 <bpin>:

void
bpin(struct buf *b)
{
    800036d2:	1101                	add	sp,sp,-32
    800036d4:	e822                	sd	s0,16(sp)
    800036d6:	e426                	sd	s1,8(sp)
    800036d8:	ec06                	sd	ra,24(sp)
    800036da:	1000                	add	s0,sp,32
    800036dc:	84aa                	mv	s1,a0
	acquire(&bcache.lock);
    800036de:	00013517          	auipc	a0,0x13
    800036e2:	71a50513          	add	a0,a0,1818 # 80016df8 <bcache>
    800036e6:	ffffd097          	auipc	ra,0xffffd
    800036ea:	57a080e7          	jalr	1402(ra) # 80000c60 <acquire>
	b->refcnt++;
    800036ee:	40bc                	lw	a5,64(s1)
	release(&bcache.lock);
}
    800036f0:	6442                	ld	s0,16(sp)
    800036f2:	60e2                	ld	ra,24(sp)
	b->refcnt++;
    800036f4:	2785                	addw	a5,a5,1
    800036f6:	c0bc                	sw	a5,64(s1)
}
    800036f8:	64a2                	ld	s1,8(sp)
	release(&bcache.lock);
    800036fa:	00013517          	auipc	a0,0x13
    800036fe:	6fe50513          	add	a0,a0,1790 # 80016df8 <bcache>
}
    80003702:	6105                	add	sp,sp,32
	release(&bcache.lock);
    80003704:	ffffd317          	auipc	t1,0xffffd
    80003708:	61c30067          	jr	1564(t1) # 80000d20 <release>

000000008000370c <bunpin>:

void
bunpin(struct buf *b)
{
    8000370c:	1101                	add	sp,sp,-32
    8000370e:	e822                	sd	s0,16(sp)
    80003710:	e426                	sd	s1,8(sp)
    80003712:	ec06                	sd	ra,24(sp)
    80003714:	1000                	add	s0,sp,32
    80003716:	84aa                	mv	s1,a0
	acquire(&bcache.lock);
    80003718:	00013517          	auipc	a0,0x13
    8000371c:	6e050513          	add	a0,a0,1760 # 80016df8 <bcache>
    80003720:	ffffd097          	auipc	ra,0xffffd
    80003724:	540080e7          	jalr	1344(ra) # 80000c60 <acquire>
	b->refcnt--;
    80003728:	40bc                	lw	a5,64(s1)
	release(&bcache.lock);
}
    8000372a:	6442                	ld	s0,16(sp)
    8000372c:	60e2                	ld	ra,24(sp)
	b->refcnt--;
    8000372e:	37fd                	addw	a5,a5,-1
    80003730:	c0bc                	sw	a5,64(s1)
}
    80003732:	64a2                	ld	s1,8(sp)
	release(&bcache.lock);
    80003734:	00013517          	auipc	a0,0x13
    80003738:	6c450513          	add	a0,a0,1732 # 80016df8 <bcache>
}
    8000373c:	6105                	add	sp,sp,32
	release(&bcache.lock);
    8000373e:	ffffd317          	auipc	t1,0xffffd
    80003742:	5e230067          	jr	1506(t1) # 80000d20 <release>

0000000080003746 <balloc>:
 * Allocate a zeroed disk block.
 * returns 0 if outvof disk space.
 */
static uint
balloc(uint dev) 
{
    80003746:	711d                	add	sp,sp,-96
    80003748:	e8a2                	sd	s0,80(sp)
    8000374a:	ec5e                	sd	s7,24(sp)
    8000374c:	ec86                	sd	ra,88(sp)
    8000374e:	e4a6                	sd	s1,72(sp)
    80003750:	1080                	add	s0,sp,96
	int b = undefined, bi = undefined, m = undefined;
	struct buf *bp = nullptr;

	bp = 0;
	for (b = 0; b < sb.size; b += BPB) {
    80003752:	0001cb97          	auipc	s7,0x1c
    80003756:	d66b8b93          	add	s7,s7,-666 # 8001f4b8 <sb>
    8000375a:	004ba783          	lw	a5,4(s7)
    8000375e:	cfad                	beqz	a5,800037d8 <balloc+0x92>
    80003760:	e0ca                	sd	s2,64(sp)
    80003762:	fc4e                	sd	s3,56(sp)
    80003764:	f852                	sd	s4,48(sp)
    80003766:	f456                	sd	s5,40(sp)
    80003768:	f05a                	sd	s6,32(sp)
    8000376a:	892a                	mv	s2,a0
    8000376c:	4481                	li	s1,0
    8000376e:	4b01                	li	s6,0
		bp = bread(dev, BBLOCK(b, sb));
		for (bi = 0; bi < BPB && b + bi < sb.size; bi++) {
			m = 1 << (bi % 8);
    80003770:	4a05                	li	s4,1
		for (bi = 0; bi < BPB && b + bi < sb.size; bi++) {
    80003772:	6a89                	lui	s5,0x2
	for (b = 0; b < sb.size; b += BPB) {
    80003774:	6989                	lui	s3,0x2
		bp = bread(dev, BBLOCK(b, sb));
    80003776:	01cba783          	lw	a5,28(s7)
    8000377a:	00db559b          	srlw	a1,s6,0xd
    8000377e:	854a                	mv	a0,s2
    80003780:	9dbd                	addw	a1,a1,a5
    80003782:	00000097          	auipc	ra,0x0
    80003786:	d8a080e7          	jalr	-630(ra) # 8000350c <bread>
		for (bi = 0; bi < BPB && b + bi < sb.size; bi++) {
    8000378a:	004ba803          	lw	a6,4(s7)
    8000378e:	2481                	sext.w	s1,s1
    80003790:	4781                	li	a5,0
    80003792:	a809                	j	800037a4 <balloc+0x5e>
			if ((bp->data[bi / 8] & m) == 0) {
    80003794:	05874603          	lbu	a2,88(a4)
    80003798:	00c6f5b3          	and	a1,a3,a2
    8000379c:	cdb1                	beqz	a1,800037f8 <balloc+0xb2>
		for (bi = 0; bi < BPB && b + bi < sb.size; bi++) {
    8000379e:	2485                	addw	s1,s1,1
    800037a0:	01578c63          	beq	a5,s5,800037b8 <balloc+0x72>
			if ((bp->data[bi / 8] & m) == 0) {
    800037a4:	4037d713          	sra	a4,a5,0x3
			m = 1 << (bi % 8);
    800037a8:	0077f693          	and	a3,a5,7
			if ((bp->data[bi / 8] & m) == 0) {
    800037ac:	972a                	add	a4,a4,a0
			m = 1 << (bi % 8);
    800037ae:	00da16bb          	sllw	a3,s4,a3
		for (bi = 0; bi < BPB && b + bi < sb.size; bi++) {
    800037b2:	2785                	addw	a5,a5,1
    800037b4:	ff04e0e3          	bltu	s1,a6,80003794 <balloc+0x4e>
				brelse(bp);
				bzero(dev, b + bi);
				return b + bi;
			}
		}
		brelse(bp);
    800037b8:	00000097          	auipc	ra,0x0
    800037bc:	e88080e7          	jalr	-376(ra) # 80003640 <brelse>
	for (b = 0; b < sb.size; b += BPB) {
    800037c0:	004ba783          	lw	a5,4(s7)
    800037c4:	01698b3b          	addw	s6,s3,s6
    800037c8:	84da                	mv	s1,s6
    800037ca:	fafb66e3          	bltu	s6,a5,80003776 <balloc+0x30>
    800037ce:	6906                	ld	s2,64(sp)
    800037d0:	79e2                	ld	s3,56(sp)
    800037d2:	7a42                	ld	s4,48(sp)
    800037d4:	7aa2                	ld	s5,40(sp)
    800037d6:	7b02                	ld	s6,32(sp)
	}
	printf("balloc: out of blocks\n");
    800037d8:	00005517          	auipc	a0,0x5
    800037dc:	09850513          	add	a0,a0,152 # 80008870 <etext+0x870>
    800037e0:	ffffd097          	auipc	ra,0xffffd
    800037e4:	e00080e7          	jalr	-512(ra) # 800005e0 <printf>
	return 0;
}
    800037e8:	60e6                	ld	ra,88(sp)
    800037ea:	6446                	ld	s0,80(sp)
	return 0;
    800037ec:	4481                	li	s1,0
}
    800037ee:	6be2                	ld	s7,24(sp)
    800037f0:	8526                	mv	a0,s1
    800037f2:	64a6                	ld	s1,72(sp)
    800037f4:	6125                	add	sp,sp,96
    800037f6:	8082                	ret
				    bp->data[bi / 8] |= m;
    800037f8:	8e55                	or	a2,a2,a3
    800037fa:	04c70c23          	sb	a2,88(a4)
				    log_write(bp);
    800037fe:	faa43423          	sd	a0,-88(s0)
    80003802:	00001097          	auipc	ra,0x1
    80003806:	194080e7          	jalr	404(ra) # 80004996 <log_write>
				brelse(bp);
    8000380a:	fa843503          	ld	a0,-88(s0)
    8000380e:	00000097          	auipc	ra,0x0
    80003812:	e32080e7          	jalr	-462(ra) # 80003640 <brelse>
	bp = bread(dev, bno);
    80003816:	85a6                	mv	a1,s1
    80003818:	854a                	mv	a0,s2
    8000381a:	00000097          	auipc	ra,0x0
    8000381e:	cf2080e7          	jalr	-782(ra) # 8000350c <bread>
    80003822:	892a                	mv	s2,a0
	memset(bp->data, 0, BSIZE);
    80003824:	40000613          	li	a2,1024
    80003828:	4581                	li	a1,0
    8000382a:	05850513          	add	a0,a0,88
    8000382e:	ffffd097          	auipc	ra,0xffffd
    80003832:	546080e7          	jalr	1350(ra) # 80000d74 <memset>
	log_write(bp);
    80003836:	854a                	mv	a0,s2
    80003838:	00001097          	auipc	ra,0x1
    8000383c:	15e080e7          	jalr	350(ra) # 80004996 <log_write>
	brelse(bp);
    80003840:	854a                	mv	a0,s2
    80003842:	00000097          	auipc	ra,0x0
    80003846:	dfe080e7          	jalr	-514(ra) # 80003640 <brelse>
}
    8000384a:	60e6                	ld	ra,88(sp)
    8000384c:	6446                	ld	s0,80(sp)
}
    8000384e:	6906                	ld	s2,64(sp)
    80003850:	79e2                	ld	s3,56(sp)
    80003852:	7a42                	ld	s4,48(sp)
    80003854:	7aa2                	ld	s5,40(sp)
    80003856:	7b02                	ld	s6,32(sp)
}
    80003858:	6be2                	ld	s7,24(sp)
    8000385a:	8526                	mv	a0,s1
    8000385c:	64a6                	ld	s1,72(sp)
    8000385e:	6125                	add	sp,sp,96
    80003860:	8082                	ret

0000000080003862 <bmap>:
 * If there is no such block, bmap allocates one.
 * returns 0 if out of disk space.
 */
static uint
bmap(struct inode *ip, uint bn)
{
    80003862:	7179                	add	sp,sp,-48
    80003864:	f022                	sd	s0,32(sp)
    80003866:	e44e                	sd	s3,8(sp)
    80003868:	f406                	sd	ra,40(sp)
    8000386a:	ec26                	sd	s1,24(sp)
    8000386c:	e84a                	sd	s2,16(sp)
    8000386e:	1800                	add	s0,sp,48
	uint addr = undefined, *a = nullptr;
	struct buf *bp = nullptr;

	if (bn < NDIRECT) {
    80003870:	47ad                	li	a5,11
{
    80003872:	89aa                	mv	s3,a0
	if (bn < NDIRECT) {
    80003874:	02b7e463          	bltu	a5,a1,8000389c <bmap+0x3a>
		if ((addr = ip->addrs[bn]) == 0) {
    80003878:	02059793          	sll	a5,a1,0x20
    8000387c:	01e7d593          	srl	a1,a5,0x1e
    80003880:	00b504b3          	add	s1,a0,a1
    80003884:	0504a903          	lw	s2,80(s1)
    80003888:	08090463          	beqz	s2,80003910 <bmap+0xae>
		}
		brelse(bp);
		return addr;
	}
	panic("bmap: out of range");
}
    8000388c:	70a2                	ld	ra,40(sp)
    8000388e:	7402                	ld	s0,32(sp)
    80003890:	64e2                	ld	s1,24(sp)
    80003892:	69a2                	ld	s3,8(sp)
    80003894:	854a                	mv	a0,s2
    80003896:	6942                	ld	s2,16(sp)
    80003898:	6145                	add	sp,sp,48
    8000389a:	8082                	ret
	bn -= NDIRECT;
    8000389c:	ff45849b          	addw	s1,a1,-12
    800038a0:	0004871b          	sext.w	a4,s1
	if (bn < NINDIRECT) {
    800038a4:	0ff00793          	li	a5,255
    800038a8:	0ae7eb63          	bltu	a5,a4,8000395e <bmap+0xfc>
			    if ((addr = ip->addrs[NDIRECT]) == 0) {
    800038ac:	08052903          	lw	s2,128(a0)
			addr = balloc(ip->dev);
    800038b0:	4108                	lw	a0,0(a0)
			    if ((addr = ip->addrs[NDIRECT]) == 0) {
    800038b2:	08091263          	bnez	s2,80003936 <bmap+0xd4>
				addr = balloc(ip->dev);
    800038b6:	00000097          	auipc	ra,0x0
    800038ba:	e90080e7          	jalr	-368(ra) # 80003746 <balloc>
    800038be:	0005091b          	sext.w	s2,a0
				if (addr == 0)
    800038c2:	fc0905e3          	beqz	s2,8000388c <bmap+0x2a>
    800038c6:	0009a503          	lw	a0,0(s3) # 2000 <_entry-0x7fffe000>
    800038ca:	e052                	sd	s4,0(sp)
				ip->addrs[NDIRECT] = addr;
    800038cc:	0929a023          	sw	s2,128(s3)
		bp = bread(ip->dev, addr);
    800038d0:	85ca                	mv	a1,s2
    800038d2:	00000097          	auipc	ra,0x0
    800038d6:	c3a080e7          	jalr	-966(ra) # 8000350c <bread>
		if ((addr = a[bn]) == 0) {
    800038da:	02049713          	sll	a4,s1,0x20
		a = (uint *) bp->data;
    800038de:	05850793          	add	a5,a0,88
		if ((addr = a[bn]) == 0) {
    800038e2:	01e75593          	srl	a1,a4,0x1e
    800038e6:	00b784b3          	add	s1,a5,a1
    800038ea:	0004a903          	lw	s2,0(s1)
		bp = bread(ip->dev, addr);
    800038ee:	8a2a                	mv	s4,a0
		if ((addr = a[bn]) == 0) {
    800038f0:	04090563          	beqz	s2,8000393a <bmap+0xd8>
		brelse(bp);
    800038f4:	8552                	mv	a0,s4
    800038f6:	00000097          	auipc	ra,0x0
    800038fa:	d4a080e7          	jalr	-694(ra) # 80003640 <brelse>
}
    800038fe:	70a2                	ld	ra,40(sp)
    80003900:	7402                	ld	s0,32(sp)
		return addr;
    80003902:	6a02                	ld	s4,0(sp)
}
    80003904:	64e2                	ld	s1,24(sp)
    80003906:	69a2                	ld	s3,8(sp)
    80003908:	854a                	mv	a0,s2
    8000390a:	6942                	ld	s2,16(sp)
    8000390c:	6145                	add	sp,sp,48
    8000390e:	8082                	ret
			addr = balloc(ip->dev);
    80003910:	4108                	lw	a0,0(a0)
    80003912:	00000097          	auipc	ra,0x0
    80003916:	e34080e7          	jalr	-460(ra) # 80003746 <balloc>
    8000391a:	0005091b          	sext.w	s2,a0
			if (addr == 0)
    8000391e:	f60907e3          	beqz	s2,8000388c <bmap+0x2a>
}
    80003922:	70a2                	ld	ra,40(sp)
    80003924:	7402                	ld	s0,32(sp)
			ip->addrs[bn] = addr;
    80003926:	0524a823          	sw	s2,80(s1)
}
    8000392a:	69a2                	ld	s3,8(sp)
    8000392c:	64e2                	ld	s1,24(sp)
    8000392e:	854a                	mv	a0,s2
    80003930:	6942                	ld	s2,16(sp)
    80003932:	6145                	add	sp,sp,48
    80003934:	8082                	ret
    80003936:	e052                	sd	s4,0(sp)
    80003938:	bf61                	j	800038d0 <bmap+0x6e>
			addr = balloc(ip->dev);
    8000393a:	0009a503          	lw	a0,0(s3)
    8000393e:	00000097          	auipc	ra,0x0
    80003942:	e08080e7          	jalr	-504(ra) # 80003746 <balloc>
    80003946:	0005091b          	sext.w	s2,a0
			if (addr) {
    8000394a:	fa0905e3          	beqz	s2,800038f4 <bmap+0x92>
				a[bn] = addr;
    8000394e:	0124a023          	sw	s2,0(s1)
				log_write(bp);
    80003952:	8552                	mv	a0,s4
    80003954:	00001097          	auipc	ra,0x1
    80003958:	042080e7          	jalr	66(ra) # 80004996 <log_write>
    8000395c:	bf61                	j	800038f4 <bmap+0x92>
	panic("bmap: out of range");
    8000395e:	00005517          	auipc	a0,0x5
    80003962:	f2a50513          	add	a0,a0,-214 # 80008888 <etext+0x888>
    80003966:	e052                	sd	s4,0(sp)
    80003968:	ffffd097          	auipc	ra,0xffffd
    8000396c:	c2e080e7          	jalr	-978(ra) # 80000596 <panic>

0000000080003970 <iget>:
{
    80003970:	7179                	add	sp,sp,-48
    80003972:	f022                	sd	s0,32(sp)
    80003974:	ec26                	sd	s1,24(sp)
    80003976:	e84a                	sd	s2,16(sp)
    80003978:	e44e                	sd	s3,8(sp)
    8000397a:	e052                	sd	s4,0(sp)
    8000397c:	f406                	sd	ra,40(sp)
    8000397e:	1800                	add	s0,sp,48
    80003980:	892a                	mv	s2,a0
	acquire(&itable.lock);
    80003982:	0001c517          	auipc	a0,0x1c
    80003986:	b5650513          	add	a0,a0,-1194 # 8001f4d8 <itable>
{
    8000398a:	8a2e                	mv	s4,a1
	acquire(&itable.lock);
    8000398c:	ffffd097          	auipc	ra,0xffffd
    80003990:	2d4080e7          	jalr	724(ra) # 80000c60 <acquire>
	empty = 0;
    80003994:	4981                	li	s3,0
	for (ip = &itable.inode[0]; ip < &itable.inode[NINODE]; ip++) {
    80003996:	0001c497          	auipc	s1,0x1c
    8000399a:	b5a48493          	add	s1,s1,-1190 # 8001f4f0 <itable+0x18>
    8000399e:	0001d697          	auipc	a3,0x1d
    800039a2:	5e268693          	add	a3,a3,1506 # 80020f80 <log>
    800039a6:	a801                	j	800039b6 <iget+0x46>
		if (ip->ref > 0 && ip->dev == dev && ip->inum == inum) {
    800039a8:	4098                	lw	a4,0(s1)
    800039aa:	07270163          	beq	a4,s2,80003a0c <iget+0x9c>
	for (ip = &itable.inode[0]; ip < &itable.inode[NINODE]; ip++) {
    800039ae:	08848493          	add	s1,s1,136
    800039b2:	00d48d63          	beq	s1,a3,800039cc <iget+0x5c>
		if (ip->ref > 0 && ip->dev == dev && ip->inum == inum) {
    800039b6:	449c                	lw	a5,8(s1)
    800039b8:	fef048e3          	bgtz	a5,800039a8 <iget+0x38>
		if (empty == 0 && ip->ref == 0)
    800039bc:	fe0999e3          	bnez	s3,800039ae <iget+0x3e>
    800039c0:	e7ad                	bnez	a5,80003a2a <iget+0xba>
			    empty = ip;
    800039c2:	89a6                	mv	s3,s1
	for (ip = &itable.inode[0]; ip < &itable.inode[NINODE]; ip++) {
    800039c4:	08848493          	add	s1,s1,136
    800039c8:	fed497e3          	bne	s1,a3,800039b6 <iget+0x46>
	    if (empty == 0)
    800039cc:	06098763          	beqz	s3,80003a3a <iget+0xca>
	ip->dev = dev;
    800039d0:	1902                	sll	s2,s2,0x20
    800039d2:	1a02                	sll	s4,s4,0x20
    800039d4:	02095913          	srl	s2,s2,0x20
    800039d8:	01496933          	or	s2,s2,s4
	ip->ref = 1;
    800039dc:	4785                	li	a5,1
	ip->dev = dev;
    800039de:	0129b023          	sd	s2,0(s3)
	ip->ref = 1;
    800039e2:	00f9a423          	sw	a5,8(s3)
	ip->valid = 0;
    800039e6:	0409a023          	sw	zero,64(s3)
	release(&itable.lock);
    800039ea:	0001c517          	auipc	a0,0x1c
    800039ee:	aee50513          	add	a0,a0,-1298 # 8001f4d8 <itable>
    800039f2:	ffffd097          	auipc	ra,0xffffd
    800039f6:	32e080e7          	jalr	814(ra) # 80000d20 <release>
}
    800039fa:	70a2                	ld	ra,40(sp)
    800039fc:	7402                	ld	s0,32(sp)
    800039fe:	64e2                	ld	s1,24(sp)
    80003a00:	6942                	ld	s2,16(sp)
    80003a02:	6a02                	ld	s4,0(sp)
    80003a04:	854e                	mv	a0,s3
    80003a06:	69a2                	ld	s3,8(sp)
    80003a08:	6145                	add	sp,sp,48
    80003a0a:	8082                	ret
		if (ip->ref > 0 && ip->dev == dev && ip->inum == inum) {
    80003a0c:	40d8                	lw	a4,4(s1)
    80003a0e:	fb4710e3          	bne	a4,s4,800039ae <iget+0x3e>
			ip->ref++;
    80003a12:	2785                	addw	a5,a5,1
			release(&itable.lock);
    80003a14:	0001c517          	auipc	a0,0x1c
    80003a18:	ac450513          	add	a0,a0,-1340 # 8001f4d8 <itable>
			ip->ref++;
    80003a1c:	c49c                	sw	a5,8(s1)
			release(&itable.lock);
    80003a1e:	ffffd097          	auipc	ra,0xffffd
    80003a22:	302080e7          	jalr	770(ra) # 80000d20 <release>
			return ip;
    80003a26:	89a6                	mv	s3,s1
    80003a28:	bfc9                	j	800039fa <iget+0x8a>
	for (ip = &itable.inode[0]; ip < &itable.inode[NINODE]; ip++) {
    80003a2a:	08848493          	add	s1,s1,136
    80003a2e:	00d48663          	beq	s1,a3,80003a3a <iget+0xca>
		if (ip->ref > 0 && ip->dev == dev && ip->inum == inum) {
    80003a32:	449c                	lw	a5,8(s1)
    80003a34:	f6f04ae3          	bgtz	a5,800039a8 <iget+0x38>
    80003a38:	b761                	j	800039c0 <iget+0x50>
		panic("iget: no inodes");
    80003a3a:	00005517          	auipc	a0,0x5
    80003a3e:	e6650513          	add	a0,a0,-410 # 800088a0 <etext+0x8a0>
    80003a42:	ffffd097          	auipc	ra,0xffffd
    80003a46:	b54080e7          	jalr	-1196(ra) # 80000596 <panic>

0000000080003a4a <bfree>:
{
    80003a4a:	1101                	add	sp,sp,-32
    80003a4c:	e822                	sd	s0,16(sp)
    80003a4e:	e426                	sd	s1,8(sp)
    80003a50:	ec06                	sd	ra,24(sp)
    80003a52:	e04a                	sd	s2,0(sp)
    80003a54:	1000                	add	s0,sp,32
    80003a56:	84ae                	mv	s1,a1
	bp = bread(dev, BBLOCK(b, sb));
    80003a58:	0001c797          	auipc	a5,0x1c
    80003a5c:	a7c7a783          	lw	a5,-1412(a5) # 8001f4d4 <sb+0x1c>
    80003a60:	00d5d59b          	srlw	a1,a1,0xd
    80003a64:	9dbd                	addw	a1,a1,a5
    80003a66:	00000097          	auipc	ra,0x0
    80003a6a:	aa6080e7          	jalr	-1370(ra) # 8000350c <bread>
	if ((bp->data[bi / 8] & m) == 0)
    80003a6e:	4034d79b          	sraw	a5,s1,0x3
    80003a72:	3ff7f793          	and	a5,a5,1023
    80003a76:	97aa                	add	a5,a5,a0
    80003a78:	0587c683          	lbu	a3,88(a5)
	m = 1 << (bi % 8);
    80003a7c:	889d                	and	s1,s1,7
    80003a7e:	4705                	li	a4,1
    80003a80:	0097173b          	sllw	a4,a4,s1
	if ((bp->data[bi / 8] & m) == 0)
    80003a84:	00d77633          	and	a2,a4,a3
    80003a88:	c60d                	beqz	a2,80003ab2 <bfree+0x68>
	bp->data[bi / 8] &= ~m;
    80003a8a:	fff74713          	not	a4,a4
    80003a8e:	8ef9                	and	a3,a3,a4
    80003a90:	04d78c23          	sb	a3,88(a5)
    80003a94:	892a                	mv	s2,a0
	log_write(bp);
    80003a96:	00001097          	auipc	ra,0x1
    80003a9a:	f00080e7          	jalr	-256(ra) # 80004996 <log_write>
}
    80003a9e:	6442                	ld	s0,16(sp)
    80003aa0:	60e2                	ld	ra,24(sp)
    80003aa2:	64a2                	ld	s1,8(sp)
	brelse(bp);
    80003aa4:	854a                	mv	a0,s2
}
    80003aa6:	6902                	ld	s2,0(sp)
    80003aa8:	6105                	add	sp,sp,32
	brelse(bp);
    80003aaa:	00000317          	auipc	t1,0x0
    80003aae:	b9630067          	jr	-1130(t1) # 80003640 <brelse>
		panic("freeing free block");
    80003ab2:	00005517          	auipc	a0,0x5
    80003ab6:	dfe50513          	add	a0,a0,-514 # 800088b0 <etext+0x8b0>
    80003aba:	ffffd097          	auipc	ra,0xffffd
    80003abe:	adc080e7          	jalr	-1316(ra) # 80000596 <panic>

0000000080003ac2 <fsinit>:
{
    80003ac2:	7179                	add	sp,sp,-48
    80003ac4:	f406                	sd	ra,40(sp)
    80003ac6:	f022                	sd	s0,32(sp)
    80003ac8:	ec26                	sd	s1,24(sp)
    80003aca:	1800                	add	s0,sp,48
    80003acc:	e84a                	sd	s2,16(sp)
    80003ace:	e44e                	sd	s3,8(sp)
	bp = bread(dev, 1);
    80003ad0:	4585                	li	a1,1
	memmove(sb, bp->data, sizeof(*sb));
    80003ad2:	0001c997          	auipc	s3,0x1c
    80003ad6:	9e698993          	add	s3,s3,-1562 # 8001f4b8 <sb>
{
    80003ada:	892a                	mv	s2,a0
	bp = bread(dev, 1);
    80003adc:	00000097          	auipc	ra,0x0
    80003ae0:	a30080e7          	jalr	-1488(ra) # 8000350c <bread>
	memmove(sb, bp->data, sizeof(*sb));
    80003ae4:	05850593          	add	a1,a0,88
	bp = bread(dev, 1);
    80003ae8:	84aa                	mv	s1,a0
	memmove(sb, bp->data, sizeof(*sb));
    80003aea:	02000613          	li	a2,32
    80003aee:	854e                	mv	a0,s3
    80003af0:	ffffd097          	auipc	ra,0xffffd
    80003af4:	338080e7          	jalr	824(ra) # 80000e28 <memmove>
	brelse(bp);
    80003af8:	8526                	mv	a0,s1
    80003afa:	00000097          	auipc	ra,0x0
    80003afe:	b46080e7          	jalr	-1210(ra) # 80003640 <brelse>
	if (sb.magic != FSMAGIC)
    80003b02:	0009a703          	lw	a4,0(s3)
    80003b06:	102037b7          	lui	a5,0x10203
    80003b0a:	04078793          	add	a5,a5,64 # 10203040 <_entry-0x6fdfcfc0>
    80003b0e:	00f71e63          	bne	a4,a5,80003b2a <fsinit+0x68>
}
    80003b12:	7402                	ld	s0,32(sp)
    80003b14:	70a2                	ld	ra,40(sp)
    80003b16:	64e2                	ld	s1,24(sp)
	initlog(dev, &sb);
    80003b18:	85ce                	mv	a1,s3
    80003b1a:	854a                	mv	a0,s2
}
    80003b1c:	69a2                	ld	s3,8(sp)
    80003b1e:	6942                	ld	s2,16(sp)
    80003b20:	6145                	add	sp,sp,48
	initlog(dev, &sb);
    80003b22:	00001317          	auipc	t1,0x1
    80003b26:	c1230067          	jr	-1006(t1) # 80004734 <initlog>
		panic("invalid file system");
    80003b2a:	00005517          	auipc	a0,0x5
    80003b2e:	d9e50513          	add	a0,a0,-610 # 800088c8 <etext+0x8c8>
    80003b32:	ffffd097          	auipc	ra,0xffffd
    80003b36:	a64080e7          	jalr	-1436(ra) # 80000596 <panic>

0000000080003b3a <iinit>:
{
    80003b3a:	7179                	add	sp,sp,-48
    80003b3c:	f022                	sd	s0,32(sp)
    80003b3e:	ec26                	sd	s1,24(sp)
    80003b40:	e84a                	sd	s2,16(sp)
    80003b42:	e44e                	sd	s3,8(sp)
    80003b44:	f406                	sd	ra,40(sp)
    80003b46:	1800                	add	s0,sp,48
	initlock(&itable.lock, "itable");
    80003b48:	00005597          	auipc	a1,0x5
    80003b4c:	d9858593          	add	a1,a1,-616 # 800088e0 <etext+0x8e0>
    80003b50:	0001c517          	auipc	a0,0x1c
    80003b54:	98850513          	add	a0,a0,-1656 # 8001f4d8 <itable>
    80003b58:	ffffd097          	auipc	ra,0xffffd
    80003b5c:	078080e7          	jalr	120(ra) # 80000bd0 <initlock>
	for (i = 0; i < NINODE; i++) {
    80003b60:	0001c497          	auipc	s1,0x1c
    80003b64:	9a048493          	add	s1,s1,-1632 # 8001f500 <itable+0x28>
    80003b68:	0001d997          	auipc	s3,0x1d
    80003b6c:	42898993          	add	s3,s3,1064 # 80020f90 <log+0x10>
		initsleeplock(&itable.inode[i].lock, "inode");
    80003b70:	00005917          	auipc	s2,0x5
    80003b74:	d7890913          	add	s2,s2,-648 # 800088e8 <etext+0x8e8>
    80003b78:	8526                	mv	a0,s1
    80003b7a:	85ca                	mv	a1,s2
	for (i = 0; i < NINODE; i++) {
    80003b7c:	08848493          	add	s1,s1,136
		initsleeplock(&itable.inode[i].lock, "inode");
    80003b80:	00001097          	auipc	ra,0x1
    80003b84:	ef0080e7          	jalr	-272(ra) # 80004a70 <initsleeplock>
	for (i = 0; i < NINODE; i++) {
    80003b88:	ff3498e3          	bne	s1,s3,80003b78 <iinit+0x3e>
}
    80003b8c:	70a2                	ld	ra,40(sp)
    80003b8e:	7402                	ld	s0,32(sp)
    80003b90:	64e2                	ld	s1,24(sp)
    80003b92:	6942                	ld	s2,16(sp)
    80003b94:	69a2                	ld	s3,8(sp)
    80003b96:	6145                	add	sp,sp,48
    80003b98:	8082                	ret

0000000080003b9a <_ialloc>:
{
    80003b9a:	715d                	add	sp,sp,-80
    80003b9c:	e0a2                	sd	s0,64(sp)
    80003b9e:	f052                	sd	s4,32(sp)
    80003ba0:	e486                	sd	ra,72(sp)
    80003ba2:	0880                	add	s0,sp,80
	for (inum = 1; inum < sb.ninodes; inum++) {
    80003ba4:	0001ca17          	auipc	s4,0x1c
    80003ba8:	914a0a13          	add	s4,s4,-1772 # 8001f4b8 <sb>
    80003bac:	00ca2703          	lw	a4,12(s4)
    80003bb0:	4785                	li	a5,1
    80003bb2:	0ae7f563          	bgeu	a5,a4,80003c5c <_ialloc+0xc2>
    80003bb6:	fc26                	sd	s1,56(sp)
    80003bb8:	ec56                	sd	s5,24(sp)
    80003bba:	e45e                	sd	s7,8(sp)
    80003bbc:	f84a                	sd	s2,48(sp)
    80003bbe:	f44e                	sd	s3,40(sp)
    80003bc0:	e85a                	sd	s6,16(sp)
    80003bc2:	8aaa                	mv	s5,a0
    80003bc4:	8bae                	mv	s7,a1
    80003bc6:	4485                	li	s1,1
    80003bc8:	a811                	j	80003bdc <_ialloc+0x42>
		brelse(bp);
    80003bca:	00000097          	auipc	ra,0x0
    80003bce:	a76080e7          	jalr	-1418(ra) # 80003640 <brelse>
	for (inum = 1; inum < sb.ninodes; inum++) {
    80003bd2:	00ca2783          	lw	a5,12(s4)
    80003bd6:	2485                	addw	s1,s1,1
    80003bd8:	06f4fc63          	bgeu	s1,a5,80003c50 <_ialloc+0xb6>
		bp = bread(dev, IBLOCK(inum, sb));
    80003bdc:	018a2783          	lw	a5,24(s4)
    80003be0:	0044d59b          	srlw	a1,s1,0x4
    80003be4:	8556                	mv	a0,s5
    80003be6:	9dbd                	addw	a1,a1,a5
    80003be8:	00000097          	auipc	ra,0x0
    80003bec:	924080e7          	jalr	-1756(ra) # 8000350c <bread>
		dip = (struct dinode *)bp->data + inum % IPB;
    80003bf0:	00f4f793          	and	a5,s1,15
    80003bf4:	079a                	sll	a5,a5,0x6
    80003bf6:	05850993          	add	s3,a0,88
    80003bfa:	99be                	add	s3,s3,a5
		if (dip->type == 0) {
    80003bfc:	00099783          	lh	a5,0(s3)
    80003c00:	00048b1b          	sext.w	s6,s1
		bp = bread(dev, IBLOCK(inum, sb));
    80003c04:	892a                	mv	s2,a0
		if (dip->type == 0) {
    80003c06:	f3f1                	bnez	a5,80003bca <_ialloc+0x30>
			    memset(dip, 0, sizeof(*dip));
    80003c08:	4581                	li	a1,0
    80003c0a:	04000613          	li	a2,64
    80003c0e:	854e                	mv	a0,s3
    80003c10:	ffffd097          	auipc	ra,0xffffd
    80003c14:	164080e7          	jalr	356(ra) # 80000d74 <memset>
			log_write(bp);
    80003c18:	854a                	mv	a0,s2
			dip->type = type;
    80003c1a:	01799023          	sh	s7,0(s3)
			log_write(bp);
    80003c1e:	00001097          	auipc	ra,0x1
    80003c22:	d78080e7          	jalr	-648(ra) # 80004996 <log_write>
			    brelse(bp);
    80003c26:	854a                	mv	a0,s2
    80003c28:	00000097          	auipc	ra,0x0
    80003c2c:	a18080e7          	jalr	-1512(ra) # 80003640 <brelse>
}
    80003c30:	6406                	ld	s0,64(sp)
			return iget(dev, inum);
    80003c32:	74e2                	ld	s1,56(sp)
    80003c34:	7942                	ld	s2,48(sp)
    80003c36:	79a2                	ld	s3,40(sp)
    80003c38:	6ba2                	ld	s7,8(sp)
}
    80003c3a:	60a6                	ld	ra,72(sp)
    80003c3c:	7a02                	ld	s4,32(sp)
			return iget(dev, inum);
    80003c3e:	85da                	mv	a1,s6
    80003c40:	8556                	mv	a0,s5
    80003c42:	6b42                	ld	s6,16(sp)
    80003c44:	6ae2                	ld	s5,24(sp)
}
    80003c46:	6161                	add	sp,sp,80
			return iget(dev, inum);
    80003c48:	00000317          	auipc	t1,0x0
    80003c4c:	d2830067          	jr	-728(t1) # 80003970 <iget>
    80003c50:	74e2                	ld	s1,56(sp)
    80003c52:	7942                	ld	s2,48(sp)
    80003c54:	79a2                	ld	s3,40(sp)
    80003c56:	6ae2                	ld	s5,24(sp)
    80003c58:	6b42                	ld	s6,16(sp)
    80003c5a:	6ba2                	ld	s7,8(sp)
	printf("ialloc: no inodes\n");
    80003c5c:	00005517          	auipc	a0,0x5
    80003c60:	c9450513          	add	a0,a0,-876 # 800088f0 <etext+0x8f0>
    80003c64:	ffffd097          	auipc	ra,0xffffd
    80003c68:	97c080e7          	jalr	-1668(ra) # 800005e0 <printf>
}
    80003c6c:	60a6                	ld	ra,72(sp)
    80003c6e:	6406                	ld	s0,64(sp)
    80003c70:	7a02                	ld	s4,32(sp)
    80003c72:	4501                	li	a0,0
    80003c74:	6161                	add	sp,sp,80
    80003c76:	8082                	ret

0000000080003c78 <iupdate>:
{
    80003c78:	1101                	add	sp,sp,-32
    80003c7a:	ec06                	sd	ra,24(sp)
    80003c7c:	e822                	sd	s0,16(sp)
    80003c7e:	e426                	sd	s1,8(sp)
    80003c80:	1000                	add	s0,sp,32
    80003c82:	e04a                	sd	s2,0(sp)
	bp = bread(ip->dev, IBLOCK(ip->inum, sb));
    80003c84:	415c                	lw	a5,4(a0)
{
    80003c86:	84aa                	mv	s1,a0
	bp = bread(ip->dev, IBLOCK(ip->inum, sb));
    80003c88:	4108                	lw	a0,0(a0)
    80003c8a:	0047d79b          	srlw	a5,a5,0x4
    80003c8e:	0001c597          	auipc	a1,0x1c
    80003c92:	8425a583          	lw	a1,-1982(a1) # 8001f4d0 <sb+0x18>
    80003c96:	9dbd                	addw	a1,a1,a5
    80003c98:	00000097          	auipc	ra,0x0
    80003c9c:	874080e7          	jalr	-1932(ra) # 8000350c <bread>
	dip = (struct dinode *)bp->data + ip->inum % IPB;
    80003ca0:	40dc                	lw	a5,4(s1)
	dip->type = ip->type;
    80003ca2:	0444d883          	lhu	a7,68(s1)
	dip->major = ip->major;
    80003ca6:	0464d803          	lhu	a6,70(s1)
	dip->minor = ip->minor;
    80003caa:	0484d583          	lhu	a1,72(s1)
	dip->nlink = ip->nlink;
    80003cae:	04a4d603          	lhu	a2,74(s1)
	dip->size = ip->size;
    80003cb2:	44f4                	lw	a3,76(s1)
	dip = (struct dinode *)bp->data + ip->inum % IPB;
    80003cb4:	00f7f713          	and	a4,a5,15
    80003cb8:	071a                	sll	a4,a4,0x6
    80003cba:	05850793          	add	a5,a0,88
    80003cbe:	97ba                	add	a5,a5,a4
	bp = bread(ip->dev, IBLOCK(ip->inum, sb));
    80003cc0:	892a                	mv	s2,a0
	dip->minor = ip->minor;
    80003cc2:	00b79223          	sh	a1,4(a5)
	dip->nlink = ip->nlink;
    80003cc6:	00c79323          	sh	a2,6(a5)
	memmove(dip->addrs, ip->addrs, sizeof(ip->addrs));
    80003cca:	05048593          	add	a1,s1,80
	dip->type = ip->type;
    80003cce:	01179023          	sh	a7,0(a5)
	dip->major = ip->major;
    80003cd2:	01079123          	sh	a6,2(a5)
	dip->size = ip->size;
    80003cd6:	c794                	sw	a3,8(a5)
	memmove(dip->addrs, ip->addrs, sizeof(ip->addrs));
    80003cd8:	03400613          	li	a2,52
    80003cdc:	00c78513          	add	a0,a5,12
    80003ce0:	ffffd097          	auipc	ra,0xffffd
    80003ce4:	148080e7          	jalr	328(ra) # 80000e28 <memmove>
	log_write(bp);
    80003ce8:	854a                	mv	a0,s2
    80003cea:	00001097          	auipc	ra,0x1
    80003cee:	cac080e7          	jalr	-852(ra) # 80004996 <log_write>
}
    80003cf2:	6442                	ld	s0,16(sp)
    80003cf4:	60e2                	ld	ra,24(sp)
    80003cf6:	64a2                	ld	s1,8(sp)
	brelse(bp);
    80003cf8:	854a                	mv	a0,s2
}
    80003cfa:	6902                	ld	s2,0(sp)
    80003cfc:	6105                	add	sp,sp,32
	brelse(bp);
    80003cfe:	00000317          	auipc	t1,0x0
    80003d02:	94230067          	jr	-1726(t1) # 80003640 <brelse>

0000000080003d06 <idup>:
{
    80003d06:	1101                	add	sp,sp,-32
    80003d08:	ec06                	sd	ra,24(sp)
    80003d0a:	e822                	sd	s0,16(sp)
    80003d0c:	e426                	sd	s1,8(sp)
    80003d0e:	1000                	add	s0,sp,32
    80003d10:	84aa                	mv	s1,a0
	acquire(&itable.lock);
    80003d12:	0001b517          	auipc	a0,0x1b
    80003d16:	7c650513          	add	a0,a0,1990 # 8001f4d8 <itable>
    80003d1a:	ffffd097          	auipc	ra,0xffffd
    80003d1e:	f46080e7          	jalr	-186(ra) # 80000c60 <acquire>
	ip->ref++;
    80003d22:	449c                	lw	a5,8(s1)
	release(&itable.lock);
    80003d24:	0001b517          	auipc	a0,0x1b
    80003d28:	7b450513          	add	a0,a0,1972 # 8001f4d8 <itable>
	ip->ref++;
    80003d2c:	2785                	addw	a5,a5,1
    80003d2e:	c49c                	sw	a5,8(s1)
	release(&itable.lock);
    80003d30:	ffffd097          	auipc	ra,0xffffd
    80003d34:	ff0080e7          	jalr	-16(ra) # 80000d20 <release>
}
    80003d38:	60e2                	ld	ra,24(sp)
    80003d3a:	6442                	ld	s0,16(sp)
    80003d3c:	8526                	mv	a0,s1
    80003d3e:	64a2                	ld	s1,8(sp)
    80003d40:	6105                	add	sp,sp,32
    80003d42:	8082                	ret

0000000080003d44 <ilock>:
{
    80003d44:	1101                	add	sp,sp,-32
    80003d46:	e822                	sd	s0,16(sp)
    80003d48:	ec06                	sd	ra,24(sp)
    80003d4a:	e426                	sd	s1,8(sp)
    80003d4c:	1000                	add	s0,sp,32
	if (ip == 0 || ip->ref < 1)
    80003d4e:	c14d                	beqz	a0,80003df0 <ilock+0xac>
    80003d50:	451c                	lw	a5,8(a0)
    80003d52:	84aa                	mv	s1,a0
    80003d54:	08f05e63          	blez	a5,80003df0 <ilock+0xac>
	acquiresleep(&ip->lock);
    80003d58:	0541                	add	a0,a0,16
    80003d5a:	00001097          	auipc	ra,0x1
    80003d5e:	d50080e7          	jalr	-688(ra) # 80004aaa <acquiresleep>
	if (ip->valid == 0) {
    80003d62:	40bc                	lw	a5,64(s1)
    80003d64:	c791                	beqz	a5,80003d70 <ilock+0x2c>
}
    80003d66:	60e2                	ld	ra,24(sp)
    80003d68:	6442                	ld	s0,16(sp)
    80003d6a:	64a2                	ld	s1,8(sp)
    80003d6c:	6105                	add	sp,sp,32
    80003d6e:	8082                	ret
		bp = bread(ip->dev, IBLOCK(ip->inum, sb));
    80003d70:	40dc                	lw	a5,4(s1)
    80003d72:	4088                	lw	a0,0(s1)
    80003d74:	0001b597          	auipc	a1,0x1b
    80003d78:	75c5a583          	lw	a1,1884(a1) # 8001f4d0 <sb+0x18>
    80003d7c:	0047d79b          	srlw	a5,a5,0x4
    80003d80:	9dbd                	addw	a1,a1,a5
    80003d82:	e04a                	sd	s2,0(sp)
    80003d84:	fffff097          	auipc	ra,0xfffff
    80003d88:	788080e7          	jalr	1928(ra) # 8000350c <bread>
		dip = (struct dinode *)bp->data + ip->inum % IPB;
    80003d8c:	40dc                	lw	a5,4(s1)
    80003d8e:	05850593          	add	a1,a0,88
		bp = bread(ip->dev, IBLOCK(ip->inum, sb));
    80003d92:	892a                	mv	s2,a0
		dip = (struct dinode *)bp->data + ip->inum % IPB;
    80003d94:	8bbd                	and	a5,a5,15
    80003d96:	079a                	sll	a5,a5,0x6
    80003d98:	95be                	add	a1,a1,a5
		ip->type = dip->type;
    80003d9a:	0005d503          	lhu	a0,0(a1)
		ip->major = dip->major;
    80003d9e:	0025d603          	lhu	a2,2(a1)
		ip->nlink = dip->nlink;
    80003da2:	0065d703          	lhu	a4,6(a1)
		ip->size = dip->size;
    80003da6:	459c                	lw	a5,8(a1)
		ip->minor = dip->minor;
    80003da8:	0045d683          	lhu	a3,4(a1)
		ip->nlink = dip->nlink;
    80003dac:	04e49523          	sh	a4,74(s1)
		ip->size = dip->size;
    80003db0:	c4fc                	sw	a5,76(s1)
		ip->type = dip->type;
    80003db2:	04a49223          	sh	a0,68(s1)
		ip->major = dip->major;
    80003db6:	04c49323          	sh	a2,70(s1)
		ip->minor = dip->minor;
    80003dba:	04d49423          	sh	a3,72(s1)
		memmove(ip->addrs, dip->addrs, sizeof(ip->addrs));
    80003dbe:	03400613          	li	a2,52
    80003dc2:	05b1                	add	a1,a1,12
    80003dc4:	05048513          	add	a0,s1,80
    80003dc8:	ffffd097          	auipc	ra,0xffffd
    80003dcc:	060080e7          	jalr	96(ra) # 80000e28 <memmove>
		brelse(bp);
    80003dd0:	854a                	mv	a0,s2
    80003dd2:	00000097          	auipc	ra,0x0
    80003dd6:	86e080e7          	jalr	-1938(ra) # 80003640 <brelse>
		if (ip->type == 0)
    80003dda:	04449783          	lh	a5,68(s1)
		ip->valid = 1;
    80003dde:	4705                	li	a4,1
    80003de0:	c0b8                	sw	a4,64(s1)
		if (ip->type == 0)
    80003de2:	c385                	beqz	a5,80003e02 <ilock+0xbe>
}
    80003de4:	60e2                	ld	ra,24(sp)
    80003de6:	6442                	ld	s0,16(sp)
    80003de8:	6902                	ld	s2,0(sp)
    80003dea:	64a2                	ld	s1,8(sp)
    80003dec:	6105                	add	sp,sp,32
    80003dee:	8082                	ret
		panic("ilock");
    80003df0:	00005517          	auipc	a0,0x5
    80003df4:	b1850513          	add	a0,a0,-1256 # 80008908 <etext+0x908>
    80003df8:	e04a                	sd	s2,0(sp)
    80003dfa:	ffffc097          	auipc	ra,0xffffc
    80003dfe:	79c080e7          	jalr	1948(ra) # 80000596 <panic>
			panic("ilock: no type");
    80003e02:	00005517          	auipc	a0,0x5
    80003e06:	b0e50513          	add	a0,a0,-1266 # 80008910 <etext+0x910>
    80003e0a:	ffffc097          	auipc	ra,0xffffc
    80003e0e:	78c080e7          	jalr	1932(ra) # 80000596 <panic>

0000000080003e12 <iunlock>:
{
    80003e12:	1101                	add	sp,sp,-32
    80003e14:	e822                	sd	s0,16(sp)
    80003e16:	ec06                	sd	ra,24(sp)
    80003e18:	e426                	sd	s1,8(sp)
    80003e1a:	e04a                	sd	s2,0(sp)
    80003e1c:	1000                	add	s0,sp,32
	if (ip == 0 || !holdingsleep(&ip->lock) || ip->ref < 1)
    80003e1e:	c51d                	beqz	a0,80003e4c <iunlock+0x3a>
    80003e20:	01050913          	add	s2,a0,16
    80003e24:	84aa                	mv	s1,a0
    80003e26:	854a                	mv	a0,s2
    80003e28:	00001097          	auipc	ra,0x1
    80003e2c:	d18080e7          	jalr	-744(ra) # 80004b40 <holdingsleep>
    80003e30:	cd11                	beqz	a0,80003e4c <iunlock+0x3a>
    80003e32:	449c                	lw	a5,8(s1)
    80003e34:	00f05c63          	blez	a5,80003e4c <iunlock+0x3a>
}
    80003e38:	6442                	ld	s0,16(sp)
    80003e3a:	60e2                	ld	ra,24(sp)
    80003e3c:	64a2                	ld	s1,8(sp)
	releasesleep(&ip->lock);
    80003e3e:	854a                	mv	a0,s2
}
    80003e40:	6902                	ld	s2,0(sp)
    80003e42:	6105                	add	sp,sp,32
	releasesleep(&ip->lock);
    80003e44:	00001317          	auipc	t1,0x1
    80003e48:	cba30067          	jr	-838(t1) # 80004afe <releasesleep>
		panic("iunlock");
    80003e4c:	00005517          	auipc	a0,0x5
    80003e50:	ad450513          	add	a0,a0,-1324 # 80008920 <etext+0x920>
    80003e54:	ffffc097          	auipc	ra,0xffffc
    80003e58:	742080e7          	jalr	1858(ra) # 80000596 <panic>

0000000080003e5c <itrunc>:
/*
 * Truncate inode(discard contents).
 * Caller must hold ip->lock.
 */
void
itrunc(struct inode *ip){
    80003e5c:	7179                	add	sp,sp,-48
    80003e5e:	f022                	sd	s0,32(sp)
    80003e60:	ec26                	sd	s1,24(sp)
    80003e62:	e84a                	sd	s2,16(sp)
    80003e64:	e44e                	sd	s3,8(sp)
    80003e66:	f406                	sd	ra,40(sp)
    80003e68:	1800                	add	s0,sp,48
    80003e6a:	89aa                	mv	s3,a0
    80003e6c:	05050493          	add	s1,a0,80
    80003e70:	08050913          	add	s2,a0,128
    80003e74:	a021                	j	80003e7c <itrunc+0x20>
	int i = undefined, j = undefined; 
	struct buf *bp = nullptr;
	uint *a = nullptr;

	for (i = 0; i < NDIRECT; i++) {
    80003e76:	0491                	add	s1,s1,4
    80003e78:	01248f63          	beq	s1,s2,80003e96 <itrunc+0x3a>
		if (ip->addrs[i]) {
    80003e7c:	408c                	lw	a1,0(s1)
    80003e7e:	dde5                	beqz	a1,80003e76 <itrunc+0x1a>
			bfree(ip->dev, ip->addrs[i]);
    80003e80:	0009a503          	lw	a0,0(s3)
	for (i = 0; i < NDIRECT; i++) {
    80003e84:	0491                	add	s1,s1,4
			bfree(ip->dev, ip->addrs[i]);
    80003e86:	00000097          	auipc	ra,0x0
    80003e8a:	bc4080e7          	jalr	-1084(ra) # 80003a4a <bfree>
			ip->addrs[i] = 0;
    80003e8e:	fe04ae23          	sw	zero,-4(s1)
	for (i = 0; i < NDIRECT; i++) {
    80003e92:	ff2495e3          	bne	s1,s2,80003e7c <itrunc+0x20>
		}
	}

	if (ip->addrs[NDIRECT]) {
    80003e96:	0809a583          	lw	a1,128(s3)
    80003e9a:	ed91                	bnez	a1,80003eb6 <itrunc+0x5a>
		bfree(ip->dev, ip->addrs[NDIRECT]);
		ip->addrs[NDIRECT] = 0;
	}
	ip->size = 0;
	iupdate(ip);
}
    80003e9c:	7402                	ld	s0,32(sp)
    80003e9e:	70a2                	ld	ra,40(sp)
    80003ea0:	64e2                	ld	s1,24(sp)
    80003ea2:	6942                	ld	s2,16(sp)
	ip->size = 0;
    80003ea4:	0409a623          	sw	zero,76(s3)
	iupdate(ip);
    80003ea8:	854e                	mv	a0,s3
}
    80003eaa:	69a2                	ld	s3,8(sp)
    80003eac:	6145                	add	sp,sp,48
	iupdate(ip);
    80003eae:	00000317          	auipc	t1,0x0
    80003eb2:	dca30067          	jr	-566(t1) # 80003c78 <iupdate>
		bp = bread(ip->dev, ip->addrs[NDIRECT]);
    80003eb6:	0009a503          	lw	a0,0(s3)
    80003eba:	e052                	sd	s4,0(sp)
    80003ebc:	fffff097          	auipc	ra,0xfffff
    80003ec0:	650080e7          	jalr	1616(ra) # 8000350c <bread>
    80003ec4:	8a2a                	mv	s4,a0
		for (j = 0; j < NINDIRECT; j++) {
    80003ec6:	05850493          	add	s1,a0,88
    80003eca:	45850913          	add	s2,a0,1112
    80003ece:	a021                	j	80003ed6 <itrunc+0x7a>
    80003ed0:	0491                	add	s1,s1,4
    80003ed2:	01248d63          	beq	s1,s2,80003eec <itrunc+0x90>
			if (a[j])
    80003ed6:	408c                	lw	a1,0(s1)
    80003ed8:	dde5                	beqz	a1,80003ed0 <itrunc+0x74>
				bfree(ip->dev, a[j]);
    80003eda:	0009a503          	lw	a0,0(s3)
		for (j = 0; j < NINDIRECT; j++) {
    80003ede:	0491                	add	s1,s1,4
				bfree(ip->dev, a[j]);
    80003ee0:	00000097          	auipc	ra,0x0
    80003ee4:	b6a080e7          	jalr	-1174(ra) # 80003a4a <bfree>
		for (j = 0; j < NINDIRECT; j++) {
    80003ee8:	ff2497e3          	bne	s1,s2,80003ed6 <itrunc+0x7a>
		brelse(bp);
    80003eec:	8552                	mv	a0,s4
    80003eee:	fffff097          	auipc	ra,0xfffff
    80003ef2:	752080e7          	jalr	1874(ra) # 80003640 <brelse>
		bfree(ip->dev, ip->addrs[NDIRECT]);
    80003ef6:	0809a583          	lw	a1,128(s3)
    80003efa:	0009a503          	lw	a0,0(s3)
    80003efe:	00000097          	auipc	ra,0x0
    80003f02:	b4c080e7          	jalr	-1204(ra) # 80003a4a <bfree>
		ip->addrs[NDIRECT] = 0;
    80003f06:	6a02                	ld	s4,0(sp)
    80003f08:	0809a023          	sw	zero,128(s3)
    80003f0c:	bf41                	j	80003e9c <itrunc+0x40>

0000000080003f0e <iput>:
{
    80003f0e:	1101                	add	sp,sp,-32
    80003f10:	e822                	sd	s0,16(sp)
    80003f12:	e426                	sd	s1,8(sp)
    80003f14:	ec06                	sd	ra,24(sp)
    80003f16:	1000                	add	s0,sp,32
    80003f18:	84aa                	mv	s1,a0
	acquire(&itable.lock);
    80003f1a:	0001b517          	auipc	a0,0x1b
    80003f1e:	5be50513          	add	a0,a0,1470 # 8001f4d8 <itable>
    80003f22:	ffffd097          	auipc	ra,0xffffd
    80003f26:	d3e080e7          	jalr	-706(ra) # 80000c60 <acquire>
	if (ip->ref == 1 && ip->valid && ip->nlink == 0) {
    80003f2a:	449c                	lw	a5,8(s1)
    80003f2c:	4705                	li	a4,1
    80003f2e:	02e78063          	beq	a5,a4,80003f4e <iput+0x40>
}
    80003f32:	6442                	ld	s0,16(sp)
	ip->ref--;
    80003f34:	37fd                	addw	a5,a5,-1
}
    80003f36:	60e2                	ld	ra,24(sp)
	ip->ref--;
    80003f38:	c49c                	sw	a5,8(s1)
}
    80003f3a:	64a2                	ld	s1,8(sp)
	release(&itable.lock);
    80003f3c:	0001b517          	auipc	a0,0x1b
    80003f40:	59c50513          	add	a0,a0,1436 # 8001f4d8 <itable>
}
    80003f44:	6105                	add	sp,sp,32
	release(&itable.lock);
    80003f46:	ffffd317          	auipc	t1,0xffffd
    80003f4a:	dda30067          	jr	-550(t1) # 80000d20 <release>
	if (ip->ref == 1 && ip->valid && ip->nlink == 0) {
    80003f4e:	40b8                	lw	a4,64(s1)
    80003f50:	d36d                	beqz	a4,80003f32 <iput+0x24>
    80003f52:	04a49703          	lh	a4,74(s1)
    80003f56:	ff71                	bnez	a4,80003f32 <iput+0x24>
    80003f58:	e04a                	sd	s2,0(sp)
		acquiresleep(&ip->lock);
    80003f5a:	01048913          	add	s2,s1,16
    80003f5e:	854a                	mv	a0,s2
    80003f60:	00001097          	auipc	ra,0x1
    80003f64:	b4a080e7          	jalr	-1206(ra) # 80004aaa <acquiresleep>
		release(&itable.lock);
    80003f68:	0001b517          	auipc	a0,0x1b
    80003f6c:	57050513          	add	a0,a0,1392 # 8001f4d8 <itable>
    80003f70:	ffffd097          	auipc	ra,0xffffd
    80003f74:	db0080e7          	jalr	-592(ra) # 80000d20 <release>
		itrunc(ip);
    80003f78:	8526                	mv	a0,s1
    80003f7a:	00000097          	auipc	ra,0x0
    80003f7e:	ee2080e7          	jalr	-286(ra) # 80003e5c <itrunc>
		iupdate(ip);
    80003f82:	8526                	mv	a0,s1
		ip->type = 0;
    80003f84:	04049223          	sh	zero,68(s1)
		iupdate(ip);
    80003f88:	00000097          	auipc	ra,0x0
    80003f8c:	cf0080e7          	jalr	-784(ra) # 80003c78 <iupdate>
		releasesleep(&ip->lock);
    80003f90:	854a                	mv	a0,s2
		ip->valid = 0;
    80003f92:	0404a023          	sw	zero,64(s1)
		releasesleep(&ip->lock);
    80003f96:	00001097          	auipc	ra,0x1
    80003f9a:	b68080e7          	jalr	-1176(ra) # 80004afe <releasesleep>
		acquire(&itable.lock);
    80003f9e:	0001b517          	auipc	a0,0x1b
    80003fa2:	53a50513          	add	a0,a0,1338 # 8001f4d8 <itable>
    80003fa6:	ffffd097          	auipc	ra,0xffffd
    80003faa:	cba080e7          	jalr	-838(ra) # 80000c60 <acquire>
	ip->ref--;
    80003fae:	449c                	lw	a5,8(s1)
    80003fb0:	6902                	ld	s2,0(sp)
    80003fb2:	b741                	j	80003f32 <iput+0x24>

0000000080003fb4 <iunlockput>:
{
    80003fb4:	1101                	add	sp,sp,-32
    80003fb6:	e822                	sd	s0,16(sp)
    80003fb8:	ec06                	sd	ra,24(sp)
    80003fba:	e426                	sd	s1,8(sp)
    80003fbc:	e04a                	sd	s2,0(sp)
    80003fbe:	1000                	add	s0,sp,32
	if (ip == 0 || !holdingsleep(&ip->lock) || ip->ref < 1)
    80003fc0:	cd05                	beqz	a0,80003ff8 <iunlockput+0x44>
    80003fc2:	01050913          	add	s2,a0,16
    80003fc6:	84aa                	mv	s1,a0
    80003fc8:	854a                	mv	a0,s2
    80003fca:	00001097          	auipc	ra,0x1
    80003fce:	b76080e7          	jalr	-1162(ra) # 80004b40 <holdingsleep>
    80003fd2:	c11d                	beqz	a0,80003ff8 <iunlockput+0x44>
    80003fd4:	449c                	lw	a5,8(s1)
    80003fd6:	02f05163          	blez	a5,80003ff8 <iunlockput+0x44>
	releasesleep(&ip->lock);
    80003fda:	854a                	mv	a0,s2
    80003fdc:	00001097          	auipc	ra,0x1
    80003fe0:	b22080e7          	jalr	-1246(ra) # 80004afe <releasesleep>
}
    80003fe4:	6442                	ld	s0,16(sp)
    80003fe6:	60e2                	ld	ra,24(sp)
    80003fe8:	6902                	ld	s2,0(sp)
	iput(ip);
    80003fea:	8526                	mv	a0,s1
}
    80003fec:	64a2                	ld	s1,8(sp)
    80003fee:	6105                	add	sp,sp,32
	iput(ip);
    80003ff0:	00000317          	auipc	t1,0x0
    80003ff4:	f1e30067          	jr	-226(t1) # 80003f0e <iput>
		panic("iunlock");
    80003ff8:	00005517          	auipc	a0,0x5
    80003ffc:	92850513          	add	a0,a0,-1752 # 80008920 <etext+0x920>
    80004000:	ffffc097          	auipc	ra,0xffffc
    80004004:	596080e7          	jalr	1430(ra) # 80000596 <panic>

0000000080004008 <stati>:
 * Copy stat information from inode.
 * Caller must hold ip->lock.
 */
void
stati(struct inode *ip, struct stat *st)
{
    80004008:	1141                	add	sp,sp,-16
    8000400a:	e422                	sd	s0,8(sp)
    8000400c:	0800                	add	s0,sp,16
	st->dev = ip->dev;
	st->ino = ip->inum;
	st->type = ip->type;
    8000400e:	04a55703          	lhu	a4,74(a0)
    80004012:	04455783          	lhu	a5,68(a0)
	st->dev = ip->dev;
    80004016:	00052803          	lw	a6,0(a0)
	st->ino = ip->inum;
    8000401a:	4150                	lw	a2,4(a0)
	st->nlink = ip->nlink;
	st->size = ip->size;
    8000401c:	04c56683          	lwu	a3,76(a0)
}
    80004020:	6422                	ld	s0,8(sp)
	st->type = ip->type;
    80004022:	0107171b          	sllw	a4,a4,0x10
    80004026:	8fd9                	or	a5,a5,a4
	st->dev = ip->dev;
    80004028:	0105a023          	sw	a6,0(a1)
	st->ino = ip->inum;
    8000402c:	c1d0                	sw	a2,4(a1)
	st->type = ip->type;
    8000402e:	c59c                	sw	a5,8(a1)
	st->size = ip->size;
    80004030:	e994                	sd	a3,16(a1)
}
    80004032:	0141                	add	sp,sp,16
    80004034:	8082                	ret

0000000080004036 <readi>:
 * If user_dst == 1, then dst is a user virtual address;
 * otherwise, dst is a kernel address.
 */
int
readi(struct inode *ip, int user_dst, uint64 dst, uint off, uint n)
{
    80004036:	7119                	add	sp,sp,-128
    80004038:	f8a2                	sd	s0,112(sp)
    8000403a:	e0da                	sd	s6,64(sp)
    8000403c:	fc86                	sd	ra,120(sp)
    8000403e:	0100                	add	s0,sp,128
    80004040:	8b2a                	mv	s6,a0
        uint tot = undefined, m = undefined;
	struct buf *bp = nullptr;

	if (off > ip->size || off + n < off)
    80004042:	4568                	lw	a0,76(a0)
		return 0;
    80004044:	4781                	li	a5,0
	if (off > ip->size || off + n < off)
    80004046:	0cd56563          	bltu	a0,a3,80004110 <readi+0xda>
    8000404a:	f4a6                	sd	s1,104(sp)
    8000404c:	ecce                	sd	s3,88(sp)
    8000404e:	e4d6                	sd	s5,72(sp)
    80004050:	8aba                	mv	s5,a4
    80004052:	9f35                	addw	a4,a4,a3
    80004054:	84b6                	mv	s1,a3
    80004056:	00d739b3          	sltu	s3,a4,a3
		return 0;
    8000405a:	4781                	li	a5,0
	if (off > ip->size || off + n < off)
    8000405c:	0cd76063          	bltu	a4,a3,8000411c <readi+0xe6>
    80004060:	e8d2                	sd	s4,80(sp)
    80004062:	fc5e                	sd	s7,56(sp)
    80004064:	8a32                	mv	s4,a2
	if (off + n > ip->size)
    80004066:	8bae                	mv	s7,a1
    80004068:	00e57463          	bgeu	a0,a4,80004070 <readi+0x3a>
		n = ip->size - off;
    8000406c:	40d50abb          	subw	s5,a0,a3

	for (tot = 0; tot < n; tot += m, off += m, dst += m) {
    80004070:	0c0a8a63          	beqz	s5,80004144 <readi+0x10e>
    80004074:	f862                	sd	s8,48(sp)
    80004076:	f466                	sd	s9,40(sp)
    80004078:	f0ca                	sd	s2,96(sp)
    8000407a:	f06a                	sd	s10,32(sp)
    8000407c:	ec6e                	sd	s11,24(sp)
		uint addr = bmap(ip, off / BSIZE);
		if (addr == 0)
			break;
		bp = bread(ip->dev, addr);
		m = min(n - tot, BSIZE - off % BSIZE);
    8000407e:	40000c93          	li	s9,1024
		if (either_copyout(user_dst, dst, bp->data + (off % BSIZE), m) == -1) {
    80004082:	5c7d                	li	s8,-1
    80004084:	a085                	j	800040e4 <readi+0xae>
		bp = bread(ip->dev, addr);
    80004086:	000b2503          	lw	a0,0(s6)
    8000408a:	fffff097          	auipc	ra,0xfffff
    8000408e:	482080e7          	jalr	1154(ra) # 8000350c <bread>
		m = min(n - tot, BSIZE - off % BSIZE);
    80004092:	3ff4f613          	and	a2,s1,1023
		bp = bread(ip->dev, addr);
    80004096:	8d2a                	mv	s10,a0
		m = min(n - tot, BSIZE - off % BSIZE);
    80004098:	40cc893b          	subw	s2,s9,a2
		if (either_copyout(user_dst, dst, bp->data + (off % BSIZE), m) == -1) {
    8000409c:	058d0813          	add	a6,s10,88
		m = min(n - tot, BSIZE - off % BSIZE);
    800040a0:	413a873b          	subw	a4,s5,s3
    800040a4:	0009069b          	sext.w	a3,s2
		if (either_copyout(user_dst, dst, bp->data + (off % BSIZE), m) == -1) {
    800040a8:	85d2                	mv	a1,s4
    800040aa:	855e                	mv	a0,s7
    800040ac:	9642                	add	a2,a2,a6
		m = min(n - tot, BSIZE - off % BSIZE);
    800040ae:	00d77363          	bgeu	a4,a3,800040b4 <readi+0x7e>
    800040b2:	893a                	mv	s2,a4
		if (either_copyout(user_dst, dst, bp->data + (off % BSIZE), m) == -1) {
    800040b4:	02091d93          	sll	s11,s2,0x20
    800040b8:	020ddd93          	srl	s11,s11,0x20
    800040bc:	86ee                	mv	a3,s11
    800040be:	fffff097          	auipc	ra,0xfffff
    800040c2:	854080e7          	jalr	-1964(ra) # 80002912 <either_copyout>
    800040c6:	87aa                	mv	a5,a0
			brelse(bp);
			tot = -1;
			break;
		}
		brelse(bp);
    800040c8:	856a                	mv	a0,s10
		if (either_copyout(user_dst, dst, bp->data + (off % BSIZE), m) == -1) {
    800040ca:	07878263          	beq	a5,s8,8000412e <readi+0xf8>
	for (tot = 0; tot < n; tot += m, off += m, dst += m) {
    800040ce:	013909bb          	addw	s3,s2,s3
		brelse(bp);
    800040d2:	fffff097          	auipc	ra,0xfffff
    800040d6:	56e080e7          	jalr	1390(ra) # 80003640 <brelse>
	for (tot = 0; tot < n; tot += m, off += m, dst += m) {
    800040da:	009904bb          	addw	s1,s2,s1
    800040de:	9a6e                	add	s4,s4,s11
    800040e0:	0759f063          	bgeu	s3,s5,80004140 <readi+0x10a>
		uint addr = bmap(ip, off / BSIZE);
    800040e4:	00a4d59b          	srlw	a1,s1,0xa
    800040e8:	855a                	mv	a0,s6
    800040ea:	fffff097          	auipc	ra,0xfffff
    800040ee:	778080e7          	jalr	1912(ra) # 80003862 <bmap>
    800040f2:	0005059b          	sext.w	a1,a0
		if (addr == 0)
    800040f6:	f9c1                	bnez	a1,80004086 <readi+0x50>
	}
	return tot;
    800040f8:	0009879b          	sext.w	a5,s3
    800040fc:	74a6                	ld	s1,104(sp)
    800040fe:	7906                	ld	s2,96(sp)
    80004100:	69e6                	ld	s3,88(sp)
    80004102:	6a46                	ld	s4,80(sp)
    80004104:	6aa6                	ld	s5,72(sp)
    80004106:	7be2                	ld	s7,56(sp)
    80004108:	7c42                	ld	s8,48(sp)
    8000410a:	7ca2                	ld	s9,40(sp)
    8000410c:	7d02                	ld	s10,32(sp)
    8000410e:	6de2                	ld	s11,24(sp)
}
    80004110:	70e6                	ld	ra,120(sp)
    80004112:	7446                	ld	s0,112(sp)
    80004114:	6b06                	ld	s6,64(sp)
    80004116:	853e                	mv	a0,a5
    80004118:	6109                	add	sp,sp,128
    8000411a:	8082                	ret
    8000411c:	70e6                	ld	ra,120(sp)
    8000411e:	7446                	ld	s0,112(sp)
    80004120:	74a6                	ld	s1,104(sp)
    80004122:	69e6                	ld	s3,88(sp)
    80004124:	6aa6                	ld	s5,72(sp)
    80004126:	6b06                	ld	s6,64(sp)
    80004128:	853e                	mv	a0,a5
    8000412a:	6109                	add	sp,sp,128
    8000412c:	8082                	ret
    8000412e:	f8f43423          	sd	a5,-120(s0)
			brelse(bp);
    80004132:	fffff097          	auipc	ra,0xfffff
    80004136:	50e080e7          	jalr	1294(ra) # 80003640 <brelse>
			break;
    8000413a:	f8843783          	ld	a5,-120(s0)
    8000413e:	bf7d                	j	800040fc <readi+0xc6>
	return tot;
    80004140:	87ce                	mv	a5,s3
    80004142:	bf6d                	j	800040fc <readi+0xc6>
    80004144:	74a6                	ld	s1,104(sp)
    80004146:	69e6                	ld	s3,88(sp)
    80004148:	6a46                	ld	s4,80(sp)
    8000414a:	6aa6                	ld	s5,72(sp)
    8000414c:	7be2                	ld	s7,56(sp)
	for (tot = 0; tot < n; tot += m, off += m, dst += m) {
    8000414e:	4781                	li	a5,0
	return tot;
    80004150:	b7c1                	j	80004110 <readi+0xda>

0000000080004152 <writei>:
 * If the return value is less than the requested n,
 * there was an error of some kind.
 */
int
writei(struct inode *ip, int user_src, uint64 src, uint off, uint n)
{
    80004152:	7159                	add	sp,sp,-112
    80004154:	f0a2                	sd	s0,96(sp)
    80004156:	f486                	sd	ra,104(sp)
    80004158:	e0d2                	sd	s4,64(sp)
    8000415a:	1880                	add	s0,sp,112
	uint tot = undefined, m = undefined;
	struct buf *bp = nullptr;

	if (off > ip->size || off + n < off)
    8000415c:	457c                	lw	a5,76(a0)
    8000415e:	10d7ea63          	bltu	a5,a3,80004272 <writei+0x120>
    80004162:	e4ce                	sd	s3,72(sp)
    80004164:	f45e                	sd	s7,40(sp)
    80004166:	00e687bb          	addw	a5,a3,a4
    8000416a:	89b6                	mv	s3,a3
    8000416c:	8bba                	mv	s7,a4
    8000416e:	00d7ba33          	sltu	s4,a5,a3
    80004172:	0ed7ec63          	bltu	a5,a3,8000426a <writei+0x118>
		return -1;
	if (off + n > MAXFILE * BSIZE)
    80004176:	00043737          	lui	a4,0x43
    8000417a:	0ef76863          	bltu	a4,a5,8000426a <writei+0x118>
    8000417e:	f85a                	sd	s6,48(sp)
    80004180:	8b2a                	mv	s6,a0
		return -1;

	for (tot = 0; tot < n; tot += m, off += m, src += m) {
    80004182:	0e0b8263          	beqz	s7,80004266 <writei+0x114>
    80004186:	fc56                	sd	s5,56(sp)
    80004188:	f062                	sd	s8,32(sp)
    8000418a:	ec66                	sd	s9,24(sp)
    8000418c:	e86a                	sd	s10,16(sp)
    8000418e:	eca6                	sd	s1,88(sp)
    80004190:	e8ca                	sd	s2,80(sp)
    80004192:	e46e                	sd	s11,8(sp)
    80004194:	8c2e                	mv	s8,a1
    80004196:	8ab2                	mv	s5,a2
		uint addr = bmap(ip, off / BSIZE);
		if (addr == 0)
			break;
		bp = bread(ip->dev, addr);
		m = min(n - tot, BSIZE - off % BSIZE);
    80004198:	40000d13          	li	s10,1024
		if (either_copyin(bp->data + (off % BSIZE), user_src, src, m) == -1) {
    8000419c:	5cfd                	li	s9,-1
    8000419e:	a0ad                	j	80004208 <writei+0xb6>
		bp = bread(ip->dev, addr);
    800041a0:	000b2503          	lw	a0,0(s6)
    800041a4:	fffff097          	auipc	ra,0xfffff
    800041a8:	368080e7          	jalr	872(ra) # 8000350c <bread>
		m = min(n - tot, BSIZE - off % BSIZE);
    800041ac:	3ff9f793          	and	a5,s3,1023
    800041b0:	40fd093b          	subw	s2,s10,a5
		bp = bread(ip->dev, addr);
    800041b4:	84aa                	mv	s1,a0
		m = min(n - tot, BSIZE - off % BSIZE);
    800041b6:	414b86bb          	subw	a3,s7,s4
		if (either_copyin(bp->data + (off % BSIZE), user_src, src, m) == -1) {
    800041ba:	05850513          	add	a0,a0,88
		m = min(n - tot, BSIZE - off % BSIZE);
    800041be:	0009081b          	sext.w	a6,s2
		if (either_copyin(bp->data + (off % BSIZE), user_src, src, m) == -1) {
    800041c2:	8656                	mv	a2,s5
    800041c4:	85e2                	mv	a1,s8
    800041c6:	953e                	add	a0,a0,a5
		m = min(n - tot, BSIZE - off % BSIZE);
    800041c8:	0106f363          	bgeu	a3,a6,800041ce <writei+0x7c>
    800041cc:	8936                	mv	s2,a3
		if (either_copyin(bp->data + (off % BSIZE), user_src, src, m) == -1) {
    800041ce:	02091d93          	sll	s11,s2,0x20
    800041d2:	020ddd93          	srl	s11,s11,0x20
    800041d6:	86ee                	mv	a3,s11
    800041d8:	ffffe097          	auipc	ra,0xffffe
    800041dc:	7c2080e7          	jalr	1986(ra) # 8000299a <either_copyin>
    800041e0:	87aa                	mv	a5,a0
			brelse(bp);
			break;
		}
		log_write(bp);
    800041e2:	8526                	mv	a0,s1
		if (either_copyin(bp->data + (off % BSIZE), user_src, src, m) == -1) {
    800041e4:	07978863          	beq	a5,s9,80004254 <writei+0x102>
		log_write(bp);
    800041e8:	00000097          	auipc	ra,0x0
    800041ec:	7ae080e7          	jalr	1966(ra) # 80004996 <log_write>
		brelse(bp);
    800041f0:	8526                	mv	a0,s1
	for (tot = 0; tot < n; tot += m, off += m, src += m) {
    800041f2:	01490a3b          	addw	s4,s2,s4
		brelse(bp);
    800041f6:	fffff097          	auipc	ra,0xfffff
    800041fa:	44a080e7          	jalr	1098(ra) # 80003640 <brelse>
	for (tot = 0; tot < n; tot += m, off += m, src += m) {
    800041fe:	013909bb          	addw	s3,s2,s3
    80004202:	9aee                	add	s5,s5,s11
    80004204:	017a7c63          	bgeu	s4,s7,8000421c <writei+0xca>
		uint addr = bmap(ip, off / BSIZE);
    80004208:	00a9d59b          	srlw	a1,s3,0xa
    8000420c:	855a                	mv	a0,s6
    8000420e:	fffff097          	auipc	ra,0xfffff
    80004212:	654080e7          	jalr	1620(ra) # 80003862 <bmap>
    80004216:	0005059b          	sext.w	a1,a0
		if (addr == 0)
    8000421a:	f1d9                	bnez	a1,800041a0 <writei+0x4e>
	}

	if (off > ip->size)
    8000421c:	04cb2783          	lw	a5,76(s6)
    80004220:	0137f463          	bgeu	a5,s3,80004228 <writei+0xd6>
		ip->size = off;
    80004224:	053b2623          	sw	s3,76(s6)
    80004228:	64e6                	ld	s1,88(sp)
    8000422a:	6946                	ld	s2,80(sp)
    8000422c:	7ae2                	ld	s5,56(sp)
    8000422e:	7c02                	ld	s8,32(sp)
    80004230:	6ce2                	ld	s9,24(sp)
    80004232:	6d42                	ld	s10,16(sp)
    80004234:	6da2                	ld	s11,8(sp)
         * because the loop above might have called bmap() and added a new
         * block to ip->addrs[].
         */
	iupdate(ip);

	return tot;
    80004236:	2a01                	sext.w	s4,s4
	iupdate(ip);
    80004238:	855a                	mv	a0,s6
    8000423a:	00000097          	auipc	ra,0x0
    8000423e:	a3e080e7          	jalr	-1474(ra) # 80003c78 <iupdate>
	return tot;
    80004242:	69a6                	ld	s3,72(sp)
    80004244:	7b42                	ld	s6,48(sp)
    80004246:	7ba2                	ld	s7,40(sp)
}
    80004248:	70a6                	ld	ra,104(sp)
    8000424a:	7406                	ld	s0,96(sp)
    8000424c:	8552                	mv	a0,s4
    8000424e:	6a06                	ld	s4,64(sp)
    80004250:	6165                	add	sp,sp,112
    80004252:	8082                	ret
			brelse(bp);
    80004254:	fffff097          	auipc	ra,0xfffff
    80004258:	3ec080e7          	jalr	1004(ra) # 80003640 <brelse>
	if (off > ip->size)
    8000425c:	04cb2783          	lw	a5,76(s6)
    80004260:	fd37e2e3          	bltu	a5,s3,80004224 <writei+0xd2>
    80004264:	b7d1                	j	80004228 <writei+0xd6>
	for (tot = 0; tot < n; tot += m, off += m, src += m) {
    80004266:	4a01                	li	s4,0
    80004268:	bfc1                	j	80004238 <writei+0xe6>
		return -1;
    8000426a:	69a6                	ld	s3,72(sp)
    8000426c:	7ba2                	ld	s7,40(sp)
    8000426e:	5a7d                	li	s4,-1
    80004270:	bfe1                	j	80004248 <writei+0xf6>
    80004272:	5a7d                	li	s4,-1
    80004274:	bfd1                	j	80004248 <writei+0xf6>

0000000080004276 <namecmp>:

/* Directories */

int
namecmp(const char *s, const char *t)
{
    80004276:	1141                	add	sp,sp,-16
    80004278:	e422                	sd	s0,8(sp)
    8000427a:	0800                	add	s0,sp,16
	return strncmp(s, t, DIRSIZ);
}
    8000427c:	6422                	ld	s0,8(sp)
	return strncmp(s, t, DIRSIZ);
    8000427e:	4639                	li	a2,14
}
    80004280:	0141                	add	sp,sp,16
	return strncmp(s, t, DIRSIZ);
    80004282:	ffffd317          	auipc	t1,0xffffd
    80004286:	c2e30067          	jr	-978(t1) # 80000eb0 <strncmp>

000000008000428a <dirlookup>:
 * Look for a directory entry in a directory.
 * If found, set * poff to byte offset of entry.
 */
struct inode *
dirlookup(struct inode *dp, char *name, uint * poff)
{
    8000428a:	7139                	add	sp,sp,-64
    8000428c:	f822                	sd	s0,48(sp)
    8000428e:	fc06                	sd	ra,56(sp)
    80004290:	0080                	add	s0,sp,64
    80004292:	f426                	sd	s1,40(sp)
    80004294:	f04a                	sd	s2,32(sp)
    80004296:	ec4e                	sd	s3,24(sp)
    80004298:	e852                	sd	s4,16(sp)
	uint off = undefined, inum = undefined;
	struct dirent de = {};

	if (dp->type != T_DIR)
    8000429a:	04451703          	lh	a4,68(a0)
	struct dirent de = {};
    8000429e:	fc043023          	sd	zero,-64(s0)
    800042a2:	fc043423          	sd	zero,-56(s0)
	if (dp->type != T_DIR)
    800042a6:	4785                	li	a5,1
    800042a8:	08f71b63          	bne	a4,a5,8000433e <dirlookup+0xb4>
		panic("dirlookup not DIR");

	for (off = 0; off < dp->size; off += sizeof(de)) {
    800042ac:	457c                	lw	a5,76(a0)
    800042ae:	892a                	mv	s2,a0
    800042b0:	89ae                	mv	s3,a1
    800042b2:	8a32                	mv	s4,a2
    800042b4:	4481                	li	s1,0
    800042b6:	cf9d                	beqz	a5,800042f4 <dirlookup+0x6a>
		if (readi(dp, 0, (uint64) & de, off, sizeof(de)) != sizeof(de))
    800042b8:	4741                	li	a4,16
    800042ba:	86a6                	mv	a3,s1
    800042bc:	fc040613          	add	a2,s0,-64
    800042c0:	4581                	li	a1,0
    800042c2:	854a                	mv	a0,s2
    800042c4:	00000097          	auipc	ra,0x0
    800042c8:	d72080e7          	jalr	-654(ra) # 80004036 <readi>
    800042cc:	47c1                	li	a5,16
    800042ce:	06f51063          	bne	a0,a5,8000432e <dirlookup+0xa4>
			panic("dirlookup read");
		if (de.inum == 0)
    800042d2:	fc045783          	lhu	a5,-64(s0)
    800042d6:	cb91                	beqz	a5,800042ea <dirlookup+0x60>
	return strncmp(s, t, DIRSIZ);
    800042d8:	4639                	li	a2,14
    800042da:	fc240593          	add	a1,s0,-62
    800042de:	854e                	mv	a0,s3
    800042e0:	ffffd097          	auipc	ra,0xffffd
    800042e4:	bd0080e7          	jalr	-1072(ra) # 80000eb0 <strncmp>
			continue;
		if (namecmp(name, de.name) == 0) {
    800042e8:	cd19                	beqz	a0,80004306 <dirlookup+0x7c>
	for (off = 0; off < dp->size; off += sizeof(de)) {
    800042ea:	04c92783          	lw	a5,76(s2)
    800042ee:	24c1                	addw	s1,s1,16
    800042f0:	fcf4e4e3          	bltu	s1,a5,800042b8 <dirlookup+0x2e>
			return iget(dp->dev, inum);
		}
	}

	return 0;
}
    800042f4:	70e2                	ld	ra,56(sp)
    800042f6:	7442                	ld	s0,48(sp)
    800042f8:	74a2                	ld	s1,40(sp)
    800042fa:	7902                	ld	s2,32(sp)
    800042fc:	69e2                	ld	s3,24(sp)
    800042fe:	6a42                	ld	s4,16(sp)
	return 0;
    80004300:	4501                	li	a0,0
}
    80004302:	6121                	add	sp,sp,64
    80004304:	8082                	ret
			    if (poff)
    80004306:	000a0463          	beqz	s4,8000430e <dirlookup+0x84>
				*poff = off;
    8000430a:	009a2023          	sw	s1,0(s4)
			return iget(dp->dev, inum);
    8000430e:	fc045583          	lhu	a1,-64(s0)
    80004312:	00092503          	lw	a0,0(s2)
    80004316:	fffff097          	auipc	ra,0xfffff
    8000431a:	65a080e7          	jalr	1626(ra) # 80003970 <iget>
}
    8000431e:	70e2                	ld	ra,56(sp)
    80004320:	7442                	ld	s0,48(sp)
    80004322:	74a2                	ld	s1,40(sp)
    80004324:	7902                	ld	s2,32(sp)
    80004326:	69e2                	ld	s3,24(sp)
    80004328:	6a42                	ld	s4,16(sp)
    8000432a:	6121                	add	sp,sp,64
    8000432c:	8082                	ret
			panic("dirlookup read");
    8000432e:	00004517          	auipc	a0,0x4
    80004332:	61250513          	add	a0,a0,1554 # 80008940 <etext+0x940>
    80004336:	ffffc097          	auipc	ra,0xffffc
    8000433a:	260080e7          	jalr	608(ra) # 80000596 <panic>
		panic("dirlookup not DIR");
    8000433e:	00004517          	auipc	a0,0x4
    80004342:	5ea50513          	add	a0,a0,1514 # 80008928 <etext+0x928>
    80004346:	ffffc097          	auipc	ra,0xffffc
    8000434a:	250080e7          	jalr	592(ra) # 80000596 <panic>

000000008000434e <namex>:
 * path element into name, which must have room for DIRSIZ bytes.
 * Must be called inside a transaction since it calls iput().
 */
static struct inode *
namex(char *path, int nameiparent, char *name)
{
    8000434e:	711d                	add	sp,sp,-96
    80004350:	e8a2                	sd	s0,80(sp)
    80004352:	e4a6                	sd	s1,72(sp)
    80004354:	f456                	sd	s5,40(sp)
    80004356:	f05a                	sd	s6,32(sp)
    80004358:	ec86                	sd	ra,88(sp)
    8000435a:	e0ca                	sd	s2,64(sp)
    8000435c:	fc4e                	sd	s3,56(sp)
    8000435e:	f852                	sd	s4,48(sp)
    80004360:	ec5e                	sd	s7,24(sp)
    80004362:	e862                	sd	s8,16(sp)
    80004364:	e466                	sd	s9,8(sp)
    80004366:	1080                	add	s0,sp,96
        struct inode *ip = nullptr, *next = nullptr;

        if    (*path == '/')
    80004368:	00054703          	lbu	a4,0(a0)
    8000436c:	02f00793          	li	a5,47
{
    80004370:	84aa                	mv	s1,a0
    80004372:	8b2e                	mv	s6,a1
    80004374:	8ab2                	mv	s5,a2
        if    (*path == '/')
    80004376:	16f70163          	beq	a4,a5,800044d8 <namex+0x18a>
                ip = iget(ROOTDEV, ROOTINO);
        else
                ip = idup(myproc()->cwd);
    8000437a:	ffffe097          	auipc	ra,0xffffe
    8000437e:	a76080e7          	jalr	-1418(ra) # 80001df0 <myproc>
    80004382:	87aa                	mv	a5,a0
    80004384:	1507ba03          	ld	s4,336(a5)
	acquire(&itable.lock);
    80004388:	0001b517          	auipc	a0,0x1b
    8000438c:	15050513          	add	a0,a0,336 # 8001f4d8 <itable>
    80004390:	ffffd097          	auipc	ra,0xffffd
    80004394:	8d0080e7          	jalr	-1840(ra) # 80000c60 <acquire>
	ip->ref++;
    80004398:	008a2783          	lw	a5,8(s4)
	release(&itable.lock);
    8000439c:	0001b517          	auipc	a0,0x1b
    800043a0:	13c50513          	add	a0,a0,316 # 8001f4d8 <itable>
	ip->ref++;
    800043a4:	2785                	addw	a5,a5,1
    800043a6:	00fa2423          	sw	a5,8(s4)
	release(&itable.lock);
    800043aa:	ffffd097          	auipc	ra,0xffffd
    800043ae:	976080e7          	jalr	-1674(ra) # 80000d20 <release>
	while (*path == '/')
    800043b2:	02f00913          	li	s2,47
	if (len >= DIRSIZ)
    800043b6:	4c35                	li	s8,13

        while ((path = skipelem(path, name)) != 0) {
                ilock(ip);
                if (ip->type != T_DIR) {
    800043b8:	4b85                	li	s7,1
	while (*path == '/')
    800043ba:	0004c783          	lbu	a5,0(s1)
    800043be:	01279763          	bne	a5,s2,800043cc <namex+0x7e>
    800043c2:	0014c783          	lbu	a5,1(s1)
		path++;
    800043c6:	0485                	add	s1,s1,1
	while (*path == '/')
    800043c8:	ff278de3          	beq	a5,s2,800043c2 <namex+0x74>
	if (*path == 0)
    800043cc:	cfd5                	beqz	a5,80004488 <namex+0x13a>
	while (*path != '/' && *path != 0)
    800043ce:	0004c783          	lbu	a5,0(s1)
    800043d2:	89a6                	mv	s3,s1
    800043d4:	8cd6                	mv	s9,s5
	if (len >= DIRSIZ)
    800043d6:	4601                	li	a2,0
	while (*path != '/' && *path != 0)
    800043d8:	09278e63          	beq	a5,s2,80004474 <namex+0x126>
    800043dc:	c791                	beqz	a5,800043e8 <namex+0x9a>
    800043de:	0019c783          	lbu	a5,1(s3)
		path++;
    800043e2:	0985                	add	s3,s3,1
	while (*path != '/' && *path != 0)
    800043e4:	ff279ce3          	bne	a5,s2,800043dc <namex+0x8e>
	if (len >= DIRSIZ)
    800043e8:	4099863b          	subw	a2,s3,s1
    800043ec:	08cc7263          	bgeu	s8,a2,80004470 <namex+0x122>
		memmove(name, s, DIRSIZ);
    800043f0:	85a6                	mv	a1,s1
    800043f2:	4639                	li	a2,14
    800043f4:	8556                	mv	a0,s5
    800043f6:	ffffd097          	auipc	ra,0xffffd
    800043fa:	a32080e7          	jalr	-1486(ra) # 80000e28 <memmove>
    800043fe:	84ce                	mv	s1,s3
	while (*path == '/')
    80004400:	0009c783          	lbu	a5,0(s3)
    80004404:	01279763          	bne	a5,s2,80004412 <namex+0xc4>
    80004408:	0014c783          	lbu	a5,1(s1)
		path++;
    8000440c:	0485                	add	s1,s1,1
	while (*path == '/')
    8000440e:	ff278de3          	beq	a5,s2,80004408 <namex+0xba>
                ilock(ip);
    80004412:	8552                	mv	a0,s4
    80004414:	00000097          	auipc	ra,0x0
    80004418:	930080e7          	jalr	-1744(ra) # 80003d44 <ilock>
                if (ip->type != T_DIR) {
    8000441c:	044a1783          	lh	a5,68(s4)
    80004420:	09779463          	bne	a5,s7,800044a8 <namex+0x15a>
                        iunlockput(ip);
                        return 0;
                }
                if (nameiparent && *path == '\0') {
    80004424:	000b0563          	beqz	s6,8000442e <namex+0xe0>
    80004428:	0004c783          	lbu	a5,0(s1)
    8000442c:	cfd5                	beqz	a5,800044e8 <namex+0x19a>
                        //Stop one level early.
                        iunlock(ip);
                        return ip;
                }
                if ((next = dirlookup(ip, name, 0)) == 0) {
    8000442e:	4601                	li	a2,0
    80004430:	85d6                	mv	a1,s5
    80004432:	8552                	mv	a0,s4
    80004434:	00000097          	auipc	ra,0x0
    80004438:	e56080e7          	jalr	-426(ra) # 8000428a <dirlookup>
    8000443c:	89aa                	mv	s3,a0
    8000443e:	c52d                	beqz	a0,800044a8 <namex+0x15a>
	if (ip == 0 || !holdingsleep(&ip->lock) || ip->ref < 1)
    80004440:	010a0c93          	add	s9,s4,16
    80004444:	8566                	mv	a0,s9
    80004446:	00000097          	auipc	ra,0x0
    8000444a:	6fa080e7          	jalr	1786(ra) # 80004b40 <holdingsleep>
    8000444e:	cd5d                	beqz	a0,8000450c <namex+0x1be>
    80004450:	008a2783          	lw	a5,8(s4)
    80004454:	0af05c63          	blez	a5,8000450c <namex+0x1be>
	releasesleep(&ip->lock);
    80004458:	8566                	mv	a0,s9
    8000445a:	00000097          	auipc	ra,0x0
    8000445e:	6a4080e7          	jalr	1700(ra) # 80004afe <releasesleep>
	iput(ip);
    80004462:	8552                	mv	a0,s4
    80004464:	00000097          	auipc	ra,0x0
    80004468:	aaa080e7          	jalr	-1366(ra) # 80003f0e <iput>
                        iunlockput(ip);
                        return 0;
                }
                iunlockput(ip);
                ip = next;
    8000446c:	8a4e                	mv	s4,s3
    8000446e:	b7b1                	j	800043ba <namex+0x6c>
		name[len] = 0;
    80004470:	00ca8cb3          	add	s9,s5,a2
		memmove(name, s, len);
    80004474:	85a6                	mv	a1,s1
    80004476:	8556                	mv	a0,s5
    80004478:	ffffd097          	auipc	ra,0xffffd
    8000447c:	9b0080e7          	jalr	-1616(ra) # 80000e28 <memmove>
		name[len] = 0;
    80004480:	84ce                	mv	s1,s3
    80004482:	000c8023          	sb	zero,0(s9)
    80004486:	bfad                	j	80004400 <namex+0xb2>
        }
        if    (nameiparent) {
    80004488:	040b1163          	bnez	s6,800044ca <namex+0x17c>
                iput(ip);
                return 0;
        }
        return ip;
}
    8000448c:	60e6                	ld	ra,88(sp)
    8000448e:	6446                	ld	s0,80(sp)
    80004490:	64a6                	ld	s1,72(sp)
    80004492:	6906                	ld	s2,64(sp)
    80004494:	79e2                	ld	s3,56(sp)
    80004496:	7aa2                	ld	s5,40(sp)
    80004498:	7b02                	ld	s6,32(sp)
    8000449a:	6be2                	ld	s7,24(sp)
    8000449c:	6c42                	ld	s8,16(sp)
    8000449e:	6ca2                	ld	s9,8(sp)
    800044a0:	8552                	mv	a0,s4
    800044a2:	7a42                	ld	s4,48(sp)
    800044a4:	6125                	add	sp,sp,96
    800044a6:	8082                	ret
	if (ip == 0 || !holdingsleep(&ip->lock) || ip->ref < 1)
    800044a8:	010a0493          	add	s1,s4,16
    800044ac:	8526                	mv	a0,s1
    800044ae:	00000097          	auipc	ra,0x0
    800044b2:	692080e7          	jalr	1682(ra) # 80004b40 <holdingsleep>
    800044b6:	c939                	beqz	a0,8000450c <namex+0x1be>
    800044b8:	008a2783          	lw	a5,8(s4)
    800044bc:	04f05863          	blez	a5,8000450c <namex+0x1be>
	releasesleep(&ip->lock);
    800044c0:	8526                	mv	a0,s1
    800044c2:	00000097          	auipc	ra,0x0
    800044c6:	63c080e7          	jalr	1596(ra) # 80004afe <releasesleep>
	iput(ip);
    800044ca:	8552                	mv	a0,s4
    800044cc:	00000097          	auipc	ra,0x0
    800044d0:	a42080e7          	jalr	-1470(ra) # 80003f0e <iput>
                        return 0;
    800044d4:	4a01                	li	s4,0
    800044d6:	bf5d                	j	8000448c <namex+0x13e>
                ip = iget(ROOTDEV, ROOTINO);
    800044d8:	4585                	li	a1,1
    800044da:	4505                	li	a0,1
    800044dc:	fffff097          	auipc	ra,0xfffff
    800044e0:	494080e7          	jalr	1172(ra) # 80003970 <iget>
    800044e4:	8a2a                	mv	s4,a0
    800044e6:	b5f1                	j	800043b2 <namex+0x64>
	if (ip == 0 || !holdingsleep(&ip->lock) || ip->ref < 1)
    800044e8:	010a0493          	add	s1,s4,16
    800044ec:	8526                	mv	a0,s1
    800044ee:	00000097          	auipc	ra,0x0
    800044f2:	652080e7          	jalr	1618(ra) # 80004b40 <holdingsleep>
    800044f6:	c919                	beqz	a0,8000450c <namex+0x1be>
    800044f8:	008a2783          	lw	a5,8(s4)
    800044fc:	00f05863          	blez	a5,8000450c <namex+0x1be>
	releasesleep(&ip->lock);
    80004500:	8526                	mv	a0,s1
    80004502:	00000097          	auipc	ra,0x0
    80004506:	5fc080e7          	jalr	1532(ra) # 80004afe <releasesleep>
}
    8000450a:	b749                	j	8000448c <namex+0x13e>
		panic("iunlock");
    8000450c:	00004517          	auipc	a0,0x4
    80004510:	41450513          	add	a0,a0,1044 # 80008920 <etext+0x920>
    80004514:	ffffc097          	auipc	ra,0xffffc
    80004518:	082080e7          	jalr	130(ra) # 80000596 <panic>

000000008000451c <dirlink>:
{
    8000451c:	7139                	add	sp,sp,-64
    8000451e:	f822                	sd	s0,48(sp)
    80004520:	f04a                	sd	s2,32(sp)
    80004522:	0080                	add	s0,sp,64
    80004524:	ec4e                	sd	s3,24(sp)
    80004526:	e852                	sd	s4,16(sp)
    80004528:	fc06                	sd	ra,56(sp)
    8000452a:	89b2                	mv	s3,a2
	if ((ip = dirlookup(dp, name, 0)) != 0) {
    8000452c:	4601                	li	a2,0
{
    8000452e:	892a                	mv	s2,a0
    80004530:	8a2e                	mv	s4,a1
	struct dirent de = {};
    80004532:	fc043023          	sd	zero,-64(s0)
    80004536:	fc043423          	sd	zero,-56(s0)
	if ((ip = dirlookup(dp, name, 0)) != 0) {
    8000453a:	00000097          	auipc	ra,0x0
    8000453e:	d50080e7          	jalr	-688(ra) # 8000428a <dirlookup>
    80004542:	ed2d                	bnez	a0,800045bc <dirlink+0xa0>
    80004544:	f426                	sd	s1,40(sp)
        for (off = 0; off < dp->size; off += sizeof(de)) {
    80004546:	04c92483          	lw	s1,76(s2)
    8000454a:	c885                	beqz	s1,8000457a <dirlink+0x5e>
    8000454c:	4481                	li	s1,0
    8000454e:	a031                	j	8000455a <dirlink+0x3e>
    80004550:	04c92783          	lw	a5,76(s2)
    80004554:	24c1                	addw	s1,s1,16
    80004556:	02f4f263          	bgeu	s1,a5,8000457a <dirlink+0x5e>
                if (readi(dp, 0, (uint64) & de, off, sizeof(de)) != sizeof(de))
    8000455a:	4741                	li	a4,16
    8000455c:	86a6                	mv	a3,s1
    8000455e:	fc040613          	add	a2,s0,-64
    80004562:	4581                	li	a1,0
    80004564:	854a                	mv	a0,s2
    80004566:	00000097          	auipc	ra,0x0
    8000456a:	ad0080e7          	jalr	-1328(ra) # 80004036 <readi>
    8000456e:	47c1                	li	a5,16
    80004570:	04f51c63          	bne	a0,a5,800045c8 <dirlink+0xac>
                if (de.inum == 0)
    80004574:	fc045783          	lhu	a5,-64(s0)
    80004578:	ffe1                	bnez	a5,80004550 <dirlink+0x34>
        strncpy(de.name, name, DIRSIZ);
    8000457a:	4639                	li	a2,14
    8000457c:	85d2                	mv	a1,s4
    8000457e:	fc240513          	add	a0,s0,-62
    80004582:	ffffd097          	auipc	ra,0xffffd
    80004586:	968080e7          	jalr	-1688(ra) # 80000eea <strncpy>
        if (writei(dp, 0, (uint64) & de, off, sizeof(de)) != sizeof(de))
    8000458a:	86a6                	mv	a3,s1
    8000458c:	4741                	li	a4,16
    8000458e:	fc040613          	add	a2,s0,-64
    80004592:	4581                	li	a1,0
    80004594:	854a                	mv	a0,s2
        de.inum = inum;
    80004596:	fd341023          	sh	s3,-64(s0)
        if (writei(dp, 0, (uint64) & de, off, sizeof(de)) != sizeof(de))
    8000459a:	00000097          	auipc	ra,0x0
    8000459e:	bb8080e7          	jalr	-1096(ra) # 80004152 <writei>
    800045a2:	1541                	add	a0,a0,-16
    800045a4:	74a2                	ld	s1,40(sp)
    800045a6:	00a03533          	snez	a0,a0
    800045aa:	40a00533          	neg	a0,a0
}
    800045ae:	70e2                	ld	ra,56(sp)
    800045b0:	7442                	ld	s0,48(sp)
    800045b2:	7902                	ld	s2,32(sp)
    800045b4:	69e2                	ld	s3,24(sp)
    800045b6:	6a42                	ld	s4,16(sp)
    800045b8:	6121                	add	sp,sp,64
    800045ba:	8082                	ret
		iput(ip);
    800045bc:	00000097          	auipc	ra,0x0
    800045c0:	952080e7          	jalr	-1710(ra) # 80003f0e <iput>
		return -1;
    800045c4:	557d                	li	a0,-1
    800045c6:	b7e5                	j	800045ae <dirlink+0x92>
                        panic("dirlink read");
    800045c8:	00004517          	auipc	a0,0x4
    800045cc:	38850513          	add	a0,a0,904 # 80008950 <etext+0x950>
    800045d0:	ffffc097          	auipc	ra,0xffffc
    800045d4:	fc6080e7          	jalr	-58(ra) # 80000596 <panic>

00000000800045d8 <namei>:

struct inode *
namei(char *path)
{
    800045d8:	1101                	add	sp,sp,-32
    800045da:	e822                	sd	s0,16(sp)
    800045dc:	ec06                	sd	ra,24(sp)
    800045de:	1000                	add	s0,sp,32
        char name[DIRSIZ] = {};
        return namex(path, 0, name);
    800045e0:	fe040613          	add	a2,s0,-32
    800045e4:	4581                	li	a1,0
        char name[DIRSIZ] = {};
    800045e6:	fe043023          	sd	zero,-32(s0)
    800045ea:	fe042423          	sw	zero,-24(s0)
    800045ee:	fe041623          	sh	zero,-20(s0)
        return namex(path, 0, name);
    800045f2:	00000097          	auipc	ra,0x0
    800045f6:	d5c080e7          	jalr	-676(ra) # 8000434e <namex>
}
    800045fa:	60e2                	ld	ra,24(sp)
    800045fc:	6442                	ld	s0,16(sp)
    800045fe:	6105                	add	sp,sp,32
    80004600:	8082                	ret

0000000080004602 <nameiparent>:

struct inode *
nameiparent(char *path, char *name)
{
    80004602:	1141                	add	sp,sp,-16
    80004604:	e422                	sd	s0,8(sp)
    80004606:	0800                	add	s0,sp,16
        return namex(path, 1, name);
}
    80004608:	6422                	ld	s0,8(sp)
{
    8000460a:	862e                	mv	a2,a1
        return namex(path, 1, name);
    8000460c:	4585                	li	a1,1
}
    8000460e:	0141                	add	sp,sp,16
        return namex(path, 1, name);
    80004610:	00000317          	auipc	t1,0x0
    80004614:	d3e30067          	jr	-706(t1) # 8000434e <namex>

0000000080004618 <write_head>:
 * This is the true point at which the
 * current transaction commits.
 */
static void
write_head(void)
{
    80004618:	1101                	add	sp,sp,-32
    8000461a:	e822                	sd	s0,16(sp)
    8000461c:	e426                	sd	s1,8(sp)
    8000461e:	ec06                	sd	ra,24(sp)
    80004620:	1000                	add	s0,sp,32
        struct buf *buf = bread(log.dev, log.start);
    80004622:	0001d497          	auipc	s1,0x1d
    80004626:	95e48493          	add	s1,s1,-1698 # 80020f80 <log>
    8000462a:	4c8c                	lw	a1,24(s1)
    8000462c:	5488                	lw	a0,40(s1)
    8000462e:	fffff097          	auipc	ra,0xfffff
    80004632:	ede080e7          	jalr	-290(ra) # 8000350c <bread>
        struct logheader *hb = (struct logheader *)(buf->data);
        int i = undefined;
        hb->n = log.lh.n;
    80004636:	54d0                	lw	a2,44(s1)
        struct buf *buf = bread(log.dev, log.start);
    80004638:	84aa                	mv	s1,a0
        hb->n = log.lh.n;
    8000463a:	cd30                	sw	a2,88(a0)
        for (i = 0; i < log.lh.n; i++) {
    8000463c:	00c05f63          	blez	a2,8000465a <write_head+0x42>
    80004640:	060a                	sll	a2,a2,0x2
    80004642:	0001d717          	auipc	a4,0x1d
    80004646:	96e70713          	add	a4,a4,-1682 # 80020fb0 <log+0x30>
    8000464a:	87aa                	mv	a5,a0
    8000464c:	962a                	add	a2,a2,a0
                hb->block[i] = log.lh.block[i];
    8000464e:	4314                	lw	a3,0(a4)
        for (i = 0; i < log.lh.n; i++) {
    80004650:	0791                	add	a5,a5,4
    80004652:	0711                	add	a4,a4,4
                hb->block[i] = log.lh.block[i];
    80004654:	cfb4                	sw	a3,88(a5)
        for (i = 0; i < log.lh.n; i++) {
    80004656:	fec79ce3          	bne	a5,a2,8000464e <write_head+0x36>
        }
        bwrite(buf);
    8000465a:	8526                	mv	a0,s1
    8000465c:	fffff097          	auipc	ra,0xfffff
    80004660:	fa8080e7          	jalr	-88(ra) # 80003604 <bwrite>
        brelse(buf);
}
    80004664:	6442                	ld	s0,16(sp)
    80004666:	60e2                	ld	ra,24(sp)
        brelse(buf);
    80004668:	8526                	mv	a0,s1
}
    8000466a:	64a2                	ld	s1,8(sp)
    8000466c:	6105                	add	sp,sp,32
        brelse(buf);
    8000466e:	fffff317          	auipc	t1,0xfffff
    80004672:	fd230067          	jr	-46(t1) # 80003640 <brelse>

0000000080004676 <install_trans>:
{
    80004676:	7139                	add	sp,sp,-64
    80004678:	f822                	sd	s0,48(sp)
    8000467a:	ec4e                	sd	s3,24(sp)
    8000467c:	fc06                	sd	ra,56(sp)
    8000467e:	0080                	add	s0,sp,64
        for (tail = 0; tail < log.lh.n; tail++) {
    80004680:	0001d997          	auipc	s3,0x1d
    80004684:	90098993          	add	s3,s3,-1792 # 80020f80 <log>
    80004688:	02c9a783          	lw	a5,44(s3)
    8000468c:	08f05f63          	blez	a5,8000472a <install_trans+0xb4>
    80004690:	e852                	sd	s4,16(sp)
    80004692:	e456                	sd	s5,8(sp)
    80004694:	e05a                	sd	s6,0(sp)
    80004696:	f426                	sd	s1,40(sp)
    80004698:	f04a                	sd	s2,32(sp)
    8000469a:	8b2a                	mv	s6,a0
    8000469c:	0001da97          	auipc	s5,0x1d
    800046a0:	914a8a93          	add	s5,s5,-1772 # 80020fb0 <log+0x30>
    800046a4:	4a01                	li	s4,0
    800046a6:	a00d                	j	800046c8 <install_trans+0x52>
                brelse(lbuf);
    800046a8:	854a                	mv	a0,s2
    800046aa:	fffff097          	auipc	ra,0xfffff
    800046ae:	f96080e7          	jalr	-106(ra) # 80003640 <brelse>
                brelse(dbuf);
    800046b2:	8526                	mv	a0,s1
    800046b4:	fffff097          	auipc	ra,0xfffff
    800046b8:	f8c080e7          	jalr	-116(ra) # 80003640 <brelse>
        for (tail = 0; tail < log.lh.n; tail++) {
    800046bc:	02c9a783          	lw	a5,44(s3)
    800046c0:	2a05                	addw	s4,s4,1
    800046c2:	0a91                	add	s5,s5,4
    800046c4:	04fa5e63          	bge	s4,a5,80004720 <install_trans+0xaa>
                struct buf *lbuf = bread(log.dev, log.start + tail + 1);
    800046c8:	0189a583          	lw	a1,24(s3)
    800046cc:	0289a503          	lw	a0,40(s3)
    800046d0:	014585bb          	addw	a1,a1,s4
    800046d4:	2585                	addw	a1,a1,1
    800046d6:	fffff097          	auipc	ra,0xfffff
    800046da:	e36080e7          	jalr	-458(ra) # 8000350c <bread>
                struct buf *dbuf = bread(log.dev, log.lh.block[tail]);
    800046de:	000aa583          	lw	a1,0(s5)
                struct buf *lbuf = bread(log.dev, log.start + tail + 1);
    800046e2:	892a                	mv	s2,a0
                struct buf *dbuf = bread(log.dev, log.lh.block[tail]);
    800046e4:	0289a503          	lw	a0,40(s3)
    800046e8:	fffff097          	auipc	ra,0xfffff
    800046ec:	e24080e7          	jalr	-476(ra) # 8000350c <bread>
    800046f0:	84aa                	mv	s1,a0
                memmove(dbuf->data, lbuf->data, BSIZE);
    800046f2:	40000613          	li	a2,1024
    800046f6:	05890593          	add	a1,s2,88
    800046fa:	05850513          	add	a0,a0,88
    800046fe:	ffffc097          	auipc	ra,0xffffc
    80004702:	72a080e7          	jalr	1834(ra) # 80000e28 <memmove>
                bwrite(dbuf);
    80004706:	8526                	mv	a0,s1
    80004708:	fffff097          	auipc	ra,0xfffff
    8000470c:	efc080e7          	jalr	-260(ra) # 80003604 <bwrite>
                if  (recovering == 0)
    80004710:	f80b1ce3          	bnez	s6,800046a8 <install_trans+0x32>
                        bunpin(dbuf);
    80004714:	8526                	mv	a0,s1
    80004716:	fffff097          	auipc	ra,0xfffff
    8000471a:	ff6080e7          	jalr	-10(ra) # 8000370c <bunpin>
    8000471e:	b769                	j	800046a8 <install_trans+0x32>
    80004720:	74a2                	ld	s1,40(sp)
    80004722:	7902                	ld	s2,32(sp)
    80004724:	6a42                	ld	s4,16(sp)
    80004726:	6aa2                	ld	s5,8(sp)
    80004728:	6b02                	ld	s6,0(sp)
}
    8000472a:	70e2                	ld	ra,56(sp)
    8000472c:	7442                	ld	s0,48(sp)
    8000472e:	69e2                	ld	s3,24(sp)
    80004730:	6121                	add	sp,sp,64
    80004732:	8082                	ret

0000000080004734 <initlog>:
{
    80004734:	7179                	add	sp,sp,-48
    80004736:	f406                	sd	ra,40(sp)
    80004738:	f022                	sd	s0,32(sp)
    8000473a:	ec26                	sd	s1,24(sp)
    8000473c:	e84a                	sd	s2,16(sp)
        initlock(&log.lock, "log");
    8000473e:	0001d497          	auipc	s1,0x1d
    80004742:	84248493          	add	s1,s1,-1982 # 80020f80 <log>
{
    80004746:	e44e                	sd	s3,8(sp)
    80004748:	1800                	add	s0,sp,48
    8000474a:	892a                	mv	s2,a0
    8000474c:	89ae                	mv	s3,a1
        initlock(&log.lock, "log");
    8000474e:	8526                	mv	a0,s1
    80004750:	00004597          	auipc	a1,0x4
    80004754:	21058593          	add	a1,a1,528 # 80008960 <etext+0x960>
    80004758:	ffffc097          	auipc	ra,0xffffc
    8000475c:	478080e7          	jalr	1144(ra) # 80000bd0 <initlock>
        log.start = sb->logstart;
    80004760:	0149a583          	lw	a1,20(s3)
    80004764:	0109e703          	lwu	a4,16(s3)
        struct buf *buf = bread(log.dev, log.start);
    80004768:	854a                	mv	a0,s2
        log.start = sb->logstart;
    8000476a:	02059793          	sll	a5,a1,0x20
    8000476e:	1702                	sll	a4,a4,0x20
    80004770:	9381                	srl	a5,a5,0x20
    80004772:	8fd9                	or	a5,a5,a4
    80004774:	ec9c                	sd	a5,24(s1)
        log.dev = dev;
    80004776:	0324a423          	sw	s2,40(s1)
        struct buf *buf = bread(log.dev, log.start);
    8000477a:	fffff097          	auipc	ra,0xfffff
    8000477e:	d92080e7          	jalr	-622(ra) # 8000350c <bread>
        log.lh.n = lh->n;
    80004782:	4d30                	lw	a2,88(a0)
    80004784:	d4d0                	sw	a2,44(s1)
        for (i = 0; i < log.lh.n; i++) {
    80004786:	02c05063          	blez	a2,800047a6 <initlog+0x72>
    8000478a:	060a                	sll	a2,a2,0x2
    8000478c:	87aa                	mv	a5,a0
    8000478e:	0001d717          	auipc	a4,0x1d
    80004792:	82270713          	add	a4,a4,-2014 # 80020fb0 <log+0x30>
    80004796:	962a                	add	a2,a2,a0
                log.lh.block[i] = lh->block[i];
    80004798:	4ff4                	lw	a3,92(a5)
        for (i = 0; i < log.lh.n; i++) {
    8000479a:	0791                	add	a5,a5,4
    8000479c:	0711                	add	a4,a4,4
                log.lh.block[i] = lh->block[i];
    8000479e:	fed72e23          	sw	a3,-4(a4)
        for (i = 0; i < log.lh.n; i++) {
    800047a2:	fec79be3          	bne	a5,a2,80004798 <initlog+0x64>
        brelse(buf);
    800047a6:	fffff097          	auipc	ra,0xfffff
    800047aa:	e9a080e7          	jalr	-358(ra) # 80003640 <brelse>

static void
recover_from_log(void)
{
        read_head();
        install_trans(1);
    800047ae:	4505                	li	a0,1
    800047b0:	00000097          	auipc	ra,0x0
    800047b4:	ec6080e7          	jalr	-314(ra) # 80004676 <install_trans>
}
    800047b8:	7402                	ld	s0,32(sp)
    800047ba:	70a2                	ld	ra,40(sp)
    800047bc:	64e2                	ld	s1,24(sp)
    800047be:	6942                	ld	s2,16(sp)
    800047c0:	69a2                	ld	s3,8(sp)
        /* if committed, copy from log to disk */
        log.lh.n = 0;
    800047c2:	0001c797          	auipc	a5,0x1c
    800047c6:	7e07a523          	sw	zero,2026(a5) # 80020fac <log+0x2c>
}
    800047ca:	6145                	add	sp,sp,48
        write_head();
    800047cc:	00000317          	auipc	t1,0x0
    800047d0:	e4c30067          	jr	-436(t1) # 80004618 <write_head>

00000000800047d4 <begin_op>:
/*
 * called at the start of each FS system call.
 */
void
begin_op(void)
{
    800047d4:	1101                	add	sp,sp,-32
    800047d6:	e822                	sd	s0,16(sp)
    800047d8:	e426                	sd	s1,8(sp)
    800047da:	e04a                	sd	s2,0(sp)
    800047dc:	ec06                	sd	ra,24(sp)
    800047de:	1000                	add	s0,sp,32
        acquire(&log.lock);
    800047e0:	0001c517          	auipc	a0,0x1c
    800047e4:	7a050513          	add	a0,a0,1952 # 80020f80 <log>
    800047e8:	ffffc097          	auipc	ra,0xffffc
    800047ec:	478080e7          	jalr	1144(ra) # 80000c60 <acquire>
    800047f0:	0001c497          	auipc	s1,0x1c
    800047f4:	79048493          	add	s1,s1,1936 # 80020f80 <log>
        while (1) {
                if (log.committing) {
                        sleep(&log, &log.lock);
                } else if (log.lh.n + (log.outstanding + 1) * MAXOPBLOCKS > LOGSIZE) {
    800047f8:	4979                	li	s2,30
    800047fa:	a029                	j	80004804 <begin_op+0x30>
                        sleep(&log, &log.lock);
    800047fc:	ffffe097          	auipc	ra,0xffffe
    80004800:	df2080e7          	jalr	-526(ra) # 800025ee <sleep>
                if (log.committing) {
    80004804:	50dc                	lw	a5,36(s1)
                        sleep(&log, &log.lock);
    80004806:	85a6                	mv	a1,s1
    80004808:	0001c517          	auipc	a0,0x1c
    8000480c:	77850513          	add	a0,a0,1912 # 80020f80 <log>
                if (log.committing) {
    80004810:	f7f5                	bnez	a5,800047fc <begin_op+0x28>
                } else if (log.lh.n + (log.outstanding + 1) * MAXOPBLOCKS > LOGSIZE) {
    80004812:	5098                	lw	a4,32(s1)
    80004814:	54d4                	lw	a3,44(s1)
    80004816:	2705                	addw	a4,a4,1
    80004818:	0027179b          	sllw	a5,a4,0x2
    8000481c:	9fb9                	addw	a5,a5,a4
    8000481e:	0017979b          	sllw	a5,a5,0x1
    80004822:	9fb5                	addw	a5,a5,a3
    80004824:	fcf96ce3          	bltu	s2,a5,800047fc <begin_op+0x28>
                        log.outstanding += 1;
                        release(&log.lock);
                        break;
                }
        }
}
    80004828:	6442                	ld	s0,16(sp)
    8000482a:	60e2                	ld	ra,24(sp)
    8000482c:	6902                	ld	s2,0(sp)
                        log.outstanding += 1;
    8000482e:	d098                	sw	a4,32(s1)
}
    80004830:	64a2                	ld	s1,8(sp)
                        release(&log.lock);
    80004832:	0001c517          	auipc	a0,0x1c
    80004836:	74e50513          	add	a0,a0,1870 # 80020f80 <log>
}
    8000483a:	6105                	add	sp,sp,32
                        release(&log.lock);
    8000483c:	ffffc317          	auipc	t1,0xffffc
    80004840:	4e430067          	jr	1252(t1) # 80000d20 <release>

0000000080004844 <end_op>:
/*
 * called at the end of each FS system call.
 * commits if this was the last outstanding operation.
 */
void
end_op(void){
    80004844:	7139                	add	sp,sp,-64
    80004846:	f822                	sd	s0,48(sp)
    80004848:	f426                	sd	s1,40(sp)
    8000484a:	f04a                	sd	s2,32(sp)
        int do_commit = 0;

        acquire(&log.lock);
    8000484c:	0001c497          	auipc	s1,0x1c
    80004850:	73448493          	add	s1,s1,1844 # 80020f80 <log>
end_op(void){
    80004854:	fc06                	sd	ra,56(sp)
    80004856:	0080                	add	s0,sp,64
        acquire(&log.lock);
    80004858:	8526                	mv	a0,s1
    8000485a:	ffffc097          	auipc	ra,0xffffc
    8000485e:	406080e7          	jalr	1030(ra) # 80000c60 <acquire>
        log.outstanding -= 1;
    80004862:	0204a903          	lw	s2,32(s1)
        if  (log.committing)
    80004866:	50dc                	lw	a5,36(s1)
        log.outstanding -= 1;
    80004868:	397d                	addw	s2,s2,-1
    8000486a:	0324a023          	sw	s2,32(s1)
        if  (log.committing)
    8000486e:	10079963          	bnez	a5,80004980 <end_op+0x13c>
                 * and decrementing log.outstanding has decreased
                 * the amount of reserved space.
                 */
                wakeup(&log);
        }
        release(&log.lock);
    80004872:	8526                	mv	a0,s1
        if  (log.outstanding == 0) {
    80004874:	0e091863          	bnez	s2,80004964 <end_op+0x120>
                log.committing = 1;
    80004878:	4785                	li	a5,1
    8000487a:	d0dc                	sw	a5,36(s1)
        release(&log.lock);
    8000487c:	ffffc097          	auipc	ra,0xffffc
    80004880:	4a4080e7          	jalr	1188(ra) # 80000d20 <release>
}

static void
commit(void) 
{
        if (log.lh.n > 0) {
    80004884:	54dc                	lw	a5,44(s1)
    80004886:	04f04363          	bgtz	a5,800048cc <end_op+0x88>
                acquire(&log.lock);
    8000488a:	0001c517          	auipc	a0,0x1c
    8000488e:	6f650513          	add	a0,a0,1782 # 80020f80 <log>
    80004892:	ffffc097          	auipc	ra,0xffffc
    80004896:	3ce080e7          	jalr	974(ra) # 80000c60 <acquire>
                wakeup(&log);
    8000489a:	0001c517          	auipc	a0,0x1c
    8000489e:	6e650513          	add	a0,a0,1766 # 80020f80 <log>
                log.committing = 0;
    800048a2:	0001c797          	auipc	a5,0x1c
    800048a6:	7007a123          	sw	zero,1794(a5) # 80020fa4 <log+0x24>
                wakeup(&log);
    800048aa:	ffffe097          	auipc	ra,0xffffe
    800048ae:	dc0080e7          	jalr	-576(ra) # 8000266a <wakeup>
}
    800048b2:	7442                	ld	s0,48(sp)
    800048b4:	70e2                	ld	ra,56(sp)
    800048b6:	74a2                	ld	s1,40(sp)
    800048b8:	7902                	ld	s2,32(sp)
                release(&log.lock);
    800048ba:	0001c517          	auipc	a0,0x1c
    800048be:	6c650513          	add	a0,a0,1734 # 80020f80 <log>
}
    800048c2:	6121                	add	sp,sp,64
                release(&log.lock);
    800048c4:	ffffc317          	auipc	t1,0xffffc
    800048c8:	45c30067          	jr	1116(t1) # 80000d20 <release>
    800048cc:	e456                	sd	s5,8(sp)
        for (tail = 0; tail < log.lh.n; tail++) {
    800048ce:	ec4e                	sd	s3,24(sp)
    800048d0:	e852                	sd	s4,16(sp)
    800048d2:	0001ca97          	auipc	s5,0x1c
    800048d6:	6dea8a93          	add	s5,s5,1758 # 80020fb0 <log+0x30>
                struct buf *to = bread(log.dev, log.start + tail + 1);
    800048da:	4c8c                	lw	a1,24(s1)
    800048dc:	5488                	lw	a0,40(s1)
        for (tail = 0; tail < log.lh.n; tail++) {
    800048de:	0a91                	add	s5,s5,4
                struct buf *to = bread(log.dev, log.start + tail + 1);
    800048e0:	012585bb          	addw	a1,a1,s2
    800048e4:	2585                	addw	a1,a1,1
    800048e6:	fffff097          	auipc	ra,0xfffff
    800048ea:	c26080e7          	jalr	-986(ra) # 8000350c <bread>
    800048ee:	89aa                	mv	s3,a0
                struct buf *from = bread(log.dev, log.lh.block[tail]);
    800048f0:	ffcaa583          	lw	a1,-4(s5)
    800048f4:	5488                	lw	a0,40(s1)
        for (tail = 0; tail < log.lh.n; tail++) {
    800048f6:	2905                	addw	s2,s2,1
                struct buf *from = bread(log.dev, log.lh.block[tail]);
    800048f8:	fffff097          	auipc	ra,0xfffff
    800048fc:	c14080e7          	jalr	-1004(ra) # 8000350c <bread>
                memmove(to->data, from->data, BSIZE);
    80004900:	05850593          	add	a1,a0,88
    80004904:	40000613          	li	a2,1024
                struct buf *from = bread(log.dev, log.lh.block[tail]);
    80004908:	8a2a                	mv	s4,a0
                memmove(to->data, from->data, BSIZE);
    8000490a:	05898513          	add	a0,s3,88
    8000490e:	ffffc097          	auipc	ra,0xffffc
    80004912:	51a080e7          	jalr	1306(ra) # 80000e28 <memmove>
                bwrite(to);
    80004916:	854e                	mv	a0,s3
    80004918:	fffff097          	auipc	ra,0xfffff
    8000491c:	cec080e7          	jalr	-788(ra) # 80003604 <bwrite>
                brelse(from);
    80004920:	8552                	mv	a0,s4
    80004922:	fffff097          	auipc	ra,0xfffff
    80004926:	d1e080e7          	jalr	-738(ra) # 80003640 <brelse>
                brelse(to);
    8000492a:	854e                	mv	a0,s3
    8000492c:	fffff097          	auipc	ra,0xfffff
    80004930:	d14080e7          	jalr	-748(ra) # 80003640 <brelse>
        for (tail = 0; tail < log.lh.n; tail++) {
    80004934:	54dc                	lw	a5,44(s1)
    80004936:	faf942e3          	blt	s2,a5,800048da <end_op+0x96>
                write_log();
                /* Write modified blocks from cache to log */
                write_head();
    8000493a:	00000097          	auipc	ra,0x0
    8000493e:	cde080e7          	jalr	-802(ra) # 80004618 <write_head>
                /* Write header to disk-- the real commit */
                install_trans(0);
    80004942:	4501                	li	a0,0
    80004944:	00000097          	auipc	ra,0x0
    80004948:	d32080e7          	jalr	-718(ra) # 80004676 <install_trans>
                /* Now install writes to home locations */
                log.lh.n = 0;
    8000494c:	0001c797          	auipc	a5,0x1c
    80004950:	6607a023          	sw	zero,1632(a5) # 80020fac <log+0x2c>
                write_head();
    80004954:	00000097          	auipc	ra,0x0
    80004958:	cc4080e7          	jalr	-828(ra) # 80004618 <write_head>
    8000495c:	69e2                	ld	s3,24(sp)
    8000495e:	6a42                	ld	s4,16(sp)
    80004960:	6aa2                	ld	s5,8(sp)
    80004962:	b725                	j	8000488a <end_op+0x46>
                wakeup(&log);
    80004964:	ffffe097          	auipc	ra,0xffffe
    80004968:	d06080e7          	jalr	-762(ra) # 8000266a <wakeup>
}
    8000496c:	7442                	ld	s0,48(sp)
    8000496e:	70e2                	ld	ra,56(sp)
    80004970:	7902                	ld	s2,32(sp)
        release(&log.lock);
    80004972:	8526                	mv	a0,s1
}
    80004974:	74a2                	ld	s1,40(sp)
    80004976:	6121                	add	sp,sp,64
                release(&log.lock);
    80004978:	ffffc317          	auipc	t1,0xffffc
    8000497c:	3a830067          	jr	936(t1) # 80000d20 <release>
                panic("log.committing");
    80004980:	00004517          	auipc	a0,0x4
    80004984:	fe850513          	add	a0,a0,-24 # 80008968 <etext+0x968>
    80004988:	ec4e                	sd	s3,24(sp)
    8000498a:	e852                	sd	s4,16(sp)
    8000498c:	e456                	sd	s5,8(sp)
    8000498e:	ffffc097          	auipc	ra,0xffffc
    80004992:	c08080e7          	jalr	-1016(ra) # 80000596 <panic>

0000000080004996 <log_write>:
 *      log_write(bp)
 *      brelse(bp)
 */
void
log_write(struct buf *b)
{
    80004996:	1101                	add	sp,sp,-32
    80004998:	e822                	sd	s0,16(sp)
    8000499a:	e426                	sd	s1,8(sp)
    8000499c:	e04a                	sd	s2,0(sp)
    8000499e:	ec06                	sd	ra,24(sp)
    800049a0:	1000                	add	s0,sp,32
        int i = undefined;

        acquire(&log.lock);
    800049a2:	0001c497          	auipc	s1,0x1c
    800049a6:	5de48493          	add	s1,s1,1502 # 80020f80 <log>
{
    800049aa:	892a                	mv	s2,a0
        acquire(&log.lock);
    800049ac:	8526                	mv	a0,s1
    800049ae:	ffffc097          	auipc	ra,0xffffc
    800049b2:	2b2080e7          	jalr	690(ra) # 80000c60 <acquire>
        if  (log.lh.n >= LOGSIZE || log.lh.n >= log.size - 1)
    800049b6:	54d0                	lw	a2,44(s1)
    800049b8:	47f5                	li	a5,29
    800049ba:	08c7eb63          	bltu	a5,a2,80004a50 <log_write+0xba>
    800049be:	4cdc                	lw	a5,28(s1)
    800049c0:	37fd                	addw	a5,a5,-1
    800049c2:	08f65763          	bge	a2,a5,80004a50 <log_write+0xba>
                panic("too big a transaction");
        if  (log.outstanding < 1)
    800049c6:	509c                	lw	a5,32(s1)
    800049c8:	08f05c63          	blez	a5,80004a60 <log_write+0xca>
        for (i = 0; i < log.lh.n; i++) {
                if (log.lh.block[i] == b->blockno)
                        /* log absorption */
                        break;
        }
        log.lh.block[i] = b->blockno;
    800049cc:	00c92583          	lw	a1,12(s2)
    800049d0:	0001c717          	auipc	a4,0x1c
    800049d4:	5e070713          	add	a4,a4,1504 # 80020fb0 <log+0x30>
        for (i = 0; i < log.lh.n; i++) {
    800049d8:	4781                	li	a5,0
        log.lh.block[i] = b->blockno;
    800049da:	0005851b          	sext.w	a0,a1
        for (i = 0; i < log.lh.n; i++) {
    800049de:	e611                	bnez	a2,800049ea <log_write+0x54>
    800049e0:	a0b5                	j	80004a4c <log_write+0xb6>
    800049e2:	2785                	addw	a5,a5,1
    800049e4:	0711                	add	a4,a4,4
    800049e6:	02f60963          	beq	a2,a5,80004a18 <log_write+0x82>
                if (log.lh.block[i] == b->blockno)
    800049ea:	4314                	lw	a3,0(a4)
    800049ec:	feb69be3          	bne	a3,a1,800049e2 <log_write+0x4c>
        log.lh.block[i] = b->blockno;
    800049f0:	00878713          	add	a4,a5,8
    800049f4:	070a                	sll	a4,a4,0x2
    800049f6:	9726                	add	a4,a4,s1
    800049f8:	cb08                	sw	a0,16(a4)
        if  (i == log.lh.n) {
    800049fa:	02f60463          	beq	a2,a5,80004a22 <log_write+0x8c>
                /* Add new block to log ? */
                bpin(b);
                log.lh.n++;
        }
        release(&log.lock);
}
    800049fe:	6442                	ld	s0,16(sp)
    80004a00:	60e2                	ld	ra,24(sp)
    80004a02:	64a2                	ld	s1,8(sp)
    80004a04:	6902                	ld	s2,0(sp)
        release(&log.lock);
    80004a06:	0001c517          	auipc	a0,0x1c
    80004a0a:	57a50513          	add	a0,a0,1402 # 80020f80 <log>
}
    80004a0e:	6105                	add	sp,sp,32
        release(&log.lock);
    80004a10:	ffffc317          	auipc	t1,0xffffc
    80004a14:	31030067          	jr	784(t1) # 80000d20 <release>
        log.lh.block[i] = b->blockno;
    80004a18:	00860793          	add	a5,a2,8
    80004a1c:	078a                	sll	a5,a5,0x2
    80004a1e:	97a6                	add	a5,a5,s1
    80004a20:	cb88                	sw	a0,16(a5)
                bpin(b);
    80004a22:	854a                	mv	a0,s2
    80004a24:	fffff097          	auipc	ra,0xfffff
    80004a28:	cae080e7          	jalr	-850(ra) # 800036d2 <bpin>
                log.lh.n++;
    80004a2c:	54dc                	lw	a5,44(s1)
}
    80004a2e:	6442                	ld	s0,16(sp)
    80004a30:	60e2                	ld	ra,24(sp)
                log.lh.n++;
    80004a32:	2785                	addw	a5,a5,1
}
    80004a34:	6902                	ld	s2,0(sp)
                log.lh.n++;
    80004a36:	d4dc                	sw	a5,44(s1)
}
    80004a38:	64a2                	ld	s1,8(sp)
        release(&log.lock);
    80004a3a:	0001c517          	auipc	a0,0x1c
    80004a3e:	54650513          	add	a0,a0,1350 # 80020f80 <log>
}
    80004a42:	6105                	add	sp,sp,32
        release(&log.lock);
    80004a44:	ffffc317          	auipc	t1,0xffffc
    80004a48:	2dc30067          	jr	732(t1) # 80000d20 <release>
        log.lh.block[i] = b->blockno;
    80004a4c:	d888                	sw	a0,48(s1)
        if  (i == log.lh.n) {
    80004a4e:	bfd1                	j	80004a22 <log_write+0x8c>
                panic("too big a transaction");
    80004a50:	00004517          	auipc	a0,0x4
    80004a54:	f2850513          	add	a0,a0,-216 # 80008978 <etext+0x978>
    80004a58:	ffffc097          	auipc	ra,0xffffc
    80004a5c:	b3e080e7          	jalr	-1218(ra) # 80000596 <panic>
                panic("log_write outside of trans");
    80004a60:	00004517          	auipc	a0,0x4
    80004a64:	f3050513          	add	a0,a0,-208 # 80008990 <etext+0x990>
    80004a68:	ffffc097          	auipc	ra,0xffffc
    80004a6c:	b2e080e7          	jalr	-1234(ra) # 80000596 <panic>

0000000080004a70 <initsleeplock>:
#include "proc.h"
#include "sleeplock.h"

void
initsleeplock(struct sleeplock *lk, char *name)
{
    80004a70:	1101                	add	sp,sp,-32
    80004a72:	e822                	sd	s0,16(sp)
    80004a74:	e426                	sd	s1,8(sp)
    80004a76:	e04a                	sd	s2,0(sp)
    80004a78:	ec06                	sd	ra,24(sp)
    80004a7a:	1000                	add	s0,sp,32
    80004a7c:	84aa                	mv	s1,a0
    80004a7e:	892e                	mv	s2,a1
	initlock(&lk->lk, "sleep lock");
    80004a80:	0521                	add	a0,a0,8
    80004a82:	00004597          	auipc	a1,0x4
    80004a86:	f2e58593          	add	a1,a1,-210 # 800089b0 <etext+0x9b0>
    80004a8a:	ffffc097          	auipc	ra,0xffffc
    80004a8e:	146080e7          	jalr	326(ra) # 80000bd0 <initlock>
	lk->name = name;
	lk->locked = 0;
	lk->pid = 0;
}
    80004a92:	60e2                	ld	ra,24(sp)
    80004a94:	6442                	ld	s0,16(sp)
	lk->name = name;
    80004a96:	0324b023          	sd	s2,32(s1)
	lk->locked = 0;
    80004a9a:	0004a023          	sw	zero,0(s1)
	lk->pid = 0;
    80004a9e:	0204a423          	sw	zero,40(s1)
}
    80004aa2:	6902                	ld	s2,0(sp)
    80004aa4:	64a2                	ld	s1,8(sp)
    80004aa6:	6105                	add	sp,sp,32
    80004aa8:	8082                	ret

0000000080004aaa <acquiresleep>:

void
acquiresleep(struct sleeplock *lk)
{
    80004aaa:	1101                	add	sp,sp,-32
    80004aac:	e822                	sd	s0,16(sp)
    80004aae:	e426                	sd	s1,8(sp)
    80004ab0:	e04a                	sd	s2,0(sp)
    80004ab2:	ec06                	sd	ra,24(sp)
    80004ab4:	1000                	add	s0,sp,32
	acquire(&lk->lk);
    80004ab6:	00850913          	add	s2,a0,8
{
    80004aba:	84aa                	mv	s1,a0
	acquire(&lk->lk);
    80004abc:	854a                	mv	a0,s2
    80004abe:	ffffc097          	auipc	ra,0xffffc
    80004ac2:	1a2080e7          	jalr	418(ra) # 80000c60 <acquire>
	while (lk->locked) {
    80004ac6:	409c                	lw	a5,0(s1)
    80004ac8:	cb89                	beqz	a5,80004ada <acquiresleep+0x30>
		sleep(lk, &lk->lk);
    80004aca:	85ca                	mv	a1,s2
    80004acc:	8526                	mv	a0,s1
    80004ace:	ffffe097          	auipc	ra,0xffffe
    80004ad2:	b20080e7          	jalr	-1248(ra) # 800025ee <sleep>
	while (lk->locked) {
    80004ad6:	409c                	lw	a5,0(s1)
    80004ad8:	fbed                	bnez	a5,80004aca <acquiresleep+0x20>
	}
	lk->locked = 1;
    80004ada:	4785                	li	a5,1
    80004adc:	c09c                	sw	a5,0(s1)
	lk->pid = myproc()->pid;
    80004ade:	ffffd097          	auipc	ra,0xffffd
    80004ae2:	312080e7          	jalr	786(ra) # 80001df0 <myproc>
    80004ae6:	591c                	lw	a5,48(a0)
	release(&lk->lk);
}
    80004ae8:	6442                	ld	s0,16(sp)
    80004aea:	60e2                	ld	ra,24(sp)
	lk->pid = myproc()->pid;
    80004aec:	d49c                	sw	a5,40(s1)
	release(&lk->lk);
    80004aee:	854a                	mv	a0,s2
}
    80004af0:	64a2                	ld	s1,8(sp)
    80004af2:	6902                	ld	s2,0(sp)
    80004af4:	6105                	add	sp,sp,32
	release(&lk->lk);
    80004af6:	ffffc317          	auipc	t1,0xffffc
    80004afa:	22a30067          	jr	554(t1) # 80000d20 <release>

0000000080004afe <releasesleep>:

void
releasesleep(struct sleeplock *lk)
{
    80004afe:	1101                	add	sp,sp,-32
    80004b00:	ec06                	sd	ra,24(sp)
    80004b02:	e822                	sd	s0,16(sp)
    80004b04:	e426                	sd	s1,8(sp)
    80004b06:	e04a                	sd	s2,0(sp)
    80004b08:	1000                	add	s0,sp,32
	acquire(&lk->lk);
    80004b0a:	00850913          	add	s2,a0,8
{
    80004b0e:	84aa                	mv	s1,a0
	acquire(&lk->lk);
    80004b10:	854a                	mv	a0,s2
    80004b12:	ffffc097          	auipc	ra,0xffffc
    80004b16:	14e080e7          	jalr	334(ra) # 80000c60 <acquire>
	lk->locked = 0;
	lk->pid = 0;
	wakeup(lk);
    80004b1a:	8526                	mv	a0,s1
	lk->locked = 0;
    80004b1c:	0004a023          	sw	zero,0(s1)
	lk->pid = 0;
    80004b20:	0204a423          	sw	zero,40(s1)
	wakeup(lk);
    80004b24:	ffffe097          	auipc	ra,0xffffe
    80004b28:	b46080e7          	jalr	-1210(ra) # 8000266a <wakeup>
	release(&lk->lk);
}
    80004b2c:	6442                	ld	s0,16(sp)
    80004b2e:	60e2                	ld	ra,24(sp)
    80004b30:	64a2                	ld	s1,8(sp)
	release(&lk->lk);
    80004b32:	854a                	mv	a0,s2
}
    80004b34:	6902                	ld	s2,0(sp)
    80004b36:	6105                	add	sp,sp,32
	release(&lk->lk);
    80004b38:	ffffc317          	auipc	t1,0xffffc
    80004b3c:	1e830067          	jr	488(t1) # 80000d20 <release>

0000000080004b40 <holdingsleep>:

int
holdingsleep(struct sleeplock *lk)
{
    80004b40:	7179                	add	sp,sp,-48
    80004b42:	f022                	sd	s0,32(sp)
    80004b44:	ec26                	sd	s1,24(sp)
    80004b46:	e84a                	sd	s2,16(sp)
    80004b48:	f406                	sd	ra,40(sp)
    80004b4a:	1800                	add	s0,sp,48
	int r = undefined;

	acquire(&lk->lk);
    80004b4c:	00850913          	add	s2,a0,8
{
    80004b50:	84aa                	mv	s1,a0
	acquire(&lk->lk);
    80004b52:	854a                	mv	a0,s2
    80004b54:	ffffc097          	auipc	ra,0xffffc
    80004b58:	10c080e7          	jalr	268(ra) # 80000c60 <acquire>
	r = lk->locked && (lk->pid == myproc()->pid);
    80004b5c:	409c                	lw	a5,0(s1)
    80004b5e:	ef91                	bnez	a5,80004b7a <holdingsleep+0x3a>
    80004b60:	4481                	li	s1,0
	release(&lk->lk);
    80004b62:	854a                	mv	a0,s2
    80004b64:	ffffc097          	auipc	ra,0xffffc
    80004b68:	1bc080e7          	jalr	444(ra) # 80000d20 <release>
	return r;
}
    80004b6c:	70a2                	ld	ra,40(sp)
    80004b6e:	7402                	ld	s0,32(sp)
    80004b70:	6942                	ld	s2,16(sp)
    80004b72:	8526                	mv	a0,s1
    80004b74:	64e2                	ld	s1,24(sp)
    80004b76:	6145                	add	sp,sp,48
    80004b78:	8082                	ret
    80004b7a:	e44e                	sd	s3,8(sp)
	r = lk->locked && (lk->pid == myproc()->pid);
    80004b7c:	0284a983          	lw	s3,40(s1)
    80004b80:	ffffd097          	auipc	ra,0xffffd
    80004b84:	270080e7          	jalr	624(ra) # 80001df0 <myproc>
    80004b88:	5904                	lw	s1,48(a0)
    80004b8a:	413484b3          	sub	s1,s1,s3
    80004b8e:	0014b493          	seqz	s1,s1
    80004b92:	69a2                	ld	s3,8(sp)
    80004b94:	b7f9                	j	80004b62 <holdingsleep+0x22>

0000000080004b96 <fileinit>:
	struct file file[NFILE];
}      ftable;

void
fileinit(void)
{
    80004b96:	1141                	add	sp,sp,-16
    80004b98:	e422                	sd	s0,8(sp)
    80004b9a:	0800                	add	s0,sp,16
	initlock(&ftable.lock, "ftable");
}
    80004b9c:	6422                	ld	s0,8(sp)
	initlock(&ftable.lock, "ftable");
    80004b9e:	00004597          	auipc	a1,0x4
    80004ba2:	e2258593          	add	a1,a1,-478 # 800089c0 <etext+0x9c0>
    80004ba6:	0001c517          	auipc	a0,0x1c
    80004baa:	52250513          	add	a0,a0,1314 # 800210c8 <ftable>
}
    80004bae:	0141                	add	sp,sp,16
	initlock(&ftable.lock, "ftable");
    80004bb0:	ffffc317          	auipc	t1,0xffffc
    80004bb4:	02030067          	jr	32(t1) # 80000bd0 <initlock>

0000000080004bb8 <filealloc>:
/* 
 * Allocate a file structure. 
 */
struct file *
filealloc(void)
{
    80004bb8:	1101                	add	sp,sp,-32
    80004bba:	e822                	sd	s0,16(sp)
    80004bbc:	e426                	sd	s1,8(sp)
    80004bbe:	ec06                	sd	ra,24(sp)
    80004bc0:	1000                	add	s0,sp,32
	struct file *f = nullptr;

	acquire(&ftable.lock);
    80004bc2:	0001c517          	auipc	a0,0x1c
    80004bc6:	50650513          	add	a0,a0,1286 # 800210c8 <ftable>
    80004bca:	ffffc097          	auipc	ra,0xffffc
    80004bce:	096080e7          	jalr	150(ra) # 80000c60 <acquire>
	for (f = ftable.file; f < ftable.file + NFILE; f++) {
    80004bd2:	0001c497          	auipc	s1,0x1c
    80004bd6:	50e48493          	add	s1,s1,1294 # 800210e0 <ftable+0x18>
    80004bda:	0001d717          	auipc	a4,0x1d
    80004bde:	4a670713          	add	a4,a4,1190 # 80022080 <disk>
    80004be2:	a029                	j	80004bec <filealloc+0x34>
    80004be4:	02848493          	add	s1,s1,40
    80004be8:	02e48463          	beq	s1,a4,80004c10 <filealloc+0x58>
		if (f->ref == 0) {
    80004bec:	40dc                	lw	a5,4(s1)
    80004bee:	fbfd                	bnez	a5,80004be4 <filealloc+0x2c>
			f->ref = 1;
    80004bf0:	4785                	li	a5,1
    80004bf2:	c0dc                	sw	a5,4(s1)
			release(&ftable.lock);
    80004bf4:	0001c517          	auipc	a0,0x1c
    80004bf8:	4d450513          	add	a0,a0,1236 # 800210c8 <ftable>
    80004bfc:	ffffc097          	auipc	ra,0xffffc
    80004c00:	124080e7          	jalr	292(ra) # 80000d20 <release>
			return f;
		}
	}
	release(&ftable.lock);
	return 0;
}
    80004c04:	60e2                	ld	ra,24(sp)
    80004c06:	6442                	ld	s0,16(sp)
    80004c08:	8526                	mv	a0,s1
    80004c0a:	64a2                	ld	s1,8(sp)
    80004c0c:	6105                	add	sp,sp,32
    80004c0e:	8082                	ret
	release(&ftable.lock);
    80004c10:	0001c517          	auipc	a0,0x1c
    80004c14:	4b850513          	add	a0,a0,1208 # 800210c8 <ftable>
    80004c18:	ffffc097          	auipc	ra,0xffffc
    80004c1c:	108080e7          	jalr	264(ra) # 80000d20 <release>
}
    80004c20:	60e2                	ld	ra,24(sp)
    80004c22:	6442                	ld	s0,16(sp)
	return 0;
    80004c24:	4481                	li	s1,0
}
    80004c26:	8526                	mv	a0,s1
    80004c28:	64a2                	ld	s1,8(sp)
    80004c2a:	6105                	add	sp,sp,32
    80004c2c:	8082                	ret

0000000080004c2e <filedup>:
/*
 * Increment ref count for filef. 
 */
struct file *
filedup(struct file *f)
{
    80004c2e:	1101                	add	sp,sp,-32
    80004c30:	e822                	sd	s0,16(sp)
    80004c32:	e426                	sd	s1,8(sp)
    80004c34:	ec06                	sd	ra,24(sp)
    80004c36:	1000                	add	s0,sp,32
    80004c38:	84aa                	mv	s1,a0
	acquire(&ftable.lock);
    80004c3a:	0001c517          	auipc	a0,0x1c
    80004c3e:	48e50513          	add	a0,a0,1166 # 800210c8 <ftable>
    80004c42:	ffffc097          	auipc	ra,0xffffc
    80004c46:	01e080e7          	jalr	30(ra) # 80000c60 <acquire>
	if (f->ref < 1)
    80004c4a:	40dc                	lw	a5,4(s1)
    80004c4c:	02f05263          	blez	a5,80004c70 <filedup+0x42>
		panic("filedup");
	f->ref++;
    80004c50:	2785                	addw	a5,a5,1
    80004c52:	c0dc                	sw	a5,4(s1)
	release(&ftable.lock);
    80004c54:	0001c517          	auipc	a0,0x1c
    80004c58:	47450513          	add	a0,a0,1140 # 800210c8 <ftable>
    80004c5c:	ffffc097          	auipc	ra,0xffffc
    80004c60:	0c4080e7          	jalr	196(ra) # 80000d20 <release>
	return f;
}
    80004c64:	60e2                	ld	ra,24(sp)
    80004c66:	6442                	ld	s0,16(sp)
    80004c68:	8526                	mv	a0,s1
    80004c6a:	64a2                	ld	s1,8(sp)
    80004c6c:	6105                	add	sp,sp,32
    80004c6e:	8082                	ret
		panic("filedup");
    80004c70:	00004517          	auipc	a0,0x4
    80004c74:	d5850513          	add	a0,a0,-680 # 800089c8 <etext+0x9c8>
    80004c78:	ffffc097          	auipc	ra,0xffffc
    80004c7c:	91e080e7          	jalr	-1762(ra) # 80000596 <panic>

0000000080004c80 <fileclose>:
/* 
 * Close file f.(Decrement ref count, close when reaches 0.) 
 */
void
fileclose(struct file *f)
{
    80004c80:	7179                	add	sp,sp,-48
    80004c82:	f022                	sd	s0,32(sp)
    80004c84:	ec26                	sd	s1,24(sp)
    80004c86:	f406                	sd	ra,40(sp)
    80004c88:	1800                	add	s0,sp,48
    80004c8a:	84aa                	mv	s1,a0
	struct file ff = {};

	acquire(&ftable.lock);
    80004c8c:	0001c517          	auipc	a0,0x1c
    80004c90:	43c50513          	add	a0,a0,1084 # 800210c8 <ftable>
    80004c94:	ffffc097          	auipc	ra,0xffffc
    80004c98:	fcc080e7          	jalr	-52(ra) # 80000c60 <acquire>
	if (f->ref < 1)
    80004c9c:	40dc                	lw	a5,4(s1)
    80004c9e:	0af05563          	blez	a5,80004d48 <fileclose+0xc8>
		panic("fileclose");
	if (--f->ref > 0) {
    80004ca2:	fff7871b          	addw	a4,a5,-1
    80004ca6:	c0d8                	sw	a4,4(s1)
    80004ca8:	e339                	bnez	a4,80004cee <fileclose+0x6e>
    80004caa:	e84a                	sd	s2,16(sp)
    80004cac:	e44e                	sd	s3,8(sp)
    80004cae:	e052                	sd	s4,0(sp)
		release(&ftable.lock);
		return;
	}
	ff = *f;
    80004cb0:	0004a903          	lw	s2,0(s1)
	f->ref = 0;
	f->type = FD_NONE;
	release(&ftable.lock);
    80004cb4:	0001c517          	auipc	a0,0x1c
    80004cb8:	41450513          	add	a0,a0,1044 # 800210c8 <ftable>
	f->type = FD_NONE;
    80004cbc:	0004a023          	sw	zero,0(s1)
	ff = *f;
    80004cc0:	0094ca03          	lbu	s4,9(s1)
    80004cc4:	0104b983          	ld	s3,16(s1)
    80004cc8:	6c84                	ld	s1,24(s1)
	release(&ftable.lock);
    80004cca:	ffffc097          	auipc	ra,0xffffc
    80004cce:	056080e7          	jalr	86(ra) # 80000d20 <release>

	if (ff.type == FD_PIPE) {
    80004cd2:	4785                	li	a5,1
    80004cd4:	04f90d63          	beq	s2,a5,80004d2e <fileclose+0xae>
		pipeclose(ff.pipe, ff.writable);
	} else if (ff.type == FD_INODE || ff.type == FD_DEVICE) {
    80004cd8:	3979                	addw	s2,s2,-2
    80004cda:	0327f663          	bgeu	a5,s2,80004d06 <fileclose+0x86>
		begin_op();
		iput(ff.ip);
		end_op();
	}
}
    80004cde:	70a2                	ld	ra,40(sp)
    80004ce0:	7402                	ld	s0,32(sp)
    80004ce2:	6942                	ld	s2,16(sp)
    80004ce4:	69a2                	ld	s3,8(sp)
    80004ce6:	6a02                	ld	s4,0(sp)
    80004ce8:	64e2                	ld	s1,24(sp)
    80004cea:	6145                	add	sp,sp,48
    80004cec:	8082                	ret
    80004cee:	7402                	ld	s0,32(sp)
    80004cf0:	70a2                	ld	ra,40(sp)
    80004cf2:	64e2                	ld	s1,24(sp)
		release(&ftable.lock);
    80004cf4:	0001c517          	auipc	a0,0x1c
    80004cf8:	3d450513          	add	a0,a0,980 # 800210c8 <ftable>
}
    80004cfc:	6145                	add	sp,sp,48
		release(&ftable.lock);
    80004cfe:	ffffc317          	auipc	t1,0xffffc
    80004d02:	02230067          	jr	34(t1) # 80000d20 <release>
		begin_op();
    80004d06:	00000097          	auipc	ra,0x0
    80004d0a:	ace080e7          	jalr	-1330(ra) # 800047d4 <begin_op>
		iput(ff.ip);
    80004d0e:	8526                	mv	a0,s1
    80004d10:	fffff097          	auipc	ra,0xfffff
    80004d14:	1fe080e7          	jalr	510(ra) # 80003f0e <iput>
}
    80004d18:	7402                	ld	s0,32(sp)
		end_op();
    80004d1a:	6942                	ld	s2,16(sp)
    80004d1c:	69a2                	ld	s3,8(sp)
    80004d1e:	6a02                	ld	s4,0(sp)
}
    80004d20:	70a2                	ld	ra,40(sp)
    80004d22:	64e2                	ld	s1,24(sp)
    80004d24:	6145                	add	sp,sp,48
		end_op();
    80004d26:	00000317          	auipc	t1,0x0
    80004d2a:	b1e30067          	jr	-1250(t1) # 80004844 <end_op>
}
    80004d2e:	7402                	ld	s0,32(sp)
		pipeclose(ff.pipe, ff.writable);
    80004d30:	6942                	ld	s2,16(sp)
}
    80004d32:	70a2                	ld	ra,40(sp)
    80004d34:	64e2                	ld	s1,24(sp)
		pipeclose(ff.pipe, ff.writable);
    80004d36:	85d2                	mv	a1,s4
    80004d38:	854e                	mv	a0,s3
    80004d3a:	6a02                	ld	s4,0(sp)
    80004d3c:	69a2                	ld	s3,8(sp)
}
    80004d3e:	6145                	add	sp,sp,48
		pipeclose(ff.pipe, ff.writable);
    80004d40:	00000317          	auipc	t1,0x0
    80004d44:	36e30067          	jr	878(t1) # 800050ae <pipeclose>
		panic("fileclose");
    80004d48:	00004517          	auipc	a0,0x4
    80004d4c:	c8850513          	add	a0,a0,-888 # 800089d0 <etext+0x9d0>
    80004d50:	e84a                	sd	s2,16(sp)
    80004d52:	e44e                	sd	s3,8(sp)
    80004d54:	e052                	sd	s4,0(sp)
    80004d56:	ffffc097          	auipc	ra,0xffffc
    80004d5a:	840080e7          	jalr	-1984(ra) # 80000596 <panic>

0000000080004d5e <filestat>:
 * Get metadata about file f.
 * addr is a user virtual address, pointing to a struct stat.
 */
int
filestat(struct file *f, uint64 addr)
{
    80004d5e:	715d                	add	sp,sp,-80
    80004d60:	e0a2                	sd	s0,64(sp)
    80004d62:	fc26                	sd	s1,56(sp)
    80004d64:	0880                	add	s0,sp,80
    80004d66:	f84a                	sd	s2,48(sp)
    80004d68:	e486                	sd	ra,72(sp)
    80004d6a:	84aa                	mv	s1,a0
    80004d6c:	892e                	mv	s2,a1
	struct proc *p = myproc();
    80004d6e:	ffffd097          	auipc	ra,0xffffd
    80004d72:	082080e7          	jalr	130(ra) # 80001df0 <myproc>
	struct stat st = {};

	if (f->type == FD_INODE || f->type == FD_DEVICE) {
    80004d76:	409c                	lw	a5,0(s1)
	struct stat st = {};
    80004d78:	fa043c23          	sd	zero,-72(s0)
    80004d7c:	fc043023          	sd	zero,-64(s0)
    80004d80:	fc043423          	sd	zero,-56(s0)
	if (f->type == FD_INODE || f->type == FD_DEVICE) {
    80004d84:	37f9                	addw	a5,a5,-2
    80004d86:	4705                	li	a4,1
    80004d88:	04f76863          	bltu	a4,a5,80004dd8 <filestat+0x7a>
		ilock(f->ip);
    80004d8c:	f44e                	sd	s3,40(sp)
    80004d8e:	89aa                	mv	s3,a0
    80004d90:	6c88                	ld	a0,24(s1)
    80004d92:	fffff097          	auipc	ra,0xfffff
    80004d96:	fb2080e7          	jalr	-78(ra) # 80003d44 <ilock>
		stati(f->ip, &st);
    80004d9a:	6c88                	ld	a0,24(s1)
    80004d9c:	fb840593          	add	a1,s0,-72
    80004da0:	fffff097          	auipc	ra,0xfffff
    80004da4:	268080e7          	jalr	616(ra) # 80004008 <stati>
		iunlock(f->ip);
    80004da8:	6c88                	ld	a0,24(s1)
    80004daa:	fffff097          	auipc	ra,0xfffff
    80004dae:	068080e7          	jalr	104(ra) # 80003e12 <iunlock>
		if (copyout(p->pagetable, addr, (char *)&st, sizeof(st)) < 0)
    80004db2:	0509b503          	ld	a0,80(s3)
    80004db6:	46e1                	li	a3,24
    80004db8:	fb840613          	add	a2,s0,-72
    80004dbc:	85ca                	mv	a1,s2
    80004dbe:	ffffd097          	auipc	ra,0xffffd
    80004dc2:	b18080e7          	jalr	-1256(ra) # 800018d6 <copyout>
    80004dc6:	79a2                	ld	s3,40(sp)
    80004dc8:	41f5551b          	sraw	a0,a0,0x1f
			return -1;
		return 0;
	}
	return -1;
}
    80004dcc:	60a6                	ld	ra,72(sp)
    80004dce:	6406                	ld	s0,64(sp)
    80004dd0:	74e2                	ld	s1,56(sp)
    80004dd2:	7942                	ld	s2,48(sp)
    80004dd4:	6161                	add	sp,sp,80
    80004dd6:	8082                	ret
			return -1;
    80004dd8:	557d                	li	a0,-1
    80004dda:	bfcd                	j	80004dcc <filestat+0x6e>

0000000080004ddc <fileread>:
 * Read from file f.
 * addr is a user virtual address.
 */
int
fileread(struct file *f, uint64 addr, int n)
{
    80004ddc:	7179                	add	sp,sp,-48
    80004dde:	f022                	sd	s0,32(sp)
    80004de0:	f406                	sd	ra,40(sp)
    80004de2:	e84a                	sd	s2,16(sp)
    80004de4:	1800                	add	s0,sp,48
	int r = 0;

	if (f->readable == 0)
    80004de6:	00854783          	lbu	a5,8(a0)
    80004dea:	c3d5                	beqz	a5,80004e8e <fileread+0xb2>
		return -1;

	if (f->type == FD_PIPE) {
    80004dec:	411c                	lw	a5,0(a0)
    80004dee:	ec26                	sd	s1,24(sp)
    80004df0:	4705                	li	a4,1
    80004df2:	84aa                	mv	s1,a0
    80004df4:	08e78363          	beq	a5,a4,80004e7a <fileread+0x9e>
		r = piperead(f->pipe, addr, n);
	} else if (f->type == FD_DEVICE) {
    80004df8:	470d                	li	a4,3
    80004dfa:	04e78963          	beq	a5,a4,80004e4c <fileread+0x70>
    80004dfe:	e44e                	sd	s3,8(sp)
		if (f->major < 0 || f->major >= NDEV || !devsw[f->major].read)
			return -1;
		r = devsw[f->major].read(1, addr, n);
	} else if (f->type == FD_INODE) {
    80004e00:	4709                	li	a4,2
    80004e02:	08e79b63          	bne	a5,a4,80004e98 <fileread+0xbc>
		ilock(f->ip);
    80004e06:	6d08                	ld	a0,24(a0)
    80004e08:	892e                	mv	s2,a1
    80004e0a:	89b2                	mv	s3,a2
    80004e0c:	fffff097          	auipc	ra,0xfffff
    80004e10:	f38080e7          	jalr	-200(ra) # 80003d44 <ilock>
		if ((r = readi(f->ip, 1, addr, f->off, n)) > 0)
    80004e14:	5094                	lw	a3,32(s1)
    80004e16:	6c88                	ld	a0,24(s1)
    80004e18:	864a                	mv	a2,s2
    80004e1a:	874e                	mv	a4,s3
    80004e1c:	4585                	li	a1,1
    80004e1e:	fffff097          	auipc	ra,0xfffff
    80004e22:	218080e7          	jalr	536(ra) # 80004036 <readi>
    80004e26:	892a                	mv	s2,a0
    80004e28:	00a05563          	blez	a0,80004e32 <fileread+0x56>
			f->off += r;
    80004e2c:	509c                	lw	a5,32(s1)
    80004e2e:	9fa9                	addw	a5,a5,a0
    80004e30:	d09c                	sw	a5,32(s1)
		iunlock(f->ip);
    80004e32:	6c88                	ld	a0,24(s1)
    80004e34:	fffff097          	auipc	ra,0xfffff
    80004e38:	fde080e7          	jalr	-34(ra) # 80003e12 <iunlock>
    80004e3c:	64e2                	ld	s1,24(sp)
    80004e3e:	69a2                	ld	s3,8(sp)
	} else {
		panic("fileread");
	}

	return r;
}
    80004e40:	70a2                	ld	ra,40(sp)
    80004e42:	7402                	ld	s0,32(sp)
    80004e44:	854a                	mv	a0,s2
    80004e46:	6942                	ld	s2,16(sp)
    80004e48:	6145                	add	sp,sp,48
    80004e4a:	8082                	ret
		if (f->major < 0 || f->major >= NDEV || !devsw[f->major].read)
    80004e4c:	02451783          	lh	a5,36(a0)
    80004e50:	4725                	li	a4,9
    80004e52:	03079693          	sll	a3,a5,0x30
    80004e56:	92c1                	srl	a3,a3,0x30
    80004e58:	02d76d63          	bltu	a4,a3,80004e92 <fileread+0xb6>
    80004e5c:	0792                	sll	a5,a5,0x4
    80004e5e:	0001c717          	auipc	a4,0x1c
    80004e62:	1ca70713          	add	a4,a4,458 # 80021028 <devsw>
    80004e66:	97ba                	add	a5,a5,a4
    80004e68:	639c                	ld	a5,0(a5)
    80004e6a:	c785                	beqz	a5,80004e92 <fileread+0xb6>
}
    80004e6c:	7402                	ld	s0,32(sp)
		r = devsw[f->major].read(1, addr, n);
    80004e6e:	64e2                	ld	s1,24(sp)
}
    80004e70:	70a2                	ld	ra,40(sp)
    80004e72:	6942                	ld	s2,16(sp)
		r = devsw[f->major].read(1, addr, n);
    80004e74:	4505                	li	a0,1
}
    80004e76:	6145                	add	sp,sp,48
		r = devsw[f->major].read(1, addr, n);
    80004e78:	8782                	jr	a5
}
    80004e7a:	7402                	ld	s0,32(sp)
		r = piperead(f->pipe, addr, n);
    80004e7c:	64e2                	ld	s1,24(sp)
}
    80004e7e:	70a2                	ld	ra,40(sp)
    80004e80:	6942                	ld	s2,16(sp)
		r = piperead(f->pipe, addr, n);
    80004e82:	6908                	ld	a0,16(a0)
}
    80004e84:	6145                	add	sp,sp,48
		r = piperead(f->pipe, addr, n);
    80004e86:	00000317          	auipc	t1,0x0
    80004e8a:	3a430067          	jr	932(t1) # 8000522a <piperead>
		return -1;
    80004e8e:	597d                	li	s2,-1
    80004e90:	bf45                	j	80004e40 <fileread+0x64>
    80004e92:	64e2                	ld	s1,24(sp)
    80004e94:	597d                	li	s2,-1
    80004e96:	b76d                	j	80004e40 <fileread+0x64>
		panic("fileread");
    80004e98:	00004517          	auipc	a0,0x4
    80004e9c:	b4850513          	add	a0,a0,-1208 # 800089e0 <etext+0x9e0>
    80004ea0:	ffffb097          	auipc	ra,0xffffb
    80004ea4:	6f6080e7          	jalr	1782(ra) # 80000596 <panic>

0000000080004ea8 <filewrite>:
 * Write to file f.
 * addr is a user virtual address.
 */
int
filewrite(struct file *f, uint64 addr, int n)
{
    80004ea8:	715d                	add	sp,sp,-80
    80004eaa:	e0a2                	sd	s0,64(sp)
    80004eac:	e486                	sd	ra,72(sp)
    80004eae:	f84a                	sd	s2,48(sp)
    80004eb0:	0880                	add	s0,sp,80
	int r = undefined, ret = 0;

	if (f->writable == 0)
    80004eb2:	00954783          	lbu	a5,9(a0)
    80004eb6:	10078a63          	beqz	a5,80004fca <filewrite+0x122>
		return -1;

	if (f->type == FD_PIPE) {
    80004eba:	411c                	lw	a5,0(a0)
    80004ebc:	fc26                	sd	s1,56(sp)
    80004ebe:	4705                	li	a4,1
    80004ec0:	84aa                	mv	s1,a0
    80004ec2:	0ee78763          	beq	a5,a4,80004fb0 <filewrite+0x108>
		ret = pipewrite(f->pipe, addr, n);
	} else if (f->type == FD_DEVICE) {
    80004ec6:	470d                	li	a4,3
    80004ec8:	0ae78d63          	beq	a5,a4,80004f82 <filewrite+0xda>
		if (f->major < 0 || f->major >= NDEV || !devsw[f->major].write)
			return -1;
		ret = devsw[f->major].write(1, addr, n);
	} else if (f->type == FD_INODE) {
    80004ecc:	4709                	li	a4,2
    80004ece:	10e79363          	bne	a5,a4,80004fd4 <filewrite+0x12c>
    80004ed2:	ec56                	sd	s5,24(sp)
    80004ed4:	8ab2                	mv	s5,a2
                 * this really belongs lower down, since writei()
                 * might be writing a device like the console.
                 */
		int max = ((MAXOPBLOCKS - 1 - 1 - 2) / 2) * BSIZE;
		int i = 0;
		while (i < n) {
    80004ed6:	0ec05763          	blez	a2,80004fc4 <filewrite+0x11c>
    80004eda:	e85a                	sd	s6,16(sp)
			int n1 = n - i;
			if (n1 > max)
    80004edc:	6b05                	lui	s6,0x1
    80004ede:	e45e                	sd	s7,8(sp)
    80004ee0:	f44e                	sd	s3,40(sp)
    80004ee2:	f052                	sd	s4,32(sp)
    80004ee4:	8bae                	mv	s7,a1
		int i = 0;
    80004ee6:	4901                	li	s2,0
			if (n1 > max)
    80004ee8:	c00b0b13          	add	s6,s6,-1024 # c00 <_entry-0x7ffff400>
    80004eec:	a025                	j	80004f14 <filewrite+0x6c>
				n1 = max;

			begin_op();
			ilock(f->ip);
			if ((r = writei(f->ip, 1, addr + i, f->off, n1)) > 0)
				f->off += r;
    80004eee:	509c                	lw	a5,32(s1)
			iunlock(f->ip);
    80004ef0:	6c88                	ld	a0,24(s1)
				f->off += r;
    80004ef2:	013787bb          	addw	a5,a5,s3
    80004ef6:	d09c                	sw	a5,32(s1)
			iunlock(f->ip);
    80004ef8:	fffff097          	auipc	ra,0xfffff
    80004efc:	f1a080e7          	jalr	-230(ra) # 80003e12 <iunlock>
			end_op();
    80004f00:	00000097          	auipc	ra,0x0
    80004f04:	944080e7          	jalr	-1724(ra) # 80004844 <end_op>

			if (r != n1) {
    80004f08:	073a1863          	bne	s4,s3,80004f78 <filewrite+0xd0>
				//error from writei
				    break;
			}
			i += r;
    80004f0c:	0149093b          	addw	s2,s2,s4
		while (i < n) {
    80004f10:	07595463          	bge	s2,s5,80004f78 <filewrite+0xd0>
			if (n1 > max)
    80004f14:	412a8a3b          	subw	s4,s5,s2
    80004f18:	014b5363          	bge	s6,s4,80004f1e <filewrite+0x76>
    80004f1c:	8a5a                	mv	s4,s6
			begin_op();
    80004f1e:	00000097          	auipc	ra,0x0
    80004f22:	8b6080e7          	jalr	-1866(ra) # 800047d4 <begin_op>
			ilock(f->ip);
    80004f26:	6c88                	ld	a0,24(s1)
    80004f28:	fffff097          	auipc	ra,0xfffff
    80004f2c:	e1c080e7          	jalr	-484(ra) # 80003d44 <ilock>
			if ((r = writei(f->ip, 1, addr + i, f->off, n1)) > 0)
    80004f30:	5094                	lw	a3,32(s1)
    80004f32:	6c88                	ld	a0,24(s1)
    80004f34:	8752                	mv	a4,s4
    80004f36:	01790633          	add	a2,s2,s7
    80004f3a:	4585                	li	a1,1
    80004f3c:	fffff097          	auipc	ra,0xfffff
    80004f40:	216080e7          	jalr	534(ra) # 80004152 <writei>
    80004f44:	89aa                	mv	s3,a0
    80004f46:	faa044e3          	bgtz	a0,80004eee <filewrite+0x46>
			iunlock(f->ip);
    80004f4a:	6c88                	ld	a0,24(s1)
    80004f4c:	fffff097          	auipc	ra,0xfffff
    80004f50:	ec6080e7          	jalr	-314(ra) # 80003e12 <iunlock>
			end_op();
    80004f54:	00000097          	auipc	ra,0x0
    80004f58:	8f0080e7          	jalr	-1808(ra) # 80004844 <end_op>
			if (r != n1) {
    80004f5c:	79a2                	ld	s3,40(sp)
    80004f5e:	7a02                	ld	s4,32(sp)
    80004f60:	6b42                	ld	s6,16(sp)
    80004f62:	6ba2                	ld	s7,8(sp)
		}
		ret = (i == n ? n : -1);
    80004f64:	74e2                	ld	s1,56(sp)
    80004f66:	072a9163          	bne	s5,s2,80004fc8 <filewrite+0x120>
    80004f6a:	6ae2                	ld	s5,24(sp)
	} else {
		panic("filewrite");
	}

	return ret;
}
    80004f6c:	60a6                	ld	ra,72(sp)
    80004f6e:	6406                	ld	s0,64(sp)
    80004f70:	854a                	mv	a0,s2
    80004f72:	7942                	ld	s2,48(sp)
    80004f74:	6161                	add	sp,sp,80
    80004f76:	8082                	ret
    80004f78:	79a2                	ld	s3,40(sp)
    80004f7a:	7a02                	ld	s4,32(sp)
    80004f7c:	6b42                	ld	s6,16(sp)
    80004f7e:	6ba2                	ld	s7,8(sp)
    80004f80:	b7d5                	j	80004f64 <filewrite+0xbc>
		if (f->major < 0 || f->major >= NDEV || !devsw[f->major].write)
    80004f82:	02451783          	lh	a5,36(a0)
    80004f86:	4725                	li	a4,9
    80004f88:	03079693          	sll	a3,a5,0x30
    80004f8c:	92c1                	srl	a3,a3,0x30
    80004f8e:	04d76063          	bltu	a4,a3,80004fce <filewrite+0x126>
    80004f92:	0792                	sll	a5,a5,0x4
    80004f94:	0001c717          	auipc	a4,0x1c
    80004f98:	09470713          	add	a4,a4,148 # 80021028 <devsw>
    80004f9c:	97ba                	add	a5,a5,a4
    80004f9e:	679c                	ld	a5,8(a5)
    80004fa0:	c79d                	beqz	a5,80004fce <filewrite+0x126>
}
    80004fa2:	6406                	ld	s0,64(sp)
		ret = devsw[f->major].write(1, addr, n);
    80004fa4:	74e2                	ld	s1,56(sp)
}
    80004fa6:	60a6                	ld	ra,72(sp)
    80004fa8:	7942                	ld	s2,48(sp)
		ret = devsw[f->major].write(1, addr, n);
    80004faa:	4505                	li	a0,1
}
    80004fac:	6161                	add	sp,sp,80
		ret = devsw[f->major].write(1, addr, n);
    80004fae:	8782                	jr	a5
}
    80004fb0:	6406                	ld	s0,64(sp)
		ret = pipewrite(f->pipe, addr, n);
    80004fb2:	74e2                	ld	s1,56(sp)
}
    80004fb4:	60a6                	ld	ra,72(sp)
    80004fb6:	7942                	ld	s2,48(sp)
		ret = pipewrite(f->pipe, addr, n);
    80004fb8:	6908                	ld	a0,16(a0)
}
    80004fba:	6161                	add	sp,sp,80
		ret = pipewrite(f->pipe, addr, n);
    80004fbc:	00000317          	auipc	t1,0x0
    80004fc0:	16c30067          	jr	364(t1) # 80005128 <pipewrite>
		int i = 0;
    80004fc4:	4901                	li	s2,0
    80004fc6:	bf79                	j	80004f64 <filewrite+0xbc>
    80004fc8:	6ae2                	ld	s5,24(sp)
		return -1;
    80004fca:	597d                	li	s2,-1
    80004fcc:	b745                	j	80004f6c <filewrite+0xc4>
    80004fce:	74e2                	ld	s1,56(sp)
    80004fd0:	597d                	li	s2,-1
    80004fd2:	bf69                	j	80004f6c <filewrite+0xc4>
		panic("filewrite");
    80004fd4:	00004517          	auipc	a0,0x4
    80004fd8:	a1c50513          	add	a0,a0,-1508 # 800089f0 <etext+0x9f0>
    80004fdc:	f44e                	sd	s3,40(sp)
    80004fde:	f052                	sd	s4,32(sp)
    80004fe0:	ec56                	sd	s5,24(sp)
    80004fe2:	e85a                	sd	s6,16(sp)
    80004fe4:	e45e                	sd	s7,8(sp)
    80004fe6:	ffffb097          	auipc	ra,0xffffb
    80004fea:	5b0080e7          	jalr	1456(ra) # 80000596 <panic>

0000000080004fee <pipealloc>:
	int writeopen;		/* write fd is still open */
};

int
pipealloc(struct file **f0, struct file **f1)
{
    80004fee:	7179                	add	sp,sp,-48
    80004ff0:	f022                	sd	s0,32(sp)
    80004ff2:	e84a                	sd	s2,16(sp)
    80004ff4:	e44e                	sd	s3,8(sp)
    80004ff6:	f406                	sd	ra,40(sp)
    80004ff8:	1800                	add	s0,sp,48
	struct pipe *pi = nullptr;

	pi = 0;
	*f0 = *f1 = 0;
    80004ffa:	0005b023          	sd	zero,0(a1)
    80004ffe:	00053023          	sd	zero,0(a0)
{
    80005002:	892a                	mv	s2,a0
    80005004:	89ae                	mv	s3,a1
	if ((*f0 = filealloc()) == 0 || (*f1 = filealloc()) == 0)
    80005006:	00000097          	auipc	ra,0x0
    8000500a:	bb2080e7          	jalr	-1102(ra) # 80004bb8 <filealloc>
    8000500e:	00a93023          	sd	a0,0(s2)
    80005012:	c141                	beqz	a0,80005092 <pipealloc+0xa4>
    80005014:	00000097          	auipc	ra,0x0
    80005018:	ba4080e7          	jalr	-1116(ra) # 80004bb8 <filealloc>
    8000501c:	00a9b023          	sd	a0,0(s3)
    80005020:	c135                	beqz	a0,80005084 <pipealloc+0x96>
    80005022:	ec26                	sd	s1,24(sp)
		goto bad;
	if ((pi = (struct pipe *)kalloc()) == 0)
    80005024:	ffffc097          	auipc	ra,0xffffc
    80005028:	b42080e7          	jalr	-1214(ra) # 80000b66 <kalloc>
    8000502c:	84aa                	mv	s1,a0
    8000502e:	c93d                	beqz	a0,800050a4 <pipealloc+0xb6>
		goto bad;
	pi->readopen = 1;
    80005030:	4785                	li	a5,1
    80005032:	1782                	sll	a5,a5,0x20
    80005034:	e052                	sd	s4,0(sp)
    80005036:	0785                	add	a5,a5,1
    80005038:	22f53023          	sd	a5,544(a0)
	pi->writeopen = 1;
	pi->nwrite = 0;
	pi->nread = 0;
    8000503c:	20053c23          	sd	zero,536(a0)
	initlock(&pi->lock, "pipe");
    80005040:	00004597          	auipc	a1,0x4
    80005044:	9c058593          	add	a1,a1,-1600 # 80008a00 <etext+0xa00>
    80005048:	ffffc097          	auipc	ra,0xffffc
    8000504c:	b88080e7          	jalr	-1144(ra) # 80000bd0 <initlock>
	(*f0)->type = FD_PIPE;
    80005050:	00093703          	ld	a4,0(s2)
	pi->readopen = 1;
    80005054:	4a05                	li	s4,1
	(*f0)->pipe = pi;
	(*f1)->type = FD_PIPE;
	(*f1)->readable = 0;
	(*f1)->writable = 1;
	(*f1)->pipe = pi;
	return 0;
    80005056:	4501                	li	a0,0
	(*f0)->readable = 1;
    80005058:	01471423          	sh	s4,8(a4)
	(*f1)->type = FD_PIPE;
    8000505c:	0009b783          	ld	a5,0(s3)
	(*f0)->type = FD_PIPE;
    80005060:	01472023          	sw	s4,0(a4)
	(*f0)->pipe = pi;
    80005064:	eb04                	sd	s1,16(a4)
	(*f1)->readable = 0;
    80005066:	10000713          	li	a4,256
    8000506a:	00e79423          	sh	a4,8(a5)
	(*f1)->type = FD_PIPE;
    8000506e:	0147a023          	sw	s4,0(a5)
	(*f1)->pipe = pi;
    80005072:	eb84                	sd	s1,16(a5)
	return 0;
    80005074:	6a02                	ld	s4,0(sp)
    80005076:	64e2                	ld	s1,24(sp)
	if (*f0)
		fileclose(*f0);
	if (*f1)
		fileclose(*f1);
	return -1;
}
    80005078:	70a2                	ld	ra,40(sp)
    8000507a:	7402                	ld	s0,32(sp)
    8000507c:	6942                	ld	s2,16(sp)
    8000507e:	69a2                	ld	s3,8(sp)
    80005080:	6145                	add	sp,sp,48
    80005082:	8082                	ret
	if (*f0)
    80005084:	00093503          	ld	a0,0(s2)
    80005088:	cd01                	beqz	a0,800050a0 <pipealloc+0xb2>
		fileclose(*f0);
    8000508a:	00000097          	auipc	ra,0x0
    8000508e:	bf6080e7          	jalr	-1034(ra) # 80004c80 <fileclose>
	if (*f1)
    80005092:	0009b503          	ld	a0,0(s3)
    80005096:	c509                	beqz	a0,800050a0 <pipealloc+0xb2>
		fileclose(*f1);
    80005098:	00000097          	auipc	ra,0x0
    8000509c:	be8080e7          	jalr	-1048(ra) # 80004c80 <fileclose>
	return -1;
    800050a0:	557d                	li	a0,-1
    800050a2:	bfd9                	j	80005078 <pipealloc+0x8a>
	if (*f0)
    800050a4:	00093503          	ld	a0,0(s2)
    800050a8:	64e2                	ld	s1,24(sp)
    800050aa:	f165                	bnez	a0,8000508a <pipealloc+0x9c>
    800050ac:	b7dd                	j	80005092 <pipealloc+0xa4>

00000000800050ae <pipeclose>:

void
pipeclose(struct pipe *pi, int writable)
{
    800050ae:	1101                	add	sp,sp,-32
    800050b0:	e822                	sd	s0,16(sp)
    800050b2:	e426                	sd	s1,8(sp)
    800050b4:	e04a                	sd	s2,0(sp)
    800050b6:	ec06                	sd	ra,24(sp)
    800050b8:	1000                	add	s0,sp,32
    800050ba:	892e                	mv	s2,a1
    800050bc:	84aa                	mv	s1,a0
	acquire(&pi->lock);
    800050be:	ffffc097          	auipc	ra,0xffffc
    800050c2:	ba2080e7          	jalr	-1118(ra) # 80000c60 <acquire>
	if (writable) {
    800050c6:	02090c63          	beqz	s2,800050fe <pipeclose+0x50>
		pi->writeopen = 0;
		wakeup(&pi->nread);
    800050ca:	21848513          	add	a0,s1,536
		pi->writeopen = 0;
    800050ce:	2204a223          	sw	zero,548(s1)
		wakeup(&pi->nread);
    800050d2:	ffffd097          	auipc	ra,0xffffd
    800050d6:	598080e7          	jalr	1432(ra) # 8000266a <wakeup>
	} else {
		pi->readopen = 0;
		wakeup(&pi->nwrite);
	}
	if (pi->readopen == 0 && pi->writeopen == 0) {
    800050da:	2204b783          	ld	a5,544(s1)
		release(&pi->lock);
    800050de:	8526                	mv	a0,s1
	if (pi->readopen == 0 && pi->writeopen == 0) {
    800050e0:	eb9d                	bnez	a5,80005116 <pipeclose+0x68>
		release(&pi->lock);
    800050e2:	ffffc097          	auipc	ra,0xffffc
    800050e6:	c3e080e7          	jalr	-962(ra) # 80000d20 <release>
		kfree((char *)pi);
	} else
		release(&pi->lock);
}
    800050ea:	6442                	ld	s0,16(sp)
    800050ec:	60e2                	ld	ra,24(sp)
    800050ee:	6902                	ld	s2,0(sp)
		kfree((char *)pi);
    800050f0:	8526                	mv	a0,s1
}
    800050f2:	64a2                	ld	s1,8(sp)
    800050f4:	6105                	add	sp,sp,32
		kfree((char *)pi);
    800050f6:	ffffc317          	auipc	t1,0xffffc
    800050fa:	95230067          	jr	-1710(t1) # 80000a48 <kfree>
		wakeup(&pi->nwrite);
    800050fe:	21c48513          	add	a0,s1,540
		pi->readopen = 0;
    80005102:	2204a023          	sw	zero,544(s1)
		wakeup(&pi->nwrite);
    80005106:	ffffd097          	auipc	ra,0xffffd
    8000510a:	564080e7          	jalr	1380(ra) # 8000266a <wakeup>
	if (pi->readopen == 0 && pi->writeopen == 0) {
    8000510e:	2204b783          	ld	a5,544(s1)
		release(&pi->lock);
    80005112:	8526                	mv	a0,s1
	if (pi->readopen == 0 && pi->writeopen == 0) {
    80005114:	d7f9                	beqz	a5,800050e2 <pipeclose+0x34>
}
    80005116:	6442                	ld	s0,16(sp)
    80005118:	60e2                	ld	ra,24(sp)
    8000511a:	64a2                	ld	s1,8(sp)
    8000511c:	6902                	ld	s2,0(sp)
    8000511e:	6105                	add	sp,sp,32
		release(&pi->lock);
    80005120:	ffffc317          	auipc	t1,0xffffc
    80005124:	c0030067          	jr	-1024(t1) # 80000d20 <release>

0000000080005128 <pipewrite>:

int
pipewrite(struct pipe *pi, uint64 addr, int n)
{
    80005128:	711d                	add	sp,sp,-96
    8000512a:	e8a2                	sd	s0,80(sp)
    8000512c:	e4a6                	sd	s1,72(sp)
    8000512e:	fc4e                	sd	s3,56(sp)
    80005130:	f852                	sd	s4,48(sp)
    80005132:	f456                	sd	s5,40(sp)
    80005134:	ec86                	sd	ra,88(sp)
    80005136:	e0ca                	sd	s2,64(sp)
    80005138:	1080                	add	s0,sp,96
    8000513a:	84aa                	mv	s1,a0
    8000513c:	8a32                	mv	s4,a2
    8000513e:	8aae                	mv	s5,a1
	int i = 0;
	struct proc *pr = myproc();
    80005140:	ffffd097          	auipc	ra,0xffffd
    80005144:	cb0080e7          	jalr	-848(ra) # 80001df0 <myproc>
    80005148:	89aa                	mv	s3,a0

	acquire(&pi->lock);
    8000514a:	8526                	mv	a0,s1
    8000514c:	ffffc097          	auipc	ra,0xffffc
    80005150:	b14080e7          	jalr	-1260(ra) # 80000c60 <acquire>
	while (i < n) {
    80005154:	0d405963          	blez	s4,80005226 <pipewrite+0xfe>
    80005158:	f05a                	sd	s6,32(sp)
    8000515a:	ec5e                	sd	s7,24(sp)
    8000515c:	e862                	sd	s8,16(sp)
	int i = 0;
    8000515e:	4901                	li	s2,0
		if (pi->nwrite == pi->nread + PIPESIZE) { /* DOC:		pipewrite - full */
			    wakeup(&pi->nread);
			sleep(&pi->nwrite, &pi->lock);
		} else {
			char ch;
			if (copyin(pr->pagetable, &ch, addr + i, 1) == -1)
    80005160:	5b7d                	li	s6,-1
			    wakeup(&pi->nread);
    80005162:	21848c13          	add	s8,s1,536
			sleep(&pi->nwrite, &pi->lock);
    80005166:	21c48b93          	add	s7,s1,540
		if (pi->readopen == 0 || killed(pr)) {
    8000516a:	2204a783          	lw	a5,544(s1)
    8000516e:	854e                	mv	a0,s3
    80005170:	cbc1                	beqz	a5,80005200 <pipewrite+0xd8>
    80005172:	ffffd097          	auipc	ra,0xffffd
    80005176:	774080e7          	jalr	1908(ra) # 800028e6 <killed>
			if (copyin(pr->pagetable, &ch, addr + i, 1) == -1)
    8000517a:	4685                	li	a3,1
    8000517c:	01590633          	add	a2,s2,s5
    80005180:	faf40593          	add	a1,s0,-81
		if (pi->readopen == 0 || killed(pr)) {
    80005184:	ed35                	bnez	a0,80005200 <pipewrite+0xd8>
		if (pi->nwrite == pi->nread + PIPESIZE) { /* DOC:		pipewrite - full */
    80005186:	2184a783          	lw	a5,536(s1)
    8000518a:	21c4a703          	lw	a4,540(s1)
    8000518e:	2007879b          	addw	a5,a5,512
    80005192:	04f70963          	beq	a4,a5,800051e4 <pipewrite+0xbc>
			if (copyin(pr->pagetable, &ch, addr + i, 1) == -1)
    80005196:	0509b503          	ld	a0,80(s3)
    8000519a:	ffffd097          	auipc	ra,0xffffd
    8000519e:	808080e7          	jalr	-2040(ra) # 800019a2 <copyin>
    800051a2:	03650263          	beq	a0,s6,800051c6 <pipewrite+0x9e>
				break;
			pi->data[pi->nwrite++ % PIPESIZE] = ch;
    800051a6:	21c4a783          	lw	a5,540(s1)
    800051aa:	faf44703          	lbu	a4,-81(s0)
			i++;
    800051ae:	2905                	addw	s2,s2,1
			pi->data[pi->nwrite++ % PIPESIZE] = ch;
    800051b0:	0017869b          	addw	a3,a5,1
    800051b4:	1ff7f793          	and	a5,a5,511
    800051b8:	20d4ae23          	sw	a3,540(s1)
    800051bc:	97a6                	add	a5,a5,s1
    800051be:	00e78c23          	sb	a4,24(a5)
	while (i < n) {
    800051c2:	fb4944e3          	blt	s2,s4,8000516a <pipewrite+0x42>
    800051c6:	7b02                	ld	s6,32(sp)
    800051c8:	6be2                	ld	s7,24(sp)
    800051ca:	6c42                	ld	s8,16(sp)
		}
	}
	wakeup(&pi->nread);
    800051cc:	21848513          	add	a0,s1,536
    800051d0:	ffffd097          	auipc	ra,0xffffd
    800051d4:	49a080e7          	jalr	1178(ra) # 8000266a <wakeup>
	release(&pi->lock);
    800051d8:	8526                	mv	a0,s1
    800051da:	ffffc097          	auipc	ra,0xffffc
    800051de:	b46080e7          	jalr	-1210(ra) # 80000d20 <release>

	return i;
    800051e2:	a805                	j	80005212 <pipewrite+0xea>
			    wakeup(&pi->nread);
    800051e4:	8562                	mv	a0,s8
    800051e6:	ffffd097          	auipc	ra,0xffffd
    800051ea:	484080e7          	jalr	1156(ra) # 8000266a <wakeup>
			sleep(&pi->nwrite, &pi->lock);
    800051ee:	85a6                	mv	a1,s1
    800051f0:	855e                	mv	a0,s7
    800051f2:	ffffd097          	auipc	ra,0xffffd
    800051f6:	3fc080e7          	jalr	1020(ra) # 800025ee <sleep>
	while (i < n) {
    800051fa:	f74948e3          	blt	s2,s4,8000516a <pipewrite+0x42>
    800051fe:	b7e1                	j	800051c6 <pipewrite+0x9e>
			release(&pi->lock);
    80005200:	8526                	mv	a0,s1
    80005202:	ffffc097          	auipc	ra,0xffffc
    80005206:	b1e080e7          	jalr	-1250(ra) # 80000d20 <release>
			return -1;
    8000520a:	7b02                	ld	s6,32(sp)
    8000520c:	6be2                	ld	s7,24(sp)
    8000520e:	6c42                	ld	s8,16(sp)
    80005210:	597d                	li	s2,-1
}
    80005212:	60e6                	ld	ra,88(sp)
    80005214:	6446                	ld	s0,80(sp)
    80005216:	64a6                	ld	s1,72(sp)
    80005218:	79e2                	ld	s3,56(sp)
    8000521a:	7a42                	ld	s4,48(sp)
    8000521c:	7aa2                	ld	s5,40(sp)
    8000521e:	854a                	mv	a0,s2
    80005220:	6906                	ld	s2,64(sp)
    80005222:	6125                	add	sp,sp,96
    80005224:	8082                	ret
	int i = 0;
    80005226:	4901                	li	s2,0
    80005228:	b755                	j	800051cc <pipewrite+0xa4>

000000008000522a <piperead>:

int
piperead(struct pipe *pi, uint64 addr, int n)
{
    8000522a:	715d                	add	sp,sp,-80
    8000522c:	e486                	sd	ra,72(sp)
    8000522e:	e0a2                	sd	s0,64(sp)
    80005230:	fc26                	sd	s1,56(sp)
    80005232:	0880                	add	s0,sp,80
    80005234:	f84a                	sd	s2,48(sp)
    80005236:	f44e                	sd	s3,40(sp)
    80005238:	f052                	sd	s4,32(sp)
    8000523a:	ec56                	sd	s5,24(sp)
    8000523c:	84aa                	mv	s1,a0
    8000523e:	892e                	mv	s2,a1
    80005240:	8ab2                	mv	s5,a2
	int i = undefined;
	struct proc *pr = myproc();
    80005242:	ffffd097          	auipc	ra,0xffffd
    80005246:	bae080e7          	jalr	-1106(ra) # 80001df0 <myproc>
    8000524a:	8a2a                	mv	s4,a0
	char ch = undefined;

	acquire(&pi->lock);
    8000524c:	8526                	mv	a0,s1
	char ch = undefined;
    8000524e:	fa040fa3          	sb	zero,-65(s0)
	acquire(&pi->lock);
    80005252:	ffffc097          	auipc	ra,0xffffc
    80005256:	a0e080e7          	jalr	-1522(ra) # 80000c60 <acquire>
	while (pi->nread == pi->nwrite && pi->writeopen) { /*DOC:		pipe - empty */
    8000525a:	2184a783          	lw	a5,536(s1)
    8000525e:	21c4a703          	lw	a4,540(s1)
    80005262:	21848993          	add	s3,s1,536
    80005266:	02e78563          	beq	a5,a4,80005290 <piperead+0x66>
    8000526a:	a03d                	j	80005298 <piperead+0x6e>
		    if (killed(pr)) {
    8000526c:	ffffd097          	auipc	ra,0xffffd
    80005270:	67a080e7          	jalr	1658(ra) # 800028e6 <killed>
    80005274:	87aa                	mv	a5,a0
			release(&pi->lock);
			return -1;
		}
		sleep(&pi->nread, &pi->lock); /* DOC:		piperead - sleep */
    80005276:	85a6                	mv	a1,s1
    80005278:	854e                	mv	a0,s3
		    if (killed(pr)) {
    8000527a:	efc9                	bnez	a5,80005314 <piperead+0xea>
		sleep(&pi->nread, &pi->lock); /* DOC:		piperead - sleep */
    8000527c:	ffffd097          	auipc	ra,0xffffd
    80005280:	372080e7          	jalr	882(ra) # 800025ee <sleep>
	while (pi->nread == pi->nwrite && pi->writeopen) { /*DOC:		pipe - empty */
    80005284:	2184a783          	lw	a5,536(s1)
    80005288:	21c4a703          	lw	a4,540(s1)
    8000528c:	00e79663          	bne	a5,a4,80005298 <piperead+0x6e>
    80005290:	2244a683          	lw	a3,548(s1)
		    if (killed(pr)) {
    80005294:	8552                	mv	a0,s4
	while (pi->nread == pi->nwrite && pi->writeopen) { /*DOC:		pipe - empty */
    80005296:	faf9                	bnez	a3,8000526c <piperead+0x42>
    80005298:	e85a                	sd	s6,16(sp)
	}
	for (i = 0; i < n; i++) { /* DOC:		piperead - copy */
    8000529a:	4981                	li	s3,0
		    if (pi->nread == pi->nwrite)
			break;
		ch = pi->data[pi->nread++ % PIPESIZE];
		if (copyout(pr->pagetable, addr + i, &ch, 1) == -1)
    8000529c:	5b7d                	li	s6,-1
	for (i = 0; i < n; i++) { /* DOC:		piperead - copy */
    8000529e:	03504963          	bgtz	s5,800052d0 <piperead+0xa6>
    800052a2:	a099                	j	800052e8 <piperead+0xbe>
		ch = pi->data[pi->nread++ % PIPESIZE];
    800052a4:	20a4ac23          	sw	a0,536(s1)
    800052a8:	01884783          	lbu	a5,24(a6) # 1018 <_entry-0x7fffefe8>
		if (copyout(pr->pagetable, addr + i, &ch, 1) == -1)
    800052ac:	050a3503          	ld	a0,80(s4)
		ch = pi->data[pi->nread++ % PIPESIZE];
    800052b0:	faf40fa3          	sb	a5,-65(s0)
		if (copyout(pr->pagetable, addr + i, &ch, 1) == -1)
    800052b4:	ffffc097          	auipc	ra,0xffffc
    800052b8:	622080e7          	jalr	1570(ra) # 800018d6 <copyout>
    800052bc:	03650663          	beq	a0,s6,800052e8 <piperead+0xbe>
	for (i = 0; i < n; i++) { /* DOC:		piperead - copy */
    800052c0:	2985                	addw	s3,s3,1
    800052c2:	0905                	add	s2,s2,1
    800052c4:	033a8263          	beq	s5,s3,800052e8 <piperead+0xbe>
    800052c8:	2184a783          	lw	a5,536(s1)
    800052cc:	21c4a703          	lw	a4,540(s1)
		ch = pi->data[pi->nread++ % PIPESIZE];
    800052d0:	1ff7f693          	and	a3,a5,511
    800052d4:	00d48833          	add	a6,s1,a3
    800052d8:	0017851b          	addw	a0,a5,1
		if (copyout(pr->pagetable, addr + i, &ch, 1) == -1)
    800052dc:	4685                	li	a3,1
    800052de:	fbf40613          	add	a2,s0,-65
    800052e2:	85ca                	mv	a1,s2
		    if (pi->nread == pi->nwrite)
    800052e4:	fcf710e3          	bne	a4,a5,800052a4 <piperead+0x7a>
			break;
	}
	wakeup(&pi->nwrite); /* DOC:	piperead - wakeup */
    800052e8:	21c48513          	add	a0,s1,540
    800052ec:	ffffd097          	auipc	ra,0xffffd
    800052f0:	37e080e7          	jalr	894(ra) # 8000266a <wakeup>
	    release(&pi->lock);
    800052f4:	8526                	mv	a0,s1
    800052f6:	ffffc097          	auipc	ra,0xffffc
    800052fa:	a2a080e7          	jalr	-1494(ra) # 80000d20 <release>
    800052fe:	6b42                	ld	s6,16(sp)
	return i;
}
    80005300:	60a6                	ld	ra,72(sp)
    80005302:	6406                	ld	s0,64(sp)
    80005304:	74e2                	ld	s1,56(sp)
    80005306:	7942                	ld	s2,48(sp)
    80005308:	7a02                	ld	s4,32(sp)
    8000530a:	6ae2                	ld	s5,24(sp)
    8000530c:	854e                	mv	a0,s3
    8000530e:	79a2                	ld	s3,40(sp)
    80005310:	6161                	add	sp,sp,80
    80005312:	8082                	ret
			release(&pi->lock);
    80005314:	8526                	mv	a0,s1
    80005316:	ffffc097          	auipc	ra,0xffffc
    8000531a:	a0a080e7          	jalr	-1526(ra) # 80000d20 <release>
			return -1;
    8000531e:	59fd                	li	s3,-1
    80005320:	b7c5                	j	80005300 <piperead+0xd6>

0000000080005322 <flags2perm>:

static int loadseg(pde_t *, uint64, struct inode *, uint, uint);

int
flags2perm(int flags)
{
    80005322:	1141                	add	sp,sp,-16
    80005324:	e422                	sd	s0,8(sp)
    80005326:	0800                	add	s0,sp,16
	int perm = 0;
	if (flags & 0x1)
    80005328:	00157713          	and	a4,a0,1
		perm = PTE_X;
	if (flags & 0x2)
    8000532c:	00257793          	and	a5,a0,2
	if (flags & 0x1)
    80005330:	00371513          	sll	a0,a4,0x3
	if (flags & 0x2)
    80005334:	c399                	beqz	a5,8000533a <flags2perm+0x18>
		perm |= PTE_W;
    80005336:	00456513          	or	a0,a0,4
	return perm;
}
    8000533a:	6422                	ld	s0,8(sp)
    8000533c:	0141                	add	sp,sp,16
    8000533e:	8082                	ret

0000000080005340 <exec>:

int
exec(char *path, char **argv)
{
    80005340:	df010113          	add	sp,sp,-528
    80005344:	20113423          	sd	ra,520(sp)
    80005348:	20813023          	sd	s0,512(sp)
    8000534c:	ffa6                	sd	s1,504(sp)
    8000534e:	0c00                	add	s0,sp,528
    80005350:	fbca                	sd	s2,496(sp)
    80005352:	872a                	mv	a4,a0
    80005354:	87ae                	mv	a5,a1
	char *s = nullptr, *last = nullptr;
	int i = undefined, off = undefined;
	uint64 argc = undefined, sz = 0, sp = undefined, ustack[MAXARG] = {}, stackbase = undefined;
    80005356:	10000613          	li	a2,256
    8000535a:	4581                	li	a1,0
    8000535c:	e9040513          	add	a0,s0,-368
{
    80005360:	893a                	mv	s2,a4
    80005362:	dee43c23          	sd	a4,-520(s0)
    80005366:	e0f43023          	sd	a5,-512(s0)
	uint64 argc = undefined, sz = 0, sp = undefined, ustack[MAXARG] = {}, stackbase = undefined;
    8000536a:	ffffc097          	auipc	ra,0xffffc
    8000536e:	a0a080e7          	jalr	-1526(ra) # 80000d74 <memset>
	struct elfhdr elf = {};
    80005372:	e4043823          	sd	zero,-432(s0)
    80005376:	e4043c23          	sd	zero,-424(s0)
    8000537a:	e6043023          	sd	zero,-416(s0)
    8000537e:	e6043423          	sd	zero,-408(s0)
    80005382:	e6043823          	sd	zero,-400(s0)
    80005386:	e6043c23          	sd	zero,-392(s0)
    8000538a:	e8043023          	sd	zero,-384(s0)
    8000538e:	e8043423          	sd	zero,-376(s0)
	struct inode *ip = nullptr;
	struct proghdr ph = {};
    80005392:	e0043c23          	sd	zero,-488(s0)
    80005396:	e2043023          	sd	zero,-480(s0)
    8000539a:	e2043423          	sd	zero,-472(s0)
    8000539e:	e2043823          	sd	zero,-464(s0)
    800053a2:	e2043c23          	sd	zero,-456(s0)
    800053a6:	e4043023          	sd	zero,-448(s0)
    800053aa:	e4043423          	sd	zero,-440(s0)
	pagetable_t pagetable = 0, oldpagetable = nullptr;
	struct proc *p = myproc();
    800053ae:	ffffd097          	auipc	ra,0xffffd
    800053b2:	a42080e7          	jalr	-1470(ra) # 80001df0 <myproc>
    800053b6:	84aa                	mv	s1,a0

	begin_op();
    800053b8:	fffff097          	auipc	ra,0xfffff
    800053bc:	41c080e7          	jalr	1052(ra) # 800047d4 <begin_op>

	if ((ip = namei(path)) == 0) {
    800053c0:	854a                	mv	a0,s2
    800053c2:	fffff097          	auipc	ra,0xfffff
    800053c6:	216080e7          	jalr	534(ra) # 800045d8 <namei>
    800053ca:	16050163          	beqz	a0,8000552c <exec+0x1ec>
		end_op();
		return -1;
	}
	ilock(ip);
    800053ce:	892a                	mv	s2,a0
    800053d0:	fffff097          	auipc	ra,0xfffff
    800053d4:	974080e7          	jalr	-1676(ra) # 80003d44 <ilock>

	/* Check ELF header */
	    if (readi(ip, 0, (uint64) & elf, 0, sizeof(elf)) != sizeof(elf))
    800053d8:	04000713          	li	a4,64
    800053dc:	4681                	li	a3,0
    800053de:	e5040613          	add	a2,s0,-432
    800053e2:	4581                	li	a1,0
    800053e4:	854a                	mv	a0,s2
    800053e6:	fffff097          	auipc	ra,0xfffff
    800053ea:	c50080e7          	jalr	-944(ra) # 80004036 <readi>
    800053ee:	04000793          	li	a5,64
    800053f2:	12f51863          	bne	a0,a5,80005522 <exec+0x1e2>
		goto bad;

	if (elf.magic != ELF_MAGIC)
    800053f6:	e5042703          	lw	a4,-432(s0)
    800053fa:	464c47b7          	lui	a5,0x464c4
    800053fe:	57f78793          	add	a5,a5,1407 # 464c457f <_entry-0x39b3ba81>
    80005402:	12f71063          	bne	a4,a5,80005522 <exec+0x1e2>
		goto bad;

	if ((pagetable = proc_pagetable(p)) == 0)
    80005406:	8526                	mv	a0,s1
    80005408:	f7ce                	sd	s3,488(sp)
    8000540a:	ffffd097          	auipc	ra,0xffffd
    8000540e:	a64080e7          	jalr	-1436(ra) # 80001e6e <proc_pagetable>
    80005412:	89aa                	mv	s3,a0
    80005414:	2e050d63          	beqz	a0,8000570e <exec+0x3ce>
		goto bad;

	/* Load program into memory. */
	for (i = 0, off = elf.phoff; i < elf.phnum; i++, off += sizeof(ph)) {
    80005418:	e8845783          	lhu	a5,-376(s0)
    8000541c:	e3e2                	sd	s8,448(sp)
    8000541e:	f3d2                	sd	s4,480(sp)
    80005420:	efd6                	sd	s5,472(sp)
    80005422:	ebda                	sd	s6,464(sp)
    80005424:	e7de                	sd	s7,456(sp)
    80005426:	ff66                	sd	s9,440(sp)
    80005428:	fb6a                	sd	s10,432(sp)
    8000542a:	e7042c03          	lw	s8,-400(s0)
    8000542e:	2c078a63          	beqz	a5,80005702 <exec+0x3c2>
    80005432:	f76e                	sd	s11,424(sp)
			continue;
		if (ph.memsz < ph.filesz)
			goto bad;
		if (ph.vaddr + ph.memsz < ph.vaddr)
			goto bad;
		if (ph.vaddr % PGSIZE != 0)
    80005434:	6b05                	lui	s6,0x1
	uint64 argc = undefined, sz = 0, sp = undefined, ustack[MAXARG] = {}, stackbase = undefined;
    80005436:	4481                	li	s1,0
	for (i = 0, off = elf.phoff; i < elf.phnum; i++, off += sizeof(ph)) {
    80005438:	4c81                	li	s9,0
loadseg(pagetable_t pagetable, uint64 va, struct inode *ip, uint offset, uint sz)
{
	uint i = undefined, n = undefined;
	uint64 pa = undefined;

	for (i = 0; i < sz; i += PGSIZE) {
    8000543a:	6b85                	lui	s7,0x1
		if (readi(ip, 0, (uint64) & ph, off, sizeof(ph)) != sizeof(ph))
    8000543c:	2c01                	sext.w	s8,s8
    8000543e:	03800713          	li	a4,56
    80005442:	86e2                	mv	a3,s8
    80005444:	e1840613          	add	a2,s0,-488
    80005448:	4581                	li	a1,0
    8000544a:	854a                	mv	a0,s2
    8000544c:	fffff097          	auipc	ra,0xfffff
    80005450:	bea080e7          	jalr	-1046(ra) # 80004036 <readi>
    80005454:	03800793          	li	a5,56
    80005458:	1ef51763          	bne	a0,a5,80005646 <exec+0x306>
		if (ph.type != ELF_PROG_LOAD)
    8000545c:	e1842783          	lw	a5,-488(s0)
    80005460:	4705                	li	a4,1
    80005462:	0ee79563          	bne	a5,a4,8000554c <exec+0x20c>
		if (ph.memsz < ph.filesz)
    80005466:	e4043703          	ld	a4,-448(s0)
    8000546a:	e3843783          	ld	a5,-456(s0)
    8000546e:	1cf76c63          	bltu	a4,a5,80005646 <exec+0x306>
		if (ph.vaddr + ph.memsz < ph.vaddr)
    80005472:	e2843783          	ld	a5,-472(s0)
    80005476:	00f70633          	add	a2,a4,a5
    8000547a:	1ce66663          	bltu	a2,a4,80005646 <exec+0x306>
		if (ph.vaddr % PGSIZE != 0)
    8000547e:	6705                	lui	a4,0x1
    80005480:	177d                	add	a4,a4,-1 # fff <_entry-0x7ffff001>
    80005482:	8ff9                	and	a5,a5,a4
    80005484:	1c079163          	bnez	a5,80005646 <exec+0x306>
		if ((sz1 = uvmalloc(pagetable, sz, ph.vaddr + ph.memsz, flags2perm(ph.flags))) == 0)
    80005488:	e1c42783          	lw	a5,-484(s0)
	if (flags & 0x1)
    8000548c:	0037969b          	sllw	a3,a5,0x3
	if (flags & 0x2)
    80005490:	8b89                	and	a5,a5,2
	if (flags & 0x1)
    80005492:	8aa1                	and	a3,a3,8
	if (flags & 0x2)
    80005494:	c399                	beqz	a5,8000549a <exec+0x15a>
		perm |= PTE_W;
    80005496:	0046e693          	or	a3,a3,4
		if ((sz1 = uvmalloc(pagetable, sz, ph.vaddr + ph.memsz, flags2perm(ph.flags))) == 0)
    8000549a:	85a6                	mv	a1,s1
    8000549c:	854e                	mv	a0,s3
    8000549e:	ffffc097          	auipc	ra,0xffffc
    800054a2:	0ee080e7          	jalr	238(ra) # 8000158c <uvmalloc>
    800054a6:	e0a43423          	sd	a0,-504(s0)
    800054aa:	18050e63          	beqz	a0,80005646 <exec+0x306>
		if (loadseg(pagetable, ph.vaddr, ip, ph.off, ph.filesz) < 0)
    800054ae:	e3842483          	lw	s1,-456(s0)
    800054b2:	e2843a03          	ld	s4,-472(s0)
    800054b6:	e2042a83          	lw	s5,-480(s0)
	for (i = 0; i < sz; i += PGSIZE) {
    800054ba:	c4d9                	beqz	s1,80005548 <exec+0x208>
    800054bc:	4d81                	li	s11,0
    800054be:	a029                	j	800054c8 <exec+0x188>
    800054c0:	01bb8dbb          	addw	s11,s7,s11
    800054c4:	089df263          	bgeu	s11,s1,80005548 <exec+0x208>
		pa = walkaddr(pagetable, va + i);
    800054c8:	020d9593          	sll	a1,s11,0x20
    800054cc:	9181                	srl	a1,a1,0x20
    800054ce:	95d2                	add	a1,a1,s4
    800054d0:	854e                	mv	a0,s3
    800054d2:	ffffc097          	auipc	ra,0xffffc
    800054d6:	ddc080e7          	jalr	-548(ra) # 800012ae <walkaddr>
    800054da:	862a                	mv	a2,a0
		if (pa == 0)
    800054dc:	20050b63          	beqz	a0,800056f2 <exec+0x3b2>
			panic("loadseg: address should exist");
		if (sz - i < PGSIZE)
    800054e0:	41b48d3b          	subw	s10,s1,s11
    800054e4:	01ab7363          	bgeu	s6,s10,800054ea <exec+0x1aa>
    800054e8:	6d05                	lui	s10,0x1
			n = sz - i;
		else
			n = PGSIZE;
		if (readi(ip, 0, (uint64) pa, offset + i, n) != n)
    800054ea:	876a                	mv	a4,s10
    800054ec:	01ba86bb          	addw	a3,s5,s11
    800054f0:	4581                	li	a1,0
    800054f2:	854a                	mv	a0,s2
    800054f4:	fffff097          	auipc	ra,0xfffff
    800054f8:	b42080e7          	jalr	-1214(ra) # 80004036 <readi>
    800054fc:	2501                	sext.w	a0,a0
    800054fe:	fcad01e3          	beq	s10,a0,800054c0 <exec+0x180>
		proc_freepagetable(pagetable, sz);
    80005502:	e0843583          	ld	a1,-504(s0)
    80005506:	854e                	mv	a0,s3
    80005508:	ffffd097          	auipc	ra,0xffffd
    8000550c:	aea080e7          	jalr	-1302(ra) # 80001ff2 <proc_freepagetable>
    80005510:	79be                	ld	s3,488(sp)
    80005512:	7a1e                	ld	s4,480(sp)
    80005514:	6afe                	ld	s5,472(sp)
    80005516:	6b5e                	ld	s6,464(sp)
    80005518:	6bbe                	ld	s7,456(sp)
    8000551a:	6c1e                	ld	s8,448(sp)
    8000551c:	7cfa                	ld	s9,440(sp)
    8000551e:	7d5a                	ld	s10,432(sp)
    80005520:	7dba                	ld	s11,424(sp)
		iunlockput(ip);
    80005522:	854a                	mv	a0,s2
    80005524:	fffff097          	auipc	ra,0xfffff
    80005528:	a90080e7          	jalr	-1392(ra) # 80003fb4 <iunlockput>
		end_op();
    8000552c:	fffff097          	auipc	ra,0xfffff
    80005530:	318080e7          	jalr	792(ra) # 80004844 <end_op>
		return -1;
    80005534:	557d                	li	a0,-1
}
    80005536:	20813083          	ld	ra,520(sp)
    8000553a:	20013403          	ld	s0,512(sp)
    8000553e:	74fe                	ld	s1,504(sp)
    80005540:	795e                	ld	s2,496(sp)
    80005542:	21010113          	add	sp,sp,528
    80005546:	8082                	ret
		sz = sz1;
    80005548:	e0843483          	ld	s1,-504(s0)
	for (i = 0, off = elf.phoff; i < elf.phnum; i++, off += sizeof(ph)) {
    8000554c:	e8845783          	lhu	a5,-376(s0)
    80005550:	2c85                	addw	s9,s9,1
    80005552:	038c0c1b          	addw	s8,s8,56 # 1038 <_entry-0x7fffefc8>
    80005556:	eefcc3e3          	blt	s9,a5,8000543c <exec+0xfc>
	sz = PGROUNDUP(sz);
    8000555a:	6785                	lui	a5,0x1
    8000555c:	17fd                	add	a5,a5,-1 # fff <_entry-0x7ffff001>
    8000555e:	94be                	add	s1,s1,a5
    80005560:	7dba                	ld	s11,424(sp)
    80005562:	77fd                	lui	a5,0xfffff
    80005564:	8cfd                	and	s1,s1,a5
	if ((sz1 = uvmalloc(pagetable, sz, sz + 2 * PGSIZE, PTE_W)) == 0)
    80005566:	6a09                	lui	s4,0x2
    80005568:	9a26                	add	s4,s4,s1
	iunlockput(ip);
    8000556a:	854a                	mv	a0,s2
    8000556c:	fffff097          	auipc	ra,0xfffff
    80005570:	a48080e7          	jalr	-1464(ra) # 80003fb4 <iunlockput>
	end_op();
    80005574:	fffff097          	auipc	ra,0xfffff
    80005578:	2d0080e7          	jalr	720(ra) # 80004844 <end_op>
	p = myproc();
    8000557c:	ffffd097          	auipc	ra,0xffffd
    80005580:	874080e7          	jalr	-1932(ra) # 80001df0 <myproc>
    80005584:	8baa                	mv	s7,a0
	if ((sz1 = uvmalloc(pagetable, sz, sz + 2 * PGSIZE, PTE_W)) == 0)
    80005586:	4691                	li	a3,4
    80005588:	8652                	mv	a2,s4
    8000558a:	85a6                	mv	a1,s1
    8000558c:	854e                	mv	a0,s3
	uint64 oldsz = p->sz;
    8000558e:	048bbc03          	ld	s8,72(s7) # 1048 <_entry-0x7fffefb8>
	if ((sz1 = uvmalloc(pagetable, sz, sz + 2 * PGSIZE, PTE_W)) == 0)
    80005592:	ffffc097          	auipc	ra,0xffffc
    80005596:	ffa080e7          	jalr	-6(ra) # 8000158c <uvmalloc>
    8000559a:	8b2a                	mv	s6,a0
    8000559c:	16050f63          	beqz	a0,8000571a <exec+0x3da>
	uvmclear(pagetable, sz - 2 * PGSIZE);
    800055a0:	75f9                	lui	a1,0xffffe
    800055a2:	95aa                	add	a1,a1,a0
    800055a4:	854e                	mv	a0,s3
    800055a6:	ffffc097          	auipc	ra,0xffffc
    800055aa:	2ba080e7          	jalr	698(ra) # 80001860 <uvmclear>
	for (argc = 0; argv[argc]; argc++) {
    800055ae:	e0043783          	ld	a5,-512(s0)
	stackbase = sp - PGSIZE;
    800055b2:	7a7d                	lui	s4,0xfffff
    800055b4:	9a5a                	add	s4,s4,s6
	for (argc = 0; argv[argc]; argc++) {
    800055b6:	6388                	ld	a0,0(a5)
    800055b8:	14050d63          	beqz	a0,80005712 <exec+0x3d2>
    800055bc:	e9040493          	add	s1,s0,-368
    800055c0:	f9040a93          	add	s5,s0,-112
	sp = sz;
    800055c4:	8cda                	mv	s9,s6
	for (argc = 0; argv[argc]; argc++) {
    800055c6:	4901                	li	s2,0
    800055c8:	a011                	j	800055cc <exec+0x28c>
    800055ca:	896a                	mv	s2,s10
		sp -= strlen(argv[argc]) + 1;
    800055cc:	ffffc097          	auipc	ra,0xffffc
    800055d0:	990080e7          	jalr	-1648(ra) # 80000f5c <strlen>
    800055d4:	0015079b          	addw	a5,a0,1
    800055d8:	40fc87b3          	sub	a5,s9,a5
		sp -= sp % 16;/* riscv sp must be 16 - byte aligned */
    800055dc:	ff07fc93          	and	s9,a5,-16
		if (sp < stackbase)
    800055e0:	054ce463          	bltu	s9,s4,80005628 <exec+0x2e8>
		if (copyout(pagetable, sp, argv[argc], strlen(argv[argc]) + 1) < 0)
    800055e4:	e0043783          	ld	a5,-512(s0)
    800055e8:	0007bd03          	ld	s10,0(a5) # fffffffffffff000 <end+0xffffffff7ffdce40>
    800055ec:	856a                	mv	a0,s10
    800055ee:	ffffc097          	auipc	ra,0xffffc
    800055f2:	96e080e7          	jalr	-1682(ra) # 80000f5c <strlen>
    800055f6:	0015069b          	addw	a3,a0,1
    800055fa:	866a                	mv	a2,s10
    800055fc:	85e6                	mv	a1,s9
    800055fe:	854e                	mv	a0,s3
    80005600:	ffffc097          	auipc	ra,0xffffc
    80005604:	2d6080e7          	jalr	726(ra) # 800018d6 <copyout>
    80005608:	02054063          	bltz	a0,80005628 <exec+0x2e8>
	for (argc = 0; argv[argc]; argc++) {
    8000560c:	e0043783          	ld	a5,-512(s0)
		ustack[argc] = sp;
    80005610:	0194b023          	sd	s9,0(s1)
	for (argc = 0; argv[argc]; argc++) {
    80005614:	00190d13          	add	s10,s2,1
    80005618:	6788                	ld	a0,8(a5)
    8000561a:	07a1                	add	a5,a5,8
    8000561c:	e0f43023          	sd	a5,-512(s0)
    80005620:	c515                	beqz	a0,8000564c <exec+0x30c>
		if (argc >= MAXARG)
    80005622:	04a1                	add	s1,s1,8
    80005624:	fb5493e3          	bne	s1,s5,800055ca <exec+0x28a>
		proc_freepagetable(pagetable, sz);
    80005628:	85da                	mv	a1,s6
    8000562a:	854e                	mv	a0,s3
    8000562c:	ffffd097          	auipc	ra,0xffffd
    80005630:	9c6080e7          	jalr	-1594(ra) # 80001ff2 <proc_freepagetable>
	if (ip) {
    80005634:	79be                	ld	s3,488(sp)
    80005636:	7a1e                	ld	s4,480(sp)
    80005638:	6afe                	ld	s5,472(sp)
    8000563a:	6b5e                	ld	s6,464(sp)
    8000563c:	6bbe                	ld	s7,456(sp)
    8000563e:	6c1e                	ld	s8,448(sp)
    80005640:	7cfa                	ld	s9,440(sp)
    80005642:	7d5a                	ld	s10,432(sp)
    80005644:	bdc5                	j	80005534 <exec+0x1f4>
	for (last = s = path; *s; s++)
    80005646:	e0943423          	sd	s1,-504(s0)
    8000564a:	bd65                	j	80005502 <exec+0x1c2>
	sp -= (argc + 1) * sizeof(uint64);
    8000564c:	00290693          	add	a3,s2,2
    80005650:	068e                	sll	a3,a3,0x3
	ustack[argc] = 0;
    80005652:	003d1793          	sll	a5,s10,0x3
    80005656:	f9078793          	add	a5,a5,-112
    8000565a:	97a2                	add	a5,a5,s0
	sp -= (argc + 1) * sizeof(uint64);
    8000565c:	40dc84b3          	sub	s1,s9,a3
	ustack[argc] = 0;
    80005660:	f007b023          	sd	zero,-256(a5)
	sp -= sp % 16;
    80005664:	98c1                	and	s1,s1,-16
	if (sp < stackbase)
    80005666:	fd44e1e3          	bltu	s1,s4,80005628 <exec+0x2e8>
	if (copyout(pagetable, sp, (char *)ustack, (argc + 1) * sizeof(uint64)) < 0)
    8000566a:	e9040613          	add	a2,s0,-368
    8000566e:	85a6                	mv	a1,s1
    80005670:	854e                	mv	a0,s3
    80005672:	ffffc097          	auipc	ra,0xffffc
    80005676:	264080e7          	jalr	612(ra) # 800018d6 <copyout>
    8000567a:	fa0547e3          	bltz	a0,80005628 <exec+0x2e8>
	p->trapframe->a1 = sp;
    8000567e:	058bb783          	ld	a5,88(s7)
	for (last = s = path; *s; s++)
    80005682:	df843583          	ld	a1,-520(s0)
	p->trapframe->a1 = sp;
    80005686:	ffa4                	sd	s1,120(a5)
	for (last = s = path; *s; s++)
    80005688:	0005c783          	lbu	a5,0(a1) # ffffffffffffe000 <end+0xffffffff7ffdbe40>
    8000568c:	cfb5                	beqz	a5,80005708 <exec+0x3c8>
		if (*s == '/')
    8000568e:	02f00713          	li	a4,47
		        last = s + 1;
    80005692:	df843683          	ld	a3,-520(s0)
    80005696:	0685                	add	a3,a3,1
    80005698:	ded43c23          	sd	a3,-520(s0)
		if (*s == '/')
    8000569c:	00e79363          	bne	a5,a4,800056a2 <exec+0x362>
		        last = s + 1;
    800056a0:	85b6                	mv	a1,a3
	for (last = s = path; *s; s++)
    800056a2:	df843783          	ld	a5,-520(s0)
    800056a6:	0007c783          	lbu	a5,0(a5)
    800056aa:	f7e5                	bnez	a5,80005692 <exec+0x352>
	safestrcpy(p->name, last, sizeof(p->name));
    800056ac:	4641                	li	a2,16
    800056ae:	158b8513          	add	a0,s7,344
    800056b2:	ffffc097          	auipc	ra,0xffffc
    800056b6:	874080e7          	jalr	-1932(ra) # 80000f26 <safestrcpy>
	p->trapframe->epc = elf.entry;
    800056ba:	058bb783          	ld	a5,88(s7)
    800056be:	e6843703          	ld	a4,-408(s0)
	oldpagetable = p->pagetable;
    800056c2:	050bb503          	ld	a0,80(s7)
	p->sz = sz;
    800056c6:	056bb423          	sd	s6,72(s7)
	p->pagetable = pagetable;
    800056ca:	053bb823          	sd	s3,80(s7)
	proc_freepagetable(oldpagetable, oldsz);
    800056ce:	85e2                	mv	a1,s8
	p->trapframe->epc = elf.entry;
    800056d0:	ef98                	sd	a4,24(a5)
	p->trapframe->sp = sp;
    800056d2:	fb84                	sd	s1,48(a5)
	proc_freepagetable(oldpagetable, oldsz);
    800056d4:	ffffd097          	auipc	ra,0xffffd
    800056d8:	91e080e7          	jalr	-1762(ra) # 80001ff2 <proc_freepagetable>
	return argc;
    800056dc:	000d051b          	sext.w	a0,s10
    800056e0:	79be                	ld	s3,488(sp)
    800056e2:	7a1e                	ld	s4,480(sp)
    800056e4:	6afe                	ld	s5,472(sp)
    800056e6:	6b5e                	ld	s6,464(sp)
    800056e8:	6bbe                	ld	s7,456(sp)
    800056ea:	6c1e                	ld	s8,448(sp)
    800056ec:	7cfa                	ld	s9,440(sp)
    800056ee:	7d5a                	ld	s10,432(sp)
    800056f0:	b599                	j	80005536 <exec+0x1f6>
			panic("loadseg: address should exist");
    800056f2:	00003517          	auipc	a0,0x3
    800056f6:	31650513          	add	a0,a0,790 # 80008a08 <etext+0xa08>
    800056fa:	ffffb097          	auipc	ra,0xffffb
    800056fe:	e9c080e7          	jalr	-356(ra) # 80000596 <panic>
	for (i = 0, off = elf.phoff; i < elf.phnum; i++, off += sizeof(ph)) {
    80005702:	6a09                	lui	s4,0x2
    80005704:	4481                	li	s1,0
    80005706:	b595                	j	8000556a <exec+0x22a>
	for (last = s = path; *s; s++)
    80005708:	df843583          	ld	a1,-520(s0)
    8000570c:	b745                	j	800056ac <exec+0x36c>
    8000570e:	79be                	ld	s3,488(sp)
    80005710:	bd09                	j	80005522 <exec+0x1e2>
	sp = sz;
    80005712:	8cda                	mv	s9,s6
	for (argc = 0; argv[argc]; argc++) {
    80005714:	46a1                	li	a3,8
    80005716:	4d01                	li	s10,0
    80005718:	bf2d                	j	80005652 <exec+0x312>
		proc_freepagetable(pagetable, sz);
    8000571a:	85a6                	mv	a1,s1
    8000571c:	b739                	j	8000562a <exec+0x2ea>

000000008000571e <create>:
        return -1;
}

static struct inode*
create(char *path, short type, short major, short minor)
{
    8000571e:	715d                	add	sp,sp,-80
    80005720:	e0a2                	sd	s0,64(sp)
    80005722:	f44e                	sd	s3,40(sp)
    80005724:	0880                	add	s0,sp,80
    80005726:	f052                	sd	s4,32(sp)
    80005728:	ec56                	sd	s5,24(sp)
    8000572a:	e486                	sd	ra,72(sp)
    8000572c:	fc26                	sd	s1,56(sp)
    8000572e:	8aae                	mv	s5,a1
        struct inode *ip = nullptr, *dp = nullptr;
        char name[DIRSIZ] = {};

        if((dp = nameiparent(path, name)) == 0)
    80005730:	fb040593          	add	a1,s0,-80
{
    80005734:	8a32                	mv	s4,a2
    80005736:	89b6                	mv	s3,a3
        char name[DIRSIZ] = {};
    80005738:	fa043823          	sd	zero,-80(s0)
    8000573c:	fa042c23          	sw	zero,-72(s0)
    80005740:	fa041e23          	sh	zero,-68(s0)
        if((dp = nameiparent(path, name)) == 0)
    80005744:	fffff097          	auipc	ra,0xfffff
    80005748:	ebe080e7          	jalr	-322(ra) # 80004602 <nameiparent>
    8000574c:	c535                	beqz	a0,800057b8 <create+0x9a>
    8000574e:	f84a                	sd	s2,48(sp)
    80005750:	892a                	mv	s2,a0
                return 0;

        ilock(dp);
    80005752:	ffffe097          	auipc	ra,0xffffe
    80005756:	5f2080e7          	jalr	1522(ra) # 80003d44 <ilock>

        if((ip = dirlookup(dp, name, 0)) != 0){
    8000575a:	4601                	li	a2,0
    8000575c:	fb040593          	add	a1,s0,-80
    80005760:	854a                	mv	a0,s2
    80005762:	fffff097          	auipc	ra,0xfffff
    80005766:	b28080e7          	jalr	-1240(ra) # 8000428a <dirlookup>
    8000576a:	84aa                	mv	s1,a0
    8000576c:	c921                	beqz	a0,800057bc <create+0x9e>
                iunlockput(dp);
    8000576e:	854a                	mv	a0,s2
    80005770:	fffff097          	auipc	ra,0xfffff
    80005774:	844080e7          	jalr	-1980(ra) # 80003fb4 <iunlockput>
                ilock(ip);
    80005778:	8526                	mv	a0,s1
    8000577a:	ffffe097          	auipc	ra,0xffffe
    8000577e:	5ca080e7          	jalr	1482(ra) # 80003d44 <ilock>
                if(type == T_FILE && (ip->type == T_FILE || ip->type == T_DEVICE))
    80005782:	4789                	li	a5,2
    80005784:	02fa9463          	bne	s5,a5,800057ac <create+0x8e>
    80005788:	0444d783          	lhu	a5,68(s1)
    8000578c:	4705                	li	a4,1
    8000578e:	37f9                	addw	a5,a5,-2
    80005790:	17c2                	sll	a5,a5,0x30
    80005792:	93c1                	srl	a5,a5,0x30
    80005794:	00f76c63          	bltu	a4,a5,800057ac <create+0x8e>
    80005798:	7942                	ld	s2,48(sp)
        ip->nlink = 0;
        iupdate(ip);
        iunlockput(ip);
        iunlockput(dp);
        return 0;
}
    8000579a:	60a6                	ld	ra,72(sp)
    8000579c:	6406                	ld	s0,64(sp)
    8000579e:	79a2                	ld	s3,40(sp)
    800057a0:	7a02                	ld	s4,32(sp)
    800057a2:	6ae2                	ld	s5,24(sp)
    800057a4:	8526                	mv	a0,s1
    800057a6:	74e2                	ld	s1,56(sp)
    800057a8:	6161                	add	sp,sp,80
    800057aa:	8082                	ret
                iunlockput(ip);
    800057ac:	8526                	mv	a0,s1
    800057ae:	fffff097          	auipc	ra,0xfffff
    800057b2:	806080e7          	jalr	-2042(ra) # 80003fb4 <iunlockput>
    800057b6:	7942                	ld	s2,48(sp)
                return 0;
    800057b8:	4481                	li	s1,0
    800057ba:	b7c5                	j	8000579a <create+0x7c>
        if((ip = _ialloc(dp->dev, type)) == 0){
    800057bc:	00092503          	lw	a0,0(s2)
    800057c0:	85d6                	mv	a1,s5
    800057c2:	ffffe097          	auipc	ra,0xffffe
    800057c6:	3d8080e7          	jalr	984(ra) # 80003b9a <_ialloc>
    800057ca:	84aa                	mv	s1,a0
    800057cc:	c961                	beqz	a0,8000589c <create+0x17e>
    800057ce:	e85a                	sd	s6,16(sp)
        ilock(ip);
    800057d0:	ffffe097          	auipc	ra,0xffffe
    800057d4:	574080e7          	jalr	1396(ra) # 80003d44 <ilock>
        ip->nlink = 1;
    800057d8:	4b05                	li	s6,1
        ip->major = major;
    800057da:	05449323          	sh	s4,70(s1)
        ip->minor = minor;
    800057de:	05349423          	sh	s3,72(s1)
        ip->nlink = 1;
    800057e2:	05649523          	sh	s6,74(s1)
        iupdate(ip);
    800057e6:	8526                	mv	a0,s1
    800057e8:	ffffe097          	auipc	ra,0xffffe
    800057ec:	490080e7          	jalr	1168(ra) # 80003c78 <iupdate>
                if(dirlink(ip, ".", ip->inum) < 0 || dirlink(ip, "..", dp->inum) < 0)
    800057f0:	40d0                	lw	a2,4(s1)
        if(type == T_DIR){  // Create . and .. entries.
    800057f2:	036a8363          	beq	s5,s6,80005818 <create+0xfa>
        if(dirlink(dp, name, ip->inum) < 0)
    800057f6:	fb040593          	add	a1,s0,-80
    800057fa:	854a                	mv	a0,s2
    800057fc:	fffff097          	auipc	ra,0xfffff
    80005800:	d20080e7          	jalr	-736(ra) # 8000451c <dirlink>
    80005804:	06054763          	bltz	a0,80005872 <create+0x154>
        iunlockput(dp);
    80005808:	854a                	mv	a0,s2
    8000580a:	ffffe097          	auipc	ra,0xffffe
    8000580e:	7aa080e7          	jalr	1962(ra) # 80003fb4 <iunlockput>
        return ip;
    80005812:	7942                	ld	s2,48(sp)
    80005814:	6b42                	ld	s6,16(sp)
    80005816:	b751                	j	8000579a <create+0x7c>
                if(dirlink(ip, ".", ip->inum) < 0 || dirlink(ip, "..", dp->inum) < 0)
    80005818:	00003597          	auipc	a1,0x3
    8000581c:	21058593          	add	a1,a1,528 # 80008a28 <etext+0xa28>
    80005820:	8526                	mv	a0,s1
    80005822:	fffff097          	auipc	ra,0xfffff
    80005826:	cfa080e7          	jalr	-774(ra) # 8000451c <dirlink>
    8000582a:	04054463          	bltz	a0,80005872 <create+0x154>
    8000582e:	00492603          	lw	a2,4(s2)
    80005832:	00003597          	auipc	a1,0x3
    80005836:	1fe58593          	add	a1,a1,510 # 80008a30 <etext+0xa30>
    8000583a:	8526                	mv	a0,s1
    8000583c:	fffff097          	auipc	ra,0xfffff
    80005840:	ce0080e7          	jalr	-800(ra) # 8000451c <dirlink>
    80005844:	02054763          	bltz	a0,80005872 <create+0x154>
        if(dirlink(dp, name, ip->inum) < 0)
    80005848:	40d0                	lw	a2,4(s1)
    8000584a:	fb040593          	add	a1,s0,-80
    8000584e:	854a                	mv	a0,s2
    80005850:	fffff097          	auipc	ra,0xfffff
    80005854:	ccc080e7          	jalr	-820(ra) # 8000451c <dirlink>
    80005858:	00054d63          	bltz	a0,80005872 <create+0x154>
                dp->nlink++;  /* for ".." */
    8000585c:	04a95783          	lhu	a5,74(s2)
                iupdate(dp);
    80005860:	854a                	mv	a0,s2
                dp->nlink++;  /* for ".." */
    80005862:	2785                	addw	a5,a5,1
    80005864:	04f91523          	sh	a5,74(s2)
                iupdate(dp);
    80005868:	ffffe097          	auipc	ra,0xffffe
    8000586c:	410080e7          	jalr	1040(ra) # 80003c78 <iupdate>
    80005870:	bf61                	j	80005808 <create+0xea>
        iupdate(ip);
    80005872:	8526                	mv	a0,s1
        ip->nlink = 0;
    80005874:	04049523          	sh	zero,74(s1)
        iupdate(ip);
    80005878:	ffffe097          	auipc	ra,0xffffe
    8000587c:	400080e7          	jalr	1024(ra) # 80003c78 <iupdate>
        iunlockput(ip);
    80005880:	8526                	mv	a0,s1
    80005882:	ffffe097          	auipc	ra,0xffffe
    80005886:	732080e7          	jalr	1842(ra) # 80003fb4 <iunlockput>
        iunlockput(dp);
    8000588a:	854a                	mv	a0,s2
    8000588c:	ffffe097          	auipc	ra,0xffffe
    80005890:	728080e7          	jalr	1832(ra) # 80003fb4 <iunlockput>
                return 0;
    80005894:	4481                	li	s1,0
        return 0;
    80005896:	7942                	ld	s2,48(sp)
    80005898:	6b42                	ld	s6,16(sp)
    8000589a:	b701                	j	8000579a <create+0x7c>
                iunlockput(dp);
    8000589c:	854a                	mv	a0,s2
    8000589e:	ffffe097          	auipc	ra,0xffffe
    800058a2:	716080e7          	jalr	1814(ra) # 80003fb4 <iunlockput>
                return 0;
    800058a6:	4481                	li	s1,0
                return 0;
    800058a8:	7942                	ld	s2,48(sp)
    800058aa:	bdc5                	j	8000579a <create+0x7c>

00000000800058ac <sys_dup>:
{
    800058ac:	7179                	add	sp,sp,-48
    800058ae:	f022                	sd	s0,32(sp)
    800058b0:	f406                	sd	ra,40(sp)
    800058b2:	1800                	add	s0,sp,48
        argint(n, &fd);
    800058b4:	fdc40593          	add	a1,s0,-36
    800058b8:	4501                	li	a0,0
        int fd = undefined;
    800058ba:	fc042e23          	sw	zero,-36(s0)
        argint(n, &fd);
    800058be:	ffffd097          	auipc	ra,0xffffd
    800058c2:	720080e7          	jalr	1824(ra) # 80002fde <argint>
        if(fd < 0 || fd >= NOFILE || (f=myproc()->ofile[fd]) == 0)
    800058c6:	fdc42703          	lw	a4,-36(s0)
    800058ca:	47bd                	li	a5,15
    800058cc:	04e7e163          	bltu	a5,a4,8000590e <sys_dup+0x62>
    800058d0:	e84a                	sd	s2,16(sp)
    800058d2:	ffffc097          	auipc	ra,0xffffc
    800058d6:	51e080e7          	jalr	1310(ra) # 80001df0 <myproc>
    800058da:	fdc42783          	lw	a5,-36(s0)
    800058de:	07e9                	add	a5,a5,26
    800058e0:	078e                	sll	a5,a5,0x3
    800058e2:	953e                	add	a0,a0,a5
    800058e4:	00053903          	ld	s2,0(a0)
    800058e8:	04090a63          	beqz	s2,8000593c <sys_dup+0x90>
    800058ec:	ec26                	sd	s1,24(sp)
        struct proc *p = myproc();
    800058ee:	ffffc097          	auipc	ra,0xffffc
    800058f2:	502080e7          	jalr	1282(ra) # 80001df0 <myproc>
        for(fd = 0; fd < NOFILE; fd++){
    800058f6:	0d050793          	add	a5,a0,208
    800058fa:	4481                	li	s1,0
    800058fc:	46c1                	li	a3,16
                if(p->ofile[fd] == 0){
    800058fe:	6398                	ld	a4,0(a5)
        for(fd = 0; fd < NOFILE; fd++){
    80005900:	07a1                	add	a5,a5,8
                if(p->ofile[fd] == 0){
    80005902:	cb19                	beqz	a4,80005918 <sys_dup+0x6c>
        for(fd = 0; fd < NOFILE; fd++){
    80005904:	2485                	addw	s1,s1,1
    80005906:	fed49ce3          	bne	s1,a3,800058fe <sys_dup+0x52>
    8000590a:	64e2                	ld	s1,24(sp)
    8000590c:	6942                	ld	s2,16(sp)
                return -1;
    8000590e:	557d                	li	a0,-1
}
    80005910:	70a2                	ld	ra,40(sp)
    80005912:	7402                	ld	s0,32(sp)
    80005914:	6145                	add	sp,sp,48
    80005916:	8082                	ret
                        p->ofile[fd] = f;
    80005918:	01a48793          	add	a5,s1,26
    8000591c:	078e                	sll	a5,a5,0x3
    8000591e:	953e                	add	a0,a0,a5
    80005920:	01253023          	sd	s2,0(a0)
        filedup(f);
    80005924:	854a                	mv	a0,s2
    80005926:	fffff097          	auipc	ra,0xfffff
    8000592a:	308080e7          	jalr	776(ra) # 80004c2e <filedup>
}
    8000592e:	70a2                	ld	ra,40(sp)
    80005930:	7402                	ld	s0,32(sp)
        return fd;
    80005932:	6942                	ld	s2,16(sp)
    80005934:	8526                	mv	a0,s1
    80005936:	64e2                	ld	s1,24(sp)
}
    80005938:	6145                	add	sp,sp,48
    8000593a:	8082                	ret
    8000593c:	6942                	ld	s2,16(sp)
                return -1;
    8000593e:	557d                	li	a0,-1
    80005940:	bfc1                	j	80005910 <sys_dup+0x64>

0000000080005942 <sys_read>:
{
    80005942:	1101                	add	sp,sp,-32
    80005944:	ec06                	sd	ra,24(sp)
    80005946:	e822                	sd	s0,16(sp)
    80005948:	1000                	add	s0,sp,32
        argaddr(1, &p);
    8000594a:	fe840593          	add	a1,s0,-24
    8000594e:	4505                	li	a0,1
        int n = undefined;
    80005950:	fe042023          	sw	zero,-32(s0)
        uint64 p = undefined;
    80005954:	fe043423          	sd	zero,-24(s0)
        argaddr(1, &p);
    80005958:	ffffd097          	auipc	ra,0xffffd
    8000595c:	73e080e7          	jalr	1854(ra) # 80003096 <argaddr>
        argint(2, &n);
    80005960:	fe040593          	add	a1,s0,-32
    80005964:	4509                	li	a0,2
    80005966:	ffffd097          	auipc	ra,0xffffd
    8000596a:	678080e7          	jalr	1656(ra) # 80002fde <argint>
        argint(n, &fd);
    8000596e:	fe440593          	add	a1,s0,-28
    80005972:	4501                	li	a0,0
        int fd = undefined;
    80005974:	fe042223          	sw	zero,-28(s0)
        argint(n, &fd);
    80005978:	ffffd097          	auipc	ra,0xffffd
    8000597c:	666080e7          	jalr	1638(ra) # 80002fde <argint>
        if(fd < 0 || fd >= NOFILE || (f=myproc()->ofile[fd]) == 0)
    80005980:	fe442703          	lw	a4,-28(s0)
    80005984:	47bd                	li	a5,15
    80005986:	02e7e963          	bltu	a5,a4,800059b8 <sys_read+0x76>
    8000598a:	ffffc097          	auipc	ra,0xffffc
    8000598e:	466080e7          	jalr	1126(ra) # 80001df0 <myproc>
    80005992:	fe442783          	lw	a5,-28(s0)
    80005996:	07e9                	add	a5,a5,26
    80005998:	078e                	sll	a5,a5,0x3
    8000599a:	953e                	add	a0,a0,a5
    8000599c:	6108                	ld	a0,0(a0)
    8000599e:	cd09                	beqz	a0,800059b8 <sys_read+0x76>
        return fileread(f, p, n);
    800059a0:	fe042603          	lw	a2,-32(s0)
    800059a4:	fe843583          	ld	a1,-24(s0)
    800059a8:	fffff097          	auipc	ra,0xfffff
    800059ac:	434080e7          	jalr	1076(ra) # 80004ddc <fileread>
}
    800059b0:	60e2                	ld	ra,24(sp)
    800059b2:	6442                	ld	s0,16(sp)
    800059b4:	6105                	add	sp,sp,32
    800059b6:	8082                	ret
                return -1;
    800059b8:	557d                	li	a0,-1
    800059ba:	bfdd                	j	800059b0 <sys_read+0x6e>

00000000800059bc <sys_write>:
{
    800059bc:	1101                	add	sp,sp,-32
    800059be:	ec06                	sd	ra,24(sp)
    800059c0:	e822                	sd	s0,16(sp)
    800059c2:	1000                	add	s0,sp,32
        argaddr(1, &p);
    800059c4:	fe840593          	add	a1,s0,-24
    800059c8:	4505                	li	a0,1
        int n = undefined;
    800059ca:	fe042023          	sw	zero,-32(s0)
        uint64 p = undefined;
    800059ce:	fe043423          	sd	zero,-24(s0)
        argaddr(1, &p);
    800059d2:	ffffd097          	auipc	ra,0xffffd
    800059d6:	6c4080e7          	jalr	1732(ra) # 80003096 <argaddr>
        argint(2, &n);
    800059da:	fe040593          	add	a1,s0,-32
    800059de:	4509                	li	a0,2
    800059e0:	ffffd097          	auipc	ra,0xffffd
    800059e4:	5fe080e7          	jalr	1534(ra) # 80002fde <argint>
        argint(n, &fd);
    800059e8:	fe440593          	add	a1,s0,-28
    800059ec:	4501                	li	a0,0
        int fd = undefined;
    800059ee:	fe042223          	sw	zero,-28(s0)
        argint(n, &fd);
    800059f2:	ffffd097          	auipc	ra,0xffffd
    800059f6:	5ec080e7          	jalr	1516(ra) # 80002fde <argint>
        if(fd < 0 || fd >= NOFILE || (f=myproc()->ofile[fd]) == 0)
    800059fa:	fe442703          	lw	a4,-28(s0)
    800059fe:	47bd                	li	a5,15
    80005a00:	02e7e963          	bltu	a5,a4,80005a32 <sys_write+0x76>
    80005a04:	ffffc097          	auipc	ra,0xffffc
    80005a08:	3ec080e7          	jalr	1004(ra) # 80001df0 <myproc>
    80005a0c:	fe442783          	lw	a5,-28(s0)
    80005a10:	07e9                	add	a5,a5,26
    80005a12:	078e                	sll	a5,a5,0x3
    80005a14:	953e                	add	a0,a0,a5
    80005a16:	6108                	ld	a0,0(a0)
    80005a18:	cd09                	beqz	a0,80005a32 <sys_write+0x76>
        return filewrite(f, p, n);
    80005a1a:	fe042603          	lw	a2,-32(s0)
    80005a1e:	fe843583          	ld	a1,-24(s0)
    80005a22:	fffff097          	auipc	ra,0xfffff
    80005a26:	486080e7          	jalr	1158(ra) # 80004ea8 <filewrite>
}
    80005a2a:	60e2                	ld	ra,24(sp)
    80005a2c:	6442                	ld	s0,16(sp)
    80005a2e:	6105                	add	sp,sp,32
    80005a30:	8082                	ret
                return -1;
    80005a32:	557d                	li	a0,-1
    80005a34:	bfdd                	j	80005a2a <sys_write+0x6e>

0000000080005a36 <sys_close>:
{
    80005a36:	7179                	add	sp,sp,-48
    80005a38:	f022                	sd	s0,32(sp)
    80005a3a:	f406                	sd	ra,40(sp)
    80005a3c:	1800                	add	s0,sp,48
        argint(n, &fd);
    80005a3e:	fdc40593          	add	a1,s0,-36
    80005a42:	4501                	li	a0,0
        int fd = undefined;
    80005a44:	fc042e23          	sw	zero,-36(s0)
        argint(n, &fd);
    80005a48:	ffffd097          	auipc	ra,0xffffd
    80005a4c:	596080e7          	jalr	1430(ra) # 80002fde <argint>
        if(fd < 0 || fd >= NOFILE || (f=myproc()->ofile[fd]) == 0)
    80005a50:	fdc42703          	lw	a4,-36(s0)
    80005a54:	47bd                	li	a5,15
    80005a56:	04e7e663          	bltu	a5,a4,80005aa2 <sys_close+0x6c>
    80005a5a:	ec26                	sd	s1,24(sp)
    80005a5c:	e84a                	sd	s2,16(sp)
    80005a5e:	ffffc097          	auipc	ra,0xffffc
    80005a62:	392080e7          	jalr	914(ra) # 80001df0 <myproc>
    80005a66:	fdc42483          	lw	s1,-36(s0)
    80005a6a:	04e9                	add	s1,s1,26
    80005a6c:	048e                	sll	s1,s1,0x3
    80005a6e:	9526                	add	a0,a0,s1
    80005a70:	00053903          	ld	s2,0(a0)
    80005a74:	02090563          	beqz	s2,80005a9e <sys_close+0x68>
        myproc()->ofile[fd] = 0;
    80005a78:	ffffc097          	auipc	ra,0xffffc
    80005a7c:	378080e7          	jalr	888(ra) # 80001df0 <myproc>
    80005a80:	9526                	add	a0,a0,s1
    80005a82:	00053023          	sd	zero,0(a0)
        fileclose(f);
    80005a86:	854a                	mv	a0,s2
    80005a88:	fffff097          	auipc	ra,0xfffff
    80005a8c:	1f8080e7          	jalr	504(ra) # 80004c80 <fileclose>
        return 0;
    80005a90:	64e2                	ld	s1,24(sp)
    80005a92:	6942                	ld	s2,16(sp)
    80005a94:	4501                	li	a0,0
}
    80005a96:	70a2                	ld	ra,40(sp)
    80005a98:	7402                	ld	s0,32(sp)
    80005a9a:	6145                	add	sp,sp,48
    80005a9c:	8082                	ret
    80005a9e:	64e2                	ld	s1,24(sp)
    80005aa0:	6942                	ld	s2,16(sp)
                return -1;
    80005aa2:	557d                	li	a0,-1
    80005aa4:	bfcd                	j	80005a96 <sys_close+0x60>

0000000080005aa6 <sys_fstat>:
{
    80005aa6:	1101                	add	sp,sp,-32
    80005aa8:	ec06                	sd	ra,24(sp)
    80005aaa:	e822                	sd	s0,16(sp)
    80005aac:	1000                	add	s0,sp,32
        argaddr(1, &st);
    80005aae:	fe840593          	add	a1,s0,-24
    80005ab2:	4505                	li	a0,1
        uint64 st = undefined; /* user pointer to struct stat */
    80005ab4:	fe043423          	sd	zero,-24(s0)
        argaddr(1, &st);
    80005ab8:	ffffd097          	auipc	ra,0xffffd
    80005abc:	5de080e7          	jalr	1502(ra) # 80003096 <argaddr>
        argint(n, &fd);
    80005ac0:	fe440593          	add	a1,s0,-28
    80005ac4:	4501                	li	a0,0
        int fd = undefined;
    80005ac6:	fe042223          	sw	zero,-28(s0)
        argint(n, &fd);
    80005aca:	ffffd097          	auipc	ra,0xffffd
    80005ace:	514080e7          	jalr	1300(ra) # 80002fde <argint>
        if(fd < 0 || fd >= NOFILE || (f=myproc()->ofile[fd]) == 0)
    80005ad2:	fe442703          	lw	a4,-28(s0)
    80005ad6:	47bd                	li	a5,15
    80005ad8:	02e7e763          	bltu	a5,a4,80005b06 <sys_fstat+0x60>
    80005adc:	ffffc097          	auipc	ra,0xffffc
    80005ae0:	314080e7          	jalr	788(ra) # 80001df0 <myproc>
    80005ae4:	fe442783          	lw	a5,-28(s0)
    80005ae8:	07e9                	add	a5,a5,26
    80005aea:	078e                	sll	a5,a5,0x3
    80005aec:	953e                	add	a0,a0,a5
    80005aee:	6108                	ld	a0,0(a0)
    80005af0:	c919                	beqz	a0,80005b06 <sys_fstat+0x60>
        return filestat(f, st);
    80005af2:	fe843583          	ld	a1,-24(s0)
    80005af6:	fffff097          	auipc	ra,0xfffff
    80005afa:	268080e7          	jalr	616(ra) # 80004d5e <filestat>
}
    80005afe:	60e2                	ld	ra,24(sp)
    80005b00:	6442                	ld	s0,16(sp)
    80005b02:	6105                	add	sp,sp,32
    80005b04:	8082                	ret
                return -1;
    80005b06:	557d                	li	a0,-1
    80005b08:	bfdd                	j	80005afe <sys_fstat+0x58>

0000000080005b0a <sys_link>:
{
    80005b0a:	7169                	add	sp,sp,-304
    80005b0c:	f606                	sd	ra,296(sp)
    80005b0e:	f222                	sd	s0,288(sp)
    80005b10:	1a00                	add	s0,sp,304
        char name[DIRSIZ] = {}, new[MAXPATH] = {}, old[MAXPATH] = {};
    80005b12:	08000613          	li	a2,128
    80005b16:	4581                	li	a1,0
    80005b18:	ee040513          	add	a0,s0,-288
    80005b1c:	ec043823          	sd	zero,-304(s0)
    80005b20:	ec042c23          	sw	zero,-296(s0)
    80005b24:	ec041e23          	sh	zero,-292(s0)
    80005b28:	ffffb097          	auipc	ra,0xffffb
    80005b2c:	24c080e7          	jalr	588(ra) # 80000d74 <memset>
    80005b30:	08000613          	li	a2,128
    80005b34:	4581                	li	a1,0
    80005b36:	f6040513          	add	a0,s0,-160
    80005b3a:	ffffb097          	auipc	ra,0xffffb
    80005b3e:	23a080e7          	jalr	570(ra) # 80000d74 <memset>
        if(argstr(0, old, MAXPATH) < 0 || argstr(1, new, MAXPATH) < 0)
    80005b42:	08000613          	li	a2,128
    80005b46:	f6040593          	add	a1,s0,-160
    80005b4a:	4501                	li	a0,0
    80005b4c:	ffffd097          	auipc	ra,0xffffd
    80005b50:	602080e7          	jalr	1538(ra) # 8000314e <argstr>
    80005b54:	10054463          	bltz	a0,80005c5c <sys_link+0x152>
    80005b58:	08000613          	li	a2,128
    80005b5c:	ee040593          	add	a1,s0,-288
    80005b60:	4505                	li	a0,1
    80005b62:	ffffd097          	auipc	ra,0xffffd
    80005b66:	5ec080e7          	jalr	1516(ra) # 8000314e <argstr>
    80005b6a:	0e054963          	bltz	a0,80005c5c <sys_link+0x152>
    80005b6e:	ee26                	sd	s1,280(sp)
        begin_op();
    80005b70:	fffff097          	auipc	ra,0xfffff
    80005b74:	c64080e7          	jalr	-924(ra) # 800047d4 <begin_op>
        if((ip = namei(old)) == 0){
    80005b78:	f6040513          	add	a0,s0,-160
    80005b7c:	fffff097          	auipc	ra,0xfffff
    80005b80:	a5c080e7          	jalr	-1444(ra) # 800045d8 <namei>
    80005b84:	84aa                	mv	s1,a0
    80005b86:	c165                	beqz	a0,80005c66 <sys_link+0x15c>
        ilock(ip);
    80005b88:	ffffe097          	auipc	ra,0xffffe
    80005b8c:	1bc080e7          	jalr	444(ra) # 80003d44 <ilock>
        if(ip->type == T_DIR){
    80005b90:	04449703          	lh	a4,68(s1)
    80005b94:	4785                	li	a5,1
    80005b96:	0cf70e63          	beq	a4,a5,80005c72 <sys_link+0x168>
        ip->nlink++;
    80005b9a:	04a4d783          	lhu	a5,74(s1)
    80005b9e:	ea4a                	sd	s2,272(sp)
        iupdate(ip);
    80005ba0:	8526                	mv	a0,s1
        ip->nlink++;
    80005ba2:	2785                	addw	a5,a5,1
    80005ba4:	04f49523          	sh	a5,74(s1)
        iupdate(ip);
    80005ba8:	ffffe097          	auipc	ra,0xffffe
    80005bac:	0d0080e7          	jalr	208(ra) # 80003c78 <iupdate>
        iunlock(ip);
    80005bb0:	8526                	mv	a0,s1
    80005bb2:	ffffe097          	auipc	ra,0xffffe
    80005bb6:	260080e7          	jalr	608(ra) # 80003e12 <iunlock>
        if((dp = nameiparent(new, name)) == 0)
    80005bba:	ed040593          	add	a1,s0,-304
    80005bbe:	ee040513          	add	a0,s0,-288
    80005bc2:	fffff097          	auipc	ra,0xfffff
    80005bc6:	a40080e7          	jalr	-1472(ra) # 80004602 <nameiparent>
    80005bca:	892a                	mv	s2,a0
    80005bcc:	cd31                	beqz	a0,80005c28 <sys_link+0x11e>
        ilock(dp);
    80005bce:	ffffe097          	auipc	ra,0xffffe
    80005bd2:	176080e7          	jalr	374(ra) # 80003d44 <ilock>
        if(dp->dev != ip->dev || dirlink(dp, name, ip->inum) < 0){
    80005bd6:	00092703          	lw	a4,0(s2)
    80005bda:	409c                	lw	a5,0(s1)
    80005bdc:	04f71163          	bne	a4,a5,80005c1e <sys_link+0x114>
    80005be0:	40d0                	lw	a2,4(s1)
    80005be2:	ed040593          	add	a1,s0,-304
    80005be6:	854a                	mv	a0,s2
    80005be8:	fffff097          	auipc	ra,0xfffff
    80005bec:	934080e7          	jalr	-1740(ra) # 8000451c <dirlink>
    80005bf0:	02054763          	bltz	a0,80005c1e <sys_link+0x114>
        iunlockput(dp);
    80005bf4:	854a                	mv	a0,s2
    80005bf6:	ffffe097          	auipc	ra,0xffffe
    80005bfa:	3be080e7          	jalr	958(ra) # 80003fb4 <iunlockput>
        iput(ip);
    80005bfe:	8526                	mv	a0,s1
    80005c00:	ffffe097          	auipc	ra,0xffffe
    80005c04:	30e080e7          	jalr	782(ra) # 80003f0e <iput>
        end_op();
    80005c08:	fffff097          	auipc	ra,0xfffff
    80005c0c:	c3c080e7          	jalr	-964(ra) # 80004844 <end_op>
}
    80005c10:	70b2                	ld	ra,296(sp)
    80005c12:	7412                	ld	s0,288(sp)
        return 0;
    80005c14:	64f2                	ld	s1,280(sp)
    80005c16:	6952                	ld	s2,272(sp)
    80005c18:	4501                	li	a0,0
}
    80005c1a:	6155                	add	sp,sp,304
    80005c1c:	8082                	ret
                iunlockput(dp);
    80005c1e:	854a                	mv	a0,s2
    80005c20:	ffffe097          	auipc	ra,0xffffe
    80005c24:	394080e7          	jalr	916(ra) # 80003fb4 <iunlockput>
        ilock(ip);
    80005c28:	8526                	mv	a0,s1
    80005c2a:	ffffe097          	auipc	ra,0xffffe
    80005c2e:	11a080e7          	jalr	282(ra) # 80003d44 <ilock>
        ip->nlink--;
    80005c32:	04a4d783          	lhu	a5,74(s1)
        iupdate(ip);
    80005c36:	8526                	mv	a0,s1
        ip->nlink--;
    80005c38:	37fd                	addw	a5,a5,-1
    80005c3a:	04f49523          	sh	a5,74(s1)
        iupdate(ip);
    80005c3e:	ffffe097          	auipc	ra,0xffffe
    80005c42:	03a080e7          	jalr	58(ra) # 80003c78 <iupdate>
        iunlockput(ip);
    80005c46:	8526                	mv	a0,s1
    80005c48:	ffffe097          	auipc	ra,0xffffe
    80005c4c:	36c080e7          	jalr	876(ra) # 80003fb4 <iunlockput>
        end_op();
    80005c50:	fffff097          	auipc	ra,0xfffff
    80005c54:	bf4080e7          	jalr	-1036(ra) # 80004844 <end_op>
        return -1;
    80005c58:	64f2                	ld	s1,280(sp)
    80005c5a:	6952                	ld	s2,272(sp)
}
    80005c5c:	70b2                	ld	ra,296(sp)
    80005c5e:	7412                	ld	s0,288(sp)
                return -1;
    80005c60:	557d                	li	a0,-1
}
    80005c62:	6155                	add	sp,sp,304
    80005c64:	8082                	ret
                end_op();
    80005c66:	fffff097          	auipc	ra,0xfffff
    80005c6a:	bde080e7          	jalr	-1058(ra) # 80004844 <end_op>
    80005c6e:	64f2                	ld	s1,280(sp)
                return -1;
    80005c70:	b7f5                	j	80005c5c <sys_link+0x152>
                iunlockput(ip);
    80005c72:	8526                	mv	a0,s1
    80005c74:	ffffe097          	auipc	ra,0xffffe
    80005c78:	340080e7          	jalr	832(ra) # 80003fb4 <iunlockput>
                end_op();
    80005c7c:	fffff097          	auipc	ra,0xfffff
    80005c80:	bc8080e7          	jalr	-1080(ra) # 80004844 <end_op>
                return -1;
    80005c84:	64f2                	ld	s1,280(sp)
    80005c86:	bfd9                	j	80005c5c <sys_link+0x152>

0000000080005c88 <sys_unlink>:
{
    80005c88:	7151                	add	sp,sp,-240
    80005c8a:	f1a2                	sd	s0,224(sp)
    80005c8c:	f586                	sd	ra,232(sp)
    80005c8e:	1980                	add	s0,sp,240
        char name[DIRSIZ] = {}, path[MAXPATH] = {};
    80005c90:	08000613          	li	a2,128
    80005c94:	4581                	li	a1,0
    80005c96:	f5040513          	add	a0,s0,-176
        struct dirent de = {};
    80005c9a:	f2043823          	sd	zero,-208(s0)
    80005c9e:	f2043c23          	sd	zero,-200(s0)
        char name[DIRSIZ] = {}, path[MAXPATH] = {};
    80005ca2:	f2043023          	sd	zero,-224(s0)
    80005ca6:	f2042423          	sw	zero,-216(s0)
    80005caa:	f2041623          	sh	zero,-212(s0)
    80005cae:	ffffb097          	auipc	ra,0xffffb
    80005cb2:	0c6080e7          	jalr	198(ra) # 80000d74 <memset>
        if(argstr(0, path, MAXPATH) < 0)
    80005cb6:	08000613          	li	a2,128
    80005cba:	f5040593          	add	a1,s0,-176
    80005cbe:	4501                	li	a0,0
        uint off = undefined;
    80005cc0:	f0042e23          	sw	zero,-228(s0)
        if(argstr(0, path, MAXPATH) < 0)
    80005cc4:	ffffd097          	auipc	ra,0xffffd
    80005cc8:	48a080e7          	jalr	1162(ra) # 8000314e <argstr>
    80005ccc:	10054a63          	bltz	a0,80005de0 <sys_unlink+0x158>
    80005cd0:	e5ce                	sd	s3,200(sp)
        begin_op();
    80005cd2:	fffff097          	auipc	ra,0xfffff
    80005cd6:	b02080e7          	jalr	-1278(ra) # 800047d4 <begin_op>
        if((dp = nameiparent(path, name)) == 0){
    80005cda:	f2040593          	add	a1,s0,-224
    80005cde:	f5040513          	add	a0,s0,-176
    80005ce2:	fffff097          	auipc	ra,0xfffff
    80005ce6:	920080e7          	jalr	-1760(ra) # 80004602 <nameiparent>
    80005cea:	89aa                	mv	s3,a0
    80005cec:	14050563          	beqz	a0,80005e36 <sys_unlink+0x1ae>
        ilock(dp);
    80005cf0:	ffffe097          	auipc	ra,0xffffe
    80005cf4:	054080e7          	jalr	84(ra) # 80003d44 <ilock>
        if(namecmp(name, ".") == 0 || namecmp(name, "..") == 0)
    80005cf8:	00003597          	auipc	a1,0x3
    80005cfc:	d3058593          	add	a1,a1,-720 # 80008a28 <etext+0xa28>
    80005d00:	f2040513          	add	a0,s0,-224
    80005d04:	ffffe097          	auipc	ra,0xffffe
    80005d08:	572080e7          	jalr	1394(ra) # 80004276 <namecmp>
    80005d0c:	c161                	beqz	a0,80005dcc <sys_unlink+0x144>
    80005d0e:	00003597          	auipc	a1,0x3
    80005d12:	d2258593          	add	a1,a1,-734 # 80008a30 <etext+0xa30>
    80005d16:	f2040513          	add	a0,s0,-224
    80005d1a:	ffffe097          	auipc	ra,0xffffe
    80005d1e:	55c080e7          	jalr	1372(ra) # 80004276 <namecmp>
    80005d22:	c54d                	beqz	a0,80005dcc <sys_unlink+0x144>
        if((ip = dirlookup(dp, name, &off)) == 0)
    80005d24:	f1c40613          	add	a2,s0,-228
    80005d28:	f2040593          	add	a1,s0,-224
    80005d2c:	854e                	mv	a0,s3
    80005d2e:	eda6                	sd	s1,216(sp)
    80005d30:	ffffe097          	auipc	ra,0xffffe
    80005d34:	55a080e7          	jalr	1370(ra) # 8000428a <dirlookup>
    80005d38:	84aa                	mv	s1,a0
    80005d3a:	c941                	beqz	a0,80005dca <sys_unlink+0x142>
        ilock(ip);
    80005d3c:	ffffe097          	auipc	ra,0xffffe
    80005d40:	008080e7          	jalr	8(ra) # 80003d44 <ilock>
        if(ip->nlink < 1)
    80005d44:	04a49783          	lh	a5,74(s1)
    80005d48:	12f05c63          	blez	a5,80005e80 <sys_unlink+0x1f8>
        if(ip->type == T_DIR && !isdirempty(ip)){
    80005d4c:	04449703          	lh	a4,68(s1)
    80005d50:	4785                	li	a5,1
    80005d52:	08f70963          	beq	a4,a5,80005de4 <sys_unlink+0x15c>
        memset(&de, 0, sizeof(de));
    80005d56:	4641                	li	a2,16
    80005d58:	4581                	li	a1,0
    80005d5a:	f3040513          	add	a0,s0,-208
    80005d5e:	ffffb097          	auipc	ra,0xffffb
    80005d62:	016080e7          	jalr	22(ra) # 80000d74 <memset>
        if(writei(dp, 0, (uint64)&de, off, sizeof(de)) != sizeof(de))
    80005d66:	f1c42683          	lw	a3,-228(s0)
    80005d6a:	4741                	li	a4,16
    80005d6c:	f3040613          	add	a2,s0,-208
    80005d70:	4581                	li	a1,0
    80005d72:	854e                	mv	a0,s3
    80005d74:	ffffe097          	auipc	ra,0xffffe
    80005d78:	3de080e7          	jalr	990(ra) # 80004152 <writei>
    80005d7c:	47c1                	li	a5,16
    80005d7e:	0ef51863          	bne	a0,a5,80005e6e <sys_unlink+0x1e6>
        if(ip->type == T_DIR){
    80005d82:	04449703          	lh	a4,68(s1)
    80005d86:	4785                	li	a5,1
    80005d88:	0af70e63          	beq	a4,a5,80005e44 <sys_unlink+0x1bc>
        iunlockput(dp);
    80005d8c:	854e                	mv	a0,s3
    80005d8e:	ffffe097          	auipc	ra,0xffffe
    80005d92:	226080e7          	jalr	550(ra) # 80003fb4 <iunlockput>
        ip->nlink--;
    80005d96:	04a4d783          	lhu	a5,74(s1)
        iupdate(ip);
    80005d9a:	8526                	mv	a0,s1
        ip->nlink--;
    80005d9c:	37fd                	addw	a5,a5,-1
    80005d9e:	04f49523          	sh	a5,74(s1)
        iupdate(ip);
    80005da2:	ffffe097          	auipc	ra,0xffffe
    80005da6:	ed6080e7          	jalr	-298(ra) # 80003c78 <iupdate>
        iunlockput(ip);
    80005daa:	8526                	mv	a0,s1
    80005dac:	ffffe097          	auipc	ra,0xffffe
    80005db0:	208080e7          	jalr	520(ra) # 80003fb4 <iunlockput>
        end_op();
    80005db4:	fffff097          	auipc	ra,0xfffff
    80005db8:	a90080e7          	jalr	-1392(ra) # 80004844 <end_op>
        return 0;
    80005dbc:	64ee                	ld	s1,216(sp)
    80005dbe:	69ae                	ld	s3,200(sp)
    80005dc0:	4501                	li	a0,0
}
    80005dc2:	70ae                	ld	ra,232(sp)
    80005dc4:	740e                	ld	s0,224(sp)
    80005dc6:	616d                	add	sp,sp,240
    80005dc8:	8082                	ret
    80005dca:	64ee                	ld	s1,216(sp)
        iunlockput(dp);
    80005dcc:	854e                	mv	a0,s3
    80005dce:	ffffe097          	auipc	ra,0xffffe
    80005dd2:	1e6080e7          	jalr	486(ra) # 80003fb4 <iunlockput>
        end_op();
    80005dd6:	fffff097          	auipc	ra,0xfffff
    80005dda:	a6e080e7          	jalr	-1426(ra) # 80004844 <end_op>
        return -1;
    80005dde:	69ae                	ld	s3,200(sp)
                return -1;
    80005de0:	557d                	li	a0,-1
    80005de2:	b7c5                	j	80005dc2 <sys_unlink+0x13a>
        for(off=2*sizeof(de); off<dp->size; off+=sizeof(de)){
    80005de4:	44f8                	lw	a4,76(s1)
        struct dirent de = {};
    80005de6:	f4043023          	sd	zero,-192(s0)
    80005dea:	f4043423          	sd	zero,-184(s0)
        for(off=2*sizeof(de); off<dp->size; off+=sizeof(de)){
    80005dee:	02000793          	li	a5,32
    80005df2:	f6e7f2e3          	bgeu	a5,a4,80005d56 <sys_unlink+0xce>
    80005df6:	e9ca                	sd	s2,208(sp)
                if(readi(dp, 0, (uint64)&de, off, sizeof(de)) != sizeof(de))
    80005df8:	02000913          	li	s2,32
    80005dfc:	a029                	j	80005e06 <sys_unlink+0x17e>
        for(off=2*sizeof(de); off<dp->size; off+=sizeof(de)){
    80005dfe:	44fc                	lw	a5,76(s1)
    80005e00:	2941                	addw	s2,s2,16
    80005e02:	04f97c63          	bgeu	s2,a5,80005e5a <sys_unlink+0x1d2>
                if(readi(dp, 0, (uint64)&de, off, sizeof(de)) != sizeof(de))
    80005e06:	4741                	li	a4,16
    80005e08:	86ca                	mv	a3,s2
    80005e0a:	f4040613          	add	a2,s0,-192
    80005e0e:	4581                	li	a1,0
    80005e10:	8526                	mv	a0,s1
    80005e12:	ffffe097          	auipc	ra,0xffffe
    80005e16:	224080e7          	jalr	548(ra) # 80004036 <readi>
    80005e1a:	47c1                	li	a5,16
    80005e1c:	04f51163          	bne	a0,a5,80005e5e <sys_unlink+0x1d6>
                if(de.inum != 0)
    80005e20:	f4045783          	lhu	a5,-192(s0)
    80005e24:	dfe9                	beqz	a5,80005dfe <sys_unlink+0x176>
                iunlockput(ip);
    80005e26:	8526                	mv	a0,s1
    80005e28:	ffffe097          	auipc	ra,0xffffe
    80005e2c:	18c080e7          	jalr	396(ra) # 80003fb4 <iunlockput>
                goto bad;
    80005e30:	64ee                	ld	s1,216(sp)
    80005e32:	694e                	ld	s2,208(sp)
    80005e34:	bf61                	j	80005dcc <sys_unlink+0x144>
                end_op();
    80005e36:	fffff097          	auipc	ra,0xfffff
    80005e3a:	a0e080e7          	jalr	-1522(ra) # 80004844 <end_op>
                return -1;
    80005e3e:	557d                	li	a0,-1
                end_op();
    80005e40:	69ae                	ld	s3,200(sp)
    80005e42:	b741                	j	80005dc2 <sys_unlink+0x13a>
                dp->nlink--;
    80005e44:	04a9d783          	lhu	a5,74(s3)
                iupdate(dp);
    80005e48:	854e                	mv	a0,s3
                dp->nlink--;
    80005e4a:	37fd                	addw	a5,a5,-1
    80005e4c:	04f99523          	sh	a5,74(s3)
                iupdate(dp);
    80005e50:	ffffe097          	auipc	ra,0xffffe
    80005e54:	e28080e7          	jalr	-472(ra) # 80003c78 <iupdate>
    80005e58:	bf15                	j	80005d8c <sys_unlink+0x104>
    80005e5a:	694e                	ld	s2,208(sp)
    80005e5c:	bded                	j	80005d56 <sys_unlink+0xce>
                        panic("isdirempty: readi");
    80005e5e:	00003517          	auipc	a0,0x3
    80005e62:	bf250513          	add	a0,a0,-1038 # 80008a50 <etext+0xa50>
    80005e66:	ffffa097          	auipc	ra,0xffffa
    80005e6a:	730080e7          	jalr	1840(ra) # 80000596 <panic>
                panic("unlink: writei");
    80005e6e:	00003517          	auipc	a0,0x3
    80005e72:	bfa50513          	add	a0,a0,-1030 # 80008a68 <etext+0xa68>
    80005e76:	e9ca                	sd	s2,208(sp)
    80005e78:	ffffa097          	auipc	ra,0xffffa
    80005e7c:	71e080e7          	jalr	1822(ra) # 80000596 <panic>
                panic("unlink: nlink < 1");
    80005e80:	00003517          	auipc	a0,0x3
    80005e84:	bb850513          	add	a0,a0,-1096 # 80008a38 <etext+0xa38>
    80005e88:	e9ca                	sd	s2,208(sp)
    80005e8a:	ffffa097          	auipc	ra,0xffffa
    80005e8e:	70c080e7          	jalr	1804(ra) # 80000596 <panic>

0000000080005e92 <sys_open>:

uint64
sys_open(void)
{
    80005e92:	7131                	add	sp,sp,-192
    80005e94:	fd06                	sd	ra,184(sp)
    80005e96:	f922                	sd	s0,176(sp)
    80005e98:	0180                	add	s0,sp,192
        char path[MAXPATH] = {};
    80005e9a:	08000613          	li	a2,128
    80005e9e:	4581                	li	a1,0
    80005ea0:	f5040513          	add	a0,s0,-176
    80005ea4:	ffffb097          	auipc	ra,0xffffb
    80005ea8:	ed0080e7          	jalr	-304(ra) # 80000d74 <memset>
        int fd = undefined, omode = undefined;
        struct file *f = nullptr;
        struct inode *ip = nullptr;
        int n = undefined;

        argint(1, &omode);
    80005eac:	f4c40593          	add	a1,s0,-180
    80005eb0:	4505                	li	a0,1
        int fd = undefined, omode = undefined;
    80005eb2:	f4042623          	sw	zero,-180(s0)
        argint(1, &omode);
    80005eb6:	ffffd097          	auipc	ra,0xffffd
    80005eba:	128080e7          	jalr	296(ra) # 80002fde <argint>
        if((n = argstr(0, path, MAXPATH)) < 0)
    80005ebe:	08000613          	li	a2,128
    80005ec2:	f5040593          	add	a1,s0,-176
    80005ec6:	4501                	li	a0,0
    80005ec8:	ffffd097          	auipc	ra,0xffffd
    80005ecc:	286080e7          	jalr	646(ra) # 8000314e <argstr>
    80005ed0:	08054d63          	bltz	a0,80005f6a <sys_open+0xd8>
                return -1;

        begin_op();
    80005ed4:	f14a                	sd	s2,160(sp)
    80005ed6:	fffff097          	auipc	ra,0xfffff
    80005eda:	8fe080e7          	jalr	-1794(ra) # 800047d4 <begin_op>

        if(omode & O_CREATE){
    80005ede:	f4c42783          	lw	a5,-180(s0)
    80005ee2:	2007f793          	and	a5,a5,512
    80005ee6:	e7c1                	bnez	a5,80005f6e <sys_open+0xdc>
                if(ip == 0){
                        end_op();
                        return -1;
                }
        } else {
                if((ip = namei(path)) == 0){
    80005ee8:	f5040513          	add	a0,s0,-176
    80005eec:	ffffe097          	auipc	ra,0xffffe
    80005ef0:	6ec080e7          	jalr	1772(ra) # 800045d8 <namei>
    80005ef4:	892a                	mv	s2,a0
    80005ef6:	12050f63          	beqz	a0,80006034 <sys_open+0x1a2>
                        end_op();
                        return -1;
                }
                ilock(ip);
    80005efa:	ffffe097          	auipc	ra,0xffffe
    80005efe:	e4a080e7          	jalr	-438(ra) # 80003d44 <ilock>
                if(ip->type == T_DIR && omode != O_RDONLY){
    80005f02:	04491783          	lh	a5,68(s2)
    80005f06:	4705                	li	a4,1
    80005f08:	10e78763          	beq	a5,a4,80006016 <sys_open+0x184>
                        end_op();
                        return -1;
                }
        }

        if(ip->type == T_DEVICE && (ip->major < 0 || ip->major >= NDEV)){
    80005f0c:	470d                	li	a4,3
    80005f0e:	00e79763          	bne	a5,a4,80005f1c <sys_open+0x8a>
    80005f12:	04695703          	lhu	a4,70(s2)
    80005f16:	47a5                	li	a5,9
    80005f18:	10e7e263          	bltu	a5,a4,8000601c <sys_open+0x18a>
    80005f1c:	ed4e                	sd	s3,152(sp)
                iunlockput(ip);
                end_op();
                return -1;
        }

        if((f = filealloc()) == 0 || (fd = fdalloc(f)) < 0){
    80005f1e:	fffff097          	auipc	ra,0xfffff
    80005f22:	c9a080e7          	jalr	-870(ra) # 80004bb8 <filealloc>
    80005f26:	89aa                	mv	s3,a0
    80005f28:	c515                	beqz	a0,80005f54 <sys_open+0xc2>
    80005f2a:	f526                	sd	s1,168(sp)
        struct proc *p = myproc();
    80005f2c:	ffffc097          	auipc	ra,0xffffc
    80005f30:	ec4080e7          	jalr	-316(ra) # 80001df0 <myproc>
        for(fd = 0; fd < NOFILE; fd++){
    80005f34:	0d050793          	add	a5,a0,208
    80005f38:	4481                	li	s1,0
    80005f3a:	46c1                	li	a3,16
                if(p->ofile[fd] == 0){
    80005f3c:	6398                	ld	a4,0(a5)
        for(fd = 0; fd < NOFILE; fd++){
    80005f3e:	07a1                	add	a5,a5,8
                if(p->ofile[fd] == 0){
    80005f40:	c729                	beqz	a4,80005f8a <sys_open+0xf8>
        for(fd = 0; fd < NOFILE; fd++){
    80005f42:	2485                	addw	s1,s1,1
    80005f44:	fed49ce3          	bne	s1,a3,80005f3c <sys_open+0xaa>
                if(f)
                        fileclose(f);
    80005f48:	854e                	mv	a0,s3
    80005f4a:	fffff097          	auipc	ra,0xfffff
    80005f4e:	d36080e7          	jalr	-714(ra) # 80004c80 <fileclose>
    80005f52:	74aa                	ld	s1,168(sp)
                iunlockput(ip);
    80005f54:	854a                	mv	a0,s2
    80005f56:	ffffe097          	auipc	ra,0xffffe
    80005f5a:	05e080e7          	jalr	94(ra) # 80003fb4 <iunlockput>
                end_op();
    80005f5e:	fffff097          	auipc	ra,0xfffff
    80005f62:	8e6080e7          	jalr	-1818(ra) # 80004844 <end_op>
                return -1;
    80005f66:	790a                	ld	s2,160(sp)
    80005f68:	69ea                	ld	s3,152(sp)
                return -1;
    80005f6a:	557d                	li	a0,-1
    80005f6c:	a071                	j	80005ff8 <sys_open+0x166>
                ip = create(path, T_FILE, 0, 0);
    80005f6e:	4681                	li	a3,0
    80005f70:	4601                	li	a2,0
    80005f72:	4589                	li	a1,2
    80005f74:	f5040513          	add	a0,s0,-176
    80005f78:	fffff097          	auipc	ra,0xfffff
    80005f7c:	7a6080e7          	jalr	1958(ra) # 8000571e <create>
    80005f80:	892a                	mv	s2,a0
                if(ip == 0){
    80005f82:	c94d                	beqz	a0,80006034 <sys_open+0x1a2>
        if(ip->type == T_DEVICE && (ip->major < 0 || ip->major >= NDEV)){
    80005f84:	04451783          	lh	a5,68(a0)
    80005f88:	b751                	j	80005f0c <sys_open+0x7a>
        } else {
                f->type = FD_INODE;
                f->off = 0;
        }
        f->ip = ip;
        f->readable = !(omode & O_WRONLY);
    80005f8a:	f4c42683          	lw	a3,-180(s0)
                        p->ofile[fd] = f;
    80005f8e:	01a48713          	add	a4,s1,26
    80005f92:	070e                	sll	a4,a4,0x3
        if(ip->type == T_DEVICE){
    80005f94:	04491603          	lh	a2,68(s2)
        f->writable = (omode & O_WRONLY) || (omode & O_RDWR);
    80005f98:	0036f793          	and	a5,a3,3
                        p->ofile[fd] = f;
    80005f9c:	953a                	add	a0,a0,a4
        f->writable = (omode & O_WRONLY) || (omode & O_RDWR);
    80005f9e:	00f037b3          	snez	a5,a5
        f->readable = !(omode & O_WRONLY);
    80005fa2:	fff6c713          	not	a4,a3
    80005fa6:	0087979b          	sllw	a5,a5,0x8
    80005faa:	8b05                	and	a4,a4,1
                        p->ofile[fd] = f;
    80005fac:	01353023          	sd	s3,0(a0)
        if(ip->type == T_DEVICE){
    80005fb0:	458d                	li	a1,3
    80005fb2:	8f5d                	or	a4,a4,a5
    80005fb4:	04b60663          	beq	a2,a1,80006000 <sys_open+0x16e>
                f->off = 0;
    80005fb8:	4789                	li	a5,2
    80005fba:	0209a023          	sw	zero,32(s3)
    80005fbe:	00f9a023          	sw	a5,0(s3)
        f->ip = ip;
    80005fc2:	0129bc23          	sd	s2,24(s3)
        f->readable = !(omode & O_WRONLY);
    80005fc6:	00e99423          	sh	a4,8(s3)

        if((omode & O_TRUNC) && ip->type == T_FILE){
    80005fca:	4006f693          	and	a3,a3,1024
    80005fce:	ca81                	beqz	a3,80005fde <sys_open+0x14c>
    80005fd0:	00f61763          	bne	a2,a5,80005fde <sys_open+0x14c>
                itrunc(ip);
    80005fd4:	854a                	mv	a0,s2
    80005fd6:	ffffe097          	auipc	ra,0xffffe
    80005fda:	e86080e7          	jalr	-378(ra) # 80003e5c <itrunc>
        }

        iunlock(ip);
    80005fde:	854a                	mv	a0,s2
    80005fe0:	ffffe097          	auipc	ra,0xffffe
    80005fe4:	e32080e7          	jalr	-462(ra) # 80003e12 <iunlock>
        end_op();
    80005fe8:	fffff097          	auipc	ra,0xfffff
    80005fec:	85c080e7          	jalr	-1956(ra) # 80004844 <end_op>

        return fd;
    80005ff0:	8526                	mv	a0,s1
    80005ff2:	790a                	ld	s2,160(sp)
    80005ff4:	74aa                	ld	s1,168(sp)
    80005ff6:	69ea                	ld	s3,152(sp)
}
    80005ff8:	70ea                	ld	ra,184(sp)
    80005ffa:	744a                	ld	s0,176(sp)
    80005ffc:	6129                	add	sp,sp,192
    80005ffe:	8082                	ret
                f->major = ip->major;
    80006000:	04695783          	lhu	a5,70(s2)
    80006004:	00c9a023          	sw	a2,0(s3)
        f->ip = ip;
    80006008:	0129bc23          	sd	s2,24(s3)
                f->major = ip->major;
    8000600c:	02f99223          	sh	a5,36(s3)
        f->readable = !(omode & O_WRONLY);
    80006010:	00e99423          	sh	a4,8(s3)
        if((omode & O_TRUNC) && ip->type == T_FILE){
    80006014:	b7e9                	j	80005fde <sys_open+0x14c>
                if(ip->type == T_DIR && omode != O_RDONLY){
    80006016:	f4c42783          	lw	a5,-180(s0)
    8000601a:	d389                	beqz	a5,80005f1c <sys_open+0x8a>
                iunlockput(ip);
    8000601c:	854a                	mv	a0,s2
    8000601e:	ffffe097          	auipc	ra,0xffffe
    80006022:	f96080e7          	jalr	-106(ra) # 80003fb4 <iunlockput>
                end_op();
    80006026:	fffff097          	auipc	ra,0xfffff
    8000602a:	81e080e7          	jalr	-2018(ra) # 80004844 <end_op>
                return -1;
    8000602e:	557d                	li	a0,-1
                return -1;
    80006030:	790a                	ld	s2,160(sp)
    80006032:	b7d9                	j	80005ff8 <sys_open+0x166>
                        end_op();
    80006034:	fffff097          	auipc	ra,0xfffff
    80006038:	810080e7          	jalr	-2032(ra) # 80004844 <end_op>
                return -1;
    8000603c:	557d                	li	a0,-1
                        end_op();
    8000603e:	790a                	ld	s2,160(sp)
    80006040:	bf65                	j	80005ff8 <sys_open+0x166>

0000000080006042 <sys_mkdir>:

uint64
sys_mkdir(void)
{
    80006042:	7175                	add	sp,sp,-144
    80006044:	e506                	sd	ra,136(sp)
    80006046:	e122                	sd	s0,128(sp)
    80006048:	0900                	add	s0,sp,144
        char path[MAXPATH] = {};
    8000604a:	08000613          	li	a2,128
    8000604e:	4581                	li	a1,0
    80006050:	f7040513          	add	a0,s0,-144
    80006054:	ffffb097          	auipc	ra,0xffffb
    80006058:	d20080e7          	jalr	-736(ra) # 80000d74 <memset>
        struct inode *ip = nullptr;

        begin_op();
    8000605c:	ffffe097          	auipc	ra,0xffffe
    80006060:	778080e7          	jalr	1912(ra) # 800047d4 <begin_op>
        if(argstr(0, path, MAXPATH) < 0 || (ip = create(path, T_DIR, 0, 0)) == 0){
    80006064:	08000613          	li	a2,128
    80006068:	f7040593          	add	a1,s0,-144
    8000606c:	4501                	li	a0,0
    8000606e:	ffffd097          	auipc	ra,0xffffd
    80006072:	0e0080e7          	jalr	224(ra) # 8000314e <argstr>
    80006076:	02054963          	bltz	a0,800060a8 <sys_mkdir+0x66>
    8000607a:	4681                	li	a3,0
    8000607c:	4601                	li	a2,0
    8000607e:	4585                	li	a1,1
    80006080:	f7040513          	add	a0,s0,-144
    80006084:	fffff097          	auipc	ra,0xfffff
    80006088:	69a080e7          	jalr	1690(ra) # 8000571e <create>
    8000608c:	cd11                	beqz	a0,800060a8 <sys_mkdir+0x66>
                end_op();
                return -1;
        }
        iunlockput(ip);
    8000608e:	ffffe097          	auipc	ra,0xffffe
    80006092:	f26080e7          	jalr	-218(ra) # 80003fb4 <iunlockput>
        end_op();
    80006096:	ffffe097          	auipc	ra,0xffffe
    8000609a:	7ae080e7          	jalr	1966(ra) # 80004844 <end_op>
        return 0;
}
    8000609e:	60aa                	ld	ra,136(sp)
    800060a0:	640a                	ld	s0,128(sp)
        return 0;
    800060a2:	4501                	li	a0,0
}
    800060a4:	6149                	add	sp,sp,144
    800060a6:	8082                	ret
                end_op();
    800060a8:	ffffe097          	auipc	ra,0xffffe
    800060ac:	79c080e7          	jalr	1948(ra) # 80004844 <end_op>
}
    800060b0:	60aa                	ld	ra,136(sp)
    800060b2:	640a                	ld	s0,128(sp)
                return -1;
    800060b4:	557d                	li	a0,-1
}
    800060b6:	6149                	add	sp,sp,144
    800060b8:	8082                	ret

00000000800060ba <sys_mknod>:

uint64
sys_mknod(void)
{
    800060ba:	7135                	add	sp,sp,-160
    800060bc:	ed06                	sd	ra,152(sp)
    800060be:	e922                	sd	s0,144(sp)
    800060c0:	1100                	add	s0,sp,160
        struct inode *ip = nullptr;
        char path[MAXPATH] = {};
    800060c2:	08000613          	li	a2,128
    800060c6:	4581                	li	a1,0
    800060c8:	f7040513          	add	a0,s0,-144
    800060cc:	ffffb097          	auipc	ra,0xffffb
    800060d0:	ca8080e7          	jalr	-856(ra) # 80000d74 <memset>
        int major = undefined, minor = undefined;
    800060d4:	f6042423          	sw	zero,-152(s0)
    800060d8:	f6042623          	sw	zero,-148(s0)

        begin_op();
    800060dc:	ffffe097          	auipc	ra,0xffffe
    800060e0:	6f8080e7          	jalr	1784(ra) # 800047d4 <begin_op>
        argint(1, &major);
    800060e4:	f6840593          	add	a1,s0,-152
    800060e8:	4505                	li	a0,1
    800060ea:	ffffd097          	auipc	ra,0xffffd
    800060ee:	ef4080e7          	jalr	-268(ra) # 80002fde <argint>
        argint(2, &minor);
    800060f2:	f6c40593          	add	a1,s0,-148
    800060f6:	4509                	li	a0,2
    800060f8:	ffffd097          	auipc	ra,0xffffd
    800060fc:	ee6080e7          	jalr	-282(ra) # 80002fde <argint>
        if((argstr(0, path, MAXPATH)) < 0 ||
    80006100:	08000613          	li	a2,128
    80006104:	f7040593          	add	a1,s0,-144
    80006108:	4501                	li	a0,0
    8000610a:	ffffd097          	auipc	ra,0xffffd
    8000610e:	044080e7          	jalr	68(ra) # 8000314e <argstr>
    80006112:	02054b63          	bltz	a0,80006148 <sys_mknod+0x8e>
                        (ip = create(path, T_DEVICE, major, minor)) == 0){
    80006116:	f6c41683          	lh	a3,-148(s0)
    8000611a:	f6841603          	lh	a2,-152(s0)
    8000611e:	458d                	li	a1,3
    80006120:	f7040513          	add	a0,s0,-144
    80006124:	fffff097          	auipc	ra,0xfffff
    80006128:	5fa080e7          	jalr	1530(ra) # 8000571e <create>
        if((argstr(0, path, MAXPATH)) < 0 ||
    8000612c:	cd11                	beqz	a0,80006148 <sys_mknod+0x8e>
                end_op();
                return -1;
        }
        iunlockput(ip);
    8000612e:	ffffe097          	auipc	ra,0xffffe
    80006132:	e86080e7          	jalr	-378(ra) # 80003fb4 <iunlockput>
        end_op();
    80006136:	ffffe097          	auipc	ra,0xffffe
    8000613a:	70e080e7          	jalr	1806(ra) # 80004844 <end_op>
        return 0;
}
    8000613e:	60ea                	ld	ra,152(sp)
    80006140:	644a                	ld	s0,144(sp)
        return 0;
    80006142:	4501                	li	a0,0
}
    80006144:	610d                	add	sp,sp,160
    80006146:	8082                	ret
                end_op();
    80006148:	ffffe097          	auipc	ra,0xffffe
    8000614c:	6fc080e7          	jalr	1788(ra) # 80004844 <end_op>
}
    80006150:	60ea                	ld	ra,152(sp)
    80006152:	644a                	ld	s0,144(sp)
                return -1;
    80006154:	557d                	li	a0,-1
}
    80006156:	610d                	add	sp,sp,160
    80006158:	8082                	ret

000000008000615a <sys_chdir>:

uint64
sys_chdir(void)
{
    8000615a:	7135                	add	sp,sp,-160
    8000615c:	ed06                	sd	ra,152(sp)
    8000615e:	e922                	sd	s0,144(sp)
    80006160:	e14a                	sd	s2,128(sp)
    80006162:	1100                	add	s0,sp,160
        char path[MAXPATH] = {};
    80006164:	08000613          	li	a2,128
    80006168:	4581                	li	a1,0
    8000616a:	f6040513          	add	a0,s0,-160
    8000616e:	ffffb097          	auipc	ra,0xffffb
    80006172:	c06080e7          	jalr	-1018(ra) # 80000d74 <memset>
        struct inode *ip = nullptr;
        struct proc *p = myproc();
    80006176:	ffffc097          	auipc	ra,0xffffc
    8000617a:	c7a080e7          	jalr	-902(ra) # 80001df0 <myproc>
    8000617e:	892a                	mv	s2,a0

        begin_op();
    80006180:	ffffe097          	auipc	ra,0xffffe
    80006184:	654080e7          	jalr	1620(ra) # 800047d4 <begin_op>
        if(argstr(0, path, MAXPATH) < 0 || (ip = namei(path)) == 0){
    80006188:	08000613          	li	a2,128
    8000618c:	f6040593          	add	a1,s0,-160
    80006190:	4501                	li	a0,0
    80006192:	ffffd097          	auipc	ra,0xffffd
    80006196:	fbc080e7          	jalr	-68(ra) # 8000314e <argstr>
    8000619a:	06054c63          	bltz	a0,80006212 <sys_chdir+0xb8>
    8000619e:	f6040513          	add	a0,s0,-160
    800061a2:	e526                	sd	s1,136(sp)
    800061a4:	ffffe097          	auipc	ra,0xffffe
    800061a8:	434080e7          	jalr	1076(ra) # 800045d8 <namei>
    800061ac:	84aa                	mv	s1,a0
    800061ae:	c12d                	beqz	a0,80006210 <sys_chdir+0xb6>
                end_op();
                return -1;
        }
        ilock(ip);
    800061b0:	ffffe097          	auipc	ra,0xffffe
    800061b4:	b94080e7          	jalr	-1132(ra) # 80003d44 <ilock>
        if(ip->type != T_DIR){
    800061b8:	04449703          	lh	a4,68(s1)
    800061bc:	4785                	li	a5,1
                iunlockput(ip);
    800061be:	8526                	mv	a0,s1
        if(ip->type != T_DIR){
    800061c0:	02f71963          	bne	a4,a5,800061f2 <sys_chdir+0x98>
                end_op();
                return -1;
        }
        iunlock(ip);
    800061c4:	ffffe097          	auipc	ra,0xffffe
    800061c8:	c4e080e7          	jalr	-946(ra) # 80003e12 <iunlock>
        iput(p->cwd);
    800061cc:	15093503          	ld	a0,336(s2)
    800061d0:	ffffe097          	auipc	ra,0xffffe
    800061d4:	d3e080e7          	jalr	-706(ra) # 80003f0e <iput>
        end_op();
    800061d8:	ffffe097          	auipc	ra,0xffffe
    800061dc:	66c080e7          	jalr	1644(ra) # 80004844 <end_op>
        p->cwd = ip;
        return 0;
}
    800061e0:	60ea                	ld	ra,152(sp)
    800061e2:	644a                	ld	s0,144(sp)
        p->cwd = ip;
    800061e4:	14993823          	sd	s1,336(s2)
        return 0;
    800061e8:	4501                	li	a0,0
    800061ea:	64aa                	ld	s1,136(sp)
}
    800061ec:	690a                	ld	s2,128(sp)
    800061ee:	610d                	add	sp,sp,160
    800061f0:	8082                	ret
                iunlockput(ip);
    800061f2:	ffffe097          	auipc	ra,0xffffe
    800061f6:	dc2080e7          	jalr	-574(ra) # 80003fb4 <iunlockput>
                end_op();
    800061fa:	ffffe097          	auipc	ra,0xffffe
    800061fe:	64a080e7          	jalr	1610(ra) # 80004844 <end_op>
    80006202:	64aa                	ld	s1,136(sp)
                return -1;
    80006204:	557d                	li	a0,-1
}
    80006206:	60ea                	ld	ra,152(sp)
    80006208:	644a                	ld	s0,144(sp)
    8000620a:	690a                	ld	s2,128(sp)
    8000620c:	610d                	add	sp,sp,160
    8000620e:	8082                	ret
    80006210:	64aa                	ld	s1,136(sp)
                end_op();
    80006212:	ffffe097          	auipc	ra,0xffffe
    80006216:	632080e7          	jalr	1586(ra) # 80004844 <end_op>
                return -1;
    8000621a:	557d                	li	a0,-1
    8000621c:	b7ed                	j	80006206 <sys_chdir+0xac>

000000008000621e <sys_exec>:

uint64
sys_exec(void)
{
    8000621e:	7121                	add	sp,sp,-448
    80006220:	ff06                	sd	ra,440(sp)
    80006222:	fb22                	sd	s0,432(sp)
    80006224:	0380                	add	s0,sp,448
        char path[MAXPATH] = {}, *argv[MAXARG] = {};
    80006226:	08000613          	li	a2,128
    8000622a:	4581                	li	a1,0
    8000622c:	e5040513          	add	a0,s0,-432
    80006230:	ffffb097          	auipc	ra,0xffffb
    80006234:	b44080e7          	jalr	-1212(ra) # 80000d74 <memset>
    80006238:	10000613          	li	a2,256
    8000623c:	4581                	li	a1,0
    8000623e:	ed040513          	add	a0,s0,-304
    80006242:	ffffb097          	auipc	ra,0xffffb
    80006246:	b32080e7          	jalr	-1230(ra) # 80000d74 <memset>
        int i = undefined;
        uint64 uargv = undefined, uarg = undefined;

        argaddr(1, &uargv);
    8000624a:	e4040593          	add	a1,s0,-448
    8000624e:	4505                	li	a0,1
        uint64 uargv = undefined, uarg = undefined;
    80006250:	e4043023          	sd	zero,-448(s0)
    80006254:	e4043423          	sd	zero,-440(s0)
        argaddr(1, &uargv);
    80006258:	ffffd097          	auipc	ra,0xffffd
    8000625c:	e3e080e7          	jalr	-450(ra) # 80003096 <argaddr>
        if(argstr(0, path, MAXPATH) < 0) {
    80006260:	08000613          	li	a2,128
    80006264:	e5040593          	add	a1,s0,-432
    80006268:	4501                	li	a0,0
    8000626a:	ffffd097          	auipc	ra,0xffffd
    8000626e:	ee4080e7          	jalr	-284(ra) # 8000314e <argstr>
    80006272:	08054a63          	bltz	a0,80006306 <sys_exec+0xe8>
    80006276:	f726                	sd	s1,424(sp)
                return -1;
        }
        memset(argv, 0, sizeof(argv));
    80006278:	10000613          	li	a2,256
    8000627c:	4581                	li	a1,0
    8000627e:	ed040513          	add	a0,s0,-304
    80006282:	ed040493          	add	s1,s0,-304
    80006286:	f34a                	sd	s2,416(sp)
    80006288:	ef4e                	sd	s3,408(sp)
    8000628a:	eb52                	sd	s4,400(sp)
    8000628c:	89a6                	mv	s3,s1
    8000628e:	ffffb097          	auipc	ra,0xffffb
    80006292:	ae6080e7          	jalr	-1306(ra) # 80000d74 <memset>
    80006296:	4901                	li	s2,0
        for(i=0;; i++){
                if(i >= NELEM(argv)){
    80006298:	02000a13          	li	s4,32
                        goto bad;
                }
                if(fetchaddr(uargv+sizeof(uint64)*i, (uint64*)&uarg) < 0){
    8000629c:	e4043783          	ld	a5,-448(s0)
    800062a0:	00391513          	sll	a0,s2,0x3
    800062a4:	e4840593          	add	a1,s0,-440
    800062a8:	953e                	add	a0,a0,a5
    800062aa:	ffffd097          	auipc	ra,0xffffd
    800062ae:	c90080e7          	jalr	-880(ra) # 80002f3a <fetchaddr>
    800062b2:	02054a63          	bltz	a0,800062e6 <sys_exec+0xc8>
                        goto bad;
                }
                if(uarg == 0){
    800062b6:	e4843783          	ld	a5,-440(s0)
    800062ba:	cbb9                	beqz	a5,80006310 <sys_exec+0xf2>
                        argv[i] = 0;
                        break;
                }
                argv[i] = kalloc();
    800062bc:	ffffb097          	auipc	ra,0xffffb
    800062c0:	8aa080e7          	jalr	-1878(ra) # 80000b66 <kalloc>
    800062c4:	00a9b023          	sd	a0,0(s3)
    800062c8:	85aa                	mv	a1,a0
                if(argv[i] == 0)
                        goto bad;
                if(fetchstr(uarg, argv[i], PGSIZE) < 0)
    800062ca:	6605                	lui	a2,0x1
                if(argv[i] == 0)
    800062cc:	cd09                	beqz	a0,800062e6 <sys_exec+0xc8>
                if(fetchstr(uarg, argv[i], PGSIZE) < 0)
    800062ce:	e4843503          	ld	a0,-440(s0)
                if(i >= NELEM(argv)){
    800062d2:	0905                	add	s2,s2,1
                if(fetchstr(uarg, argv[i], PGSIZE) < 0)
    800062d4:	ffffd097          	auipc	ra,0xffffd
    800062d8:	cb4080e7          	jalr	-844(ra) # 80002f88 <fetchstr>
    800062dc:	00054563          	bltz	a0,800062e6 <sys_exec+0xc8>
                if(i >= NELEM(argv)){
    800062e0:	09a1                	add	s3,s3,8
    800062e2:	fb491de3          	bne	s2,s4,8000629c <sys_exec+0x7e>
                kfree(argv[i]);

        return ret;

bad:
        for(i = 0; i < NELEM(argv) && argv[i] != 0; i++)
    800062e6:	fd040913          	add	s2,s0,-48
    800062ea:	a801                	j	800062fa <sys_exec+0xdc>
    800062ec:	04a1                	add	s1,s1,8
                kfree(argv[i]);
    800062ee:	ffffa097          	auipc	ra,0xffffa
    800062f2:	75a080e7          	jalr	1882(ra) # 80000a48 <kfree>
        for(i = 0; i < NELEM(argv) && argv[i] != 0; i++)
    800062f6:	01248463          	beq	s1,s2,800062fe <sys_exec+0xe0>
    800062fa:	6088                	ld	a0,0(s1)
    800062fc:	f965                	bnez	a0,800062ec <sys_exec+0xce>
    800062fe:	74ba                	ld	s1,424(sp)
    80006300:	791a                	ld	s2,416(sp)
    80006302:	69fa                	ld	s3,408(sp)
    80006304:	6a5a                	ld	s4,400(sp)
        return -1;
}
    80006306:	70fa                	ld	ra,440(sp)
    80006308:	745a                	ld	s0,432(sp)
                return -1;
    8000630a:	557d                	li	a0,-1
}
    8000630c:	6139                	add	sp,sp,448
    8000630e:	8082                	ret
                        argv[i] = 0;
    80006310:	0009079b          	sext.w	a5,s2
    80006314:	078e                	sll	a5,a5,0x3
    80006316:	fd078793          	add	a5,a5,-48
    8000631a:	97a2                	add	a5,a5,s0
        int ret = exec(path, argv);
    8000631c:	ed040593          	add	a1,s0,-304
    80006320:	e5040513          	add	a0,s0,-432
                        argv[i] = 0;
    80006324:	f007b023          	sd	zero,-256(a5)
        int ret = exec(path, argv);
    80006328:	fffff097          	auipc	ra,0xfffff
    8000632c:	018080e7          	jalr	24(ra) # 80005340 <exec>
    80006330:	892a                	mv	s2,a0
        for(i = 0; i < NELEM(argv) && argv[i] != 0; i++)
    80006332:	fd040993          	add	s3,s0,-48
    80006336:	a801                	j	80006346 <sys_exec+0x128>
    80006338:	04a1                	add	s1,s1,8
                kfree(argv[i]);
    8000633a:	ffffa097          	auipc	ra,0xffffa
    8000633e:	70e080e7          	jalr	1806(ra) # 80000a48 <kfree>
        for(i = 0; i < NELEM(argv) && argv[i] != 0; i++)
    80006342:	01348463          	beq	s1,s3,8000634a <sys_exec+0x12c>
    80006346:	6088                	ld	a0,0(s1)
    80006348:	f965                	bnez	a0,80006338 <sys_exec+0x11a>
}
    8000634a:	70fa                	ld	ra,440(sp)
    8000634c:	745a                	ld	s0,432(sp)
        return ret;
    8000634e:	74ba                	ld	s1,424(sp)
    80006350:	69fa                	ld	s3,408(sp)
    80006352:	6a5a                	ld	s4,400(sp)
    80006354:	854a                	mv	a0,s2
    80006356:	791a                	ld	s2,416(sp)
}
    80006358:	6139                	add	sp,sp,448
    8000635a:	8082                	ret

000000008000635c <sys_pipe>:

uint64
sys_pipe(void)
{
    8000635c:	7139                	add	sp,sp,-64
    8000635e:	fc06                	sd	ra,56(sp)
    80006360:	f822                	sd	s0,48(sp)
    80006362:	f426                	sd	s1,40(sp)
    80006364:	0080                	add	s0,sp,64
        uint64 fdarray = undefined; // user pointer to array of two integers
    80006366:	fc043423          	sd	zero,-56(s0)
        struct file *rf = nullptr, *wf = nullptr;
    8000636a:	fc043823          	sd	zero,-48(s0)
    8000636e:	fc043c23          	sd	zero,-40(s0)
        int fd0 = undefined, fd1 = undefined;
    80006372:	fc042023          	sw	zero,-64(s0)
    80006376:	fc042223          	sw	zero,-60(s0)
        struct proc *p = myproc();
    8000637a:	ffffc097          	auipc	ra,0xffffc
    8000637e:	a76080e7          	jalr	-1418(ra) # 80001df0 <myproc>

        argaddr(0, &fdarray);
    80006382:	fc840593          	add	a1,s0,-56
        struct proc *p = myproc();
    80006386:	84aa                	mv	s1,a0
        argaddr(0, &fdarray);
    80006388:	4501                	li	a0,0
    8000638a:	ffffd097          	auipc	ra,0xffffd
    8000638e:	d0c080e7          	jalr	-756(ra) # 80003096 <argaddr>
        if(pipealloc(&rf, &wf) < 0)
    80006392:	fd840593          	add	a1,s0,-40
    80006396:	fd040513          	add	a0,s0,-48
    8000639a:	fffff097          	auipc	ra,0xfffff
    8000639e:	c54080e7          	jalr	-940(ra) # 80004fee <pipealloc>
    800063a2:	04054663          	bltz	a0,800063ee <sys_pipe+0x92>
                return -1;
        fd0 = -1;
    800063a6:	57fd                	li	a5,-1
    800063a8:	f04a                	sd	s2,32(sp)
    800063aa:	fcf42023          	sw	a5,-64(s0)
        if((fd0 = fdalloc(rf)) < 0 || (fd1 = fdalloc(wf)) < 0){
    800063ae:	fd043903          	ld	s2,-48(s0)
        struct proc *p = myproc();
    800063b2:	ffffc097          	auipc	ra,0xffffc
    800063b6:	a3e080e7          	jalr	-1474(ra) # 80001df0 <myproc>
        for(fd = 0; fd < NOFILE; fd++){
    800063ba:	0d050713          	add	a4,a0,208
    800063be:	4781                	li	a5,0
    800063c0:	4641                	li	a2,16
                if(p->ofile[fd] == 0){
    800063c2:	6314                	ld	a3,0(a4)
        for(fd = 0; fd < NOFILE; fd++){
    800063c4:	0721                	add	a4,a4,8
                if(p->ofile[fd] == 0){
    800063c6:	ca95                	beqz	a3,800063fa <sys_pipe+0x9e>
        for(fd = 0; fd < NOFILE; fd++){
    800063c8:	2785                	addw	a5,a5,1
    800063ca:	fec79ce3          	bne	a5,a2,800063c2 <sys_pipe+0x66>
        if((fd0 = fdalloc(rf)) < 0 || (fd1 = fdalloc(wf)) < 0){
    800063ce:	57fd                	li	a5,-1
    800063d0:	fcf42023          	sw	a5,-64(s0)
                if(fd0 >= 0)
                        p->ofile[fd0] = 0;
                fileclose(rf);
    800063d4:	fd043503          	ld	a0,-48(s0)
    800063d8:	fffff097          	auipc	ra,0xfffff
    800063dc:	8a8080e7          	jalr	-1880(ra) # 80004c80 <fileclose>
                fileclose(wf);
    800063e0:	fd843503          	ld	a0,-40(s0)
    800063e4:	fffff097          	auipc	ra,0xfffff
    800063e8:	89c080e7          	jalr	-1892(ra) # 80004c80 <fileclose>
    800063ec:	7902                	ld	s2,32(sp)
                fileclose(rf);
                fileclose(wf);
                return -1;
        }
        return 0;
}
    800063ee:	70e2                	ld	ra,56(sp)
    800063f0:	7442                	ld	s0,48(sp)
    800063f2:	74a2                	ld	s1,40(sp)
                return -1;
    800063f4:	557d                	li	a0,-1
}
    800063f6:	6121                	add	sp,sp,64
    800063f8:	8082                	ret
                        p->ofile[fd] = f;
    800063fa:	01a78713          	add	a4,a5,26
    800063fe:	070e                	sll	a4,a4,0x3
    80006400:	953a                	add	a0,a0,a4
    80006402:	01253023          	sd	s2,0(a0)
        if((fd0 = fdalloc(rf)) < 0 || (fd1 = fdalloc(wf)) < 0){
    80006406:	fcf42023          	sw	a5,-64(s0)
    8000640a:	fd843903          	ld	s2,-40(s0)
        struct proc *p = myproc();
    8000640e:	ffffc097          	auipc	ra,0xffffc
    80006412:	9e2080e7          	jalr	-1566(ra) # 80001df0 <myproc>
    80006416:	882a                	mv	a6,a0
        for(fd = 0; fd < NOFILE; fd++){
    80006418:	0d050713          	add	a4,a0,208
    8000641c:	4781                	li	a5,0
    8000641e:	4641                	li	a2,16
                if(p->ofile[fd] == 0){
    80006420:	6314                	ld	a3,0(a4)
        for(fd = 0; fd < NOFILE; fd++){
    80006422:	0721                	add	a4,a4,8
                if(p->ofile[fd] == 0){
    80006424:	c28d                	beqz	a3,80006446 <sys_pipe+0xea>
        for(fd = 0; fd < NOFILE; fd++){
    80006426:	2785                	addw	a5,a5,1
    80006428:	fec79ce3          	bne	a5,a2,80006420 <sys_pipe+0xc4>
                if(fd0 >= 0)
    8000642c:	fc042783          	lw	a5,-64(s0)
        if((fd0 = fdalloc(rf)) < 0 || (fd1 = fdalloc(wf)) < 0){
    80006430:	577d                	li	a4,-1
    80006432:	fce42223          	sw	a4,-60(s0)
                if(fd0 >= 0)
    80006436:	f807cfe3          	bltz	a5,800063d4 <sys_pipe+0x78>
                        p->ofile[fd0] = 0;
    8000643a:	07e9                	add	a5,a5,26
    8000643c:	078e                	sll	a5,a5,0x3
    8000643e:	97a6                	add	a5,a5,s1
    80006440:	0007b023          	sd	zero,0(a5)
    80006444:	bf41                	j	800063d4 <sys_pipe+0x78>
                        p->ofile[fd] = f;
    80006446:	01a78713          	add	a4,a5,26
        if(copyout(p->pagetable, fdarray, (char*)&fd0, sizeof(fd0)) < 0 ||
    8000644a:	68a8                	ld	a0,80(s1)
                        p->ofile[fd] = f;
    8000644c:	070e                	sll	a4,a4,0x3
        if(copyout(p->pagetable, fdarray, (char*)&fd0, sizeof(fd0)) < 0 ||
    8000644e:	fc843583          	ld	a1,-56(s0)
                        p->ofile[fd] = f;
    80006452:	983a                	add	a6,a6,a4
    80006454:	01283023          	sd	s2,0(a6)
        if(copyout(p->pagetable, fdarray, (char*)&fd0, sizeof(fd0)) < 0 ||
    80006458:	4691                	li	a3,4
    8000645a:	fc040613          	add	a2,s0,-64
        if((fd0 = fdalloc(rf)) < 0 || (fd1 = fdalloc(wf)) < 0){
    8000645e:	fcf42223          	sw	a5,-60(s0)
        if(copyout(p->pagetable, fdarray, (char*)&fd0, sizeof(fd0)) < 0 ||
    80006462:	ffffb097          	auipc	ra,0xffffb
    80006466:	474080e7          	jalr	1140(ra) # 800018d6 <copyout>
    8000646a:	02054663          	bltz	a0,80006496 <sys_pipe+0x13a>
                        copyout(p->pagetable, fdarray+sizeof(fd0), (char *)&fd1, sizeof(fd1)) < 0){
    8000646e:	fc843583          	ld	a1,-56(s0)
    80006472:	68a8                	ld	a0,80(s1)
    80006474:	4691                	li	a3,4
    80006476:	fc440613          	add	a2,s0,-60
    8000647a:	0591                	add	a1,a1,4
    8000647c:	ffffb097          	auipc	ra,0xffffb
    80006480:	45a080e7          	jalr	1114(ra) # 800018d6 <copyout>
        if(copyout(p->pagetable, fdarray, (char*)&fd0, sizeof(fd0)) < 0 ||
    80006484:	00054963          	bltz	a0,80006496 <sys_pipe+0x13a>
}
    80006488:	70e2                	ld	ra,56(sp)
    8000648a:	7442                	ld	s0,48(sp)
        return 0;
    8000648c:	7902                	ld	s2,32(sp)
}
    8000648e:	74a2                	ld	s1,40(sp)
        return 0;
    80006490:	4501                	li	a0,0
}
    80006492:	6121                	add	sp,sp,64
    80006494:	8082                	ret
                p->ofile[fd0] = 0;
    80006496:	fc042703          	lw	a4,-64(s0)
                p->ofile[fd1] = 0;
    8000649a:	fc442783          	lw	a5,-60(s0)
                fileclose(rf);
    8000649e:	fd043503          	ld	a0,-48(s0)
                p->ofile[fd0] = 0;
    800064a2:	0769                	add	a4,a4,26
    800064a4:	070e                	sll	a4,a4,0x3
                p->ofile[fd1] = 0;
    800064a6:	07e9                	add	a5,a5,26
                p->ofile[fd0] = 0;
    800064a8:	9726                	add	a4,a4,s1
                p->ofile[fd1] = 0;
    800064aa:	078e                	sll	a5,a5,0x3
                p->ofile[fd0] = 0;
    800064ac:	00073023          	sd	zero,0(a4)
                p->ofile[fd1] = 0;
    800064b0:	97a6                	add	a5,a5,s1
    800064b2:	0007b023          	sd	zero,0(a5)
                fileclose(rf);
    800064b6:	ffffe097          	auipc	ra,0xffffe
    800064ba:	7ca080e7          	jalr	1994(ra) # 80004c80 <fileclose>
                fileclose(wf);
    800064be:	fd843503          	ld	a0,-40(s0)
    800064c2:	ffffe097          	auipc	ra,0xffffe
    800064c6:	7be080e7          	jalr	1982(ra) # 80004c80 <fileclose>
                return -1;
    800064ca:	7902                	ld	s2,32(sp)
    800064cc:	b70d                	j	800063ee <sys_pipe+0x92>
	...

00000000800064d0 <kernelvec>:
    800064d0:	7111                	add	sp,sp,-256
    800064d2:	e006                	sd	ra,0(sp)
    800064d4:	e40a                	sd	sp,8(sp)
    800064d6:	e80e                	sd	gp,16(sp)
    800064d8:	ec12                	sd	tp,24(sp)
    800064da:	f016                	sd	t0,32(sp)
    800064dc:	f41a                	sd	t1,40(sp)
    800064de:	f81e                	sd	t2,48(sp)
    800064e0:	fc22                	sd	s0,56(sp)
    800064e2:	e0a6                	sd	s1,64(sp)
    800064e4:	e4aa                	sd	a0,72(sp)
    800064e6:	e8ae                	sd	a1,80(sp)
    800064e8:	ecb2                	sd	a2,88(sp)
    800064ea:	f0b6                	sd	a3,96(sp)
    800064ec:	f4ba                	sd	a4,104(sp)
    800064ee:	f8be                	sd	a5,112(sp)
    800064f0:	fcc2                	sd	a6,120(sp)
    800064f2:	e146                	sd	a7,128(sp)
    800064f4:	e54a                	sd	s2,136(sp)
    800064f6:	e94e                	sd	s3,144(sp)
    800064f8:	ed52                	sd	s4,152(sp)
    800064fa:	f156                	sd	s5,160(sp)
    800064fc:	f55a                	sd	s6,168(sp)
    800064fe:	f95e                	sd	s7,176(sp)
    80006500:	fd62                	sd	s8,184(sp)
    80006502:	e1e6                	sd	s9,192(sp)
    80006504:	e5ea                	sd	s10,200(sp)
    80006506:	e9ee                	sd	s11,208(sp)
    80006508:	edf2                	sd	t3,216(sp)
    8000650a:	f1f6                	sd	t4,224(sp)
    8000650c:	f5fa                	sd	t5,232(sp)
    8000650e:	f9fe                	sd	t6,240(sp)
    80006510:	95ffc0ef          	jal	80002e6e <kerneltrap>
    80006514:	6082                	ld	ra,0(sp)
    80006516:	6122                	ld	sp,8(sp)
    80006518:	61c2                	ld	gp,16(sp)
    8000651a:	7282                	ld	t0,32(sp)
    8000651c:	7322                	ld	t1,40(sp)
    8000651e:	73c2                	ld	t2,48(sp)
    80006520:	7462                	ld	s0,56(sp)
    80006522:	6486                	ld	s1,64(sp)
    80006524:	6526                	ld	a0,72(sp)
    80006526:	65c6                	ld	a1,80(sp)
    80006528:	6666                	ld	a2,88(sp)
    8000652a:	7686                	ld	a3,96(sp)
    8000652c:	7726                	ld	a4,104(sp)
    8000652e:	77c6                	ld	a5,112(sp)
    80006530:	7866                	ld	a6,120(sp)
    80006532:	688a                	ld	a7,128(sp)
    80006534:	692a                	ld	s2,136(sp)
    80006536:	69ca                	ld	s3,144(sp)
    80006538:	6a6a                	ld	s4,152(sp)
    8000653a:	7a8a                	ld	s5,160(sp)
    8000653c:	7b2a                	ld	s6,168(sp)
    8000653e:	7bca                	ld	s7,176(sp)
    80006540:	7c6a                	ld	s8,184(sp)
    80006542:	6c8e                	ld	s9,192(sp)
    80006544:	6d2e                	ld	s10,200(sp)
    80006546:	6dce                	ld	s11,208(sp)
    80006548:	6e6e                	ld	t3,216(sp)
    8000654a:	7e8e                	ld	t4,224(sp)
    8000654c:	7f2e                	ld	t5,232(sp)
    8000654e:	7fce                	ld	t6,240(sp)
    80006550:	6111                	add	sp,sp,256
    80006552:	10200073          	sret
    80006556:	00000013          	nop
    8000655a:	00000013          	nop
    8000655e:	0001                	nop

0000000080006560 <timervec>:
    80006560:	34051573          	csrrw	a0,mscratch,a0
    80006564:	e10c                	sd	a1,0(a0)
    80006566:	e510                	sd	a2,8(a0)
    80006568:	e914                	sd	a3,16(a0)
    8000656a:	6d0c                	ld	a1,24(a0)
    8000656c:	7110                	ld	a2,32(a0)
    8000656e:	6194                	ld	a3,0(a1)
    80006570:	96b2                	add	a3,a3,a2
    80006572:	e194                	sd	a3,0(a1)
    80006574:	4589                	li	a1,2
    80006576:	14459073          	csrw	sip,a1
    8000657a:	6914                	ld	a3,16(a0)
    8000657c:	6510                	ld	a2,8(a0)
    8000657e:	610c                	ld	a1,0(a0)
    80006580:	34051573          	csrrw	a0,mscratch,a0
    80006584:	30200073          	mret
	...

000000008000658a <plicinit>:
 * the riscv Platform Level Interrupt Controller(PLIC).
 */

void
plicinit(void)
{
    8000658a:	1141                	add	sp,sp,-16
    8000658c:	e422                	sd	s0,8(sp)
    8000658e:	0800                	add	s0,sp,16
	/* 
         * set desired IRQ priorities non - zero(otherwise disabled). 
         */
	*(uint32 *)(PLIC + UART0_IRQ * 4) = 1;
	*(uint32 *)(PLIC + VIRTIO0_IRQ * 4) = 1;
}
    80006590:	6422                	ld	s0,8(sp)
	*(uint32 *)(PLIC + UART0_IRQ * 4) = 1;
    80006592:	4685                	li	a3,1
    80006594:	0c000737          	lui	a4,0xc000
    80006598:	d714                	sw	a3,40(a4)
	*(uint32 *)(PLIC + VIRTIO0_IRQ * 4) = 1;
    8000659a:	0c0007b7          	lui	a5,0xc000
    8000659e:	c3d4                	sw	a3,4(a5)
}
    800065a0:	0141                	add	sp,sp,16
    800065a2:	8082                	ret

00000000800065a4 <plicinithart>:

void
plicinithart(void)
{
    800065a4:	1141                	add	sp,sp,-16
    800065a6:	e022                	sd	s0,0(sp)
    800065a8:	e406                	sd	ra,8(sp)
    800065aa:	0800                	add	s0,sp,16
	int hart = cpuid();
    800065ac:	ffffc097          	auipc	ra,0xffffc
    800065b0:	818080e7          	jalr	-2024(ra) # 80001dc4 <cpuid>

	/*
         * set enable bits for this hart 's S-mode
         * for the uart and virtio disk.
         */
	*(uint32 *)PLIC_SENABLE(hart) = (1 << UART0_IRQ) | (1 << VIRTIO0_IRQ);
    800065b4:	0085171b          	sllw	a4,a0,0x8
    800065b8:	0c0027b7          	lui	a5,0xc002
    800065bc:	97ba                	add	a5,a5,a4
    800065be:	40200713          	li	a4,1026

	/* 
         * set this hart 's S-mode priority threshold to 0. 
         */
	*(uint32 *)PLIC_SPRIORITY(hart) = 0;
}
    800065c2:	60a2                	ld	ra,8(sp)
    800065c4:	6402                	ld	s0,0(sp)
	*(uint32 *)PLIC_SENABLE(hart) = (1 << UART0_IRQ) | (1 << VIRTIO0_IRQ);
    800065c6:	08e7a023          	sw	a4,128(a5) # c002080 <_entry-0x73ffdf80>
	*(uint32 *)PLIC_SPRIORITY(hart) = 0;
    800065ca:	00d5151b          	sllw	a0,a0,0xd
    800065ce:	0c2017b7          	lui	a5,0xc201
    800065d2:	97aa                	add	a5,a5,a0
    800065d4:	0007a023          	sw	zero,0(a5) # c201000 <_entry-0x73dff000>
}
    800065d8:	0141                	add	sp,sp,16
    800065da:	8082                	ret

00000000800065dc <plic_claim>:

/*
 * ask the PLIC what interrupt we should serve.
 */
int
plic_claim(void){
    800065dc:	1141                	add	sp,sp,-16
    800065de:	e022                	sd	s0,0(sp)
    800065e0:	e406                	sd	ra,8(sp)
    800065e2:	0800                	add	s0,sp,16
        int hart = cpuid();
    800065e4:	ffffb097          	auipc	ra,0xffffb
    800065e8:	7e0080e7          	jalr	2016(ra) # 80001dc4 <cpuid>
        int irq = *(uint32 *)PLIC_SCLAIM(hart);
        return irq;
}
    800065ec:	60a2                	ld	ra,8(sp)
    800065ee:	6402                	ld	s0,0(sp)
        int irq = *(uint32 *)PLIC_SCLAIM(hart);
    800065f0:	00d5151b          	sllw	a0,a0,0xd
    800065f4:	0c2017b7          	lui	a5,0xc201
    800065f8:	97aa                	add	a5,a5,a0
}
    800065fa:	43c8                	lw	a0,4(a5)
    800065fc:	0141                	add	sp,sp,16
    800065fe:	8082                	ret

0000000080006600 <plic_complete>:
/*
 * tell the PLIC we 've served this IRQ.
 */
void
plic_complete(int irq)
{
    80006600:	1101                	add	sp,sp,-32
    80006602:	e822                	sd	s0,16(sp)
    80006604:	e426                	sd	s1,8(sp)
    80006606:	ec06                	sd	ra,24(sp)
    80006608:	1000                	add	s0,sp,32
    8000660a:	84aa                	mv	s1,a0
	int hart = cpuid();
    8000660c:	ffffb097          	auipc	ra,0xffffb
    80006610:	7b8080e7          	jalr	1976(ra) # 80001dc4 <cpuid>
	*(uint32 *)PLIC_SCLAIM(hart) = irq;
}
    80006614:	60e2                	ld	ra,24(sp)
    80006616:	6442                	ld	s0,16(sp)
	*(uint32 *)PLIC_SCLAIM(hart) = irq;
    80006618:	00d5179b          	sllw	a5,a0,0xd
    8000661c:	0c201737          	lui	a4,0xc201
    80006620:	97ba                	add	a5,a5,a4
    80006622:	c3c4                	sw	s1,4(a5)
}
    80006624:	64a2                	ld	s1,8(sp)
    80006626:	6105                	add	sp,sp,32
    80006628:	8082                	ret

000000008000662a <free_desc>:
/* 
 * mark a descriptor as free.
 */
static void
free_desc(int i)
{
    8000662a:	1141                	add	sp,sp,-16
    8000662c:	e022                	sd	s0,0(sp)
    8000662e:	e406                	sd	ra,8(sp)
    80006630:	0800                	add	s0,sp,16
	if (i >= NUM)
    80006632:	479d                	li	a5,7
    80006634:	04a7c063          	blt	a5,a0,80006674 <free_desc+0x4a>
		panic("free_desc 1");
	if (disk.free[i])
    80006638:	0001c797          	auipc	a5,0x1c
    8000663c:	a4878793          	add	a5,a5,-1464 # 80022080 <disk>
    80006640:	00a78733          	add	a4,a5,a0
    80006644:	01874683          	lbu	a3,24(a4) # c201018 <_entry-0x73dfefe8>
    80006648:	ee95                	bnez	a3,80006684 <free_desc+0x5a>
		panic("free_desc 2");
	disk.desc[i].addr = 0;
    8000664a:	639c                	ld	a5,0(a5)
    8000664c:	0512                	sll	a0,a0,0x4
    8000664e:	97aa                	add	a5,a5,a0
	disk.desc[i].len = 0;
    80006650:	0007b423          	sd	zero,8(a5)
	disk.desc[i].addr = 0;
    80006654:	0007b023          	sd	zero,0(a5)
	disk.desc[i].flags = 0;
	disk.desc[i].next = 0;
	disk.free[i] = 1;
    80006658:	4785                	li	a5,1
    8000665a:	00f70c23          	sb	a5,24(a4)
	wakeup(&disk.free[0]);
}
    8000665e:	6402                	ld	s0,0(sp)
    80006660:	60a2                	ld	ra,8(sp)
	wakeup(&disk.free[0]);
    80006662:	0001c517          	auipc	a0,0x1c
    80006666:	a3650513          	add	a0,a0,-1482 # 80022098 <disk+0x18>
}
    8000666a:	0141                	add	sp,sp,16
	wakeup(&disk.free[0]);
    8000666c:	ffffc317          	auipc	t1,0xffffc
    80006670:	ffe30067          	jr	-2(t1) # 8000266a <wakeup>
		panic("free_desc 1");
    80006674:	00002517          	auipc	a0,0x2
    80006678:	40450513          	add	a0,a0,1028 # 80008a78 <etext+0xa78>
    8000667c:	ffffa097          	auipc	ra,0xffffa
    80006680:	f1a080e7          	jalr	-230(ra) # 80000596 <panic>
		panic("free_desc 2");
    80006684:	00002517          	auipc	a0,0x2
    80006688:	40450513          	add	a0,a0,1028 # 80008a88 <etext+0xa88>
    8000668c:	ffffa097          	auipc	ra,0xffffa
    80006690:	f0a080e7          	jalr	-246(ra) # 80000596 <panic>

0000000080006694 <virtio_disk_init>:
{
    80006694:	1101                	add	sp,sp,-32
    80006696:	e822                	sd	s0,16(sp)
    80006698:	ec06                	sd	ra,24(sp)
    8000669a:	e426                	sd	s1,8(sp)
    8000669c:	e04a                	sd	s2,0(sp)
    8000669e:	1000                	add	s0,sp,32
	initlock(&disk.vdisk_lock, "virtio_disk");
    800066a0:	00002597          	auipc	a1,0x2
    800066a4:	3f858593          	add	a1,a1,1016 # 80008a98 <etext+0xa98>
    800066a8:	0001c517          	auipc	a0,0x1c
    800066ac:	b0050513          	add	a0,a0,-1280 # 800221a8 <disk+0x128>
    800066b0:	ffffa097          	auipc	ra,0xffffa
    800066b4:	520080e7          	jalr	1312(ra) # 80000bd0 <initlock>
	if (*R(VIRTIO_MMIO_MAGIC_VALUE) != 0x74726976 ||
    800066b8:	100017b7          	lui	a5,0x10001
    800066bc:	4398                	lw	a4,0(a5)
    800066be:	747277b7          	lui	a5,0x74727
    800066c2:	97678793          	add	a5,a5,-1674 # 74726976 <_entry-0xb8d968a>
    800066c6:	16f71363          	bne	a4,a5,8000682c <virtio_disk_init+0x198>
	    *R(VIRTIO_MMIO_VERSION) != 2 ||
    800066ca:	100017b7          	lui	a5,0x10001
    800066ce:	43d8                	lw	a4,4(a5)
	if (*R(VIRTIO_MMIO_MAGIC_VALUE) != 0x74726976 ||
    800066d0:	4609                	li	a2,2
	    *R(VIRTIO_MMIO_VERSION) != 2 ||
    800066d2:	0007069b          	sext.w	a3,a4
	if (*R(VIRTIO_MMIO_MAGIC_VALUE) != 0x74726976 ||
    800066d6:	14c71b63          	bne	a4,a2,8000682c <virtio_disk_init+0x198>
	    *R(VIRTIO_MMIO_DEVICE_ID) != 2 ||
    800066da:	4798                	lw	a4,8(a5)
	    *R(VIRTIO_MMIO_VERSION) != 2 ||
    800066dc:	14d71863          	bne	a4,a3,8000682c <virtio_disk_init+0x198>
	    *R(VIRTIO_MMIO_VENDOR_ID) != 0x554d4551) {
    800066e0:	10001737          	lui	a4,0x10001
    800066e4:	4754                	lw	a3,12(a4)
	    *R(VIRTIO_MMIO_DEVICE_ID) != 2 ||
    800066e6:	554d47b7          	lui	a5,0x554d4
    800066ea:	55178793          	add	a5,a5,1361 # 554d4551 <_entry-0x2ab2baaf>
    800066ee:	12f69f63          	bne	a3,a5,8000682c <virtio_disk_init+0x198>
	*R(VIRTIO_MMIO_STATUS) = status;
    800066f2:	100017b7          	lui	a5,0x10001
    800066f6:	0607a823          	sw	zero,112(a5) # 10001070 <_entry-0x6fffef90>
	*R(VIRTIO_MMIO_STATUS) = status;
    800066fa:	4705                	li	a4,1
    800066fc:	dbb8                	sw	a4,112(a5)
	*R(VIRTIO_MMIO_STATUS) = status;
    800066fe:	470d                	li	a4,3
    80006700:	dbb8                	sw	a4,112(a5)
        uint64 features = *R(VIRTIO_MMIO_DEVICE_FEATURES);
    80006702:	100016b7          	lui	a3,0x10001
    80006706:	4a90                	lw	a2,16(a3)
	features &= ~(1 << VIRTIO_RING_F_INDIRECT_DESC);
    80006708:	c7ffe5b7          	lui	a1,0xc7ffe
    8000670c:	75f58593          	add	a1,a1,1887 # ffffffffc7ffe75f <end+0xffffffff47fdc59f>
	*R(VIRTIO_MMIO_DRIVER_FEATURES) = features;
    80006710:	8e6d                	and	a2,a2,a1
    80006712:	10001737          	lui	a4,0x10001
    80006716:	d310                	sw	a2,32(a4)
	*R(VIRTIO_MMIO_STATUS) = status;
    80006718:	462d                	li	a2,11
    8000671a:	dbb0                	sw	a2,112(a5)
	status = *R(VIRTIO_MMIO_STATUS);
    8000671c:	0707a903          	lw	s2,112(a5)
	if (!(status & VIRTIO_CONFIG_S_FEATURES_OK))
    80006720:	00897793          	and	a5,s2,8
	status = *R(VIRTIO_MMIO_STATUS);
    80006724:	2901                	sext.w	s2,s2
	if (!(status & VIRTIO_CONFIG_S_FEATURES_OK))
    80006726:	12078b63          	beqz	a5,8000685c <virtio_disk_init+0x1c8>
	*R(VIRTIO_MMIO_QUEUE_SEL) = 0;
    8000672a:	100017b7          	lui	a5,0x10001
	if (*R(VIRTIO_MMIO_QUEUE_READY))
    8000672e:	10001737          	lui	a4,0x10001
    80006732:	04470713          	add	a4,a4,68 # 10001044 <_entry-0x6fffefbc>
	*R(VIRTIO_MMIO_QUEUE_SEL) = 0;
    80006736:	0207a823          	sw	zero,48(a5) # 10001030 <_entry-0x6fffefd0>
	if (*R(VIRTIO_MMIO_QUEUE_READY))
    8000673a:	4318                	lw	a4,0(a4)
    8000673c:	12071863          	bnez	a4,8000686c <virtio_disk_init+0x1d8>
        uint32 max = *R(VIRTIO_MMIO_QUEUE_NUM_MAX);
    80006740:	100017b7          	lui	a5,0x10001
    80006744:	5bd8                	lw	a4,52(a5)
    80006746:	0007069b          	sext.w	a3,a4
	if (max == 0)
    8000674a:	10070163          	beqz	a4,8000684c <virtio_disk_init+0x1b8>
	if (max < NUM)
    8000674e:	479d                	li	a5,7
    80006750:	12d7f663          	bgeu	a5,a3,8000687c <virtio_disk_init+0x1e8>
	disk.desc = kalloc();
    80006754:	0001c497          	auipc	s1,0x1c
    80006758:	92c48493          	add	s1,s1,-1748 # 80022080 <disk>
    8000675c:	ffffa097          	auipc	ra,0xffffa
    80006760:	40a080e7          	jalr	1034(ra) # 80000b66 <kalloc>
    80006764:	e088                	sd	a0,0(s1)
	disk.avail = kalloc();
    80006766:	ffffa097          	auipc	ra,0xffffa
    8000676a:	400080e7          	jalr	1024(ra) # 80000b66 <kalloc>
    8000676e:	e488                	sd	a0,8(s1)
	disk.used = kalloc();
    80006770:	ffffa097          	auipc	ra,0xffffa
    80006774:	3f6080e7          	jalr	1014(ra) # 80000b66 <kalloc>
    80006778:	87aa                	mv	a5,a0
	if (!disk.desc || !disk.avail || !disk.used)
    8000677a:	6088                	ld	a0,0(s1)
	disk.used = kalloc();
    8000677c:	e89c                	sd	a5,16(s1)
	if (!disk.desc || !disk.avail || !disk.used)
    8000677e:	cd5d                	beqz	a0,8000683c <virtio_disk_init+0x1a8>
    80006780:	6498                	ld	a4,8(s1)
    80006782:	cf4d                	beqz	a4,8000683c <virtio_disk_init+0x1a8>
    80006784:	cfc5                	beqz	a5,8000683c <virtio_disk_init+0x1a8>
	memset(disk.desc, 0, PGSIZE);
    80006786:	6605                	lui	a2,0x1
    80006788:	4581                	li	a1,0
    8000678a:	ffffa097          	auipc	ra,0xffffa
    8000678e:	5ea080e7          	jalr	1514(ra) # 80000d74 <memset>
	memset(disk.avail, 0, PGSIZE);
    80006792:	6488                	ld	a0,8(s1)
    80006794:	6605                	lui	a2,0x1
    80006796:	4581                	li	a1,0
    80006798:	ffffa097          	auipc	ra,0xffffa
    8000679c:	5dc080e7          	jalr	1500(ra) # 80000d74 <memset>
	memset(disk.used, 0, PGSIZE);
    800067a0:	6888                	ld	a0,16(s1)
    800067a2:	6605                	lui	a2,0x1
    800067a4:	4581                	li	a1,0
    800067a6:	ffffa097          	auipc	ra,0xffffa
    800067aa:	5ce080e7          	jalr	1486(ra) # 80000d74 <memset>
	*R(VIRTIO_MMIO_QUEUE_DESC_LOW) = (uint64) disk.desc;
    800067ae:	6094                	ld	a3,0(s1)
	*R(VIRTIO_MMIO_DRIVER_DESC_LOW) = (uint64) disk.avail;
    800067b0:	6498                	ld	a4,8(s1)
	*R(VIRTIO_MMIO_QUEUE_NUM) = NUM;
    800067b2:	100017b7          	lui	a5,0x10001
    800067b6:	4621                	li	a2,8
    800067b8:	df90                	sw	a2,56(a5)
	*R(VIRTIO_MMIO_QUEUE_DESC_LOW) = (uint64) disk.desc;
    800067ba:	10001837          	lui	a6,0x10001
    800067be:	0006879b          	sext.w	a5,a3
    800067c2:	08f82023          	sw	a5,128(a6) # 10001080 <_entry-0x6fffef80>
	*R(VIRTIO_MMIO_QUEUE_DESC_HIGH) = (uint64) disk.desc >> 32;
    800067c6:	9681                	sra	a3,a3,0x20
	*R(VIRTIO_MMIO_DEVICE_DESC_LOW) = (uint64) disk.used;
    800067c8:	689c                	ld	a5,16(s1)
	*R(VIRTIO_MMIO_QUEUE_DESC_HIGH) = (uint64) disk.desc >> 32;
    800067ca:	10001537          	lui	a0,0x10001
    800067ce:	08d52223          	sw	a3,132(a0) # 10001084 <_entry-0x6fffef7c>
	*R(VIRTIO_MMIO_DRIVER_DESC_LOW) = (uint64) disk.avail;
    800067d2:	100015b7          	lui	a1,0x10001
    800067d6:	0007069b          	sext.w	a3,a4
    800067da:	08d5a823          	sw	a3,144(a1) # 10001090 <_entry-0x6fffef70>
	*R(VIRTIO_MMIO_DRIVER_DESC_HIGH) = (uint64) disk.avail >> 32;
    800067de:	9701                	sra	a4,a4,0x20
    800067e0:	10001637          	lui	a2,0x10001
    800067e4:	08e62a23          	sw	a4,148(a2) # 10001094 <_entry-0x6fffef6c>
	*R(VIRTIO_MMIO_DEVICE_DESC_LOW) = (uint64) disk.used;
    800067e8:	0007889b          	sext.w	a7,a5
    800067ec:	100016b7          	lui	a3,0x10001
    800067f0:	0b16a023          	sw	a7,160(a3) # 100010a0 <_entry-0x6fffef60>
	*R(VIRTIO_MMIO_DEVICE_DESC_HIGH) = (uint64) disk.used >> 32;
    800067f4:	9781                	sra	a5,a5,0x20
    800067f6:	10001737          	lui	a4,0x10001
    800067fa:	0af72223          	sw	a5,164(a4) # 100010a4 <_entry-0x6fffef5c>
	*R(VIRTIO_MMIO_QUEUE_READY) = 0x1;
    800067fe:	100018b7          	lui	a7,0x10001
    80006802:	4785                	li	a5,1
    80006804:	04f8a223          	sw	a5,68(a7) # 10001044 <_entry-0x6fffefbc>
		disk.free[i] = 1;
    80006808:	00001897          	auipc	a7,0x1
    8000680c:	7f88b883          	ld	a7,2040(a7) # 80008000 <etext>
    80006810:	0114bc23          	sd	a7,24(s1)
}
    80006814:	60e2                	ld	ra,24(sp)
    80006816:	6442                	ld	s0,16(sp)
	status |= VIRTIO_CONFIG_S_DRIVER_OK;
    80006818:	00496913          	or	s2,s2,4
	*R(VIRTIO_MMIO_STATUS) = status;
    8000681c:	100017b7          	lui	a5,0x10001
    80006820:	0727a823          	sw	s2,112(a5) # 10001070 <_entry-0x6fffef90>
}
    80006824:	64a2                	ld	s1,8(sp)
    80006826:	6902                	ld	s2,0(sp)
    80006828:	6105                	add	sp,sp,32
    8000682a:	8082                	ret
		panic("could not find virtio disk");
    8000682c:	00002517          	auipc	a0,0x2
    80006830:	27c50513          	add	a0,a0,636 # 80008aa8 <etext+0xaa8>
    80006834:	ffffa097          	auipc	ra,0xffffa
    80006838:	d62080e7          	jalr	-670(ra) # 80000596 <panic>
		panic("virtio disk kalloc");
    8000683c:	00002517          	auipc	a0,0x2
    80006840:	30c50513          	add	a0,a0,780 # 80008b48 <etext+0xb48>
    80006844:	ffffa097          	auipc	ra,0xffffa
    80006848:	d52080e7          	jalr	-686(ra) # 80000596 <panic>
		panic("virtio disk has no queue 0");
    8000684c:	00002517          	auipc	a0,0x2
    80006850:	2bc50513          	add	a0,a0,700 # 80008b08 <etext+0xb08>
    80006854:	ffffa097          	auipc	ra,0xffffa
    80006858:	d42080e7          	jalr	-702(ra) # 80000596 <panic>
		panic("virtio disk FEATURES_OK unset");
    8000685c:	00002517          	auipc	a0,0x2
    80006860:	26c50513          	add	a0,a0,620 # 80008ac8 <etext+0xac8>
    80006864:	ffffa097          	auipc	ra,0xffffa
    80006868:	d32080e7          	jalr	-718(ra) # 80000596 <panic>
		panic("virtio disk should not be ready");
    8000686c:	00002517          	auipc	a0,0x2
    80006870:	27c50513          	add	a0,a0,636 # 80008ae8 <etext+0xae8>
    80006874:	ffffa097          	auipc	ra,0xffffa
    80006878:	d22080e7          	jalr	-734(ra) # 80000596 <panic>
		panic("virtio disk max queue too short");
    8000687c:	00002517          	auipc	a0,0x2
    80006880:	2ac50513          	add	a0,a0,684 # 80008b28 <etext+0xb28>
    80006884:	ffffa097          	auipc	ra,0xffffa
    80006888:	d12080e7          	jalr	-750(ra) # 80000596 <panic>

000000008000688c <virtio_disk_rw>:
	return 0;
}

void
virtio_disk_rw(struct buf *b, int write)
{
    8000688c:	7159                	add	sp,sp,-112
    8000688e:	f0a2                	sd	s0,96(sp)
    80006890:	eca6                	sd	s1,88(sp)
    80006892:	e8ca                	sd	s2,80(sp)
    80006894:	e4ce                	sd	s3,72(sp)
    80006896:	e0d2                	sd	s4,64(sp)
    80006898:	fc56                	sd	s5,56(sp)
    8000689a:	f85a                	sd	s6,48(sp)
    8000689c:	f45e                	sd	s7,40(sp)
    8000689e:	f062                	sd	s8,32(sp)
    800068a0:	ec66                	sd	s9,24(sp)
    800068a2:	f486                	sd	ra,104(sp)
    800068a4:	e86a                	sd	s10,16(sp)
    800068a6:	1880                	add	s0,sp,112
	uint64 sector = b->blockno * (BSIZE / 512);
    800068a8:	455c                	lw	a5,12(a0)
{
    800068aa:	892a                	mv	s2,a0

	acquire(&disk.vdisk_lock);
    800068ac:	0001c517          	auipc	a0,0x1c
    800068b0:	8fc50513          	add	a0,a0,-1796 # 800221a8 <disk+0x128>
	uint64 sector = b->blockno * (BSIZE / 512);
    800068b4:	0017979b          	sllw	a5,a5,0x1
    800068b8:	02079b93          	sll	s7,a5,0x20
{
    800068bc:	8b2e                	mv	s6,a1
	uint64 sector = b->blockno * (BSIZE / 512);
    800068be:	020bdb93          	srl	s7,s7,0x20
	acquire(&disk.vdisk_lock);
    800068c2:	ffffa097          	auipc	ra,0xffffa
    800068c6:	39e080e7          	jalr	926(ra) # 80000c60 <acquire>
    800068ca:	0001b497          	auipc	s1,0x1b
    800068ce:	7b648493          	add	s1,s1,1974 # 80022080 <disk>
	for (int i = 0; i < NUM; i++) {
    800068d2:	4ca1                	li	s9,8
	for (int i = 0; i < 3; i++) {
    800068d4:	498d                	li	s3,3
		idx[i] = alloc_desc();
    800068d6:	5a7d                	li	s4,-1
			for (int j = 0; j < i; j++)
    800068d8:	4c09                	li	s8,2
	int idx[3];
	while (1) {
		if (alloc3_desc(idx) == 0) {
			break;
		}
		sleep(&disk.free[0], &disk.vdisk_lock);
    800068da:	0001ca97          	auipc	s5,0x1c
    800068de:	8cea8a93          	add	s5,s5,-1842 # 800221a8 <disk+0x128>
	for (int i = 0; i < 3; i++) {
    800068e2:	f9040613          	add	a2,s0,-112
    800068e6:	4d01                	li	s10,0
	for (int i = 0; i < NUM; i++) {
    800068e8:	0001b717          	auipc	a4,0x1b
    800068ec:	79870713          	add	a4,a4,1944 # 80022080 <disk>
    800068f0:	4781                	li	a5,0
		if (disk.free[i]) {
    800068f2:	01874683          	lbu	a3,24(a4)
	for (int i = 0; i < NUM; i++) {
    800068f6:	0705                	add	a4,a4,1
		if (disk.free[i]) {
    800068f8:	e2a1                	bnez	a3,80006938 <virtio_disk_rw+0xac>
	for (int i = 0; i < NUM; i++) {
    800068fa:	2785                	addw	a5,a5,1
    800068fc:	ff979be3          	bne	a5,s9,800068f2 <virtio_disk_rw+0x66>
		idx[i] = alloc_desc();
    80006900:	01462023          	sw	s4,0(a2)
			for (int j = 0; j < i; j++)
    80006904:	020d0063          	beqz	s10,80006924 <virtio_disk_rw+0x98>
				free_desc(idx[j]);
    80006908:	f9042503          	lw	a0,-112(s0)
    8000690c:	00000097          	auipc	ra,0x0
    80006910:	d1e080e7          	jalr	-738(ra) # 8000662a <free_desc>
			for (int j = 0; j < i; j++)
    80006914:	018d1863          	bne	s10,s8,80006924 <virtio_disk_rw+0x98>
				free_desc(idx[j]);
    80006918:	f9442503          	lw	a0,-108(s0)
    8000691c:	00000097          	auipc	ra,0x0
    80006920:	d0e080e7          	jalr	-754(ra) # 8000662a <free_desc>
		sleep(&disk.free[0], &disk.vdisk_lock);
    80006924:	85d6                	mv	a1,s5
    80006926:	0001b517          	auipc	a0,0x1b
    8000692a:	77250513          	add	a0,a0,1906 # 80022098 <disk+0x18>
    8000692e:	ffffc097          	auipc	ra,0xffffc
    80006932:	cc0080e7          	jalr	-832(ra) # 800025ee <sleep>
		if (alloc3_desc(idx) == 0) {
    80006936:	b775                	j	800068e2 <virtio_disk_rw+0x56>
			disk.free[i] = 0;
    80006938:	00f48733          	add	a4,s1,a5
		idx[i] = alloc_desc();
    8000693c:	c21c                	sw	a5,0(a2)
			disk.free[i] = 0;
    8000693e:	00070c23          	sb	zero,24(a4)
	for (int i = 0; i < 3; i++) {
    80006942:	2d05                	addw	s10,s10,1 # 1001 <_entry-0x7fffefff>
    80006944:	0611                	add	a2,a2,4
    80006946:	fb3d11e3          	bne	s10,s3,800068e8 <virtio_disk_rw+0x5c>
	}

	/* format the three descriptors */
	/* qemu's virtio-blk.c reads them. */

	struct virtio_blk_req *buf0 = &disk.ops[idx[0]];
    8000694a:	f9042803          	lw	a6,-112(s0)
		buf0->type = VIRTIO_BLK_T_IN;
	//read the disk
	    buf0->reserved = 0;
	buf0->sector = sector;

	disk.desc[idx[0]].addr = (uint64) buf0;
    8000694e:	6090                	ld	a2,0(s1)
	disk.desc[idx[0]].len = sizeof(struct virtio_blk_req);
	disk.desc[idx[0]].flags = VRING_DESC_F_NEXT;
	disk.desc[idx[0]].next = idx[1];
    80006950:	f9442e83          	lw	t4,-108(s0)
    80006954:	00a80693          	add	a3,a6,10
	/* device reads b->data */
	else
		disk.desc[idx[1]].flags = VRING_DESC_F_WRITE;
	/* device writes b->data */
	disk.desc[idx[1]].flags |= VRING_DESC_F_NEXT;
	disk.desc[idx[1]].next = idx[2];
    80006958:	f9842883          	lw	a7,-104(s0)
    8000695c:	00481793          	sll	a5,a6,0x4
	if (write)
    80006960:	0692                	sll	a3,a3,0x4
    80006962:	96a6                	add	a3,a3,s1
	if (write)
    80006964:	001b3713          	seqz	a4,s6
	struct virtio_blk_req *buf0 = &disk.ops[idx[0]];
    80006968:	0a878e13          	add	t3,a5,168
	if (write)
    8000696c:	01603b33          	snez	s6,s6
    80006970:	0166a423          	sw	s6,8(a3)
	    buf0->reserved = 0;
    80006974:	0006a623          	sw	zero,12(a3)
	buf0->sector = sector;
    80006978:	0176b823          	sd	s7,16(a3)
	disk.desc[idx[0]].addr = (uint64) buf0;
    8000697c:	00f605b3          	add	a1,a2,a5
	struct virtio_blk_req *buf0 = &disk.ops[idx[0]];
    80006980:	9e26                	add	t3,t3,s1
	if (write)
    80006982:	0017171b          	sllw	a4,a4,0x1
	disk.desc[idx[0]].addr = (uint64) buf0;
    80006986:	01c5b023          	sd	t3,0(a1)
	disk.desc[idx[0]].flags = VRING_DESC_F_NEXT;
    8000698a:	4305                	li	t1,1
	disk.desc[idx[1]].flags |= VRING_DESC_F_NEXT;
    8000698c:	01089f1b          	sllw	t5,a7,0x10
	disk.desc[idx[1]].addr = (uint64) b->data;
    80006990:	004e9513          	sll	a0,t4,0x4
	disk.desc[idx[0]].len = sizeof(struct virtio_blk_req);
    80006994:	4e41                	li	t3,16
	disk.desc[idx[1]].flags |= VRING_DESC_F_NEXT;
    80006996:	00176713          	or	a4,a4,1
	disk.desc[idx[0]].len = sizeof(struct virtio_blk_req);
    8000699a:	01c5a423          	sw	t3,8(a1)
	disk.desc[idx[0]].flags = VRING_DESC_F_NEXT;
    8000699e:	00659623          	sh	t1,12(a1)
	disk.desc[idx[0]].next = idx[1];
    800069a2:	01d59723          	sh	t4,14(a1)
	disk.desc[idx[1]].addr = (uint64) b->data;
    800069a6:	9532                	add	a0,a0,a2
	disk.desc[idx[1]].flags |= VRING_DESC_F_NEXT;
    800069a8:	01e76733          	or	a4,a4,t5

	disk.info[idx[0]].status = 0xff;
    800069ac:	00280693          	add	a3,a6,2
	disk.desc[idx[1]].flags |= VRING_DESC_F_NEXT;
    800069b0:	c558                	sw	a4,12(a0)
	disk.desc[idx[1]].addr = (uint64) b->data;
    800069b2:	05890e13          	add	t3,s2,88
	disk.info[idx[0]].status = 0xff;
    800069b6:	0692                	sll	a3,a3,0x4
	disk.desc[idx[1]].len = BSIZE;
    800069b8:	40000713          	li	a4,1024
	/* device writes 0 on success */
	disk.desc[idx[2]].addr = (uint64) & disk.info[idx[0]].status;
	disk.desc[idx[2]].len = 1;
    800069bc:	4585                	li	a1,1
	disk.desc[idx[1]].len = BSIZE;
    800069be:	c518                	sw	a4,8(a0)
	disk.desc[idx[1]].addr = (uint64) b->data;
    800069c0:	01c53023          	sd	t3,0(a0)
	disk.info[idx[0]].status = 0xff;
    800069c4:	00d48733          	add	a4,s1,a3
	disk.desc[idx[2]].addr = (uint64) & disk.info[idx[0]].status;
    800069c8:	0892                	sll	a7,a7,0x4
	disk.info[idx[0]].status = 0xff;
    800069ca:	56fd                	li	a3,-1
	disk.desc[idx[2]].len = 1;
    800069cc:	1586                	sll	a1,a1,0x21
	disk.info[idx[0]].status = 0xff;
    800069ce:	00d70823          	sb	a3,16(a4)
	disk.desc[idx[2]].addr = (uint64) & disk.info[idx[0]].status;
    800069d2:	9646                	add	a2,a2,a7
	disk.desc[idx[2]].len = 1;
    800069d4:	0585                	add	a1,a1,1
    800069d6:	e60c                	sd	a1,8(a2)
	/* record struct buf for virtio_disk_intr() */
	b->disk = 1;
	disk.info[idx[0]].b = b;

	/* tell the device the first index in our chain of descriptors */
	disk.avail->ring[disk.avail->idx % NUM] = idx[0];
    800069d8:	648c                	ld	a1,8(s1)
	disk.desc[idx[2]].addr = (uint64) & disk.info[idx[0]].status;
    800069da:	03078793          	add	a5,a5,48
    800069de:	97a6                	add	a5,a5,s1
	disk.avail->ring[disk.avail->idx % NUM] = idx[0];
    800069e0:	0025d683          	lhu	a3,2(a1)
	disk.desc[idx[2]].addr = (uint64) & disk.info[idx[0]].status;
    800069e4:	e21c                	sd	a5,0(a2)
	b->disk = 1;
    800069e6:	00692223          	sw	t1,4(s2)
	disk.avail->ring[disk.avail->idx % NUM] = idx[0];
    800069ea:	0076f793          	and	a5,a3,7
    800069ee:	0786                	sll	a5,a5,0x1
	disk.info[idx[0]].b = b;
    800069f0:	01273423          	sd	s2,8(a4)
	disk.avail->ring[disk.avail->idx % NUM] = idx[0];
    800069f4:	95be                	add	a1,a1,a5
    800069f6:	01059223          	sh	a6,4(a1)

	__sync_synchronize();
    800069fa:	0ff0000f          	fence

	/* tell the device another avail ring entry is available */
	disk.avail->idx += 1;
    800069fe:	6498                	ld	a4,8(s1)
    80006a00:	00275783          	lhu	a5,2(a4)
    80006a04:	2785                	addw	a5,a5,1
    80006a06:	00f71123          	sh	a5,2(a4)
	//not % NUM...

	__sync_synchronize();
    80006a0a:	0ff0000f          	fence

	*R(VIRTIO_MMIO_QUEUE_NOTIFY) = 0;
    80006a0e:	100017b7          	lui	a5,0x10001
    80006a12:	0407a823          	sw	zero,80(a5) # 10001050 <_entry-0x6fffefb0>
	//value is the queue number

	/* Wait for virtio_disk_intr() to say the request has finished */
	    while (b->disk == 1) {
    80006a16:	00492703          	lw	a4,4(s2)
		sleep(b, &disk.vdisk_lock);
    80006a1a:	0001ba17          	auipc	s4,0x1b
    80006a1e:	78ea0a13          	add	s4,s4,1934 # 800221a8 <disk+0x128>
	    while (b->disk == 1) {
    80006a22:	4985                	li	s3,1
    80006a24:	00671c63          	bne	a4,t1,80006a3c <virtio_disk_rw+0x1b0>
		sleep(b, &disk.vdisk_lock);
    80006a28:	85d2                	mv	a1,s4
    80006a2a:	854a                	mv	a0,s2
    80006a2c:	ffffc097          	auipc	ra,0xffffc
    80006a30:	bc2080e7          	jalr	-1086(ra) # 800025ee <sleep>
	    while (b->disk == 1) {
    80006a34:	00492783          	lw	a5,4(s2)
    80006a38:	ff3788e3          	beq	a5,s3,80006a28 <virtio_disk_rw+0x19c>
	}

	disk.info[idx[0]].b = 0;
    80006a3c:	f9042903          	lw	s2,-112(s0)
    80006a40:	00290793          	add	a5,s2,2
    80006a44:	0792                	sll	a5,a5,0x4
    80006a46:	97a6                	add	a5,a5,s1
    80006a48:	0007b423          	sd	zero,8(a5)
		int flag = disk.desc[i].flags;
    80006a4c:	609c                	ld	a5,0(s1)
    80006a4e:	00491713          	sll	a4,s2,0x4
    80006a52:	854a                	mv	a0,s2
    80006a54:	97ba                	add	a5,a5,a4
    80006a56:	00c7d983          	lhu	s3,12(a5)
		int nxt = disk.desc[i].next;
    80006a5a:	00e7d903          	lhu	s2,14(a5)
		free_desc(i);
    80006a5e:	00000097          	auipc	ra,0x0
    80006a62:	bcc080e7          	jalr	-1076(ra) # 8000662a <free_desc>
		if (flag & VRING_DESC_F_NEXT)
    80006a66:	0019f993          	and	s3,s3,1
    80006a6a:	fe0991e3          	bnez	s3,80006a4c <virtio_disk_rw+0x1c0>
	free_chain(idx[0]);

	release(&disk.vdisk_lock);
}
    80006a6e:	7406                	ld	s0,96(sp)
    80006a70:	70a6                	ld	ra,104(sp)
    80006a72:	64e6                	ld	s1,88(sp)
    80006a74:	6946                	ld	s2,80(sp)
    80006a76:	69a6                	ld	s3,72(sp)
    80006a78:	6a06                	ld	s4,64(sp)
    80006a7a:	7ae2                	ld	s5,56(sp)
    80006a7c:	7b42                	ld	s6,48(sp)
    80006a7e:	7ba2                	ld	s7,40(sp)
    80006a80:	7c02                	ld	s8,32(sp)
    80006a82:	6ce2                	ld	s9,24(sp)
    80006a84:	6d42                	ld	s10,16(sp)
	release(&disk.vdisk_lock);
    80006a86:	0001b517          	auipc	a0,0x1b
    80006a8a:	72250513          	add	a0,a0,1826 # 800221a8 <disk+0x128>
}
    80006a8e:	6165                	add	sp,sp,112
	release(&disk.vdisk_lock);
    80006a90:	ffffa317          	auipc	t1,0xffffa
    80006a94:	29030067          	jr	656(t1) # 80000d20 <release>

0000000080006a98 <virtio_disk_intr>:

void
virtio_disk_intr()
{
    80006a98:	1101                	add	sp,sp,-32
    80006a9a:	e822                	sd	s0,16(sp)
    80006a9c:	e426                	sd	s1,8(sp)
    80006a9e:	ec06                	sd	ra,24(sp)
    80006aa0:	1000                	add	s0,sp,32
	acquire(&disk.vdisk_lock);
    80006aa2:	0001b517          	auipc	a0,0x1b
    80006aa6:	70650513          	add	a0,a0,1798 # 800221a8 <disk+0x128>
    80006aaa:	ffffa097          	auipc	ra,0xffffa
    80006aae:	1b6080e7          	jalr	438(ra) # 80000c60 <acquire>
	 * seen this interrupt, which the following line does. this may race
	 * with the device writing new entries to the "used" ring, in which
	 * case we may process the new completion entries in this interrupt
	 * and have nothing to do in the next interrupt, which is harmless. 
         */
	*R(VIRTIO_MMIO_INTERRUPT_ACK) = *R(VIRTIO_MMIO_INTERRUPT_STATUS) & 0x3;
    80006ab2:	100017b7          	lui	a5,0x10001
    80006ab6:	53b4                	lw	a3,96(a5)
    80006ab8:	10001737          	lui	a4,0x10001
	acquire(&disk.vdisk_lock);
    80006abc:	0001b497          	auipc	s1,0x1b
    80006ac0:	5c448493          	add	s1,s1,1476 # 80022080 <disk>
	*R(VIRTIO_MMIO_INTERRUPT_ACK) = *R(VIRTIO_MMIO_INTERRUPT_STATUS) & 0x3;
    80006ac4:	8a8d                	and	a3,a3,3
    80006ac6:	d374                	sw	a3,100(a4)

	__sync_synchronize();
    80006ac8:	0ff0000f          	fence
	/* 
         * the device increments disk.used->idx when it adds an entry to the
	 * used ring. 
         */

	while (disk.used_idx != disk.used->idx) {
    80006acc:	689c                	ld	a5,16(s1)
    80006ace:	0204d703          	lhu	a4,32(s1)
    80006ad2:	0027d783          	lhu	a5,2(a5) # 10001002 <_entry-0x6fffeffe>
    80006ad6:	04f70463          	beq	a4,a5,80006b1e <virtio_disk_intr+0x86>
		__sync_synchronize();
    80006ada:	0ff0000f          	fence
		int id = disk.used->ring[disk.used_idx % NUM].id;
    80006ade:	0204d783          	lhu	a5,32(s1)
    80006ae2:	6898                	ld	a4,16(s1)
    80006ae4:	8b9d                	and	a5,a5,7
    80006ae6:	078e                	sll	a5,a5,0x3
    80006ae8:	97ba                	add	a5,a5,a4
    80006aea:	43dc                	lw	a5,4(a5)

		if (disk.info[id].status != 0)
    80006aec:	0789                	add	a5,a5,2
    80006aee:	0792                	sll	a5,a5,0x4
    80006af0:	97a6                	add	a5,a5,s1
    80006af2:	0107c703          	lbu	a4,16(a5)
    80006af6:	e321                	bnez	a4,80006b36 <virtio_disk_intr+0x9e>
			panic("virtio_disk_intr status");

		struct buf *b = disk.info[id].b;
    80006af8:	6788                	ld	a0,8(a5)
		b->disk = 0;
    80006afa:	00052223          	sw	zero,4(a0)
		/* disk is done with buf */
		    wakeup(b);
    80006afe:	ffffc097          	auipc	ra,0xffffc
    80006b02:	b6c080e7          	jalr	-1172(ra) # 8000266a <wakeup>

		disk.used_idx += 1;
    80006b06:	0204d783          	lhu	a5,32(s1)
	while (disk.used_idx != disk.used->idx) {
    80006b0a:	6898                	ld	a4,16(s1)
		disk.used_idx += 1;
    80006b0c:	2785                	addw	a5,a5,1
	while (disk.used_idx != disk.used->idx) {
    80006b0e:	00275703          	lhu	a4,2(a4) # 10001002 <_entry-0x6fffeffe>
		disk.used_idx += 1;
    80006b12:	17c2                	sll	a5,a5,0x30
    80006b14:	93c1                	srl	a5,a5,0x30
    80006b16:	02f49023          	sh	a5,32(s1)
	while (disk.used_idx != disk.used->idx) {
    80006b1a:	fcf710e3          	bne	a4,a5,80006ada <virtio_disk_intr+0x42>
	}

	release(&disk.vdisk_lock);
}
    80006b1e:	6442                	ld	s0,16(sp)
    80006b20:	60e2                	ld	ra,24(sp)
    80006b22:	64a2                	ld	s1,8(sp)
	release(&disk.vdisk_lock);
    80006b24:	0001b517          	auipc	a0,0x1b
    80006b28:	68450513          	add	a0,a0,1668 # 800221a8 <disk+0x128>
}
    80006b2c:	6105                	add	sp,sp,32
	release(&disk.vdisk_lock);
    80006b2e:	ffffa317          	auipc	t1,0xffffa
    80006b32:	1f230067          	jr	498(t1) # 80000d20 <release>
			panic("virtio_disk_intr status");
    80006b36:	00002517          	auipc	a0,0x2
    80006b3a:	02a50513          	add	a0,a0,42 # 80008b60 <etext+0xb60>
    80006b3e:	ffffa097          	auipc	ra,0xffffa
    80006b42:	a58080e7          	jalr	-1448(ra) # 80000596 <panic>
	...

0000000080007000 <_trampoline>:
    80007000:	14051073          	csrw	sscratch,a0
    80007004:	02000537          	lui	a0,0x2000
    80007008:	357d                	addw	a0,a0,-1 # 1ffffff <_entry-0x7e000001>
    8000700a:	0536                	sll	a0,a0,0xd
    8000700c:	02153423          	sd	ra,40(a0)
    80007010:	02253823          	sd	sp,48(a0)
    80007014:	02353c23          	sd	gp,56(a0)
    80007018:	04453023          	sd	tp,64(a0)
    8000701c:	04553423          	sd	t0,72(a0)
    80007020:	04653823          	sd	t1,80(a0)
    80007024:	04753c23          	sd	t2,88(a0)
    80007028:	f120                	sd	s0,96(a0)
    8000702a:	f524                	sd	s1,104(a0)
    8000702c:	fd2c                	sd	a1,120(a0)
    8000702e:	e150                	sd	a2,128(a0)
    80007030:	e554                	sd	a3,136(a0)
    80007032:	e958                	sd	a4,144(a0)
    80007034:	ed5c                	sd	a5,152(a0)
    80007036:	0b053023          	sd	a6,160(a0)
    8000703a:	0b153423          	sd	a7,168(a0)
    8000703e:	0b253823          	sd	s2,176(a0)
    80007042:	0b353c23          	sd	s3,184(a0)
    80007046:	0d453023          	sd	s4,192(a0)
    8000704a:	0d553423          	sd	s5,200(a0)
    8000704e:	0d653823          	sd	s6,208(a0)
    80007052:	0d753c23          	sd	s7,216(a0)
    80007056:	0f853023          	sd	s8,224(a0)
    8000705a:	0f953423          	sd	s9,232(a0)
    8000705e:	0fa53823          	sd	s10,240(a0)
    80007062:	0fb53c23          	sd	s11,248(a0)
    80007066:	11c53023          	sd	t3,256(a0)
    8000706a:	11d53423          	sd	t4,264(a0)
    8000706e:	11e53823          	sd	t5,272(a0)
    80007072:	11f53c23          	sd	t6,280(a0)
    80007076:	140022f3          	csrr	t0,sscratch
    8000707a:	06553823          	sd	t0,112(a0)
    8000707e:	00853103          	ld	sp,8(a0)
    80007082:	02053203          	ld	tp,32(a0)
    80007086:	01053283          	ld	t0,16(a0)
    8000708a:	00053303          	ld	t1,0(a0)
    8000708e:	12000073          	sfence.vma
    80007092:	18031073          	csrw	satp,t1
    80007096:	12000073          	sfence.vma
    8000709a:	8282                	jr	t0

000000008000709c <userret>:
    8000709c:	12000073          	sfence.vma
    800070a0:	18051073          	csrw	satp,a0
    800070a4:	12000073          	sfence.vma
    800070a8:	02000537          	lui	a0,0x2000
    800070ac:	357d                	addw	a0,a0,-1 # 1ffffff <_entry-0x7e000001>
    800070ae:	0536                	sll	a0,a0,0xd
    800070b0:	02853083          	ld	ra,40(a0)
    800070b4:	03053103          	ld	sp,48(a0)
    800070b8:	03853183          	ld	gp,56(a0)
    800070bc:	04053203          	ld	tp,64(a0)
    800070c0:	04853283          	ld	t0,72(a0)
    800070c4:	05053303          	ld	t1,80(a0)
    800070c8:	05853383          	ld	t2,88(a0)
    800070cc:	7120                	ld	s0,96(a0)
    800070ce:	7524                	ld	s1,104(a0)
    800070d0:	7d2c                	ld	a1,120(a0)
    800070d2:	6150                	ld	a2,128(a0)
    800070d4:	6554                	ld	a3,136(a0)
    800070d6:	6958                	ld	a4,144(a0)
    800070d8:	6d5c                	ld	a5,152(a0)
    800070da:	0a053803          	ld	a6,160(a0)
    800070de:	0a853883          	ld	a7,168(a0)
    800070e2:	0b053903          	ld	s2,176(a0)
    800070e6:	0b853983          	ld	s3,184(a0)
    800070ea:	0c053a03          	ld	s4,192(a0)
    800070ee:	0c853a83          	ld	s5,200(a0)
    800070f2:	0d053b03          	ld	s6,208(a0)
    800070f6:	0d853b83          	ld	s7,216(a0)
    800070fa:	0e053c03          	ld	s8,224(a0)
    800070fe:	0e853c83          	ld	s9,232(a0)
    80007102:	0f053d03          	ld	s10,240(a0)
    80007106:	0f853d83          	ld	s11,248(a0)
    8000710a:	10053e03          	ld	t3,256(a0)
    8000710e:	10853e83          	ld	t4,264(a0)
    80007112:	11053f03          	ld	t5,272(a0)
    80007116:	11853f83          	ld	t6,280(a0)
    8000711a:	7928                	ld	a0,112(a0)
    8000711c:	10200073          	sret
	...
