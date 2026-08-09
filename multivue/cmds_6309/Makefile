include $(NITROS9DIR)/rules.mak

vpath %.asm ../cmds_6809

#AFLAGS		+= -e
DEPENDS		= ./Makefile

OSCMDS_DIR	= ../.nitros9-6309/.mods
OSCMDS		= $(addprefix $(OSCMDS_DIR)/,shell utilpak1 grfdrv backup format free help)
CMDS		= gshell cocopr control demo fstat \
		gcal gcalc gclock gport gprint gsort

ALLOBJS		= $(OSCMDS) $(CMDS)

all:	dependencies $(CMDS)

.PHONY: dependencies

dependencies:
	$(MAKE) -C .. dependencies

gshell: gshell.asm
	$(AS) $(ASOUT)$@ $< $(AFLAGS)

clean:
	$(RM) $(CMDS) *.list *.map

showobjs:
	@$(ECHO) $(ALLOBJS)

identify:
	$(IDENT_SHORT) $(ALLOBJS)
