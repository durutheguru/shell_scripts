SCRIPT = install_script.sh

all: install-script

install-script:
	@cd misc && echo "Installing script: $(SCRIPT)" && chmod +x $(SCRIPT) && ./$(SCRIPT) $(SCRIPT)

# .PHONY targets tell make that these targets are not files
.PHONY: all install-script
