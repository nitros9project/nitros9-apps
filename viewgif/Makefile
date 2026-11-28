.DEFAULT_GOAL := all
COMPILER ?= c3
OPT ?= Os
JOBS ?= 8
PYTHON ?= python3
HOST_CC ?= cc
export HOST_CC
.PHONY: all viewgif viewvef c3 cmoc llvm test clean
all: viewgif viewvef
viewgif:
	rm -f viewgif viewvef
	$(PYTHON) build/build.py --compiler $(COMPILER) --opt $(OPT) --jobs $(JOBS)
	cp build/out/$(COMPILER)/$(OPT)/viewgif viewgif
	cp build/out/$(COMPILER)/$(OPT)/viewvef viewvef
viewvef: viewgif
c3 cmoc llvm:
	$(MAKE) all COMPILER=$@
test:
	$(PYTHON) tests/test_decode.py
clean:
	rm -rf build/out build/graphics
	rm -f viewgif viewvef
