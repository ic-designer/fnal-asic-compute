# Constants
VNCTOOLS_VERSION := 0.3.1
WORKDIR_ROOT ?= $(error ERROR: Undefined variable WORKDIR_ROOT)
WORKDIR_DEPS ?= $(error ERROR: Undefined variable WORKDIR_DEPS)

# Dependencies
override VNCTOOLS_REPO := $(WORKDIR_DEPS)/bash-vnctools-$(VNCTOOLS_VERSION)
$(VNCTOOLS_REPO):
	@echo "Loading vnctools..."
	mkdir -p $(WORKDIR_DEPS)
	curl -sL https://github.com/ic-designer/bash-vnctools/archive/refs/tags/$(VNCTOOLS_VERSION).tar.gz | tar xz -C $(WORKDIR_DEPS)
	test -d $@
	@echo

# Targets
.PHONY: hook-install
 hook-install: $(VNCTOOLS_REPO)
	$(MAKE) -C $(VNCTOOLS_REPO) install WORKDIR_ROOT=$(WORKDIR_ROOT)

.PHONY: hook-test
hook-test: $(VNCTOOLS_REPO)
	$(MAKE) -C $(VNCTOOLS_REPO) test WORKDIR_ROOT=$(WORKDIR_ROOT)

.PHONY: hook-uninstall
hook-uninstall: $(VNCTOOLS_REPO)
	$(MAKE) -C $(VNCTOOLS_REPO) uninstall WORKDIR_ROOT=$(WORKDIR_ROOT)
