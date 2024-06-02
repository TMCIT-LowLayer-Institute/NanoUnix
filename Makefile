K=sys/kern
U=user

OBJS = \
  $K/entry.o \
  $K/start.o \
  $K/console.o \
  $K/printf.o \
  $K/uart.o \
  $K/kalloc.o \
  $K/spinlock.o \
  $K/string.o \
  $K/main.o \
  $K/vm.o \
  $K/proc.o \
  $K/swtch.o \
  $K/trampoline.o \
  $K/trap.o \
  $K/syscall.o \
  $K/sysproc.o \
  $K/bio.o \
  $K/fs.o \
  $K/log.o \
  $K/sleeplock.o \
  $K/file.o \
  $K/pipe.o \
  $K/exec.o \
  $K/sysfile.o \
  $K/kernelvec.o \
  $K/plic.o \
  $K/virtio_disk.o
  $(LIBSA)
  $(STDLIB)

# riscv64-unknown-elf- or riscv64-linux-gnu-
# perhaps in /opt/riscv/bin
#TOOLPREFIX =

# Try to infer the correct TOOLPREFIX if not set
ifndef TOOLPREFIX
TOOLPREFIX := $(shell if riscv64-unknown-elf-objdump -i 2>&1 | grep 'elf64-big' >/dev/null 2>&1; \
	then echo 'riscv64-unknown-elf-'; \
	elif riscv64-linux-gnu-objdump -i 2>&1 | grep 'elf64-big' >/dev/null 2>&1; \
	then echo 'riscv64-linux-gnu-'; \
	elif riscv64-unknown-linux-gnu-objdump -i 2>&1 | grep 'elf64-big' >/dev/null 2>&1; \
	then echo 'riscv64-unknown-linux-gnu-'; \
	else echo "***" 1>&2; \
	echo "*** Error: Couldn't find a riscv64 version of GCC/binutils." 1>&2; \
	echo "*** To turn off this error, run 'gmake TOOLPREFIX= ...'." 1>&2; \
	echo "***" 1>&2; exit 1; fi)
endif

QEMU = qemu-system-riscv64

CC = $(TOOLPREFIX)gcc
AS = $(TOOLPREFIX)gas
LD = $(TOOLPREFIX)ld
OBJCOPY = $(TOOLPREFIX)objcopy
OBJDUMP = $(TOOLPREFIX)objdump

CFLAGS = -Wall -Werror -O2 -fno-omit-frame-pointer -ggdb -gdwarf-2 -std=c2x -I./include -I./ -I./sys -DKERNEL -D__POSIX_VISIBLE=200809 -D__XPG_VISIBLE=420 -Wno-attributes

CFLAGS += -MD
CFLAGS += -mcmodel=medany
CFLAGS += -ffreestanding -fno-common -nostdlib -mno-relax
CFLAGS += -I.
CFLAGS += $(shell $(CC) -fno-stack-protector -E -x c /dev/null >/dev/null 2>&1 && echo -fno-stack-protector)

# Disable PIE when possible (for Ubuntu 16.10 toolchain)
ifneq ($(shell $(CC) -dumpspecs 2>/dev/null | grep -e '[^f]no-pie'),)
CFLAGS += -fno-pie -no-pie
endif
ifneq ($(shell $(CC) -dumpspecs 2>/dev/null | grep -e '[^f]nopie'),)
CFLAGS += -fno-pie -nopie
endif

LDFLAGS = -z max-page-size=4096

# カーネルにリンクするライブラリの定義
KERN_LIBS = $(LIBSA) $(STDLIB) $(STRING) $(GEN) $(TEST)

# LIBSAのビルドルール
LIBSA_DIR = sys/lib/libsa
LIBSA_SRCS = $(wildcard $(LIBSA_DIR)/*.c)
LIBSA_OBJS = $(patsubst $(LIBSA_DIR)/%.c, $(LIBSA_DIR)/%.o, $(LIBSA_SRCS))

# STDLIBのビルドルール
STDLIB_DIR = lib/libc/stdlib
STDLIB_SRCS = $(wildcard $(STDLIB_DIR)/*.c)
STDLIB_OBJS = $(patsubst $(STDLIB_DIR)/%.c, $(STDLIB_DIR)/%.o, $(STDLIB_SRCS))

# STRINGのビルドルール
STRING_DIR = lib/libc/string
STRING_SRCS = $(wildcard $(STRING_DIR)/*.c)
STRING_OBJS = $(patsubst $(STRING_DIR)/%.c, $(STRING_DIR)/%.o, $(STRING_SRCS))

# GENのビルドルール
GEN_DIR = lib/libc/gen
GEN_SRCS = $(wildcard $(GEN_DIR)/*.c)
GEN_OBJS = $(patsubst $(GEN_DIR)/%.c, $(GEN_DIR)/%.o, $(GEN_SRCS))

# LIBSA_OBJSをソースからオブジェクトに変換するルールの作成。
$(LIBSA_DIR)/%.o: $(LIBSA_DIR)/%.c
	@echo "\033[0;32mCompiling $< for LIBSA\033[0m"
	$(CC) $(CFLAGS) -Wno-attributes -c $< -o $@

# LIBSAターゲットの作成とLIBSA_OBJSスタティックライブラリの生成。
LIBSA = $(LIBSA_DIR)/libsa.a
$(LIBSA): $(LIBSA_OBJS)
	@echo "\033[0;34mCreating $@ library\033[0m"
	$(AR) rcs $@ $^

# STDLIB_OBJSをソースからオブジェクトに変換するルールを作成。
$(STDLIB_DIR)/%.o: $(STDLIB_DIR)/%.c
	@echo "\033[0;32mCompiling $< for STDLIB\033[0m"
	$(CC) $(CFLAGS) -Wno-attributes -c $< -o $@

# STDLIBターゲットを作り、STDLIB_OBJSからスタティックライブラリを生成。
STDLIB = $(STDLIB_DIR)/stdlib.a
$(STDLIB): $(STDLIB_OBJS)
	@echo "\033[0;34mCreating $@ library\033[0m"
	$(AR) rcs $@ $^

# STRING_OBJSをソースからオブジェクトに変換するルールを作成。
$(STRING_DIR)/%.o: $(STRING_DIR)/%.c
	@echo "\033[0;32mCompiling $< for STRING\033[0m"
	$(CC) $(CFLAGS) -Wno-attributes -c $< -o $@

# STRINGターゲットを作り、STRING_OBJSからスタティックライブラリを生成。
STRING = $(STRING_DIR)/string.a
$(STRING): $(STRING_OBJS)
	@echo "\033[0;34mCreating $@ library\033[0m"
	$(AR) rcs $@ $^

# GEN_OBJSをソースからオブジェクトに変換するルールの作成。
$(GEN_DIR)/%.o: $(GEN_DIR)/%.c
	@echo "\033[0;32mCompiling $< for GEN\033[0m"
	$(CC) $(CFLAGS) -Wno-attributes -c $< -o $@

# GENターゲットを作り、GEN_OBJSからスタティックライブラリを生成。
GEN = $(GEN_DIR)/gen.a
$(GEN): $(GEN_OBJS)
	@echo "\033[0;34mCreating $@ library\033[0m"
	$(AR) rcs $@ $^

#### アセンブリ #####
# STCHのビルドルール
STCH_DIR = lib/libc/stch/riscv64/sys
STCH_SRCS = $(wildcard $(STCH_DIR)/*.S)
STCH_OBJS = $(patsubst $(STCH_DIR)/%.S, $(STCH_DIR)/%.o, $(STCH_SRCS))

# STCH_OBJSをアセンブリからオブジェクトに変換するルールの作成。
$(STCH_DIR)/%.o: $(STCH_DIR)/%.S
	@echo "\033[0;32mAssembling $< for STCH\033[0m"
	$(AS) $(ASFLAGS) $< -o $@

# STCHターゲットを作り、STCH_OBJSからスタティックライブラリを生成。
STCH = $(STCH_DIR)/stch.a
$(STCH): $(STCH_OBJS)
	@echo "\033[0;34mCreating $@ library\033[0m"
	$(AR) rcs $@ $^

#### ZIG #####
# zigディレクトリのビルドルール
TEST_DIR = zig
ZIG_SRCS = $(wildcard $(TEST_DIR)/*.zig)
TEST = $(TEST_DIR)/libtest.a

# ZIG のソースファイルを静的ライブラリにビルド
$(TEST_DIR)/libtest.a: $(ZIG_SRCS)
	zig build-lib -static -fPIC -fcompiler-rt -O ReleaseSafe -target riscv64-freestanding  -isystem ./zig -I./ -I./sys $(ZIG_SRCS) ./zig/test.h
	@mv libtest.a $(TEST_DIR)

UZLIB_SRCS = $(wildcard user/*.zig)
UZLIB_OBJS = $(patsubst user/%.zig, $U/%.zig.o, $(notdir $(UZLIB_SRCS)))

$U/%.zig.o: user/%.zig
	@echo "\033[0;32mCompiling $< (Zig)\033[0m"
	zig build-obj -fno-stack-protector -fno-lto -O ReleaseFast -target riscv64-freestanding -isystem ./ -I ./sys $< --name poweroff.zig
	@mv poweroff.zig.o user

$U/_poweroff: $U/poweroff.zig.o $(ULIB) $(TEST_DIR)/libtest.a
	$(LD) $(LDFLAGS) -T $U/user.ld -o $@ $^
	$(OBJDUMP) -S $@ > $*.asm
	$(OBJDUMP) -t $@ | sed '1,/SYMBOL TABLE/d; s/ .* / /; /^$$/d' > $*.sym

$K/kernel: $(OBJS) $(KERN_LIBS) $K/kernel.ld $U/initcode
	$(LD) $(LDFLAGS) -T $K/kernel.ld -o $K/kernel $(OBJS) $(KERN_LIBS)
	$(OBJDUMP) -S $K/kernel > $K/kernel.asm
	$(OBJDUMP) -t $K/kernel | sed '1,/SYMBOL TABLE/d; s/ .*/ /; /^$$/d' > $K/kernel.sym

$U/initcode: $U/initcode.S
	$(CC) $(CFLAGS) -march=rv64g -nostdinc -I. -Ikernel -c $U/initcode.S -o $U/initcode.o
	$(LD) $(LDFLAGS) -N -e start -Ttext 0 -o $U/initcode.out $U/initcode.o
	$(OBJCOPY) -S -O binary $U/initcode.out $U/initcode
	$(OBJDUMP) -S $U/initcode.o > $U/initcode.asm

tags: $(OBJS) _init
	etags *.S *.c

ULIB = $U/ulib.o $U/usys.o $U/printf.o $U/umalloc.o

_%: %.o $(ULIB) $(TEST_DIR)/libtest.a
	$(LD) $(LDFLAGS) -T $U/user.ld -o $@ $^
	$(OBJDUMP) -S $@ > $*.asm
	$(OBJDUMP) -t $@ | sed '1,/SYMBOL TABLE/d; s/ .* / /; /^$$/d' > $*.sym

$U/usys.S : $U/usys.pl
	perl $U/usys.pl > $U/usys.S

$U/usys.o : $U/usys.S
	$(CC) $(CFLAGS) -c -o $U/usys.o $U/usys.S

$U/_forktest: $U/forktest.o $(ULIB)
	# forktest has less library code linked in - needs to be small
	# in order to be able to max out the proc table.
	$(LD) $(LDFLAGS) -N -e main -Ttext 0 -o $U/_forktest $U/forktest.o $U/ulib.o $U/usys.o
	$(OBJDUMP) -S $U/_forktest > $U/forktest.asm

#mkfs/mkfs: mkfs/mkfs.c $K/fs.h $K/param.h
#	/usr/local/bin/clang -Werror -Wall -I. -o mkfs/mkfs mkfs/mkfs.c -std=c23
# Makefile
# Directories to search for clang
UNAME_S := $(shell uname -s)
UNAME_M := $(shell uname -m)

ifeq ($(UNAME_S),Darwin)
    ifeq ($(UNAME_M),x86_64)
        # Intel Mac用の設定
        MKFS_CC_PATH := $(shell ./find_clang)
    else
        # Apple Silicon Mac用の設定
        MKFS_CC_PATH := $(shell ./find_clang_apple_silicon)
    endif
else
    # Linux用の設定
    MKFS_CC_PATH := $(shell ./find_clang_linux)
endif

# find_clangの出力を判定し、見つからない場合はデフォルトのパスを設定
MKFS_CC := $(shell { ./find_clang || echo "gcc-13"; })
MKFS_CFLAGS := -Werror -Wall -std=c23

mkfs/mkfs: mkfs/mkfs.c $K/fs.h $K/param.h
	cc $(MKFS_CFLAGS) -o mkfs/mkfs mkfs/mkfs.c

# Prevent deletion of intermediate files, e.g. cat.o, after first build, so
# that disk image changes after first build are persistent until clean.  More
# details:
# http://www.gnu.org/software/make/manual/html_node/Chained-Rules.html
.PRECIOUS: %.o

UPROGS=\
	$U/_cat\
	$U/_echo\
	$U/_forktest\
	$U/_grep\
	$U/_init\
	$U/_kill\
	$U/_ln\
	$U/_ls\
	$U/_mkdir\
	$U/_rm\
	$U/_sh\
	$U/_stressfs\
	$U/_usertests\
	$U/_grind\
	$U/_wc\
	$U/_zombie\
	$U/_test\
#	$U/_poweroff\

fs.img: mkfs/mkfs README $(UPROGS) include
	mkfs/mkfs fs.img README $(UPROGS) include

-include kernel/*.d user/*.d

clean:
	rm -f *.tex *.dvi *.idx *.aux *.log *.ind *.ilg \
	*/*.o */*.d */*.asm */*.sym \
	$U/initcode $U/initcode.out $K/kernel fs.img \
	mkfs/mkfs .gdbinit \
        $U/usys.S \
	$(UPROGS) \
	&& find . -type f \( -name '*.a' -o -name '*.o' -o -name '*.d' -o -name '*.asm' \) -delete

#	$(LIBSA_DIR)/*.d $(LIBSA_DIR)/*.o $(LIBSA_DIR)/*.a \
#	$(STDLIB_DIR)/*.d $(STDLIB_DIR)/*.o $(STDLIB_DIR)/*.a \
#	$(STRING_DIR)/*.d $(STRING_DIR)/*.o $(STRING_DIR)/*.a \
#	$(GEN_DIR)/*.d $(GEN_DIR)/*.o  $(GEN_DIR)/*.a \

# try to generate a unique GDB port
GDBPORT = $(shell expr `id -u` % 5000 + 25000)
# QEMU's gdb stub command line changed in 0.11
QEMUGDB = $(shell if $(QEMU) -help | grep -q '^-gdb'; \
	then echo "-gdb tcp::$(GDBPORT)"; \
	else echo "-s -p $(GDBPORT)"; fi)
ifndef CPUS
CPUS := 1
endif

QEMUOPTS = -machine virt -bios none -kernel $K/kernel -m 128M -smp $(CPUS) -nographic
QEMUOPTS += -global virtio-mmio.force-legacy=false
QEMUOPTS += -drive file=fs.img,if=none,format=raw,id=x0
QEMUOPTS += -device virtio-blk-device,drive=x0,bus=virtio-mmio-bus.0

qemu: $K/kernel fs.img
	$(QEMU) $(QEMUOPTS)

.gdbinit: .gdbinit.tmpl-riscv
	sed "s/:1234/:$(GDBPORT)/" < $^ > $@

qemu-gdb: $K/kernel .gdbinit fs.img
	@echo "*** Now run 'gdb' in another window." 1>&2
	$(QEMU) $(QEMUOPTS) -S $(QEMUGDB)  
