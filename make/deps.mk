# Constants
WORKDIR_ROOT ?= $(error ERROR: Undefined variable WORKDIR_ROOT)
WORKDIR_DEPS = $(WORKDIR_ROOT)/deps

CONFIGURATOR_RULES_BRANCH := main

# Dependencies
override CONFIGURATOR_RULES.MK := $(WORKDIR_DEPS)/make-configurator-rules/make-configurator-rules.mk
$(CONFIGURATOR_RULES.MK):
	@echo "Loading FNAL ASIC Compute Rules..."
	git clone --config advice.detachedHead=false --depth 1 \
			https://github.com/ic-designer/make-configurator-rules.git --branch $(CONFIGURATOR_RULES_BRANCH) \
			$(WORKDIR_DEPS)/make-configurator-rules
	@echo
