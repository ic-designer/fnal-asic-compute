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
.PHONY: private_install
private_install: \
		$(DESTDIR)/$(PKGSUBDIR)/.bashrc \
		$(DESTDIR)/$(PKGSUBDIR)/.bash_profile \
		$(DESTDIR)/$(PKGSUBDIR)/.local/bin/filename-search-and-replace \
		$(DESTDIR)/$(PKGSUBDIR)/.local/bin/install-pyenv \
		$(DESTDIR)/$(PKGSUBDIR)/.ssh/config \
		$(HOMEDIR)/.bashrc \
		$(HOMEDIR)/.bash_profile \
		$(HOMEDIR)/.local/bin/filename-search-and-replace \
		$(HOMEDIR)/.local/bin/install-pyenv \
		$(HOMEDIR)/.ssh/config

$(DESTDIR)/$(PKGSUBDIR)/% : $(SRCSUBDIR)/%
ifeq ($(VERSION),develop)
	$(call install-as-link)
else
	$(call install-as-file)
endif

$(HOMEDIR)/% : $(DESTDIR)/$(PKGSUBDIR)/%
	$(call install-as-link)


.PHONY: private_uninstall
private_uninstall:
	@-\rm -fv $(DESTDIR)/$(PKGSUBDIR)/*
	@-\rm -dv $(DESTDIR)/$(PKGSUBDIR)
	@-\rm -dv $(dir $(DESTDIR)/$(PKGSUBDIR))
	@-\rm -dv $(DESTDIR)/$(LIBSUBDIR)
	@test ! -e $(DESTDIR)/$(PKGSUBDIR)
	@-\rm -dv $(HOMEDIR)/.bashrc
	@test ! -e $(HOMEDIR)/.bashrc
	@-\rm -dv $(HOMEDIR)/.bashrc_profile
	@test ! -e $(HOMEDIR)/.bashrc_profile
	@-\rm -dv $(HOMEDIR)/.ssh/config
	@test ! -e $(HOMEDIR)/.ssh/config
	@-\rm -dv $(HOMEDIR)/.local/bin/filename-search-and-replace
	@test ! -e $(HOMEDIR)/.local/bin/filename-search-and-replace


.PHONY: private_test
private_test :
	@$(MAKE) install DESTDIR=$(abspath $(WORKDIR_TEST)) HOMEDIR=$(abspath $(WORKDIR_TEST))/home


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
