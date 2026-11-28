COMPILER ?= c3
ifneq ($(filter vbcc,$(MAKECMDGOALS)),)
COMPILER := vbcc
endif
ifeq ($(COMPILER),vbcc)
.DEFAULT_GOAL := all
.PHONY: all vbcc clean
all:
	python3 ../../build-support/vbcc.py --target mroff --install
vbcc: all
clean:
	python3 -c 'import shutil; shutil.rmtree("../../mroff/build/out/vbcc",ignore_errors=True)'
else
include $(NITROS9DIR)/rules.mak

CFLAGS += -y -q

RFILES = nromain.r nrotxt.r nromac.r nroio.r

# c3 -r compiles x.c to x.r
%.r: %.c
	$(CC) $(CFLAGS) $< -r

all: mroff

mroff: $(RFILES)
	$(CC) $(RFILES) -f=$@ -m=4k

$(RFILES): nro.h

clean:
	$(RM) $(RFILES) mroff

endif
