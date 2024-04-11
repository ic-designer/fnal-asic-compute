# FNAL ASIC Compute

[![Makefile CI](https://github.com/ic-designer/fnal-asic-compute/actions/workflows/makefile.yml/badge.svg)](https://github.com/ic-designer/fnal-asic-compute/actions/workflows/makefile.yml)

FNAL ASIC Compute provides standardized configurations for the following FNAL ASIC
computing systems:
- MacOS VNC Client
- Linux VNC Server

## Features

The MacOS VNC Client currently supports the following features:
- Automatic Kerberos authentification and token renewal without password prompts.
- Manage VNC connections from FNAL MacOS VNC Clients to FNAL Linux VNC Servers with
  the `vnctools` scripts.
- Display git repo information in the command prompt.
- Standard FNAL Kerberos and SSH configurations.


## Installation

The configurations can installed using the following code snippet:

```bash
curl -sL https://github.com/ic-designer/fnal-asic-compute/archive/refs/tags/0.8.0.tar.gz | tar xz
make -C fnal-asic-compute-0.8.0 install
```

The Makefile retrieves information from the operating system to determine which
configuration to install. As shown below, the Makefile first determines the operating
system, then passes the target to the configuration specific target.

```make
UNAME_OS:=$(shell sh -c 'uname -s 2>/dev/null')
ifeq ($(UNAME_OS),Darwin)
    TARGET_CONFIG := fnal-asic-config-macos-client
else ifeq ($(UNAME_OS),Linux)
    TARGET_CONFIG := fnal-asic-config-linux-server
else
    $(error Unsupported operating system, $(UNAME_OS))
endif
SRCDIR_ROOT = $(TARGET_CONFIG)
```

## Configurations

### MacOS VNC Client


The macOS client configuration provides the following user configuation files:
- `~/.kerberos/krb5.conf` - FNAL Kerberos Configuration for MacOS
- `~/.kerberos/krbtools-keytab` - Helper script to generate keytab file needed for passwordless authentication.
- `~/.ssh/config` - FNAL SSH client configurations.
- `~/.zshrc` - Base zsh run command file.

The envirnment variables provided below are also supported. These variables can be uniquely set
for each user by adding to the override file `~/.zshrc_local`.
- `KRB5_PRINCIPAL` - Overrides the default kerebros principal if defined.

The MacOS client configuration also installs `vnctools` to help manage VNC connections.

[VNC Tools Command Reference](https://github.com/ic-designer/bash-vnctools/blob/d60f8c8697f0d56824c01a4dd6593d126c65e9dd/README.md)

### Linux VNC Server

The Linux server configuration provides the following user configuation files:
- `~/.local/bin/filename-search-and-replace` - Bash script for renaming files using search and replace.
- `~/.local/bin/isntall-pyenv` - Bash scrip to help install pyenv.
- `~/.ssh/config` - FNAL SSH server configurations.
- `~/.bashrc` - Base bash run command file.
- `~/.bash_profile` - Base profile file.

## Make Targets

Run `make` help to list the supported make targets.

```
$ make help
Available targets:
   check                   Performs a mock installation and uninstallation.
   clean                   Delete all files created by make.
   help                    Provides this help message
   install                 Install the configuration for the current OS
   test                    Performs a mock installation and uninstallation.
   uninstall               Unistalls the configuration for the current OS
```
