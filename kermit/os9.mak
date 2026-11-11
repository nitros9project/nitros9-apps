* Kermit's makefile for OS-9/6809, built on the Pico-Thing with make
* and cc1. Kermit calls _gs_rdy, _gs_opt, _ss_opt, _ss_rel and _ss_ssig,
* which are in KLibc rather than the Microware library, so build KLibc
* in ../KLIBC first. cc1 always links the Microware library, so Kermit
* is linked with rlink, which writes it to the execution directory.
* LEVEL2 makes time.h's tps 100: without it tps is 10, and Kermit's
* 10-second timeouts last two seconds at the Pico-Thing's 50 ticks.
CC     = cc1
PROG   = kermit
ODIR   = /dd/cmds
CDEFS  = -dCOCO -dLEVEL2
CFLAGS = -r $(CDEFS)

HEADERS = os9inc.h

FILES = os9cli.r os9cmd.r os9con.r os9ker.r \
        os9rec.r os9sen.r os9srv.r os9utl.r

SRC = os9cli.c os9cmd.c os9con.c os9ker.c \
      os9rec.c os9sen.c os9srv.c os9utl.c

$(ODIR)/$(PROG): $(FILES)
        rlink ../KLIBC/sys.a/rels/cstart.r $(FILES) -l=../KLIBC/clib.l -l=/dd/lib/sys.l -M=1k -o=$(PROG)

$(FILES):  $(HEADERS)

date.list: $(HEADERS) $(SRC)
        pr -p96 -h1 -r90 -n $? ! spl
        touch date.list
