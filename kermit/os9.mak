PROG   = kermit
ODIR   = /dd/cmds
CDEFS  = -dCOCO
CFLAGS = -r $(CDEFS)

HEADERS = os9inc.h

FILES = os9cli.r os9cmd.r os9con.r os9ker.r \
        os9rec.r os9sen.r os9srv.r os9utl.r

SRC = os9cli.c os9cmd.c os9con.c os9ker.c \
      os9rec.c os9sen.c os9srv.c os9utl.c

$(ODIR)/$(PROG): $(FILES)
        cc $(FILES) -f=$(ODIR)/$(PROG) -m=1k

$(FILES):  $(HEADERS)

date.list: $(HEADERS) $(SRC)
        pr -p96 -h1 -r90 -n $? ! spl
        touch date.list
