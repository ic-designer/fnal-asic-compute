# Config
export

# Constants
DESTDIR ?= $(error ERROR: Undefined variable DESTDIR)
HOMEDIR ?= $(error ERROR: Undefined variable HOMEDIR)
LIBDIR ?= $(error ERROR: Undefined variable LIBDIR)
PREFIX ?= $(error ERROR: Undefined variable PREFIX)
WORKDIR_ROOT ?= $(error ERROR: Undefined variable WORKDIR_ROOT)

override NAME := fnal-asic-compute-shared
override PKGSUBDIR = $(NAME)/$(TARGET_CONFIG)
override PKGSUBDIR = $(NAME)
override VERSION := $(shell git describe --always --dirty --broken 2> /dev/null)

override SRCDIR_CONFIG_FILES := $(shell cd src && find . -type f)
override WORKDIR_BUILD = $(WORKDIR_ROOT)/build/$(NAME)/$(VERSION)
override WORKDIR_DEPS = $(WORKDIR_ROOT)/deps
override WORKDIR_TEST = $(WORKDIR_ROOT)/test/$(NAME)/$(VERSION)

# Includes
include deps.mk
include $(BOXERBIRD.MK)

# Targets
.PHONY: private_clean
private_clean:
	@echo "Cleaning directories:"
	@$(if $(wildcard $(WORKDIR_BUILD)), rm -rfv $(WORKDIR_BUILD))
	@$(if $(wildcard $(WORKDIR_DEPS)), rm -rfv $(WORKDIR_DEPS))
	@$(if $(wildcard $(WORKDIR_ROOT)), rm -rfv $(WORKDIR_ROOT))
	@$(if $(wildcard $(WORKDIR_TEST)), rm -rfv $(WORKDIR_TEST))
	@echo


.PHONY: private_install
private_install: $(foreach s, $(SRCDIR_CONFIG_FILES), $(DESTDIR)/$(LIBDIR)/$(PKGSUBDIR)/$(s) $(DESTDIR)/$(HOMEDIR)/$(s))
	diff -r $(DESTDIR)/$(LIBDIR)/$(PKGSUBDIR) src/

$(DESTDIR)/$(LIBDIR)/$(PKGSUBDIR)/%: src/%
	$(boxerbird::install-as-copy)

$(DESTDIR)/$(HOMEDIR)/%: $(DESTDIR)/$(LIBDIR)/$(PKGSUBDIR)/%
	$(boxerbird::install-as-link)


.PHONY: private_test
private_test :
	@$(MAKE) install uninstall DESTDIR=$(abspath $(WORKDIR_TEST))/$(PKGSUBDIR)


.PHONY: private_uninstall
private_uninstall:
	@echo "Uninstalling $(NAME)"
	@$(foreach s, $(SRCDIR_CONFIG_FILES), \
		rm -v $(DESTDIR)/$(HOMEDIR)/$(s); \
		test ! -e $(DESTDIR)/$(HOMEDIR)/$(s); \
		rm -dv $(dir $(DESTDIR)/$(HOMEDIR)/$(s)) 2> /dev/null || true;\
	)
	@\rm -rdfv $(DESTDIR)/$(LIBDIR)/$(PKGSUBDIR) 2> /dev/null || true
	@\rm -dv $(dir $(DESTDIR)/$(LIBDIR)/$(PKGSUBDIR)) 2> /dev/null || true
	@\rm -dv $(DESTDIR)/$(LIBDIR) 2> /dev/null || true
	@echo
