# Config
.DELETE_ON_ERROR:
.SUFFIXES:
MAKEFLAGS += --no-builtin-rules


# Paths
DESTDIR = ~/.local
HOMEDIR = ~


# Constants
UNAME_OS:=$(shell sh -c 'uname -s 2>/dev/null')
ifeq ($(UNAME_OS),Darwin)
    TARGET_CONFIG := fnal-asic-macos-config
else ifeq ($(UNAME_OS),Linux)
    TARGET_CONFIG := fnal-asic-linux-config
else
    $(error Unsupported operating system, $(UNAME_OS))
endif
override NAME := $(TARGET_CONFIG)
override VERSION := $(shell git describe --always --dirty --broken)
override WORKDIR_ROOT := $(CURDIR)/.make


# Configuration specific targets
export
%:
	$(MAKE) -C $(TARGET_CONFIG) -I $(CURDIR)/make $(MAKECMDGOALS)
