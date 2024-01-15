# Includes
include make/private.mk

# Targets
.PHONY: check
check: private_test

.PHONY: clean
clean: private_clean

.PHONY: install
install: private_install

.PHONY: test
test: private_test

.PHONY: uninstall
uninstall: private_uninstall
