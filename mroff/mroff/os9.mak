* Makefile to compile MROFF
*
*  built on the Pico-Thing with make and cc1.  mroff calls skipbl,
*  skipwd and memset, which are in KLibc rather than the Microware
*  library, so build KLibc in ../KLIBC first.  cc1 always links the
*  Microware library, so mroff is linked with rlink, which writes it to
*  the execution directory and cuts a -l path at 15 characters.  cc1 -r
*  leaves each .r here.

CC = cc1
RFILES = nromain.r nrotxt.r nromac.r nroio.r
CFLAGS = -s

mroff: $(RFILES)
 rlink ../KLIBC/sys.a/rels/cstart.r $(RFILES) -l=../KLIBC/clib.l -l=/dd/lib/sys.l -M=4k -e=11 -o=mroff

nroio.r: nro.h nroio.c

nromac.r: nro.h nromac.c

nrotxt.r: nro.h nrotxt.c

nromain.r: nro.h nromain.c

* END
