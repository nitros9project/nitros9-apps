include $(NITROS9DIR)/rules.mak

CFLAGS += -y -q

all: man

man: man.c
	$(CC) $(CFLAGS) man.c -f=$@

clean:
	$(RM) man
