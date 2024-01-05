DESTDIR:=~/.local
HOMEDIR:=~
NAME:=fnal-asic-macos-config
override VERSION:=0.2.0-alpha+20230104


.PHONY: clean
clean: private_clean

.PHONY: install
install: install_private

.PHONY: pkg_list
pkg_list: private_pkg_list

.PHONY: pkg_override
pkg_override: private_pkg_override

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

# Includes
include make/private.mk
