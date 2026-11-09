include $(NITROS9DIR)/rules.mak

CFLAGS += -y -q

all: ppc

ppc: ppc.c
	$(CC) $(CFLAGS) ppc.c -f=$@

clean:
	$(RM) ppc
