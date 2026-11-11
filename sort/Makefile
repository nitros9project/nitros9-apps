include $(NITROS9DIR)/rules.mak

CFLAGS += -y -q

RFILES = sort.r compare.r msort.r input.r runs.r merge.r

# c3 -r compiles x.c to x.r
%.r: %.c
	$(CC) $(CFLAGS) $< -r

all: sort

sort: $(RFILES)
	$(CC) $(RFILES) -f=$@

$(RFILES): sort.h

clean:
	$(RM) $(RFILES) sort
