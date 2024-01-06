# Constants
export
DESTDIR ?= $(error ERROR: Undefined variable DESTDIR)
HOMEDIR ?= $(error ERROR: Undefined variable HOMEDIR)
NAME ?= $(error ERROR: Undefined variable NAME)
SRCS ?= $(error ERROR: Undefined variable SRCS)
VERSION ?= $(error ERROR: Undefined variable VERSION)
WORKDIR ?= $(error ERROR: Undefined variable WORKDIR)

override LIBSUBDIR=lib
override PKGSUBDIR=$(LIBSUBDIR)/$(NAME)/$(NAME)-$(VERSION)
override SRCSUBDIR=src
override WORKDIR_PKGS=$(WORKDIR)/$(TARGET_CONFIG)-$(VERSION)/pkgs
override WORKDIR_TEST=$(WORKDIR)/$(TARGET_CONFIG)-$(VERSION)/test


# Includes
include shared-recipes.mk


# Targets
.PHONY: private_clean
private_clean:
	@echo "Cleaning directories: $(WORKDIR), $(WORKDIR_PKGS)"
	$(if $(wildcard $(WORKDIR)), rm -rf $(WORKDIR))
	$(if $(wildcard $(WORKDIR_PKGS)), rm -rf $(WORKDIR_PKGS))


.PHONY: private_install
private_install: $(foreach s, $(SRCS), $(DESTDIR)/$(PKGSUBDIR)/$(s) $(HOMEDIR)/$(s))
	diff -r $(DESTDIR)/$(PKGSUBDIR) $(SRCSUBDIR)

$(DESTDIR)/$(PKGSUBDIR)/%: $(SRCSUBDIR)/%
ifeq ($(VERSION),develop)
	$(call install-as-link)
else
	$(call install-as-copy)
endif

$(HOMEDIR)/%: $(DESTDIR)/$(PKGSUBDIR)/%
	$(call install-as-link)


.PHONY: private_pkg_list
private_pkg_list:
	$(call git-list-remotes, $(WORKDIR_PKGS))


.PHONY: private_pkg_override
private_pkg_override: REPO_NAME ?= $(error ERROR: Name not defined. Please defined REPO_NAME=<name>)
private_pkg_override: REPO_PATH ?= $(error ERROR: Repo not defined. Please defined REPO_PATH=<path>)
private_pkg_override:
	$(call git-clone-shallow, $(REPO_PATH), $(WORKDIR_PKGS)/$(REPO_NAME))


.PHONY: private_test
private_test :
	@$(MAKE) install uninstall \
		DESTDIR=$(abspath $(WORKDIR_TEST))/home/.local \
		HOMEDIR=$(abspath $(WORKDIR_TEST))/home


.PHONY: private_uninstall
private_uninstall:
	$(foreach s, $(SRCS), \rm -v $(HOMEDIR)/$(s) && test ! -e $(HOMEDIR)/$(s); \rm -dv $(dir $(HOMEDIR)/$(s)) 2> /dev/null || true; )
	@-\rm -rdfv $(DESTDIR)/$(PKGSUBDIR) 2> /dev/null
	@-\rm -dv $(dir $(DESTDIR)/$(PKGSUBDIR)) 2> /dev/null
	@-\rm -dv $(DESTDIR)/$(LIBSUBDIR) 2> /dev/null
