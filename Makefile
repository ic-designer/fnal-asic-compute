# Constants
.DEFAULT_GOAL := help

# Targets
.PHONY: check
## Performs a mock installation and uninstallation.
check: private_test

.PHONY: clean
## Delete all files created by make.
clean: private_clean

.PHONY: install
## Install the configuration for the current OS
install: private_install

.PHONY: test
## Performs a mock installation and uninstallation.
test: private_test

.PHONY: uninstall
## Unistalls the configuration for the current OS
uninstall: private_uninstall

# Includes
include make/private.mk
