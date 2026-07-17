include $(NITROS9DIR)/rules.mak

# DeskMate 3 is original 6809 code. In particular, dmpaint uses RESET as a
# label, which is only an instruction mnemonic in 6309 mode.
AS := $(subst --6309,--6809,$(AS))

DSK	= DeskMate3.dsk

CD	= $(LEVEL2)/coco3/cmds
MD	= $(LEVEL2)/coco3/modules

UTILS	= $(CD)/shell $(CD)/format $(CD)/rename
SYSGO	= $(MD)/sysgo_dd
CMDS	= accdata autoex desk dmalt dmapps dmbackup dmcaln dmcards dmdskini \
	dmhelp dmledger dmload dmmenu dmpaint dmterm dmtext dmtim
HELP	= dmalt.hlp dmcaln.hlp dmcards.hlp dmledger.hlp dmmenu.hlp \
	dmpaint.hlp dmterm.hlp dmtext.hlp
ROOTFILES	= Sample.fil

KERNEL	= $(MD)/rel_32 $(MD)/boot_1773_6ms $(MD)/krn

OS9BOOT	= $(MD)/krnp2 $(MD)/ioman $(MD)/init \
		$(MD)/rbf.mn \
		$(MD)/rb1773.dr $(MD)/ddd0_40d.dd \
		$(MD)/d0_40d.dd $(MD)/d1_40d.dd $(MD)/d2_40d.dd \
		$(MD)/scf.mn $(MD)/vtio.dr $(MD)/co3hires.sb \
		$(MD)/joydrv_joy.sb $(MD)/snddrv_cc3.sb \
		$(MD)/covdg.io $(MD)/term_vdg.dt \
		$(MD)/sc6551.dr $(MD)/t2_sc6551.dd \
		$(MD)/clock_60hz $(MD)/clock2_soft

.PHONY: all dependencies clean

all: $(DSK)

dependencies:
	$(MAKE) -C $(MD) $(notdir $(KERNEL) $(OS9BOOT) $(SYSGO))
	$(MAKE) -C $(CD) $(notdir $(UTILS))

clean:
	$(RM) os9boot kernel $(DSK) *.list *.map

$(DSK): $(CMDS) $(HELP) $(ROOTFILES) | dependencies
	$(RM) $@
	$(OS9FORMAT_DS40) $@ -q -n"DeskMate 3"
	$(MERGE) $(OS9BOOT)>os9boot
	$(MERGE) $(KERNEL)>kernel
	$(OS9GEN) $@ -b=os9boot -t=kernel
	$(RM) os9boot kernel
	$(OS9COPY) $(SYSGO) $@,sysgo
	$(OS9ATTR_EXEC) $@,sysgo
	$(MAKDIR) $@,CMDS
	$(OS9COPY) $(UTILS) $@,CMDS
	$(OS9ATTR_EXEC) $(foreach file,$(notdir $(UTILS)),$@,CMDS/$(file))
	$(OS9COPY) $(CMDS) $@,CMDS
	$(OS9ATTR_EXEC) $(foreach file,$(notdir $(CMDS)),$@,CMDS/$(file))
	$(CPL) $(HELP) $@,CMDS
	$(OS9ATTR_EXEC) $(foreach file,$(notdir $(HELP)),$@,CMDS/$(file))
	$(OS9COPY) $(ROOTFILES) $@,.
	$(OS9ATTR_TEXT) $(foreach file,$(ROOTFILES),$@,$(file))
