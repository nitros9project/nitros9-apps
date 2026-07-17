include $(NITROS9DIR)/rules.mak

DSK68_FLOPPY	= MultiVue_6809.dsk
DSK63_FLOPPY	= MultiVue_6309.dsk

CMDS68	= $(shell $(MAKE) -C cmds_6809 --no-print-directory showobjs)
CMDS63	= $(shell $(MAKE) -C cmds_6309 --no-print-directory showobjs)
ICONS	= icon.demo
SYSBIN	= $(shell $(MAKE) -C sys --no-print-directory showbinobjs)
SYSTEXT	= $(shell $(MAKE) -C sys --no-print-directory showtextobjs)
DEMO	= aif.dmo
ROOTFILES = startup

DSKS	= $(DSK68_FLOPPY) $(DSK63_FLOPPY)

MD68	= $(LEVEL2)/coco3/modules
MD63	= $(LEVEL2)/coco3_6309/modules

KERNEL68_FLOPPY	= $(MD68)/rel_40 $(MD68)/boot_1773_6ms $(MD68)/krn
KERNEL63_FLOPPY	= $(MD63)/rel_40 $(MD63)/boot_1773_6ms $(MD63)/krn

BOOTFILE68_FLOPPY	= $(MD68)/krnp2 $(MD68)/ioman $(MD68)/init \
		$(MD68)/rbf.mn \
		$(MD68)/rb1773.dr $(MD68)/ddd0_40d.dd \
		$(MD68)/d0_40d.dd $(MD68)/d1_40d.dd \
		$(MD68)/scf.mn $(MD68)/vtio.dr \
		$(MD68)/joydrv_joy.sb $(MD68)/snddrv_cc3.sb \
		$(MD68)/cowin.io $(MD68)/term_win40.dt \
		$(MD68)/w.dw $(MD68)/w1.dw $(MD68)/w2.dw $(MD68)/w3.dw \
		$(MD68)/w4.dw $(MD68)/w5.dw $(MD68)/w6.dw $(MD68)/w7.dw \
		$(MD68)/clock_60hz $(MD68)/clock2_soft \
		$(MD68)/sysgo_dd

BOOTFILE63_FLOPPY	= $(MD63)/krnp2 $(MD63)/ioman $(MD63)/init \
		$(MD63)/rbf.mn \
		$(MD63)/rb1773.dr $(MD63)/ddd0_40d.dd \
		$(MD63)/d0_40d.dd $(MD63)/d1_40d.dd \
		$(MD63)/scf.mn $(MD63)/vtio.dr \
		$(MD63)/joydrv_joy.sb $(MD63)/snddrv_cc3.sb \
		$(MD63)/cowin.io $(MD63)/term_win40.dt \
		$(MD63)/w.dw $(MD63)/w1.dw $(MD63)/w2.dw $(MD63)/w3.dw \
		$(MD63)/w4.dw $(MD63)/w5.dw $(MD63)/w6.dw $(MD63)/w7.dw \
		$(MD63)/clock_60hz $(MD63)/clock2_soft \
		$(MD63)/sysgo_dd

.PHONY: all components dependencies clean

all: $(DSKS)

dependencies:
	$(MAKE) -C $(MD68) $(sort $(notdir $(KERNEL68_FLOPPY) $(BOOTFILE68_FLOPPY)))
	$(MAKE) -C $(MD63) $(sort $(notdir $(KERNEL63_FLOPPY) $(BOOTFILE63_FLOPPY)))

components: dependencies
	@$(ECHO) "**************************************************"
	@$(ECHO) "*                                                *"
	@$(ECHO) "*                    Multi-Vue                   *"
	@$(ECHO) "*                                                *"
	@$(ECHO) "**************************************************"
	$(MAKE) -C cmds_6809
	$(MAKE) -C cmds_6309
	$(MAKE) -C sys

clean:
	$(RM) os9boot kernel $(DSKS) *.list *.map
	$(MAKE) -C cmds_6809 clean
	$(MAKE) -C cmds_6309 clean
	$(MAKE) -C sys clean

$(DSK68_FLOPPY): | components
	$(RM) $@
	$(OS9FORMAT_DS40) $@ -q -n"Multi-Vue"
	$(MERGE) $(BOOTFILE68_FLOPPY)>os9boot
	$(MERGE) $(KERNEL68_FLOPPY)>kernel
	$(OS9GEN) $@ -b=os9boot -t=kernel
	$(RM) os9boot kernel
	$(MAKDIR) $@,CMDS
	$(MAKDIR) $@,CMDS/ICONS
	$(MAKDIR) $@,SYS
	$(MAKDIR) $@,DEMO
	$(CD) cmds_6809; $(OS9COPY) $(CMDS68) ../$@,CMDS
	$(OS9ATTR_EXEC) $(foreach file,$(notdir $(CMDS68)),$@,CMDS/$(file))
	$(OS9RENAME) $@,CMDS/gshell AutoEx
	$(CD) icons; $(OS9COPY) $(ICONS) ../$@,CMDS/ICONS
	$(OS9ATTR_EXEC) $(foreach file,$(ICONS),$@,CMDS/ICONS/$(file))
	$(CD) sys; $(OS9COPY) $(SYSBIN) ../$@,SYS
	$(OS9ATTR_TEXT) $(foreach file,$(SYSBIN),$@,SYS/$(file))
	$(CD) sys; $(CPL) $(SYSTEXT) ../$@,SYS
	$(OS9ATTR_TEXT) $(foreach file,$(SYSTEXT),$@,SYS/$(file))
	$(CD) demo; $(CPL) $(DEMO) ../$@,DEMO
	$(OS9ATTR_TEXT) $(foreach file,$(DEMO),$@,DEMO/$(file))
	$(CPL) $(ROOTFILES) $@,.
	$(OS9ATTR_TEXT) $(foreach file,$(ROOTFILES),$@,$(file))

$(DSK63_FLOPPY): | components
	$(RM) $@
	$(OS9FORMAT_DS40) $@ -q -n"Multi-Vue"
	$(MERGE) $(BOOTFILE63_FLOPPY)>os9boot
	$(MERGE) $(KERNEL63_FLOPPY)>kernel
	$(OS9GEN) $@ -b=os9boot -t=kernel
	$(RM) os9boot kernel
	$(MAKDIR) $@,CMDS
	$(MAKDIR) $@,CMDS/ICONS
	$(MAKDIR) $@,SYS
	$(MAKDIR) $@,DEMO
	$(CD) cmds_6309; $(OS9COPY) $(CMDS63) ../$@,CMDS
	$(OS9ATTR_EXEC) $(foreach file,$(notdir $(CMDS63)),$@,CMDS/$(file))
	$(OS9RENAME) $@,CMDS/gshell AutoEx
	$(CD) icons; $(OS9COPY) $(ICONS) ../$@,CMDS/ICONS
	$(OS9ATTR_EXEC) $(foreach file,$(ICONS),$@,CMDS/ICONS/$(file))
	$(CD) sys; $(OS9COPY) $(SYSBIN) ../$@,SYS
	$(OS9ATTR_TEXT) $(foreach file,$(SYSBIN),$@,SYS/$(file))
	$(CD) sys; $(CPL) $(SYSTEXT) ../$@,SYS
	$(OS9ATTR_TEXT) $(foreach file,$(SYSTEXT),$@,SYS/$(file))
	$(CD) demo; $(CPL) $(DEMO) ../$@,DEMO
	$(OS9ATTR_TEXT) $(foreach file,$(DEMO),$@,DEMO/$(file))
	$(CPL) $(ROOTFILES) $@,.
	$(OS9ATTR_TEXT) $(foreach file,$(ROOTFILES),$@,$(file))
