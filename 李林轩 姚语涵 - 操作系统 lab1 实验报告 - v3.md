李林轩 姚语涵 - 操作系统 lab1 实验报告

# 目录

<!-- TOC -->

- [目录](#目录)
- [实验回答、实验过程记录、实验结果及分析](#实验回答实验过程记录实验结果及分析)
  - [## 1.1 理解通过 make 生成执行文件的过程。(要求在报告中写出对下述问题的回答)](#h2-id11-理解通过-make-生成执行文件的过程要求在报告中写出对下述问题的回答-4911-理解通过-make-生成执行文件的过程要求在报告中写出对下述问题的回答h2)
    - [1. 操作系统镜像文件 ucore.img是如何一步一步生成的？](#1-操作系统镜像文件-ucoreimg是如何一步一步生成的)
  - [1.2 为了熟悉使用qemu和gdb进行的调试工作，我们进行如下的小练习](#12-为了熟悉使用qemu和gdb进行的调试工作我们进行如下的小练习)
    - [1. 从初始化位置0x7c00设置实地址断点，测试断点正常](#1-从初始化位置0x7c00设置实地址断点测试断点正常)
    - [2. 从0x7c00开始跟踪代码运行，将单步跟踪反汇编得到的代码与bootasm.S和bootblock.asm进行比较](#2-从0x7c00开始跟踪代码运行将单步跟踪反汇编得到的代码与bootasms和bootblockasm进行比较)
    - [3. 自己找一个bootloader或内核中的代码位置设置断点，并进行调试](#3-自己找一个bootloader或内核中的代码位置设置断点并进行调试)
  - [1.3 分析计算机上电开始直到进口入UCORE kern_init（）函数之间的全过程（要求在实验报告中写出分析）](#13-分析计算机上电开始直到进口入ucore-kern_init函数之间的全过程要求在实验报告中写出分析)
        - [- BIOS与bootloader各⼲了什么](#ullibios与bootloader各了什么liul)
            - [- bootloader是如何从实模式进⼊到保护模式中的](#ullibootloader是如何从实模式进到保护模式中的liul)
            - [- GDT表作用和初始化位置：](#ulligdt表作用和初始化位置liul)
            - [- bootloader如何加载ELF格式的kernel](#ullibootloader如何加载elf格式的kernelliul)
            - [- bootloader如何读取硬盘扇区](#ullibootloader如何读取硬盘扇区liul)
  - [1.4 实现函数调用堆栈跟踪函数 (需要编程)](#14-实现函数调用堆栈跟踪函数-需要编程)
  - [1.5 完善中断初始化和处理 (需要编程)](#15-完善中断初始化和处理-需要编程)

<!-- /TOC -->

<br>

# 实验回答、实验过程记录、实验结果及分析

## 1.1 理解通过 make 生成执行文件的过程。(要求在报告中写出对下述问题的回答)
---
<br>

### 1. 操作系统镜像文件 ucore.img是如何一步一步生成的？

<br>

使用make clean，make V= 打印出详细的编译过程

```powershell
# ucore操作系统初始化
+ cc kern/init/init.c   # gcc命令：将.c或.S命令编译生成.o目标文件。# 各行实际命令如下：
gcc -Ikern/init/ -march=i686 -fno-builtin -fno-PIC -Wall -ggdb -m32 -gstabs -nostdinc  -fno-stack-protector -Ilibs/ -Ikern/debug/ -Ikern/driver/ -Ikern/trap/ -Ikern/mm/ -c kern/init/init.c -o obj/kern/init/init.o
kern/init/init.c:97:1: warning: ‘lab1_switch_test’ defined but not used [-Wunused-function]
   97 | lab1_switch_test(void) {
      | ^~~~~~~~~~~~~~~~

# 公共库部分
+ cc kern/libs/stdio.c
gcc -Ikern/libs/ -march=i686 -fno-builtin -fno-PIC -Wall -ggdb -m32 -gstabs -nostdinc  -fno-stack-protector -Ilibs/ -Ikern/debug/ -Ikern/driver/ -Ikern/trap/ -Ikern/mm/ -c kern/libs/stdio.c -o obj/kern/libs/stdio.o
+ cc kern/libs/readline.c
gcc -Ikern/libs/ -march=i686 -fno-builtin -fno-PIC -Wall -ggdb -m32 -gstabs -nostdinc  -fno-stack-protector -Ilibs/ -Ikern/debug/ -Ikern/driver/ -Ikern/trap/ -Ikern/mm/ -c kern/libs/readline.c -o obj/kern/libs/readline.o

# 内核调试部分
+ cc kern/debug/panic.c
gcc -Ikern/debug/ -march=i686 -fno-builtin -fno-PIC -Wall -ggdb -m32 -gstabs -nostdinc  -fno-stack-protector -Ilibs/ -Ikern/debug/ -Ikern/driver/ -Ikern/trap/ -Ikern/mm/ -c kern/debug/panic.c -o obj/kern/debug/panic.o
kern/debug/panic.c: In function ‘__panic’:
kern/debug/panic.c:27:5: warning: implicit declaration of function ‘print_stackframe’; did you mean ‘print_trapframe’? [-Wimplicit-function-declaration]
   27 |     print_stackframe();
      |     ^~~~~~~~~~~~~~~~
      |     print_trapframe
+ cc kern/debug/kdebug.c
gcc -Ikern/debug/ -march=i686 -fno-builtin -fno-PIC -Wall -ggdb -m32 -gstabs -nostdinc  -fno-stack-protector -Ilibs/ -Ikern/debug/ -Ikern/driver/ -Ikern/trap/ -Ikern/mm/ -c kern/debug/kdebug.c -o obj/kern/debug/kdebug.o
kern/debug/kdebug.c:251:1: warning: ‘read_eip’ defined but not used [-Wunused-function]
  251 | read_eip(void) {
      | ^~~~~~~~
+ cc kern/debug/kmonitor.c
gcc -Ikern/debug/ -march=i686 -fno-builtin -fno-PIC -Wall -ggdb -m32 -gstabs -nostdinc  -fno-stack-protector -Ilibs/ -Ikern/debug/ -Ikern/driver/ -Ikern/trap/ -Ikern/mm/ -c kern/debug/kmonitor.c -o obj/kern/debug/kmonitor.o

# 外设驱动部分
+ cc kern/driver/clock.c
gcc -Ikern/driver/ -march=i686 -fno-builtin -fno-PIC -Wall -ggdb -m32 -gstabs -nostdinc  -fno-stack-protector -Ilibs/ -Ikern/debug/ -Ikern/driver/ -Ikern/trap/ -Ikern/mm/ -c kern/driver/clock.c -o obj/kern/driver/clock.o
+ cc kern/driver/console.c
gcc -Ikern/driver/ -march=i686 -fno-builtin -fno-PIC -Wall -ggdb -m32 -gstabs -nostdinc  -fno-stack-protector -Ilibs/ -Ikern/debug/ -Ikern/driver/ -Ikern/trap/ -Ikern/mm/ -c kern/driver/console.c -o obj/kern/driver/console.o
+ cc kern/driver/picirq.c
gcc -Ikern/driver/ -march=i686 -fno-builtin -fno-PIC -Wall -ggdb -m32 -gstabs -nostdinc  -fno-stack-protector -Ilibs/ -Ikern/debug/ -Ikern/driver/ -Ikern/trap/ -Ikern/mm/ -c kern/driver/picirq.c -o obj/kern/driver/picirq.o
+ cc kern/driver/intr.c
gcc -Ikern/driver/ -march=i686 -fno-builtin -fno-PIC -Wall -ggdb -m32 -gstabs -nostdinc  -fno-stack-protector -Ilibs/ -Ikern/debug/ -Ikern/driver/ -Ikern/trap/ -Ikern/mm/ -c kern/driver/intr.c -o obj/kern/driver/intr.o

# 中断处理部分
+ cc kern/trap/trap.c
gcc -Ikern/trap/ -march=i686 -fno-builtin -fno-PIC -Wall -ggdb -m32 -gstabs -nostdinc  -fno-stack-protector -Ilibs/ -Ikern/debug/ -Ikern/driver/ -Ikern/trap/ -Ikern/mm/ -c kern/trap/trap.c -o obj/kern/trap/trap.o
kern/trap/trap.c: In function ‘print_trapframe’:
kern/trap/trap.c:101:16: warning: taking address of packed member of ‘struct trapframe’ may result in an unaligned pointer value [-Waddress-of-packed-member]
  101 |     print_regs(&tf->tf_regs);
      |                ^~~~~~~~~~~~
At top level:
kern/trap/trap.c:30:26: warning: ‘idt_pd’ defined but not used [-Wunused-variable]
   30 | static struct pseudodesc idt_pd = {
      |                          ^~~~~~
kern/trap/trap.c:14:13: warning: ‘print_ticks’ defined but not used [-Wunused-function]
   14 | static void print_ticks() {
      |             ^~~~~~~~~~~
+ cc kern/trap/vectors.S
gcc -Ikern/trap/ -march=i686 -fno-builtin -fno-PIC -Wall -ggdb -m32 -gstabs -nostdinc  -fno-stack-protector -Ilibs/ -Ikern/debug/ -Ikern/driver/ -Ikern/trap/ -Ikern/mm/ -c kern/trap/vectors.S -o obj/kern/trap/vectors.o
+ cc kern/trap/trapentry.S
gcc -Ikern/trap/ -march=i686 -fno-builtin -fno-PIC -Wall -ggdb -m32 -gstabs -nostdinc  -fno-stack-protector -Ilibs/ -Ikern/debug/ -Ikern/driver/ -Ikern/trap/ -Ikern/mm/ -c kern/trap/trapentry.S -o obj/kern/trap/trapentry.o

# 内存管理部分
+ cc kern/mm/pmm.c
gcc -Ikern/mm/ -march=i686 -fno-builtin -fno-PIC -Wall -ggdb -m32 -gstabs -nostdinc  -fno-stack-protector -Ilibs/ -Ikern/debug/ -Ikern/driver/ -Ikern/trap/ -Ikern/mm/ -c kern/mm/pmm.c -o obj/kern/mm/pmm.o

# 公共库部分
+ cc libs/string.c
gcc -Ilibs/ -march=i686 -fno-builtin -fno-PIC -Wall -ggdb -m32 -gstabs -nostdinc  -fno-stack-protector -Ilibs/  -c libs/string.c -o obj/libs/string.o
+ cc libs/printfmt.c
gcc -Ilibs/ -march=i686 -fno-builtin -fno-PIC -Wall -ggdb -m32 -gstabs -nostdinc  -fno-stack-protector -Ilibs/  -c libs/printfmt.c -o obj/libs/printfmt.o


+ ld bin/kernel # ld命令：链接.o文件生成新的.o文件或可执行文件。
ld -m    elf_i386 -nostdlib -T tools/kernel.ld -o bin/kernel  obj/kern/init/init.o obj/kern/libs/stdio.o obj/kern/libs/readline.o obj/kern/debug/panic.o obj/kern/debug/kdebug.o obj/kern/debug/kmonitor.o obj/kern/driver/clock.o obj/kern/driver/console.o obj/kern/driver/picirq.o obj/kern/driver/intr.o obj/kern/trap/trap.o obj/kern/trap/vectors.o obj/kern/trap/trapentry.o obj/kern/mm/pmm.o  obj/libs/string.o obj/libs/printfmt.o


# bootloader部分
+ cc boot/bootasm.S
gcc -Iboot/ -march=i686 -fno-builtin -fno-PIC -Wall -ggdb -m32 -gstabs -nostdinc  -fno-stack-protector -Ilibs/ -Os -nostdinc -c boot/bootasm.S -o obj/boot/bootasm.o
+ cc boot/bootmain.c
gcc -Iboot/ -march=i686 -fno-builtin -fno-PIC -Wall -ggdb -m32 -gstabs -nostdinc  -fno-stack-protector -Ilibs/ -Os -nostdinc -c boot/bootmain.c -o obj/boot/bootmain.o

# 工具部分
+ cc tools/sign.c   # 生成sign需要sign.c，sign.c是一个C语言小程序，用于生成一个规范的硬盘主引导扇区。
gcc -Itools/ -g -Wall -O2 -c tools/sign.c -o obj/sign/tools/sign.o
gcc -g -Wall -O2 obj/sign/tools/sign.o -o bin/sign

# 生成bootblock
+ ld bin/bootblock
ld -m    elf_i386 -nostdlib -N -e start -Ttext 0x7C00 obj/boot/bootasm.o obj/boot/bootmain.o -o obj/bootblock.o
'obj/bootblock.out' size: 496 bytes
build 512 bytes boot sector: 'bin/bootblock' success!
dd if=/dev/zero of=bin/ucore.img count=10000
记录了10000+0 的读入
记录了10000+0 的写出
5120000 bytes (5.1 MB, 4.9 MiB) copied, 0.0490557 s, 104 MB/s
dd if=bin/bootblock of=bin/ucore.img conv=notrunc
记录了1+0 的读入
记录了1+0 的写出
512 bytes copied, 0.000241324 s, 2.1 MB/s
dd if=bin/kernel of=bin/ucore.img seek=1 conv=notrunc
记录了154+1 的读入
记录了154+1 的写出
78912 bytes (79 kB, 77 KiB) copied, 0.000918762 s, 85.9 MB/s
```

生成过程：

通过GCC编译器将Kernel目录下的.c文件编译成OBJ目录下的.o文件

ld命令根据链接脚本文件kernel.ld将生成的*.o文件，链接成BIN目录下的kernel文件。

通过GCC编译器将boot目录下的bootasm.s，bootmain.c文件以及tools目录下的sign.c文件编译成OBJ目录下的 bootblock.o文件。

通过ld命令将生成的bootblock.o文件，链接成BIN目录下的bootblock文件。

使用dd命令，用dev/zero生成10000个块的空字符，每个块大小为512bytes,ucore.img总大小为5120000bytes。之后将bin目录下的bootloader代码复制到ucore内，共512bytes。最后将 bin/kernel 写入到bin/ucore.img，生成完最终的ucore镜像文件

## 1.2 为了熟悉使用qemu和gdb进行的调试工作，我们进行如下的小练习

### 1. 从初始化位置0x7c00设置实地址断点，测试断点正常

输入b *0x7c00 在该处设置断点

![2 (2)](https://raw.githubusercontent.com/llx-08/imageBed/master/2 (2).png)

输入continue跳转到断点处，能够正常运行

![23](https://raw.githubusercontent.com/llx-08/imageBed/master/23.png)

![qe](https://raw.githubusercontent.com/llx-08/imageBed/master/qe.png)



### 2. 从0x7c00开始跟踪代码运行，将单步跟踪反汇编得到的代码与bootasm.S和bootblock.asm进行比较

部分反汇编代码与bootasm.S文件对比，经调试两者是相同的

![img](https://raw.githubusercontent.com/llx-08/imageBed/master/asda.png)

### 3. 自己找一个bootloader或内核中的代码位置设置断点，并进行调试

Make完使用qemu对ucore进行调试

![dasdw](https://raw.githubusercontent.com/llx-08/imageBed/master/dasdw.png)

设置断点0x7c12，输入continue正常运行。

![adwa](https://raw.githubusercontent.com/llx-08/imageBed/master/adwa.png)

与bootasm.s中代码对比也相同。



## 1.3 分析计算机上电开始直到进口入UCORE kern_init（）函数之间的全过程（要求在实验报告中写出分析）

---

<br>

##### - BIOS与bootloader各⼲了什么

计算机上电后，先不执行操作系统，而是执行BIOS，bootloader等系统初始化软件完成基本IO初始化和引导加载功能。
最初计算机处于实模式，段寄存器CS和扩展指针寄存器EIP分别初始化为初值0xF000（符合早期8086的可见值，不可见值为0xFFFF0000，是CS指向的32位Base address）和0x0000FFF0。故而实际地址为CS的Base address再加上EIP为0xFFFFFFF0，是基本IO处理模块BIOS的EPROM的所在地。CPU先跳转到BIOS的起始地址0xFFFFFFF0处执行，让BIOS完成相应的初始化工作。BIOS的起始地址处第一条指令是长跳指令，跳转到BIOS的实际地址处，去完成对计算机各种硬件的初始化，如内存、CPU等。（可见于bootasm.S）

<br>
之后，BIOS开始引导软件的执行，它加载存储设备（如软盘、硬盘、光盘、USB盘）的第一个扇区，即主引导主扇区MBR的512 Bytes到内存的0x7c00处。

```c
    // read the 1st page off disk
    readseg((uintptr_t)ELFHDR, SECTSIZE * 8, 0);
```

这512 Bytes里就是bootloader。至此，BIOS的初始化工作完成，CPU的控制权从BIOS转到bootloader，在0x7c00处开始执行。

<br>

##### - bootloader是如何从实模式进⼊到保护模式中的

bootloader首先通过修改A20地址线完成计算机从实模式到保护模式的转换，

```avrasm
    # Enable A20:
    #  For backwards compatibility with the earliest PCs, physical
    #  address line 20 is tied low, so that addresses higher than
    #  1MB wrap around to zero by default. This code undoes this.
    # in/out 指令访问外设端口
seta20.1:
    inb $0x64, %al                                  # Wait for not busy(8042 input buffer empty).
    testb $0x2, %al
    jnz seta20.1

    movb $0xd1, %al                                 # 0xd1 -> port 0x64
    outb %al, $0x64                                 # 0xd1 means: write data to 8042's P2 port

seta20.2:
    inb $0x64, %al                                  # Wait for not busy(8042 input buffer empty).
    testb $0x2, %al
    jnz seta20.2

    movb $0xdf, %al                                 # 0xdf -> port 0x60
    outb %al, $0x60                                 # 0xdf = 11011111, means set P2's A20 bit(the 1 bit) to 1
```

段机制便在保护模式下自动使能，

```avrasm
# Switch from real to protected mode, using a bootstrap GDT
# and segment translation that makes virtual addresses
# identical to physical addresses, so that the
# effective memory map does not change during the switch.
# lgdt指令加载GDT 
lgdt gdtdesc
movl %cr0, %eax
orl $CR0_PE_ON, %eax
movl %eax, %cr0
```

在ucore中只用到了GDT，没有用到LDT。lgdt加载全局描述符表GDT，getdesc包含GDT的起始地址long gdt和其大小0x17

##### - GDT表作用和初始化位置：
```avrasm
gdtdesc:
# 开辟放置GDT起始地址空间
    .word 0x17                                      # sizeof(gdt) - 1
    .long gdt                                       # address gdt
```

第0个段描述符SEG_NULLASM是空的，代码段为SEG_ASM，数据段为SEG_ASM，其起始地址为0x0，最大值限制为0xffffffff，起到了保护作用

```avrasm
# Bootstrap GDT
# 调用宏配置GDT
.p2align 2                                          # force 4 byte alignment
gdt:
    SEG_NULLASM                                     # null seg
    SEG_ASM(STA_X|STA_R, 0x0, 0xffffffff)           # code seg for bootloader and kernel
    SEG_ASM(STA_W, 0x0, 0xffffffff)                 # data seg for bootloader and kernel
```

一旦进入了保护模式，bootloader就具备了访问4GB内存空间32位地址空间的功能。接下来bootloader要继续从硬盘里读取elf格式的ucore kernel（跟在MBR后面的扇区），将操作系统加载到内存中去，
##### - bootloader如何加载ELF格式的kernel
##### - bootloader如何读取硬盘扇区
```c
    // is this a valid ELF?
    if (ELFHDR->e_magic != ELF_MAGIC) {
        goto bad;
    }

    struct proghdr *ph, *eph;

    // load each program segment (ignores ph flags)
    ph = (struct proghdr *)((uintptr_t)ELFHDR + ELFHDR->e_phoff);
    eph = ph + ELFHDR->e_phnum;
    for (; ph < eph; ph ++) {
        readseg(ph->p_va & 0xFFFFFF, ph->p_memsz, ph->p_offset);
    }
    // call the entry point from the ELF header
    // note: does not return
    ((void (*)(void))(ELFHDR->e_entry & 0xFFFFFF))();
```

并跳转到ucore OS的入口地址（即kern_init函数的起始地址）解析该执行程序，此时控制权转移到ucore OS中。



<br>

## 1.4 实现函数调用堆栈跟踪函数 (需要编程)

我们需要在lab1中完成kdebug.c中函数print_stackframe的实现，可以通过函数print_stackframe来跟踪函数调用堆栈中记录的返回地址。在如果能够正确实现此函数，可在 lab1 中执行“make qemu”后，在 qemu 模拟器中得到类似如下的输出:
...
请完成实验，看看输出是否与上述显示大致一致，并解释最后一行各个数值的含义。
提示: 可阅读小节“函数堆栈”，了解编译器如何建立函数调用关系的。在完成 lab1 编译后，查看 lab1/obj/bootblock.asm，了解 bootloader 源码与机器码的语句和地址等的对应关系; 查看lab1/obj/kernel.asm，了解 ucore OS 源码与机器码的语句和地址等的对应关系。
要求完成函数 kern/debug/kdebug.c::print_stackframe 的实现，提交改进后源代码包 (可以编译执行)，并在实验报告中简要说明实现过程，并写出对上述问题的回答。

---

<br>

根据代码中的实验提示，可知：
print_stackframe函数的说明
```
 * print_stackframe - print a list of the saved eip values from the nested 'call'
 * instructions that led to the current point of execution
```
要用到的一系列函数的说明
```
 * The inline function read_ebp() can tell us the value of current ebp. And the
 * non-inline function read_eip() is useful, it can read the value of current eip,
 * since while calling this function, read_eip() can read the caller's eip from
 * stack easily.
```
esp：寄存器存放当前线程的栈顶指针
ebp：寄存器存放当前线程的栈底指针
eip：寄存器存放下一个CPU指令存放的内存地址，当CPU执行完当前的指令后，从EIP寄存器中读取下一条指令的内存地址，然后继续执行。
```
 * In print_debuginfo(), the function debuginfo_eip() can get enough information about
 * calling-chain. Finally print_stackframe() will trace and print them for debugging.
```
```
 * Note that, the length of ebp-chain is limited. In boot/bootasm.S, before jumping
 * to the kernel entry, the value of ebp has been set to zero, that's the boundary.
```

print_debuginfo
```c
/* *
 * print_debuginfo - read and print the stat information for the address @eip,
 * and info.eip_fn_addr should be the first address of the related function.
 * */
```

<br>

由此可以完成该函数，实现过程见注释：

<br>

```c
void
print_stackframe(void) {
     /* LAB1 YOUR CODE : STEP 1 */

     // (1) call read_ebp() to get the value of ebp.the type is(uint32_t)->其实就是int;
     uint32_t *ebp = (uint32_t *)read_ebp(); // inline function, 指针类型

     // (2) call read_eip() to get the value of eip. the type is (uint32_t);
     uint32_t eip = read_eip();              // non-inline function

     //(3) from 0 .. STACKFRAME_DEPTH
     // ebp为0时终止
     while (ebp)
     {
         // (3.1) printf value of ebp, eip
         cprintf("ebp: 0x%08x eip: 0x%08x args: \n", (uint32_t)ebp, eip);

         // (3.2) (uint32_t)calling arguments [0..4] = the contents in address (uint32_t)ebp +2 [0..4]
         // ebp所指位置向上都为输入的参数，案例中给了四个args所以输出四个
         cprintf("0x%08x 0x%08x 0x%08x 0x%08x\n", ebp[2], ebp[3], ebp[4], ebp[5]);

         // (3.3)控制输出格式
         cprintf("\n");

         // (3.4) call print_debuginfo(eip-1) to print the C calling function name and line number, etc.
         // eip指向的是当前位置的下一条指令地址，所以要-1
         print_debuginfo(eip - 1);

         // (3.5) popup a calling stackframe
         //  *NOTICE : 指针运算时候的单位问题,例如一个int*类型的指针+1其实质地址值+4
         eip = ((uint32_t *)ebp)[1];    // ebp指针指向的地址向上一个位置为上一个函数的eip
         ebp = *ebp;    // ebp指针指向的地址存储了上一个函数的ebp
         // 开弹！下一个函数！
    }
}
```

![水印是我本人blog上的](https://img-blog.csdnimg.cn/20201030003143142.png?x-oss-process=image/watermark,type_ZmFuZ3poZW5naGVpdGk,shadow_10,text_aHR0cHM6Ly9ibG9nLmNzZG4ubmV0L3FxXzQ0MzU0NTIw,size_16,color_FFFFFF,t_70#pic_center)
水印是我本人blog上的

<br>

## 1.5 完善中断初始化和处理 (需要编程) 
请完成编码工工作和回答如下问题:
1. 中断描述符表 (也可简称为保护模式下的中断向量表) 中一个表项占多少字节? 其中哪几位代表中断处理理代码的入口?
2. 请编程完善 kern/trap/trap.c 中对中断向量表进行初始化的函数 idt_init。在 idt_init 函数中，依次对所有中断入口进行初始化。使用 mmu.h 中的 SETGATE 宏，填充 idt 数组内容。每个中断的入口由 tools/vectors.c 生成，使用 trap.c 中声明的 vectors 数组即可。请在实验报告中描述 IDT_INIT 作用。
3. 请编程完善 trap.c 中的中断处理函数 trap，在对时钟中断进行处理的部分填写 trap 函数中处理时钟中断的部分，使操作系统每遇到 100 次时钟中断后，调用 print_ticks 子子程序，向屏幕上打印一行文字”100 ticks”。
4. 请大家用自己的语言在实验报告中描述中断过程，包括硬件 (CPU) 做的操作和操作系统做的操作。



1. 中断描述符表中的每一个表项均占8个字节

   其中最开始2个字节和最末尾2个字节定义了offset，第16-31位定义了处理代码入口地址的段选择子，使用其在GDT中查找到相应段的base address，加上offset就是中断处理代码的入口

   ![img](https://github.com/llx-08/imageBed/raw/master/asada.jpg)

2. 

```c
/* idt_init - initialize IDT to each of the entry points in kern/trap/vectors.S */
void idt_init(void) {
    extern uintptr_t __vectors[];

    for (int i = 0; i < 256; i++) {
        SETGATE(idt[i], 0, GD_KTEXT, __vectors[i], DPL_KERNEL);
    }

    lidt(&idt_pd);
}
```

idt_init作用：

首先声明vectors数组，该数组由vector.S定义，即可以跳转到中断处理的地址

SETGATE对idt数组进行初始化，最后使用lidt函数传给CPU IDT表的地址



3. 处理时钟中断代码

```c
void trap(struct trapframe *tf) {
    // dispatch based on what type of trap occurred
    trap_dispatch(tf);
}

/* trap_dispatch - dispatch based on what type of trap occurred */
static void trap_dispatch(struct trapframe *tf) {
    char c;

    switch (tf->tf_trapno) {
    case IRQ_OFFSET + IRQ_TIMER:
        ticks++;
        
        if (ticks % TICK_NUM == 0) {
            print_ticks();
        }

        break;
    }
}

```

运行结果

![img](https://raw.githubusercontent.com/llx-08/imageBed/master/tick.png)

4. CPU收到中断或者异常的信号时，它会暂停执行当前的程序或任务，通过一定的机制跳转到负责处理这个信号的相关处理程序中，在完成对这个信号的处理后再跳回到刚才被打断的程序或任务中。

   CPU每次执行完指令都会检查在执行指令过程中有无中断信号，如果有，CPU会读取中断向量，并根据得到的中断向量到IDT表里找到该向量对应的中断描述符，中断描述符里保存着中断服务程序的段选择符。段描述符里保存了中断服务程序的段基址和属性信息，此时CPU就得到了中断服务程序的起始地址。之后CPU开始利用栈保护被暂停执行的程序的现场

    CPU利用中断服务程序的段描述符将第一条指令的地址加载到cs和eip寄存器中，开始执行中断服务程序。之前执行的程序暂停，中断服务程序正式开始工作。

    在每个中断服务程序完成后会通过返回指令返回先前程序。程序执行这条返回指令时，会从栈里弹出先前保存的被暂停程序的现场信息，即eflags,cs,eip重新开始执行