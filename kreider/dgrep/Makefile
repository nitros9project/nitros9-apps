include $(NITROS9DIR)/rules.mak

CFLAGS += -y -q

all: dgrep

dgrep: grep.c grep.h
	$(CC) $(CFLAGS) grep.c -f=$@

clean:
	$(RM) dgrep
