# Config
.DELETE_ON_ERROR:
.SUFFIXES:
MAKEFLAGS += --no-builtin-rules

# Constants
override SRCS = \
	.kerberos/krb5.conf \
	.kerberos/krbtools-keytab \
	.ssh/config \
	.zshrc

# Includes
include shared-targets.mk

# Targets
.PHONY: check
check: private_test

.PHONY: clean
clean: private_clean

.PHONY: install
install: $(VNCTOOLS_REPO)
	@$(MAKE) private_install
	@$(MAKE) -C $(VNCTOOLS_REPO) install
	@echo "Installation successful"

.PHONY: test
test: private_test

.PHONY: uninstall
uninstall: $(VNCTOOLS_REPO)
	@$(MAKE) -C $(VNCTOOLS_REPO) uninstall
	@$(MAKE) private_uninstall
