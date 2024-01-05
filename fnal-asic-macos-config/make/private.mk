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


# Includes
include make/extras.mk


# Dependencies
$(WORKDIR_PKGS)/bash-vnctools/makefile: | $(WORKDIR_PKGS)/.
	$(call git-clone-shallow, \
			git@github.com:ic-designer/bash-vnctools.git, \
			$(WORKDIR_PKGS)/bash-vnctools, \
			0.1.1)


# Private targets
.PHONY: private_install
private_install: \
		$(DESTDIR)/$(PKGSUBDIR)/.zshrc \
		$(DESTDIR)/$(PKGSUBDIR)/.kerberos/krbtools-keytab \
		$(DESTDIR)/$(PKGSUBDIR)/.kerberos/krb5.conf \
		$(DESTDIR)/$(PKGSUBDIR)/.ssh/config \
 		$(HOMEDIR)/.zshrc \
		$(HOMEDIR)/.kerberos/krb5.conf \
		$(HOMEDIR)/.kerberos/krbtools-keytab \
		$(HOMEDIR)/.ssh/config

$(DESTDIR)/$(PKGSUBDIR)/% : %
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
	@-\rm -dv $(HOMEDIR)/.zshrc
	@test ! -e $(HOMEDIR)/.zshrc
	@-\rm -dv $(HOMEDIR)/.kerberos/krb5.conf
	@test ! -e $(HOMEDIR)/.kerberos/krb5.conf
	@-\rm -dv $(HOMEDIR)/.kerberos/krbtools-keytab
	@test ! -e $(HOMEDIR)/.kerberos/krbtools-keytab
	@-\rm -dv $(HOMEDIR)/.kerberos
	@-\rm -dv $(HOMEDIR)/.ssh/config
	@test ! -e $(HOMEDIR)/.ssh/config


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
