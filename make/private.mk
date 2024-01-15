# Constants
override NAME := fnal-asic-compute-shared
override VERSION := $(shell git describe --always --dirty --broken 2> /dev/null)

# Includes
include make/deps.mk
include make/hooks.mk
-include $(SRCDIR_ROOT)/hooks.mk
include $(CONFIGURATOR_RULES.MK)
