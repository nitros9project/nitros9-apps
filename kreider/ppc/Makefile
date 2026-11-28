COMPILER ?= c3
ifneq ($(filter vbcc,$(MAKECMDGOALS)),)
COMPILER := vbcc
endif
ifeq ($(COMPILER),vbcc)
.DEFAULT_GOAL := all
.PHONY: all vbcc clean
all:
	python3 ../../build-support/vbcc.py --target ppc --install
vbcc: all
clean:
	python3 -c 'import shutil; shutil.rmtree("../../kreider/build/out/vbcc",ignore_errors=True)'
else
include $(NITROS9DIR)/rules.mak

CFLAGS += -y -q

all: ppc

ppc: ppc.c
	$(CC) $(CFLAGS) ppc.c -f=$@

clean:
	$(RM) ppc

endif
