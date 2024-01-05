DESTDIR:=~/.local
HOMEDIR:=~
NAME:=fnal-asic-macos-config
override VERSION:=0.2.0


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


# Config
.DELETE_ON_ERROR:
.SUFFIXES:
MAKEFLAGS += --no-builtin-rules

# Paths
override LIBSUBDIR:=lib
override WORKDIR:=.make
override WORKDIR_PKGS:=$(WORKDIR)/pkgs
override WORKDIR_TEST:=$(WORKDIR)/test


# Includes
include make/private.mk
