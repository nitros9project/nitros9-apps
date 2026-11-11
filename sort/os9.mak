* sort's makefile for OS-9/6809, built on the target with make and cc1,
* which writes sort to the execution directory.
CC     = cc1
CFLAGS = -dLEVEL2

RFILES = sort.r compare.r msort.r input.r runs.r merge.r

sort: $(RFILES)
        cc1 $(RFILES) -f=sort

$(RFILES): sort.h
