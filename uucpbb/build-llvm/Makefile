OPT ?= Os
TARGET ?= all
JOBS ?= 8
PYTHON ?= python3
.DEFAULT_GOAL := build
.PHONY: build sizes targets test
build:
	$(PYTHON) build.py build --opt $(OPT) --target $(TARGET) --jobs $(JOBS)
sizes:
	$(PYTHON) build.py sizes
targets:
	$(PYTHON) build.py targets

test:
	$(PYTHON) tests/test_compat.py
