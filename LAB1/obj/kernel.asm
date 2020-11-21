
bin/kernel：     文件格式 elf32-i386


Disassembly of section .text:

00100000 <kern_init>:
int kern_init(void) __attribute__((noreturn));
void grade_backtrace(void);
static void lab1_switch_test(void);

int
kern_init(void) {
  100000:	55                   	push   %ebp
  100001:	89 e5                	mov    %esp,%ebp
  100003:	83 ec 28             	sub    $0x28,%esp
    extern char edata[], end[];
    memset(edata, 0, end - edata);
  100006:	ba 20 fd 10 00       	mov    $0x10fd20,%edx
  10000b:	b8 16 ea 10 00       	mov    $0x10ea16,%eax
  100010:	29 c2                	sub    %eax,%edx
  100012:	89 d0                	mov    %edx,%eax
  100014:	89 44 24 08          	mov    %eax,0x8(%esp)
  100018:	c7 44 24 04 00 00 00 	movl   $0x0,0x4(%esp)
  10001f:	00 
  100020:	c7 04 24 16 ea 10 00 	movl   $0x10ea16,(%esp)
  100027:	e8 5e 2b 00 00       	call   102b8a <memset>

    cons_init();                // init the console 使得cprintf可以在内核中向console输出
  10002c:	e8 32 15 00 00       	call   101563 <cons_init>

    const char *message = "UCORE os is loading ...";
  100031:	c7 45 f4 a0 33 10 00 	movl   $0x1033a0,-0xc(%ebp)
    cprintf("%s\n\n", message);
  100038:	8b 45 f4             	mov    -0xc(%ebp),%eax
  10003b:	89 44 24 04          	mov    %eax,0x4(%esp)
  10003f:	c7 04 24 b8 33 10 00 	movl   $0x1033b8,(%esp)
  100046:	e8 11 02 00 00       	call   10025c <cprintf>

    print_kerninfo();
  10004b:	e8 b2 08 00 00       	call   100902 <print_kerninfo>

    grade_backtrace();
  100050:	e8 89 00 00 00       	call   1000de <grade_backtrace>

    pmm_init();                 // init physical memory management
  100055:	e8 05 28 00 00       	call   10285f <pmm_init>

    pic_init();                 // init interrupt controller
  10005a:	e8 43 16 00 00       	call   1016a2 <pic_init>
    idt_init();                 // init interrupt descriptor table
  10005f:	e8 a3 17 00 00       	call   101807 <idt_init>

    clock_init();               // init clock interrupt
  100064:	e8 db 0c 00 00       	call   100d44 <clock_init>
    intr_enable();              // enable irq interrupt
  100069:	e8 6e 17 00 00       	call   1017dc <intr_enable>
    //LAB1: CAHLLENGE 1 If you try to do it, uncomment lab1_switch_test()
    // user/kernel mode switch test
    //lab1_switch_test();

    /* do nothing */
    while (1);
  10006e:	eb fe                	jmp    10006e <kern_init+0x6e>

00100070 <grade_backtrace2>:
}

void __attribute__((noinline))
grade_backtrace2(int arg0, int arg1, int arg2, int arg3) {
  100070:	55                   	push   %ebp
  100071:	89 e5                	mov    %esp,%ebp
  100073:	83 ec 18             	sub    $0x18,%esp
    mon_backtrace(0, NULL, NULL);
  100076:	c7 44 24 08 00 00 00 	movl   $0x0,0x8(%esp)
  10007d:	00 
  10007e:	c7 44 24 04 00 00 00 	movl   $0x0,0x4(%esp)
  100085:	00 
  100086:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
  10008d:	e8 a0 0c 00 00       	call   100d32 <mon_backtrace>
}
  100092:	90                   	nop
  100093:	c9                   	leave  
  100094:	c3                   	ret    

00100095 <grade_backtrace1>:

void __attribute__((noinline))
grade_backtrace1(int arg0, int arg1) {
  100095:	55                   	push   %ebp
  100096:	89 e5                	mov    %esp,%ebp
  100098:	53                   	push   %ebx
  100099:	83 ec 14             	sub    $0x14,%esp
    grade_backtrace2(arg0, (int)&arg0, arg1, (int)&arg1);
  10009c:	8d 4d 0c             	lea    0xc(%ebp),%ecx
  10009f:	8b 55 0c             	mov    0xc(%ebp),%edx
  1000a2:	8d 5d 08             	lea    0x8(%ebp),%ebx
  1000a5:	8b 45 08             	mov    0x8(%ebp),%eax
  1000a8:	89 4c 24 0c          	mov    %ecx,0xc(%esp)
  1000ac:	89 54 24 08          	mov    %edx,0x8(%esp)
  1000b0:	89 5c 24 04          	mov    %ebx,0x4(%esp)
  1000b4:	89 04 24             	mov    %eax,(%esp)
  1000b7:	e8 b4 ff ff ff       	call   100070 <grade_backtrace2>
}
  1000bc:	90                   	nop
  1000bd:	83 c4 14             	add    $0x14,%esp
  1000c0:	5b                   	pop    %ebx
  1000c1:	5d                   	pop    %ebp
  1000c2:	c3                   	ret    

001000c3 <grade_backtrace0>:

void __attribute__((noinline))
grade_backtrace0(int arg0, int arg1, int arg2) {
  1000c3:	55                   	push   %ebp
  1000c4:	89 e5                	mov    %esp,%ebp
  1000c6:	83 ec 18             	sub    $0x18,%esp
    grade_backtrace1(arg0, arg2);
  1000c9:	8b 45 10             	mov    0x10(%ebp),%eax
  1000cc:	89 44 24 04          	mov    %eax,0x4(%esp)
  1000d0:	8b 45 08             	mov    0x8(%ebp),%eax
  1000d3:	89 04 24             	mov    %eax,(%esp)
  1000d6:	e8 ba ff ff ff       	call   100095 <grade_backtrace1>
}
  1000db:	90                   	nop
  1000dc:	c9                   	leave  
  1000dd:	c3                   	ret    

001000de <grade_backtrace>:

void
grade_backtrace(void) {
  1000de:	55                   	push   %ebp
  1000df:	89 e5                	mov    %esp,%ebp
  1000e1:	83 ec 18             	sub    $0x18,%esp
    grade_backtrace0(0, (int)kern_init, 0xffff0000);
  1000e4:	b8 00 00 10 00       	mov    $0x100000,%eax
  1000e9:	c7 44 24 08 00 00 ff 	movl   $0xffff0000,0x8(%esp)
  1000f0:	ff 
  1000f1:	89 44 24 04          	mov    %eax,0x4(%esp)
  1000f5:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
  1000fc:	e8 c2 ff ff ff       	call   1000c3 <grade_backtrace0>
}
  100101:	90                   	nop
  100102:	c9                   	leave  
  100103:	c3                   	ret    

00100104 <lab1_print_cur_status>:

static void
lab1_print_cur_status(void) {
  100104:	55                   	push   %ebp
  100105:	89 e5                	mov    %esp,%ebp
  100107:	83 ec 28             	sub    $0x28,%esp
    static int round = 0;
    uint16_t reg1, reg2, reg3, reg4;
    asm volatile (
  10010a:	8c 4d f6             	mov    %cs,-0xa(%ebp)
  10010d:	8c 5d f4             	mov    %ds,-0xc(%ebp)
  100110:	8c 45 f2             	mov    %es,-0xe(%ebp)
  100113:	8c 55 f0             	mov    %ss,-0x10(%ebp)
            "mov %%cs, %0;"
            "mov %%ds, %1;"
            "mov %%es, %2;"
            "mov %%ss, %3;"
            : "=m"(reg1), "=m"(reg2), "=m"(reg3), "=m"(reg4));
    cprintf("%d: @ring %d\n", round, reg1 & 3);
  100116:	0f b7 45 f6          	movzwl -0xa(%ebp),%eax
  10011a:	83 e0 03             	and    $0x3,%eax
  10011d:	89 c2                	mov    %eax,%edx
  10011f:	a1 20 ea 10 00       	mov    0x10ea20,%eax
  100124:	89 54 24 08          	mov    %edx,0x8(%esp)
  100128:	89 44 24 04          	mov    %eax,0x4(%esp)
  10012c:	c7 04 24 bd 33 10 00 	movl   $0x1033bd,(%esp)
  100133:	e8 24 01 00 00       	call   10025c <cprintf>
    cprintf("%d:  cs = %x\n", round, reg1);
  100138:	0f b7 45 f6          	movzwl -0xa(%ebp),%eax
  10013c:	89 c2                	mov    %eax,%edx
  10013e:	a1 20 ea 10 00       	mov    0x10ea20,%eax
  100143:	89 54 24 08          	mov    %edx,0x8(%esp)
  100147:	89 44 24 04          	mov    %eax,0x4(%esp)
  10014b:	c7 04 24 cb 33 10 00 	movl   $0x1033cb,(%esp)
  100152:	e8 05 01 00 00       	call   10025c <cprintf>
    cprintf("%d:  ds = %x\n", round, reg2);
  100157:	0f b7 45 f4          	movzwl -0xc(%ebp),%eax
  10015b:	89 c2                	mov    %eax,%edx
  10015d:	a1 20 ea 10 00       	mov    0x10ea20,%eax
  100162:	89 54 24 08          	mov    %edx,0x8(%esp)
  100166:	89 44 24 04          	mov    %eax,0x4(%esp)
  10016a:	c7 04 24 d9 33 10 00 	movl   $0x1033d9,(%esp)
  100171:	e8 e6 00 00 00       	call   10025c <cprintf>
    cprintf("%d:  es = %x\n", round, reg3);
  100176:	0f b7 45 f2          	movzwl -0xe(%ebp),%eax
  10017a:	89 c2                	mov    %eax,%edx
  10017c:	a1 20 ea 10 00       	mov    0x10ea20,%eax
  100181:	89 54 24 08          	mov    %edx,0x8(%esp)
  100185:	89 44 24 04          	mov    %eax,0x4(%esp)
  100189:	c7 04 24 e7 33 10 00 	movl   $0x1033e7,(%esp)
  100190:	e8 c7 00 00 00       	call   10025c <cprintf>
    cprintf("%d:  ss = %x\n", round, reg4);
  100195:	0f b7 45 f0          	movzwl -0x10(%ebp),%eax
  100199:	89 c2                	mov    %eax,%edx
  10019b:	a1 20 ea 10 00       	mov    0x10ea20,%eax
  1001a0:	89 54 24 08          	mov    %edx,0x8(%esp)
  1001a4:	89 44 24 04          	mov    %eax,0x4(%esp)
  1001a8:	c7 04 24 f5 33 10 00 	movl   $0x1033f5,(%esp)
  1001af:	e8 a8 00 00 00       	call   10025c <cprintf>
    round ++;
  1001b4:	a1 20 ea 10 00       	mov    0x10ea20,%eax
  1001b9:	40                   	inc    %eax
  1001ba:	a3 20 ea 10 00       	mov    %eax,0x10ea20
}
  1001bf:	90                   	nop
  1001c0:	c9                   	leave  
  1001c1:	c3                   	ret    

001001c2 <lab1_switch_to_user>:

static void
lab1_switch_to_user(void) {
  1001c2:	55                   	push   %ebp
  1001c3:	89 e5                	mov    %esp,%ebp
    //LAB1 CHALLENGE 1 : TODO
    // make space for user stack 
    
}
  1001c5:	90                   	nop
  1001c6:	5d                   	pop    %ebp
  1001c7:	c3                   	ret    

001001c8 <lab1_switch_to_kernel>:

static void
lab1_switch_to_kernel(void) {
  1001c8:	55                   	push   %ebp
  1001c9:	89 e5                	mov    %esp,%ebp
    //LAB1 CHALLENGE 1 :  TODO
}
  1001cb:	90                   	nop
  1001cc:	5d                   	pop    %ebp
  1001cd:	c3                   	ret    

001001ce <lab1_switch_test>:

static void
lab1_switch_test(void) {
  1001ce:	55                   	push   %ebp
  1001cf:	89 e5                	mov    %esp,%ebp
  1001d1:	83 ec 18             	sub    $0x18,%esp
    lab1_print_cur_status();
  1001d4:	e8 2b ff ff ff       	call   100104 <lab1_print_cur_status>
    cprintf("+++ switch to  user  mode +++\n");
  1001d9:	c7 04 24 04 34 10 00 	movl   $0x103404,(%esp)
  1001e0:	e8 77 00 00 00       	call   10025c <cprintf>
    lab1_switch_to_user();
  1001e5:	e8 d8 ff ff ff       	call   1001c2 <lab1_switch_to_user>
    lab1_print_cur_status();
  1001ea:	e8 15 ff ff ff       	call   100104 <lab1_print_cur_status>
    cprintf("+++ switch to kernel mode +++\n");
  1001ef:	c7 04 24 24 34 10 00 	movl   $0x103424,(%esp)
  1001f6:	e8 61 00 00 00       	call   10025c <cprintf>
    lab1_switch_to_kernel();
  1001fb:	e8 c8 ff ff ff       	call   1001c8 <lab1_switch_to_kernel>
    lab1_print_cur_status();
  100200:	e8 ff fe ff ff       	call   100104 <lab1_print_cur_status>
}
  100205:	90                   	nop
  100206:	c9                   	leave  
  100207:	c3                   	ret    

00100208 <cputch>:
/* *
 * cputch - writes a single character @c to stdout, and it will
 * increace the value of counter pointed by @cnt.
 * */
static void
cputch(int c, int *cnt) {
  100208:	55                   	push   %ebp
  100209:	89 e5                	mov    %esp,%ebp
  10020b:	83 ec 18             	sub    $0x18,%esp
    cons_putc(c);
  10020e:	8b 45 08             	mov    0x8(%ebp),%eax
  100211:	89 04 24             	mov    %eax,(%esp)
  100214:	e8 77 13 00 00       	call   101590 <cons_putc>
    (*cnt) ++;
  100219:	8b 45 0c             	mov    0xc(%ebp),%eax
  10021c:	8b 00                	mov    (%eax),%eax
  10021e:	8d 50 01             	lea    0x1(%eax),%edx
  100221:	8b 45 0c             	mov    0xc(%ebp),%eax
  100224:	89 10                	mov    %edx,(%eax)
}
  100226:	90                   	nop
  100227:	c9                   	leave  
  100228:	c3                   	ret    

00100229 <vcprintf>:
 *
 * Call this function if you are already dealing with a va_list.
 * Or you probably want cprintf() instead.
 * */
int
vcprintf(const char *fmt, va_list ap) {
  100229:	55                   	push   %ebp
  10022a:	89 e5                	mov    %esp,%ebp
  10022c:	83 ec 28             	sub    $0x28,%esp
    int cnt = 0;
  10022f:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
    vprintfmt((void*)cputch, &cnt, fmt, ap);
  100236:	8b 45 0c             	mov    0xc(%ebp),%eax
  100239:	89 44 24 0c          	mov    %eax,0xc(%esp)
  10023d:	8b 45 08             	mov    0x8(%ebp),%eax
  100240:	89 44 24 08          	mov    %eax,0x8(%esp)
  100244:	8d 45 f4             	lea    -0xc(%ebp),%eax
  100247:	89 44 24 04          	mov    %eax,0x4(%esp)
  10024b:	c7 04 24 08 02 10 00 	movl   $0x100208,(%esp)
  100252:	e8 86 2c 00 00       	call   102edd <vprintfmt>
    return cnt;
  100257:	8b 45 f4             	mov    -0xc(%ebp),%eax
}
  10025a:	c9                   	leave  
  10025b:	c3                   	ret    

0010025c <cprintf>:
 *
 * The return value is the number of characters which would be
 * written to stdout.
 * */
int
cprintf(const char *fmt, ...) {
  10025c:	55                   	push   %ebp
  10025d:	89 e5                	mov    %esp,%ebp
  10025f:	83 ec 28             	sub    $0x28,%esp
    va_list ap;
    int cnt;
    va_start(ap, fmt);
  100262:	8d 45 0c             	lea    0xc(%ebp),%eax
  100265:	89 45 f0             	mov    %eax,-0x10(%ebp)
    cnt = vcprintf(fmt, ap);
  100268:	8b 45 f0             	mov    -0x10(%ebp),%eax
  10026b:	89 44 24 04          	mov    %eax,0x4(%esp)
  10026f:	8b 45 08             	mov    0x8(%ebp),%eax
  100272:	89 04 24             	mov    %eax,(%esp)
  100275:	e8 af ff ff ff       	call   100229 <vcprintf>
  10027a:	89 45 f4             	mov    %eax,-0xc(%ebp)
    va_end(ap);
    return cnt;
  10027d:	8b 45 f4             	mov    -0xc(%ebp),%eax
}
  100280:	c9                   	leave  
  100281:	c3                   	ret    

00100282 <cputchar>:

/* cputchar - writes a single character to stdout */
void
cputchar(int c) {
  100282:	55                   	push   %ebp
  100283:	89 e5                	mov    %esp,%ebp
  100285:	83 ec 18             	sub    $0x18,%esp
    cons_putc(c);
  100288:	8b 45 08             	mov    0x8(%ebp),%eax
  10028b:	89 04 24             	mov    %eax,(%esp)
  10028e:	e8 fd 12 00 00       	call   101590 <cons_putc>
}
  100293:	90                   	nop
  100294:	c9                   	leave  
  100295:	c3                   	ret    

00100296 <cputs>:
/* *
 * cputs- writes the string pointed by @str to stdout and
 * appends a newline character.
 * */
int
cputs(const char *str) {
  100296:	55                   	push   %ebp
  100297:	89 e5                	mov    %esp,%ebp
  100299:	83 ec 28             	sub    $0x28,%esp
    int cnt = 0;
  10029c:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
    char c;
    while ((c = *str ++) != '\0') {
  1002a3:	eb 13                	jmp    1002b8 <cputs+0x22>
        cputch(c, &cnt);
  1002a5:	0f be 45 f7          	movsbl -0x9(%ebp),%eax
  1002a9:	8d 55 f0             	lea    -0x10(%ebp),%edx
  1002ac:	89 54 24 04          	mov    %edx,0x4(%esp)
  1002b0:	89 04 24             	mov    %eax,(%esp)
  1002b3:	e8 50 ff ff ff       	call   100208 <cputch>
    while ((c = *str ++) != '\0') {
  1002b8:	8b 45 08             	mov    0x8(%ebp),%eax
  1002bb:	8d 50 01             	lea    0x1(%eax),%edx
  1002be:	89 55 08             	mov    %edx,0x8(%ebp)
  1002c1:	0f b6 00             	movzbl (%eax),%eax
  1002c4:	88 45 f7             	mov    %al,-0x9(%ebp)
  1002c7:	80 7d f7 00          	cmpb   $0x0,-0x9(%ebp)
  1002cb:	75 d8                	jne    1002a5 <cputs+0xf>
    }
    cputch('\n', &cnt);
  1002cd:	8d 45 f0             	lea    -0x10(%ebp),%eax
  1002d0:	89 44 24 04          	mov    %eax,0x4(%esp)
  1002d4:	c7 04 24 0a 00 00 00 	movl   $0xa,(%esp)
  1002db:	e8 28 ff ff ff       	call   100208 <cputch>
    return cnt;
  1002e0:	8b 45 f0             	mov    -0x10(%ebp),%eax
}
  1002e3:	c9                   	leave  
  1002e4:	c3                   	ret    

001002e5 <getchar>:

/* getchar - reads a single non-zero character from stdin */
int
getchar(void) {
  1002e5:	55                   	push   %ebp
  1002e6:	89 e5                	mov    %esp,%ebp
  1002e8:	83 ec 18             	sub    $0x18,%esp
    int c;
    while ((c = cons_getc()) == 0)
  1002eb:	e8 ca 12 00 00       	call   1015ba <cons_getc>
  1002f0:	89 45 f4             	mov    %eax,-0xc(%ebp)
  1002f3:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
  1002f7:	74 f2                	je     1002eb <getchar+0x6>
        /* do nothing */;
    return c;
  1002f9:	8b 45 f4             	mov    -0xc(%ebp),%eax
}
  1002fc:	c9                   	leave  
  1002fd:	c3                   	ret    

001002fe <readline>:
 * The readline() function returns the text of the line read. If some errors
 * are happened, NULL is returned. The return value is a global variable,
 * thus it should be copied before it is used.
 * */
char *
readline(const char *prompt) {
  1002fe:	55                   	push   %ebp
  1002ff:	89 e5                	mov    %esp,%ebp
  100301:	83 ec 28             	sub    $0x28,%esp
    if (prompt != NULL) {
  100304:	83 7d 08 00          	cmpl   $0x0,0x8(%ebp)
  100308:	74 13                	je     10031d <readline+0x1f>
        cprintf("%s", prompt);
  10030a:	8b 45 08             	mov    0x8(%ebp),%eax
  10030d:	89 44 24 04          	mov    %eax,0x4(%esp)
  100311:	c7 04 24 43 34 10 00 	movl   $0x103443,(%esp)
  100318:	e8 3f ff ff ff       	call   10025c <cprintf>
    }
    int i = 0, c;
  10031d:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
    while (1) {
        c = getchar();
  100324:	e8 bc ff ff ff       	call   1002e5 <getchar>
  100329:	89 45 f0             	mov    %eax,-0x10(%ebp)
        if (c < 0) {
  10032c:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
  100330:	79 07                	jns    100339 <readline+0x3b>
            return NULL;
  100332:	b8 00 00 00 00       	mov    $0x0,%eax
  100337:	eb 78                	jmp    1003b1 <readline+0xb3>
        }
        else if (c >= ' ' && i < BUFSIZE - 1) {
  100339:	83 7d f0 1f          	cmpl   $0x1f,-0x10(%ebp)
  10033d:	7e 28                	jle    100367 <readline+0x69>
  10033f:	81 7d f4 fe 03 00 00 	cmpl   $0x3fe,-0xc(%ebp)
  100346:	7f 1f                	jg     100367 <readline+0x69>
            cputchar(c);
  100348:	8b 45 f0             	mov    -0x10(%ebp),%eax
  10034b:	89 04 24             	mov    %eax,(%esp)
  10034e:	e8 2f ff ff ff       	call   100282 <cputchar>
            buf[i ++] = c;
  100353:	8b 45 f4             	mov    -0xc(%ebp),%eax
  100356:	8d 50 01             	lea    0x1(%eax),%edx
  100359:	89 55 f4             	mov    %edx,-0xc(%ebp)
  10035c:	8b 55 f0             	mov    -0x10(%ebp),%edx
  10035f:	88 90 40 ea 10 00    	mov    %dl,0x10ea40(%eax)
  100365:	eb 45                	jmp    1003ac <readline+0xae>
        }
        else if (c == '\b' && i > 0) {
  100367:	83 7d f0 08          	cmpl   $0x8,-0x10(%ebp)
  10036b:	75 16                	jne    100383 <readline+0x85>
  10036d:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
  100371:	7e 10                	jle    100383 <readline+0x85>
            cputchar(c);
  100373:	8b 45 f0             	mov    -0x10(%ebp),%eax
  100376:	89 04 24             	mov    %eax,(%esp)
  100379:	e8 04 ff ff ff       	call   100282 <cputchar>
            i --;
  10037e:	ff 4d f4             	decl   -0xc(%ebp)
  100381:	eb 29                	jmp    1003ac <readline+0xae>
        }
        else if (c == '\n' || c == '\r') {
  100383:	83 7d f0 0a          	cmpl   $0xa,-0x10(%ebp)
  100387:	74 06                	je     10038f <readline+0x91>
  100389:	83 7d f0 0d          	cmpl   $0xd,-0x10(%ebp)
  10038d:	75 95                	jne    100324 <readline+0x26>
            cputchar(c);
  10038f:	8b 45 f0             	mov    -0x10(%ebp),%eax
  100392:	89 04 24             	mov    %eax,(%esp)
  100395:	e8 e8 fe ff ff       	call   100282 <cputchar>
            buf[i] = '\0';
  10039a:	8b 45 f4             	mov    -0xc(%ebp),%eax
  10039d:	05 40 ea 10 00       	add    $0x10ea40,%eax
  1003a2:	c6 00 00             	movb   $0x0,(%eax)
            return buf;
  1003a5:	b8 40 ea 10 00       	mov    $0x10ea40,%eax
  1003aa:	eb 05                	jmp    1003b1 <readline+0xb3>
        c = getchar();
  1003ac:	e9 73 ff ff ff       	jmp    100324 <readline+0x26>
        }
    }
}
  1003b1:	c9                   	leave  
  1003b2:	c3                   	ret    

001003b3 <__panic>:
/* *
 * __panic - __panic is called on unresolvable fatal errors. it prints
 * "panic: 'message'", and then enters the kernel monitor.
 * */
void
__panic(const char *file, int line, const char *fmt, ...) {
  1003b3:	55                   	push   %ebp
  1003b4:	89 e5                	mov    %esp,%ebp
  1003b6:	83 ec 28             	sub    $0x28,%esp
    if (is_panic) {
  1003b9:	a1 40 ee 10 00       	mov    0x10ee40,%eax
  1003be:	85 c0                	test   %eax,%eax
  1003c0:	75 5b                	jne    10041d <__panic+0x6a>
        goto panic_dead;
    }
    is_panic = 1;
  1003c2:	c7 05 40 ee 10 00 01 	movl   $0x1,0x10ee40
  1003c9:	00 00 00 

    // print the 'message'
    va_list ap;
    va_start(ap, fmt);
  1003cc:	8d 45 14             	lea    0x14(%ebp),%eax
  1003cf:	89 45 f4             	mov    %eax,-0xc(%ebp)
    cprintf("kernel panic at %s:%d:\n    ", file, line);
  1003d2:	8b 45 0c             	mov    0xc(%ebp),%eax
  1003d5:	89 44 24 08          	mov    %eax,0x8(%esp)
  1003d9:	8b 45 08             	mov    0x8(%ebp),%eax
  1003dc:	89 44 24 04          	mov    %eax,0x4(%esp)
  1003e0:	c7 04 24 46 34 10 00 	movl   $0x103446,(%esp)
  1003e7:	e8 70 fe ff ff       	call   10025c <cprintf>
    vcprintf(fmt, ap);
  1003ec:	8b 45 f4             	mov    -0xc(%ebp),%eax
  1003ef:	89 44 24 04          	mov    %eax,0x4(%esp)
  1003f3:	8b 45 10             	mov    0x10(%ebp),%eax
  1003f6:	89 04 24             	mov    %eax,(%esp)
  1003f9:	e8 2b fe ff ff       	call   100229 <vcprintf>
    cprintf("\n");
  1003fe:	c7 04 24 62 34 10 00 	movl   $0x103462,(%esp)
  100405:	e8 52 fe ff ff       	call   10025c <cprintf>
    
    cprintf("stack trackback:\n");
  10040a:	c7 04 24 64 34 10 00 	movl   $0x103464,(%esp)
  100411:	e8 46 fe ff ff       	call   10025c <cprintf>
    print_stackframe();
  100416:	e8 32 06 00 00       	call   100a4d <print_stackframe>
  10041b:	eb 01                	jmp    10041e <__panic+0x6b>
        goto panic_dead;
  10041d:	90                   	nop
    
    va_end(ap);

panic_dead:
    intr_disable();
  10041e:	e8 c0 13 00 00       	call   1017e3 <intr_disable>
    while (1) {
        kmonitor(NULL);
  100423:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
  10042a:	e8 36 08 00 00       	call   100c65 <kmonitor>
  10042f:	eb f2                	jmp    100423 <__panic+0x70>

00100431 <__warn>:
    }
}

/* __warn - like panic, but don't */
void
__warn(const char *file, int line, const char *fmt, ...) {
  100431:	55                   	push   %ebp
  100432:	89 e5                	mov    %esp,%ebp
  100434:	83 ec 28             	sub    $0x28,%esp
    va_list ap;
    va_start(ap, fmt);
  100437:	8d 45 14             	lea    0x14(%ebp),%eax
  10043a:	89 45 f4             	mov    %eax,-0xc(%ebp)
    cprintf("kernel warning at %s:%d:\n    ", file, line);
  10043d:	8b 45 0c             	mov    0xc(%ebp),%eax
  100440:	89 44 24 08          	mov    %eax,0x8(%esp)
  100444:	8b 45 08             	mov    0x8(%ebp),%eax
  100447:	89 44 24 04          	mov    %eax,0x4(%esp)
  10044b:	c7 04 24 76 34 10 00 	movl   $0x103476,(%esp)
  100452:	e8 05 fe ff ff       	call   10025c <cprintf>
    vcprintf(fmt, ap);
  100457:	8b 45 f4             	mov    -0xc(%ebp),%eax
  10045a:	89 44 24 04          	mov    %eax,0x4(%esp)
  10045e:	8b 45 10             	mov    0x10(%ebp),%eax
  100461:	89 04 24             	mov    %eax,(%esp)
  100464:	e8 c0 fd ff ff       	call   100229 <vcprintf>
    cprintf("\n");
  100469:	c7 04 24 62 34 10 00 	movl   $0x103462,(%esp)
  100470:	e8 e7 fd ff ff       	call   10025c <cprintf>
    va_end(ap);
}
  100475:	90                   	nop
  100476:	c9                   	leave  
  100477:	c3                   	ret    

00100478 <is_kernel_panic>:

bool
is_kernel_panic(void) {
  100478:	55                   	push   %ebp
  100479:	89 e5                	mov    %esp,%ebp
    return is_panic;
  10047b:	a1 40 ee 10 00       	mov    0x10ee40,%eax
}
  100480:	5d                   	pop    %ebp
  100481:	c3                   	ret    

00100482 <stab_binsearch>:
 *      stab_binsearch(stabs, &left, &right, N_SO, 0xf0100184);
 * will exit setting left = 118, right = 554.
 * */
static void
stab_binsearch(const struct stab *stabs, int *region_left, int *region_right,
           int type, uintptr_t addr) {
  100482:	55                   	push   %ebp
  100483:	89 e5                	mov    %esp,%ebp
  100485:	83 ec 20             	sub    $0x20,%esp
    int l = *region_left, r = *region_right, any_matches = 0;
  100488:	8b 45 0c             	mov    0xc(%ebp),%eax
  10048b:	8b 00                	mov    (%eax),%eax
  10048d:	89 45 fc             	mov    %eax,-0x4(%ebp)
  100490:	8b 45 10             	mov    0x10(%ebp),%eax
  100493:	8b 00                	mov    (%eax),%eax
  100495:	89 45 f8             	mov    %eax,-0x8(%ebp)
  100498:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)

    while (l <= r) {
  10049f:	e9 ca 00 00 00       	jmp    10056e <stab_binsearch+0xec>
        int true_m = (l + r) / 2, m = true_m;
  1004a4:	8b 55 fc             	mov    -0x4(%ebp),%edx
  1004a7:	8b 45 f8             	mov    -0x8(%ebp),%eax
  1004aa:	01 d0                	add    %edx,%eax
  1004ac:	89 c2                	mov    %eax,%edx
  1004ae:	c1 ea 1f             	shr    $0x1f,%edx
  1004b1:	01 d0                	add    %edx,%eax
  1004b3:	d1 f8                	sar    %eax
  1004b5:	89 45 ec             	mov    %eax,-0x14(%ebp)
  1004b8:	8b 45 ec             	mov    -0x14(%ebp),%eax
  1004bb:	89 45 f0             	mov    %eax,-0x10(%ebp)

        // search for earliest stab with right type
        while (m >= l && stabs[m].n_type != type) {
  1004be:	eb 03                	jmp    1004c3 <stab_binsearch+0x41>
            m --;
  1004c0:	ff 4d f0             	decl   -0x10(%ebp)
        while (m >= l && stabs[m].n_type != type) {
  1004c3:	8b 45 f0             	mov    -0x10(%ebp),%eax
  1004c6:	3b 45 fc             	cmp    -0x4(%ebp),%eax
  1004c9:	7c 1f                	jl     1004ea <stab_binsearch+0x68>
  1004cb:	8b 55 f0             	mov    -0x10(%ebp),%edx
  1004ce:	89 d0                	mov    %edx,%eax
  1004d0:	01 c0                	add    %eax,%eax
  1004d2:	01 d0                	add    %edx,%eax
  1004d4:	c1 e0 02             	shl    $0x2,%eax
  1004d7:	89 c2                	mov    %eax,%edx
  1004d9:	8b 45 08             	mov    0x8(%ebp),%eax
  1004dc:	01 d0                	add    %edx,%eax
  1004de:	0f b6 40 04          	movzbl 0x4(%eax),%eax
  1004e2:	0f b6 c0             	movzbl %al,%eax
  1004e5:	39 45 14             	cmp    %eax,0x14(%ebp)
  1004e8:	75 d6                	jne    1004c0 <stab_binsearch+0x3e>
        }
        if (m < l) {    // no match in [l, m]
  1004ea:	8b 45 f0             	mov    -0x10(%ebp),%eax
  1004ed:	3b 45 fc             	cmp    -0x4(%ebp),%eax
  1004f0:	7d 09                	jge    1004fb <stab_binsearch+0x79>
            l = true_m + 1;
  1004f2:	8b 45 ec             	mov    -0x14(%ebp),%eax
  1004f5:	40                   	inc    %eax
  1004f6:	89 45 fc             	mov    %eax,-0x4(%ebp)
            continue;
  1004f9:	eb 73                	jmp    10056e <stab_binsearch+0xec>
        }

        // actual binary search
        any_matches = 1;
  1004fb:	c7 45 f4 01 00 00 00 	movl   $0x1,-0xc(%ebp)
        if (stabs[m].n_value < addr) {
  100502:	8b 55 f0             	mov    -0x10(%ebp),%edx
  100505:	89 d0                	mov    %edx,%eax
  100507:	01 c0                	add    %eax,%eax
  100509:	01 d0                	add    %edx,%eax
  10050b:	c1 e0 02             	shl    $0x2,%eax
  10050e:	89 c2                	mov    %eax,%edx
  100510:	8b 45 08             	mov    0x8(%ebp),%eax
  100513:	01 d0                	add    %edx,%eax
  100515:	8b 40 08             	mov    0x8(%eax),%eax
  100518:	39 45 18             	cmp    %eax,0x18(%ebp)
  10051b:	76 11                	jbe    10052e <stab_binsearch+0xac>
            *region_left = m;
  10051d:	8b 45 0c             	mov    0xc(%ebp),%eax
  100520:	8b 55 f0             	mov    -0x10(%ebp),%edx
  100523:	89 10                	mov    %edx,(%eax)
            l = true_m + 1;
  100525:	8b 45 ec             	mov    -0x14(%ebp),%eax
  100528:	40                   	inc    %eax
  100529:	89 45 fc             	mov    %eax,-0x4(%ebp)
  10052c:	eb 40                	jmp    10056e <stab_binsearch+0xec>
        } else if (stabs[m].n_value > addr) {
  10052e:	8b 55 f0             	mov    -0x10(%ebp),%edx
  100531:	89 d0                	mov    %edx,%eax
  100533:	01 c0                	add    %eax,%eax
  100535:	01 d0                	add    %edx,%eax
  100537:	c1 e0 02             	shl    $0x2,%eax
  10053a:	89 c2                	mov    %eax,%edx
  10053c:	8b 45 08             	mov    0x8(%ebp),%eax
  10053f:	01 d0                	add    %edx,%eax
  100541:	8b 40 08             	mov    0x8(%eax),%eax
  100544:	39 45 18             	cmp    %eax,0x18(%ebp)
  100547:	73 14                	jae    10055d <stab_binsearch+0xdb>
            *region_right = m - 1;
  100549:	8b 45 f0             	mov    -0x10(%ebp),%eax
  10054c:	8d 50 ff             	lea    -0x1(%eax),%edx
  10054f:	8b 45 10             	mov    0x10(%ebp),%eax
  100552:	89 10                	mov    %edx,(%eax)
            r = m - 1;
  100554:	8b 45 f0             	mov    -0x10(%ebp),%eax
  100557:	48                   	dec    %eax
  100558:	89 45 f8             	mov    %eax,-0x8(%ebp)
  10055b:	eb 11                	jmp    10056e <stab_binsearch+0xec>
        } else {
            // exact match for 'addr', but continue loop to find
            // *region_right
            *region_left = m;
  10055d:	8b 45 0c             	mov    0xc(%ebp),%eax
  100560:	8b 55 f0             	mov    -0x10(%ebp),%edx
  100563:	89 10                	mov    %edx,(%eax)
            l = m;
  100565:	8b 45 f0             	mov    -0x10(%ebp),%eax
  100568:	89 45 fc             	mov    %eax,-0x4(%ebp)
            addr ++;
  10056b:	ff 45 18             	incl   0x18(%ebp)
    while (l <= r) {
  10056e:	8b 45 fc             	mov    -0x4(%ebp),%eax
  100571:	3b 45 f8             	cmp    -0x8(%ebp),%eax
  100574:	0f 8e 2a ff ff ff    	jle    1004a4 <stab_binsearch+0x22>
        }
    }

    if (!any_matches) {
  10057a:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
  10057e:	75 0f                	jne    10058f <stab_binsearch+0x10d>
        *region_right = *region_left - 1;
  100580:	8b 45 0c             	mov    0xc(%ebp),%eax
  100583:	8b 00                	mov    (%eax),%eax
  100585:	8d 50 ff             	lea    -0x1(%eax),%edx
  100588:	8b 45 10             	mov    0x10(%ebp),%eax
  10058b:	89 10                	mov    %edx,(%eax)
        l = *region_right;
        for (; l > *region_left && stabs[l].n_type != type; l --)
            /* do nothing */;
        *region_left = l;
    }
}
  10058d:	eb 3e                	jmp    1005cd <stab_binsearch+0x14b>
        l = *region_right;
  10058f:	8b 45 10             	mov    0x10(%ebp),%eax
  100592:	8b 00                	mov    (%eax),%eax
  100594:	89 45 fc             	mov    %eax,-0x4(%ebp)
        for (; l > *region_left && stabs[l].n_type != type; l --)
  100597:	eb 03                	jmp    10059c <stab_binsearch+0x11a>
  100599:	ff 4d fc             	decl   -0x4(%ebp)
  10059c:	8b 45 0c             	mov    0xc(%ebp),%eax
  10059f:	8b 00                	mov    (%eax),%eax
  1005a1:	39 45 fc             	cmp    %eax,-0x4(%ebp)
  1005a4:	7e 1f                	jle    1005c5 <stab_binsearch+0x143>
  1005a6:	8b 55 fc             	mov    -0x4(%ebp),%edx
  1005a9:	89 d0                	mov    %edx,%eax
  1005ab:	01 c0                	add    %eax,%eax
  1005ad:	01 d0                	add    %edx,%eax
  1005af:	c1 e0 02             	shl    $0x2,%eax
  1005b2:	89 c2                	mov    %eax,%edx
  1005b4:	8b 45 08             	mov    0x8(%ebp),%eax
  1005b7:	01 d0                	add    %edx,%eax
  1005b9:	0f b6 40 04          	movzbl 0x4(%eax),%eax
  1005bd:	0f b6 c0             	movzbl %al,%eax
  1005c0:	39 45 14             	cmp    %eax,0x14(%ebp)
  1005c3:	75 d4                	jne    100599 <stab_binsearch+0x117>
        *region_left = l;
  1005c5:	8b 45 0c             	mov    0xc(%ebp),%eax
  1005c8:	8b 55 fc             	mov    -0x4(%ebp),%edx
  1005cb:	89 10                	mov    %edx,(%eax)
}
  1005cd:	90                   	nop
  1005ce:	c9                   	leave  
  1005cf:	c3                   	ret    

001005d0 <debuginfo_eip>:
 * the specified instruction address, @addr.  Returns 0 if information
 * was found, and negative if not.  But even if it returns negative it
 * has stored some information into '*info'.
 * */
int
debuginfo_eip(uintptr_t addr, struct eipdebuginfo *info) {
  1005d0:	55                   	push   %ebp
  1005d1:	89 e5                	mov    %esp,%ebp
  1005d3:	83 ec 58             	sub    $0x58,%esp
    const struct stab *stabs, *stab_end;
    const char *stabstr, *stabstr_end;

    info->eip_file = "<unknown>";
  1005d6:	8b 45 0c             	mov    0xc(%ebp),%eax
  1005d9:	c7 00 94 34 10 00    	movl   $0x103494,(%eax)
    info->eip_line = 0;
  1005df:	8b 45 0c             	mov    0xc(%ebp),%eax
  1005e2:	c7 40 04 00 00 00 00 	movl   $0x0,0x4(%eax)
    info->eip_fn_name = "<unknown>";
  1005e9:	8b 45 0c             	mov    0xc(%ebp),%eax
  1005ec:	c7 40 08 94 34 10 00 	movl   $0x103494,0x8(%eax)
    info->eip_fn_namelen = 9;
  1005f3:	8b 45 0c             	mov    0xc(%ebp),%eax
  1005f6:	c7 40 0c 09 00 00 00 	movl   $0x9,0xc(%eax)
    info->eip_fn_addr = addr;
  1005fd:	8b 45 0c             	mov    0xc(%ebp),%eax
  100600:	8b 55 08             	mov    0x8(%ebp),%edx
  100603:	89 50 10             	mov    %edx,0x10(%eax)
    info->eip_fn_narg = 0;
  100606:	8b 45 0c             	mov    0xc(%ebp),%eax
  100609:	c7 40 14 00 00 00 00 	movl   $0x0,0x14(%eax)

    stabs = __STAB_BEGIN__;
  100610:	c7 45 f4 cc 3c 10 00 	movl   $0x103ccc,-0xc(%ebp)
    stab_end = __STAB_END__;
  100617:	c7 45 f0 d4 b8 10 00 	movl   $0x10b8d4,-0x10(%ebp)
    stabstr = __STABSTR_BEGIN__;
  10061e:	c7 45 ec d5 b8 10 00 	movl   $0x10b8d5,-0x14(%ebp)
    stabstr_end = __STABSTR_END__;
  100625:	c7 45 e8 99 d9 10 00 	movl   $0x10d999,-0x18(%ebp)

    // String table validity checks
    if (stabstr_end <= stabstr || stabstr_end[-1] != 0) {
  10062c:	8b 45 e8             	mov    -0x18(%ebp),%eax
  10062f:	3b 45 ec             	cmp    -0x14(%ebp),%eax
  100632:	76 0b                	jbe    10063f <debuginfo_eip+0x6f>
  100634:	8b 45 e8             	mov    -0x18(%ebp),%eax
  100637:	48                   	dec    %eax
  100638:	0f b6 00             	movzbl (%eax),%eax
  10063b:	84 c0                	test   %al,%al
  10063d:	74 0a                	je     100649 <debuginfo_eip+0x79>
        return -1;
  10063f:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
  100644:	e9 b7 02 00 00       	jmp    100900 <debuginfo_eip+0x330>
    // 'eip'.  First, we find the basic source file containing 'eip'.
    // Then, we look in that source file for the function.  Then we look
    // for the line number.

    // Search the entire set of stabs for the source file (type N_SO).
    int lfile = 0, rfile = (stab_end - stabs) - 1;
  100649:	c7 45 e4 00 00 00 00 	movl   $0x0,-0x1c(%ebp)
  100650:	8b 55 f0             	mov    -0x10(%ebp),%edx
  100653:	8b 45 f4             	mov    -0xc(%ebp),%eax
  100656:	29 c2                	sub    %eax,%edx
  100658:	89 d0                	mov    %edx,%eax
  10065a:	c1 f8 02             	sar    $0x2,%eax
  10065d:	69 c0 ab aa aa aa    	imul   $0xaaaaaaab,%eax,%eax
  100663:	48                   	dec    %eax
  100664:	89 45 e0             	mov    %eax,-0x20(%ebp)
    stab_binsearch(stabs, &lfile, &rfile, N_SO, addr);
  100667:	8b 45 08             	mov    0x8(%ebp),%eax
  10066a:	89 44 24 10          	mov    %eax,0x10(%esp)
  10066e:	c7 44 24 0c 64 00 00 	movl   $0x64,0xc(%esp)
  100675:	00 
  100676:	8d 45 e0             	lea    -0x20(%ebp),%eax
  100679:	89 44 24 08          	mov    %eax,0x8(%esp)
  10067d:	8d 45 e4             	lea    -0x1c(%ebp),%eax
  100680:	89 44 24 04          	mov    %eax,0x4(%esp)
  100684:	8b 45 f4             	mov    -0xc(%ebp),%eax
  100687:	89 04 24             	mov    %eax,(%esp)
  10068a:	e8 f3 fd ff ff       	call   100482 <stab_binsearch>
    if (lfile == 0)
  10068f:	8b 45 e4             	mov    -0x1c(%ebp),%eax
  100692:	85 c0                	test   %eax,%eax
  100694:	75 0a                	jne    1006a0 <debuginfo_eip+0xd0>
        return -1;
  100696:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
  10069b:	e9 60 02 00 00       	jmp    100900 <debuginfo_eip+0x330>

    // Search within that file's stabs for the function definition
    // (N_FUN).
    int lfun = lfile, rfun = rfile;
  1006a0:	8b 45 e4             	mov    -0x1c(%ebp),%eax
  1006a3:	89 45 dc             	mov    %eax,-0x24(%ebp)
  1006a6:	8b 45 e0             	mov    -0x20(%ebp),%eax
  1006a9:	89 45 d8             	mov    %eax,-0x28(%ebp)
    int lline, rline;
    stab_binsearch(stabs, &lfun, &rfun, N_FUN, addr);
  1006ac:	8b 45 08             	mov    0x8(%ebp),%eax
  1006af:	89 44 24 10          	mov    %eax,0x10(%esp)
  1006b3:	c7 44 24 0c 24 00 00 	movl   $0x24,0xc(%esp)
  1006ba:	00 
  1006bb:	8d 45 d8             	lea    -0x28(%ebp),%eax
  1006be:	89 44 24 08          	mov    %eax,0x8(%esp)
  1006c2:	8d 45 dc             	lea    -0x24(%ebp),%eax
  1006c5:	89 44 24 04          	mov    %eax,0x4(%esp)
  1006c9:	8b 45 f4             	mov    -0xc(%ebp),%eax
  1006cc:	89 04 24             	mov    %eax,(%esp)
  1006cf:	e8 ae fd ff ff       	call   100482 <stab_binsearch>

    if (lfun <= rfun) {
  1006d4:	8b 55 dc             	mov    -0x24(%ebp),%edx
  1006d7:	8b 45 d8             	mov    -0x28(%ebp),%eax
  1006da:	39 c2                	cmp    %eax,%edx
  1006dc:	7f 7c                	jg     10075a <debuginfo_eip+0x18a>
        // stabs[lfun] points to the function name
        // in the string table, but check bounds just in case.
        if (stabs[lfun].n_strx < stabstr_end - stabstr) {
  1006de:	8b 45 dc             	mov    -0x24(%ebp),%eax
  1006e1:	89 c2                	mov    %eax,%edx
  1006e3:	89 d0                	mov    %edx,%eax
  1006e5:	01 c0                	add    %eax,%eax
  1006e7:	01 d0                	add    %edx,%eax
  1006e9:	c1 e0 02             	shl    $0x2,%eax
  1006ec:	89 c2                	mov    %eax,%edx
  1006ee:	8b 45 f4             	mov    -0xc(%ebp),%eax
  1006f1:	01 d0                	add    %edx,%eax
  1006f3:	8b 00                	mov    (%eax),%eax
  1006f5:	8b 4d e8             	mov    -0x18(%ebp),%ecx
  1006f8:	8b 55 ec             	mov    -0x14(%ebp),%edx
  1006fb:	29 d1                	sub    %edx,%ecx
  1006fd:	89 ca                	mov    %ecx,%edx
  1006ff:	39 d0                	cmp    %edx,%eax
  100701:	73 22                	jae    100725 <debuginfo_eip+0x155>
            info->eip_fn_name = stabstr + stabs[lfun].n_strx;
  100703:	8b 45 dc             	mov    -0x24(%ebp),%eax
  100706:	89 c2                	mov    %eax,%edx
  100708:	89 d0                	mov    %edx,%eax
  10070a:	01 c0                	add    %eax,%eax
  10070c:	01 d0                	add    %edx,%eax
  10070e:	c1 e0 02             	shl    $0x2,%eax
  100711:	89 c2                	mov    %eax,%edx
  100713:	8b 45 f4             	mov    -0xc(%ebp),%eax
  100716:	01 d0                	add    %edx,%eax
  100718:	8b 10                	mov    (%eax),%edx
  10071a:	8b 45 ec             	mov    -0x14(%ebp),%eax
  10071d:	01 c2                	add    %eax,%edx
  10071f:	8b 45 0c             	mov    0xc(%ebp),%eax
  100722:	89 50 08             	mov    %edx,0x8(%eax)
        }
        info->eip_fn_addr = stabs[lfun].n_value;
  100725:	8b 45 dc             	mov    -0x24(%ebp),%eax
  100728:	89 c2                	mov    %eax,%edx
  10072a:	89 d0                	mov    %edx,%eax
  10072c:	01 c0                	add    %eax,%eax
  10072e:	01 d0                	add    %edx,%eax
  100730:	c1 e0 02             	shl    $0x2,%eax
  100733:	89 c2                	mov    %eax,%edx
  100735:	8b 45 f4             	mov    -0xc(%ebp),%eax
  100738:	01 d0                	add    %edx,%eax
  10073a:	8b 50 08             	mov    0x8(%eax),%edx
  10073d:	8b 45 0c             	mov    0xc(%ebp),%eax
  100740:	89 50 10             	mov    %edx,0x10(%eax)
        addr -= info->eip_fn_addr;
  100743:	8b 45 0c             	mov    0xc(%ebp),%eax
  100746:	8b 40 10             	mov    0x10(%eax),%eax
  100749:	29 45 08             	sub    %eax,0x8(%ebp)
        // Search within the function definition for the line number.
        lline = lfun;
  10074c:	8b 45 dc             	mov    -0x24(%ebp),%eax
  10074f:	89 45 d4             	mov    %eax,-0x2c(%ebp)
        rline = rfun;
  100752:	8b 45 d8             	mov    -0x28(%ebp),%eax
  100755:	89 45 d0             	mov    %eax,-0x30(%ebp)
  100758:	eb 15                	jmp    10076f <debuginfo_eip+0x19f>
    } else {
        // Couldn't find function stab!  Maybe we're in an assembly
        // file.  Search the whole file for the line number.
        info->eip_fn_addr = addr;
  10075a:	8b 45 0c             	mov    0xc(%ebp),%eax
  10075d:	8b 55 08             	mov    0x8(%ebp),%edx
  100760:	89 50 10             	mov    %edx,0x10(%eax)
        lline = lfile;
  100763:	8b 45 e4             	mov    -0x1c(%ebp),%eax
  100766:	89 45 d4             	mov    %eax,-0x2c(%ebp)
        rline = rfile;
  100769:	8b 45 e0             	mov    -0x20(%ebp),%eax
  10076c:	89 45 d0             	mov    %eax,-0x30(%ebp)
    }
    info->eip_fn_namelen = strfind(info->eip_fn_name, ':') - info->eip_fn_name;
  10076f:	8b 45 0c             	mov    0xc(%ebp),%eax
  100772:	8b 40 08             	mov    0x8(%eax),%eax
  100775:	c7 44 24 04 3a 00 00 	movl   $0x3a,0x4(%esp)
  10077c:	00 
  10077d:	89 04 24             	mov    %eax,(%esp)
  100780:	e8 81 22 00 00       	call   102a06 <strfind>
  100785:	89 c2                	mov    %eax,%edx
  100787:	8b 45 0c             	mov    0xc(%ebp),%eax
  10078a:	8b 40 08             	mov    0x8(%eax),%eax
  10078d:	29 c2                	sub    %eax,%edx
  10078f:	8b 45 0c             	mov    0xc(%ebp),%eax
  100792:	89 50 0c             	mov    %edx,0xc(%eax)

    // Search within [lline, rline] for the line number stab.
    // If found, set info->eip_line to the right line number.
    // If not found, return -1.
    stab_binsearch(stabs, &lline, &rline, N_SLINE, addr);
  100795:	8b 45 08             	mov    0x8(%ebp),%eax
  100798:	89 44 24 10          	mov    %eax,0x10(%esp)
  10079c:	c7 44 24 0c 44 00 00 	movl   $0x44,0xc(%esp)
  1007a3:	00 
  1007a4:	8d 45 d0             	lea    -0x30(%ebp),%eax
  1007a7:	89 44 24 08          	mov    %eax,0x8(%esp)
  1007ab:	8d 45 d4             	lea    -0x2c(%ebp),%eax
  1007ae:	89 44 24 04          	mov    %eax,0x4(%esp)
  1007b2:	8b 45 f4             	mov    -0xc(%ebp),%eax
  1007b5:	89 04 24             	mov    %eax,(%esp)
  1007b8:	e8 c5 fc ff ff       	call   100482 <stab_binsearch>
    if (lline <= rline) {
  1007bd:	8b 55 d4             	mov    -0x2c(%ebp),%edx
  1007c0:	8b 45 d0             	mov    -0x30(%ebp),%eax
  1007c3:	39 c2                	cmp    %eax,%edx
  1007c5:	7f 23                	jg     1007ea <debuginfo_eip+0x21a>
        info->eip_line = stabs[rline].n_desc;
  1007c7:	8b 45 d0             	mov    -0x30(%ebp),%eax
  1007ca:	89 c2                	mov    %eax,%edx
  1007cc:	89 d0                	mov    %edx,%eax
  1007ce:	01 c0                	add    %eax,%eax
  1007d0:	01 d0                	add    %edx,%eax
  1007d2:	c1 e0 02             	shl    $0x2,%eax
  1007d5:	89 c2                	mov    %eax,%edx
  1007d7:	8b 45 f4             	mov    -0xc(%ebp),%eax
  1007da:	01 d0                	add    %edx,%eax
  1007dc:	0f b7 40 06          	movzwl 0x6(%eax),%eax
  1007e0:	89 c2                	mov    %eax,%edx
  1007e2:	8b 45 0c             	mov    0xc(%ebp),%eax
  1007e5:	89 50 04             	mov    %edx,0x4(%eax)

    // Search backwards from the line number for the relevant filename stab.
    // We can't just use the "lfile" stab because inlined functions
    // can interpolate code from a different file!
    // Such included source files use the N_SOL stab type.
    while (lline >= lfile
  1007e8:	eb 11                	jmp    1007fb <debuginfo_eip+0x22b>
        return -1;
  1007ea:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
  1007ef:	e9 0c 01 00 00       	jmp    100900 <debuginfo_eip+0x330>
           && stabs[lline].n_type != N_SOL
           && (stabs[lline].n_type != N_SO || !stabs[lline].n_value)) {
        lline --;
  1007f4:	8b 45 d4             	mov    -0x2c(%ebp),%eax
  1007f7:	48                   	dec    %eax
  1007f8:	89 45 d4             	mov    %eax,-0x2c(%ebp)
    while (lline >= lfile
  1007fb:	8b 55 d4             	mov    -0x2c(%ebp),%edx
  1007fe:	8b 45 e4             	mov    -0x1c(%ebp),%eax
  100801:	39 c2                	cmp    %eax,%edx
  100803:	7c 56                	jl     10085b <debuginfo_eip+0x28b>
           && stabs[lline].n_type != N_SOL
  100805:	8b 45 d4             	mov    -0x2c(%ebp),%eax
  100808:	89 c2                	mov    %eax,%edx
  10080a:	89 d0                	mov    %edx,%eax
  10080c:	01 c0                	add    %eax,%eax
  10080e:	01 d0                	add    %edx,%eax
  100810:	c1 e0 02             	shl    $0x2,%eax
  100813:	89 c2                	mov    %eax,%edx
  100815:	8b 45 f4             	mov    -0xc(%ebp),%eax
  100818:	01 d0                	add    %edx,%eax
  10081a:	0f b6 40 04          	movzbl 0x4(%eax),%eax
  10081e:	3c 84                	cmp    $0x84,%al
  100820:	74 39                	je     10085b <debuginfo_eip+0x28b>
           && (stabs[lline].n_type != N_SO || !stabs[lline].n_value)) {
  100822:	8b 45 d4             	mov    -0x2c(%ebp),%eax
  100825:	89 c2                	mov    %eax,%edx
  100827:	89 d0                	mov    %edx,%eax
  100829:	01 c0                	add    %eax,%eax
  10082b:	01 d0                	add    %edx,%eax
  10082d:	c1 e0 02             	shl    $0x2,%eax
  100830:	89 c2                	mov    %eax,%edx
  100832:	8b 45 f4             	mov    -0xc(%ebp),%eax
  100835:	01 d0                	add    %edx,%eax
  100837:	0f b6 40 04          	movzbl 0x4(%eax),%eax
  10083b:	3c 64                	cmp    $0x64,%al
  10083d:	75 b5                	jne    1007f4 <debuginfo_eip+0x224>
  10083f:	8b 45 d4             	mov    -0x2c(%ebp),%eax
  100842:	89 c2                	mov    %eax,%edx
  100844:	89 d0                	mov    %edx,%eax
  100846:	01 c0                	add    %eax,%eax
  100848:	01 d0                	add    %edx,%eax
  10084a:	c1 e0 02             	shl    $0x2,%eax
  10084d:	89 c2                	mov    %eax,%edx
  10084f:	8b 45 f4             	mov    -0xc(%ebp),%eax
  100852:	01 d0                	add    %edx,%eax
  100854:	8b 40 08             	mov    0x8(%eax),%eax
  100857:	85 c0                	test   %eax,%eax
  100859:	74 99                	je     1007f4 <debuginfo_eip+0x224>
    }
    if (lline >= lfile && stabs[lline].n_strx < stabstr_end - stabstr) {
  10085b:	8b 55 d4             	mov    -0x2c(%ebp),%edx
  10085e:	8b 45 e4             	mov    -0x1c(%ebp),%eax
  100861:	39 c2                	cmp    %eax,%edx
  100863:	7c 46                	jl     1008ab <debuginfo_eip+0x2db>
  100865:	8b 45 d4             	mov    -0x2c(%ebp),%eax
  100868:	89 c2                	mov    %eax,%edx
  10086a:	89 d0                	mov    %edx,%eax
  10086c:	01 c0                	add    %eax,%eax
  10086e:	01 d0                	add    %edx,%eax
  100870:	c1 e0 02             	shl    $0x2,%eax
  100873:	89 c2                	mov    %eax,%edx
  100875:	8b 45 f4             	mov    -0xc(%ebp),%eax
  100878:	01 d0                	add    %edx,%eax
  10087a:	8b 00                	mov    (%eax),%eax
  10087c:	8b 4d e8             	mov    -0x18(%ebp),%ecx
  10087f:	8b 55 ec             	mov    -0x14(%ebp),%edx
  100882:	29 d1                	sub    %edx,%ecx
  100884:	89 ca                	mov    %ecx,%edx
  100886:	39 d0                	cmp    %edx,%eax
  100888:	73 21                	jae    1008ab <debuginfo_eip+0x2db>
        info->eip_file = stabstr + stabs[lline].n_strx;
  10088a:	8b 45 d4             	mov    -0x2c(%ebp),%eax
  10088d:	89 c2                	mov    %eax,%edx
  10088f:	89 d0                	mov    %edx,%eax
  100891:	01 c0                	add    %eax,%eax
  100893:	01 d0                	add    %edx,%eax
  100895:	c1 e0 02             	shl    $0x2,%eax
  100898:	89 c2                	mov    %eax,%edx
  10089a:	8b 45 f4             	mov    -0xc(%ebp),%eax
  10089d:	01 d0                	add    %edx,%eax
  10089f:	8b 10                	mov    (%eax),%edx
  1008a1:	8b 45 ec             	mov    -0x14(%ebp),%eax
  1008a4:	01 c2                	add    %eax,%edx
  1008a6:	8b 45 0c             	mov    0xc(%ebp),%eax
  1008a9:	89 10                	mov    %edx,(%eax)
    }

    // Set eip_fn_narg to the number of arguments taken by the function,
    // or 0 if there was no containing function.
    if (lfun < rfun) {
  1008ab:	8b 55 dc             	mov    -0x24(%ebp),%edx
  1008ae:	8b 45 d8             	mov    -0x28(%ebp),%eax
  1008b1:	39 c2                	cmp    %eax,%edx
  1008b3:	7d 46                	jge    1008fb <debuginfo_eip+0x32b>
        for (lline = lfun + 1;
  1008b5:	8b 45 dc             	mov    -0x24(%ebp),%eax
  1008b8:	40                   	inc    %eax
  1008b9:	89 45 d4             	mov    %eax,-0x2c(%ebp)
  1008bc:	eb 16                	jmp    1008d4 <debuginfo_eip+0x304>
             lline < rfun && stabs[lline].n_type == N_PSYM;
             lline ++) {
            info->eip_fn_narg ++;
  1008be:	8b 45 0c             	mov    0xc(%ebp),%eax
  1008c1:	8b 40 14             	mov    0x14(%eax),%eax
  1008c4:	8d 50 01             	lea    0x1(%eax),%edx
  1008c7:	8b 45 0c             	mov    0xc(%ebp),%eax
  1008ca:	89 50 14             	mov    %edx,0x14(%eax)
             lline ++) {
  1008cd:	8b 45 d4             	mov    -0x2c(%ebp),%eax
  1008d0:	40                   	inc    %eax
  1008d1:	89 45 d4             	mov    %eax,-0x2c(%ebp)
             lline < rfun && stabs[lline].n_type == N_PSYM;
  1008d4:	8b 55 d4             	mov    -0x2c(%ebp),%edx
  1008d7:	8b 45 d8             	mov    -0x28(%ebp),%eax
        for (lline = lfun + 1;
  1008da:	39 c2                	cmp    %eax,%edx
  1008dc:	7d 1d                	jge    1008fb <debuginfo_eip+0x32b>
             lline < rfun && stabs[lline].n_type == N_PSYM;
  1008de:	8b 45 d4             	mov    -0x2c(%ebp),%eax
  1008e1:	89 c2                	mov    %eax,%edx
  1008e3:	89 d0                	mov    %edx,%eax
  1008e5:	01 c0                	add    %eax,%eax
  1008e7:	01 d0                	add    %edx,%eax
  1008e9:	c1 e0 02             	shl    $0x2,%eax
  1008ec:	89 c2                	mov    %eax,%edx
  1008ee:	8b 45 f4             	mov    -0xc(%ebp),%eax
  1008f1:	01 d0                	add    %edx,%eax
  1008f3:	0f b6 40 04          	movzbl 0x4(%eax),%eax
  1008f7:	3c a0                	cmp    $0xa0,%al
  1008f9:	74 c3                	je     1008be <debuginfo_eip+0x2ee>
        }
    }
    return 0;
  1008fb:	b8 00 00 00 00       	mov    $0x0,%eax
}
  100900:	c9                   	leave  
  100901:	c3                   	ret    

00100902 <print_kerninfo>:
 * print_kerninfo - print the information about kernel, including the location
 * of kernel entry, the start addresses of data and text segements, the start
 * address of free memory and how many memory that kernel has used.
 * */
void
print_kerninfo(void) {
  100902:	55                   	push   %ebp
  100903:	89 e5                	mov    %esp,%ebp
  100905:	83 ec 18             	sub    $0x18,%esp
    extern char etext[], edata[], end[], kern_init[];
    cprintf("Special kernel symbols:\n");
  100908:	c7 04 24 9e 34 10 00 	movl   $0x10349e,(%esp)
  10090f:	e8 48 f9 ff ff       	call   10025c <cprintf>
    cprintf("  entry  0x%08x (phys)\n", kern_init);
  100914:	c7 44 24 04 00 00 10 	movl   $0x100000,0x4(%esp)
  10091b:	00 
  10091c:	c7 04 24 b7 34 10 00 	movl   $0x1034b7,(%esp)
  100923:	e8 34 f9 ff ff       	call   10025c <cprintf>
    cprintf("  etext  0x%08x (phys)\n", etext);
  100928:	c7 44 24 04 84 33 10 	movl   $0x103384,0x4(%esp)
  10092f:	00 
  100930:	c7 04 24 cf 34 10 00 	movl   $0x1034cf,(%esp)
  100937:	e8 20 f9 ff ff       	call   10025c <cprintf>
    cprintf("  edata  0x%08x (phys)\n", edata);
  10093c:	c7 44 24 04 16 ea 10 	movl   $0x10ea16,0x4(%esp)
  100943:	00 
  100944:	c7 04 24 e7 34 10 00 	movl   $0x1034e7,(%esp)
  10094b:	e8 0c f9 ff ff       	call   10025c <cprintf>
    cprintf("  end    0x%08x (phys)\n", end);
  100950:	c7 44 24 04 20 fd 10 	movl   $0x10fd20,0x4(%esp)
  100957:	00 
  100958:	c7 04 24 ff 34 10 00 	movl   $0x1034ff,(%esp)
  10095f:	e8 f8 f8 ff ff       	call   10025c <cprintf>
    cprintf("Kernel executable memory footprint: %dKB\n", (end - kern_init + 1023)/1024);
  100964:	b8 20 fd 10 00       	mov    $0x10fd20,%eax
  100969:	8d 90 ff 03 00 00    	lea    0x3ff(%eax),%edx
  10096f:	b8 00 00 10 00       	mov    $0x100000,%eax
  100974:	29 c2                	sub    %eax,%edx
  100976:	89 d0                	mov    %edx,%eax
  100978:	8d 90 ff 03 00 00    	lea    0x3ff(%eax),%edx
  10097e:	85 c0                	test   %eax,%eax
  100980:	0f 48 c2             	cmovs  %edx,%eax
  100983:	c1 f8 0a             	sar    $0xa,%eax
  100986:	89 44 24 04          	mov    %eax,0x4(%esp)
  10098a:	c7 04 24 18 35 10 00 	movl   $0x103518,(%esp)
  100991:	e8 c6 f8 ff ff       	call   10025c <cprintf>
}
  100996:	90                   	nop
  100997:	c9                   	leave  
  100998:	c3                   	ret    

00100999 <print_debuginfo>:
/* *
 * print_debuginfo - read and print the stat information for the address @eip,
 * and info.eip_fn_addr should be the first address of the related function.
 * */
void
print_debuginfo(uintptr_t eip) {
  100999:	55                   	push   %ebp
  10099a:	89 e5                	mov    %esp,%ebp
  10099c:	81 ec 48 01 00 00    	sub    $0x148,%esp
    struct eipdebuginfo info;
    if (debuginfo_eip(eip, &info) != 0) {
  1009a2:	8d 45 dc             	lea    -0x24(%ebp),%eax
  1009a5:	89 44 24 04          	mov    %eax,0x4(%esp)
  1009a9:	8b 45 08             	mov    0x8(%ebp),%eax
  1009ac:	89 04 24             	mov    %eax,(%esp)
  1009af:	e8 1c fc ff ff       	call   1005d0 <debuginfo_eip>
  1009b4:	85 c0                	test   %eax,%eax
  1009b6:	74 15                	je     1009cd <print_debuginfo+0x34>
        cprintf("    <unknow>: -- 0x%08x --\n", eip);
  1009b8:	8b 45 08             	mov    0x8(%ebp),%eax
  1009bb:	89 44 24 04          	mov    %eax,0x4(%esp)
  1009bf:	c7 04 24 42 35 10 00 	movl   $0x103542,(%esp)
  1009c6:	e8 91 f8 ff ff       	call   10025c <cprintf>
        }
        fnname[j] = '\0';
        cprintf("    %s:%d: %s+%d\n", info.eip_file, info.eip_line,
                fnname, eip - info.eip_fn_addr);
    }
}
  1009cb:	eb 6c                	jmp    100a39 <print_debuginfo+0xa0>
        for (j = 0; j < info.eip_fn_namelen; j ++) {
  1009cd:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
  1009d4:	eb 1b                	jmp    1009f1 <print_debuginfo+0x58>
            fnname[j] = info.eip_fn_name[j];
  1009d6:	8b 55 e4             	mov    -0x1c(%ebp),%edx
  1009d9:	8b 45 f4             	mov    -0xc(%ebp),%eax
  1009dc:	01 d0                	add    %edx,%eax
  1009de:	0f b6 00             	movzbl (%eax),%eax
  1009e1:	8d 8d dc fe ff ff    	lea    -0x124(%ebp),%ecx
  1009e7:	8b 55 f4             	mov    -0xc(%ebp),%edx
  1009ea:	01 ca                	add    %ecx,%edx
  1009ec:	88 02                	mov    %al,(%edx)
        for (j = 0; j < info.eip_fn_namelen; j ++) {
  1009ee:	ff 45 f4             	incl   -0xc(%ebp)
  1009f1:	8b 45 e8             	mov    -0x18(%ebp),%eax
  1009f4:	39 45 f4             	cmp    %eax,-0xc(%ebp)
  1009f7:	7c dd                	jl     1009d6 <print_debuginfo+0x3d>
        fnname[j] = '\0';
  1009f9:	8d 95 dc fe ff ff    	lea    -0x124(%ebp),%edx
  1009ff:	8b 45 f4             	mov    -0xc(%ebp),%eax
  100a02:	01 d0                	add    %edx,%eax
  100a04:	c6 00 00             	movb   $0x0,(%eax)
                fnname, eip - info.eip_fn_addr);
  100a07:	8b 45 ec             	mov    -0x14(%ebp),%eax
        cprintf("    %s:%d: %s+%d\n", info.eip_file, info.eip_line,
  100a0a:	8b 55 08             	mov    0x8(%ebp),%edx
  100a0d:	89 d1                	mov    %edx,%ecx
  100a0f:	29 c1                	sub    %eax,%ecx
  100a11:	8b 55 e0             	mov    -0x20(%ebp),%edx
  100a14:	8b 45 dc             	mov    -0x24(%ebp),%eax
  100a17:	89 4c 24 10          	mov    %ecx,0x10(%esp)
  100a1b:	8d 8d dc fe ff ff    	lea    -0x124(%ebp),%ecx
  100a21:	89 4c 24 0c          	mov    %ecx,0xc(%esp)
  100a25:	89 54 24 08          	mov    %edx,0x8(%esp)
  100a29:	89 44 24 04          	mov    %eax,0x4(%esp)
  100a2d:	c7 04 24 5e 35 10 00 	movl   $0x10355e,(%esp)
  100a34:	e8 23 f8 ff ff       	call   10025c <cprintf>
}
  100a39:	90                   	nop
  100a3a:	c9                   	leave  
  100a3b:	c3                   	ret    

00100a3c <read_eip>:

static __noinline uint32_t
read_eip(void) {
  100a3c:	55                   	push   %ebp
  100a3d:	89 e5                	mov    %esp,%ebp
  100a3f:	83 ec 10             	sub    $0x10,%esp
    uint32_t eip;
    asm volatile("movl 4(%%ebp), %0" : "=r" (eip));
  100a42:	8b 45 04             	mov    0x4(%ebp),%eax
  100a45:	89 45 fc             	mov    %eax,-0x4(%ebp)
    return eip;
  100a48:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
  100a4b:	c9                   	leave  
  100a4c:	c3                   	ret    

00100a4d <print_stackframe>:
 *
 * Note that, the length of ebp-chain is limited. In boot/bootasm.S, before jumping
 * to the kernel entry, the value of ebp has been set to zero, that's the boundary.
 * */
void
print_stackframe(void) {
  100a4d:	55                   	push   %ebp
  100a4e:	89 e5                	mov    %esp,%ebp
  100a50:	53                   	push   %ebx
  100a51:	83 ec 34             	sub    $0x34,%esp
}

static inline uint32_t
read_ebp(void) {
    uint32_t ebp;
    asm volatile ("movl %%ebp, %0" : "=r" (ebp));
  100a54:	89 e8                	mov    %ebp,%eax
  100a56:	89 45 ec             	mov    %eax,-0x14(%ebp)
    return ebp;
  100a59:	8b 45 ec             	mov    -0x14(%ebp),%eax
      *                   the calling funciton's ebp = ss:[ebp]
      */
     // EBP指针指向当前堆栈轨迹，通过EBP形成了一个调用链，沿着调用链可以找出函数调用轨迹。
     // 注意指针运算时候的单位问题,例如一个int*类型的指针+1其实质地址值+4
     // 注意取得EBP EIP值的顺序问题
     uint32_t *ebp = (uint32_t *)read_ebp();
  100a5c:	89 45 f4             	mov    %eax,-0xc(%ebp)
     uint32_t eip = read_eip();
  100a5f:	e8 d8 ff ff ff       	call   100a3c <read_eip>
  100a64:	89 45 f0             	mov    %eax,-0x10(%ebp)

     while (ebp)
  100a67:	eb 7f                	jmp    100ae8 <print_stackframe+0x9b>
         {
             cprintf("ebp: 0x%08x eip: 0x%08x args: \n", (uint32_t)ebp, eip);
  100a69:	8b 45 f4             	mov    -0xc(%ebp),%eax
  100a6c:	8b 55 f0             	mov    -0x10(%ebp),%edx
  100a6f:	89 54 24 08          	mov    %edx,0x8(%esp)
  100a73:	89 44 24 04          	mov    %eax,0x4(%esp)
  100a77:	c7 04 24 70 35 10 00 	movl   $0x103570,(%esp)
  100a7e:	e8 d9 f7 ff ff       	call   10025c <cprintf>

             cprintf("0x%08x 0x%08x 0x%08x 0x%08x\n", ebp[2], ebp[3], ebp[4], ebp[5]);
  100a83:	8b 45 f4             	mov    -0xc(%ebp),%eax
  100a86:	83 c0 14             	add    $0x14,%eax
  100a89:	8b 18                	mov    (%eax),%ebx
  100a8b:	8b 45 f4             	mov    -0xc(%ebp),%eax
  100a8e:	83 c0 10             	add    $0x10,%eax
  100a91:	8b 08                	mov    (%eax),%ecx
  100a93:	8b 45 f4             	mov    -0xc(%ebp),%eax
  100a96:	83 c0 0c             	add    $0xc,%eax
  100a99:	8b 10                	mov    (%eax),%edx
  100a9b:	8b 45 f4             	mov    -0xc(%ebp),%eax
  100a9e:	83 c0 08             	add    $0x8,%eax
  100aa1:	8b 00                	mov    (%eax),%eax
  100aa3:	89 5c 24 10          	mov    %ebx,0x10(%esp)
  100aa7:	89 4c 24 0c          	mov    %ecx,0xc(%esp)
  100aab:	89 54 24 08          	mov    %edx,0x8(%esp)
  100aaf:	89 44 24 04          	mov    %eax,0x4(%esp)
  100ab3:	c7 04 24 90 35 10 00 	movl   $0x103590,(%esp)
  100aba:	e8 9d f7 ff ff       	call   10025c <cprintf>

             cprintf("\n");
  100abf:	c7 04 24 ad 35 10 00 	movl   $0x1035ad,(%esp)
  100ac6:	e8 91 f7 ff ff       	call   10025c <cprintf>

             print_debuginfo(eip - 1);
  100acb:	8b 45 f0             	mov    -0x10(%ebp),%eax
  100ace:	48                   	dec    %eax
  100acf:	89 04 24             	mov    %eax,(%esp)
  100ad2:	e8 c2 fe ff ff       	call   100999 <print_debuginfo>

             eip = ((uint32_t *)ebp)[1];    // ebp指针指向的地址向上一个位置为上一个函数的eip
  100ad7:	8b 45 f4             	mov    -0xc(%ebp),%eax
  100ada:	8b 40 04             	mov    0x4(%eax),%eax
  100add:	89 45 f0             	mov    %eax,-0x10(%ebp)
             ebp = *ebp;    // ebp指针指向的地址存储了上一个函数的ebp
  100ae0:	8b 45 f4             	mov    -0xc(%ebp),%eax
  100ae3:	8b 00                	mov    (%eax),%eax
  100ae5:	89 45 f4             	mov    %eax,-0xc(%ebp)
     while (ebp)
  100ae8:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
  100aec:	0f 85 77 ff ff ff    	jne    100a69 <print_stackframe+0x1c>
             // 开弹！下一个函数！
        }
}
  100af2:	90                   	nop
  100af3:	83 c4 34             	add    $0x34,%esp
  100af6:	5b                   	pop    %ebx
  100af7:	5d                   	pop    %ebp
  100af8:	c3                   	ret    

00100af9 <parse>:
#define MAXARGS         16
#define WHITESPACE      " \t\n\r"

/* parse - parse the command buffer into whitespace-separated arguments */
static int
parse(char *buf, char **argv) {
  100af9:	55                   	push   %ebp
  100afa:	89 e5                	mov    %esp,%ebp
  100afc:	83 ec 28             	sub    $0x28,%esp
    int argc = 0;
  100aff:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
    while (1) {
        // find global whitespace
        while (*buf != '\0' && strchr(WHITESPACE, *buf) != NULL) {
  100b06:	eb 0c                	jmp    100b14 <parse+0x1b>
            *buf ++ = '\0';
  100b08:	8b 45 08             	mov    0x8(%ebp),%eax
  100b0b:	8d 50 01             	lea    0x1(%eax),%edx
  100b0e:	89 55 08             	mov    %edx,0x8(%ebp)
  100b11:	c6 00 00             	movb   $0x0,(%eax)
        while (*buf != '\0' && strchr(WHITESPACE, *buf) != NULL) {
  100b14:	8b 45 08             	mov    0x8(%ebp),%eax
  100b17:	0f b6 00             	movzbl (%eax),%eax
  100b1a:	84 c0                	test   %al,%al
  100b1c:	74 1d                	je     100b3b <parse+0x42>
  100b1e:	8b 45 08             	mov    0x8(%ebp),%eax
  100b21:	0f b6 00             	movzbl (%eax),%eax
  100b24:	0f be c0             	movsbl %al,%eax
  100b27:	89 44 24 04          	mov    %eax,0x4(%esp)
  100b2b:	c7 04 24 30 36 10 00 	movl   $0x103630,(%esp)
  100b32:	e8 9d 1e 00 00       	call   1029d4 <strchr>
  100b37:	85 c0                	test   %eax,%eax
  100b39:	75 cd                	jne    100b08 <parse+0xf>
        }
        if (*buf == '\0') {
  100b3b:	8b 45 08             	mov    0x8(%ebp),%eax
  100b3e:	0f b6 00             	movzbl (%eax),%eax
  100b41:	84 c0                	test   %al,%al
  100b43:	74 65                	je     100baa <parse+0xb1>
            break;
        }

        // save and scan past next arg
        if (argc == MAXARGS - 1) {
  100b45:	83 7d f4 0f          	cmpl   $0xf,-0xc(%ebp)
  100b49:	75 14                	jne    100b5f <parse+0x66>
            cprintf("Too many arguments (max %d).\n", MAXARGS);
  100b4b:	c7 44 24 04 10 00 00 	movl   $0x10,0x4(%esp)
  100b52:	00 
  100b53:	c7 04 24 35 36 10 00 	movl   $0x103635,(%esp)
  100b5a:	e8 fd f6 ff ff       	call   10025c <cprintf>
        }
        argv[argc ++] = buf;
  100b5f:	8b 45 f4             	mov    -0xc(%ebp),%eax
  100b62:	8d 50 01             	lea    0x1(%eax),%edx
  100b65:	89 55 f4             	mov    %edx,-0xc(%ebp)
  100b68:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  100b6f:	8b 45 0c             	mov    0xc(%ebp),%eax
  100b72:	01 c2                	add    %eax,%edx
  100b74:	8b 45 08             	mov    0x8(%ebp),%eax
  100b77:	89 02                	mov    %eax,(%edx)
        while (*buf != '\0' && strchr(WHITESPACE, *buf) == NULL) {
  100b79:	eb 03                	jmp    100b7e <parse+0x85>
            buf ++;
  100b7b:	ff 45 08             	incl   0x8(%ebp)
        while (*buf != '\0' && strchr(WHITESPACE, *buf) == NULL) {
  100b7e:	8b 45 08             	mov    0x8(%ebp),%eax
  100b81:	0f b6 00             	movzbl (%eax),%eax
  100b84:	84 c0                	test   %al,%al
  100b86:	74 8c                	je     100b14 <parse+0x1b>
  100b88:	8b 45 08             	mov    0x8(%ebp),%eax
  100b8b:	0f b6 00             	movzbl (%eax),%eax
  100b8e:	0f be c0             	movsbl %al,%eax
  100b91:	89 44 24 04          	mov    %eax,0x4(%esp)
  100b95:	c7 04 24 30 36 10 00 	movl   $0x103630,(%esp)
  100b9c:	e8 33 1e 00 00       	call   1029d4 <strchr>
  100ba1:	85 c0                	test   %eax,%eax
  100ba3:	74 d6                	je     100b7b <parse+0x82>
        while (*buf != '\0' && strchr(WHITESPACE, *buf) != NULL) {
  100ba5:	e9 6a ff ff ff       	jmp    100b14 <parse+0x1b>
            break;
  100baa:	90                   	nop
        }
    }
    return argc;
  100bab:	8b 45 f4             	mov    -0xc(%ebp),%eax
}
  100bae:	c9                   	leave  
  100baf:	c3                   	ret    

00100bb0 <runcmd>:
/* *
 * runcmd - parse the input string, split it into separated arguments
 * and then lookup and invoke some related commands/
 * */
static int
runcmd(char *buf, struct trapframe *tf) {
  100bb0:	55                   	push   %ebp
  100bb1:	89 e5                	mov    %esp,%ebp
  100bb3:	53                   	push   %ebx
  100bb4:	83 ec 64             	sub    $0x64,%esp
    char *argv[MAXARGS];
    int argc = parse(buf, argv);
  100bb7:	8d 45 b0             	lea    -0x50(%ebp),%eax
  100bba:	89 44 24 04          	mov    %eax,0x4(%esp)
  100bbe:	8b 45 08             	mov    0x8(%ebp),%eax
  100bc1:	89 04 24             	mov    %eax,(%esp)
  100bc4:	e8 30 ff ff ff       	call   100af9 <parse>
  100bc9:	89 45 f0             	mov    %eax,-0x10(%ebp)
    if (argc == 0) {
  100bcc:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
  100bd0:	75 0a                	jne    100bdc <runcmd+0x2c>
        return 0;
  100bd2:	b8 00 00 00 00       	mov    $0x0,%eax
  100bd7:	e9 83 00 00 00       	jmp    100c5f <runcmd+0xaf>
    }
    int i;
    for (i = 0; i < NCOMMANDS; i ++) {
  100bdc:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
  100be3:	eb 5a                	jmp    100c3f <runcmd+0x8f>
        if (strcmp(commands[i].name, argv[0]) == 0) {
  100be5:	8b 4d b0             	mov    -0x50(%ebp),%ecx
  100be8:	8b 55 f4             	mov    -0xc(%ebp),%edx
  100beb:	89 d0                	mov    %edx,%eax
  100bed:	01 c0                	add    %eax,%eax
  100bef:	01 d0                	add    %edx,%eax
  100bf1:	c1 e0 02             	shl    $0x2,%eax
  100bf4:	05 00 e0 10 00       	add    $0x10e000,%eax
  100bf9:	8b 00                	mov    (%eax),%eax
  100bfb:	89 4c 24 04          	mov    %ecx,0x4(%esp)
  100bff:	89 04 24             	mov    %eax,(%esp)
  100c02:	e8 30 1d 00 00       	call   102937 <strcmp>
  100c07:	85 c0                	test   %eax,%eax
  100c09:	75 31                	jne    100c3c <runcmd+0x8c>
            return commands[i].func(argc - 1, argv + 1, tf);
  100c0b:	8b 55 f4             	mov    -0xc(%ebp),%edx
  100c0e:	89 d0                	mov    %edx,%eax
  100c10:	01 c0                	add    %eax,%eax
  100c12:	01 d0                	add    %edx,%eax
  100c14:	c1 e0 02             	shl    $0x2,%eax
  100c17:	05 08 e0 10 00       	add    $0x10e008,%eax
  100c1c:	8b 10                	mov    (%eax),%edx
  100c1e:	8d 45 b0             	lea    -0x50(%ebp),%eax
  100c21:	83 c0 04             	add    $0x4,%eax
  100c24:	8b 4d f0             	mov    -0x10(%ebp),%ecx
  100c27:	8d 59 ff             	lea    -0x1(%ecx),%ebx
  100c2a:	8b 4d 0c             	mov    0xc(%ebp),%ecx
  100c2d:	89 4c 24 08          	mov    %ecx,0x8(%esp)
  100c31:	89 44 24 04          	mov    %eax,0x4(%esp)
  100c35:	89 1c 24             	mov    %ebx,(%esp)
  100c38:	ff d2                	call   *%edx
  100c3a:	eb 23                	jmp    100c5f <runcmd+0xaf>
    for (i = 0; i < NCOMMANDS; i ++) {
  100c3c:	ff 45 f4             	incl   -0xc(%ebp)
  100c3f:	8b 45 f4             	mov    -0xc(%ebp),%eax
  100c42:	83 f8 02             	cmp    $0x2,%eax
  100c45:	76 9e                	jbe    100be5 <runcmd+0x35>
        }
    }
    cprintf("Unknown command '%s'\n", argv[0]);
  100c47:	8b 45 b0             	mov    -0x50(%ebp),%eax
  100c4a:	89 44 24 04          	mov    %eax,0x4(%esp)
  100c4e:	c7 04 24 53 36 10 00 	movl   $0x103653,(%esp)
  100c55:	e8 02 f6 ff ff       	call   10025c <cprintf>
    return 0;
  100c5a:	b8 00 00 00 00       	mov    $0x0,%eax
}
  100c5f:	83 c4 64             	add    $0x64,%esp
  100c62:	5b                   	pop    %ebx
  100c63:	5d                   	pop    %ebp
  100c64:	c3                   	ret    

00100c65 <kmonitor>:

/***** Implementations of basic kernel monitor commands *****/

void
kmonitor(struct trapframe *tf) {
  100c65:	55                   	push   %ebp
  100c66:	89 e5                	mov    %esp,%ebp
  100c68:	83 ec 28             	sub    $0x28,%esp
    cprintf("Welcome to the kernel debug monitor!!\n");
  100c6b:	c7 04 24 6c 36 10 00 	movl   $0x10366c,(%esp)
  100c72:	e8 e5 f5 ff ff       	call   10025c <cprintf>
    cprintf("Type 'help' for a list of commands.\n");
  100c77:	c7 04 24 94 36 10 00 	movl   $0x103694,(%esp)
  100c7e:	e8 d9 f5 ff ff       	call   10025c <cprintf>

    if (tf != NULL) {
  100c83:	83 7d 08 00          	cmpl   $0x0,0x8(%ebp)
  100c87:	74 0b                	je     100c94 <kmonitor+0x2f>
        print_trapframe(tf);
  100c89:	8b 45 08             	mov    0x8(%ebp),%eax
  100c8c:	89 04 24             	mov    %eax,(%esp)
  100c8f:	e8 ac 0c 00 00       	call   101940 <print_trapframe>
    }

    char *buf;
    while (1) {
        if ((buf = readline("K> ")) != NULL) {
  100c94:	c7 04 24 b9 36 10 00 	movl   $0x1036b9,(%esp)
  100c9b:	e8 5e f6 ff ff       	call   1002fe <readline>
  100ca0:	89 45 f4             	mov    %eax,-0xc(%ebp)
  100ca3:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
  100ca7:	74 eb                	je     100c94 <kmonitor+0x2f>
            if (runcmd(buf, tf) < 0) {
  100ca9:	8b 45 08             	mov    0x8(%ebp),%eax
  100cac:	89 44 24 04          	mov    %eax,0x4(%esp)
  100cb0:	8b 45 f4             	mov    -0xc(%ebp),%eax
  100cb3:	89 04 24             	mov    %eax,(%esp)
  100cb6:	e8 f5 fe ff ff       	call   100bb0 <runcmd>
  100cbb:	85 c0                	test   %eax,%eax
  100cbd:	78 02                	js     100cc1 <kmonitor+0x5c>
        if ((buf = readline("K> ")) != NULL) {
  100cbf:	eb d3                	jmp    100c94 <kmonitor+0x2f>
                break;
  100cc1:	90                   	nop
            }
        }
    }
}
  100cc2:	90                   	nop
  100cc3:	c9                   	leave  
  100cc4:	c3                   	ret    

00100cc5 <mon_help>:

/* mon_help - print the information about mon_* functions */
int
mon_help(int argc, char **argv, struct trapframe *tf) {
  100cc5:	55                   	push   %ebp
  100cc6:	89 e5                	mov    %esp,%ebp
  100cc8:	83 ec 28             	sub    $0x28,%esp
    int i;
    for (i = 0; i < NCOMMANDS; i ++) {
  100ccb:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
  100cd2:	eb 3d                	jmp    100d11 <mon_help+0x4c>
        cprintf("%s - %s\n", commands[i].name, commands[i].desc);
  100cd4:	8b 55 f4             	mov    -0xc(%ebp),%edx
  100cd7:	89 d0                	mov    %edx,%eax
  100cd9:	01 c0                	add    %eax,%eax
  100cdb:	01 d0                	add    %edx,%eax
  100cdd:	c1 e0 02             	shl    $0x2,%eax
  100ce0:	05 04 e0 10 00       	add    $0x10e004,%eax
  100ce5:	8b 08                	mov    (%eax),%ecx
  100ce7:	8b 55 f4             	mov    -0xc(%ebp),%edx
  100cea:	89 d0                	mov    %edx,%eax
  100cec:	01 c0                	add    %eax,%eax
  100cee:	01 d0                	add    %edx,%eax
  100cf0:	c1 e0 02             	shl    $0x2,%eax
  100cf3:	05 00 e0 10 00       	add    $0x10e000,%eax
  100cf8:	8b 00                	mov    (%eax),%eax
  100cfa:	89 4c 24 08          	mov    %ecx,0x8(%esp)
  100cfe:	89 44 24 04          	mov    %eax,0x4(%esp)
  100d02:	c7 04 24 bd 36 10 00 	movl   $0x1036bd,(%esp)
  100d09:	e8 4e f5 ff ff       	call   10025c <cprintf>
    for (i = 0; i < NCOMMANDS; i ++) {
  100d0e:	ff 45 f4             	incl   -0xc(%ebp)
  100d11:	8b 45 f4             	mov    -0xc(%ebp),%eax
  100d14:	83 f8 02             	cmp    $0x2,%eax
  100d17:	76 bb                	jbe    100cd4 <mon_help+0xf>
    }
    return 0;
  100d19:	b8 00 00 00 00       	mov    $0x0,%eax
}
  100d1e:	c9                   	leave  
  100d1f:	c3                   	ret    

00100d20 <mon_kerninfo>:
/* *
 * mon_kerninfo - call print_kerninfo in kern/debug/kdebug.c to
 * print the memory occupancy in kernel.
 * */
int
mon_kerninfo(int argc, char **argv, struct trapframe *tf) {
  100d20:	55                   	push   %ebp
  100d21:	89 e5                	mov    %esp,%ebp
  100d23:	83 ec 08             	sub    $0x8,%esp
    print_kerninfo();
  100d26:	e8 d7 fb ff ff       	call   100902 <print_kerninfo>
    return 0;
  100d2b:	b8 00 00 00 00       	mov    $0x0,%eax
}
  100d30:	c9                   	leave  
  100d31:	c3                   	ret    

00100d32 <mon_backtrace>:
/* *
 * mon_backtrace - call print_stackframe in kern/debug/kdebug.c to
 * print a backtrace of the stack.
 * */
int
mon_backtrace(int argc, char **argv, struct trapframe *tf) {
  100d32:	55                   	push   %ebp
  100d33:	89 e5                	mov    %esp,%ebp
  100d35:	83 ec 08             	sub    $0x8,%esp
    print_stackframe();
  100d38:	e8 10 fd ff ff       	call   100a4d <print_stackframe>
    return 0;
  100d3d:	b8 00 00 00 00       	mov    $0x0,%eax
}
  100d42:	c9                   	leave  
  100d43:	c3                   	ret    

00100d44 <clock_init>:
/* *
 * clock_init - initialize 8253 clock to interrupt 100 times per second,
 * and then enable IRQ_TIMER.
 * */
void
clock_init(void) {
  100d44:	55                   	push   %ebp
  100d45:	89 e5                	mov    %esp,%ebp
  100d47:	83 ec 28             	sub    $0x28,%esp
  100d4a:	66 c7 45 ee 43 00    	movw   $0x43,-0x12(%ebp)
  100d50:	c6 45 ed 34          	movb   $0x34,-0x13(%ebp)
    asm volatile ("outb %0, %1" :: "a" (data), "d" (port));
  100d54:	0f b6 45 ed          	movzbl -0x13(%ebp),%eax
  100d58:	0f b7 55 ee          	movzwl -0x12(%ebp),%edx
  100d5c:	ee                   	out    %al,(%dx)
  100d5d:	66 c7 45 f2 40 00    	movw   $0x40,-0xe(%ebp)
  100d63:	c6 45 f1 9c          	movb   $0x9c,-0xf(%ebp)
  100d67:	0f b6 45 f1          	movzbl -0xf(%ebp),%eax
  100d6b:	0f b7 55 f2          	movzwl -0xe(%ebp),%edx
  100d6f:	ee                   	out    %al,(%dx)
  100d70:	66 c7 45 f6 40 00    	movw   $0x40,-0xa(%ebp)
  100d76:	c6 45 f5 2e          	movb   $0x2e,-0xb(%ebp)
  100d7a:	0f b6 45 f5          	movzbl -0xb(%ebp),%eax
  100d7e:	0f b7 55 f6          	movzwl -0xa(%ebp),%edx
  100d82:	ee                   	out    %al,(%dx)
    outb(TIMER_MODE, TIMER_SEL0 | TIMER_RATEGEN | TIMER_16BIT);
    outb(IO_TIMER1, TIMER_DIV(100) % 256);
    outb(IO_TIMER1, TIMER_DIV(100) / 256);

    // initialize time counter 'ticks' to zero
    ticks = 0;
  100d83:	c7 05 08 f9 10 00 00 	movl   $0x0,0x10f908
  100d8a:	00 00 00 

    cprintf("++ setup timer interrupts\n");
  100d8d:	c7 04 24 c6 36 10 00 	movl   $0x1036c6,(%esp)
  100d94:	e8 c3 f4 ff ff       	call   10025c <cprintf>
    pic_enable(IRQ_TIMER);
  100d99:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
  100da0:	e8 ca 08 00 00       	call   10166f <pic_enable>
}
  100da5:	90                   	nop
  100da6:	c9                   	leave  
  100da7:	c3                   	ret    

00100da8 <delay>:
#include <picirq.h>
#include <trap.h>

/* stupid I/O delay routine necessitated by historical PC design flaws */
static void
delay(void) {
  100da8:	55                   	push   %ebp
  100da9:	89 e5                	mov    %esp,%ebp
  100dab:	83 ec 10             	sub    $0x10,%esp
  100dae:	66 c7 45 f2 84 00    	movw   $0x84,-0xe(%ebp)
    asm volatile ("inb %1, %0" : "=a" (data) : "d" (port));
  100db4:	0f b7 45 f2          	movzwl -0xe(%ebp),%eax
  100db8:	89 c2                	mov    %eax,%edx
  100dba:	ec                   	in     (%dx),%al
  100dbb:	88 45 f1             	mov    %al,-0xf(%ebp)
  100dbe:	66 c7 45 f6 84 00    	movw   $0x84,-0xa(%ebp)
  100dc4:	0f b7 45 f6          	movzwl -0xa(%ebp),%eax
  100dc8:	89 c2                	mov    %eax,%edx
  100dca:	ec                   	in     (%dx),%al
  100dcb:	88 45 f5             	mov    %al,-0xb(%ebp)
  100dce:	66 c7 45 fa 84 00    	movw   $0x84,-0x6(%ebp)
  100dd4:	0f b7 45 fa          	movzwl -0x6(%ebp),%eax
  100dd8:	89 c2                	mov    %eax,%edx
  100dda:	ec                   	in     (%dx),%al
  100ddb:	88 45 f9             	mov    %al,-0x7(%ebp)
  100dde:	66 c7 45 fe 84 00    	movw   $0x84,-0x2(%ebp)
  100de4:	0f b7 45 fe          	movzwl -0x2(%ebp),%eax
  100de8:	89 c2                	mov    %eax,%edx
  100dea:	ec                   	in     (%dx),%al
  100deb:	88 45 fd             	mov    %al,-0x3(%ebp)
    inb(0x84);
    inb(0x84);
    inb(0x84);
    inb(0x84);
}
  100dee:	90                   	nop
  100def:	c9                   	leave  
  100df0:	c3                   	ret    

00100df1 <cga_init>:
//    -- 数据寄存器 映射 到 端口 0x3D5或0x3B5 
//    -- 索引寄存器 0x3D4或0x3B4,决定在数据寄存器中的数据表示什么。

/* TEXT-mode CGA/VGA display output */
static void
cga_init(void) {
  100df1:	55                   	push   %ebp
  100df2:	89 e5                	mov    %esp,%ebp
  100df4:	83 ec 20             	sub    $0x20,%esp
    volatile uint16_t *cp = (uint16_t *)CGA_BUF;   //CGA_BUF: 0xB8000 (彩色显示的显存物理基址)
  100df7:	c7 45 fc 00 80 0b 00 	movl   $0xb8000,-0x4(%ebp)
    uint16_t was = *cp;                                            //保存当前显存0xB8000处的值
  100dfe:	8b 45 fc             	mov    -0x4(%ebp),%eax
  100e01:	0f b7 00             	movzwl (%eax),%eax
  100e04:	66 89 45 fa          	mov    %ax,-0x6(%ebp)
    *cp = (uint16_t) 0xA55A;                                   // 给这个地址随便写个值，看看能否再读出同样的值
  100e08:	8b 45 fc             	mov    -0x4(%ebp),%eax
  100e0b:	66 c7 00 5a a5       	movw   $0xa55a,(%eax)
    if (*cp != 0xA55A) {                                            // 如果读不出来，说明没有这块显存，即是单显配置
  100e10:	8b 45 fc             	mov    -0x4(%ebp),%eax
  100e13:	0f b7 00             	movzwl (%eax),%eax
  100e16:	0f b7 c0             	movzwl %ax,%eax
  100e19:	3d 5a a5 00 00       	cmp    $0xa55a,%eax
  100e1e:	74 12                	je     100e32 <cga_init+0x41>
        cp = (uint16_t*)MONO_BUF;                         //设置为单显的显存基址 MONO_BUF： 0xB0000
  100e20:	c7 45 fc 00 00 0b 00 	movl   $0xb0000,-0x4(%ebp)
        addr_6845 = MONO_BASE;                           //设置为单显控制的IO地址，MONO_BASE: 0x3B4
  100e27:	66 c7 05 66 ee 10 00 	movw   $0x3b4,0x10ee66
  100e2e:	b4 03 
  100e30:	eb 13                	jmp    100e45 <cga_init+0x54>
    } else {                                                                // 如果读出来了，有这块显存，即是彩显配置
        *cp = was;                                                      //还原原来显存位置的值
  100e32:	8b 45 fc             	mov    -0x4(%ebp),%eax
  100e35:	0f b7 55 fa          	movzwl -0x6(%ebp),%edx
  100e39:	66 89 10             	mov    %dx,(%eax)
        addr_6845 = CGA_BASE;                               // 设置为彩显控制的IO地址，CGA_BASE: 0x3D4 
  100e3c:	66 c7 05 66 ee 10 00 	movw   $0x3d4,0x10ee66
  100e43:	d4 03 
    // Extract cursor location
    // 6845索引寄存器的index 0x0E（及十进制的14）== 光标位置(高位)
    // 6845索引寄存器的index 0x0F（及十进制的15）== 光标位置(低位)
    // 6845 reg 15 : Cursor Address (Low Byte)
    uint32_t pos;
    outb(addr_6845, 14);                                        
  100e45:	0f b7 05 66 ee 10 00 	movzwl 0x10ee66,%eax
  100e4c:	66 89 45 e6          	mov    %ax,-0x1a(%ebp)
  100e50:	c6 45 e5 0e          	movb   $0xe,-0x1b(%ebp)
    asm volatile ("outb %0, %1" :: "a" (data), "d" (port));
  100e54:	0f b6 45 e5          	movzbl -0x1b(%ebp),%eax
  100e58:	0f b7 55 e6          	movzwl -0x1a(%ebp),%edx
  100e5c:	ee                   	out    %al,(%dx)
    pos = inb(addr_6845 + 1) << 8;                       //读出了光标位置(高位)
  100e5d:	0f b7 05 66 ee 10 00 	movzwl 0x10ee66,%eax
  100e64:	40                   	inc    %eax
  100e65:	0f b7 c0             	movzwl %ax,%eax
  100e68:	66 89 45 ea          	mov    %ax,-0x16(%ebp)
    asm volatile ("inb %1, %0" : "=a" (data) : "d" (port));
  100e6c:	0f b7 45 ea          	movzwl -0x16(%ebp),%eax
  100e70:	89 c2                	mov    %eax,%edx
  100e72:	ec                   	in     (%dx),%al
  100e73:	88 45 e9             	mov    %al,-0x17(%ebp)
    return data;
  100e76:	0f b6 45 e9          	movzbl -0x17(%ebp),%eax
  100e7a:	0f b6 c0             	movzbl %al,%eax
  100e7d:	c1 e0 08             	shl    $0x8,%eax
  100e80:	89 45 f4             	mov    %eax,-0xc(%ebp)
    outb(addr_6845, 15);
  100e83:	0f b7 05 66 ee 10 00 	movzwl 0x10ee66,%eax
  100e8a:	66 89 45 ee          	mov    %ax,-0x12(%ebp)
  100e8e:	c6 45 ed 0f          	movb   $0xf,-0x13(%ebp)
    asm volatile ("outb %0, %1" :: "a" (data), "d" (port));
  100e92:	0f b6 45 ed          	movzbl -0x13(%ebp),%eax
  100e96:	0f b7 55 ee          	movzwl -0x12(%ebp),%edx
  100e9a:	ee                   	out    %al,(%dx)
    pos |= inb(addr_6845 + 1);                             //读出了光标位置(低位)
  100e9b:	0f b7 05 66 ee 10 00 	movzwl 0x10ee66,%eax
  100ea2:	40                   	inc    %eax
  100ea3:	0f b7 c0             	movzwl %ax,%eax
  100ea6:	66 89 45 f2          	mov    %ax,-0xe(%ebp)
    asm volatile ("inb %1, %0" : "=a" (data) : "d" (port));
  100eaa:	0f b7 45 f2          	movzwl -0xe(%ebp),%eax
  100eae:	89 c2                	mov    %eax,%edx
  100eb0:	ec                   	in     (%dx),%al
  100eb1:	88 45 f1             	mov    %al,-0xf(%ebp)
    return data;
  100eb4:	0f b6 45 f1          	movzbl -0xf(%ebp),%eax
  100eb8:	0f b6 c0             	movzbl %al,%eax
  100ebb:	09 45 f4             	or     %eax,-0xc(%ebp)

    crt_buf = (uint16_t*) cp;                                  //crt_buf是CGA显存起始地址
  100ebe:	8b 45 fc             	mov    -0x4(%ebp),%eax
  100ec1:	a3 60 ee 10 00       	mov    %eax,0x10ee60
    crt_pos = pos;                                                  //crt_pos是CGA当前光标位置
  100ec6:	8b 45 f4             	mov    -0xc(%ebp),%eax
  100ec9:	0f b7 c0             	movzwl %ax,%eax
  100ecc:	66 a3 64 ee 10 00    	mov    %ax,0x10ee64
}
  100ed2:	90                   	nop
  100ed3:	c9                   	leave  
  100ed4:	c3                   	ret    

00100ed5 <serial_init>:

static bool serial_exists = 0;

static void
serial_init(void) {
  100ed5:	55                   	push   %ebp
  100ed6:	89 e5                	mov    %esp,%ebp
  100ed8:	83 ec 48             	sub    $0x48,%esp
  100edb:	66 c7 45 d2 fa 03    	movw   $0x3fa,-0x2e(%ebp)
  100ee1:	c6 45 d1 00          	movb   $0x0,-0x2f(%ebp)
    asm volatile ("outb %0, %1" :: "a" (data), "d" (port));
  100ee5:	0f b6 45 d1          	movzbl -0x2f(%ebp),%eax
  100ee9:	0f b7 55 d2          	movzwl -0x2e(%ebp),%edx
  100eed:	ee                   	out    %al,(%dx)
  100eee:	66 c7 45 d6 fb 03    	movw   $0x3fb,-0x2a(%ebp)
  100ef4:	c6 45 d5 80          	movb   $0x80,-0x2b(%ebp)
  100ef8:	0f b6 45 d5          	movzbl -0x2b(%ebp),%eax
  100efc:	0f b7 55 d6          	movzwl -0x2a(%ebp),%edx
  100f00:	ee                   	out    %al,(%dx)
  100f01:	66 c7 45 da f8 03    	movw   $0x3f8,-0x26(%ebp)
  100f07:	c6 45 d9 0c          	movb   $0xc,-0x27(%ebp)
  100f0b:	0f b6 45 d9          	movzbl -0x27(%ebp),%eax
  100f0f:	0f b7 55 da          	movzwl -0x26(%ebp),%edx
  100f13:	ee                   	out    %al,(%dx)
  100f14:	66 c7 45 de f9 03    	movw   $0x3f9,-0x22(%ebp)
  100f1a:	c6 45 dd 00          	movb   $0x0,-0x23(%ebp)
  100f1e:	0f b6 45 dd          	movzbl -0x23(%ebp),%eax
  100f22:	0f b7 55 de          	movzwl -0x22(%ebp),%edx
  100f26:	ee                   	out    %al,(%dx)
  100f27:	66 c7 45 e2 fb 03    	movw   $0x3fb,-0x1e(%ebp)
  100f2d:	c6 45 e1 03          	movb   $0x3,-0x1f(%ebp)
  100f31:	0f b6 45 e1          	movzbl -0x1f(%ebp),%eax
  100f35:	0f b7 55 e2          	movzwl -0x1e(%ebp),%edx
  100f39:	ee                   	out    %al,(%dx)
  100f3a:	66 c7 45 e6 fc 03    	movw   $0x3fc,-0x1a(%ebp)
  100f40:	c6 45 e5 00          	movb   $0x0,-0x1b(%ebp)
  100f44:	0f b6 45 e5          	movzbl -0x1b(%ebp),%eax
  100f48:	0f b7 55 e6          	movzwl -0x1a(%ebp),%edx
  100f4c:	ee                   	out    %al,(%dx)
  100f4d:	66 c7 45 ea f9 03    	movw   $0x3f9,-0x16(%ebp)
  100f53:	c6 45 e9 01          	movb   $0x1,-0x17(%ebp)
  100f57:	0f b6 45 e9          	movzbl -0x17(%ebp),%eax
  100f5b:	0f b7 55 ea          	movzwl -0x16(%ebp),%edx
  100f5f:	ee                   	out    %al,(%dx)
  100f60:	66 c7 45 ee fd 03    	movw   $0x3fd,-0x12(%ebp)
    asm volatile ("inb %1, %0" : "=a" (data) : "d" (port));
  100f66:	0f b7 45 ee          	movzwl -0x12(%ebp),%eax
  100f6a:	89 c2                	mov    %eax,%edx
  100f6c:	ec                   	in     (%dx),%al
  100f6d:	88 45 ed             	mov    %al,-0x13(%ebp)
    return data;
  100f70:	0f b6 45 ed          	movzbl -0x13(%ebp),%eax
    // Enable rcv interrupts
    outb(COM1 + COM_IER, COM_IER_RDI);

    // Clear any preexisting overrun indications and interrupts
    // Serial port doesn't exist if COM_LSR returns 0xFF
    serial_exists = (inb(COM1 + COM_LSR) != 0xFF);
  100f74:	3c ff                	cmp    $0xff,%al
  100f76:	0f 95 c0             	setne  %al
  100f79:	0f b6 c0             	movzbl %al,%eax
  100f7c:	a3 68 ee 10 00       	mov    %eax,0x10ee68
  100f81:	66 c7 45 f2 fa 03    	movw   $0x3fa,-0xe(%ebp)
    asm volatile ("inb %1, %0" : "=a" (data) : "d" (port));
  100f87:	0f b7 45 f2          	movzwl -0xe(%ebp),%eax
  100f8b:	89 c2                	mov    %eax,%edx
  100f8d:	ec                   	in     (%dx),%al
  100f8e:	88 45 f1             	mov    %al,-0xf(%ebp)
  100f91:	66 c7 45 f6 f8 03    	movw   $0x3f8,-0xa(%ebp)
  100f97:	0f b7 45 f6          	movzwl -0xa(%ebp),%eax
  100f9b:	89 c2                	mov    %eax,%edx
  100f9d:	ec                   	in     (%dx),%al
  100f9e:	88 45 f5             	mov    %al,-0xb(%ebp)
    (void) inb(COM1+COM_IIR);
    (void) inb(COM1+COM_RX);

    if (serial_exists) {
  100fa1:	a1 68 ee 10 00       	mov    0x10ee68,%eax
  100fa6:	85 c0                	test   %eax,%eax
  100fa8:	74 0c                	je     100fb6 <serial_init+0xe1>
        pic_enable(IRQ_COM1);
  100faa:	c7 04 24 04 00 00 00 	movl   $0x4,(%esp)
  100fb1:	e8 b9 06 00 00       	call   10166f <pic_enable>
    }
}
  100fb6:	90                   	nop
  100fb7:	c9                   	leave  
  100fb8:	c3                   	ret    

00100fb9 <lpt_putc_sub>:

static void
lpt_putc_sub(int c) {
  100fb9:	55                   	push   %ebp
  100fba:	89 e5                	mov    %esp,%ebp
  100fbc:	83 ec 20             	sub    $0x20,%esp
    int i;
    for (i = 0; !(inb(LPTPORT + 1) & 0x80) && i < 12800; i ++) {
  100fbf:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  100fc6:	eb 08                	jmp    100fd0 <lpt_putc_sub+0x17>
        delay();
  100fc8:	e8 db fd ff ff       	call   100da8 <delay>
    for (i = 0; !(inb(LPTPORT + 1) & 0x80) && i < 12800; i ++) {
  100fcd:	ff 45 fc             	incl   -0x4(%ebp)
  100fd0:	66 c7 45 fa 79 03    	movw   $0x379,-0x6(%ebp)
  100fd6:	0f b7 45 fa          	movzwl -0x6(%ebp),%eax
  100fda:	89 c2                	mov    %eax,%edx
  100fdc:	ec                   	in     (%dx),%al
  100fdd:	88 45 f9             	mov    %al,-0x7(%ebp)
    return data;
  100fe0:	0f b6 45 f9          	movzbl -0x7(%ebp),%eax
  100fe4:	84 c0                	test   %al,%al
  100fe6:	78 09                	js     100ff1 <lpt_putc_sub+0x38>
  100fe8:	81 7d fc ff 31 00 00 	cmpl   $0x31ff,-0x4(%ebp)
  100fef:	7e d7                	jle    100fc8 <lpt_putc_sub+0xf>
    }
    outb(LPTPORT + 0, c);
  100ff1:	8b 45 08             	mov    0x8(%ebp),%eax
  100ff4:	0f b6 c0             	movzbl %al,%eax
  100ff7:	66 c7 45 ee 78 03    	movw   $0x378,-0x12(%ebp)
  100ffd:	88 45 ed             	mov    %al,-0x13(%ebp)
    asm volatile ("outb %0, %1" :: "a" (data), "d" (port));
  101000:	0f b6 45 ed          	movzbl -0x13(%ebp),%eax
  101004:	0f b7 55 ee          	movzwl -0x12(%ebp),%edx
  101008:	ee                   	out    %al,(%dx)
  101009:	66 c7 45 f2 7a 03    	movw   $0x37a,-0xe(%ebp)
  10100f:	c6 45 f1 0d          	movb   $0xd,-0xf(%ebp)
  101013:	0f b6 45 f1          	movzbl -0xf(%ebp),%eax
  101017:	0f b7 55 f2          	movzwl -0xe(%ebp),%edx
  10101b:	ee                   	out    %al,(%dx)
  10101c:	66 c7 45 f6 7a 03    	movw   $0x37a,-0xa(%ebp)
  101022:	c6 45 f5 08          	movb   $0x8,-0xb(%ebp)
  101026:	0f b6 45 f5          	movzbl -0xb(%ebp),%eax
  10102a:	0f b7 55 f6          	movzwl -0xa(%ebp),%edx
  10102e:	ee                   	out    %al,(%dx)
    outb(LPTPORT + 2, 0x08 | 0x04 | 0x01);
    outb(LPTPORT + 2, 0x08);
}
  10102f:	90                   	nop
  101030:	c9                   	leave  
  101031:	c3                   	ret    

00101032 <lpt_putc>:

/* lpt_putc - copy console output to parallel port */
static void
lpt_putc(int c) {
  101032:	55                   	push   %ebp
  101033:	89 e5                	mov    %esp,%ebp
  101035:	83 ec 04             	sub    $0x4,%esp
    if (c != '\b') {
  101038:	83 7d 08 08          	cmpl   $0x8,0x8(%ebp)
  10103c:	74 0d                	je     10104b <lpt_putc+0x19>
        lpt_putc_sub(c);
  10103e:	8b 45 08             	mov    0x8(%ebp),%eax
  101041:	89 04 24             	mov    %eax,(%esp)
  101044:	e8 70 ff ff ff       	call   100fb9 <lpt_putc_sub>
    else {
        lpt_putc_sub('\b');
        lpt_putc_sub(' ');
        lpt_putc_sub('\b');
    }
}
  101049:	eb 24                	jmp    10106f <lpt_putc+0x3d>
        lpt_putc_sub('\b');
  10104b:	c7 04 24 08 00 00 00 	movl   $0x8,(%esp)
  101052:	e8 62 ff ff ff       	call   100fb9 <lpt_putc_sub>
        lpt_putc_sub(' ');
  101057:	c7 04 24 20 00 00 00 	movl   $0x20,(%esp)
  10105e:	e8 56 ff ff ff       	call   100fb9 <lpt_putc_sub>
        lpt_putc_sub('\b');
  101063:	c7 04 24 08 00 00 00 	movl   $0x8,(%esp)
  10106a:	e8 4a ff ff ff       	call   100fb9 <lpt_putc_sub>
}
  10106f:	90                   	nop
  101070:	c9                   	leave  
  101071:	c3                   	ret    

00101072 <cga_putc>:

/* cga_putc - print character to console */
static void
cga_putc(int c) {
  101072:	55                   	push   %ebp
  101073:	89 e5                	mov    %esp,%ebp
  101075:	53                   	push   %ebx
  101076:	83 ec 34             	sub    $0x34,%esp
    // set black on white
    if (!(c & ~0xFF)) {
  101079:	8b 45 08             	mov    0x8(%ebp),%eax
  10107c:	25 00 ff ff ff       	and    $0xffffff00,%eax
  101081:	85 c0                	test   %eax,%eax
  101083:	75 07                	jne    10108c <cga_putc+0x1a>
        c |= 0x0700;
  101085:	81 4d 08 00 07 00 00 	orl    $0x700,0x8(%ebp)
    }

    switch (c & 0xff) {
  10108c:	8b 45 08             	mov    0x8(%ebp),%eax
  10108f:	0f b6 c0             	movzbl %al,%eax
  101092:	83 f8 0a             	cmp    $0xa,%eax
  101095:	74 55                	je     1010ec <cga_putc+0x7a>
  101097:	83 f8 0d             	cmp    $0xd,%eax
  10109a:	74 63                	je     1010ff <cga_putc+0x8d>
  10109c:	83 f8 08             	cmp    $0x8,%eax
  10109f:	0f 85 94 00 00 00    	jne    101139 <cga_putc+0xc7>
    case '\b':
        if (crt_pos > 0) {
  1010a5:	0f b7 05 64 ee 10 00 	movzwl 0x10ee64,%eax
  1010ac:	85 c0                	test   %eax,%eax
  1010ae:	0f 84 af 00 00 00    	je     101163 <cga_putc+0xf1>
            crt_pos --;
  1010b4:	0f b7 05 64 ee 10 00 	movzwl 0x10ee64,%eax
  1010bb:	48                   	dec    %eax
  1010bc:	0f b7 c0             	movzwl %ax,%eax
  1010bf:	66 a3 64 ee 10 00    	mov    %ax,0x10ee64
            crt_buf[crt_pos] = (c & ~0xff) | ' ';
  1010c5:	8b 45 08             	mov    0x8(%ebp),%eax
  1010c8:	98                   	cwtl   
  1010c9:	25 00 ff ff ff       	and    $0xffffff00,%eax
  1010ce:	98                   	cwtl   
  1010cf:	83 c8 20             	or     $0x20,%eax
  1010d2:	98                   	cwtl   
  1010d3:	8b 15 60 ee 10 00    	mov    0x10ee60,%edx
  1010d9:	0f b7 0d 64 ee 10 00 	movzwl 0x10ee64,%ecx
  1010e0:	01 c9                	add    %ecx,%ecx
  1010e2:	01 ca                	add    %ecx,%edx
  1010e4:	0f b7 c0             	movzwl %ax,%eax
  1010e7:	66 89 02             	mov    %ax,(%edx)
        }
        break;
  1010ea:	eb 77                	jmp    101163 <cga_putc+0xf1>
    case '\n':
        crt_pos += CRT_COLS;
  1010ec:	0f b7 05 64 ee 10 00 	movzwl 0x10ee64,%eax
  1010f3:	83 c0 50             	add    $0x50,%eax
  1010f6:	0f b7 c0             	movzwl %ax,%eax
  1010f9:	66 a3 64 ee 10 00    	mov    %ax,0x10ee64
    case '\r':
        crt_pos -= (crt_pos % CRT_COLS);
  1010ff:	0f b7 1d 64 ee 10 00 	movzwl 0x10ee64,%ebx
  101106:	0f b7 0d 64 ee 10 00 	movzwl 0x10ee64,%ecx
  10110d:	ba cd cc cc cc       	mov    $0xcccccccd,%edx
  101112:	89 c8                	mov    %ecx,%eax
  101114:	f7 e2                	mul    %edx
  101116:	c1 ea 06             	shr    $0x6,%edx
  101119:	89 d0                	mov    %edx,%eax
  10111b:	c1 e0 02             	shl    $0x2,%eax
  10111e:	01 d0                	add    %edx,%eax
  101120:	c1 e0 04             	shl    $0x4,%eax
  101123:	29 c1                	sub    %eax,%ecx
  101125:	89 c8                	mov    %ecx,%eax
  101127:	0f b7 c0             	movzwl %ax,%eax
  10112a:	29 c3                	sub    %eax,%ebx
  10112c:	89 d8                	mov    %ebx,%eax
  10112e:	0f b7 c0             	movzwl %ax,%eax
  101131:	66 a3 64 ee 10 00    	mov    %ax,0x10ee64
        break;
  101137:	eb 2b                	jmp    101164 <cga_putc+0xf2>
    default:
        crt_buf[crt_pos ++] = c;     // write the character
  101139:	8b 0d 60 ee 10 00    	mov    0x10ee60,%ecx
  10113f:	0f b7 05 64 ee 10 00 	movzwl 0x10ee64,%eax
  101146:	8d 50 01             	lea    0x1(%eax),%edx
  101149:	0f b7 d2             	movzwl %dx,%edx
  10114c:	66 89 15 64 ee 10 00 	mov    %dx,0x10ee64
  101153:	01 c0                	add    %eax,%eax
  101155:	8d 14 01             	lea    (%ecx,%eax,1),%edx
  101158:	8b 45 08             	mov    0x8(%ebp),%eax
  10115b:	0f b7 c0             	movzwl %ax,%eax
  10115e:	66 89 02             	mov    %ax,(%edx)
        break;
  101161:	eb 01                	jmp    101164 <cga_putc+0xf2>
        break;
  101163:	90                   	nop
    }

    // What is the purpose of this?
    if (crt_pos >= CRT_SIZE) {
  101164:	0f b7 05 64 ee 10 00 	movzwl 0x10ee64,%eax
  10116b:	3d cf 07 00 00       	cmp    $0x7cf,%eax
  101170:	76 5d                	jbe    1011cf <cga_putc+0x15d>
        int i;
        memmove(crt_buf, crt_buf + CRT_COLS, (CRT_SIZE - CRT_COLS) * sizeof(uint16_t));
  101172:	a1 60 ee 10 00       	mov    0x10ee60,%eax
  101177:	8d 90 a0 00 00 00    	lea    0xa0(%eax),%edx
  10117d:	a1 60 ee 10 00       	mov    0x10ee60,%eax
  101182:	c7 44 24 08 00 0f 00 	movl   $0xf00,0x8(%esp)
  101189:	00 
  10118a:	89 54 24 04          	mov    %edx,0x4(%esp)
  10118e:	89 04 24             	mov    %eax,(%esp)
  101191:	e8 34 1a 00 00       	call   102bca <memmove>
        for (i = CRT_SIZE - CRT_COLS; i < CRT_SIZE; i ++) {
  101196:	c7 45 f4 80 07 00 00 	movl   $0x780,-0xc(%ebp)
  10119d:	eb 14                	jmp    1011b3 <cga_putc+0x141>
            crt_buf[i] = 0x0700 | ' ';
  10119f:	a1 60 ee 10 00       	mov    0x10ee60,%eax
  1011a4:	8b 55 f4             	mov    -0xc(%ebp),%edx
  1011a7:	01 d2                	add    %edx,%edx
  1011a9:	01 d0                	add    %edx,%eax
  1011ab:	66 c7 00 20 07       	movw   $0x720,(%eax)
        for (i = CRT_SIZE - CRT_COLS; i < CRT_SIZE; i ++) {
  1011b0:	ff 45 f4             	incl   -0xc(%ebp)
  1011b3:	81 7d f4 cf 07 00 00 	cmpl   $0x7cf,-0xc(%ebp)
  1011ba:	7e e3                	jle    10119f <cga_putc+0x12d>
        }
        crt_pos -= CRT_COLS;
  1011bc:	0f b7 05 64 ee 10 00 	movzwl 0x10ee64,%eax
  1011c3:	83 e8 50             	sub    $0x50,%eax
  1011c6:	0f b7 c0             	movzwl %ax,%eax
  1011c9:	66 a3 64 ee 10 00    	mov    %ax,0x10ee64
    }

    // move that little blinky thing
    outb(addr_6845, 14);
  1011cf:	0f b7 05 66 ee 10 00 	movzwl 0x10ee66,%eax
  1011d6:	66 89 45 e6          	mov    %ax,-0x1a(%ebp)
  1011da:	c6 45 e5 0e          	movb   $0xe,-0x1b(%ebp)
  1011de:	0f b6 45 e5          	movzbl -0x1b(%ebp),%eax
  1011e2:	0f b7 55 e6          	movzwl -0x1a(%ebp),%edx
  1011e6:	ee                   	out    %al,(%dx)
    outb(addr_6845 + 1, crt_pos >> 8);
  1011e7:	0f b7 05 64 ee 10 00 	movzwl 0x10ee64,%eax
  1011ee:	c1 e8 08             	shr    $0x8,%eax
  1011f1:	0f b7 c0             	movzwl %ax,%eax
  1011f4:	0f b6 c0             	movzbl %al,%eax
  1011f7:	0f b7 15 66 ee 10 00 	movzwl 0x10ee66,%edx
  1011fe:	42                   	inc    %edx
  1011ff:	0f b7 d2             	movzwl %dx,%edx
  101202:	66 89 55 ea          	mov    %dx,-0x16(%ebp)
  101206:	88 45 e9             	mov    %al,-0x17(%ebp)
  101209:	0f b6 45 e9          	movzbl -0x17(%ebp),%eax
  10120d:	0f b7 55 ea          	movzwl -0x16(%ebp),%edx
  101211:	ee                   	out    %al,(%dx)
    outb(addr_6845, 15);
  101212:	0f b7 05 66 ee 10 00 	movzwl 0x10ee66,%eax
  101219:	66 89 45 ee          	mov    %ax,-0x12(%ebp)
  10121d:	c6 45 ed 0f          	movb   $0xf,-0x13(%ebp)
  101221:	0f b6 45 ed          	movzbl -0x13(%ebp),%eax
  101225:	0f b7 55 ee          	movzwl -0x12(%ebp),%edx
  101229:	ee                   	out    %al,(%dx)
    outb(addr_6845 + 1, crt_pos);
  10122a:	0f b7 05 64 ee 10 00 	movzwl 0x10ee64,%eax
  101231:	0f b6 c0             	movzbl %al,%eax
  101234:	0f b7 15 66 ee 10 00 	movzwl 0x10ee66,%edx
  10123b:	42                   	inc    %edx
  10123c:	0f b7 d2             	movzwl %dx,%edx
  10123f:	66 89 55 f2          	mov    %dx,-0xe(%ebp)
  101243:	88 45 f1             	mov    %al,-0xf(%ebp)
  101246:	0f b6 45 f1          	movzbl -0xf(%ebp),%eax
  10124a:	0f b7 55 f2          	movzwl -0xe(%ebp),%edx
  10124e:	ee                   	out    %al,(%dx)
}
  10124f:	90                   	nop
  101250:	83 c4 34             	add    $0x34,%esp
  101253:	5b                   	pop    %ebx
  101254:	5d                   	pop    %ebp
  101255:	c3                   	ret    

00101256 <serial_putc_sub>:

static void
serial_putc_sub(int c) {
  101256:	55                   	push   %ebp
  101257:	89 e5                	mov    %esp,%ebp
  101259:	83 ec 10             	sub    $0x10,%esp
    int i;
    for (i = 0; !(inb(COM1 + COM_LSR) & COM_LSR_TXRDY) && i < 12800; i ++) {
  10125c:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  101263:	eb 08                	jmp    10126d <serial_putc_sub+0x17>
        delay();
  101265:	e8 3e fb ff ff       	call   100da8 <delay>
    for (i = 0; !(inb(COM1 + COM_LSR) & COM_LSR_TXRDY) && i < 12800; i ++) {
  10126a:	ff 45 fc             	incl   -0x4(%ebp)
  10126d:	66 c7 45 fa fd 03    	movw   $0x3fd,-0x6(%ebp)
    asm volatile ("inb %1, %0" : "=a" (data) : "d" (port));
  101273:	0f b7 45 fa          	movzwl -0x6(%ebp),%eax
  101277:	89 c2                	mov    %eax,%edx
  101279:	ec                   	in     (%dx),%al
  10127a:	88 45 f9             	mov    %al,-0x7(%ebp)
    return data;
  10127d:	0f b6 45 f9          	movzbl -0x7(%ebp),%eax
  101281:	0f b6 c0             	movzbl %al,%eax
  101284:	83 e0 20             	and    $0x20,%eax
  101287:	85 c0                	test   %eax,%eax
  101289:	75 09                	jne    101294 <serial_putc_sub+0x3e>
  10128b:	81 7d fc ff 31 00 00 	cmpl   $0x31ff,-0x4(%ebp)
  101292:	7e d1                	jle    101265 <serial_putc_sub+0xf>
    }
    outb(COM1 + COM_TX, c);
  101294:	8b 45 08             	mov    0x8(%ebp),%eax
  101297:	0f b6 c0             	movzbl %al,%eax
  10129a:	66 c7 45 f6 f8 03    	movw   $0x3f8,-0xa(%ebp)
  1012a0:	88 45 f5             	mov    %al,-0xb(%ebp)
    asm volatile ("outb %0, %1" :: "a" (data), "d" (port));
  1012a3:	0f b6 45 f5          	movzbl -0xb(%ebp),%eax
  1012a7:	0f b7 55 f6          	movzwl -0xa(%ebp),%edx
  1012ab:	ee                   	out    %al,(%dx)
}
  1012ac:	90                   	nop
  1012ad:	c9                   	leave  
  1012ae:	c3                   	ret    

001012af <serial_putc>:

/* serial_putc - print character to serial port */
static void
serial_putc(int c) {
  1012af:	55                   	push   %ebp
  1012b0:	89 e5                	mov    %esp,%ebp
  1012b2:	83 ec 04             	sub    $0x4,%esp
    if (c != '\b') {
  1012b5:	83 7d 08 08          	cmpl   $0x8,0x8(%ebp)
  1012b9:	74 0d                	je     1012c8 <serial_putc+0x19>
        serial_putc_sub(c);
  1012bb:	8b 45 08             	mov    0x8(%ebp),%eax
  1012be:	89 04 24             	mov    %eax,(%esp)
  1012c1:	e8 90 ff ff ff       	call   101256 <serial_putc_sub>
    else {
        serial_putc_sub('\b');
        serial_putc_sub(' ');
        serial_putc_sub('\b');
    }
}
  1012c6:	eb 24                	jmp    1012ec <serial_putc+0x3d>
        serial_putc_sub('\b');
  1012c8:	c7 04 24 08 00 00 00 	movl   $0x8,(%esp)
  1012cf:	e8 82 ff ff ff       	call   101256 <serial_putc_sub>
        serial_putc_sub(' ');
  1012d4:	c7 04 24 20 00 00 00 	movl   $0x20,(%esp)
  1012db:	e8 76 ff ff ff       	call   101256 <serial_putc_sub>
        serial_putc_sub('\b');
  1012e0:	c7 04 24 08 00 00 00 	movl   $0x8,(%esp)
  1012e7:	e8 6a ff ff ff       	call   101256 <serial_putc_sub>
}
  1012ec:	90                   	nop
  1012ed:	c9                   	leave  
  1012ee:	c3                   	ret    

001012ef <cons_intr>:
/* *
 * cons_intr - called by device interrupt routines to feed input
 * characters into the circular console input buffer.
 * */
static void
cons_intr(int (*proc)(void)) {
  1012ef:	55                   	push   %ebp
  1012f0:	89 e5                	mov    %esp,%ebp
  1012f2:	83 ec 18             	sub    $0x18,%esp
    int c;
    while ((c = (*proc)()) != -1) {
  1012f5:	eb 33                	jmp    10132a <cons_intr+0x3b>
        if (c != 0) {
  1012f7:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
  1012fb:	74 2d                	je     10132a <cons_intr+0x3b>
            cons.buf[cons.wpos ++] = c;
  1012fd:	a1 84 f0 10 00       	mov    0x10f084,%eax
  101302:	8d 50 01             	lea    0x1(%eax),%edx
  101305:	89 15 84 f0 10 00    	mov    %edx,0x10f084
  10130b:	8b 55 f4             	mov    -0xc(%ebp),%edx
  10130e:	88 90 80 ee 10 00    	mov    %dl,0x10ee80(%eax)
            if (cons.wpos == CONSBUFSIZE) {
  101314:	a1 84 f0 10 00       	mov    0x10f084,%eax
  101319:	3d 00 02 00 00       	cmp    $0x200,%eax
  10131e:	75 0a                	jne    10132a <cons_intr+0x3b>
                cons.wpos = 0;
  101320:	c7 05 84 f0 10 00 00 	movl   $0x0,0x10f084
  101327:	00 00 00 
    while ((c = (*proc)()) != -1) {
  10132a:	8b 45 08             	mov    0x8(%ebp),%eax
  10132d:	ff d0                	call   *%eax
  10132f:	89 45 f4             	mov    %eax,-0xc(%ebp)
  101332:	83 7d f4 ff          	cmpl   $0xffffffff,-0xc(%ebp)
  101336:	75 bf                	jne    1012f7 <cons_intr+0x8>
            }
        }
    }
}
  101338:	90                   	nop
  101339:	c9                   	leave  
  10133a:	c3                   	ret    

0010133b <serial_proc_data>:

/* serial_proc_data - get data from serial port */
static int
serial_proc_data(void) {
  10133b:	55                   	push   %ebp
  10133c:	89 e5                	mov    %esp,%ebp
  10133e:	83 ec 10             	sub    $0x10,%esp
  101341:	66 c7 45 fa fd 03    	movw   $0x3fd,-0x6(%ebp)
    asm volatile ("inb %1, %0" : "=a" (data) : "d" (port));
  101347:	0f b7 45 fa          	movzwl -0x6(%ebp),%eax
  10134b:	89 c2                	mov    %eax,%edx
  10134d:	ec                   	in     (%dx),%al
  10134e:	88 45 f9             	mov    %al,-0x7(%ebp)
    return data;
  101351:	0f b6 45 f9          	movzbl -0x7(%ebp),%eax
    if (!(inb(COM1 + COM_LSR) & COM_LSR_DATA)) {
  101355:	0f b6 c0             	movzbl %al,%eax
  101358:	83 e0 01             	and    $0x1,%eax
  10135b:	85 c0                	test   %eax,%eax
  10135d:	75 07                	jne    101366 <serial_proc_data+0x2b>
        return -1;
  10135f:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
  101364:	eb 2a                	jmp    101390 <serial_proc_data+0x55>
  101366:	66 c7 45 f6 f8 03    	movw   $0x3f8,-0xa(%ebp)
    asm volatile ("inb %1, %0" : "=a" (data) : "d" (port));
  10136c:	0f b7 45 f6          	movzwl -0xa(%ebp),%eax
  101370:	89 c2                	mov    %eax,%edx
  101372:	ec                   	in     (%dx),%al
  101373:	88 45 f5             	mov    %al,-0xb(%ebp)
    return data;
  101376:	0f b6 45 f5          	movzbl -0xb(%ebp),%eax
    }
    int c = inb(COM1 + COM_RX);
  10137a:	0f b6 c0             	movzbl %al,%eax
  10137d:	89 45 fc             	mov    %eax,-0x4(%ebp)
    if (c == 127) {
  101380:	83 7d fc 7f          	cmpl   $0x7f,-0x4(%ebp)
  101384:	75 07                	jne    10138d <serial_proc_data+0x52>
        c = '\b';
  101386:	c7 45 fc 08 00 00 00 	movl   $0x8,-0x4(%ebp)
    }
    return c;
  10138d:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
  101390:	c9                   	leave  
  101391:	c3                   	ret    

00101392 <serial_intr>:

/* serial_intr - try to feed input characters from serial port */
void
serial_intr(void) {
  101392:	55                   	push   %ebp
  101393:	89 e5                	mov    %esp,%ebp
  101395:	83 ec 18             	sub    $0x18,%esp
    if (serial_exists) {
  101398:	a1 68 ee 10 00       	mov    0x10ee68,%eax
  10139d:	85 c0                	test   %eax,%eax
  10139f:	74 0c                	je     1013ad <serial_intr+0x1b>
        cons_intr(serial_proc_data);
  1013a1:	c7 04 24 3b 13 10 00 	movl   $0x10133b,(%esp)
  1013a8:	e8 42 ff ff ff       	call   1012ef <cons_intr>
    }
}
  1013ad:	90                   	nop
  1013ae:	c9                   	leave  
  1013af:	c3                   	ret    

001013b0 <kbd_proc_data>:
 *
 * The kbd_proc_data() function gets data from the keyboard.
 * If we finish a character, return it, else 0. And return -1 if no data.
 * */
static int
kbd_proc_data(void) {
  1013b0:	55                   	push   %ebp
  1013b1:	89 e5                	mov    %esp,%ebp
  1013b3:	83 ec 38             	sub    $0x38,%esp
  1013b6:	66 c7 45 f0 64 00    	movw   $0x64,-0x10(%ebp)
    asm volatile ("inb %1, %0" : "=a" (data) : "d" (port));
  1013bc:	8b 45 f0             	mov    -0x10(%ebp),%eax
  1013bf:	89 c2                	mov    %eax,%edx
  1013c1:	ec                   	in     (%dx),%al
  1013c2:	88 45 ef             	mov    %al,-0x11(%ebp)
    return data;
  1013c5:	0f b6 45 ef          	movzbl -0x11(%ebp),%eax
    int c;
    uint8_t data;
    static uint32_t shift;

    if ((inb(KBSTATP) & KBS_DIB) == 0) {
  1013c9:	0f b6 c0             	movzbl %al,%eax
  1013cc:	83 e0 01             	and    $0x1,%eax
  1013cf:	85 c0                	test   %eax,%eax
  1013d1:	75 0a                	jne    1013dd <kbd_proc_data+0x2d>
        return -1;
  1013d3:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
  1013d8:	e9 55 01 00 00       	jmp    101532 <kbd_proc_data+0x182>
  1013dd:	66 c7 45 ec 60 00    	movw   $0x60,-0x14(%ebp)
    asm volatile ("inb %1, %0" : "=a" (data) : "d" (port));
  1013e3:	8b 45 ec             	mov    -0x14(%ebp),%eax
  1013e6:	89 c2                	mov    %eax,%edx
  1013e8:	ec                   	in     (%dx),%al
  1013e9:	88 45 eb             	mov    %al,-0x15(%ebp)
    return data;
  1013ec:	0f b6 45 eb          	movzbl -0x15(%ebp),%eax
    }

    data = inb(KBDATAP);
  1013f0:	88 45 f3             	mov    %al,-0xd(%ebp)

    if (data == 0xE0) {
  1013f3:	80 7d f3 e0          	cmpb   $0xe0,-0xd(%ebp)
  1013f7:	75 17                	jne    101410 <kbd_proc_data+0x60>
        // E0 escape character
        shift |= E0ESC;
  1013f9:	a1 88 f0 10 00       	mov    0x10f088,%eax
  1013fe:	83 c8 40             	or     $0x40,%eax
  101401:	a3 88 f0 10 00       	mov    %eax,0x10f088
        return 0;
  101406:	b8 00 00 00 00       	mov    $0x0,%eax
  10140b:	e9 22 01 00 00       	jmp    101532 <kbd_proc_data+0x182>
    } else if (data & 0x80) {
  101410:	0f b6 45 f3          	movzbl -0xd(%ebp),%eax
  101414:	84 c0                	test   %al,%al
  101416:	79 45                	jns    10145d <kbd_proc_data+0xad>
        // Key released
        data = (shift & E0ESC ? data : data & 0x7F);
  101418:	a1 88 f0 10 00       	mov    0x10f088,%eax
  10141d:	83 e0 40             	and    $0x40,%eax
  101420:	85 c0                	test   %eax,%eax
  101422:	75 08                	jne    10142c <kbd_proc_data+0x7c>
  101424:	0f b6 45 f3          	movzbl -0xd(%ebp),%eax
  101428:	24 7f                	and    $0x7f,%al
  10142a:	eb 04                	jmp    101430 <kbd_proc_data+0x80>
  10142c:	0f b6 45 f3          	movzbl -0xd(%ebp),%eax
  101430:	88 45 f3             	mov    %al,-0xd(%ebp)
        shift &= ~(shiftcode[data] | E0ESC);
  101433:	0f b6 45 f3          	movzbl -0xd(%ebp),%eax
  101437:	0f b6 80 40 e0 10 00 	movzbl 0x10e040(%eax),%eax
  10143e:	0c 40                	or     $0x40,%al
  101440:	0f b6 c0             	movzbl %al,%eax
  101443:	f7 d0                	not    %eax
  101445:	89 c2                	mov    %eax,%edx
  101447:	a1 88 f0 10 00       	mov    0x10f088,%eax
  10144c:	21 d0                	and    %edx,%eax
  10144e:	a3 88 f0 10 00       	mov    %eax,0x10f088
        return 0;
  101453:	b8 00 00 00 00       	mov    $0x0,%eax
  101458:	e9 d5 00 00 00       	jmp    101532 <kbd_proc_data+0x182>
    } else if (shift & E0ESC) {
  10145d:	a1 88 f0 10 00       	mov    0x10f088,%eax
  101462:	83 e0 40             	and    $0x40,%eax
  101465:	85 c0                	test   %eax,%eax
  101467:	74 11                	je     10147a <kbd_proc_data+0xca>
        // Last character was an E0 escape; or with 0x80
        data |= 0x80;
  101469:	80 4d f3 80          	orb    $0x80,-0xd(%ebp)
        shift &= ~E0ESC;
  10146d:	a1 88 f0 10 00       	mov    0x10f088,%eax
  101472:	83 e0 bf             	and    $0xffffffbf,%eax
  101475:	a3 88 f0 10 00       	mov    %eax,0x10f088
    }

    shift |= shiftcode[data];
  10147a:	0f b6 45 f3          	movzbl -0xd(%ebp),%eax
  10147e:	0f b6 80 40 e0 10 00 	movzbl 0x10e040(%eax),%eax
  101485:	0f b6 d0             	movzbl %al,%edx
  101488:	a1 88 f0 10 00       	mov    0x10f088,%eax
  10148d:	09 d0                	or     %edx,%eax
  10148f:	a3 88 f0 10 00       	mov    %eax,0x10f088
    shift ^= togglecode[data];
  101494:	0f b6 45 f3          	movzbl -0xd(%ebp),%eax
  101498:	0f b6 80 40 e1 10 00 	movzbl 0x10e140(%eax),%eax
  10149f:	0f b6 d0             	movzbl %al,%edx
  1014a2:	a1 88 f0 10 00       	mov    0x10f088,%eax
  1014a7:	31 d0                	xor    %edx,%eax
  1014a9:	a3 88 f0 10 00       	mov    %eax,0x10f088

    c = charcode[shift & (CTL | SHIFT)][data];
  1014ae:	a1 88 f0 10 00       	mov    0x10f088,%eax
  1014b3:	83 e0 03             	and    $0x3,%eax
  1014b6:	8b 14 85 40 e5 10 00 	mov    0x10e540(,%eax,4),%edx
  1014bd:	0f b6 45 f3          	movzbl -0xd(%ebp),%eax
  1014c1:	01 d0                	add    %edx,%eax
  1014c3:	0f b6 00             	movzbl (%eax),%eax
  1014c6:	0f b6 c0             	movzbl %al,%eax
  1014c9:	89 45 f4             	mov    %eax,-0xc(%ebp)
    if (shift & CAPSLOCK) {
  1014cc:	a1 88 f0 10 00       	mov    0x10f088,%eax
  1014d1:	83 e0 08             	and    $0x8,%eax
  1014d4:	85 c0                	test   %eax,%eax
  1014d6:	74 22                	je     1014fa <kbd_proc_data+0x14a>
        if ('a' <= c && c <= 'z')
  1014d8:	83 7d f4 60          	cmpl   $0x60,-0xc(%ebp)
  1014dc:	7e 0c                	jle    1014ea <kbd_proc_data+0x13a>
  1014de:	83 7d f4 7a          	cmpl   $0x7a,-0xc(%ebp)
  1014e2:	7f 06                	jg     1014ea <kbd_proc_data+0x13a>
            c += 'A' - 'a';
  1014e4:	83 6d f4 20          	subl   $0x20,-0xc(%ebp)
  1014e8:	eb 10                	jmp    1014fa <kbd_proc_data+0x14a>
        else if ('A' <= c && c <= 'Z')
  1014ea:	83 7d f4 40          	cmpl   $0x40,-0xc(%ebp)
  1014ee:	7e 0a                	jle    1014fa <kbd_proc_data+0x14a>
  1014f0:	83 7d f4 5a          	cmpl   $0x5a,-0xc(%ebp)
  1014f4:	7f 04                	jg     1014fa <kbd_proc_data+0x14a>
            c += 'a' - 'A';
  1014f6:	83 45 f4 20          	addl   $0x20,-0xc(%ebp)
    }

    // Process special keys
    // Ctrl-Alt-Del: reboot
    if (!(~shift & (CTL | ALT)) && c == KEY_DEL) {
  1014fa:	a1 88 f0 10 00       	mov    0x10f088,%eax
  1014ff:	f7 d0                	not    %eax
  101501:	83 e0 06             	and    $0x6,%eax
  101504:	85 c0                	test   %eax,%eax
  101506:	75 27                	jne    10152f <kbd_proc_data+0x17f>
  101508:	81 7d f4 e9 00 00 00 	cmpl   $0xe9,-0xc(%ebp)
  10150f:	75 1e                	jne    10152f <kbd_proc_data+0x17f>
        cprintf("Rebooting!\n");
  101511:	c7 04 24 e1 36 10 00 	movl   $0x1036e1,(%esp)
  101518:	e8 3f ed ff ff       	call   10025c <cprintf>
  10151d:	66 c7 45 e8 92 00    	movw   $0x92,-0x18(%ebp)
  101523:	c6 45 e7 03          	movb   $0x3,-0x19(%ebp)
    asm volatile ("outb %0, %1" :: "a" (data), "d" (port));
  101527:	0f b6 45 e7          	movzbl -0x19(%ebp),%eax
  10152b:	8b 55 e8             	mov    -0x18(%ebp),%edx
  10152e:	ee                   	out    %al,(%dx)
        outb(0x92, 0x3); // courtesy of Chris Frost
    }
    return c;
  10152f:	8b 45 f4             	mov    -0xc(%ebp),%eax
}
  101532:	c9                   	leave  
  101533:	c3                   	ret    

00101534 <kbd_intr>:

/* kbd_intr - try to feed input characters from keyboard */
static void
kbd_intr(void) {
  101534:	55                   	push   %ebp
  101535:	89 e5                	mov    %esp,%ebp
  101537:	83 ec 18             	sub    $0x18,%esp
    cons_intr(kbd_proc_data);
  10153a:	c7 04 24 b0 13 10 00 	movl   $0x1013b0,(%esp)
  101541:	e8 a9 fd ff ff       	call   1012ef <cons_intr>
}
  101546:	90                   	nop
  101547:	c9                   	leave  
  101548:	c3                   	ret    

00101549 <kbd_init>:

static void
kbd_init(void) {
  101549:	55                   	push   %ebp
  10154a:	89 e5                	mov    %esp,%ebp
  10154c:	83 ec 18             	sub    $0x18,%esp
    // drain the kbd buffer
    kbd_intr();
  10154f:	e8 e0 ff ff ff       	call   101534 <kbd_intr>
    pic_enable(IRQ_KBD);
  101554:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
  10155b:	e8 0f 01 00 00       	call   10166f <pic_enable>
}
  101560:	90                   	nop
  101561:	c9                   	leave  
  101562:	c3                   	ret    

00101563 <cons_init>:

/* cons_init - initializes the console devices */
void
cons_init(void) {
  101563:	55                   	push   %ebp
  101564:	89 e5                	mov    %esp,%ebp
  101566:	83 ec 18             	sub    $0x18,%esp
    cga_init();
  101569:	e8 83 f8 ff ff       	call   100df1 <cga_init>
    serial_init();
  10156e:	e8 62 f9 ff ff       	call   100ed5 <serial_init>
    kbd_init();
  101573:	e8 d1 ff ff ff       	call   101549 <kbd_init>
    if (!serial_exists) {
  101578:	a1 68 ee 10 00       	mov    0x10ee68,%eax
  10157d:	85 c0                	test   %eax,%eax
  10157f:	75 0c                	jne    10158d <cons_init+0x2a>
        cprintf("serial port does not exist!!\n");
  101581:	c7 04 24 ed 36 10 00 	movl   $0x1036ed,(%esp)
  101588:	e8 cf ec ff ff       	call   10025c <cprintf>
    }
}
  10158d:	90                   	nop
  10158e:	c9                   	leave  
  10158f:	c3                   	ret    

00101590 <cons_putc>:

/* cons_putc - print a single character @c to console devices */
void
cons_putc(int c) {
  101590:	55                   	push   %ebp
  101591:	89 e5                	mov    %esp,%ebp
  101593:	83 ec 18             	sub    $0x18,%esp
    lpt_putc(c);
  101596:	8b 45 08             	mov    0x8(%ebp),%eax
  101599:	89 04 24             	mov    %eax,(%esp)
  10159c:	e8 91 fa ff ff       	call   101032 <lpt_putc>
    cga_putc(c);
  1015a1:	8b 45 08             	mov    0x8(%ebp),%eax
  1015a4:	89 04 24             	mov    %eax,(%esp)
  1015a7:	e8 c6 fa ff ff       	call   101072 <cga_putc>
    serial_putc(c);
  1015ac:	8b 45 08             	mov    0x8(%ebp),%eax
  1015af:	89 04 24             	mov    %eax,(%esp)
  1015b2:	e8 f8 fc ff ff       	call   1012af <serial_putc>
}
  1015b7:	90                   	nop
  1015b8:	c9                   	leave  
  1015b9:	c3                   	ret    

001015ba <cons_getc>:
/* *
 * cons_getc - return the next input character from console,
 * or 0 if none waiting.
 * */
int
cons_getc(void) {
  1015ba:	55                   	push   %ebp
  1015bb:	89 e5                	mov    %esp,%ebp
  1015bd:	83 ec 18             	sub    $0x18,%esp
    int c;

    // poll for any pending input characters,
    // so that this function works even when interrupts are disabled
    // (e.g., when called from the kernel monitor).
    serial_intr();
  1015c0:	e8 cd fd ff ff       	call   101392 <serial_intr>
    kbd_intr();
  1015c5:	e8 6a ff ff ff       	call   101534 <kbd_intr>

    // grab the next character from the input buffer.
    if (cons.rpos != cons.wpos) {
  1015ca:	8b 15 80 f0 10 00    	mov    0x10f080,%edx
  1015d0:	a1 84 f0 10 00       	mov    0x10f084,%eax
  1015d5:	39 c2                	cmp    %eax,%edx
  1015d7:	74 36                	je     10160f <cons_getc+0x55>
        c = cons.buf[cons.rpos ++];
  1015d9:	a1 80 f0 10 00       	mov    0x10f080,%eax
  1015de:	8d 50 01             	lea    0x1(%eax),%edx
  1015e1:	89 15 80 f0 10 00    	mov    %edx,0x10f080
  1015e7:	0f b6 80 80 ee 10 00 	movzbl 0x10ee80(%eax),%eax
  1015ee:	0f b6 c0             	movzbl %al,%eax
  1015f1:	89 45 f4             	mov    %eax,-0xc(%ebp)
        if (cons.rpos == CONSBUFSIZE) {
  1015f4:	a1 80 f0 10 00       	mov    0x10f080,%eax
  1015f9:	3d 00 02 00 00       	cmp    $0x200,%eax
  1015fe:	75 0a                	jne    10160a <cons_getc+0x50>
            cons.rpos = 0;
  101600:	c7 05 80 f0 10 00 00 	movl   $0x0,0x10f080
  101607:	00 00 00 
        }
        return c;
  10160a:	8b 45 f4             	mov    -0xc(%ebp),%eax
  10160d:	eb 05                	jmp    101614 <cons_getc+0x5a>
    }
    return 0;
  10160f:	b8 00 00 00 00       	mov    $0x0,%eax
}
  101614:	c9                   	leave  
  101615:	c3                   	ret    

00101616 <pic_setmask>:
// Initial IRQ mask has interrupt 2 enabled (for slave 8259A).
static uint16_t irq_mask = 0xFFFF & ~(1 << IRQ_SLAVE);
static bool did_init = 0;

static void
pic_setmask(uint16_t mask) {
  101616:	55                   	push   %ebp
  101617:	89 e5                	mov    %esp,%ebp
  101619:	83 ec 14             	sub    $0x14,%esp
  10161c:	8b 45 08             	mov    0x8(%ebp),%eax
  10161f:	66 89 45 ec          	mov    %ax,-0x14(%ebp)
    irq_mask = mask;
  101623:	8b 45 ec             	mov    -0x14(%ebp),%eax
  101626:	66 a3 50 e5 10 00    	mov    %ax,0x10e550
    if (did_init) {
  10162c:	a1 8c f0 10 00       	mov    0x10f08c,%eax
  101631:	85 c0                	test   %eax,%eax
  101633:	74 37                	je     10166c <pic_setmask+0x56>
        outb(IO_PIC1 + 1, mask);
  101635:	8b 45 ec             	mov    -0x14(%ebp),%eax
  101638:	0f b6 c0             	movzbl %al,%eax
  10163b:	66 c7 45 fa 21 00    	movw   $0x21,-0x6(%ebp)
  101641:	88 45 f9             	mov    %al,-0x7(%ebp)
  101644:	0f b6 45 f9          	movzbl -0x7(%ebp),%eax
  101648:	0f b7 55 fa          	movzwl -0x6(%ebp),%edx
  10164c:	ee                   	out    %al,(%dx)
        outb(IO_PIC2 + 1, mask >> 8);
  10164d:	0f b7 45 ec          	movzwl -0x14(%ebp),%eax
  101651:	c1 e8 08             	shr    $0x8,%eax
  101654:	0f b7 c0             	movzwl %ax,%eax
  101657:	0f b6 c0             	movzbl %al,%eax
  10165a:	66 c7 45 fe a1 00    	movw   $0xa1,-0x2(%ebp)
  101660:	88 45 fd             	mov    %al,-0x3(%ebp)
  101663:	0f b6 45 fd          	movzbl -0x3(%ebp),%eax
  101667:	0f b7 55 fe          	movzwl -0x2(%ebp),%edx
  10166b:	ee                   	out    %al,(%dx)
    }
}
  10166c:	90                   	nop
  10166d:	c9                   	leave  
  10166e:	c3                   	ret    

0010166f <pic_enable>:

void
pic_enable(unsigned int irq) {
  10166f:	55                   	push   %ebp
  101670:	89 e5                	mov    %esp,%ebp
  101672:	83 ec 04             	sub    $0x4,%esp
    pic_setmask(irq_mask & ~(1 << irq));
  101675:	8b 45 08             	mov    0x8(%ebp),%eax
  101678:	ba 01 00 00 00       	mov    $0x1,%edx
  10167d:	88 c1                	mov    %al,%cl
  10167f:	d3 e2                	shl    %cl,%edx
  101681:	89 d0                	mov    %edx,%eax
  101683:	98                   	cwtl   
  101684:	f7 d0                	not    %eax
  101686:	0f bf d0             	movswl %ax,%edx
  101689:	0f b7 05 50 e5 10 00 	movzwl 0x10e550,%eax
  101690:	98                   	cwtl   
  101691:	21 d0                	and    %edx,%eax
  101693:	98                   	cwtl   
  101694:	0f b7 c0             	movzwl %ax,%eax
  101697:	89 04 24             	mov    %eax,(%esp)
  10169a:	e8 77 ff ff ff       	call   101616 <pic_setmask>
}
  10169f:	90                   	nop
  1016a0:	c9                   	leave  
  1016a1:	c3                   	ret    

001016a2 <pic_init>:

/* pic_init - initialize the 8259A interrupt controllers */
void
pic_init(void) {
  1016a2:	55                   	push   %ebp
  1016a3:	89 e5                	mov    %esp,%ebp
  1016a5:	83 ec 44             	sub    $0x44,%esp
    did_init = 1;
  1016a8:	c7 05 8c f0 10 00 01 	movl   $0x1,0x10f08c
  1016af:	00 00 00 
  1016b2:	66 c7 45 ca 21 00    	movw   $0x21,-0x36(%ebp)
  1016b8:	c6 45 c9 ff          	movb   $0xff,-0x37(%ebp)
  1016bc:	0f b6 45 c9          	movzbl -0x37(%ebp),%eax
  1016c0:	0f b7 55 ca          	movzwl -0x36(%ebp),%edx
  1016c4:	ee                   	out    %al,(%dx)
  1016c5:	66 c7 45 ce a1 00    	movw   $0xa1,-0x32(%ebp)
  1016cb:	c6 45 cd ff          	movb   $0xff,-0x33(%ebp)
  1016cf:	0f b6 45 cd          	movzbl -0x33(%ebp),%eax
  1016d3:	0f b7 55 ce          	movzwl -0x32(%ebp),%edx
  1016d7:	ee                   	out    %al,(%dx)
  1016d8:	66 c7 45 d2 20 00    	movw   $0x20,-0x2e(%ebp)
  1016de:	c6 45 d1 11          	movb   $0x11,-0x2f(%ebp)
  1016e2:	0f b6 45 d1          	movzbl -0x2f(%ebp),%eax
  1016e6:	0f b7 55 d2          	movzwl -0x2e(%ebp),%edx
  1016ea:	ee                   	out    %al,(%dx)
  1016eb:	66 c7 45 d6 21 00    	movw   $0x21,-0x2a(%ebp)
  1016f1:	c6 45 d5 20          	movb   $0x20,-0x2b(%ebp)
  1016f5:	0f b6 45 d5          	movzbl -0x2b(%ebp),%eax
  1016f9:	0f b7 55 d6          	movzwl -0x2a(%ebp),%edx
  1016fd:	ee                   	out    %al,(%dx)
  1016fe:	66 c7 45 da 21 00    	movw   $0x21,-0x26(%ebp)
  101704:	c6 45 d9 04          	movb   $0x4,-0x27(%ebp)
  101708:	0f b6 45 d9          	movzbl -0x27(%ebp),%eax
  10170c:	0f b7 55 da          	movzwl -0x26(%ebp),%edx
  101710:	ee                   	out    %al,(%dx)
  101711:	66 c7 45 de 21 00    	movw   $0x21,-0x22(%ebp)
  101717:	c6 45 dd 03          	movb   $0x3,-0x23(%ebp)
  10171b:	0f b6 45 dd          	movzbl -0x23(%ebp),%eax
  10171f:	0f b7 55 de          	movzwl -0x22(%ebp),%edx
  101723:	ee                   	out    %al,(%dx)
  101724:	66 c7 45 e2 a0 00    	movw   $0xa0,-0x1e(%ebp)
  10172a:	c6 45 e1 11          	movb   $0x11,-0x1f(%ebp)
  10172e:	0f b6 45 e1          	movzbl -0x1f(%ebp),%eax
  101732:	0f b7 55 e2          	movzwl -0x1e(%ebp),%edx
  101736:	ee                   	out    %al,(%dx)
  101737:	66 c7 45 e6 a1 00    	movw   $0xa1,-0x1a(%ebp)
  10173d:	c6 45 e5 28          	movb   $0x28,-0x1b(%ebp)
  101741:	0f b6 45 e5          	movzbl -0x1b(%ebp),%eax
  101745:	0f b7 55 e6          	movzwl -0x1a(%ebp),%edx
  101749:	ee                   	out    %al,(%dx)
  10174a:	66 c7 45 ea a1 00    	movw   $0xa1,-0x16(%ebp)
  101750:	c6 45 e9 02          	movb   $0x2,-0x17(%ebp)
  101754:	0f b6 45 e9          	movzbl -0x17(%ebp),%eax
  101758:	0f b7 55 ea          	movzwl -0x16(%ebp),%edx
  10175c:	ee                   	out    %al,(%dx)
  10175d:	66 c7 45 ee a1 00    	movw   $0xa1,-0x12(%ebp)
  101763:	c6 45 ed 03          	movb   $0x3,-0x13(%ebp)
  101767:	0f b6 45 ed          	movzbl -0x13(%ebp),%eax
  10176b:	0f b7 55 ee          	movzwl -0x12(%ebp),%edx
  10176f:	ee                   	out    %al,(%dx)
  101770:	66 c7 45 f2 20 00    	movw   $0x20,-0xe(%ebp)
  101776:	c6 45 f1 68          	movb   $0x68,-0xf(%ebp)
  10177a:	0f b6 45 f1          	movzbl -0xf(%ebp),%eax
  10177e:	0f b7 55 f2          	movzwl -0xe(%ebp),%edx
  101782:	ee                   	out    %al,(%dx)
  101783:	66 c7 45 f6 20 00    	movw   $0x20,-0xa(%ebp)
  101789:	c6 45 f5 0a          	movb   $0xa,-0xb(%ebp)
  10178d:	0f b6 45 f5          	movzbl -0xb(%ebp),%eax
  101791:	0f b7 55 f6          	movzwl -0xa(%ebp),%edx
  101795:	ee                   	out    %al,(%dx)
  101796:	66 c7 45 fa a0 00    	movw   $0xa0,-0x6(%ebp)
  10179c:	c6 45 f9 68          	movb   $0x68,-0x7(%ebp)
  1017a0:	0f b6 45 f9          	movzbl -0x7(%ebp),%eax
  1017a4:	0f b7 55 fa          	movzwl -0x6(%ebp),%edx
  1017a8:	ee                   	out    %al,(%dx)
  1017a9:	66 c7 45 fe a0 00    	movw   $0xa0,-0x2(%ebp)
  1017af:	c6 45 fd 0a          	movb   $0xa,-0x3(%ebp)
  1017b3:	0f b6 45 fd          	movzbl -0x3(%ebp),%eax
  1017b7:	0f b7 55 fe          	movzwl -0x2(%ebp),%edx
  1017bb:	ee                   	out    %al,(%dx)
    outb(IO_PIC1, 0x0a);    // read IRR by default

    outb(IO_PIC2, 0x68);    // OCW3
    outb(IO_PIC2, 0x0a);    // OCW3

    if (irq_mask != 0xFFFF) {
  1017bc:	0f b7 05 50 e5 10 00 	movzwl 0x10e550,%eax
  1017c3:	3d ff ff 00 00       	cmp    $0xffff,%eax
  1017c8:	74 0f                	je     1017d9 <pic_init+0x137>
        pic_setmask(irq_mask);
  1017ca:	0f b7 05 50 e5 10 00 	movzwl 0x10e550,%eax
  1017d1:	89 04 24             	mov    %eax,(%esp)
  1017d4:	e8 3d fe ff ff       	call   101616 <pic_setmask>
    }
}
  1017d9:	90                   	nop
  1017da:	c9                   	leave  
  1017db:	c3                   	ret    

001017dc <intr_enable>:
#include <x86.h>
#include <intr.h>

/* intr_enable - enable irq interrupt */
void
intr_enable(void) {
  1017dc:	55                   	push   %ebp
  1017dd:	89 e5                	mov    %esp,%ebp
    asm volatile ("lidt (%0)" :: "r" (pd));
}

static inline void
sti(void) {
    asm volatile ("sti");
  1017df:	fb                   	sti    
    sti();
}
  1017e0:	90                   	nop
  1017e1:	5d                   	pop    %ebp
  1017e2:	c3                   	ret    

001017e3 <intr_disable>:

/* intr_disable - disable irq interrupt */
void
intr_disable(void) {
  1017e3:	55                   	push   %ebp
  1017e4:	89 e5                	mov    %esp,%ebp
}

static inline void
cli(void) {
    asm volatile ("cli");
  1017e6:	fa                   	cli    
    cli();
}
  1017e7:	90                   	nop
  1017e8:	5d                   	pop    %ebp
  1017e9:	c3                   	ret    

001017ea <print_ticks>:
#include <console.h>
#include <kdebug.h>

#define TICK_NUM 100

static void print_ticks() {
  1017ea:	55                   	push   %ebp
  1017eb:	89 e5                	mov    %esp,%ebp
  1017ed:	83 ec 18             	sub    $0x18,%esp
    cprintf("%d ticks\n",TICK_NUM);
  1017f0:	c7 44 24 04 64 00 00 	movl   $0x64,0x4(%esp)
  1017f7:	00 
  1017f8:	c7 04 24 20 37 10 00 	movl   $0x103720,(%esp)
  1017ff:	e8 58 ea ff ff       	call   10025c <cprintf>
#ifdef DEBUG_GRADE
    cprintf("End of Test.\n");
    panic("EOT: kernel seems ok.");
#endif
}
  101804:	90                   	nop
  101805:	c9                   	leave  
  101806:	c3                   	ret    

00101807 <idt_init>:
    sizeof(idt) - 1, (uintptr_t)idt
};

/* idt_init - initialize IDT to each of the entry points in kern/trap/vectors.S */
void
idt_init(void) {
  101807:	55                   	push   %ebp
  101808:	89 e5                	mov    %esp,%ebp
  10180a:	83 ec 10             	sub    $0x10,%esp
      *     You don't know the meaning of this instruction? just google it! and check the libs/x86.h to know more.
      *     Notice: the argument of lidt is idt_pd. try to find it!
      */
      extern uintptr_t __vectors[];

     for (int i = 0; i < 256; i++) {
  10180d:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  101814:	e9 c4 00 00 00       	jmp    1018dd <idt_init+0xd6>
         SETGATE(idt[i], 0, GD_KTEXT, __vectors[i], DPL_KERNEL);
  101819:	8b 45 fc             	mov    -0x4(%ebp),%eax
  10181c:	8b 04 85 e0 e5 10 00 	mov    0x10e5e0(,%eax,4),%eax
  101823:	0f b7 d0             	movzwl %ax,%edx
  101826:	8b 45 fc             	mov    -0x4(%ebp),%eax
  101829:	66 89 14 c5 a0 f0 10 	mov    %dx,0x10f0a0(,%eax,8)
  101830:	00 
  101831:	8b 45 fc             	mov    -0x4(%ebp),%eax
  101834:	66 c7 04 c5 a2 f0 10 	movw   $0x8,0x10f0a2(,%eax,8)
  10183b:	00 08 00 
  10183e:	8b 45 fc             	mov    -0x4(%ebp),%eax
  101841:	0f b6 14 c5 a4 f0 10 	movzbl 0x10f0a4(,%eax,8),%edx
  101848:	00 
  101849:	80 e2 e0             	and    $0xe0,%dl
  10184c:	88 14 c5 a4 f0 10 00 	mov    %dl,0x10f0a4(,%eax,8)
  101853:	8b 45 fc             	mov    -0x4(%ebp),%eax
  101856:	0f b6 14 c5 a4 f0 10 	movzbl 0x10f0a4(,%eax,8),%edx
  10185d:	00 
  10185e:	80 e2 1f             	and    $0x1f,%dl
  101861:	88 14 c5 a4 f0 10 00 	mov    %dl,0x10f0a4(,%eax,8)
  101868:	8b 45 fc             	mov    -0x4(%ebp),%eax
  10186b:	0f b6 14 c5 a5 f0 10 	movzbl 0x10f0a5(,%eax,8),%edx
  101872:	00 
  101873:	80 e2 f0             	and    $0xf0,%dl
  101876:	80 ca 0e             	or     $0xe,%dl
  101879:	88 14 c5 a5 f0 10 00 	mov    %dl,0x10f0a5(,%eax,8)
  101880:	8b 45 fc             	mov    -0x4(%ebp),%eax
  101883:	0f b6 14 c5 a5 f0 10 	movzbl 0x10f0a5(,%eax,8),%edx
  10188a:	00 
  10188b:	80 e2 ef             	and    $0xef,%dl
  10188e:	88 14 c5 a5 f0 10 00 	mov    %dl,0x10f0a5(,%eax,8)
  101895:	8b 45 fc             	mov    -0x4(%ebp),%eax
  101898:	0f b6 14 c5 a5 f0 10 	movzbl 0x10f0a5(,%eax,8),%edx
  10189f:	00 
  1018a0:	80 e2 9f             	and    $0x9f,%dl
  1018a3:	88 14 c5 a5 f0 10 00 	mov    %dl,0x10f0a5(,%eax,8)
  1018aa:	8b 45 fc             	mov    -0x4(%ebp),%eax
  1018ad:	0f b6 14 c5 a5 f0 10 	movzbl 0x10f0a5(,%eax,8),%edx
  1018b4:	00 
  1018b5:	80 ca 80             	or     $0x80,%dl
  1018b8:	88 14 c5 a5 f0 10 00 	mov    %dl,0x10f0a5(,%eax,8)
  1018bf:	8b 45 fc             	mov    -0x4(%ebp),%eax
  1018c2:	8b 04 85 e0 e5 10 00 	mov    0x10e5e0(,%eax,4),%eax
  1018c9:	c1 e8 10             	shr    $0x10,%eax
  1018cc:	0f b7 d0             	movzwl %ax,%edx
  1018cf:	8b 45 fc             	mov    -0x4(%ebp),%eax
  1018d2:	66 89 14 c5 a6 f0 10 	mov    %dx,0x10f0a6(,%eax,8)
  1018d9:	00 
     for (int i = 0; i < 256; i++) {
  1018da:	ff 45 fc             	incl   -0x4(%ebp)
  1018dd:	81 7d fc ff 00 00 00 	cmpl   $0xff,-0x4(%ebp)
  1018e4:	0f 8e 2f ff ff ff    	jle    101819 <idt_init+0x12>
  1018ea:	c7 45 f8 60 e5 10 00 	movl   $0x10e560,-0x8(%ebp)
    asm volatile ("lidt (%0)" :: "r" (pd));
  1018f1:	8b 45 f8             	mov    -0x8(%ebp),%eax
  1018f4:	0f 01 18             	lidtl  (%eax)
     }

     lidt(&idt_pd);
}
  1018f7:	90                   	nop
  1018f8:	c9                   	leave  
  1018f9:	c3                   	ret    

001018fa <trapname>:

static const char *
trapname(int trapno) {
  1018fa:	55                   	push   %ebp
  1018fb:	89 e5                	mov    %esp,%ebp
        "Alignment Check",
        "Machine-Check",
        "SIMD Floating-Point Exception"
    };

    if (trapno < sizeof(excnames)/sizeof(const char * const)) {
  1018fd:	8b 45 08             	mov    0x8(%ebp),%eax
  101900:	83 f8 13             	cmp    $0x13,%eax
  101903:	77 0c                	ja     101911 <trapname+0x17>
        return excnames[trapno];
  101905:	8b 45 08             	mov    0x8(%ebp),%eax
  101908:	8b 04 85 80 3a 10 00 	mov    0x103a80(,%eax,4),%eax
  10190f:	eb 18                	jmp    101929 <trapname+0x2f>
    }
    if (trapno >= IRQ_OFFSET && trapno < IRQ_OFFSET + 16) {
  101911:	83 7d 08 1f          	cmpl   $0x1f,0x8(%ebp)
  101915:	7e 0d                	jle    101924 <trapname+0x2a>
  101917:	83 7d 08 2f          	cmpl   $0x2f,0x8(%ebp)
  10191b:	7f 07                	jg     101924 <trapname+0x2a>
        return "Hardware Interrupt";
  10191d:	b8 2a 37 10 00       	mov    $0x10372a,%eax
  101922:	eb 05                	jmp    101929 <trapname+0x2f>
    }
    return "(unknown trap)";
  101924:	b8 3d 37 10 00       	mov    $0x10373d,%eax
}
  101929:	5d                   	pop    %ebp
  10192a:	c3                   	ret    

0010192b <trap_in_kernel>:

/* trap_in_kernel - test if trap happened in kernel */
bool
trap_in_kernel(struct trapframe *tf) {
  10192b:	55                   	push   %ebp
  10192c:	89 e5                	mov    %esp,%ebp
    return (tf->tf_cs == (uint16_t)KERNEL_CS);
  10192e:	8b 45 08             	mov    0x8(%ebp),%eax
  101931:	0f b7 40 3c          	movzwl 0x3c(%eax),%eax
  101935:	83 f8 08             	cmp    $0x8,%eax
  101938:	0f 94 c0             	sete   %al
  10193b:	0f b6 c0             	movzbl %al,%eax
}
  10193e:	5d                   	pop    %ebp
  10193f:	c3                   	ret    

00101940 <print_trapframe>:
    "TF", "IF", "DF", "OF", NULL, NULL, "NT", NULL,
    "RF", "VM", "AC", "VIF", "VIP", "ID", NULL, NULL,
};

void
print_trapframe(struct trapframe *tf) {
  101940:	55                   	push   %ebp
  101941:	89 e5                	mov    %esp,%ebp
  101943:	83 ec 28             	sub    $0x28,%esp
    cprintf("trapframe at %p\n", tf);
  101946:	8b 45 08             	mov    0x8(%ebp),%eax
  101949:	89 44 24 04          	mov    %eax,0x4(%esp)
  10194d:	c7 04 24 7e 37 10 00 	movl   $0x10377e,(%esp)
  101954:	e8 03 e9 ff ff       	call   10025c <cprintf>
    print_regs(&tf->tf_regs);
  101959:	8b 45 08             	mov    0x8(%ebp),%eax
  10195c:	89 04 24             	mov    %eax,(%esp)
  10195f:	e8 8f 01 00 00       	call   101af3 <print_regs>
    cprintf("  ds   0x----%04x\n", tf->tf_ds);
  101964:	8b 45 08             	mov    0x8(%ebp),%eax
  101967:	0f b7 40 2c          	movzwl 0x2c(%eax),%eax
  10196b:	89 44 24 04          	mov    %eax,0x4(%esp)
  10196f:	c7 04 24 8f 37 10 00 	movl   $0x10378f,(%esp)
  101976:	e8 e1 e8 ff ff       	call   10025c <cprintf>
    cprintf("  es   0x----%04x\n", tf->tf_es);
  10197b:	8b 45 08             	mov    0x8(%ebp),%eax
  10197e:	0f b7 40 28          	movzwl 0x28(%eax),%eax
  101982:	89 44 24 04          	mov    %eax,0x4(%esp)
  101986:	c7 04 24 a2 37 10 00 	movl   $0x1037a2,(%esp)
  10198d:	e8 ca e8 ff ff       	call   10025c <cprintf>
    cprintf("  fs   0x----%04x\n", tf->tf_fs);
  101992:	8b 45 08             	mov    0x8(%ebp),%eax
  101995:	0f b7 40 24          	movzwl 0x24(%eax),%eax
  101999:	89 44 24 04          	mov    %eax,0x4(%esp)
  10199d:	c7 04 24 b5 37 10 00 	movl   $0x1037b5,(%esp)
  1019a4:	e8 b3 e8 ff ff       	call   10025c <cprintf>
    cprintf("  gs   0x----%04x\n", tf->tf_gs);
  1019a9:	8b 45 08             	mov    0x8(%ebp),%eax
  1019ac:	0f b7 40 20          	movzwl 0x20(%eax),%eax
  1019b0:	89 44 24 04          	mov    %eax,0x4(%esp)
  1019b4:	c7 04 24 c8 37 10 00 	movl   $0x1037c8,(%esp)
  1019bb:	e8 9c e8 ff ff       	call   10025c <cprintf>
    cprintf("  trap 0x%08x %s\n", tf->tf_trapno, trapname(tf->tf_trapno));
  1019c0:	8b 45 08             	mov    0x8(%ebp),%eax
  1019c3:	8b 40 30             	mov    0x30(%eax),%eax
  1019c6:	89 04 24             	mov    %eax,(%esp)
  1019c9:	e8 2c ff ff ff       	call   1018fa <trapname>
  1019ce:	89 c2                	mov    %eax,%edx
  1019d0:	8b 45 08             	mov    0x8(%ebp),%eax
  1019d3:	8b 40 30             	mov    0x30(%eax),%eax
  1019d6:	89 54 24 08          	mov    %edx,0x8(%esp)
  1019da:	89 44 24 04          	mov    %eax,0x4(%esp)
  1019de:	c7 04 24 db 37 10 00 	movl   $0x1037db,(%esp)
  1019e5:	e8 72 e8 ff ff       	call   10025c <cprintf>
    cprintf("  err  0x%08x\n", tf->tf_err);
  1019ea:	8b 45 08             	mov    0x8(%ebp),%eax
  1019ed:	8b 40 34             	mov    0x34(%eax),%eax
  1019f0:	89 44 24 04          	mov    %eax,0x4(%esp)
  1019f4:	c7 04 24 ed 37 10 00 	movl   $0x1037ed,(%esp)
  1019fb:	e8 5c e8 ff ff       	call   10025c <cprintf>
    cprintf("  eip  0x%08x\n", tf->tf_eip);
  101a00:	8b 45 08             	mov    0x8(%ebp),%eax
  101a03:	8b 40 38             	mov    0x38(%eax),%eax
  101a06:	89 44 24 04          	mov    %eax,0x4(%esp)
  101a0a:	c7 04 24 fc 37 10 00 	movl   $0x1037fc,(%esp)
  101a11:	e8 46 e8 ff ff       	call   10025c <cprintf>
    cprintf("  cs   0x----%04x\n", tf->tf_cs);
  101a16:	8b 45 08             	mov    0x8(%ebp),%eax
  101a19:	0f b7 40 3c          	movzwl 0x3c(%eax),%eax
  101a1d:	89 44 24 04          	mov    %eax,0x4(%esp)
  101a21:	c7 04 24 0b 38 10 00 	movl   $0x10380b,(%esp)
  101a28:	e8 2f e8 ff ff       	call   10025c <cprintf>
    cprintf("  flag 0x%08x ", tf->tf_eflags);
  101a2d:	8b 45 08             	mov    0x8(%ebp),%eax
  101a30:	8b 40 40             	mov    0x40(%eax),%eax
  101a33:	89 44 24 04          	mov    %eax,0x4(%esp)
  101a37:	c7 04 24 1e 38 10 00 	movl   $0x10381e,(%esp)
  101a3e:	e8 19 e8 ff ff       	call   10025c <cprintf>

    int i, j;
    for (i = 0, j = 1; i < sizeof(IA32flags) / sizeof(IA32flags[0]); i ++, j <<= 1) {
  101a43:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
  101a4a:	c7 45 f0 01 00 00 00 	movl   $0x1,-0x10(%ebp)
  101a51:	eb 3d                	jmp    101a90 <print_trapframe+0x150>
        if ((tf->tf_eflags & j) && IA32flags[i] != NULL) {
  101a53:	8b 45 08             	mov    0x8(%ebp),%eax
  101a56:	8b 50 40             	mov    0x40(%eax),%edx
  101a59:	8b 45 f0             	mov    -0x10(%ebp),%eax
  101a5c:	21 d0                	and    %edx,%eax
  101a5e:	85 c0                	test   %eax,%eax
  101a60:	74 28                	je     101a8a <print_trapframe+0x14a>
  101a62:	8b 45 f4             	mov    -0xc(%ebp),%eax
  101a65:	8b 04 85 80 e5 10 00 	mov    0x10e580(,%eax,4),%eax
  101a6c:	85 c0                	test   %eax,%eax
  101a6e:	74 1a                	je     101a8a <print_trapframe+0x14a>
            cprintf("%s,", IA32flags[i]);
  101a70:	8b 45 f4             	mov    -0xc(%ebp),%eax
  101a73:	8b 04 85 80 e5 10 00 	mov    0x10e580(,%eax,4),%eax
  101a7a:	89 44 24 04          	mov    %eax,0x4(%esp)
  101a7e:	c7 04 24 2d 38 10 00 	movl   $0x10382d,(%esp)
  101a85:	e8 d2 e7 ff ff       	call   10025c <cprintf>
    for (i = 0, j = 1; i < sizeof(IA32flags) / sizeof(IA32flags[0]); i ++, j <<= 1) {
  101a8a:	ff 45 f4             	incl   -0xc(%ebp)
  101a8d:	d1 65 f0             	shll   -0x10(%ebp)
  101a90:	8b 45 f4             	mov    -0xc(%ebp),%eax
  101a93:	83 f8 17             	cmp    $0x17,%eax
  101a96:	76 bb                	jbe    101a53 <print_trapframe+0x113>
        }
    }
    cprintf("IOPL=%d\n", (tf->tf_eflags & FL_IOPL_MASK) >> 12);
  101a98:	8b 45 08             	mov    0x8(%ebp),%eax
  101a9b:	8b 40 40             	mov    0x40(%eax),%eax
  101a9e:	c1 e8 0c             	shr    $0xc,%eax
  101aa1:	83 e0 03             	and    $0x3,%eax
  101aa4:	89 44 24 04          	mov    %eax,0x4(%esp)
  101aa8:	c7 04 24 31 38 10 00 	movl   $0x103831,(%esp)
  101aaf:	e8 a8 e7 ff ff       	call   10025c <cprintf>

    if (!trap_in_kernel(tf)) {
  101ab4:	8b 45 08             	mov    0x8(%ebp),%eax
  101ab7:	89 04 24             	mov    %eax,(%esp)
  101aba:	e8 6c fe ff ff       	call   10192b <trap_in_kernel>
  101abf:	85 c0                	test   %eax,%eax
  101ac1:	75 2d                	jne    101af0 <print_trapframe+0x1b0>
        cprintf("  esp  0x%08x\n", tf->tf_esp);
  101ac3:	8b 45 08             	mov    0x8(%ebp),%eax
  101ac6:	8b 40 44             	mov    0x44(%eax),%eax
  101ac9:	89 44 24 04          	mov    %eax,0x4(%esp)
  101acd:	c7 04 24 3a 38 10 00 	movl   $0x10383a,(%esp)
  101ad4:	e8 83 e7 ff ff       	call   10025c <cprintf>
        cprintf("  ss   0x----%04x\n", tf->tf_ss);
  101ad9:	8b 45 08             	mov    0x8(%ebp),%eax
  101adc:	0f b7 40 48          	movzwl 0x48(%eax),%eax
  101ae0:	89 44 24 04          	mov    %eax,0x4(%esp)
  101ae4:	c7 04 24 49 38 10 00 	movl   $0x103849,(%esp)
  101aeb:	e8 6c e7 ff ff       	call   10025c <cprintf>
    }
}
  101af0:	90                   	nop
  101af1:	c9                   	leave  
  101af2:	c3                   	ret    

00101af3 <print_regs>:

void
print_regs(struct pushregs *regs) {
  101af3:	55                   	push   %ebp
  101af4:	89 e5                	mov    %esp,%ebp
  101af6:	83 ec 18             	sub    $0x18,%esp
    cprintf("  edi  0x%08x\n", regs->reg_edi);
  101af9:	8b 45 08             	mov    0x8(%ebp),%eax
  101afc:	8b 00                	mov    (%eax),%eax
  101afe:	89 44 24 04          	mov    %eax,0x4(%esp)
  101b02:	c7 04 24 5c 38 10 00 	movl   $0x10385c,(%esp)
  101b09:	e8 4e e7 ff ff       	call   10025c <cprintf>
    cprintf("  esi  0x%08x\n", regs->reg_esi);
  101b0e:	8b 45 08             	mov    0x8(%ebp),%eax
  101b11:	8b 40 04             	mov    0x4(%eax),%eax
  101b14:	89 44 24 04          	mov    %eax,0x4(%esp)
  101b18:	c7 04 24 6b 38 10 00 	movl   $0x10386b,(%esp)
  101b1f:	e8 38 e7 ff ff       	call   10025c <cprintf>
    cprintf("  ebp  0x%08x\n", regs->reg_ebp);
  101b24:	8b 45 08             	mov    0x8(%ebp),%eax
  101b27:	8b 40 08             	mov    0x8(%eax),%eax
  101b2a:	89 44 24 04          	mov    %eax,0x4(%esp)
  101b2e:	c7 04 24 7a 38 10 00 	movl   $0x10387a,(%esp)
  101b35:	e8 22 e7 ff ff       	call   10025c <cprintf>
    cprintf("  oesp 0x%08x\n", regs->reg_oesp);
  101b3a:	8b 45 08             	mov    0x8(%ebp),%eax
  101b3d:	8b 40 0c             	mov    0xc(%eax),%eax
  101b40:	89 44 24 04          	mov    %eax,0x4(%esp)
  101b44:	c7 04 24 89 38 10 00 	movl   $0x103889,(%esp)
  101b4b:	e8 0c e7 ff ff       	call   10025c <cprintf>
    cprintf("  ebx  0x%08x\n", regs->reg_ebx);
  101b50:	8b 45 08             	mov    0x8(%ebp),%eax
  101b53:	8b 40 10             	mov    0x10(%eax),%eax
  101b56:	89 44 24 04          	mov    %eax,0x4(%esp)
  101b5a:	c7 04 24 98 38 10 00 	movl   $0x103898,(%esp)
  101b61:	e8 f6 e6 ff ff       	call   10025c <cprintf>
    cprintf("  edx  0x%08x\n", regs->reg_edx);
  101b66:	8b 45 08             	mov    0x8(%ebp),%eax
  101b69:	8b 40 14             	mov    0x14(%eax),%eax
  101b6c:	89 44 24 04          	mov    %eax,0x4(%esp)
  101b70:	c7 04 24 a7 38 10 00 	movl   $0x1038a7,(%esp)
  101b77:	e8 e0 e6 ff ff       	call   10025c <cprintf>
    cprintf("  ecx  0x%08x\n", regs->reg_ecx);
  101b7c:	8b 45 08             	mov    0x8(%ebp),%eax
  101b7f:	8b 40 18             	mov    0x18(%eax),%eax
  101b82:	89 44 24 04          	mov    %eax,0x4(%esp)
  101b86:	c7 04 24 b6 38 10 00 	movl   $0x1038b6,(%esp)
  101b8d:	e8 ca e6 ff ff       	call   10025c <cprintf>
    cprintf("  eax  0x%08x\n", regs->reg_eax);
  101b92:	8b 45 08             	mov    0x8(%ebp),%eax
  101b95:	8b 40 1c             	mov    0x1c(%eax),%eax
  101b98:	89 44 24 04          	mov    %eax,0x4(%esp)
  101b9c:	c7 04 24 c5 38 10 00 	movl   $0x1038c5,(%esp)
  101ba3:	e8 b4 e6 ff ff       	call   10025c <cprintf>
}
  101ba8:	90                   	nop
  101ba9:	c9                   	leave  
  101baa:	c3                   	ret    

00101bab <trap_dispatch>:

/* trap_dispatch - dispatch based on what type of trap occurred */
static void
trap_dispatch(struct trapframe *tf) {
  101bab:	55                   	push   %ebp
  101bac:	89 e5                	mov    %esp,%ebp
  101bae:	83 ec 28             	sub    $0x28,%esp
    char c;

    switch (tf->tf_trapno) {
  101bb1:	8b 45 08             	mov    0x8(%ebp),%eax
  101bb4:	8b 40 30             	mov    0x30(%eax),%eax
  101bb7:	83 f8 2f             	cmp    $0x2f,%eax
  101bba:	77 1e                	ja     101bda <trap_dispatch+0x2f>
  101bbc:	83 f8 2e             	cmp    $0x2e,%eax
  101bbf:	0f 83 bc 00 00 00    	jae    101c81 <trap_dispatch+0xd6>
  101bc5:	83 f8 21             	cmp    $0x21,%eax
  101bc8:	74 40                	je     101c0a <trap_dispatch+0x5f>
  101bca:	83 f8 24             	cmp    $0x24,%eax
  101bcd:	74 15                	je     101be4 <trap_dispatch+0x39>
  101bcf:	83 f8 20             	cmp    $0x20,%eax
  101bd2:	0f 84 ac 00 00 00    	je     101c84 <trap_dispatch+0xd9>
  101bd8:	eb 72                	jmp    101c4c <trap_dispatch+0xa1>
  101bda:	83 e8 78             	sub    $0x78,%eax
  101bdd:	83 f8 01             	cmp    $0x1,%eax
  101be0:	77 6a                	ja     101c4c <trap_dispatch+0xa1>
  101be2:	eb 4c                	jmp    101c30 <trap_dispatch+0x85>
         * (2) Every TICK_NUM cycle, you can print some info using a funciton, such as print_ticks().
         * (3) Too Simple? Yes, I think so!
         */
        break;
    case IRQ_OFFSET + IRQ_COM1:
        c = cons_getc();
  101be4:	e8 d1 f9 ff ff       	call   1015ba <cons_getc>
  101be9:	88 45 f7             	mov    %al,-0x9(%ebp)
        cprintf("serial [%03d] %c\n", c, c);
  101bec:	0f be 55 f7          	movsbl -0x9(%ebp),%edx
  101bf0:	0f be 45 f7          	movsbl -0x9(%ebp),%eax
  101bf4:	89 54 24 08          	mov    %edx,0x8(%esp)
  101bf8:	89 44 24 04          	mov    %eax,0x4(%esp)
  101bfc:	c7 04 24 d4 38 10 00 	movl   $0x1038d4,(%esp)
  101c03:	e8 54 e6 ff ff       	call   10025c <cprintf>
        break;
  101c08:	eb 7b                	jmp    101c85 <trap_dispatch+0xda>
    case IRQ_OFFSET + IRQ_KBD:
        c = cons_getc();
  101c0a:	e8 ab f9 ff ff       	call   1015ba <cons_getc>
  101c0f:	88 45 f7             	mov    %al,-0x9(%ebp)
        cprintf("kbd [%03d] %c\n", c, c);
  101c12:	0f be 55 f7          	movsbl -0x9(%ebp),%edx
  101c16:	0f be 45 f7          	movsbl -0x9(%ebp),%eax
  101c1a:	89 54 24 08          	mov    %edx,0x8(%esp)
  101c1e:	89 44 24 04          	mov    %eax,0x4(%esp)
  101c22:	c7 04 24 e6 38 10 00 	movl   $0x1038e6,(%esp)
  101c29:	e8 2e e6 ff ff       	call   10025c <cprintf>
        break;
  101c2e:	eb 55                	jmp    101c85 <trap_dispatch+0xda>
    //LAB1 CHALLENGE 1 : YOUR CODE you should modify below codes.
    case T_SWITCH_TOU:
    case T_SWITCH_TOK:
        panic("T_SWITCH_** ??\n");
  101c30:	c7 44 24 08 f5 38 10 	movl   $0x1038f5,0x8(%esp)
  101c37:	00 
  101c38:	c7 44 24 04 a9 00 00 	movl   $0xa9,0x4(%esp)
  101c3f:	00 
  101c40:	c7 04 24 05 39 10 00 	movl   $0x103905,(%esp)
  101c47:	e8 67 e7 ff ff       	call   1003b3 <__panic>
    case IRQ_OFFSET + IRQ_IDE2:
        /* do nothing */
        break;
    default:
        // in kernel, it must be a mistake
        if ((tf->tf_cs & 3) == 0) {
  101c4c:	8b 45 08             	mov    0x8(%ebp),%eax
  101c4f:	0f b7 40 3c          	movzwl 0x3c(%eax),%eax
  101c53:	83 e0 03             	and    $0x3,%eax
  101c56:	85 c0                	test   %eax,%eax
  101c58:	75 2b                	jne    101c85 <trap_dispatch+0xda>
            print_trapframe(tf);
  101c5a:	8b 45 08             	mov    0x8(%ebp),%eax
  101c5d:	89 04 24             	mov    %eax,(%esp)
  101c60:	e8 db fc ff ff       	call   101940 <print_trapframe>
            panic("unexpected trap in kernel.\n");
  101c65:	c7 44 24 08 16 39 10 	movl   $0x103916,0x8(%esp)
  101c6c:	00 
  101c6d:	c7 44 24 04 b3 00 00 	movl   $0xb3,0x4(%esp)
  101c74:	00 
  101c75:	c7 04 24 05 39 10 00 	movl   $0x103905,(%esp)
  101c7c:	e8 32 e7 ff ff       	call   1003b3 <__panic>
        break;
  101c81:	90                   	nop
  101c82:	eb 01                	jmp    101c85 <trap_dispatch+0xda>
        break;
  101c84:	90                   	nop
        }
    }
}
  101c85:	90                   	nop
  101c86:	c9                   	leave  
  101c87:	c3                   	ret    

00101c88 <trap>:
 * trap - handles or dispatches an exception/interrupt. if and when trap() returns,
 * the code in kern/trap/trapentry.S restores the old CPU state saved in the
 * trapframe and then uses the iret instruction to return from the exception.
 * */
void
trap(struct trapframe *tf) {
  101c88:	55                   	push   %ebp
  101c89:	89 e5                	mov    %esp,%ebp
  101c8b:	83 ec 18             	sub    $0x18,%esp
    // dispatch based on what type of trap occurred
    trap_dispatch(tf);
  101c8e:	8b 45 08             	mov    0x8(%ebp),%eax
  101c91:	89 04 24             	mov    %eax,(%esp)
  101c94:	e8 12 ff ff ff       	call   101bab <trap_dispatch>
}
  101c99:	90                   	nop
  101c9a:	c9                   	leave  
  101c9b:	c3                   	ret    

00101c9c <vector0>:
# handler
.text
.globl __alltraps
.globl vector0
vector0:
  pushl $0
  101c9c:	6a 00                	push   $0x0
  pushl $0
  101c9e:	6a 00                	push   $0x0
  jmp __alltraps
  101ca0:	e9 69 0a 00 00       	jmp    10270e <__alltraps>

00101ca5 <vector1>:
.globl vector1
vector1:
  pushl $0
  101ca5:	6a 00                	push   $0x0
  pushl $1
  101ca7:	6a 01                	push   $0x1
  jmp __alltraps
  101ca9:	e9 60 0a 00 00       	jmp    10270e <__alltraps>

00101cae <vector2>:
.globl vector2
vector2:
  pushl $0
  101cae:	6a 00                	push   $0x0
  pushl $2
  101cb0:	6a 02                	push   $0x2
  jmp __alltraps
  101cb2:	e9 57 0a 00 00       	jmp    10270e <__alltraps>

00101cb7 <vector3>:
.globl vector3
vector3:
  pushl $0
  101cb7:	6a 00                	push   $0x0
  pushl $3
  101cb9:	6a 03                	push   $0x3
  jmp __alltraps
  101cbb:	e9 4e 0a 00 00       	jmp    10270e <__alltraps>

00101cc0 <vector4>:
.globl vector4
vector4:
  pushl $0
  101cc0:	6a 00                	push   $0x0
  pushl $4
  101cc2:	6a 04                	push   $0x4
  jmp __alltraps
  101cc4:	e9 45 0a 00 00       	jmp    10270e <__alltraps>

00101cc9 <vector5>:
.globl vector5
vector5:
  pushl $0
  101cc9:	6a 00                	push   $0x0
  pushl $5
  101ccb:	6a 05                	push   $0x5
  jmp __alltraps
  101ccd:	e9 3c 0a 00 00       	jmp    10270e <__alltraps>

00101cd2 <vector6>:
.globl vector6
vector6:
  pushl $0
  101cd2:	6a 00                	push   $0x0
  pushl $6
  101cd4:	6a 06                	push   $0x6
  jmp __alltraps
  101cd6:	e9 33 0a 00 00       	jmp    10270e <__alltraps>

00101cdb <vector7>:
.globl vector7
vector7:
  pushl $0
  101cdb:	6a 00                	push   $0x0
  pushl $7
  101cdd:	6a 07                	push   $0x7
  jmp __alltraps
  101cdf:	e9 2a 0a 00 00       	jmp    10270e <__alltraps>

00101ce4 <vector8>:
.globl vector8
vector8:
  pushl $8
  101ce4:	6a 08                	push   $0x8
  jmp __alltraps
  101ce6:	e9 23 0a 00 00       	jmp    10270e <__alltraps>

00101ceb <vector9>:
.globl vector9
vector9:
  pushl $0
  101ceb:	6a 00                	push   $0x0
  pushl $9
  101ced:	6a 09                	push   $0x9
  jmp __alltraps
  101cef:	e9 1a 0a 00 00       	jmp    10270e <__alltraps>

00101cf4 <vector10>:
.globl vector10
vector10:
  pushl $10
  101cf4:	6a 0a                	push   $0xa
  jmp __alltraps
  101cf6:	e9 13 0a 00 00       	jmp    10270e <__alltraps>

00101cfb <vector11>:
.globl vector11
vector11:
  pushl $11
  101cfb:	6a 0b                	push   $0xb
  jmp __alltraps
  101cfd:	e9 0c 0a 00 00       	jmp    10270e <__alltraps>

00101d02 <vector12>:
.globl vector12
vector12:
  pushl $12
  101d02:	6a 0c                	push   $0xc
  jmp __alltraps
  101d04:	e9 05 0a 00 00       	jmp    10270e <__alltraps>

00101d09 <vector13>:
.globl vector13
vector13:
  pushl $13
  101d09:	6a 0d                	push   $0xd
  jmp __alltraps
  101d0b:	e9 fe 09 00 00       	jmp    10270e <__alltraps>

00101d10 <vector14>:
.globl vector14
vector14:
  pushl $14
  101d10:	6a 0e                	push   $0xe
  jmp __alltraps
  101d12:	e9 f7 09 00 00       	jmp    10270e <__alltraps>

00101d17 <vector15>:
.globl vector15
vector15:
  pushl $0
  101d17:	6a 00                	push   $0x0
  pushl $15
  101d19:	6a 0f                	push   $0xf
  jmp __alltraps
  101d1b:	e9 ee 09 00 00       	jmp    10270e <__alltraps>

00101d20 <vector16>:
.globl vector16
vector16:
  pushl $0
  101d20:	6a 00                	push   $0x0
  pushl $16
  101d22:	6a 10                	push   $0x10
  jmp __alltraps
  101d24:	e9 e5 09 00 00       	jmp    10270e <__alltraps>

00101d29 <vector17>:
.globl vector17
vector17:
  pushl $17
  101d29:	6a 11                	push   $0x11
  jmp __alltraps
  101d2b:	e9 de 09 00 00       	jmp    10270e <__alltraps>

00101d30 <vector18>:
.globl vector18
vector18:
  pushl $0
  101d30:	6a 00                	push   $0x0
  pushl $18
  101d32:	6a 12                	push   $0x12
  jmp __alltraps
  101d34:	e9 d5 09 00 00       	jmp    10270e <__alltraps>

00101d39 <vector19>:
.globl vector19
vector19:
  pushl $0
  101d39:	6a 00                	push   $0x0
  pushl $19
  101d3b:	6a 13                	push   $0x13
  jmp __alltraps
  101d3d:	e9 cc 09 00 00       	jmp    10270e <__alltraps>

00101d42 <vector20>:
.globl vector20
vector20:
  pushl $0
  101d42:	6a 00                	push   $0x0
  pushl $20
  101d44:	6a 14                	push   $0x14
  jmp __alltraps
  101d46:	e9 c3 09 00 00       	jmp    10270e <__alltraps>

00101d4b <vector21>:
.globl vector21
vector21:
  pushl $0
  101d4b:	6a 00                	push   $0x0
  pushl $21
  101d4d:	6a 15                	push   $0x15
  jmp __alltraps
  101d4f:	e9 ba 09 00 00       	jmp    10270e <__alltraps>

00101d54 <vector22>:
.globl vector22
vector22:
  pushl $0
  101d54:	6a 00                	push   $0x0
  pushl $22
  101d56:	6a 16                	push   $0x16
  jmp __alltraps
  101d58:	e9 b1 09 00 00       	jmp    10270e <__alltraps>

00101d5d <vector23>:
.globl vector23
vector23:
  pushl $0
  101d5d:	6a 00                	push   $0x0
  pushl $23
  101d5f:	6a 17                	push   $0x17
  jmp __alltraps
  101d61:	e9 a8 09 00 00       	jmp    10270e <__alltraps>

00101d66 <vector24>:
.globl vector24
vector24:
  pushl $0
  101d66:	6a 00                	push   $0x0
  pushl $24
  101d68:	6a 18                	push   $0x18
  jmp __alltraps
  101d6a:	e9 9f 09 00 00       	jmp    10270e <__alltraps>

00101d6f <vector25>:
.globl vector25
vector25:
  pushl $0
  101d6f:	6a 00                	push   $0x0
  pushl $25
  101d71:	6a 19                	push   $0x19
  jmp __alltraps
  101d73:	e9 96 09 00 00       	jmp    10270e <__alltraps>

00101d78 <vector26>:
.globl vector26
vector26:
  pushl $0
  101d78:	6a 00                	push   $0x0
  pushl $26
  101d7a:	6a 1a                	push   $0x1a
  jmp __alltraps
  101d7c:	e9 8d 09 00 00       	jmp    10270e <__alltraps>

00101d81 <vector27>:
.globl vector27
vector27:
  pushl $0
  101d81:	6a 00                	push   $0x0
  pushl $27
  101d83:	6a 1b                	push   $0x1b
  jmp __alltraps
  101d85:	e9 84 09 00 00       	jmp    10270e <__alltraps>

00101d8a <vector28>:
.globl vector28
vector28:
  pushl $0
  101d8a:	6a 00                	push   $0x0
  pushl $28
  101d8c:	6a 1c                	push   $0x1c
  jmp __alltraps
  101d8e:	e9 7b 09 00 00       	jmp    10270e <__alltraps>

00101d93 <vector29>:
.globl vector29
vector29:
  pushl $0
  101d93:	6a 00                	push   $0x0
  pushl $29
  101d95:	6a 1d                	push   $0x1d
  jmp __alltraps
  101d97:	e9 72 09 00 00       	jmp    10270e <__alltraps>

00101d9c <vector30>:
.globl vector30
vector30:
  pushl $0
  101d9c:	6a 00                	push   $0x0
  pushl $30
  101d9e:	6a 1e                	push   $0x1e
  jmp __alltraps
  101da0:	e9 69 09 00 00       	jmp    10270e <__alltraps>

00101da5 <vector31>:
.globl vector31
vector31:
  pushl $0
  101da5:	6a 00                	push   $0x0
  pushl $31
  101da7:	6a 1f                	push   $0x1f
  jmp __alltraps
  101da9:	e9 60 09 00 00       	jmp    10270e <__alltraps>

00101dae <vector32>:
.globl vector32
vector32:
  pushl $0
  101dae:	6a 00                	push   $0x0
  pushl $32
  101db0:	6a 20                	push   $0x20
  jmp __alltraps
  101db2:	e9 57 09 00 00       	jmp    10270e <__alltraps>

00101db7 <vector33>:
.globl vector33
vector33:
  pushl $0
  101db7:	6a 00                	push   $0x0
  pushl $33
  101db9:	6a 21                	push   $0x21
  jmp __alltraps
  101dbb:	e9 4e 09 00 00       	jmp    10270e <__alltraps>

00101dc0 <vector34>:
.globl vector34
vector34:
  pushl $0
  101dc0:	6a 00                	push   $0x0
  pushl $34
  101dc2:	6a 22                	push   $0x22
  jmp __alltraps
  101dc4:	e9 45 09 00 00       	jmp    10270e <__alltraps>

00101dc9 <vector35>:
.globl vector35
vector35:
  pushl $0
  101dc9:	6a 00                	push   $0x0
  pushl $35
  101dcb:	6a 23                	push   $0x23
  jmp __alltraps
  101dcd:	e9 3c 09 00 00       	jmp    10270e <__alltraps>

00101dd2 <vector36>:
.globl vector36
vector36:
  pushl $0
  101dd2:	6a 00                	push   $0x0
  pushl $36
  101dd4:	6a 24                	push   $0x24
  jmp __alltraps
  101dd6:	e9 33 09 00 00       	jmp    10270e <__alltraps>

00101ddb <vector37>:
.globl vector37
vector37:
  pushl $0
  101ddb:	6a 00                	push   $0x0
  pushl $37
  101ddd:	6a 25                	push   $0x25
  jmp __alltraps
  101ddf:	e9 2a 09 00 00       	jmp    10270e <__alltraps>

00101de4 <vector38>:
.globl vector38
vector38:
  pushl $0
  101de4:	6a 00                	push   $0x0
  pushl $38
  101de6:	6a 26                	push   $0x26
  jmp __alltraps
  101de8:	e9 21 09 00 00       	jmp    10270e <__alltraps>

00101ded <vector39>:
.globl vector39
vector39:
  pushl $0
  101ded:	6a 00                	push   $0x0
  pushl $39
  101def:	6a 27                	push   $0x27
  jmp __alltraps
  101df1:	e9 18 09 00 00       	jmp    10270e <__alltraps>

00101df6 <vector40>:
.globl vector40
vector40:
  pushl $0
  101df6:	6a 00                	push   $0x0
  pushl $40
  101df8:	6a 28                	push   $0x28
  jmp __alltraps
  101dfa:	e9 0f 09 00 00       	jmp    10270e <__alltraps>

00101dff <vector41>:
.globl vector41
vector41:
  pushl $0
  101dff:	6a 00                	push   $0x0
  pushl $41
  101e01:	6a 29                	push   $0x29
  jmp __alltraps
  101e03:	e9 06 09 00 00       	jmp    10270e <__alltraps>

00101e08 <vector42>:
.globl vector42
vector42:
  pushl $0
  101e08:	6a 00                	push   $0x0
  pushl $42
  101e0a:	6a 2a                	push   $0x2a
  jmp __alltraps
  101e0c:	e9 fd 08 00 00       	jmp    10270e <__alltraps>

00101e11 <vector43>:
.globl vector43
vector43:
  pushl $0
  101e11:	6a 00                	push   $0x0
  pushl $43
  101e13:	6a 2b                	push   $0x2b
  jmp __alltraps
  101e15:	e9 f4 08 00 00       	jmp    10270e <__alltraps>

00101e1a <vector44>:
.globl vector44
vector44:
  pushl $0
  101e1a:	6a 00                	push   $0x0
  pushl $44
  101e1c:	6a 2c                	push   $0x2c
  jmp __alltraps
  101e1e:	e9 eb 08 00 00       	jmp    10270e <__alltraps>

00101e23 <vector45>:
.globl vector45
vector45:
  pushl $0
  101e23:	6a 00                	push   $0x0
  pushl $45
  101e25:	6a 2d                	push   $0x2d
  jmp __alltraps
  101e27:	e9 e2 08 00 00       	jmp    10270e <__alltraps>

00101e2c <vector46>:
.globl vector46
vector46:
  pushl $0
  101e2c:	6a 00                	push   $0x0
  pushl $46
  101e2e:	6a 2e                	push   $0x2e
  jmp __alltraps
  101e30:	e9 d9 08 00 00       	jmp    10270e <__alltraps>

00101e35 <vector47>:
.globl vector47
vector47:
  pushl $0
  101e35:	6a 00                	push   $0x0
  pushl $47
  101e37:	6a 2f                	push   $0x2f
  jmp __alltraps
  101e39:	e9 d0 08 00 00       	jmp    10270e <__alltraps>

00101e3e <vector48>:
.globl vector48
vector48:
  pushl $0
  101e3e:	6a 00                	push   $0x0
  pushl $48
  101e40:	6a 30                	push   $0x30
  jmp __alltraps
  101e42:	e9 c7 08 00 00       	jmp    10270e <__alltraps>

00101e47 <vector49>:
.globl vector49
vector49:
  pushl $0
  101e47:	6a 00                	push   $0x0
  pushl $49
  101e49:	6a 31                	push   $0x31
  jmp __alltraps
  101e4b:	e9 be 08 00 00       	jmp    10270e <__alltraps>

00101e50 <vector50>:
.globl vector50
vector50:
  pushl $0
  101e50:	6a 00                	push   $0x0
  pushl $50
  101e52:	6a 32                	push   $0x32
  jmp __alltraps
  101e54:	e9 b5 08 00 00       	jmp    10270e <__alltraps>

00101e59 <vector51>:
.globl vector51
vector51:
  pushl $0
  101e59:	6a 00                	push   $0x0
  pushl $51
  101e5b:	6a 33                	push   $0x33
  jmp __alltraps
  101e5d:	e9 ac 08 00 00       	jmp    10270e <__alltraps>

00101e62 <vector52>:
.globl vector52
vector52:
  pushl $0
  101e62:	6a 00                	push   $0x0
  pushl $52
  101e64:	6a 34                	push   $0x34
  jmp __alltraps
  101e66:	e9 a3 08 00 00       	jmp    10270e <__alltraps>

00101e6b <vector53>:
.globl vector53
vector53:
  pushl $0
  101e6b:	6a 00                	push   $0x0
  pushl $53
  101e6d:	6a 35                	push   $0x35
  jmp __alltraps
  101e6f:	e9 9a 08 00 00       	jmp    10270e <__alltraps>

00101e74 <vector54>:
.globl vector54
vector54:
  pushl $0
  101e74:	6a 00                	push   $0x0
  pushl $54
  101e76:	6a 36                	push   $0x36
  jmp __alltraps
  101e78:	e9 91 08 00 00       	jmp    10270e <__alltraps>

00101e7d <vector55>:
.globl vector55
vector55:
  pushl $0
  101e7d:	6a 00                	push   $0x0
  pushl $55
  101e7f:	6a 37                	push   $0x37
  jmp __alltraps
  101e81:	e9 88 08 00 00       	jmp    10270e <__alltraps>

00101e86 <vector56>:
.globl vector56
vector56:
  pushl $0
  101e86:	6a 00                	push   $0x0
  pushl $56
  101e88:	6a 38                	push   $0x38
  jmp __alltraps
  101e8a:	e9 7f 08 00 00       	jmp    10270e <__alltraps>

00101e8f <vector57>:
.globl vector57
vector57:
  pushl $0
  101e8f:	6a 00                	push   $0x0
  pushl $57
  101e91:	6a 39                	push   $0x39
  jmp __alltraps
  101e93:	e9 76 08 00 00       	jmp    10270e <__alltraps>

00101e98 <vector58>:
.globl vector58
vector58:
  pushl $0
  101e98:	6a 00                	push   $0x0
  pushl $58
  101e9a:	6a 3a                	push   $0x3a
  jmp __alltraps
  101e9c:	e9 6d 08 00 00       	jmp    10270e <__alltraps>

00101ea1 <vector59>:
.globl vector59
vector59:
  pushl $0
  101ea1:	6a 00                	push   $0x0
  pushl $59
  101ea3:	6a 3b                	push   $0x3b
  jmp __alltraps
  101ea5:	e9 64 08 00 00       	jmp    10270e <__alltraps>

00101eaa <vector60>:
.globl vector60
vector60:
  pushl $0
  101eaa:	6a 00                	push   $0x0
  pushl $60
  101eac:	6a 3c                	push   $0x3c
  jmp __alltraps
  101eae:	e9 5b 08 00 00       	jmp    10270e <__alltraps>

00101eb3 <vector61>:
.globl vector61
vector61:
  pushl $0
  101eb3:	6a 00                	push   $0x0
  pushl $61
  101eb5:	6a 3d                	push   $0x3d
  jmp __alltraps
  101eb7:	e9 52 08 00 00       	jmp    10270e <__alltraps>

00101ebc <vector62>:
.globl vector62
vector62:
  pushl $0
  101ebc:	6a 00                	push   $0x0
  pushl $62
  101ebe:	6a 3e                	push   $0x3e
  jmp __alltraps
  101ec0:	e9 49 08 00 00       	jmp    10270e <__alltraps>

00101ec5 <vector63>:
.globl vector63
vector63:
  pushl $0
  101ec5:	6a 00                	push   $0x0
  pushl $63
  101ec7:	6a 3f                	push   $0x3f
  jmp __alltraps
  101ec9:	e9 40 08 00 00       	jmp    10270e <__alltraps>

00101ece <vector64>:
.globl vector64
vector64:
  pushl $0
  101ece:	6a 00                	push   $0x0
  pushl $64
  101ed0:	6a 40                	push   $0x40
  jmp __alltraps
  101ed2:	e9 37 08 00 00       	jmp    10270e <__alltraps>

00101ed7 <vector65>:
.globl vector65
vector65:
  pushl $0
  101ed7:	6a 00                	push   $0x0
  pushl $65
  101ed9:	6a 41                	push   $0x41
  jmp __alltraps
  101edb:	e9 2e 08 00 00       	jmp    10270e <__alltraps>

00101ee0 <vector66>:
.globl vector66
vector66:
  pushl $0
  101ee0:	6a 00                	push   $0x0
  pushl $66
  101ee2:	6a 42                	push   $0x42
  jmp __alltraps
  101ee4:	e9 25 08 00 00       	jmp    10270e <__alltraps>

00101ee9 <vector67>:
.globl vector67
vector67:
  pushl $0
  101ee9:	6a 00                	push   $0x0
  pushl $67
  101eeb:	6a 43                	push   $0x43
  jmp __alltraps
  101eed:	e9 1c 08 00 00       	jmp    10270e <__alltraps>

00101ef2 <vector68>:
.globl vector68
vector68:
  pushl $0
  101ef2:	6a 00                	push   $0x0
  pushl $68
  101ef4:	6a 44                	push   $0x44
  jmp __alltraps
  101ef6:	e9 13 08 00 00       	jmp    10270e <__alltraps>

00101efb <vector69>:
.globl vector69
vector69:
  pushl $0
  101efb:	6a 00                	push   $0x0
  pushl $69
  101efd:	6a 45                	push   $0x45
  jmp __alltraps
  101eff:	e9 0a 08 00 00       	jmp    10270e <__alltraps>

00101f04 <vector70>:
.globl vector70
vector70:
  pushl $0
  101f04:	6a 00                	push   $0x0
  pushl $70
  101f06:	6a 46                	push   $0x46
  jmp __alltraps
  101f08:	e9 01 08 00 00       	jmp    10270e <__alltraps>

00101f0d <vector71>:
.globl vector71
vector71:
  pushl $0
  101f0d:	6a 00                	push   $0x0
  pushl $71
  101f0f:	6a 47                	push   $0x47
  jmp __alltraps
  101f11:	e9 f8 07 00 00       	jmp    10270e <__alltraps>

00101f16 <vector72>:
.globl vector72
vector72:
  pushl $0
  101f16:	6a 00                	push   $0x0
  pushl $72
  101f18:	6a 48                	push   $0x48
  jmp __alltraps
  101f1a:	e9 ef 07 00 00       	jmp    10270e <__alltraps>

00101f1f <vector73>:
.globl vector73
vector73:
  pushl $0
  101f1f:	6a 00                	push   $0x0
  pushl $73
  101f21:	6a 49                	push   $0x49
  jmp __alltraps
  101f23:	e9 e6 07 00 00       	jmp    10270e <__alltraps>

00101f28 <vector74>:
.globl vector74
vector74:
  pushl $0
  101f28:	6a 00                	push   $0x0
  pushl $74
  101f2a:	6a 4a                	push   $0x4a
  jmp __alltraps
  101f2c:	e9 dd 07 00 00       	jmp    10270e <__alltraps>

00101f31 <vector75>:
.globl vector75
vector75:
  pushl $0
  101f31:	6a 00                	push   $0x0
  pushl $75
  101f33:	6a 4b                	push   $0x4b
  jmp __alltraps
  101f35:	e9 d4 07 00 00       	jmp    10270e <__alltraps>

00101f3a <vector76>:
.globl vector76
vector76:
  pushl $0
  101f3a:	6a 00                	push   $0x0
  pushl $76
  101f3c:	6a 4c                	push   $0x4c
  jmp __alltraps
  101f3e:	e9 cb 07 00 00       	jmp    10270e <__alltraps>

00101f43 <vector77>:
.globl vector77
vector77:
  pushl $0
  101f43:	6a 00                	push   $0x0
  pushl $77
  101f45:	6a 4d                	push   $0x4d
  jmp __alltraps
  101f47:	e9 c2 07 00 00       	jmp    10270e <__alltraps>

00101f4c <vector78>:
.globl vector78
vector78:
  pushl $0
  101f4c:	6a 00                	push   $0x0
  pushl $78
  101f4e:	6a 4e                	push   $0x4e
  jmp __alltraps
  101f50:	e9 b9 07 00 00       	jmp    10270e <__alltraps>

00101f55 <vector79>:
.globl vector79
vector79:
  pushl $0
  101f55:	6a 00                	push   $0x0
  pushl $79
  101f57:	6a 4f                	push   $0x4f
  jmp __alltraps
  101f59:	e9 b0 07 00 00       	jmp    10270e <__alltraps>

00101f5e <vector80>:
.globl vector80
vector80:
  pushl $0
  101f5e:	6a 00                	push   $0x0
  pushl $80
  101f60:	6a 50                	push   $0x50
  jmp __alltraps
  101f62:	e9 a7 07 00 00       	jmp    10270e <__alltraps>

00101f67 <vector81>:
.globl vector81
vector81:
  pushl $0
  101f67:	6a 00                	push   $0x0
  pushl $81
  101f69:	6a 51                	push   $0x51
  jmp __alltraps
  101f6b:	e9 9e 07 00 00       	jmp    10270e <__alltraps>

00101f70 <vector82>:
.globl vector82
vector82:
  pushl $0
  101f70:	6a 00                	push   $0x0
  pushl $82
  101f72:	6a 52                	push   $0x52
  jmp __alltraps
  101f74:	e9 95 07 00 00       	jmp    10270e <__alltraps>

00101f79 <vector83>:
.globl vector83
vector83:
  pushl $0
  101f79:	6a 00                	push   $0x0
  pushl $83
  101f7b:	6a 53                	push   $0x53
  jmp __alltraps
  101f7d:	e9 8c 07 00 00       	jmp    10270e <__alltraps>

00101f82 <vector84>:
.globl vector84
vector84:
  pushl $0
  101f82:	6a 00                	push   $0x0
  pushl $84
  101f84:	6a 54                	push   $0x54
  jmp __alltraps
  101f86:	e9 83 07 00 00       	jmp    10270e <__alltraps>

00101f8b <vector85>:
.globl vector85
vector85:
  pushl $0
  101f8b:	6a 00                	push   $0x0
  pushl $85
  101f8d:	6a 55                	push   $0x55
  jmp __alltraps
  101f8f:	e9 7a 07 00 00       	jmp    10270e <__alltraps>

00101f94 <vector86>:
.globl vector86
vector86:
  pushl $0
  101f94:	6a 00                	push   $0x0
  pushl $86
  101f96:	6a 56                	push   $0x56
  jmp __alltraps
  101f98:	e9 71 07 00 00       	jmp    10270e <__alltraps>

00101f9d <vector87>:
.globl vector87
vector87:
  pushl $0
  101f9d:	6a 00                	push   $0x0
  pushl $87
  101f9f:	6a 57                	push   $0x57
  jmp __alltraps
  101fa1:	e9 68 07 00 00       	jmp    10270e <__alltraps>

00101fa6 <vector88>:
.globl vector88
vector88:
  pushl $0
  101fa6:	6a 00                	push   $0x0
  pushl $88
  101fa8:	6a 58                	push   $0x58
  jmp __alltraps
  101faa:	e9 5f 07 00 00       	jmp    10270e <__alltraps>

00101faf <vector89>:
.globl vector89
vector89:
  pushl $0
  101faf:	6a 00                	push   $0x0
  pushl $89
  101fb1:	6a 59                	push   $0x59
  jmp __alltraps
  101fb3:	e9 56 07 00 00       	jmp    10270e <__alltraps>

00101fb8 <vector90>:
.globl vector90
vector90:
  pushl $0
  101fb8:	6a 00                	push   $0x0
  pushl $90
  101fba:	6a 5a                	push   $0x5a
  jmp __alltraps
  101fbc:	e9 4d 07 00 00       	jmp    10270e <__alltraps>

00101fc1 <vector91>:
.globl vector91
vector91:
  pushl $0
  101fc1:	6a 00                	push   $0x0
  pushl $91
  101fc3:	6a 5b                	push   $0x5b
  jmp __alltraps
  101fc5:	e9 44 07 00 00       	jmp    10270e <__alltraps>

00101fca <vector92>:
.globl vector92
vector92:
  pushl $0
  101fca:	6a 00                	push   $0x0
  pushl $92
  101fcc:	6a 5c                	push   $0x5c
  jmp __alltraps
  101fce:	e9 3b 07 00 00       	jmp    10270e <__alltraps>

00101fd3 <vector93>:
.globl vector93
vector93:
  pushl $0
  101fd3:	6a 00                	push   $0x0
  pushl $93
  101fd5:	6a 5d                	push   $0x5d
  jmp __alltraps
  101fd7:	e9 32 07 00 00       	jmp    10270e <__alltraps>

00101fdc <vector94>:
.globl vector94
vector94:
  pushl $0
  101fdc:	6a 00                	push   $0x0
  pushl $94
  101fde:	6a 5e                	push   $0x5e
  jmp __alltraps
  101fe0:	e9 29 07 00 00       	jmp    10270e <__alltraps>

00101fe5 <vector95>:
.globl vector95
vector95:
  pushl $0
  101fe5:	6a 00                	push   $0x0
  pushl $95
  101fe7:	6a 5f                	push   $0x5f
  jmp __alltraps
  101fe9:	e9 20 07 00 00       	jmp    10270e <__alltraps>

00101fee <vector96>:
.globl vector96
vector96:
  pushl $0
  101fee:	6a 00                	push   $0x0
  pushl $96
  101ff0:	6a 60                	push   $0x60
  jmp __alltraps
  101ff2:	e9 17 07 00 00       	jmp    10270e <__alltraps>

00101ff7 <vector97>:
.globl vector97
vector97:
  pushl $0
  101ff7:	6a 00                	push   $0x0
  pushl $97
  101ff9:	6a 61                	push   $0x61
  jmp __alltraps
  101ffb:	e9 0e 07 00 00       	jmp    10270e <__alltraps>

00102000 <vector98>:
.globl vector98
vector98:
  pushl $0
  102000:	6a 00                	push   $0x0
  pushl $98
  102002:	6a 62                	push   $0x62
  jmp __alltraps
  102004:	e9 05 07 00 00       	jmp    10270e <__alltraps>

00102009 <vector99>:
.globl vector99
vector99:
  pushl $0
  102009:	6a 00                	push   $0x0
  pushl $99
  10200b:	6a 63                	push   $0x63
  jmp __alltraps
  10200d:	e9 fc 06 00 00       	jmp    10270e <__alltraps>

00102012 <vector100>:
.globl vector100
vector100:
  pushl $0
  102012:	6a 00                	push   $0x0
  pushl $100
  102014:	6a 64                	push   $0x64
  jmp __alltraps
  102016:	e9 f3 06 00 00       	jmp    10270e <__alltraps>

0010201b <vector101>:
.globl vector101
vector101:
  pushl $0
  10201b:	6a 00                	push   $0x0
  pushl $101
  10201d:	6a 65                	push   $0x65
  jmp __alltraps
  10201f:	e9 ea 06 00 00       	jmp    10270e <__alltraps>

00102024 <vector102>:
.globl vector102
vector102:
  pushl $0
  102024:	6a 00                	push   $0x0
  pushl $102
  102026:	6a 66                	push   $0x66
  jmp __alltraps
  102028:	e9 e1 06 00 00       	jmp    10270e <__alltraps>

0010202d <vector103>:
.globl vector103
vector103:
  pushl $0
  10202d:	6a 00                	push   $0x0
  pushl $103
  10202f:	6a 67                	push   $0x67
  jmp __alltraps
  102031:	e9 d8 06 00 00       	jmp    10270e <__alltraps>

00102036 <vector104>:
.globl vector104
vector104:
  pushl $0
  102036:	6a 00                	push   $0x0
  pushl $104
  102038:	6a 68                	push   $0x68
  jmp __alltraps
  10203a:	e9 cf 06 00 00       	jmp    10270e <__alltraps>

0010203f <vector105>:
.globl vector105
vector105:
  pushl $0
  10203f:	6a 00                	push   $0x0
  pushl $105
  102041:	6a 69                	push   $0x69
  jmp __alltraps
  102043:	e9 c6 06 00 00       	jmp    10270e <__alltraps>

00102048 <vector106>:
.globl vector106
vector106:
  pushl $0
  102048:	6a 00                	push   $0x0
  pushl $106
  10204a:	6a 6a                	push   $0x6a
  jmp __alltraps
  10204c:	e9 bd 06 00 00       	jmp    10270e <__alltraps>

00102051 <vector107>:
.globl vector107
vector107:
  pushl $0
  102051:	6a 00                	push   $0x0
  pushl $107
  102053:	6a 6b                	push   $0x6b
  jmp __alltraps
  102055:	e9 b4 06 00 00       	jmp    10270e <__alltraps>

0010205a <vector108>:
.globl vector108
vector108:
  pushl $0
  10205a:	6a 00                	push   $0x0
  pushl $108
  10205c:	6a 6c                	push   $0x6c
  jmp __alltraps
  10205e:	e9 ab 06 00 00       	jmp    10270e <__alltraps>

00102063 <vector109>:
.globl vector109
vector109:
  pushl $0
  102063:	6a 00                	push   $0x0
  pushl $109
  102065:	6a 6d                	push   $0x6d
  jmp __alltraps
  102067:	e9 a2 06 00 00       	jmp    10270e <__alltraps>

0010206c <vector110>:
.globl vector110
vector110:
  pushl $0
  10206c:	6a 00                	push   $0x0
  pushl $110
  10206e:	6a 6e                	push   $0x6e
  jmp __alltraps
  102070:	e9 99 06 00 00       	jmp    10270e <__alltraps>

00102075 <vector111>:
.globl vector111
vector111:
  pushl $0
  102075:	6a 00                	push   $0x0
  pushl $111
  102077:	6a 6f                	push   $0x6f
  jmp __alltraps
  102079:	e9 90 06 00 00       	jmp    10270e <__alltraps>

0010207e <vector112>:
.globl vector112
vector112:
  pushl $0
  10207e:	6a 00                	push   $0x0
  pushl $112
  102080:	6a 70                	push   $0x70
  jmp __alltraps
  102082:	e9 87 06 00 00       	jmp    10270e <__alltraps>

00102087 <vector113>:
.globl vector113
vector113:
  pushl $0
  102087:	6a 00                	push   $0x0
  pushl $113
  102089:	6a 71                	push   $0x71
  jmp __alltraps
  10208b:	e9 7e 06 00 00       	jmp    10270e <__alltraps>

00102090 <vector114>:
.globl vector114
vector114:
  pushl $0
  102090:	6a 00                	push   $0x0
  pushl $114
  102092:	6a 72                	push   $0x72
  jmp __alltraps
  102094:	e9 75 06 00 00       	jmp    10270e <__alltraps>

00102099 <vector115>:
.globl vector115
vector115:
  pushl $0
  102099:	6a 00                	push   $0x0
  pushl $115
  10209b:	6a 73                	push   $0x73
  jmp __alltraps
  10209d:	e9 6c 06 00 00       	jmp    10270e <__alltraps>

001020a2 <vector116>:
.globl vector116
vector116:
  pushl $0
  1020a2:	6a 00                	push   $0x0
  pushl $116
  1020a4:	6a 74                	push   $0x74
  jmp __alltraps
  1020a6:	e9 63 06 00 00       	jmp    10270e <__alltraps>

001020ab <vector117>:
.globl vector117
vector117:
  pushl $0
  1020ab:	6a 00                	push   $0x0
  pushl $117
  1020ad:	6a 75                	push   $0x75
  jmp __alltraps
  1020af:	e9 5a 06 00 00       	jmp    10270e <__alltraps>

001020b4 <vector118>:
.globl vector118
vector118:
  pushl $0
  1020b4:	6a 00                	push   $0x0
  pushl $118
  1020b6:	6a 76                	push   $0x76
  jmp __alltraps
  1020b8:	e9 51 06 00 00       	jmp    10270e <__alltraps>

001020bd <vector119>:
.globl vector119
vector119:
  pushl $0
  1020bd:	6a 00                	push   $0x0
  pushl $119
  1020bf:	6a 77                	push   $0x77
  jmp __alltraps
  1020c1:	e9 48 06 00 00       	jmp    10270e <__alltraps>

001020c6 <vector120>:
.globl vector120
vector120:
  pushl $0
  1020c6:	6a 00                	push   $0x0
  pushl $120
  1020c8:	6a 78                	push   $0x78
  jmp __alltraps
  1020ca:	e9 3f 06 00 00       	jmp    10270e <__alltraps>

001020cf <vector121>:
.globl vector121
vector121:
  pushl $0
  1020cf:	6a 00                	push   $0x0
  pushl $121
  1020d1:	6a 79                	push   $0x79
  jmp __alltraps
  1020d3:	e9 36 06 00 00       	jmp    10270e <__alltraps>

001020d8 <vector122>:
.globl vector122
vector122:
  pushl $0
  1020d8:	6a 00                	push   $0x0
  pushl $122
  1020da:	6a 7a                	push   $0x7a
  jmp __alltraps
  1020dc:	e9 2d 06 00 00       	jmp    10270e <__alltraps>

001020e1 <vector123>:
.globl vector123
vector123:
  pushl $0
  1020e1:	6a 00                	push   $0x0
  pushl $123
  1020e3:	6a 7b                	push   $0x7b
  jmp __alltraps
  1020e5:	e9 24 06 00 00       	jmp    10270e <__alltraps>

001020ea <vector124>:
.globl vector124
vector124:
  pushl $0
  1020ea:	6a 00                	push   $0x0
  pushl $124
  1020ec:	6a 7c                	push   $0x7c
  jmp __alltraps
  1020ee:	e9 1b 06 00 00       	jmp    10270e <__alltraps>

001020f3 <vector125>:
.globl vector125
vector125:
  pushl $0
  1020f3:	6a 00                	push   $0x0
  pushl $125
  1020f5:	6a 7d                	push   $0x7d
  jmp __alltraps
  1020f7:	e9 12 06 00 00       	jmp    10270e <__alltraps>

001020fc <vector126>:
.globl vector126
vector126:
  pushl $0
  1020fc:	6a 00                	push   $0x0
  pushl $126
  1020fe:	6a 7e                	push   $0x7e
  jmp __alltraps
  102100:	e9 09 06 00 00       	jmp    10270e <__alltraps>

00102105 <vector127>:
.globl vector127
vector127:
  pushl $0
  102105:	6a 00                	push   $0x0
  pushl $127
  102107:	6a 7f                	push   $0x7f
  jmp __alltraps
  102109:	e9 00 06 00 00       	jmp    10270e <__alltraps>

0010210e <vector128>:
.globl vector128
vector128:
  pushl $0
  10210e:	6a 00                	push   $0x0
  pushl $128
  102110:	68 80 00 00 00       	push   $0x80
  jmp __alltraps
  102115:	e9 f4 05 00 00       	jmp    10270e <__alltraps>

0010211a <vector129>:
.globl vector129
vector129:
  pushl $0
  10211a:	6a 00                	push   $0x0
  pushl $129
  10211c:	68 81 00 00 00       	push   $0x81
  jmp __alltraps
  102121:	e9 e8 05 00 00       	jmp    10270e <__alltraps>

00102126 <vector130>:
.globl vector130
vector130:
  pushl $0
  102126:	6a 00                	push   $0x0
  pushl $130
  102128:	68 82 00 00 00       	push   $0x82
  jmp __alltraps
  10212d:	e9 dc 05 00 00       	jmp    10270e <__alltraps>

00102132 <vector131>:
.globl vector131
vector131:
  pushl $0
  102132:	6a 00                	push   $0x0
  pushl $131
  102134:	68 83 00 00 00       	push   $0x83
  jmp __alltraps
  102139:	e9 d0 05 00 00       	jmp    10270e <__alltraps>

0010213e <vector132>:
.globl vector132
vector132:
  pushl $0
  10213e:	6a 00                	push   $0x0
  pushl $132
  102140:	68 84 00 00 00       	push   $0x84
  jmp __alltraps
  102145:	e9 c4 05 00 00       	jmp    10270e <__alltraps>

0010214a <vector133>:
.globl vector133
vector133:
  pushl $0
  10214a:	6a 00                	push   $0x0
  pushl $133
  10214c:	68 85 00 00 00       	push   $0x85
  jmp __alltraps
  102151:	e9 b8 05 00 00       	jmp    10270e <__alltraps>

00102156 <vector134>:
.globl vector134
vector134:
  pushl $0
  102156:	6a 00                	push   $0x0
  pushl $134
  102158:	68 86 00 00 00       	push   $0x86
  jmp __alltraps
  10215d:	e9 ac 05 00 00       	jmp    10270e <__alltraps>

00102162 <vector135>:
.globl vector135
vector135:
  pushl $0
  102162:	6a 00                	push   $0x0
  pushl $135
  102164:	68 87 00 00 00       	push   $0x87
  jmp __alltraps
  102169:	e9 a0 05 00 00       	jmp    10270e <__alltraps>

0010216e <vector136>:
.globl vector136
vector136:
  pushl $0
  10216e:	6a 00                	push   $0x0
  pushl $136
  102170:	68 88 00 00 00       	push   $0x88
  jmp __alltraps
  102175:	e9 94 05 00 00       	jmp    10270e <__alltraps>

0010217a <vector137>:
.globl vector137
vector137:
  pushl $0
  10217a:	6a 00                	push   $0x0
  pushl $137
  10217c:	68 89 00 00 00       	push   $0x89
  jmp __alltraps
  102181:	e9 88 05 00 00       	jmp    10270e <__alltraps>

00102186 <vector138>:
.globl vector138
vector138:
  pushl $0
  102186:	6a 00                	push   $0x0
  pushl $138
  102188:	68 8a 00 00 00       	push   $0x8a
  jmp __alltraps
  10218d:	e9 7c 05 00 00       	jmp    10270e <__alltraps>

00102192 <vector139>:
.globl vector139
vector139:
  pushl $0
  102192:	6a 00                	push   $0x0
  pushl $139
  102194:	68 8b 00 00 00       	push   $0x8b
  jmp __alltraps
  102199:	e9 70 05 00 00       	jmp    10270e <__alltraps>

0010219e <vector140>:
.globl vector140
vector140:
  pushl $0
  10219e:	6a 00                	push   $0x0
  pushl $140
  1021a0:	68 8c 00 00 00       	push   $0x8c
  jmp __alltraps
  1021a5:	e9 64 05 00 00       	jmp    10270e <__alltraps>

001021aa <vector141>:
.globl vector141
vector141:
  pushl $0
  1021aa:	6a 00                	push   $0x0
  pushl $141
  1021ac:	68 8d 00 00 00       	push   $0x8d
  jmp __alltraps
  1021b1:	e9 58 05 00 00       	jmp    10270e <__alltraps>

001021b6 <vector142>:
.globl vector142
vector142:
  pushl $0
  1021b6:	6a 00                	push   $0x0
  pushl $142
  1021b8:	68 8e 00 00 00       	push   $0x8e
  jmp __alltraps
  1021bd:	e9 4c 05 00 00       	jmp    10270e <__alltraps>

001021c2 <vector143>:
.globl vector143
vector143:
  pushl $0
  1021c2:	6a 00                	push   $0x0
  pushl $143
  1021c4:	68 8f 00 00 00       	push   $0x8f
  jmp __alltraps
  1021c9:	e9 40 05 00 00       	jmp    10270e <__alltraps>

001021ce <vector144>:
.globl vector144
vector144:
  pushl $0
  1021ce:	6a 00                	push   $0x0
  pushl $144
  1021d0:	68 90 00 00 00       	push   $0x90
  jmp __alltraps
  1021d5:	e9 34 05 00 00       	jmp    10270e <__alltraps>

001021da <vector145>:
.globl vector145
vector145:
  pushl $0
  1021da:	6a 00                	push   $0x0
  pushl $145
  1021dc:	68 91 00 00 00       	push   $0x91
  jmp __alltraps
  1021e1:	e9 28 05 00 00       	jmp    10270e <__alltraps>

001021e6 <vector146>:
.globl vector146
vector146:
  pushl $0
  1021e6:	6a 00                	push   $0x0
  pushl $146
  1021e8:	68 92 00 00 00       	push   $0x92
  jmp __alltraps
  1021ed:	e9 1c 05 00 00       	jmp    10270e <__alltraps>

001021f2 <vector147>:
.globl vector147
vector147:
  pushl $0
  1021f2:	6a 00                	push   $0x0
  pushl $147
  1021f4:	68 93 00 00 00       	push   $0x93
  jmp __alltraps
  1021f9:	e9 10 05 00 00       	jmp    10270e <__alltraps>

001021fe <vector148>:
.globl vector148
vector148:
  pushl $0
  1021fe:	6a 00                	push   $0x0
  pushl $148
  102200:	68 94 00 00 00       	push   $0x94
  jmp __alltraps
  102205:	e9 04 05 00 00       	jmp    10270e <__alltraps>

0010220a <vector149>:
.globl vector149
vector149:
  pushl $0
  10220a:	6a 00                	push   $0x0
  pushl $149
  10220c:	68 95 00 00 00       	push   $0x95
  jmp __alltraps
  102211:	e9 f8 04 00 00       	jmp    10270e <__alltraps>

00102216 <vector150>:
.globl vector150
vector150:
  pushl $0
  102216:	6a 00                	push   $0x0
  pushl $150
  102218:	68 96 00 00 00       	push   $0x96
  jmp __alltraps
  10221d:	e9 ec 04 00 00       	jmp    10270e <__alltraps>

00102222 <vector151>:
.globl vector151
vector151:
  pushl $0
  102222:	6a 00                	push   $0x0
  pushl $151
  102224:	68 97 00 00 00       	push   $0x97
  jmp __alltraps
  102229:	e9 e0 04 00 00       	jmp    10270e <__alltraps>

0010222e <vector152>:
.globl vector152
vector152:
  pushl $0
  10222e:	6a 00                	push   $0x0
  pushl $152
  102230:	68 98 00 00 00       	push   $0x98
  jmp __alltraps
  102235:	e9 d4 04 00 00       	jmp    10270e <__alltraps>

0010223a <vector153>:
.globl vector153
vector153:
  pushl $0
  10223a:	6a 00                	push   $0x0
  pushl $153
  10223c:	68 99 00 00 00       	push   $0x99
  jmp __alltraps
  102241:	e9 c8 04 00 00       	jmp    10270e <__alltraps>

00102246 <vector154>:
.globl vector154
vector154:
  pushl $0
  102246:	6a 00                	push   $0x0
  pushl $154
  102248:	68 9a 00 00 00       	push   $0x9a
  jmp __alltraps
  10224d:	e9 bc 04 00 00       	jmp    10270e <__alltraps>

00102252 <vector155>:
.globl vector155
vector155:
  pushl $0
  102252:	6a 00                	push   $0x0
  pushl $155
  102254:	68 9b 00 00 00       	push   $0x9b
  jmp __alltraps
  102259:	e9 b0 04 00 00       	jmp    10270e <__alltraps>

0010225e <vector156>:
.globl vector156
vector156:
  pushl $0
  10225e:	6a 00                	push   $0x0
  pushl $156
  102260:	68 9c 00 00 00       	push   $0x9c
  jmp __alltraps
  102265:	e9 a4 04 00 00       	jmp    10270e <__alltraps>

0010226a <vector157>:
.globl vector157
vector157:
  pushl $0
  10226a:	6a 00                	push   $0x0
  pushl $157
  10226c:	68 9d 00 00 00       	push   $0x9d
  jmp __alltraps
  102271:	e9 98 04 00 00       	jmp    10270e <__alltraps>

00102276 <vector158>:
.globl vector158
vector158:
  pushl $0
  102276:	6a 00                	push   $0x0
  pushl $158
  102278:	68 9e 00 00 00       	push   $0x9e
  jmp __alltraps
  10227d:	e9 8c 04 00 00       	jmp    10270e <__alltraps>

00102282 <vector159>:
.globl vector159
vector159:
  pushl $0
  102282:	6a 00                	push   $0x0
  pushl $159
  102284:	68 9f 00 00 00       	push   $0x9f
  jmp __alltraps
  102289:	e9 80 04 00 00       	jmp    10270e <__alltraps>

0010228e <vector160>:
.globl vector160
vector160:
  pushl $0
  10228e:	6a 00                	push   $0x0
  pushl $160
  102290:	68 a0 00 00 00       	push   $0xa0
  jmp __alltraps
  102295:	e9 74 04 00 00       	jmp    10270e <__alltraps>

0010229a <vector161>:
.globl vector161
vector161:
  pushl $0
  10229a:	6a 00                	push   $0x0
  pushl $161
  10229c:	68 a1 00 00 00       	push   $0xa1
  jmp __alltraps
  1022a1:	e9 68 04 00 00       	jmp    10270e <__alltraps>

001022a6 <vector162>:
.globl vector162
vector162:
  pushl $0
  1022a6:	6a 00                	push   $0x0
  pushl $162
  1022a8:	68 a2 00 00 00       	push   $0xa2
  jmp __alltraps
  1022ad:	e9 5c 04 00 00       	jmp    10270e <__alltraps>

001022b2 <vector163>:
.globl vector163
vector163:
  pushl $0
  1022b2:	6a 00                	push   $0x0
  pushl $163
  1022b4:	68 a3 00 00 00       	push   $0xa3
  jmp __alltraps
  1022b9:	e9 50 04 00 00       	jmp    10270e <__alltraps>

001022be <vector164>:
.globl vector164
vector164:
  pushl $0
  1022be:	6a 00                	push   $0x0
  pushl $164
  1022c0:	68 a4 00 00 00       	push   $0xa4
  jmp __alltraps
  1022c5:	e9 44 04 00 00       	jmp    10270e <__alltraps>

001022ca <vector165>:
.globl vector165
vector165:
  pushl $0
  1022ca:	6a 00                	push   $0x0
  pushl $165
  1022cc:	68 a5 00 00 00       	push   $0xa5
  jmp __alltraps
  1022d1:	e9 38 04 00 00       	jmp    10270e <__alltraps>

001022d6 <vector166>:
.globl vector166
vector166:
  pushl $0
  1022d6:	6a 00                	push   $0x0
  pushl $166
  1022d8:	68 a6 00 00 00       	push   $0xa6
  jmp __alltraps
  1022dd:	e9 2c 04 00 00       	jmp    10270e <__alltraps>

001022e2 <vector167>:
.globl vector167
vector167:
  pushl $0
  1022e2:	6a 00                	push   $0x0
  pushl $167
  1022e4:	68 a7 00 00 00       	push   $0xa7
  jmp __alltraps
  1022e9:	e9 20 04 00 00       	jmp    10270e <__alltraps>

001022ee <vector168>:
.globl vector168
vector168:
  pushl $0
  1022ee:	6a 00                	push   $0x0
  pushl $168
  1022f0:	68 a8 00 00 00       	push   $0xa8
  jmp __alltraps
  1022f5:	e9 14 04 00 00       	jmp    10270e <__alltraps>

001022fa <vector169>:
.globl vector169
vector169:
  pushl $0
  1022fa:	6a 00                	push   $0x0
  pushl $169
  1022fc:	68 a9 00 00 00       	push   $0xa9
  jmp __alltraps
  102301:	e9 08 04 00 00       	jmp    10270e <__alltraps>

00102306 <vector170>:
.globl vector170
vector170:
  pushl $0
  102306:	6a 00                	push   $0x0
  pushl $170
  102308:	68 aa 00 00 00       	push   $0xaa
  jmp __alltraps
  10230d:	e9 fc 03 00 00       	jmp    10270e <__alltraps>

00102312 <vector171>:
.globl vector171
vector171:
  pushl $0
  102312:	6a 00                	push   $0x0
  pushl $171
  102314:	68 ab 00 00 00       	push   $0xab
  jmp __alltraps
  102319:	e9 f0 03 00 00       	jmp    10270e <__alltraps>

0010231e <vector172>:
.globl vector172
vector172:
  pushl $0
  10231e:	6a 00                	push   $0x0
  pushl $172
  102320:	68 ac 00 00 00       	push   $0xac
  jmp __alltraps
  102325:	e9 e4 03 00 00       	jmp    10270e <__alltraps>

0010232a <vector173>:
.globl vector173
vector173:
  pushl $0
  10232a:	6a 00                	push   $0x0
  pushl $173
  10232c:	68 ad 00 00 00       	push   $0xad
  jmp __alltraps
  102331:	e9 d8 03 00 00       	jmp    10270e <__alltraps>

00102336 <vector174>:
.globl vector174
vector174:
  pushl $0
  102336:	6a 00                	push   $0x0
  pushl $174
  102338:	68 ae 00 00 00       	push   $0xae
  jmp __alltraps
  10233d:	e9 cc 03 00 00       	jmp    10270e <__alltraps>

00102342 <vector175>:
.globl vector175
vector175:
  pushl $0
  102342:	6a 00                	push   $0x0
  pushl $175
  102344:	68 af 00 00 00       	push   $0xaf
  jmp __alltraps
  102349:	e9 c0 03 00 00       	jmp    10270e <__alltraps>

0010234e <vector176>:
.globl vector176
vector176:
  pushl $0
  10234e:	6a 00                	push   $0x0
  pushl $176
  102350:	68 b0 00 00 00       	push   $0xb0
  jmp __alltraps
  102355:	e9 b4 03 00 00       	jmp    10270e <__alltraps>

0010235a <vector177>:
.globl vector177
vector177:
  pushl $0
  10235a:	6a 00                	push   $0x0
  pushl $177
  10235c:	68 b1 00 00 00       	push   $0xb1
  jmp __alltraps
  102361:	e9 a8 03 00 00       	jmp    10270e <__alltraps>

00102366 <vector178>:
.globl vector178
vector178:
  pushl $0
  102366:	6a 00                	push   $0x0
  pushl $178
  102368:	68 b2 00 00 00       	push   $0xb2
  jmp __alltraps
  10236d:	e9 9c 03 00 00       	jmp    10270e <__alltraps>

00102372 <vector179>:
.globl vector179
vector179:
  pushl $0
  102372:	6a 00                	push   $0x0
  pushl $179
  102374:	68 b3 00 00 00       	push   $0xb3
  jmp __alltraps
  102379:	e9 90 03 00 00       	jmp    10270e <__alltraps>

0010237e <vector180>:
.globl vector180
vector180:
  pushl $0
  10237e:	6a 00                	push   $0x0
  pushl $180
  102380:	68 b4 00 00 00       	push   $0xb4
  jmp __alltraps
  102385:	e9 84 03 00 00       	jmp    10270e <__alltraps>

0010238a <vector181>:
.globl vector181
vector181:
  pushl $0
  10238a:	6a 00                	push   $0x0
  pushl $181
  10238c:	68 b5 00 00 00       	push   $0xb5
  jmp __alltraps
  102391:	e9 78 03 00 00       	jmp    10270e <__alltraps>

00102396 <vector182>:
.globl vector182
vector182:
  pushl $0
  102396:	6a 00                	push   $0x0
  pushl $182
  102398:	68 b6 00 00 00       	push   $0xb6
  jmp __alltraps
  10239d:	e9 6c 03 00 00       	jmp    10270e <__alltraps>

001023a2 <vector183>:
.globl vector183
vector183:
  pushl $0
  1023a2:	6a 00                	push   $0x0
  pushl $183
  1023a4:	68 b7 00 00 00       	push   $0xb7
  jmp __alltraps
  1023a9:	e9 60 03 00 00       	jmp    10270e <__alltraps>

001023ae <vector184>:
.globl vector184
vector184:
  pushl $0
  1023ae:	6a 00                	push   $0x0
  pushl $184
  1023b0:	68 b8 00 00 00       	push   $0xb8
  jmp __alltraps
  1023b5:	e9 54 03 00 00       	jmp    10270e <__alltraps>

001023ba <vector185>:
.globl vector185
vector185:
  pushl $0
  1023ba:	6a 00                	push   $0x0
  pushl $185
  1023bc:	68 b9 00 00 00       	push   $0xb9
  jmp __alltraps
  1023c1:	e9 48 03 00 00       	jmp    10270e <__alltraps>

001023c6 <vector186>:
.globl vector186
vector186:
  pushl $0
  1023c6:	6a 00                	push   $0x0
  pushl $186
  1023c8:	68 ba 00 00 00       	push   $0xba
  jmp __alltraps
  1023cd:	e9 3c 03 00 00       	jmp    10270e <__alltraps>

001023d2 <vector187>:
.globl vector187
vector187:
  pushl $0
  1023d2:	6a 00                	push   $0x0
  pushl $187
  1023d4:	68 bb 00 00 00       	push   $0xbb
  jmp __alltraps
  1023d9:	e9 30 03 00 00       	jmp    10270e <__alltraps>

001023de <vector188>:
.globl vector188
vector188:
  pushl $0
  1023de:	6a 00                	push   $0x0
  pushl $188
  1023e0:	68 bc 00 00 00       	push   $0xbc
  jmp __alltraps
  1023e5:	e9 24 03 00 00       	jmp    10270e <__alltraps>

001023ea <vector189>:
.globl vector189
vector189:
  pushl $0
  1023ea:	6a 00                	push   $0x0
  pushl $189
  1023ec:	68 bd 00 00 00       	push   $0xbd
  jmp __alltraps
  1023f1:	e9 18 03 00 00       	jmp    10270e <__alltraps>

001023f6 <vector190>:
.globl vector190
vector190:
  pushl $0
  1023f6:	6a 00                	push   $0x0
  pushl $190
  1023f8:	68 be 00 00 00       	push   $0xbe
  jmp __alltraps
  1023fd:	e9 0c 03 00 00       	jmp    10270e <__alltraps>

00102402 <vector191>:
.globl vector191
vector191:
  pushl $0
  102402:	6a 00                	push   $0x0
  pushl $191
  102404:	68 bf 00 00 00       	push   $0xbf
  jmp __alltraps
  102409:	e9 00 03 00 00       	jmp    10270e <__alltraps>

0010240e <vector192>:
.globl vector192
vector192:
  pushl $0
  10240e:	6a 00                	push   $0x0
  pushl $192
  102410:	68 c0 00 00 00       	push   $0xc0
  jmp __alltraps
  102415:	e9 f4 02 00 00       	jmp    10270e <__alltraps>

0010241a <vector193>:
.globl vector193
vector193:
  pushl $0
  10241a:	6a 00                	push   $0x0
  pushl $193
  10241c:	68 c1 00 00 00       	push   $0xc1
  jmp __alltraps
  102421:	e9 e8 02 00 00       	jmp    10270e <__alltraps>

00102426 <vector194>:
.globl vector194
vector194:
  pushl $0
  102426:	6a 00                	push   $0x0
  pushl $194
  102428:	68 c2 00 00 00       	push   $0xc2
  jmp __alltraps
  10242d:	e9 dc 02 00 00       	jmp    10270e <__alltraps>

00102432 <vector195>:
.globl vector195
vector195:
  pushl $0
  102432:	6a 00                	push   $0x0
  pushl $195
  102434:	68 c3 00 00 00       	push   $0xc3
  jmp __alltraps
  102439:	e9 d0 02 00 00       	jmp    10270e <__alltraps>

0010243e <vector196>:
.globl vector196
vector196:
  pushl $0
  10243e:	6a 00                	push   $0x0
  pushl $196
  102440:	68 c4 00 00 00       	push   $0xc4
  jmp __alltraps
  102445:	e9 c4 02 00 00       	jmp    10270e <__alltraps>

0010244a <vector197>:
.globl vector197
vector197:
  pushl $0
  10244a:	6a 00                	push   $0x0
  pushl $197
  10244c:	68 c5 00 00 00       	push   $0xc5
  jmp __alltraps
  102451:	e9 b8 02 00 00       	jmp    10270e <__alltraps>

00102456 <vector198>:
.globl vector198
vector198:
  pushl $0
  102456:	6a 00                	push   $0x0
  pushl $198
  102458:	68 c6 00 00 00       	push   $0xc6
  jmp __alltraps
  10245d:	e9 ac 02 00 00       	jmp    10270e <__alltraps>

00102462 <vector199>:
.globl vector199
vector199:
  pushl $0
  102462:	6a 00                	push   $0x0
  pushl $199
  102464:	68 c7 00 00 00       	push   $0xc7
  jmp __alltraps
  102469:	e9 a0 02 00 00       	jmp    10270e <__alltraps>

0010246e <vector200>:
.globl vector200
vector200:
  pushl $0
  10246e:	6a 00                	push   $0x0
  pushl $200
  102470:	68 c8 00 00 00       	push   $0xc8
  jmp __alltraps
  102475:	e9 94 02 00 00       	jmp    10270e <__alltraps>

0010247a <vector201>:
.globl vector201
vector201:
  pushl $0
  10247a:	6a 00                	push   $0x0
  pushl $201
  10247c:	68 c9 00 00 00       	push   $0xc9
  jmp __alltraps
  102481:	e9 88 02 00 00       	jmp    10270e <__alltraps>

00102486 <vector202>:
.globl vector202
vector202:
  pushl $0
  102486:	6a 00                	push   $0x0
  pushl $202
  102488:	68 ca 00 00 00       	push   $0xca
  jmp __alltraps
  10248d:	e9 7c 02 00 00       	jmp    10270e <__alltraps>

00102492 <vector203>:
.globl vector203
vector203:
  pushl $0
  102492:	6a 00                	push   $0x0
  pushl $203
  102494:	68 cb 00 00 00       	push   $0xcb
  jmp __alltraps
  102499:	e9 70 02 00 00       	jmp    10270e <__alltraps>

0010249e <vector204>:
.globl vector204
vector204:
  pushl $0
  10249e:	6a 00                	push   $0x0
  pushl $204
  1024a0:	68 cc 00 00 00       	push   $0xcc
  jmp __alltraps
  1024a5:	e9 64 02 00 00       	jmp    10270e <__alltraps>

001024aa <vector205>:
.globl vector205
vector205:
  pushl $0
  1024aa:	6a 00                	push   $0x0
  pushl $205
  1024ac:	68 cd 00 00 00       	push   $0xcd
  jmp __alltraps
  1024b1:	e9 58 02 00 00       	jmp    10270e <__alltraps>

001024b6 <vector206>:
.globl vector206
vector206:
  pushl $0
  1024b6:	6a 00                	push   $0x0
  pushl $206
  1024b8:	68 ce 00 00 00       	push   $0xce
  jmp __alltraps
  1024bd:	e9 4c 02 00 00       	jmp    10270e <__alltraps>

001024c2 <vector207>:
.globl vector207
vector207:
  pushl $0
  1024c2:	6a 00                	push   $0x0
  pushl $207
  1024c4:	68 cf 00 00 00       	push   $0xcf
  jmp __alltraps
  1024c9:	e9 40 02 00 00       	jmp    10270e <__alltraps>

001024ce <vector208>:
.globl vector208
vector208:
  pushl $0
  1024ce:	6a 00                	push   $0x0
  pushl $208
  1024d0:	68 d0 00 00 00       	push   $0xd0
  jmp __alltraps
  1024d5:	e9 34 02 00 00       	jmp    10270e <__alltraps>

001024da <vector209>:
.globl vector209
vector209:
  pushl $0
  1024da:	6a 00                	push   $0x0
  pushl $209
  1024dc:	68 d1 00 00 00       	push   $0xd1
  jmp __alltraps
  1024e1:	e9 28 02 00 00       	jmp    10270e <__alltraps>

001024e6 <vector210>:
.globl vector210
vector210:
  pushl $0
  1024e6:	6a 00                	push   $0x0
  pushl $210
  1024e8:	68 d2 00 00 00       	push   $0xd2
  jmp __alltraps
  1024ed:	e9 1c 02 00 00       	jmp    10270e <__alltraps>

001024f2 <vector211>:
.globl vector211
vector211:
  pushl $0
  1024f2:	6a 00                	push   $0x0
  pushl $211
  1024f4:	68 d3 00 00 00       	push   $0xd3
  jmp __alltraps
  1024f9:	e9 10 02 00 00       	jmp    10270e <__alltraps>

001024fe <vector212>:
.globl vector212
vector212:
  pushl $0
  1024fe:	6a 00                	push   $0x0
  pushl $212
  102500:	68 d4 00 00 00       	push   $0xd4
  jmp __alltraps
  102505:	e9 04 02 00 00       	jmp    10270e <__alltraps>

0010250a <vector213>:
.globl vector213
vector213:
  pushl $0
  10250a:	6a 00                	push   $0x0
  pushl $213
  10250c:	68 d5 00 00 00       	push   $0xd5
  jmp __alltraps
  102511:	e9 f8 01 00 00       	jmp    10270e <__alltraps>

00102516 <vector214>:
.globl vector214
vector214:
  pushl $0
  102516:	6a 00                	push   $0x0
  pushl $214
  102518:	68 d6 00 00 00       	push   $0xd6
  jmp __alltraps
  10251d:	e9 ec 01 00 00       	jmp    10270e <__alltraps>

00102522 <vector215>:
.globl vector215
vector215:
  pushl $0
  102522:	6a 00                	push   $0x0
  pushl $215
  102524:	68 d7 00 00 00       	push   $0xd7
  jmp __alltraps
  102529:	e9 e0 01 00 00       	jmp    10270e <__alltraps>

0010252e <vector216>:
.globl vector216
vector216:
  pushl $0
  10252e:	6a 00                	push   $0x0
  pushl $216
  102530:	68 d8 00 00 00       	push   $0xd8
  jmp __alltraps
  102535:	e9 d4 01 00 00       	jmp    10270e <__alltraps>

0010253a <vector217>:
.globl vector217
vector217:
  pushl $0
  10253a:	6a 00                	push   $0x0
  pushl $217
  10253c:	68 d9 00 00 00       	push   $0xd9
  jmp __alltraps
  102541:	e9 c8 01 00 00       	jmp    10270e <__alltraps>

00102546 <vector218>:
.globl vector218
vector218:
  pushl $0
  102546:	6a 00                	push   $0x0
  pushl $218
  102548:	68 da 00 00 00       	push   $0xda
  jmp __alltraps
  10254d:	e9 bc 01 00 00       	jmp    10270e <__alltraps>

00102552 <vector219>:
.globl vector219
vector219:
  pushl $0
  102552:	6a 00                	push   $0x0
  pushl $219
  102554:	68 db 00 00 00       	push   $0xdb
  jmp __alltraps
  102559:	e9 b0 01 00 00       	jmp    10270e <__alltraps>

0010255e <vector220>:
.globl vector220
vector220:
  pushl $0
  10255e:	6a 00                	push   $0x0
  pushl $220
  102560:	68 dc 00 00 00       	push   $0xdc
  jmp __alltraps
  102565:	e9 a4 01 00 00       	jmp    10270e <__alltraps>

0010256a <vector221>:
.globl vector221
vector221:
  pushl $0
  10256a:	6a 00                	push   $0x0
  pushl $221
  10256c:	68 dd 00 00 00       	push   $0xdd
  jmp __alltraps
  102571:	e9 98 01 00 00       	jmp    10270e <__alltraps>

00102576 <vector222>:
.globl vector222
vector222:
  pushl $0
  102576:	6a 00                	push   $0x0
  pushl $222
  102578:	68 de 00 00 00       	push   $0xde
  jmp __alltraps
  10257d:	e9 8c 01 00 00       	jmp    10270e <__alltraps>

00102582 <vector223>:
.globl vector223
vector223:
  pushl $0
  102582:	6a 00                	push   $0x0
  pushl $223
  102584:	68 df 00 00 00       	push   $0xdf
  jmp __alltraps
  102589:	e9 80 01 00 00       	jmp    10270e <__alltraps>

0010258e <vector224>:
.globl vector224
vector224:
  pushl $0
  10258e:	6a 00                	push   $0x0
  pushl $224
  102590:	68 e0 00 00 00       	push   $0xe0
  jmp __alltraps
  102595:	e9 74 01 00 00       	jmp    10270e <__alltraps>

0010259a <vector225>:
.globl vector225
vector225:
  pushl $0
  10259a:	6a 00                	push   $0x0
  pushl $225
  10259c:	68 e1 00 00 00       	push   $0xe1
  jmp __alltraps
  1025a1:	e9 68 01 00 00       	jmp    10270e <__alltraps>

001025a6 <vector226>:
.globl vector226
vector226:
  pushl $0
  1025a6:	6a 00                	push   $0x0
  pushl $226
  1025a8:	68 e2 00 00 00       	push   $0xe2
  jmp __alltraps
  1025ad:	e9 5c 01 00 00       	jmp    10270e <__alltraps>

001025b2 <vector227>:
.globl vector227
vector227:
  pushl $0
  1025b2:	6a 00                	push   $0x0
  pushl $227
  1025b4:	68 e3 00 00 00       	push   $0xe3
  jmp __alltraps
  1025b9:	e9 50 01 00 00       	jmp    10270e <__alltraps>

001025be <vector228>:
.globl vector228
vector228:
  pushl $0
  1025be:	6a 00                	push   $0x0
  pushl $228
  1025c0:	68 e4 00 00 00       	push   $0xe4
  jmp __alltraps
  1025c5:	e9 44 01 00 00       	jmp    10270e <__alltraps>

001025ca <vector229>:
.globl vector229
vector229:
  pushl $0
  1025ca:	6a 00                	push   $0x0
  pushl $229
  1025cc:	68 e5 00 00 00       	push   $0xe5
  jmp __alltraps
  1025d1:	e9 38 01 00 00       	jmp    10270e <__alltraps>

001025d6 <vector230>:
.globl vector230
vector230:
  pushl $0
  1025d6:	6a 00                	push   $0x0
  pushl $230
  1025d8:	68 e6 00 00 00       	push   $0xe6
  jmp __alltraps
  1025dd:	e9 2c 01 00 00       	jmp    10270e <__alltraps>

001025e2 <vector231>:
.globl vector231
vector231:
  pushl $0
  1025e2:	6a 00                	push   $0x0
  pushl $231
  1025e4:	68 e7 00 00 00       	push   $0xe7
  jmp __alltraps
  1025e9:	e9 20 01 00 00       	jmp    10270e <__alltraps>

001025ee <vector232>:
.globl vector232
vector232:
  pushl $0
  1025ee:	6a 00                	push   $0x0
  pushl $232
  1025f0:	68 e8 00 00 00       	push   $0xe8
  jmp __alltraps
  1025f5:	e9 14 01 00 00       	jmp    10270e <__alltraps>

001025fa <vector233>:
.globl vector233
vector233:
  pushl $0
  1025fa:	6a 00                	push   $0x0
  pushl $233
  1025fc:	68 e9 00 00 00       	push   $0xe9
  jmp __alltraps
  102601:	e9 08 01 00 00       	jmp    10270e <__alltraps>

00102606 <vector234>:
.globl vector234
vector234:
  pushl $0
  102606:	6a 00                	push   $0x0
  pushl $234
  102608:	68 ea 00 00 00       	push   $0xea
  jmp __alltraps
  10260d:	e9 fc 00 00 00       	jmp    10270e <__alltraps>

00102612 <vector235>:
.globl vector235
vector235:
  pushl $0
  102612:	6a 00                	push   $0x0
  pushl $235
  102614:	68 eb 00 00 00       	push   $0xeb
  jmp __alltraps
  102619:	e9 f0 00 00 00       	jmp    10270e <__alltraps>

0010261e <vector236>:
.globl vector236
vector236:
  pushl $0
  10261e:	6a 00                	push   $0x0
  pushl $236
  102620:	68 ec 00 00 00       	push   $0xec
  jmp __alltraps
  102625:	e9 e4 00 00 00       	jmp    10270e <__alltraps>

0010262a <vector237>:
.globl vector237
vector237:
  pushl $0
  10262a:	6a 00                	push   $0x0
  pushl $237
  10262c:	68 ed 00 00 00       	push   $0xed
  jmp __alltraps
  102631:	e9 d8 00 00 00       	jmp    10270e <__alltraps>

00102636 <vector238>:
.globl vector238
vector238:
  pushl $0
  102636:	6a 00                	push   $0x0
  pushl $238
  102638:	68 ee 00 00 00       	push   $0xee
  jmp __alltraps
  10263d:	e9 cc 00 00 00       	jmp    10270e <__alltraps>

00102642 <vector239>:
.globl vector239
vector239:
  pushl $0
  102642:	6a 00                	push   $0x0
  pushl $239
  102644:	68 ef 00 00 00       	push   $0xef
  jmp __alltraps
  102649:	e9 c0 00 00 00       	jmp    10270e <__alltraps>

0010264e <vector240>:
.globl vector240
vector240:
  pushl $0
  10264e:	6a 00                	push   $0x0
  pushl $240
  102650:	68 f0 00 00 00       	push   $0xf0
  jmp __alltraps
  102655:	e9 b4 00 00 00       	jmp    10270e <__alltraps>

0010265a <vector241>:
.globl vector241
vector241:
  pushl $0
  10265a:	6a 00                	push   $0x0
  pushl $241
  10265c:	68 f1 00 00 00       	push   $0xf1
  jmp __alltraps
  102661:	e9 a8 00 00 00       	jmp    10270e <__alltraps>

00102666 <vector242>:
.globl vector242
vector242:
  pushl $0
  102666:	6a 00                	push   $0x0
  pushl $242
  102668:	68 f2 00 00 00       	push   $0xf2
  jmp __alltraps
  10266d:	e9 9c 00 00 00       	jmp    10270e <__alltraps>

00102672 <vector243>:
.globl vector243
vector243:
  pushl $0
  102672:	6a 00                	push   $0x0
  pushl $243
  102674:	68 f3 00 00 00       	push   $0xf3
  jmp __alltraps
  102679:	e9 90 00 00 00       	jmp    10270e <__alltraps>

0010267e <vector244>:
.globl vector244
vector244:
  pushl $0
  10267e:	6a 00                	push   $0x0
  pushl $244
  102680:	68 f4 00 00 00       	push   $0xf4
  jmp __alltraps
  102685:	e9 84 00 00 00       	jmp    10270e <__alltraps>

0010268a <vector245>:
.globl vector245
vector245:
  pushl $0
  10268a:	6a 00                	push   $0x0
  pushl $245
  10268c:	68 f5 00 00 00       	push   $0xf5
  jmp __alltraps
  102691:	e9 78 00 00 00       	jmp    10270e <__alltraps>

00102696 <vector246>:
.globl vector246
vector246:
  pushl $0
  102696:	6a 00                	push   $0x0
  pushl $246
  102698:	68 f6 00 00 00       	push   $0xf6
  jmp __alltraps
  10269d:	e9 6c 00 00 00       	jmp    10270e <__alltraps>

001026a2 <vector247>:
.globl vector247
vector247:
  pushl $0
  1026a2:	6a 00                	push   $0x0
  pushl $247
  1026a4:	68 f7 00 00 00       	push   $0xf7
  jmp __alltraps
  1026a9:	e9 60 00 00 00       	jmp    10270e <__alltraps>

001026ae <vector248>:
.globl vector248
vector248:
  pushl $0
  1026ae:	6a 00                	push   $0x0
  pushl $248
  1026b0:	68 f8 00 00 00       	push   $0xf8
  jmp __alltraps
  1026b5:	e9 54 00 00 00       	jmp    10270e <__alltraps>

001026ba <vector249>:
.globl vector249
vector249:
  pushl $0
  1026ba:	6a 00                	push   $0x0
  pushl $249
  1026bc:	68 f9 00 00 00       	push   $0xf9
  jmp __alltraps
  1026c1:	e9 48 00 00 00       	jmp    10270e <__alltraps>

001026c6 <vector250>:
.globl vector250
vector250:
  pushl $0
  1026c6:	6a 00                	push   $0x0
  pushl $250
  1026c8:	68 fa 00 00 00       	push   $0xfa
  jmp __alltraps
  1026cd:	e9 3c 00 00 00       	jmp    10270e <__alltraps>

001026d2 <vector251>:
.globl vector251
vector251:
  pushl $0
  1026d2:	6a 00                	push   $0x0
  pushl $251
  1026d4:	68 fb 00 00 00       	push   $0xfb
  jmp __alltraps
  1026d9:	e9 30 00 00 00       	jmp    10270e <__alltraps>

001026de <vector252>:
.globl vector252
vector252:
  pushl $0
  1026de:	6a 00                	push   $0x0
  pushl $252
  1026e0:	68 fc 00 00 00       	push   $0xfc
  jmp __alltraps
  1026e5:	e9 24 00 00 00       	jmp    10270e <__alltraps>

001026ea <vector253>:
.globl vector253
vector253:
  pushl $0
  1026ea:	6a 00                	push   $0x0
  pushl $253
  1026ec:	68 fd 00 00 00       	push   $0xfd
  jmp __alltraps
  1026f1:	e9 18 00 00 00       	jmp    10270e <__alltraps>

001026f6 <vector254>:
.globl vector254
vector254:
  pushl $0
  1026f6:	6a 00                	push   $0x0
  pushl $254
  1026f8:	68 fe 00 00 00       	push   $0xfe
  jmp __alltraps
  1026fd:	e9 0c 00 00 00       	jmp    10270e <__alltraps>

00102702 <vector255>:
.globl vector255
vector255:
  pushl $0
  102702:	6a 00                	push   $0x0
  pushl $255
  102704:	68 ff 00 00 00       	push   $0xff
  jmp __alltraps
  102709:	e9 00 00 00 00       	jmp    10270e <__alltraps>

0010270e <__alltraps>:
.text
.globl __alltraps
__alltraps:
    # push registers to build a trap frame
    # therefore make the stack look like a struct trapframe
    pushl %ds
  10270e:	1e                   	push   %ds
    pushl %es
  10270f:	06                   	push   %es
    pushl %fs
  102710:	0f a0                	push   %fs
    pushl %gs
  102712:	0f a8                	push   %gs
    pushal
  102714:	60                   	pusha  

    # load GD_KDATA into %ds and %es to set up data segments for kernel
    movl $GD_KDATA, %eax
  102715:	b8 10 00 00 00       	mov    $0x10,%eax
    movw %ax, %ds
  10271a:	8e d8                	mov    %eax,%ds
    movw %ax, %es
  10271c:	8e c0                	mov    %eax,%es

    # push %esp to pass a pointer to the trapframe as an argument to trap()
    pushl %esp
  10271e:	54                   	push   %esp

    # call trap(tf), where tf=%esp
    call trap
  10271f:	e8 64 f5 ff ff       	call   101c88 <trap>

    # pop the pushed stack pointer
    popl %esp
  102724:	5c                   	pop    %esp

00102725 <__trapret>:

    # return falls through to trapret...
.globl __trapret
__trapret:
    # restore registers from stack
    popal
  102725:	61                   	popa   

    # restore %ds, %es, %fs and %gs
    popl %gs
  102726:	0f a9                	pop    %gs
    popl %fs
  102728:	0f a1                	pop    %fs
    popl %es
  10272a:	07                   	pop    %es
    popl %ds
  10272b:	1f                   	pop    %ds

    # get rid of the trap number and error code
    addl $0x8, %esp
  10272c:	83 c4 08             	add    $0x8,%esp
    iret
  10272f:	cf                   	iret   

00102730 <lgdt>:
/* *
 * lgdt - load the global descriptor table register and reset the
 * data/code segement registers for kernel.
 * */
static inline void
lgdt(struct pseudodesc *pd) {
  102730:	55                   	push   %ebp
  102731:	89 e5                	mov    %esp,%ebp
    asm volatile ("lgdt (%0)" :: "r" (pd));
  102733:	8b 45 08             	mov    0x8(%ebp),%eax
  102736:	0f 01 10             	lgdtl  (%eax)
    asm volatile ("movw %%ax, %%gs" :: "a" (USER_DS));
  102739:	b8 23 00 00 00       	mov    $0x23,%eax
  10273e:	8e e8                	mov    %eax,%gs
    asm volatile ("movw %%ax, %%fs" :: "a" (USER_DS));
  102740:	b8 23 00 00 00       	mov    $0x23,%eax
  102745:	8e e0                	mov    %eax,%fs
    asm volatile ("movw %%ax, %%es" :: "a" (KERNEL_DS));
  102747:	b8 10 00 00 00       	mov    $0x10,%eax
  10274c:	8e c0                	mov    %eax,%es
    asm volatile ("movw %%ax, %%ds" :: "a" (KERNEL_DS));
  10274e:	b8 10 00 00 00       	mov    $0x10,%eax
  102753:	8e d8                	mov    %eax,%ds
    asm volatile ("movw %%ax, %%ss" :: "a" (KERNEL_DS));
  102755:	b8 10 00 00 00       	mov    $0x10,%eax
  10275a:	8e d0                	mov    %eax,%ss
    // reload cs
    asm volatile ("ljmp %0, $1f\n 1:\n" :: "i" (KERNEL_CS));
  10275c:	ea 63 27 10 00 08 00 	ljmp   $0x8,$0x102763
}
  102763:	90                   	nop
  102764:	5d                   	pop    %ebp
  102765:	c3                   	ret    

00102766 <gdt_init>:
/* temporary kernel stack */
uint8_t stack0[1024];

/* gdt_init - initialize the default GDT and TSS */
static void
gdt_init(void) {
  102766:	55                   	push   %ebp
  102767:	89 e5                	mov    %esp,%ebp
  102769:	83 ec 14             	sub    $0x14,%esp
    // Setup a TSS so that we can get the right stack when we trap from
    // user to the kernel. But not safe here, it's only a temporary value,
    // it will be set to KSTACKTOP in lab2.
    ts.ts_esp0 = (uint32_t)&stack0 + sizeof(stack0);
  10276c:	b8 20 f9 10 00       	mov    $0x10f920,%eax
  102771:	05 00 04 00 00       	add    $0x400,%eax
  102776:	a3 a4 f8 10 00       	mov    %eax,0x10f8a4
    ts.ts_ss0 = KERNEL_DS;
  10277b:	66 c7 05 a8 f8 10 00 	movw   $0x10,0x10f8a8
  102782:	10 00 

    // initialize the TSS filed of the gdt
    gdt[SEG_TSS] = SEG16(STS_T32A, (uint32_t)&ts, sizeof(ts), DPL_KERNEL);
  102784:	66 c7 05 08 ea 10 00 	movw   $0x68,0x10ea08
  10278b:	68 00 
  10278d:	b8 a0 f8 10 00       	mov    $0x10f8a0,%eax
  102792:	0f b7 c0             	movzwl %ax,%eax
  102795:	66 a3 0a ea 10 00    	mov    %ax,0x10ea0a
  10279b:	b8 a0 f8 10 00       	mov    $0x10f8a0,%eax
  1027a0:	c1 e8 10             	shr    $0x10,%eax
  1027a3:	a2 0c ea 10 00       	mov    %al,0x10ea0c
  1027a8:	0f b6 05 0d ea 10 00 	movzbl 0x10ea0d,%eax
  1027af:	24 f0                	and    $0xf0,%al
  1027b1:	0c 09                	or     $0x9,%al
  1027b3:	a2 0d ea 10 00       	mov    %al,0x10ea0d
  1027b8:	0f b6 05 0d ea 10 00 	movzbl 0x10ea0d,%eax
  1027bf:	0c 10                	or     $0x10,%al
  1027c1:	a2 0d ea 10 00       	mov    %al,0x10ea0d
  1027c6:	0f b6 05 0d ea 10 00 	movzbl 0x10ea0d,%eax
  1027cd:	24 9f                	and    $0x9f,%al
  1027cf:	a2 0d ea 10 00       	mov    %al,0x10ea0d
  1027d4:	0f b6 05 0d ea 10 00 	movzbl 0x10ea0d,%eax
  1027db:	0c 80                	or     $0x80,%al
  1027dd:	a2 0d ea 10 00       	mov    %al,0x10ea0d
  1027e2:	0f b6 05 0e ea 10 00 	movzbl 0x10ea0e,%eax
  1027e9:	24 f0                	and    $0xf0,%al
  1027eb:	a2 0e ea 10 00       	mov    %al,0x10ea0e
  1027f0:	0f b6 05 0e ea 10 00 	movzbl 0x10ea0e,%eax
  1027f7:	24 ef                	and    $0xef,%al
  1027f9:	a2 0e ea 10 00       	mov    %al,0x10ea0e
  1027fe:	0f b6 05 0e ea 10 00 	movzbl 0x10ea0e,%eax
  102805:	24 df                	and    $0xdf,%al
  102807:	a2 0e ea 10 00       	mov    %al,0x10ea0e
  10280c:	0f b6 05 0e ea 10 00 	movzbl 0x10ea0e,%eax
  102813:	0c 40                	or     $0x40,%al
  102815:	a2 0e ea 10 00       	mov    %al,0x10ea0e
  10281a:	0f b6 05 0e ea 10 00 	movzbl 0x10ea0e,%eax
  102821:	24 7f                	and    $0x7f,%al
  102823:	a2 0e ea 10 00       	mov    %al,0x10ea0e
  102828:	b8 a0 f8 10 00       	mov    $0x10f8a0,%eax
  10282d:	c1 e8 18             	shr    $0x18,%eax
  102830:	a2 0f ea 10 00       	mov    %al,0x10ea0f
    gdt[SEG_TSS].sd_s = 0;
  102835:	0f b6 05 0d ea 10 00 	movzbl 0x10ea0d,%eax
  10283c:	24 ef                	and    $0xef,%al
  10283e:	a2 0d ea 10 00       	mov    %al,0x10ea0d

    // reload all segment registers
    lgdt(&gdt_pd);
  102843:	c7 04 24 10 ea 10 00 	movl   $0x10ea10,(%esp)
  10284a:	e8 e1 fe ff ff       	call   102730 <lgdt>
  10284f:	66 c7 45 fe 28 00    	movw   $0x28,-0x2(%ebp)
}

static inline void
ltr(uint16_t sel) {
    asm volatile ("ltr %0" :: "r" (sel));
  102855:	0f b7 45 fe          	movzwl -0x2(%ebp),%eax
  102859:	0f 00 d8             	ltr    %ax

    // load the TSS
    ltr(GD_TSS);
}
  10285c:	90                   	nop
  10285d:	c9                   	leave  
  10285e:	c3                   	ret    

0010285f <pmm_init>:

/* pmm_init - initialize the physical memory management */
void
pmm_init(void) {
  10285f:	55                   	push   %ebp
  102860:	89 e5                	mov    %esp,%ebp
    gdt_init();
  102862:	e8 ff fe ff ff       	call   102766 <gdt_init>
}
  102867:	90                   	nop
  102868:	5d                   	pop    %ebp
  102869:	c3                   	ret    

0010286a <strlen>:
 * @s:        the input string
 *
 * The strlen() function returns the length of string @s.
 * */
size_t
strlen(const char *s) {
  10286a:	55                   	push   %ebp
  10286b:	89 e5                	mov    %esp,%ebp
  10286d:	83 ec 10             	sub    $0x10,%esp
    size_t cnt = 0;
  102870:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
    while (*s ++ != '\0') {
  102877:	eb 03                	jmp    10287c <strlen+0x12>
        cnt ++;
  102879:	ff 45 fc             	incl   -0x4(%ebp)
    while (*s ++ != '\0') {
  10287c:	8b 45 08             	mov    0x8(%ebp),%eax
  10287f:	8d 50 01             	lea    0x1(%eax),%edx
  102882:	89 55 08             	mov    %edx,0x8(%ebp)
  102885:	0f b6 00             	movzbl (%eax),%eax
  102888:	84 c0                	test   %al,%al
  10288a:	75 ed                	jne    102879 <strlen+0xf>
    }
    return cnt;
  10288c:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
  10288f:	c9                   	leave  
  102890:	c3                   	ret    

00102891 <strnlen>:
 * The return value is strlen(s), if that is less than @len, or
 * @len if there is no '\0' character among the first @len characters
 * pointed by @s.
 * */
size_t
strnlen(const char *s, size_t len) {
  102891:	55                   	push   %ebp
  102892:	89 e5                	mov    %esp,%ebp
  102894:	83 ec 10             	sub    $0x10,%esp
    size_t cnt = 0;
  102897:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
    while (cnt < len && *s ++ != '\0') {
  10289e:	eb 03                	jmp    1028a3 <strnlen+0x12>
        cnt ++;
  1028a0:	ff 45 fc             	incl   -0x4(%ebp)
    while (cnt < len && *s ++ != '\0') {
  1028a3:	8b 45 fc             	mov    -0x4(%ebp),%eax
  1028a6:	3b 45 0c             	cmp    0xc(%ebp),%eax
  1028a9:	73 10                	jae    1028bb <strnlen+0x2a>
  1028ab:	8b 45 08             	mov    0x8(%ebp),%eax
  1028ae:	8d 50 01             	lea    0x1(%eax),%edx
  1028b1:	89 55 08             	mov    %edx,0x8(%ebp)
  1028b4:	0f b6 00             	movzbl (%eax),%eax
  1028b7:	84 c0                	test   %al,%al
  1028b9:	75 e5                	jne    1028a0 <strnlen+0xf>
    }
    return cnt;
  1028bb:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
  1028be:	c9                   	leave  
  1028bf:	c3                   	ret    

001028c0 <strcpy>:
 * To avoid overflows, the size of array pointed by @dst should be long enough to
 * contain the same string as @src (including the terminating null character), and
 * should not overlap in memory with @src.
 * */
char *
strcpy(char *dst, const char *src) {
  1028c0:	55                   	push   %ebp
  1028c1:	89 e5                	mov    %esp,%ebp
  1028c3:	57                   	push   %edi
  1028c4:	56                   	push   %esi
  1028c5:	83 ec 20             	sub    $0x20,%esp
  1028c8:	8b 45 08             	mov    0x8(%ebp),%eax
  1028cb:	89 45 f4             	mov    %eax,-0xc(%ebp)
  1028ce:	8b 45 0c             	mov    0xc(%ebp),%eax
  1028d1:	89 45 f0             	mov    %eax,-0x10(%ebp)
#ifndef __HAVE_ARCH_STRCPY
#define __HAVE_ARCH_STRCPY
static inline char *
__strcpy(char *dst, const char *src) {
    int d0, d1, d2;
    asm volatile (
  1028d4:	8b 55 f0             	mov    -0x10(%ebp),%edx
  1028d7:	8b 45 f4             	mov    -0xc(%ebp),%eax
  1028da:	89 d1                	mov    %edx,%ecx
  1028dc:	89 c2                	mov    %eax,%edx
  1028de:	89 ce                	mov    %ecx,%esi
  1028e0:	89 d7                	mov    %edx,%edi
  1028e2:	ac                   	lods   %ds:(%esi),%al
  1028e3:	aa                   	stos   %al,%es:(%edi)
  1028e4:	84 c0                	test   %al,%al
  1028e6:	75 fa                	jne    1028e2 <strcpy+0x22>
  1028e8:	89 fa                	mov    %edi,%edx
  1028ea:	89 f1                	mov    %esi,%ecx
  1028ec:	89 4d ec             	mov    %ecx,-0x14(%ebp)
  1028ef:	89 55 e8             	mov    %edx,-0x18(%ebp)
  1028f2:	89 45 e4             	mov    %eax,-0x1c(%ebp)
            "stosb;"
            "testb %%al, %%al;"
            "jne 1b;"
            : "=&S" (d0), "=&D" (d1), "=&a" (d2)
            : "0" (src), "1" (dst) : "memory");
    return dst;
  1028f5:	8b 45 f4             	mov    -0xc(%ebp),%eax
#ifdef __HAVE_ARCH_STRCPY
    return __strcpy(dst, src);
  1028f8:	90                   	nop
    char *p = dst;
    while ((*p ++ = *src ++) != '\0')
        /* nothing */;
    return dst;
#endif /* __HAVE_ARCH_STRCPY */
}
  1028f9:	83 c4 20             	add    $0x20,%esp
  1028fc:	5e                   	pop    %esi
  1028fd:	5f                   	pop    %edi
  1028fe:	5d                   	pop    %ebp
  1028ff:	c3                   	ret    

00102900 <strncpy>:
 * @len:    maximum number of characters to be copied from @src
 *
 * The return value is @dst
 * */
char *
strncpy(char *dst, const char *src, size_t len) {
  102900:	55                   	push   %ebp
  102901:	89 e5                	mov    %esp,%ebp
  102903:	83 ec 10             	sub    $0x10,%esp
    char *p = dst;
  102906:	8b 45 08             	mov    0x8(%ebp),%eax
  102909:	89 45 fc             	mov    %eax,-0x4(%ebp)
    while (len > 0) {
  10290c:	eb 1e                	jmp    10292c <strncpy+0x2c>
        if ((*p = *src) != '\0') {
  10290e:	8b 45 0c             	mov    0xc(%ebp),%eax
  102911:	0f b6 10             	movzbl (%eax),%edx
  102914:	8b 45 fc             	mov    -0x4(%ebp),%eax
  102917:	88 10                	mov    %dl,(%eax)
  102919:	8b 45 fc             	mov    -0x4(%ebp),%eax
  10291c:	0f b6 00             	movzbl (%eax),%eax
  10291f:	84 c0                	test   %al,%al
  102921:	74 03                	je     102926 <strncpy+0x26>
            src ++;
  102923:	ff 45 0c             	incl   0xc(%ebp)
        }
        p ++, len --;
  102926:	ff 45 fc             	incl   -0x4(%ebp)
  102929:	ff 4d 10             	decl   0x10(%ebp)
    while (len > 0) {
  10292c:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  102930:	75 dc                	jne    10290e <strncpy+0xe>
    }
    return dst;
  102932:	8b 45 08             	mov    0x8(%ebp),%eax
}
  102935:	c9                   	leave  
  102936:	c3                   	ret    

00102937 <strcmp>:
 * - A value greater than zero indicates that the first character that does
 *   not match has a greater value in @s1 than in @s2;
 * - And a value less than zero indicates the opposite.
 * */
int
strcmp(const char *s1, const char *s2) {
  102937:	55                   	push   %ebp
  102938:	89 e5                	mov    %esp,%ebp
  10293a:	57                   	push   %edi
  10293b:	56                   	push   %esi
  10293c:	83 ec 20             	sub    $0x20,%esp
  10293f:	8b 45 08             	mov    0x8(%ebp),%eax
  102942:	89 45 f4             	mov    %eax,-0xc(%ebp)
  102945:	8b 45 0c             	mov    0xc(%ebp),%eax
  102948:	89 45 f0             	mov    %eax,-0x10(%ebp)
    asm volatile (
  10294b:	8b 55 f4             	mov    -0xc(%ebp),%edx
  10294e:	8b 45 f0             	mov    -0x10(%ebp),%eax
  102951:	89 d1                	mov    %edx,%ecx
  102953:	89 c2                	mov    %eax,%edx
  102955:	89 ce                	mov    %ecx,%esi
  102957:	89 d7                	mov    %edx,%edi
  102959:	ac                   	lods   %ds:(%esi),%al
  10295a:	ae                   	scas   %es:(%edi),%al
  10295b:	75 08                	jne    102965 <strcmp+0x2e>
  10295d:	84 c0                	test   %al,%al
  10295f:	75 f8                	jne    102959 <strcmp+0x22>
  102961:	31 c0                	xor    %eax,%eax
  102963:	eb 04                	jmp    102969 <strcmp+0x32>
  102965:	19 c0                	sbb    %eax,%eax
  102967:	0c 01                	or     $0x1,%al
  102969:	89 fa                	mov    %edi,%edx
  10296b:	89 f1                	mov    %esi,%ecx
  10296d:	89 45 ec             	mov    %eax,-0x14(%ebp)
  102970:	89 4d e8             	mov    %ecx,-0x18(%ebp)
  102973:	89 55 e4             	mov    %edx,-0x1c(%ebp)
    return ret;
  102976:	8b 45 ec             	mov    -0x14(%ebp),%eax
#ifdef __HAVE_ARCH_STRCMP
    return __strcmp(s1, s2);
  102979:	90                   	nop
    while (*s1 != '\0' && *s1 == *s2) {
        s1 ++, s2 ++;
    }
    return (int)((unsigned char)*s1 - (unsigned char)*s2);
#endif /* __HAVE_ARCH_STRCMP */
}
  10297a:	83 c4 20             	add    $0x20,%esp
  10297d:	5e                   	pop    %esi
  10297e:	5f                   	pop    %edi
  10297f:	5d                   	pop    %ebp
  102980:	c3                   	ret    

00102981 <strncmp>:
 * they are equal to each other, it continues with the following pairs until
 * the characters differ, until a terminating null-character is reached, or
 * until @n characters match in both strings, whichever happens first.
 * */
int
strncmp(const char *s1, const char *s2, size_t n) {
  102981:	55                   	push   %ebp
  102982:	89 e5                	mov    %esp,%ebp
    while (n > 0 && *s1 != '\0' && *s1 == *s2) {
  102984:	eb 09                	jmp    10298f <strncmp+0xe>
        n --, s1 ++, s2 ++;
  102986:	ff 4d 10             	decl   0x10(%ebp)
  102989:	ff 45 08             	incl   0x8(%ebp)
  10298c:	ff 45 0c             	incl   0xc(%ebp)
    while (n > 0 && *s1 != '\0' && *s1 == *s2) {
  10298f:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  102993:	74 1a                	je     1029af <strncmp+0x2e>
  102995:	8b 45 08             	mov    0x8(%ebp),%eax
  102998:	0f b6 00             	movzbl (%eax),%eax
  10299b:	84 c0                	test   %al,%al
  10299d:	74 10                	je     1029af <strncmp+0x2e>
  10299f:	8b 45 08             	mov    0x8(%ebp),%eax
  1029a2:	0f b6 10             	movzbl (%eax),%edx
  1029a5:	8b 45 0c             	mov    0xc(%ebp),%eax
  1029a8:	0f b6 00             	movzbl (%eax),%eax
  1029ab:	38 c2                	cmp    %al,%dl
  1029ad:	74 d7                	je     102986 <strncmp+0x5>
    }
    return (n == 0) ? 0 : (int)((unsigned char)*s1 - (unsigned char)*s2);
  1029af:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  1029b3:	74 18                	je     1029cd <strncmp+0x4c>
  1029b5:	8b 45 08             	mov    0x8(%ebp),%eax
  1029b8:	0f b6 00             	movzbl (%eax),%eax
  1029bb:	0f b6 d0             	movzbl %al,%edx
  1029be:	8b 45 0c             	mov    0xc(%ebp),%eax
  1029c1:	0f b6 00             	movzbl (%eax),%eax
  1029c4:	0f b6 c0             	movzbl %al,%eax
  1029c7:	29 c2                	sub    %eax,%edx
  1029c9:	89 d0                	mov    %edx,%eax
  1029cb:	eb 05                	jmp    1029d2 <strncmp+0x51>
  1029cd:	b8 00 00 00 00       	mov    $0x0,%eax
}
  1029d2:	5d                   	pop    %ebp
  1029d3:	c3                   	ret    

001029d4 <strchr>:
 *
 * The strchr() function returns a pointer to the first occurrence of
 * character in @s. If the value is not found, the function returns 'NULL'.
 * */
char *
strchr(const char *s, char c) {
  1029d4:	55                   	push   %ebp
  1029d5:	89 e5                	mov    %esp,%ebp
  1029d7:	83 ec 04             	sub    $0x4,%esp
  1029da:	8b 45 0c             	mov    0xc(%ebp),%eax
  1029dd:	88 45 fc             	mov    %al,-0x4(%ebp)
    while (*s != '\0') {
  1029e0:	eb 13                	jmp    1029f5 <strchr+0x21>
        if (*s == c) {
  1029e2:	8b 45 08             	mov    0x8(%ebp),%eax
  1029e5:	0f b6 00             	movzbl (%eax),%eax
  1029e8:	38 45 fc             	cmp    %al,-0x4(%ebp)
  1029eb:	75 05                	jne    1029f2 <strchr+0x1e>
            return (char *)s;
  1029ed:	8b 45 08             	mov    0x8(%ebp),%eax
  1029f0:	eb 12                	jmp    102a04 <strchr+0x30>
        }
        s ++;
  1029f2:	ff 45 08             	incl   0x8(%ebp)
    while (*s != '\0') {
  1029f5:	8b 45 08             	mov    0x8(%ebp),%eax
  1029f8:	0f b6 00             	movzbl (%eax),%eax
  1029fb:	84 c0                	test   %al,%al
  1029fd:	75 e3                	jne    1029e2 <strchr+0xe>
    }
    return NULL;
  1029ff:	b8 00 00 00 00       	mov    $0x0,%eax
}
  102a04:	c9                   	leave  
  102a05:	c3                   	ret    

00102a06 <strfind>:
 * The strfind() function is like strchr() except that if @c is
 * not found in @s, then it returns a pointer to the null byte at the
 * end of @s, rather than 'NULL'.
 * */
char *
strfind(const char *s, char c) {
  102a06:	55                   	push   %ebp
  102a07:	89 e5                	mov    %esp,%ebp
  102a09:	83 ec 04             	sub    $0x4,%esp
  102a0c:	8b 45 0c             	mov    0xc(%ebp),%eax
  102a0f:	88 45 fc             	mov    %al,-0x4(%ebp)
    while (*s != '\0') {
  102a12:	eb 0e                	jmp    102a22 <strfind+0x1c>
        if (*s == c) {
  102a14:	8b 45 08             	mov    0x8(%ebp),%eax
  102a17:	0f b6 00             	movzbl (%eax),%eax
  102a1a:	38 45 fc             	cmp    %al,-0x4(%ebp)
  102a1d:	74 0f                	je     102a2e <strfind+0x28>
            break;
        }
        s ++;
  102a1f:	ff 45 08             	incl   0x8(%ebp)
    while (*s != '\0') {
  102a22:	8b 45 08             	mov    0x8(%ebp),%eax
  102a25:	0f b6 00             	movzbl (%eax),%eax
  102a28:	84 c0                	test   %al,%al
  102a2a:	75 e8                	jne    102a14 <strfind+0xe>
  102a2c:	eb 01                	jmp    102a2f <strfind+0x29>
            break;
  102a2e:	90                   	nop
    }
    return (char *)s;
  102a2f:	8b 45 08             	mov    0x8(%ebp),%eax
}
  102a32:	c9                   	leave  
  102a33:	c3                   	ret    

00102a34 <strtol>:
 * an optional "0x" or "0X" prefix.
 *
 * The strtol() function returns the converted integral number as a long int value.
 * */
long
strtol(const char *s, char **endptr, int base) {
  102a34:	55                   	push   %ebp
  102a35:	89 e5                	mov    %esp,%ebp
  102a37:	83 ec 10             	sub    $0x10,%esp
    int neg = 0;
  102a3a:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
    long val = 0;
  102a41:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%ebp)

    // gobble initial whitespace
    while (*s == ' ' || *s == '\t') {
  102a48:	eb 03                	jmp    102a4d <strtol+0x19>
        s ++;
  102a4a:	ff 45 08             	incl   0x8(%ebp)
    while (*s == ' ' || *s == '\t') {
  102a4d:	8b 45 08             	mov    0x8(%ebp),%eax
  102a50:	0f b6 00             	movzbl (%eax),%eax
  102a53:	3c 20                	cmp    $0x20,%al
  102a55:	74 f3                	je     102a4a <strtol+0x16>
  102a57:	8b 45 08             	mov    0x8(%ebp),%eax
  102a5a:	0f b6 00             	movzbl (%eax),%eax
  102a5d:	3c 09                	cmp    $0x9,%al
  102a5f:	74 e9                	je     102a4a <strtol+0x16>
    }

    // plus/minus sign
    if (*s == '+') {
  102a61:	8b 45 08             	mov    0x8(%ebp),%eax
  102a64:	0f b6 00             	movzbl (%eax),%eax
  102a67:	3c 2b                	cmp    $0x2b,%al
  102a69:	75 05                	jne    102a70 <strtol+0x3c>
        s ++;
  102a6b:	ff 45 08             	incl   0x8(%ebp)
  102a6e:	eb 14                	jmp    102a84 <strtol+0x50>
    }
    else if (*s == '-') {
  102a70:	8b 45 08             	mov    0x8(%ebp),%eax
  102a73:	0f b6 00             	movzbl (%eax),%eax
  102a76:	3c 2d                	cmp    $0x2d,%al
  102a78:	75 0a                	jne    102a84 <strtol+0x50>
        s ++, neg = 1;
  102a7a:	ff 45 08             	incl   0x8(%ebp)
  102a7d:	c7 45 fc 01 00 00 00 	movl   $0x1,-0x4(%ebp)
    }

    // hex or octal base prefix
    if ((base == 0 || base == 16) && (s[0] == '0' && s[1] == 'x')) {
  102a84:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  102a88:	74 06                	je     102a90 <strtol+0x5c>
  102a8a:	83 7d 10 10          	cmpl   $0x10,0x10(%ebp)
  102a8e:	75 22                	jne    102ab2 <strtol+0x7e>
  102a90:	8b 45 08             	mov    0x8(%ebp),%eax
  102a93:	0f b6 00             	movzbl (%eax),%eax
  102a96:	3c 30                	cmp    $0x30,%al
  102a98:	75 18                	jne    102ab2 <strtol+0x7e>
  102a9a:	8b 45 08             	mov    0x8(%ebp),%eax
  102a9d:	40                   	inc    %eax
  102a9e:	0f b6 00             	movzbl (%eax),%eax
  102aa1:	3c 78                	cmp    $0x78,%al
  102aa3:	75 0d                	jne    102ab2 <strtol+0x7e>
        s += 2, base = 16;
  102aa5:	83 45 08 02          	addl   $0x2,0x8(%ebp)
  102aa9:	c7 45 10 10 00 00 00 	movl   $0x10,0x10(%ebp)
  102ab0:	eb 29                	jmp    102adb <strtol+0xa7>
    }
    else if (base == 0 && s[0] == '0') {
  102ab2:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  102ab6:	75 16                	jne    102ace <strtol+0x9a>
  102ab8:	8b 45 08             	mov    0x8(%ebp),%eax
  102abb:	0f b6 00             	movzbl (%eax),%eax
  102abe:	3c 30                	cmp    $0x30,%al
  102ac0:	75 0c                	jne    102ace <strtol+0x9a>
        s ++, base = 8;
  102ac2:	ff 45 08             	incl   0x8(%ebp)
  102ac5:	c7 45 10 08 00 00 00 	movl   $0x8,0x10(%ebp)
  102acc:	eb 0d                	jmp    102adb <strtol+0xa7>
    }
    else if (base == 0) {
  102ace:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  102ad2:	75 07                	jne    102adb <strtol+0xa7>
        base = 10;
  102ad4:	c7 45 10 0a 00 00 00 	movl   $0xa,0x10(%ebp)

    // digits
    while (1) {
        int dig;

        if (*s >= '0' && *s <= '9') {
  102adb:	8b 45 08             	mov    0x8(%ebp),%eax
  102ade:	0f b6 00             	movzbl (%eax),%eax
  102ae1:	3c 2f                	cmp    $0x2f,%al
  102ae3:	7e 1b                	jle    102b00 <strtol+0xcc>
  102ae5:	8b 45 08             	mov    0x8(%ebp),%eax
  102ae8:	0f b6 00             	movzbl (%eax),%eax
  102aeb:	3c 39                	cmp    $0x39,%al
  102aed:	7f 11                	jg     102b00 <strtol+0xcc>
            dig = *s - '0';
  102aef:	8b 45 08             	mov    0x8(%ebp),%eax
  102af2:	0f b6 00             	movzbl (%eax),%eax
  102af5:	0f be c0             	movsbl %al,%eax
  102af8:	83 e8 30             	sub    $0x30,%eax
  102afb:	89 45 f4             	mov    %eax,-0xc(%ebp)
  102afe:	eb 48                	jmp    102b48 <strtol+0x114>
        }
        else if (*s >= 'a' && *s <= 'z') {
  102b00:	8b 45 08             	mov    0x8(%ebp),%eax
  102b03:	0f b6 00             	movzbl (%eax),%eax
  102b06:	3c 60                	cmp    $0x60,%al
  102b08:	7e 1b                	jle    102b25 <strtol+0xf1>
  102b0a:	8b 45 08             	mov    0x8(%ebp),%eax
  102b0d:	0f b6 00             	movzbl (%eax),%eax
  102b10:	3c 7a                	cmp    $0x7a,%al
  102b12:	7f 11                	jg     102b25 <strtol+0xf1>
            dig = *s - 'a' + 10;
  102b14:	8b 45 08             	mov    0x8(%ebp),%eax
  102b17:	0f b6 00             	movzbl (%eax),%eax
  102b1a:	0f be c0             	movsbl %al,%eax
  102b1d:	83 e8 57             	sub    $0x57,%eax
  102b20:	89 45 f4             	mov    %eax,-0xc(%ebp)
  102b23:	eb 23                	jmp    102b48 <strtol+0x114>
        }
        else if (*s >= 'A' && *s <= 'Z') {
  102b25:	8b 45 08             	mov    0x8(%ebp),%eax
  102b28:	0f b6 00             	movzbl (%eax),%eax
  102b2b:	3c 40                	cmp    $0x40,%al
  102b2d:	7e 3b                	jle    102b6a <strtol+0x136>
  102b2f:	8b 45 08             	mov    0x8(%ebp),%eax
  102b32:	0f b6 00             	movzbl (%eax),%eax
  102b35:	3c 5a                	cmp    $0x5a,%al
  102b37:	7f 31                	jg     102b6a <strtol+0x136>
            dig = *s - 'A' + 10;
  102b39:	8b 45 08             	mov    0x8(%ebp),%eax
  102b3c:	0f b6 00             	movzbl (%eax),%eax
  102b3f:	0f be c0             	movsbl %al,%eax
  102b42:	83 e8 37             	sub    $0x37,%eax
  102b45:	89 45 f4             	mov    %eax,-0xc(%ebp)
        }
        else {
            break;
        }
        if (dig >= base) {
  102b48:	8b 45 f4             	mov    -0xc(%ebp),%eax
  102b4b:	3b 45 10             	cmp    0x10(%ebp),%eax
  102b4e:	7d 19                	jge    102b69 <strtol+0x135>
            break;
        }
        s ++, val = (val * base) + dig;
  102b50:	ff 45 08             	incl   0x8(%ebp)
  102b53:	8b 45 f8             	mov    -0x8(%ebp),%eax
  102b56:	0f af 45 10          	imul   0x10(%ebp),%eax
  102b5a:	89 c2                	mov    %eax,%edx
  102b5c:	8b 45 f4             	mov    -0xc(%ebp),%eax
  102b5f:	01 d0                	add    %edx,%eax
  102b61:	89 45 f8             	mov    %eax,-0x8(%ebp)
    while (1) {
  102b64:	e9 72 ff ff ff       	jmp    102adb <strtol+0xa7>
            break;
  102b69:	90                   	nop
        // we don't properly detect overflow!
    }

    if (endptr) {
  102b6a:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
  102b6e:	74 08                	je     102b78 <strtol+0x144>
        *endptr = (char *) s;
  102b70:	8b 45 0c             	mov    0xc(%ebp),%eax
  102b73:	8b 55 08             	mov    0x8(%ebp),%edx
  102b76:	89 10                	mov    %edx,(%eax)
    }
    return (neg ? -val : val);
  102b78:	83 7d fc 00          	cmpl   $0x0,-0x4(%ebp)
  102b7c:	74 07                	je     102b85 <strtol+0x151>
  102b7e:	8b 45 f8             	mov    -0x8(%ebp),%eax
  102b81:	f7 d8                	neg    %eax
  102b83:	eb 03                	jmp    102b88 <strtol+0x154>
  102b85:	8b 45 f8             	mov    -0x8(%ebp),%eax
}
  102b88:	c9                   	leave  
  102b89:	c3                   	ret    

00102b8a <memset>:
 * @n:        number of bytes to be set to the value
 *
 * The memset() function returns @s.
 * */
void *
memset(void *s, char c, size_t n) {
  102b8a:	55                   	push   %ebp
  102b8b:	89 e5                	mov    %esp,%ebp
  102b8d:	57                   	push   %edi
  102b8e:	83 ec 24             	sub    $0x24,%esp
  102b91:	8b 45 0c             	mov    0xc(%ebp),%eax
  102b94:	88 45 d8             	mov    %al,-0x28(%ebp)
#ifdef __HAVE_ARCH_MEMSET
    return __memset(s, c, n);
  102b97:	0f be 45 d8          	movsbl -0x28(%ebp),%eax
  102b9b:	8b 55 08             	mov    0x8(%ebp),%edx
  102b9e:	89 55 f8             	mov    %edx,-0x8(%ebp)
  102ba1:	88 45 f7             	mov    %al,-0x9(%ebp)
  102ba4:	8b 45 10             	mov    0x10(%ebp),%eax
  102ba7:	89 45 f0             	mov    %eax,-0x10(%ebp)
#ifndef __HAVE_ARCH_MEMSET
#define __HAVE_ARCH_MEMSET
static inline void *
__memset(void *s, char c, size_t n) {
    int d0, d1;
    asm volatile (
  102baa:	8b 4d f0             	mov    -0x10(%ebp),%ecx
  102bad:	0f b6 45 f7          	movzbl -0x9(%ebp),%eax
  102bb1:	8b 55 f8             	mov    -0x8(%ebp),%edx
  102bb4:	89 d7                	mov    %edx,%edi
  102bb6:	f3 aa                	rep stos %al,%es:(%edi)
  102bb8:	89 fa                	mov    %edi,%edx
  102bba:	89 4d ec             	mov    %ecx,-0x14(%ebp)
  102bbd:	89 55 e8             	mov    %edx,-0x18(%ebp)
            "rep; stosb;"
            : "=&c" (d0), "=&D" (d1)
            : "0" (n), "a" (c), "1" (s)
            : "memory");
    return s;
  102bc0:	8b 45 f8             	mov    -0x8(%ebp),%eax
  102bc3:	90                   	nop
    while (n -- > 0) {
        *p ++ = c;
    }
    return s;
#endif /* __HAVE_ARCH_MEMSET */
}
  102bc4:	83 c4 24             	add    $0x24,%esp
  102bc7:	5f                   	pop    %edi
  102bc8:	5d                   	pop    %ebp
  102bc9:	c3                   	ret    

00102bca <memmove>:
 * @n:        number of bytes to copy
 *
 * The memmove() function returns @dst.
 * */
void *
memmove(void *dst, const void *src, size_t n) {
  102bca:	55                   	push   %ebp
  102bcb:	89 e5                	mov    %esp,%ebp
  102bcd:	57                   	push   %edi
  102bce:	56                   	push   %esi
  102bcf:	53                   	push   %ebx
  102bd0:	83 ec 30             	sub    $0x30,%esp
  102bd3:	8b 45 08             	mov    0x8(%ebp),%eax
  102bd6:	89 45 f0             	mov    %eax,-0x10(%ebp)
  102bd9:	8b 45 0c             	mov    0xc(%ebp),%eax
  102bdc:	89 45 ec             	mov    %eax,-0x14(%ebp)
  102bdf:	8b 45 10             	mov    0x10(%ebp),%eax
  102be2:	89 45 e8             	mov    %eax,-0x18(%ebp)

#ifndef __HAVE_ARCH_MEMMOVE
#define __HAVE_ARCH_MEMMOVE
static inline void *
__memmove(void *dst, const void *src, size_t n) {
    if (dst < src) {
  102be5:	8b 45 f0             	mov    -0x10(%ebp),%eax
  102be8:	3b 45 ec             	cmp    -0x14(%ebp),%eax
  102beb:	73 42                	jae    102c2f <memmove+0x65>
  102bed:	8b 45 f0             	mov    -0x10(%ebp),%eax
  102bf0:	89 45 e4             	mov    %eax,-0x1c(%ebp)
  102bf3:	8b 45 ec             	mov    -0x14(%ebp),%eax
  102bf6:	89 45 e0             	mov    %eax,-0x20(%ebp)
  102bf9:	8b 45 e8             	mov    -0x18(%ebp),%eax
  102bfc:	89 45 dc             	mov    %eax,-0x24(%ebp)
            "andl $3, %%ecx;"
            "jz 1f;"
            "rep; movsb;"
            "1:"
            : "=&c" (d0), "=&D" (d1), "=&S" (d2)
            : "0" (n / 4), "g" (n), "1" (dst), "2" (src)
  102bff:	8b 45 dc             	mov    -0x24(%ebp),%eax
  102c02:	c1 e8 02             	shr    $0x2,%eax
  102c05:	89 c1                	mov    %eax,%ecx
    asm volatile (
  102c07:	8b 55 e4             	mov    -0x1c(%ebp),%edx
  102c0a:	8b 45 e0             	mov    -0x20(%ebp),%eax
  102c0d:	89 d7                	mov    %edx,%edi
  102c0f:	89 c6                	mov    %eax,%esi
  102c11:	f3 a5                	rep movsl %ds:(%esi),%es:(%edi)
  102c13:	8b 4d dc             	mov    -0x24(%ebp),%ecx
  102c16:	83 e1 03             	and    $0x3,%ecx
  102c19:	74 02                	je     102c1d <memmove+0x53>
  102c1b:	f3 a4                	rep movsb %ds:(%esi),%es:(%edi)
  102c1d:	89 f0                	mov    %esi,%eax
  102c1f:	89 fa                	mov    %edi,%edx
  102c21:	89 4d d8             	mov    %ecx,-0x28(%ebp)
  102c24:	89 55 d4             	mov    %edx,-0x2c(%ebp)
  102c27:	89 45 d0             	mov    %eax,-0x30(%ebp)
            : "memory");
    return dst;
  102c2a:	8b 45 e4             	mov    -0x1c(%ebp),%eax
#ifdef __HAVE_ARCH_MEMMOVE
    return __memmove(dst, src, n);
  102c2d:	eb 36                	jmp    102c65 <memmove+0x9b>
            : "0" (n), "1" (n - 1 + src), "2" (n - 1 + dst)
  102c2f:	8b 45 e8             	mov    -0x18(%ebp),%eax
  102c32:	8d 50 ff             	lea    -0x1(%eax),%edx
  102c35:	8b 45 ec             	mov    -0x14(%ebp),%eax
  102c38:	01 c2                	add    %eax,%edx
  102c3a:	8b 45 e8             	mov    -0x18(%ebp),%eax
  102c3d:	8d 48 ff             	lea    -0x1(%eax),%ecx
  102c40:	8b 45 f0             	mov    -0x10(%ebp),%eax
  102c43:	8d 1c 01             	lea    (%ecx,%eax,1),%ebx
    asm volatile (
  102c46:	8b 45 e8             	mov    -0x18(%ebp),%eax
  102c49:	89 c1                	mov    %eax,%ecx
  102c4b:	89 d8                	mov    %ebx,%eax
  102c4d:	89 d6                	mov    %edx,%esi
  102c4f:	89 c7                	mov    %eax,%edi
  102c51:	fd                   	std    
  102c52:	f3 a4                	rep movsb %ds:(%esi),%es:(%edi)
  102c54:	fc                   	cld    
  102c55:	89 f8                	mov    %edi,%eax
  102c57:	89 f2                	mov    %esi,%edx
  102c59:	89 4d cc             	mov    %ecx,-0x34(%ebp)
  102c5c:	89 55 c8             	mov    %edx,-0x38(%ebp)
  102c5f:	89 45 c4             	mov    %eax,-0x3c(%ebp)
    return dst;
  102c62:	8b 45 f0             	mov    -0x10(%ebp),%eax
            *d ++ = *s ++;
        }
    }
    return dst;
#endif /* __HAVE_ARCH_MEMMOVE */
}
  102c65:	83 c4 30             	add    $0x30,%esp
  102c68:	5b                   	pop    %ebx
  102c69:	5e                   	pop    %esi
  102c6a:	5f                   	pop    %edi
  102c6b:	5d                   	pop    %ebp
  102c6c:	c3                   	ret    

00102c6d <memcpy>:
 * it always copies exactly @n bytes. To avoid overflows, the size of arrays pointed
 * by both @src and @dst, should be at least @n bytes, and should not overlap
 * (for overlapping memory area, memmove is a safer approach).
 * */
void *
memcpy(void *dst, const void *src, size_t n) {
  102c6d:	55                   	push   %ebp
  102c6e:	89 e5                	mov    %esp,%ebp
  102c70:	57                   	push   %edi
  102c71:	56                   	push   %esi
  102c72:	83 ec 20             	sub    $0x20,%esp
  102c75:	8b 45 08             	mov    0x8(%ebp),%eax
  102c78:	89 45 f4             	mov    %eax,-0xc(%ebp)
  102c7b:	8b 45 0c             	mov    0xc(%ebp),%eax
  102c7e:	89 45 f0             	mov    %eax,-0x10(%ebp)
  102c81:	8b 45 10             	mov    0x10(%ebp),%eax
  102c84:	89 45 ec             	mov    %eax,-0x14(%ebp)
            : "0" (n / 4), "g" (n), "1" (dst), "2" (src)
  102c87:	8b 45 ec             	mov    -0x14(%ebp),%eax
  102c8a:	c1 e8 02             	shr    $0x2,%eax
  102c8d:	89 c1                	mov    %eax,%ecx
    asm volatile (
  102c8f:	8b 55 f4             	mov    -0xc(%ebp),%edx
  102c92:	8b 45 f0             	mov    -0x10(%ebp),%eax
  102c95:	89 d7                	mov    %edx,%edi
  102c97:	89 c6                	mov    %eax,%esi
  102c99:	f3 a5                	rep movsl %ds:(%esi),%es:(%edi)
  102c9b:	8b 4d ec             	mov    -0x14(%ebp),%ecx
  102c9e:	83 e1 03             	and    $0x3,%ecx
  102ca1:	74 02                	je     102ca5 <memcpy+0x38>
  102ca3:	f3 a4                	rep movsb %ds:(%esi),%es:(%edi)
  102ca5:	89 f0                	mov    %esi,%eax
  102ca7:	89 fa                	mov    %edi,%edx
  102ca9:	89 4d e8             	mov    %ecx,-0x18(%ebp)
  102cac:	89 55 e4             	mov    %edx,-0x1c(%ebp)
  102caf:	89 45 e0             	mov    %eax,-0x20(%ebp)
    return dst;
  102cb2:	8b 45 f4             	mov    -0xc(%ebp),%eax
#ifdef __HAVE_ARCH_MEMCPY
    return __memcpy(dst, src, n);
  102cb5:	90                   	nop
    while (n -- > 0) {
        *d ++ = *s ++;
    }
    return dst;
#endif /* __HAVE_ARCH_MEMCPY */
}
  102cb6:	83 c4 20             	add    $0x20,%esp
  102cb9:	5e                   	pop    %esi
  102cba:	5f                   	pop    %edi
  102cbb:	5d                   	pop    %ebp
  102cbc:	c3                   	ret    

00102cbd <memcmp>:
 *   match in both memory blocks has a greater value in @v1 than in @v2
 *   as if evaluated as unsigned char values;
 * - And a value less than zero indicates the opposite.
 * */
int
memcmp(const void *v1, const void *v2, size_t n) {
  102cbd:	55                   	push   %ebp
  102cbe:	89 e5                	mov    %esp,%ebp
  102cc0:	83 ec 10             	sub    $0x10,%esp
    const char *s1 = (const char *)v1;
  102cc3:	8b 45 08             	mov    0x8(%ebp),%eax
  102cc6:	89 45 fc             	mov    %eax,-0x4(%ebp)
    const char *s2 = (const char *)v2;
  102cc9:	8b 45 0c             	mov    0xc(%ebp),%eax
  102ccc:	89 45 f8             	mov    %eax,-0x8(%ebp)
    while (n -- > 0) {
  102ccf:	eb 2e                	jmp    102cff <memcmp+0x42>
        if (*s1 != *s2) {
  102cd1:	8b 45 fc             	mov    -0x4(%ebp),%eax
  102cd4:	0f b6 10             	movzbl (%eax),%edx
  102cd7:	8b 45 f8             	mov    -0x8(%ebp),%eax
  102cda:	0f b6 00             	movzbl (%eax),%eax
  102cdd:	38 c2                	cmp    %al,%dl
  102cdf:	74 18                	je     102cf9 <memcmp+0x3c>
            return (int)((unsigned char)*s1 - (unsigned char)*s2);
  102ce1:	8b 45 fc             	mov    -0x4(%ebp),%eax
  102ce4:	0f b6 00             	movzbl (%eax),%eax
  102ce7:	0f b6 d0             	movzbl %al,%edx
  102cea:	8b 45 f8             	mov    -0x8(%ebp),%eax
  102ced:	0f b6 00             	movzbl (%eax),%eax
  102cf0:	0f b6 c0             	movzbl %al,%eax
  102cf3:	29 c2                	sub    %eax,%edx
  102cf5:	89 d0                	mov    %edx,%eax
  102cf7:	eb 18                	jmp    102d11 <memcmp+0x54>
        }
        s1 ++, s2 ++;
  102cf9:	ff 45 fc             	incl   -0x4(%ebp)
  102cfc:	ff 45 f8             	incl   -0x8(%ebp)
    while (n -- > 0) {
  102cff:	8b 45 10             	mov    0x10(%ebp),%eax
  102d02:	8d 50 ff             	lea    -0x1(%eax),%edx
  102d05:	89 55 10             	mov    %edx,0x10(%ebp)
  102d08:	85 c0                	test   %eax,%eax
  102d0a:	75 c5                	jne    102cd1 <memcmp+0x14>
    }
    return 0;
  102d0c:	b8 00 00 00 00       	mov    $0x0,%eax
}
  102d11:	c9                   	leave  
  102d12:	c3                   	ret    

00102d13 <printnum>:
 * @width:         maximum number of digits, if the actual width is less than @width, use @padc instead
 * @padc:        character that padded on the left if the actual width is less than @width
 * */
static void
printnum(void (*putch)(int, void*), void *putdat,
        unsigned long long num, unsigned base, int width, int padc) {
  102d13:	55                   	push   %ebp
  102d14:	89 e5                	mov    %esp,%ebp
  102d16:	83 ec 58             	sub    $0x58,%esp
  102d19:	8b 45 10             	mov    0x10(%ebp),%eax
  102d1c:	89 45 d0             	mov    %eax,-0x30(%ebp)
  102d1f:	8b 45 14             	mov    0x14(%ebp),%eax
  102d22:	89 45 d4             	mov    %eax,-0x2c(%ebp)
    unsigned long long result = num;
  102d25:	8b 45 d0             	mov    -0x30(%ebp),%eax
  102d28:	8b 55 d4             	mov    -0x2c(%ebp),%edx
  102d2b:	89 45 e8             	mov    %eax,-0x18(%ebp)
  102d2e:	89 55 ec             	mov    %edx,-0x14(%ebp)
    unsigned mod = do_div(result, base);
  102d31:	8b 45 18             	mov    0x18(%ebp),%eax
  102d34:	89 45 e4             	mov    %eax,-0x1c(%ebp)
  102d37:	8b 45 e8             	mov    -0x18(%ebp),%eax
  102d3a:	8b 55 ec             	mov    -0x14(%ebp),%edx
  102d3d:	89 45 e0             	mov    %eax,-0x20(%ebp)
  102d40:	89 55 f0             	mov    %edx,-0x10(%ebp)
  102d43:	8b 45 f0             	mov    -0x10(%ebp),%eax
  102d46:	89 45 f4             	mov    %eax,-0xc(%ebp)
  102d49:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
  102d4d:	74 1c                	je     102d6b <printnum+0x58>
  102d4f:	8b 45 f0             	mov    -0x10(%ebp),%eax
  102d52:	ba 00 00 00 00       	mov    $0x0,%edx
  102d57:	f7 75 e4             	divl   -0x1c(%ebp)
  102d5a:	89 55 f4             	mov    %edx,-0xc(%ebp)
  102d5d:	8b 45 f0             	mov    -0x10(%ebp),%eax
  102d60:	ba 00 00 00 00       	mov    $0x0,%edx
  102d65:	f7 75 e4             	divl   -0x1c(%ebp)
  102d68:	89 45 f0             	mov    %eax,-0x10(%ebp)
  102d6b:	8b 45 e0             	mov    -0x20(%ebp),%eax
  102d6e:	8b 55 f4             	mov    -0xc(%ebp),%edx
  102d71:	f7 75 e4             	divl   -0x1c(%ebp)
  102d74:	89 45 e0             	mov    %eax,-0x20(%ebp)
  102d77:	89 55 dc             	mov    %edx,-0x24(%ebp)
  102d7a:	8b 45 e0             	mov    -0x20(%ebp),%eax
  102d7d:	8b 55 f0             	mov    -0x10(%ebp),%edx
  102d80:	89 45 e8             	mov    %eax,-0x18(%ebp)
  102d83:	89 55 ec             	mov    %edx,-0x14(%ebp)
  102d86:	8b 45 dc             	mov    -0x24(%ebp),%eax
  102d89:	89 45 d8             	mov    %eax,-0x28(%ebp)

    // first recursively print all preceding (more significant) digits
    if (num >= base) {
  102d8c:	8b 45 18             	mov    0x18(%ebp),%eax
  102d8f:	ba 00 00 00 00       	mov    $0x0,%edx
  102d94:	39 55 d4             	cmp    %edx,-0x2c(%ebp)
  102d97:	72 56                	jb     102def <printnum+0xdc>
  102d99:	39 55 d4             	cmp    %edx,-0x2c(%ebp)
  102d9c:	77 05                	ja     102da3 <printnum+0x90>
  102d9e:	39 45 d0             	cmp    %eax,-0x30(%ebp)
  102da1:	72 4c                	jb     102def <printnum+0xdc>
        printnum(putch, putdat, result, base, width - 1, padc);
  102da3:	8b 45 1c             	mov    0x1c(%ebp),%eax
  102da6:	8d 50 ff             	lea    -0x1(%eax),%edx
  102da9:	8b 45 20             	mov    0x20(%ebp),%eax
  102dac:	89 44 24 18          	mov    %eax,0x18(%esp)
  102db0:	89 54 24 14          	mov    %edx,0x14(%esp)
  102db4:	8b 45 18             	mov    0x18(%ebp),%eax
  102db7:	89 44 24 10          	mov    %eax,0x10(%esp)
  102dbb:	8b 45 e8             	mov    -0x18(%ebp),%eax
  102dbe:	8b 55 ec             	mov    -0x14(%ebp),%edx
  102dc1:	89 44 24 08          	mov    %eax,0x8(%esp)
  102dc5:	89 54 24 0c          	mov    %edx,0xc(%esp)
  102dc9:	8b 45 0c             	mov    0xc(%ebp),%eax
  102dcc:	89 44 24 04          	mov    %eax,0x4(%esp)
  102dd0:	8b 45 08             	mov    0x8(%ebp),%eax
  102dd3:	89 04 24             	mov    %eax,(%esp)
  102dd6:	e8 38 ff ff ff       	call   102d13 <printnum>
  102ddb:	eb 1b                	jmp    102df8 <printnum+0xe5>
    } else {
        // print any needed pad characters before first digit
        while (-- width > 0)
            putch(padc, putdat);
  102ddd:	8b 45 0c             	mov    0xc(%ebp),%eax
  102de0:	89 44 24 04          	mov    %eax,0x4(%esp)
  102de4:	8b 45 20             	mov    0x20(%ebp),%eax
  102de7:	89 04 24             	mov    %eax,(%esp)
  102dea:	8b 45 08             	mov    0x8(%ebp),%eax
  102ded:	ff d0                	call   *%eax
        while (-- width > 0)
  102def:	ff 4d 1c             	decl   0x1c(%ebp)
  102df2:	83 7d 1c 00          	cmpl   $0x0,0x1c(%ebp)
  102df6:	7f e5                	jg     102ddd <printnum+0xca>
    }
    // then print this (the least significant) digit
    putch("0123456789abcdef"[mod], putdat);
  102df8:	8b 45 d8             	mov    -0x28(%ebp),%eax
  102dfb:	05 50 3b 10 00       	add    $0x103b50,%eax
  102e00:	0f b6 00             	movzbl (%eax),%eax
  102e03:	0f be c0             	movsbl %al,%eax
  102e06:	8b 55 0c             	mov    0xc(%ebp),%edx
  102e09:	89 54 24 04          	mov    %edx,0x4(%esp)
  102e0d:	89 04 24             	mov    %eax,(%esp)
  102e10:	8b 45 08             	mov    0x8(%ebp),%eax
  102e13:	ff d0                	call   *%eax
}
  102e15:	90                   	nop
  102e16:	c9                   	leave  
  102e17:	c3                   	ret    

00102e18 <getuint>:
 * getuint - get an unsigned int of various possible sizes from a varargs list
 * @ap:            a varargs list pointer
 * @lflag:        determines the size of the vararg that @ap points to
 * */
static unsigned long long
getuint(va_list *ap, int lflag) {
  102e18:	55                   	push   %ebp
  102e19:	89 e5                	mov    %esp,%ebp
    if (lflag >= 2) {
  102e1b:	83 7d 0c 01          	cmpl   $0x1,0xc(%ebp)
  102e1f:	7e 14                	jle    102e35 <getuint+0x1d>
        return va_arg(*ap, unsigned long long);
  102e21:	8b 45 08             	mov    0x8(%ebp),%eax
  102e24:	8b 00                	mov    (%eax),%eax
  102e26:	8d 48 08             	lea    0x8(%eax),%ecx
  102e29:	8b 55 08             	mov    0x8(%ebp),%edx
  102e2c:	89 0a                	mov    %ecx,(%edx)
  102e2e:	8b 50 04             	mov    0x4(%eax),%edx
  102e31:	8b 00                	mov    (%eax),%eax
  102e33:	eb 30                	jmp    102e65 <getuint+0x4d>
    }
    else if (lflag) {
  102e35:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
  102e39:	74 16                	je     102e51 <getuint+0x39>
        return va_arg(*ap, unsigned long);
  102e3b:	8b 45 08             	mov    0x8(%ebp),%eax
  102e3e:	8b 00                	mov    (%eax),%eax
  102e40:	8d 48 04             	lea    0x4(%eax),%ecx
  102e43:	8b 55 08             	mov    0x8(%ebp),%edx
  102e46:	89 0a                	mov    %ecx,(%edx)
  102e48:	8b 00                	mov    (%eax),%eax
  102e4a:	ba 00 00 00 00       	mov    $0x0,%edx
  102e4f:	eb 14                	jmp    102e65 <getuint+0x4d>
    }
    else {
        return va_arg(*ap, unsigned int);
  102e51:	8b 45 08             	mov    0x8(%ebp),%eax
  102e54:	8b 00                	mov    (%eax),%eax
  102e56:	8d 48 04             	lea    0x4(%eax),%ecx
  102e59:	8b 55 08             	mov    0x8(%ebp),%edx
  102e5c:	89 0a                	mov    %ecx,(%edx)
  102e5e:	8b 00                	mov    (%eax),%eax
  102e60:	ba 00 00 00 00       	mov    $0x0,%edx
    }
}
  102e65:	5d                   	pop    %ebp
  102e66:	c3                   	ret    

00102e67 <getint>:
 * getint - same as getuint but signed, we can't use getuint because of sign extension
 * @ap:            a varargs list pointer
 * @lflag:        determines the size of the vararg that @ap points to
 * */
static long long
getint(va_list *ap, int lflag) {
  102e67:	55                   	push   %ebp
  102e68:	89 e5                	mov    %esp,%ebp
    if (lflag >= 2) {
  102e6a:	83 7d 0c 01          	cmpl   $0x1,0xc(%ebp)
  102e6e:	7e 14                	jle    102e84 <getint+0x1d>
        return va_arg(*ap, long long);
  102e70:	8b 45 08             	mov    0x8(%ebp),%eax
  102e73:	8b 00                	mov    (%eax),%eax
  102e75:	8d 48 08             	lea    0x8(%eax),%ecx
  102e78:	8b 55 08             	mov    0x8(%ebp),%edx
  102e7b:	89 0a                	mov    %ecx,(%edx)
  102e7d:	8b 50 04             	mov    0x4(%eax),%edx
  102e80:	8b 00                	mov    (%eax),%eax
  102e82:	eb 28                	jmp    102eac <getint+0x45>
    }
    else if (lflag) {
  102e84:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
  102e88:	74 12                	je     102e9c <getint+0x35>
        return va_arg(*ap, long);
  102e8a:	8b 45 08             	mov    0x8(%ebp),%eax
  102e8d:	8b 00                	mov    (%eax),%eax
  102e8f:	8d 48 04             	lea    0x4(%eax),%ecx
  102e92:	8b 55 08             	mov    0x8(%ebp),%edx
  102e95:	89 0a                	mov    %ecx,(%edx)
  102e97:	8b 00                	mov    (%eax),%eax
  102e99:	99                   	cltd   
  102e9a:	eb 10                	jmp    102eac <getint+0x45>
    }
    else {
        return va_arg(*ap, int);
  102e9c:	8b 45 08             	mov    0x8(%ebp),%eax
  102e9f:	8b 00                	mov    (%eax),%eax
  102ea1:	8d 48 04             	lea    0x4(%eax),%ecx
  102ea4:	8b 55 08             	mov    0x8(%ebp),%edx
  102ea7:	89 0a                	mov    %ecx,(%edx)
  102ea9:	8b 00                	mov    (%eax),%eax
  102eab:	99                   	cltd   
    }
}
  102eac:	5d                   	pop    %ebp
  102ead:	c3                   	ret    

00102eae <printfmt>:
 * @putch:        specified putch function, print a single character
 * @putdat:        used by @putch function
 * @fmt:        the format string to use
 * */
void
printfmt(void (*putch)(int, void*), void *putdat, const char *fmt, ...) {
  102eae:	55                   	push   %ebp
  102eaf:	89 e5                	mov    %esp,%ebp
  102eb1:	83 ec 28             	sub    $0x28,%esp
    va_list ap;

    va_start(ap, fmt);
  102eb4:	8d 45 14             	lea    0x14(%ebp),%eax
  102eb7:	89 45 f4             	mov    %eax,-0xc(%ebp)
    vprintfmt(putch, putdat, fmt, ap);
  102eba:	8b 45 f4             	mov    -0xc(%ebp),%eax
  102ebd:	89 44 24 0c          	mov    %eax,0xc(%esp)
  102ec1:	8b 45 10             	mov    0x10(%ebp),%eax
  102ec4:	89 44 24 08          	mov    %eax,0x8(%esp)
  102ec8:	8b 45 0c             	mov    0xc(%ebp),%eax
  102ecb:	89 44 24 04          	mov    %eax,0x4(%esp)
  102ecf:	8b 45 08             	mov    0x8(%ebp),%eax
  102ed2:	89 04 24             	mov    %eax,(%esp)
  102ed5:	e8 03 00 00 00       	call   102edd <vprintfmt>
    va_end(ap);
}
  102eda:	90                   	nop
  102edb:	c9                   	leave  
  102edc:	c3                   	ret    

00102edd <vprintfmt>:
 *
 * Call this function if you are already dealing with a va_list.
 * Or you probably want printfmt() instead.
 * */
void
vprintfmt(void (*putch)(int, void*), void *putdat, const char *fmt, va_list ap) {
  102edd:	55                   	push   %ebp
  102ede:	89 e5                	mov    %esp,%ebp
  102ee0:	56                   	push   %esi
  102ee1:	53                   	push   %ebx
  102ee2:	83 ec 40             	sub    $0x40,%esp
    register int ch, err;
    unsigned long long num;
    int base, width, precision, lflag, altflag;

    while (1) {
        while ((ch = *(unsigned char *)fmt ++) != '%') {
  102ee5:	eb 17                	jmp    102efe <vprintfmt+0x21>
            if (ch == '\0') {
  102ee7:	85 db                	test   %ebx,%ebx
  102ee9:	0f 84 bf 03 00 00    	je     1032ae <vprintfmt+0x3d1>
                return;
            }
            putch(ch, putdat);
  102eef:	8b 45 0c             	mov    0xc(%ebp),%eax
  102ef2:	89 44 24 04          	mov    %eax,0x4(%esp)
  102ef6:	89 1c 24             	mov    %ebx,(%esp)
  102ef9:	8b 45 08             	mov    0x8(%ebp),%eax
  102efc:	ff d0                	call   *%eax
        while ((ch = *(unsigned char *)fmt ++) != '%') {
  102efe:	8b 45 10             	mov    0x10(%ebp),%eax
  102f01:	8d 50 01             	lea    0x1(%eax),%edx
  102f04:	89 55 10             	mov    %edx,0x10(%ebp)
  102f07:	0f b6 00             	movzbl (%eax),%eax
  102f0a:	0f b6 d8             	movzbl %al,%ebx
  102f0d:	83 fb 25             	cmp    $0x25,%ebx
  102f10:	75 d5                	jne    102ee7 <vprintfmt+0xa>
        }

        // Process a %-escape sequence
        char padc = ' ';
  102f12:	c6 45 db 20          	movb   $0x20,-0x25(%ebp)
        width = precision = -1;
  102f16:	c7 45 e4 ff ff ff ff 	movl   $0xffffffff,-0x1c(%ebp)
  102f1d:	8b 45 e4             	mov    -0x1c(%ebp),%eax
  102f20:	89 45 e8             	mov    %eax,-0x18(%ebp)
        lflag = altflag = 0;
  102f23:	c7 45 dc 00 00 00 00 	movl   $0x0,-0x24(%ebp)
  102f2a:	8b 45 dc             	mov    -0x24(%ebp),%eax
  102f2d:	89 45 e0             	mov    %eax,-0x20(%ebp)

    reswitch:
        switch (ch = *(unsigned char *)fmt ++) {
  102f30:	8b 45 10             	mov    0x10(%ebp),%eax
  102f33:	8d 50 01             	lea    0x1(%eax),%edx
  102f36:	89 55 10             	mov    %edx,0x10(%ebp)
  102f39:	0f b6 00             	movzbl (%eax),%eax
  102f3c:	0f b6 d8             	movzbl %al,%ebx
  102f3f:	8d 43 dd             	lea    -0x23(%ebx),%eax
  102f42:	83 f8 55             	cmp    $0x55,%eax
  102f45:	0f 87 37 03 00 00    	ja     103282 <vprintfmt+0x3a5>
  102f4b:	8b 04 85 74 3b 10 00 	mov    0x103b74(,%eax,4),%eax
  102f52:	ff e0                	jmp    *%eax

        // flag to pad on the right
        case '-':
            padc = '-';
  102f54:	c6 45 db 2d          	movb   $0x2d,-0x25(%ebp)
            goto reswitch;
  102f58:	eb d6                	jmp    102f30 <vprintfmt+0x53>

        // flag to pad with 0's instead of spaces
        case '0':
            padc = '0';
  102f5a:	c6 45 db 30          	movb   $0x30,-0x25(%ebp)
            goto reswitch;
  102f5e:	eb d0                	jmp    102f30 <vprintfmt+0x53>

        // width field
        case '1' ... '9':
            for (precision = 0; ; ++ fmt) {
  102f60:	c7 45 e4 00 00 00 00 	movl   $0x0,-0x1c(%ebp)
                precision = precision * 10 + ch - '0';
  102f67:	8b 55 e4             	mov    -0x1c(%ebp),%edx
  102f6a:	89 d0                	mov    %edx,%eax
  102f6c:	c1 e0 02             	shl    $0x2,%eax
  102f6f:	01 d0                	add    %edx,%eax
  102f71:	01 c0                	add    %eax,%eax
  102f73:	01 d8                	add    %ebx,%eax
  102f75:	83 e8 30             	sub    $0x30,%eax
  102f78:	89 45 e4             	mov    %eax,-0x1c(%ebp)
                ch = *fmt;
  102f7b:	8b 45 10             	mov    0x10(%ebp),%eax
  102f7e:	0f b6 00             	movzbl (%eax),%eax
  102f81:	0f be d8             	movsbl %al,%ebx
                if (ch < '0' || ch > '9') {
  102f84:	83 fb 2f             	cmp    $0x2f,%ebx
  102f87:	7e 38                	jle    102fc1 <vprintfmt+0xe4>
  102f89:	83 fb 39             	cmp    $0x39,%ebx
  102f8c:	7f 33                	jg     102fc1 <vprintfmt+0xe4>
            for (precision = 0; ; ++ fmt) {
  102f8e:	ff 45 10             	incl   0x10(%ebp)
                precision = precision * 10 + ch - '0';
  102f91:	eb d4                	jmp    102f67 <vprintfmt+0x8a>
                }
            }
            goto process_precision;

        case '*':
            precision = va_arg(ap, int);
  102f93:	8b 45 14             	mov    0x14(%ebp),%eax
  102f96:	8d 50 04             	lea    0x4(%eax),%edx
  102f99:	89 55 14             	mov    %edx,0x14(%ebp)
  102f9c:	8b 00                	mov    (%eax),%eax
  102f9e:	89 45 e4             	mov    %eax,-0x1c(%ebp)
            goto process_precision;
  102fa1:	eb 1f                	jmp    102fc2 <vprintfmt+0xe5>

        case '.':
            if (width < 0)
  102fa3:	83 7d e8 00          	cmpl   $0x0,-0x18(%ebp)
  102fa7:	79 87                	jns    102f30 <vprintfmt+0x53>
                width = 0;
  102fa9:	c7 45 e8 00 00 00 00 	movl   $0x0,-0x18(%ebp)
            goto reswitch;
  102fb0:	e9 7b ff ff ff       	jmp    102f30 <vprintfmt+0x53>

        case '#':
            altflag = 1;
  102fb5:	c7 45 dc 01 00 00 00 	movl   $0x1,-0x24(%ebp)
            goto reswitch;
  102fbc:	e9 6f ff ff ff       	jmp    102f30 <vprintfmt+0x53>
            goto process_precision;
  102fc1:	90                   	nop

        process_precision:
            if (width < 0)
  102fc2:	83 7d e8 00          	cmpl   $0x0,-0x18(%ebp)
  102fc6:	0f 89 64 ff ff ff    	jns    102f30 <vprintfmt+0x53>
                width = precision, precision = -1;
  102fcc:	8b 45 e4             	mov    -0x1c(%ebp),%eax
  102fcf:	89 45 e8             	mov    %eax,-0x18(%ebp)
  102fd2:	c7 45 e4 ff ff ff ff 	movl   $0xffffffff,-0x1c(%ebp)
            goto reswitch;
  102fd9:	e9 52 ff ff ff       	jmp    102f30 <vprintfmt+0x53>

        // long flag (doubled for long long)
        case 'l':
            lflag ++;
  102fde:	ff 45 e0             	incl   -0x20(%ebp)
            goto reswitch;
  102fe1:	e9 4a ff ff ff       	jmp    102f30 <vprintfmt+0x53>

        // character
        case 'c':
            putch(va_arg(ap, int), putdat);
  102fe6:	8b 45 14             	mov    0x14(%ebp),%eax
  102fe9:	8d 50 04             	lea    0x4(%eax),%edx
  102fec:	89 55 14             	mov    %edx,0x14(%ebp)
  102fef:	8b 00                	mov    (%eax),%eax
  102ff1:	8b 55 0c             	mov    0xc(%ebp),%edx
  102ff4:	89 54 24 04          	mov    %edx,0x4(%esp)
  102ff8:	89 04 24             	mov    %eax,(%esp)
  102ffb:	8b 45 08             	mov    0x8(%ebp),%eax
  102ffe:	ff d0                	call   *%eax
            break;
  103000:	e9 a4 02 00 00       	jmp    1032a9 <vprintfmt+0x3cc>

        // error message
        case 'e':
            err = va_arg(ap, int);
  103005:	8b 45 14             	mov    0x14(%ebp),%eax
  103008:	8d 50 04             	lea    0x4(%eax),%edx
  10300b:	89 55 14             	mov    %edx,0x14(%ebp)
  10300e:	8b 18                	mov    (%eax),%ebx
            if (err < 0) {
  103010:	85 db                	test   %ebx,%ebx
  103012:	79 02                	jns    103016 <vprintfmt+0x139>
                err = -err;
  103014:	f7 db                	neg    %ebx
            }
            if (err > MAXERROR || (p = error_string[err]) == NULL) {
  103016:	83 fb 06             	cmp    $0x6,%ebx
  103019:	7f 0b                	jg     103026 <vprintfmt+0x149>
  10301b:	8b 34 9d 34 3b 10 00 	mov    0x103b34(,%ebx,4),%esi
  103022:	85 f6                	test   %esi,%esi
  103024:	75 23                	jne    103049 <vprintfmt+0x16c>
                printfmt(putch, putdat, "error %d", err);
  103026:	89 5c 24 0c          	mov    %ebx,0xc(%esp)
  10302a:	c7 44 24 08 61 3b 10 	movl   $0x103b61,0x8(%esp)
  103031:	00 
  103032:	8b 45 0c             	mov    0xc(%ebp),%eax
  103035:	89 44 24 04          	mov    %eax,0x4(%esp)
  103039:	8b 45 08             	mov    0x8(%ebp),%eax
  10303c:	89 04 24             	mov    %eax,(%esp)
  10303f:	e8 6a fe ff ff       	call   102eae <printfmt>
            }
            else {
                printfmt(putch, putdat, "%s", p);
            }
            break;
  103044:	e9 60 02 00 00       	jmp    1032a9 <vprintfmt+0x3cc>
                printfmt(putch, putdat, "%s", p);
  103049:	89 74 24 0c          	mov    %esi,0xc(%esp)
  10304d:	c7 44 24 08 6a 3b 10 	movl   $0x103b6a,0x8(%esp)
  103054:	00 
  103055:	8b 45 0c             	mov    0xc(%ebp),%eax
  103058:	89 44 24 04          	mov    %eax,0x4(%esp)
  10305c:	8b 45 08             	mov    0x8(%ebp),%eax
  10305f:	89 04 24             	mov    %eax,(%esp)
  103062:	e8 47 fe ff ff       	call   102eae <printfmt>
            break;
  103067:	e9 3d 02 00 00       	jmp    1032a9 <vprintfmt+0x3cc>

        // string
        case 's':
            if ((p = va_arg(ap, char *)) == NULL) {
  10306c:	8b 45 14             	mov    0x14(%ebp),%eax
  10306f:	8d 50 04             	lea    0x4(%eax),%edx
  103072:	89 55 14             	mov    %edx,0x14(%ebp)
  103075:	8b 30                	mov    (%eax),%esi
  103077:	85 f6                	test   %esi,%esi
  103079:	75 05                	jne    103080 <vprintfmt+0x1a3>
                p = "(null)";
  10307b:	be 6d 3b 10 00       	mov    $0x103b6d,%esi
            }
            if (width > 0 && padc != '-') {
  103080:	83 7d e8 00          	cmpl   $0x0,-0x18(%ebp)
  103084:	7e 76                	jle    1030fc <vprintfmt+0x21f>
  103086:	80 7d db 2d          	cmpb   $0x2d,-0x25(%ebp)
  10308a:	74 70                	je     1030fc <vprintfmt+0x21f>
                for (width -= strnlen(p, precision); width > 0; width --) {
  10308c:	8b 45 e4             	mov    -0x1c(%ebp),%eax
  10308f:	89 44 24 04          	mov    %eax,0x4(%esp)
  103093:	89 34 24             	mov    %esi,(%esp)
  103096:	e8 f6 f7 ff ff       	call   102891 <strnlen>
  10309b:	8b 55 e8             	mov    -0x18(%ebp),%edx
  10309e:	29 c2                	sub    %eax,%edx
  1030a0:	89 d0                	mov    %edx,%eax
  1030a2:	89 45 e8             	mov    %eax,-0x18(%ebp)
  1030a5:	eb 16                	jmp    1030bd <vprintfmt+0x1e0>
                    putch(padc, putdat);
  1030a7:	0f be 45 db          	movsbl -0x25(%ebp),%eax
  1030ab:	8b 55 0c             	mov    0xc(%ebp),%edx
  1030ae:	89 54 24 04          	mov    %edx,0x4(%esp)
  1030b2:	89 04 24             	mov    %eax,(%esp)
  1030b5:	8b 45 08             	mov    0x8(%ebp),%eax
  1030b8:	ff d0                	call   *%eax
                for (width -= strnlen(p, precision); width > 0; width --) {
  1030ba:	ff 4d e8             	decl   -0x18(%ebp)
  1030bd:	83 7d e8 00          	cmpl   $0x0,-0x18(%ebp)
  1030c1:	7f e4                	jg     1030a7 <vprintfmt+0x1ca>
                }
            }
            for (; (ch = *p ++) != '\0' && (precision < 0 || -- precision >= 0); width --) {
  1030c3:	eb 37                	jmp    1030fc <vprintfmt+0x21f>
                if (altflag && (ch < ' ' || ch > '~')) {
  1030c5:	83 7d dc 00          	cmpl   $0x0,-0x24(%ebp)
  1030c9:	74 1f                	je     1030ea <vprintfmt+0x20d>
  1030cb:	83 fb 1f             	cmp    $0x1f,%ebx
  1030ce:	7e 05                	jle    1030d5 <vprintfmt+0x1f8>
  1030d0:	83 fb 7e             	cmp    $0x7e,%ebx
  1030d3:	7e 15                	jle    1030ea <vprintfmt+0x20d>
                    putch('?', putdat);
  1030d5:	8b 45 0c             	mov    0xc(%ebp),%eax
  1030d8:	89 44 24 04          	mov    %eax,0x4(%esp)
  1030dc:	c7 04 24 3f 00 00 00 	movl   $0x3f,(%esp)
  1030e3:	8b 45 08             	mov    0x8(%ebp),%eax
  1030e6:	ff d0                	call   *%eax
  1030e8:	eb 0f                	jmp    1030f9 <vprintfmt+0x21c>
                }
                else {
                    putch(ch, putdat);
  1030ea:	8b 45 0c             	mov    0xc(%ebp),%eax
  1030ed:	89 44 24 04          	mov    %eax,0x4(%esp)
  1030f1:	89 1c 24             	mov    %ebx,(%esp)
  1030f4:	8b 45 08             	mov    0x8(%ebp),%eax
  1030f7:	ff d0                	call   *%eax
            for (; (ch = *p ++) != '\0' && (precision < 0 || -- precision >= 0); width --) {
  1030f9:	ff 4d e8             	decl   -0x18(%ebp)
  1030fc:	89 f0                	mov    %esi,%eax
  1030fe:	8d 70 01             	lea    0x1(%eax),%esi
  103101:	0f b6 00             	movzbl (%eax),%eax
  103104:	0f be d8             	movsbl %al,%ebx
  103107:	85 db                	test   %ebx,%ebx
  103109:	74 27                	je     103132 <vprintfmt+0x255>
  10310b:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
  10310f:	78 b4                	js     1030c5 <vprintfmt+0x1e8>
  103111:	ff 4d e4             	decl   -0x1c(%ebp)
  103114:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
  103118:	79 ab                	jns    1030c5 <vprintfmt+0x1e8>
                }
            }
            for (; width > 0; width --) {
  10311a:	eb 16                	jmp    103132 <vprintfmt+0x255>
                putch(' ', putdat);
  10311c:	8b 45 0c             	mov    0xc(%ebp),%eax
  10311f:	89 44 24 04          	mov    %eax,0x4(%esp)
  103123:	c7 04 24 20 00 00 00 	movl   $0x20,(%esp)
  10312a:	8b 45 08             	mov    0x8(%ebp),%eax
  10312d:	ff d0                	call   *%eax
            for (; width > 0; width --) {
  10312f:	ff 4d e8             	decl   -0x18(%ebp)
  103132:	83 7d e8 00          	cmpl   $0x0,-0x18(%ebp)
  103136:	7f e4                	jg     10311c <vprintfmt+0x23f>
            }
            break;
  103138:	e9 6c 01 00 00       	jmp    1032a9 <vprintfmt+0x3cc>

        // (signed) decimal
        case 'd':
            num = getint(&ap, lflag);
  10313d:	8b 45 e0             	mov    -0x20(%ebp),%eax
  103140:	89 44 24 04          	mov    %eax,0x4(%esp)
  103144:	8d 45 14             	lea    0x14(%ebp),%eax
  103147:	89 04 24             	mov    %eax,(%esp)
  10314a:	e8 18 fd ff ff       	call   102e67 <getint>
  10314f:	89 45 f0             	mov    %eax,-0x10(%ebp)
  103152:	89 55 f4             	mov    %edx,-0xc(%ebp)
            if ((long long)num < 0) {
  103155:	8b 45 f0             	mov    -0x10(%ebp),%eax
  103158:	8b 55 f4             	mov    -0xc(%ebp),%edx
  10315b:	85 d2                	test   %edx,%edx
  10315d:	79 26                	jns    103185 <vprintfmt+0x2a8>
                putch('-', putdat);
  10315f:	8b 45 0c             	mov    0xc(%ebp),%eax
  103162:	89 44 24 04          	mov    %eax,0x4(%esp)
  103166:	c7 04 24 2d 00 00 00 	movl   $0x2d,(%esp)
  10316d:	8b 45 08             	mov    0x8(%ebp),%eax
  103170:	ff d0                	call   *%eax
                num = -(long long)num;
  103172:	8b 45 f0             	mov    -0x10(%ebp),%eax
  103175:	8b 55 f4             	mov    -0xc(%ebp),%edx
  103178:	f7 d8                	neg    %eax
  10317a:	83 d2 00             	adc    $0x0,%edx
  10317d:	f7 da                	neg    %edx
  10317f:	89 45 f0             	mov    %eax,-0x10(%ebp)
  103182:	89 55 f4             	mov    %edx,-0xc(%ebp)
            }
            base = 10;
  103185:	c7 45 ec 0a 00 00 00 	movl   $0xa,-0x14(%ebp)
            goto number;
  10318c:	e9 a8 00 00 00       	jmp    103239 <vprintfmt+0x35c>

        // unsigned decimal
        case 'u':
            num = getuint(&ap, lflag);
  103191:	8b 45 e0             	mov    -0x20(%ebp),%eax
  103194:	89 44 24 04          	mov    %eax,0x4(%esp)
  103198:	8d 45 14             	lea    0x14(%ebp),%eax
  10319b:	89 04 24             	mov    %eax,(%esp)
  10319e:	e8 75 fc ff ff       	call   102e18 <getuint>
  1031a3:	89 45 f0             	mov    %eax,-0x10(%ebp)
  1031a6:	89 55 f4             	mov    %edx,-0xc(%ebp)
            base = 10;
  1031a9:	c7 45 ec 0a 00 00 00 	movl   $0xa,-0x14(%ebp)
            goto number;
  1031b0:	e9 84 00 00 00       	jmp    103239 <vprintfmt+0x35c>

        // (unsigned) octal
        case 'o':
            num = getuint(&ap, lflag);
  1031b5:	8b 45 e0             	mov    -0x20(%ebp),%eax
  1031b8:	89 44 24 04          	mov    %eax,0x4(%esp)
  1031bc:	8d 45 14             	lea    0x14(%ebp),%eax
  1031bf:	89 04 24             	mov    %eax,(%esp)
  1031c2:	e8 51 fc ff ff       	call   102e18 <getuint>
  1031c7:	89 45 f0             	mov    %eax,-0x10(%ebp)
  1031ca:	89 55 f4             	mov    %edx,-0xc(%ebp)
            base = 8;
  1031cd:	c7 45 ec 08 00 00 00 	movl   $0x8,-0x14(%ebp)
            goto number;
  1031d4:	eb 63                	jmp    103239 <vprintfmt+0x35c>

        // pointer
        case 'p':
            putch('0', putdat);
  1031d6:	8b 45 0c             	mov    0xc(%ebp),%eax
  1031d9:	89 44 24 04          	mov    %eax,0x4(%esp)
  1031dd:	c7 04 24 30 00 00 00 	movl   $0x30,(%esp)
  1031e4:	8b 45 08             	mov    0x8(%ebp),%eax
  1031e7:	ff d0                	call   *%eax
            putch('x', putdat);
  1031e9:	8b 45 0c             	mov    0xc(%ebp),%eax
  1031ec:	89 44 24 04          	mov    %eax,0x4(%esp)
  1031f0:	c7 04 24 78 00 00 00 	movl   $0x78,(%esp)
  1031f7:	8b 45 08             	mov    0x8(%ebp),%eax
  1031fa:	ff d0                	call   *%eax
            num = (unsigned long long)(uintptr_t)va_arg(ap, void *);
  1031fc:	8b 45 14             	mov    0x14(%ebp),%eax
  1031ff:	8d 50 04             	lea    0x4(%eax),%edx
  103202:	89 55 14             	mov    %edx,0x14(%ebp)
  103205:	8b 00                	mov    (%eax),%eax
  103207:	89 45 f0             	mov    %eax,-0x10(%ebp)
  10320a:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
            base = 16;
  103211:	c7 45 ec 10 00 00 00 	movl   $0x10,-0x14(%ebp)
            goto number;
  103218:	eb 1f                	jmp    103239 <vprintfmt+0x35c>

        // (unsigned) hexadecimal
        case 'x':
            num = getuint(&ap, lflag);
  10321a:	8b 45 e0             	mov    -0x20(%ebp),%eax
  10321d:	89 44 24 04          	mov    %eax,0x4(%esp)
  103221:	8d 45 14             	lea    0x14(%ebp),%eax
  103224:	89 04 24             	mov    %eax,(%esp)
  103227:	e8 ec fb ff ff       	call   102e18 <getuint>
  10322c:	89 45 f0             	mov    %eax,-0x10(%ebp)
  10322f:	89 55 f4             	mov    %edx,-0xc(%ebp)
            base = 16;
  103232:	c7 45 ec 10 00 00 00 	movl   $0x10,-0x14(%ebp)
        number:
            printnum(putch, putdat, num, base, width, padc);
  103239:	0f be 55 db          	movsbl -0x25(%ebp),%edx
  10323d:	8b 45 ec             	mov    -0x14(%ebp),%eax
  103240:	89 54 24 18          	mov    %edx,0x18(%esp)
  103244:	8b 55 e8             	mov    -0x18(%ebp),%edx
  103247:	89 54 24 14          	mov    %edx,0x14(%esp)
  10324b:	89 44 24 10          	mov    %eax,0x10(%esp)
  10324f:	8b 45 f0             	mov    -0x10(%ebp),%eax
  103252:	8b 55 f4             	mov    -0xc(%ebp),%edx
  103255:	89 44 24 08          	mov    %eax,0x8(%esp)
  103259:	89 54 24 0c          	mov    %edx,0xc(%esp)
  10325d:	8b 45 0c             	mov    0xc(%ebp),%eax
  103260:	89 44 24 04          	mov    %eax,0x4(%esp)
  103264:	8b 45 08             	mov    0x8(%ebp),%eax
  103267:	89 04 24             	mov    %eax,(%esp)
  10326a:	e8 a4 fa ff ff       	call   102d13 <printnum>
            break;
  10326f:	eb 38                	jmp    1032a9 <vprintfmt+0x3cc>

        // escaped '%' character
        case '%':
            putch(ch, putdat);
  103271:	8b 45 0c             	mov    0xc(%ebp),%eax
  103274:	89 44 24 04          	mov    %eax,0x4(%esp)
  103278:	89 1c 24             	mov    %ebx,(%esp)
  10327b:	8b 45 08             	mov    0x8(%ebp),%eax
  10327e:	ff d0                	call   *%eax
            break;
  103280:	eb 27                	jmp    1032a9 <vprintfmt+0x3cc>

        // unrecognized escape sequence - just print it literally
        default:
            putch('%', putdat);
  103282:	8b 45 0c             	mov    0xc(%ebp),%eax
  103285:	89 44 24 04          	mov    %eax,0x4(%esp)
  103289:	c7 04 24 25 00 00 00 	movl   $0x25,(%esp)
  103290:	8b 45 08             	mov    0x8(%ebp),%eax
  103293:	ff d0                	call   *%eax
            for (fmt --; fmt[-1] != '%'; fmt --)
  103295:	ff 4d 10             	decl   0x10(%ebp)
  103298:	eb 03                	jmp    10329d <vprintfmt+0x3c0>
  10329a:	ff 4d 10             	decl   0x10(%ebp)
  10329d:	8b 45 10             	mov    0x10(%ebp),%eax
  1032a0:	48                   	dec    %eax
  1032a1:	0f b6 00             	movzbl (%eax),%eax
  1032a4:	3c 25                	cmp    $0x25,%al
  1032a6:	75 f2                	jne    10329a <vprintfmt+0x3bd>
                /* do nothing */;
            break;
  1032a8:	90                   	nop
    while (1) {
  1032a9:	e9 37 fc ff ff       	jmp    102ee5 <vprintfmt+0x8>
                return;
  1032ae:	90                   	nop
        }
    }
}
  1032af:	83 c4 40             	add    $0x40,%esp
  1032b2:	5b                   	pop    %ebx
  1032b3:	5e                   	pop    %esi
  1032b4:	5d                   	pop    %ebp
  1032b5:	c3                   	ret    

001032b6 <sprintputch>:
 * sprintputch - 'print' a single character in a buffer
 * @ch:            the character will be printed
 * @b:            the buffer to place the character @ch
 * */
static void
sprintputch(int ch, struct sprintbuf *b) {
  1032b6:	55                   	push   %ebp
  1032b7:	89 e5                	mov    %esp,%ebp
    b->cnt ++;
  1032b9:	8b 45 0c             	mov    0xc(%ebp),%eax
  1032bc:	8b 40 08             	mov    0x8(%eax),%eax
  1032bf:	8d 50 01             	lea    0x1(%eax),%edx
  1032c2:	8b 45 0c             	mov    0xc(%ebp),%eax
  1032c5:	89 50 08             	mov    %edx,0x8(%eax)
    if (b->buf < b->ebuf) {
  1032c8:	8b 45 0c             	mov    0xc(%ebp),%eax
  1032cb:	8b 10                	mov    (%eax),%edx
  1032cd:	8b 45 0c             	mov    0xc(%ebp),%eax
  1032d0:	8b 40 04             	mov    0x4(%eax),%eax
  1032d3:	39 c2                	cmp    %eax,%edx
  1032d5:	73 12                	jae    1032e9 <sprintputch+0x33>
        *b->buf ++ = ch;
  1032d7:	8b 45 0c             	mov    0xc(%ebp),%eax
  1032da:	8b 00                	mov    (%eax),%eax
  1032dc:	8d 48 01             	lea    0x1(%eax),%ecx
  1032df:	8b 55 0c             	mov    0xc(%ebp),%edx
  1032e2:	89 0a                	mov    %ecx,(%edx)
  1032e4:	8b 55 08             	mov    0x8(%ebp),%edx
  1032e7:	88 10                	mov    %dl,(%eax)
    }
}
  1032e9:	90                   	nop
  1032ea:	5d                   	pop    %ebp
  1032eb:	c3                   	ret    

001032ec <snprintf>:
 * @str:        the buffer to place the result into
 * @size:        the size of buffer, including the trailing null space
 * @fmt:        the format string to use
 * */
int
snprintf(char *str, size_t size, const char *fmt, ...) {
  1032ec:	55                   	push   %ebp
  1032ed:	89 e5                	mov    %esp,%ebp
  1032ef:	83 ec 28             	sub    $0x28,%esp
    va_list ap;
    int cnt;
    va_start(ap, fmt);
  1032f2:	8d 45 14             	lea    0x14(%ebp),%eax
  1032f5:	89 45 f0             	mov    %eax,-0x10(%ebp)
    cnt = vsnprintf(str, size, fmt, ap);
  1032f8:	8b 45 f0             	mov    -0x10(%ebp),%eax
  1032fb:	89 44 24 0c          	mov    %eax,0xc(%esp)
  1032ff:	8b 45 10             	mov    0x10(%ebp),%eax
  103302:	89 44 24 08          	mov    %eax,0x8(%esp)
  103306:	8b 45 0c             	mov    0xc(%ebp),%eax
  103309:	89 44 24 04          	mov    %eax,0x4(%esp)
  10330d:	8b 45 08             	mov    0x8(%ebp),%eax
  103310:	89 04 24             	mov    %eax,(%esp)
  103313:	e8 08 00 00 00       	call   103320 <vsnprintf>
  103318:	89 45 f4             	mov    %eax,-0xc(%ebp)
    va_end(ap);
    return cnt;
  10331b:	8b 45 f4             	mov    -0xc(%ebp),%eax
}
  10331e:	c9                   	leave  
  10331f:	c3                   	ret    

00103320 <vsnprintf>:
 *
 * Call this function if you are already dealing with a va_list.
 * Or you probably want snprintf() instead.
 * */
int
vsnprintf(char *str, size_t size, const char *fmt, va_list ap) {
  103320:	55                   	push   %ebp
  103321:	89 e5                	mov    %esp,%ebp
  103323:	83 ec 28             	sub    $0x28,%esp
    struct sprintbuf b = {str, str + size - 1, 0};
  103326:	8b 45 08             	mov    0x8(%ebp),%eax
  103329:	89 45 ec             	mov    %eax,-0x14(%ebp)
  10332c:	8b 45 0c             	mov    0xc(%ebp),%eax
  10332f:	8d 50 ff             	lea    -0x1(%eax),%edx
  103332:	8b 45 08             	mov    0x8(%ebp),%eax
  103335:	01 d0                	add    %edx,%eax
  103337:	89 45 f0             	mov    %eax,-0x10(%ebp)
  10333a:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
    if (str == NULL || b.buf > b.ebuf) {
  103341:	83 7d 08 00          	cmpl   $0x0,0x8(%ebp)
  103345:	74 0a                	je     103351 <vsnprintf+0x31>
  103347:	8b 55 ec             	mov    -0x14(%ebp),%edx
  10334a:	8b 45 f0             	mov    -0x10(%ebp),%eax
  10334d:	39 c2                	cmp    %eax,%edx
  10334f:	76 07                	jbe    103358 <vsnprintf+0x38>
        return -E_INVAL;
  103351:	b8 fd ff ff ff       	mov    $0xfffffffd,%eax
  103356:	eb 2a                	jmp    103382 <vsnprintf+0x62>
    }
    // print the string to the buffer
    vprintfmt((void*)sprintputch, &b, fmt, ap);
  103358:	8b 45 14             	mov    0x14(%ebp),%eax
  10335b:	89 44 24 0c          	mov    %eax,0xc(%esp)
  10335f:	8b 45 10             	mov    0x10(%ebp),%eax
  103362:	89 44 24 08          	mov    %eax,0x8(%esp)
  103366:	8d 45 ec             	lea    -0x14(%ebp),%eax
  103369:	89 44 24 04          	mov    %eax,0x4(%esp)
  10336d:	c7 04 24 b6 32 10 00 	movl   $0x1032b6,(%esp)
  103374:	e8 64 fb ff ff       	call   102edd <vprintfmt>
    // null terminate the buffer
    *b.buf = '\0';
  103379:	8b 45 ec             	mov    -0x14(%ebp),%eax
  10337c:	c6 00 00             	movb   $0x0,(%eax)
    return b.cnt;
  10337f:	8b 45 f4             	mov    -0xc(%ebp),%eax
}
  103382:	c9                   	leave  
  103383:	c3                   	ret    
