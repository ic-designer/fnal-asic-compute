# Config
.DELETE_ON_ERROR:
.SUFFIXES:
MAKEFLAGS += --no-builtin-rules


# Shared Targets
SRCS = \
	.kerberos/krb5.conf \
	.kerberos/krbtools-keytab \
	.ssh/config \
	.zshrc
include shared-targets.mk


# Targets
.PHONY: check
test: private_test

.PHONY: clean
clean: private_clean

.PHONY: install
install: DESTDIR ?= $(error ERROR: Undefined variable DESTDIR)
install: WORKDIR_PKGS ?= $(error ERROR: Undefined variable WORKDIR_PKGS)
install: \
		private_install \
		$(WORKDIR_PKGS)/bash-vnctools/makefile
	@$(MAKE) -C $(WORKDIR_PKGS)/bash-vnctools/ install DESTDIR=$(DESTDIR)

.PHONY: pkg_list
pkg_list: private_pkg_list

.PHONY: pkg_override
pkg_override: private_pkg_override

.PHONY: test
test: private_test

.PHONY: uninstall
uninstall: DESTDIR ?= $(error ERROR: Undefined variable DESTDIR)
uninstall: WORKDIR_PKGS ?= $(error ERROR: Undefined variable WORKDIR_PKGS)
uninstall: \
		private_uninstall \
		$(WORKDIR_PKGS)/bash-vnctools/makefile
	@$(MAKE) -C $(WORKDIR_PKGS)/bash-vnctools/ uninstall DESTDIR=$(DESTDIR)



# Dependencies
$(WORKDIR_PKGS)/bash-vnctools/makefile: WORKDIR_PKGS ?= $(error ERROR: Undefined variable WORKDIR_PKGS)
$(WORKDIR_PKGS)/bash-vnctools/makefile: | $(WORKDIR_PKGS)/.
	$(call git-clone-shallow, \
			git@github.com:ic-designer/bash-vnctools.git, \
			$(WORKDIR_PKGS)/bash-vnctools, \
			0.1.0)
