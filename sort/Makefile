COMPILER ?= c3
ifneq ($(filter vbcc,$(MAKECMDGOALS)),)
COMPILER := vbcc
endif
ifeq ($(COMPILER),vbcc)
.DEFAULT_GOAL := all
.PHONY: all vbcc clean
all:
	python3 ../build-support/vbcc.py --package sort --install
vbcc: all
clean:
	python3 -c 'import shutil; shutil.rmtree("../sort/build/out/vbcc",ignore_errors=True)'
else
include $(NITROS9DIR)/rules.mak

CFLAGS += -y -q

RFILES = sort.r compare.r msort.r input.r runs.r merge.r

# c3 -r compiles x.c to x.r
%.r: %.c
	$(CC) $(CFLAGS) $< -r

all: sort

sort: $(RFILES)
	$(CC) $(RFILES) -f=$@

$(RFILES): sort.h

clean:
	$(RM) $(RFILES) sort

endif
