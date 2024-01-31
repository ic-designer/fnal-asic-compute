# Constants
CONFIGURATOR_RULES_BRANCH := main
VNCTOOLS_VERSION := 0.3.4

WORKDIR_ROOT ?= $(error ERROR: Undefined variable WORKDIR_ROOT)
WORKDIR_DEPS = $(WORKDIR_ROOT)/deps

# Dependencies
override CONFIGURATOR_RULES.MK := $(WORKDIR_DEPS)/make-configurator-rules/make-configurator-rules.mk
$(CONFIGURATOR_RULES.MK):
	@echo "Loading FNAL ASIC Compute Rules..."
	git clone --config advice.detachedHead=false --depth 1 \
			https://github.com/ic-designer/make-configurator-rules.git --branch $(CONFIGURATOR_RULES_BRANCH) \
			$(WORKDIR_DEPS)/make-configurator-rules
	@echo

override VNCTOOLS_REPO := $(WORKDIR_DEPS)/bash-vnctools-$(VNCTOOLS_VERSION)
$(VNCTOOLS_REPO):
	@echo "Loading vnctools..."
	mkdir -p $(WORKDIR_DEPS)
	curl -sL https://github.com/ic-designer/bash-vnctools/archive/refs/tags/$(VNCTOOLS_VERSION).tar.gz | tar xz -C $(WORKDIR_DEPS)
	test -d $@
	@echo
