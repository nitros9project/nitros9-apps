COMPILER ?= c3
ifneq ($(filter vbcc,$(MAKECMDGOALS)),)
COMPILER := vbcc
endif
ifeq ($(COMPILER),vbcc)
.DEFAULT_GOAL := all
.PHONY: all vbcc clean
all:
	python3 ../build-support/vbcc.py --package mroff --install
vbcc: all
clean:
	python3 -c 'import shutil; shutil.rmtree("../mroff/build/out/vbcc",ignore_errors=True)'
else
# Mark Griffith's mroff and man, cross-built with c3.
dirs = mroff man

.PHONY: all clean

all:
	$(foreach dir,$(dirs),$(MAKE) -C $(dir) &&) :

clean:
	$(foreach dir,$(dirs),$(MAKE) -C $(dir) clean &&) :

endif
