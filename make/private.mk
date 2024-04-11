# Config
.DELETE_ON_ERROR:
.SUFFIXES:
MAKEFLAGS += --no-builtin-rules

# Constants
override NAME := fnal-asic-compute-shared
override VERSION := $(shell git describe --always --dirty --broken 2> /dev/null)

# Paths
DESTDIR =
HOMEDIR = $(HOME)
PREFIX = $(HOME)/.local
BINDIR = $(PREFIX)/bin
LIBDIR = $(PREFIX)/lib
WORKDIR_ROOT := $(CURDIR)/.make

# Autodetect
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
include make/deps.mk
include make/hooks.mk
include $(BOXERBIRD.MK)
include $(CONFIGURATOR_RULES.MK)
-include $(SRCDIR_ROOT)/hooks.mk
