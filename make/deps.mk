# Constants
BOXERBIRD_BRANCH := main
CONFIGURATOR_RULES_BRANCH := main
VNCTOOLS_BRANCH := 0.4.1

WORKDIR_ROOT ?= $(error ERROR: Undefined variable WORKDIR_ROOT)
WORKDIR_DEPS = $(WORKDIR_ROOT)/deps

# Dependencies
override BOXERBIRD.MK := $(WORKDIR_DEPS)/make-boxerbird/boxerbird.mk
$(BOXERBIRD.MK):
	@echo "INFO: Fetching $@..."
	git clone --config advice.detachedHead=false --depth 1 \
			https://github.com/ic-designer/make-boxerbird.git --branch $(BOXERBIRD_BRANCH) \
			$(WORKDIR_DEPS)/make-boxerbird
	test -f $@
	@echo "INFO: Fetching $@ completed."
	@echo

override CONFIGURATOR_RULES.MK := $(WORKDIR_DEPS)/make-configurator-rules/make-configurator-rules.mk
$(CONFIGURATOR_RULES.MK):
	@echo "INFO: Fetching $@..."
	git clone --config advice.detachedHead=false --depth 1 \
			https://github.com/ic-designer/make-configurator-rules.git --branch $(CONFIGURATOR_RULES_BRANCH) \
			$(WORKDIR_DEPS)/make-configurator-rules
	test -f $@
	@echo "INFO: Fetching $@ completed."
	@echo

override VNCTOOLS_REPO := $(WORKDIR_DEPS)/bash-vnctools-$(VNCTOOLS_BRANCH)
$(VNCTOOLS_REPO):
	@echo "INFO: Fetching $@..."
	git clone --config advice.detachedHead=false --depth 1 \
			https://github.com/ic-designer/bash-vnctools.git --branch $(VNCTOOLS_BRANCH) \
			$(WORKDIR_DEPS)/bash-vnctools-$(VNCTOOLS_BRANCH)
	test -d $@
	@echo "INFO: Fetching $@ completed."
	@echo
