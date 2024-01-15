# Config
.DELETE_ON_ERROR:
.SUFFIXES:
MAKEFLAGS += --no-builtin-rules

# Paths
DESTDIR =
HOMEDIR = $(HOME)
PREFIX = $(HOME)/.local
LIBDIR = $(PREFIX)/lib
WORKDIR_ROOT := $(CURDIR)/.make

# Configuration
UNAME_OS:=$(shell sh -c 'uname -s 2>/dev/null')
ifeq ($(UNAME_OS),Darwin)
    TARGET_CONFIG := fnal-asic-config-macos-client
else ifeq ($(UNAME_OS),Linux)
    TARGET_CONFIG := fnal-asic-config-linux-server
else
    $(error Unsupported operating system, $(UNAME_OS))
endif
SRCDIR_ROOT = $(TARGET_CONFIG)

# Includes
include make/private.mk

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
