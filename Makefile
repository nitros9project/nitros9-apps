COMPILER ?= c3
ifneq ($(filter vbcc,$(MAKECMDGOALS)),)
COMPILER := vbcc
endif
ifeq ($(COMPILER),vbcc)
.DEFAULT_GOAL := all
.PHONY: all vbcc clean
all:
	python3 build-support/vbcc.py --target all
vbcc: all
clean:
	python3 -c 'from pathlib import Path; import shutil; [shutil.rmtree(p,ignore_errors=True) for p in Path(".").glob("*/build/out/vbcc")]'
else
ifndef NITROS9DIR
NITROS9DIR := $(abspath ../nitros9)
endif

NITROS9_APPS_DIR := $(CURDIR)

export NITROS9DIR
export NITROS9_APPS_DIR

include $(NITROS9DIR)/rules.mak

dirs = cpm deskmate3 ed kermit kreider mroff multivue os9l2bbs sled sort uemacs uucpbb viewgif

.PHONY: all clean

all:
	$(foreach dir,$(dirs),$(MAKE) -C $(dir) &&) :

clean:
	$(foreach dir,$(dirs),$(MAKE) -C $(dir) clean &&) :

endif
