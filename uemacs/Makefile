#  makefile for Micro emacs for os9/68000
# temp files on ram disk
include $(NITROS9DIR)/rules.mak

CC	= c3

CFLAGS += -y -q -dOS9 -dANSI

MAINR  = uemain1.r uemain2.r uemain3.r uemain4.r uemaintable.r
DISPR  = uedisplay1.r uedisplay2.r uedisplay3.r
RESTR  = uebasic.r uebuffer1.r uebuffer2.r uefile1.r uefile2.r uefileio.r \
  ueline1.r ueline2.r uerandom1.r uerandom2.r ueregion.r uesearch.r uespawn.r \
  uetermio.r uewindow.r ueword.r
RFILES = $(MAINR) $(DISPR) $(RESTR)

# c3 -r compiles x.c to x.r
%.r: %.c
	$(CC) $(CFLAGS) $< -r

# Two programs that differ only in their terminal back end: umacs for an ANSI
# terminal, umacsc for the CoCo control codes.
all: umacs umacsc
	@$(ECHO) "**************************************************"
	@$(ECHO) "*                                                *"
	@$(ECHO) "*                OS-9 LEVEL 2 uEmacs             *"
	@$(ECHO) "*                                                *"
	@$(ECHO) "**************************************************"

# use cio libarary
umacs: $(RFILES) ueansi.r
	$(CC) -i $(RFILES) ueansi.r -f=$@

umacsc: $(RFILES) uecoco.r
	$(CC) -i $(RFILES) uecoco.r -f=$@

$(MAINR): ueed.h uemain.h
$(DISPR): ueed.h uedisplay.h
$(RESTR) ueansi.r uecoco.r: ueed.h

clean:
	$(RM) $(RFILES) ueansi.r uecoco.r umacs umacsc
