include $(NITROS9DIR)/rules.mak

dirs	=  6809l2

.PHONY: all clean
 
# Make all components
all:
	@$(ECHO) "**************************************************"
	@$(ECHO) "*                                                *"
	@$(ECHO) "*                OS-9 LEVEL 2 BBS                *"
	@$(ECHO) "*                                                *"
	@$(ECHO) "**************************************************"
	$(foreach dir,$(dirs),$(MAKE) -C $(dir) &&) :

# Clean all components
clean:
	$(foreach dir,$(dirs),$(MAKE) -C $(dir) clean &&) :
