include $(NITROS9DIR)/rules.mak

CFLAGS += -y -q

RFILES = nromain.r nrotxt.r nromac.r nroio.r

# c3 -r compiles x.c to x.r
%.r: %.c
	$(CC) $(CFLAGS) $< -r

all: mroff

mroff: $(RFILES)
	$(CC) $(RFILES) -f=$@ -m=4k

$(RFILES): nro.h

clean:
	$(RM) $(RFILES) mroff
