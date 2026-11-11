* Makefile to compile MROFF

ODIR = /dd/cmds
RDIR = rels
RFILES = nromain.r nrotxt.r nromac.r nroio.r
CFLAGS = -s

mroff: $(RFILES)
 chd rels; cc $(RFILES) -f=$(ODIR)/Mroff -m=4k -e=11

nroio.r: nro.h nroio.c

nromac.r: nro.h nromac.c

nrotxt.r: nro.h nrotxt.c

nromain.r: nro.h nromain.c

* END

