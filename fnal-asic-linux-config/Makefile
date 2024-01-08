# Config
.DELETE_ON_ERROR:
.SUFFIXES:
MAKEFLAGS += --no-builtin-rules


# Shared Targets
SRCS = \
	.bash_profile \
	.bashrc \
	.local/bin/filename-search-and-replace \
	.local/bin/install-pyenv \
	.ssh/config
include shared-targets.mk


# Targets
.PHONY: check
test: private_test

.PHONY: clean
clean: private_clean

.PHONY: install
install: private_install

.PHONY: pkg_list
pkg_list: private_pkg_list

.PHONY: pkg_override
pkg_override: private_pkg_override

.PHONY: test
test: private_test

.PHONY: uninstall
uninstall: private_uninstall
