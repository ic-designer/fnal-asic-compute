# Constants
WORKDIR_DEPS ?= $(error ERROR: Undefined variable WORKDIR_DEPS)

BOXERBIRD_BRANCH := main

# Dependencies
override BOXERBIRD.MK := $(WORKDIR_DEPS)/make-boxerbird/boxerbird.mk
$(BOXERBIRD.MK):
	@echo "Loading Boxerbird..."
	git clone --config advice.detachedHead=false --depth 1 \
			https://github.com/ic-designer/make-boxerbird.git --branch $(BOXERBIRD_BRANCH) \
			$(WORKDIR_DEPS)/make-boxerbird
	@echo
