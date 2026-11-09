include $(NITROS9DIR)/rules.mak

CFLAGS += -y -q

all: uniq

uniq: uniq.c
	$(CC) $(CFLAGS) uniq.c -f=$@

clean:
	$(RM) uniq
