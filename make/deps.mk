# Constants
WORKDIR_DEPS ?= $(error ERROR: Undefined variable WORKDIR_DEPS)

BOXERBIRD_BRANCH := main
VNCTOOLS_VERSION := 0.3.1

# Dependencies
override BOXERBIRD.MK := $(WORKDIR_DEPS)/make-boxerbird/boxerbird.mk
$(BOXERBIRD.MK):
	@echo "Loading Boxerbird..."
	git clone --config advice.detachedHead=false --depth 1 \
			https://github.com/ic-designer/make-boxerbird.git --branch $(BOXERBIRD_BRANCH) \
			$(WORKDIR_DEPS)/make-boxerbird
	@echo

override VNCTOOLS_REPO := $(WORKDIR_DEPS)/bash-vnctools-$(VNCTOOLS_VERSION)
$(VNCTOOLS_REPO):
	@echo "Loading vnctools..."
	mkdir -p $(WORKDIR_DEPS)
	curl -sL https://github.com/ic-designer/bash-vnctools/archive/refs/tags/$(VNCTOOLS_VERSION).tar.gz | tar xz -C $(WORKDIR_DEPS)
	test -d $@
	@echo
