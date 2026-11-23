include $(NITROS9DIR)/rules.mak

CFLAGS += -y -q -dCOCO

RFILES = os9cli.r os9cmd.r os9con.r os9ker.r os9rec.r os9sen.r os9srv.r os9utl.r

# c3 -r compiles x.c to x.r
%.r: %.c
	$(CC) $(CFLAGS) $< -r

all: kermit

kermit: $(RFILES)
	$(CC) $(RFILES) -f=$@ -m=1k

$(RFILES): os9inc.h

clean:
	$(RM) $(RFILES) kermit
