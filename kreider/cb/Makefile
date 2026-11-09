include $(NITROS9DIR)/rules.mak

CFLAGS += -y -q

all: cb

cb: cb.c
	$(CC) $(CFLAGS) cb.c -f=$@

clean:
	$(RM) cb
