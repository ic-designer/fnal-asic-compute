# Constants
VNCTOOLS_REPO ?= $(error ERROR: Undefined variable VNCTOOLS_REPO)
WORKDIR_ROOT ?= $(error ERROR: Undefined variable WORKDIR_ROOT)

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
