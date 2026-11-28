COMPILER ?= c3
ifneq ($(filter vbcc,$(MAKECMDGOALS)),)
COMPILER := vbcc
endif
ifeq ($(COMPILER),vbcc)
.DEFAULT_GOAL := all
.PHONY: all vbcc clean
all:
	python3 ../../build-support/vbcc.py --target lb --install
vbcc: all
clean:
	python3 -c 'import shutil; shutil.rmtree("../../kreider/build/out/vbcc",ignore_errors=True)'
else
include $(NITROS9DIR)/rules.mak

CFLAGS += -y -q

all: lb

lb: lb.c
	$(CC) $(CFLAGS) lb.c -f=$@

clean:
	$(RM) lb

endif
