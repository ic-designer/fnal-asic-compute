DESTDIR ?= $(error ERROR: Undefined variable DESTDIR)
PREFIX ?= $(error ERROR: Undefined variable PREFIX)
BINDIR ?= $(error ERROR: Undefined variable BINDIR)
LIBDIR ?= $(error ERROR: Undefined variable LIBDIR)
PKGSUBDIR ?= $(error ERROR: Undefined variable PKGSUBDIR)
WORKDIR_TEST ?= $(error ERROR: Undefined variable WORKDIR_TEST)
WORKDIR_ROOT ?= $(error ERROR: Undefined variable WORKDIR_TEST)


.PHONY: test-makefile-install
test-makefile-install:
	$(MAKE) install DESTDIR=$(abspath $(WORKDIR_TEST))/$(PKGSUBDIR) WORKDIR_ROOT=$(WORKDIR_ROOT)
	$(MAKE) uninstall DESTDIR=$(abspath $(WORKDIR_TEST))/$(PKGSUBDIR) WORKDIR_ROOT=$(WORKDIR_ROOT)
	$(MAKE) shared-hook-test WORKDIR_ROOT=$(WORKDIR_ROOT)
	$(MAKE) hook-test WORKDIR_ROOT=$(WORKDIR_ROOT)
	@echo "INFO: Testing complete"
	@echo
