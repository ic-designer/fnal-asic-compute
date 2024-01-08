# Config
.DELETE_ON_ERROR:
.SUFFIXES:
MAKEFLAGS += --no-builtin-rules

# Dependencies
VNCTOOLS.MK = $(WORKDIR_DEPS)/vnctools/Makefile
$(VNCTOOLS.MK):
	@echo "Loading vnctools..."
	git clone --config advice.detachedHead=false \
		git@github.com:ic-designer/bash-vnctools.git --branch 0.2.0 $(dir $(VNCTOOLS.MK))
	@echo

# Targets
.PHONY: check
check: private_test

.PHONY: clean
clean: private_clean

.PHONY: install
install: private_install $(VNCTOOLS.MK)
	@$(MAKE) -C $(dir $(VNCTOOLS.MK)) install

.PHONY: test
test: private_test

.PHONY: uninstall
uninstall: private_uninstall $(VNCTOOLS.MK)
	@$(MAKE) -C $(dir $(VNCTOOLS.MK)) uninstall

# Shared Targets
SRCS = \
	.kerberos/krb5.conf \
	.kerberos/krbtools-keytab \
	.ssh/config \
	.zshrc
include shared-targets.mk
