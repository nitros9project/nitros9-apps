COMPILER ?= c3
ifneq ($(filter vbcc,$(MAKECMDGOALS)),)
COMPILER := vbcc
endif
ifeq ($(COMPILER),vbcc)
.DEFAULT_GOAL := all
.PHONY: all vbcc clean
all:
	python3 ../build-support/vbcc.py --package kreider --install
vbcc: all
clean:
	python3 -c 'import shutil; shutil.rmtree("../kreider/build/out/vbcc",ignore_errors=True)'
else
# Carl Kreider's public-domain C tools, cross-built with c3.
dirs = uniq cb ppc dgrep lb

.PHONY: all clean

all:
	$(foreach dir,$(dirs),$(MAKE) -C $(dir) &&) :

clean:
	$(foreach dir,$(dirs),$(MAKE) -C $(dir) clean &&) :

endif
