# Required Paths
DESTDIR ?= $(error ERROR: Undefined variable DESTDIR)
HOMEDIR ?= $(error ERROR: Undefined variable HOMEDIR)
NAME ?= $(error ERROR: Undefined variable NAME)
VERSION ?= $(error ERROR: Undefined variable VERSION)

LIBSUBDIR ?= $(error ERROR: Undefined variable LIBSUBDIR)
WORKDIR ?= $(error ERROR: Undefined variable WORKDIR)
WORKDIR_PKGS ?= $(error ERROR: Undefined variable WORKDIR_PKGS)
WORKDIR_TEST ?= $(error ERROR: Undefined variable WORKDIR_TEST)

override PKGSUBDIR:=$(LIBSUBDIR)/$(NAME)/$(NAME)-$(VERSION)
override SRCSUBDIR:=src


# Includes
include make/extras.mk


# Private targets
SRCS = \
	.bash_profile \
	.bashrc \
	.local/bin/filename-search-and-replace \
	.local/bin/install-pyenv \
	.ssh/config


.PHONY: private_install
private_install:
	@$(MAKE) test
	@$(MAKE) private_install_all_srcs


.PHONY: private_install_all_srcs
private_install_srcs: $(foreach s, $(SRCS), $(DESTDIR)/$(PKGSUBDIR)/$(s) $(HOMEDIR)/$(s))
	diff -qr $(DESTDIR)/$(PKGSUBDIR) $(SRCSUBDIR)

$(DESTDIR)/$(PKGSUBDIR)/%: $(SRCSUBDIR)/%
ifeq ($(VERSION),develop)
	$(call install-as-link)
else
	$(call install-as-copy)
endif

$(HOMEDIR)/%: $(DESTDIR)/$(PKGSUBDIR)/%
	$(call install-as-link)


.PHONY: private_uninstall
private_uninstall:
	$(foreach s, $(SRCS), \rm -v $(HOMEDIR)/$(s) && test ! -e $(HOMEDIR)/$(s); \rm -dv $(dir $(HOMEDIR)/$(s)); )
	@-\rm -rdfv $(DESTDIR)/$(PKGSUBDIR)
	@-\rm -dv $(dir $(DESTDIR)/$(PKGSUBDIR))
	@-\rm -dv $(DESTDIR)/$(LIBSUBDIR)


.PHONY: private_test
private_test :
	@$(MAKE) private_install_srcs private_uninstall \
		DESTDIR=$(abspath $(WORKDIR_TEST))/dest \
		HOMEDIR=$(abspath $(WORKDIR_TEST))/home


.PHONY: private_clean
private_clean:
	@echo "Cleaning directories: $(WORKDIR), $(WORKDIR_PKGS)"
	$(if $(wildcard $(WORKDIR)), rm -rf $(WORKDIR))
	$(if $(wildcard $(WORKDIR_PKGS)), rm -rf $(WORKDIR_PKGS))


.PHONY: private_pkg_list
private_pkg_list:
	$(call git-list-remotes, $(WORKDIR_PKGS))


.PHONY: private_pkg_override
private_pkg_override: REPO ?= $(error ERROR: Repo not defined. Please defined REPO=<repository>)
private_pkg_override: NAME ?= $(error ERROR: Name not defined. Please defined NAME=<repository>)
private_pkg_override:
	$(call git-clone-shallow, $(REPO), $(WORKDIR_PKGS)/$(NAME))
