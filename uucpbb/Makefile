# Source builds. The C compilers all produce OS-9/6809 modules usable on a 6309.
.DEFAULT_GOAL := all
COMPILER ?= c3
TARGET ?= all
OPT ?= Os
JOBS ?= 8
PYTHON ?= python3
C3BASE ?= $(abspath ../../nitros9-languages/c3)
CMOC_OS9_DIR ?= $(abspath ../../nitros9-c-libs)
NITROS9DIR ?= $(abspath ../../nitros9)
export C3BASE CMOC_OS9_DIR NITROS9DIR

ifneq ($(filter $(COMPILER),c3 cmoc llvm vbcc),$(COMPILER))
$(error COMPILER must be c3, cmoc, llvm, or vbcc)
endif

ifeq ($(COMPILER),llvm)
OUT = build-llvm/out/$(OPT)
else ifeq ($(COMPILER),vbcc)
OUT = build/out/vbcc/Os
else
OUT = build/out/$(COMPILER)
endif

COMMANDS = adduser chown cnvrtmail dotilde expire fileserv fixtext login mailx \
           postnews readnews rmail rnews subscribe unsubscribe uucico uuclean \
           uucp uudecode uuencode uulog uuname uuxqt whoami
CONFIG = Devices FileServ.help Systems bin.list Dialers Parameters active distributions
DOCS = adduser.man aliases.doc chown.man cnvrtmail.man fileserv.man fixtext.man \
       login.man mailrc.doc mailx.man parameters.doc postnews.man profile.doc \
       readnews.man rmail.man rnews.man signature.doc subscribe.man uucico.man \
       uuclean.man uucp.man uucpbb.doc uulog.man uuxqt.man whoami.man
DISKS = uucpbb21_6809.dsk uucpbb21_6309.dsk

.PHONY: all commands components c3 cmoc llvm vbcc dsk clean dskcopy info
all: dsk
commands:
	$(PYTHON) build/build.py --compiler $(COMPILER) --target $(TARGET) --opt $(OPT) --jobs $(JOBS)
components: commands
c3 cmoc llvm vbcc:
	$(MAKE) commands COMPILER=$@

# Keep the historical disk target names, but rebuild from the selected compiler
# every time: an image must not silently contain a previous compiler's output.
dsk: commands
	@test "$(TARGET)" = all || { echo 'Disk builds require TARGET=all'; exit 1; }
	$(MAKE) --no-print-directory package

# NitrOS-9 disk tools and assembler rules are needed only for packaging.
ifneq ($(filter package dskcopy,$(MAKECMDGOALS)),)
include $(NITROS9DIR)/rules.mak
.PHONY: package
package: $(OUT)/uumon
	@set -e; for disk in $(DISKS); do \
	  $(RM) "$$disk"; \
	  $(OS9FORMAT) -l10000 "$$disk" -q -n"UUCPbb 2.1 $(COMPILER)"; \
	  for dir in LOG UUCP UUCP/CMDS_WIN UUCP/DOC UUCP/SPOOL \
	    UUCP/SPOOL/MAIL UUCP/SPOOL/NEWS UUCP/SPOOL/UUCP \
	    UUCP/SPOOL/UUCP/REDHAT UUCP/SPOOL/UUCPPUBLIC UUCP/SPOOL/REDHAT \
	    SYS SYS/UUCP; do $(MAKDIR) "$$disk,$$dir"; done; \
	  (cd sample_config && $(CPL) $(CONFIG) "../$$disk,SYS/UUCP"); \
	  $(CPL) profile "$$disk,SYS"; \
	  (cd $(OUT) && $(OS9COPY) $(COMMANDS) uumon "$(CURDIR)/$$disk,UUCP/CMDS_WIN"); \
	  for cmd in $(COMMANDS) uumon; do $(OS9ATTR_EXEC) "$$disk,UUCP/CMDS_WIN/$$cmd"; done; \
	  (cd doc && $(CPL) $(DOCS) "../$$disk,UUCP/DOC"); \
	  $(CPL) copying README.md "$$disk,UUCP"; \
	done

$(OUT)/uumon: native/uumon.asm native/defsfile
	@mkdir -p $(OUT)
	$(AS) $(ASOUT)$@ $(AFLAGS) -I$(NITROS9DIR)/defs -Inative native/uumon.asm
endif

dskcopy: dsk
	cp $(DISKS) $(DSKDIR)
clean:
	rm -rf build/out build-llvm/out
	rm -f $(DISKS) build-llvm/results.csv
info:
	@echo "UUCPbb 2.1: COMPILER=$(COMPILER), output=$(OUT)"
