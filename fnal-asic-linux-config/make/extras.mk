define git-clone-shallow
	$(if $(wildcard $2), rm -rf $2)
	@git clone -qv --depth=1 $1 $2 $(if $3, --branch $3)
endef


define git-list-remotes
	@for d in $(1)/*; do \
		echo '$${d} $$(git -C $${d} remote get-url origin --push)'; \
	done
endef


define install-as-copy
	@install -dv $(dir $@)
	install -v $< $@
	@test -f $@
	@diff $@ $<
endef


define install-as-link
	@install -dv $(dir $@)
	@ln -sfv $(realpath $<) $@
	@test -L $@
	@test -f $@
	@diff $@ $<
endef


.PRECIOUS: %/.
%/. :
	@mkdir -p $@
