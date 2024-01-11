# FNAL ASIC Compute

[![Makefile CI](https://github.com/ic-designer/fnal-asic-compute/actions/workflows/makefile.yml/badge.svg)](https://github.com/ic-designer/fnal-asic-compute/actions/workflows/makefile.yml)


FNAL ASIC Compute provides user configuration files for FNAL ASIC computing devices. The current
supported configurations include the following:
- MacOS client running VNC
- Linux servers supporting VNC

## Configurations

### MacOS Client

The macOS client configuration provides the following user configuation files:
- `~/.kerberos/krb5.conf` - FNAL Kerberos Configuration for MacOS
- `~/.kerberos/krbtools-keytab` - Helper script to generate keytab file needed for passwordless authentication.
- `~/.ssh/config` - FNAL SSH client configurations.
- `~/.zshrc` - Base zsh run command file.

The envirnment variables provided below are also supported. These variables can be uniquely set
for each user by adding to the override file `~/.zshrc_local`.
- `KRB_PRINCIPAL` - Overrides the default kerebros principal if defined.

The MacOS client configuration also installs `vnctools` to help manage VNC connections.

[VNC Tools Command Reference](https://github.com/ic-designer/bash-vnctools/blob/d60f8c8697f0d56824c01a4dd6593d126c65e9dd/README.md)


### Linux Server

The Linux server configuration provides the following user configuation files:
- `~/.local/bin/filename-search-and-replace` - Bash script for renaming files using search and replace.
- `~/.local/bin/isntall-pyenv` - Bash scrip to help install pyenv.
- `~/.ssh/config` - FNAL SSH server configurations.
- `~/.bashrc` - Base bash run command file.
- `~/.bash_profile` - Base profile file.


## Installation

The user configuration files can installed using the code snippet below.

```bash
curl -sL https://github.com/ic-designer/fnal-asic-compute/archive/refs/tags/0.3.1.tar.gz | tar xz
make -C fnal-asic-compute-0.3.1 install
```

The Makefile will use information about the operating system to determine which configuration to
install. As shown below, the Makefile first determines the operating system, then passes the
target to the configuration specific target.

```make
UNAME_OS:=$(shell sh -c 'uname -s 2>/dev/null')
ifeq ($(UNAME_OS),Darwin)
    TARGET_CONFIG := fnal-asic-macos-config
else ifeq ($(UNAME_OS),Linux)
    TARGET_CONFIG := fnal-asic-linux-config
else
    $(error Unsupported operating system, $(UNAME_OS))
endif

...

%:
	$(MAKE) -C $(TARGET_CONFIG) -I $(CURDIR)/make $(MAKECMDGOALS)

```


## Make Targets

The supported make targets are shown below.
- `check` - Performs a staged `install` and `uninstall` in a test directory.
- `clean` - Deletes all internal build files.
- `install` - Installs copies of the configuration files.
- `test` - Same as `check`.
- `uninstall` - Uninstalls the configuration files.


```make
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
```
