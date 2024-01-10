# Config
.DELETE_ON_ERROR:
.SUFFIXES:
MAKEFLAGS += --no-builtin-rules

# Shared Targets
SRCS = \
	.kerberos/krb5.conf \
	.kerberos/krbtools-keytab \
	.ssh/config \
	.zshrc
include shared-targets.mk

# Dependencies
VNCTOOLS_VERSION = 0.3.0
VNCTOOLS.MK = $(WORKDIR_DEPS)/bash-vnctools-$(VNCTOOLS_VERSION)/Makefile
$(VNCTOOLS.MK):  |$(WORKDIR_DEPS)/.
	@echo "Loading vnctools..."
	curl -sL https://github.com/ic-designer/bash-vnctools/archive/refs/tags/$(VNCTOOLS_VERSION).tar.gz | tar xz -C $(WORKDIR_DEPS)
	test -f $@
	@echo

# Targets
.PHONY: check
check: private_test

.PHONY: clean
clean: private_clean

.PHONY: install
install: $(VNCTOOLS.MK)
	@$(MAKE) private_install
	@$(MAKE) -C $(dir $(VNCTOOLS.MK)) install

.PHONY: test
test: private_test

.PHONY: uninstall
uninstall: $(VNCTOOLS.MK)
	@$(MAKE) -C $(dir $(VNCTOOLS.MK)) uninstall
	@$(MAKE) private_uninstall
