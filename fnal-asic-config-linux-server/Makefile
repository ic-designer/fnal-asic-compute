# Config
.DELETE_ON_ERROR:
.SUFFIXES:
MAKEFLAGS += --no-builtin-rules

# Constants
override SRCS = \
	.bash_profile \
	.bashrc \
	.local/bin/filename-search-and-replace \
	.local/bin/install-pyenv \
	.ssh/config

# Includes
include private.mk

# Targets
.PHONY: check
check: private_test

.PHONY: clean
clean: private_clean

.PHONY: install
install: private_install

.PHONY: test
test: private_test

.PHONY: uninstall
uninstall: private_uninstall
