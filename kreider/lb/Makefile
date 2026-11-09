include $(NITROS9DIR)/rules.mak

CFLAGS += -y -q

all: lb

lb: lb.c
	$(CC) $(CFLAGS) lb.c -f=$@

clean:
	$(RM) lb
