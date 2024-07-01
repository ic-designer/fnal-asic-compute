# Config
.DELETE_ON_ERROR:
.SUFFIXES:
MAKEFLAGS += --no-builtin-rules
MAKEFLAGS += --no-builtin-variables
MAKEFLAGS += --warn-undefined-variables

# Constants
NAME := fnal-asic-compute-shared
VERSION := $(shell git describe --always --dirty --broken 2> /dev/null)
WORKDIR_ROOT := $(CURDIR)/.make
WORKDIR_DEPS = $(WORKDIR_ROOT)/deps
WORKDIR_TEST = $(WORKDIR_ROOT)/test/$(NAME)/$(VERSION)

# Paths
DESTDIR =
HOMEDIR = $(HOME)
PREFIX = $(HOME)/.local
BINDIR = $(PREFIX)/bin
LIBDIR = $(PREFIX)/lib

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
include $(CONFIGURATOR_RULES.MK)
-include $(SRCDIR_ROOT)/hooks.mk

# Targets
.PHONY: private_test
private_test: test-vnctools-makefile
	printf "\e[1;32mPassed Tests\e[0m\n"

ifdef bowerbird::test::generate-runner
    $(call bowerbird::test::generate-runner,test-vnctools-makefile,test/makefile)
endif
