.DEFAULT_GOAL := all
COMPILER ?= c3
OPT ?= Os
JOBS ?= 8
PYTHON ?= python3
.PHONY: all c3 cmoc llvm test clean
all:
	$(PYTHON) build/build.py --compiler $(COMPILER) --opt $(OPT) --jobs $(JOBS)
	cp build/out/$(COMPILER)/$(OPT)/sled sled
c3 cmoc llvm:
	$(MAKE) all COMPILER=$@
# Supply BOOT, ROMS, MAME and OS9 for the interactive emulator test.
test: all
	$(PYTHON) tests/interactive.py --boot "$(BOOT)" --roms "$(ROMS)" --mame "$(MAME)" --os9 "$(OS9)" --module build/out/$(COMPILER)/$(OPT)/sled
clean:
	$(PYTHON) -c 'import pathlib,shutil; shutil.rmtree("build/out",ignore_errors=True); pathlib.Path("sled").unlink(missing_ok=True)'
