# Config
.DELETE_ON_ERROR:
.SUFFIXES:
MAKEFLAGS += --no-builtin-rules


# Constants
UNAME_OS:=$(shell sh -c 'uname -s 2>/dev/null')

ifeq ($(UNAME_OS),Darwin)
    TARGET_CONFIG := fnal-asic-macos-config
else ifeq ($(UNAME_OS),Linux)
    TARGET_CONFIG := fnal-asic-linux-config
else
    $(error Unsupported operating system, $(UNAME_OS))
endif

DESTDIR=~/.local
HOMEDIR=~
NAME=$(TARGET_CONFIG)
VERSION=0.2.0
WORKDIR=$(CURDIR)/.make


# Call configuration dependent targets
export
%:
	$(MAKE) -C $(TARGET_CONFIG) -I $(CURDIR)/make $(MAKECMDGOALS)
