# Constants
WORKDIR_DEPS ?= $(error ERROR: Undefined variable WORKDIR_DEPS)

# Load Bowerbird Dependency Tools
BOWERBIRD_DEPS.MK := $(WORKDIR_DEPS)/bowerbird-deps/bowerbird_deps.mk
$(BOWERBIRD_DEPS.MK):
	@curl --silent --show-error --fail --create-dirs -o $@ -L \
https://raw.githubusercontent.com/ic-designer/make-bowerbird-deps/\
main/src/bowerbird-deps/bowerbird-deps.mk
include $(BOWERBIRD_DEPS.MK)

# Load Dependencies
$(call bowerbird::git-dependency,$(WORKDIR_DEPS)/bowerbird-help,\
		https://github.com/ic-designer/make-bowerbird-help.git,main,bowerbird.mk)
$(call bowerbird::git-dependency,$(WORKDIR_DEPS)/bowerbird-githooks,\
		https://github.com/ic-designer/make-bowerbird-githooks.git,main,bowerbird.mk)
$(call bowerbird::git-dependency,$(WORKDIR_DEPS)/bowerbird-install-tools,\
		https://github.com/ic-designer/make-bowerbird-install-tools.git,main,bowerbird.mk)
$(call bowerbird::git-dependency,$(WORKDIR_DEPS)/bowerbird-test,\
		https://github.com/ic-designer/make-bowerbird-test.git,main,bowerbird.mk)


CONFIGURATOR_RULES_BRANCH := main
CONFIGURATOR_RULES.MK := $(WORKDIR_DEPS)/make-configurator-rules/make-configurator-rules.mk
$(CONFIGURATOR_RULES.MK):
	@echo "INFO: Fetching $@..."
	git clone --config advice.detachedHead=false --depth 1 \
			https://github.com/ic-designer/make-configurator-rules.git --branch $(CONFIGURATOR_RULES_BRANCH) \
			$(WORKDIR_DEPS)/make-configurator-rules
	test -f $@
	@echo "INFO: Fetching $@ completed."
	@echo


VNCTOOLS_BRANCH := 0.5.1
VNCTOOLS_REPO := $(WORKDIR_DEPS)/bash-vnctools-$(VNCTOOLS_BRANCH)
$(VNCTOOLS_REPO):
	@echo "INFO: Fetching $@..."
	git clone --config advice.detachedHead=false --depth 1 \
			https://github.com/ic-designer/bash-vnctools.git --branch $(VNCTOOLS_BRANCH) \
			$(WORKDIR_DEPS)/bash-vnctools-$(VNCTOOLS_BRANCH)
	test -d $@
	@echo "INFO: Fetching $@ completed."
	@echo
