# All compilation uses the explicit cross-toolchain rules below.
.SUFFIXES:

C3ROOT ?= $(abspath ../../nitros9-languages/c3)
PREP := $(C3ROOT)/build/unix/prep/c3prep
COMP := $(C3ROOT)/build/unix/comp/c3comp
OPTX := $(C3ROOT)/build/unix/optx/c3optx
export C3BASE := $(C3ROOT)
export C3LW_HOME := $(C3ROOT)/lwbackend
export PATH := $(C3ROOT)/build/unix/prep:$(C3ROOT)/build/unix/comp:$(C3ROOT)/build/unix/optx:$(C3ROOT)/lwbackend:$(PATH)

.PHONY: all clean stage check-tools
all: build/walk

check-tools:
	@test -x "$(COMP)" -a -f "$(C3ROOT)/lwbackend/libc3.a" || { echo "Build c3 first: make -C $(C3ROOT) runtime"; exit 1; }

SUPPORT = $(addprefix $(C3ROOT)/lib/cgfx/,window.a text.a draw.a config.a status.a nobuffer.a) \
          $(addprefix $(C3ROOT)/lib/lib.a/,utime.a rand.a sleep.a)

build:
	mkdir -p $@

build/%.r: %.c | build check-tools
	$(PREP) -DOS9 -v=$(C3ROOT)/defs $< > build/$*.i
	$(COMP) build/$*.i > build/$*.s
	$(OPTX) < build/$*.s > build/$*.opt.s
	awk -f $(C3ROOT)/lwbackend/c3lw.awk build/$*.opt.s > build/$*.lw.s
	lwasm --format=obj -o $@ build/$*.lw.s

build/libsupport.a: cross-support.sh cross-defs.sed $(SUPPORT) $(C3ROOT)/lwbackend/c3lw.awk $(C3ROOT)/lwbackend/os9defs.sed | build check-tools
	C3ROOT="$(C3ROOT)" sh cross-support.sh

build/walk: build/walk.r build/walkoth.r build/gpbuf.r build/libsupport.a $(C3ROOT)/lwbackend/crt0.o $(C3ROOT)/lwbackend/fpdummy.o $(C3ROOT)/lwbackend/libc3.a $(C3ROOT)/lwbackend/libc3lw.a
	cd build && lwlink --format=os9 -s $(C3ROOT)/lwbackend/os9c3.ld -o walk $(C3ROOT)/lwbackend/crt0.o $(C3ROOT)/lwbackend/fpdummy.o walk.r walkoth.r gpbuf.r -L. -lsupport -L$(C3ROOT)/lwbackend -lc3 -lc3lw

stage: build/walk
	mkdir -p build/dist/CMDS build/dist/SYS
	cp build/walk build/dist/CMDS/walk
	cp sys/walk.ike build/dist/SYS/walk.ike

clean:
	rm -rf build cfg
	rm -f *.list *.map

# Private boot disk: the shared NitrOS-9 checkout supplies sources only.
NITROS9DIR ?= $(abspath ../../nitros9)
MAME ?= mame
MAME_ROM_PATH ?= $(HOME)/.local/share/mame/roms
MAME_FLAGS ?= -window -skip_gameinfo -ramsize 512k
EMUDIR = build/emulator
DISK = $(EMUDIR)/walk.dsk

.PHONY: disk run

disk: $(DISK)

$(DISK): build/walk sys/walk.ike run.startup Makefile
	mkdir -p $(EMUDIR)
	cp $(NITROS9DIR)/recipes/coco3/floppy/defsfile $(EMUDIR)/defsfile
	$(MAKE) -C $(EMUDIR) -f $(NITROS9DIR)/recipes/coco3/coco3.mak \
	    NITROS9DIR=$(NITROS9DIR) LEVEL=2 CPU=6809 TERM_COLS=40 \
	    CMDS="shell grfdrv utilpak1 load link echo merge" PORTDEFSDIR= \
	    STARTUP=$(CURDIR)/run.startup DSKIMAGE=walk.dsk all
	os9 copy -r build/walk $(DISK),CMDS/walk
	os9 attr -e -pe $(DISK),CMDS/walk
	os9 copy -r sys/walk.ike $(DISK),SYS/walk.ike

run: $(DISK)
	$(MAME) coco3 -rompath "$(MAME_ROM_PATH)" -cfg_directory "$(abspath build/mame-cfg)" -nvram_directory "$(abspath build/mame-nvram)" $(MAME_FLAGS) \
	    -ext fdc -ext:fdc:wd17xx:0 525qd -flop1 "$(abspath $(DISK))" \
	    -autoboot_delay 2 -autoboot_command "DOS\n"
