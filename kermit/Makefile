.DEFAULT_GOAL := all
COMPILER ?= c3
OPT ?= Os
TICKS ?= 60
JOBS ?= 8
PYTHON ?= python3
HOST_CC ?= cc

.PHONY: all kermit c3 cmoc llvm vbcc test clean
all: kermit
kermit:
	rm -f kermit
	$(PYTHON) build/build.py --compiler $(COMPILER) --opt $(OPT) --ticks $(TICKS) --jobs $(JOBS)
	cp build/out/$(COMPILER)/$(OPT)/kermit kermit
c3 cmoc llvm vbcc:
	$(MAKE) kermit COMPILER=$@
test:
	mkdir -p build/out/tests
	$(HOST_CC) -std=c99 -Wall -Wextra -Werror -I. message.c tests/message_test.c -o build/out/tests/message_test
	build/out/tests/message_test
clean:
	rm -rf build/out
	rm -f *.r *.o *.list *.map kermit
