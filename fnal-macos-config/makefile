DESTDIR:=~/.local
HOMEDIR:=~
VERSION:=0.1.0


NAME:=fnal-macos-config
DESTDIR_LIB_ROOT:=$(DESTDIR)/lib/$(NAME)-$(VERSION)
DESTDIR_LIB:=$(DESTDIR_LIB_ROOT)/$(NAME)-$(VERSION)


.PHONY: install
install: \
		$(DESTDIR_LIB)/.zshrc \
		$(DESTDIR_LIB)/.kerberos/krbtools-keytab \
		$(DESTDIR_LIB)/.kerberos/krb5.conf \
 		$(HOMEDIR)/.zshrc \
		$(HOMEDIR)/.kerberos/krb5.conf \
		$(HOMEDIR)/.kerberos/krbtools-keytab \
		$(HOMEDIR)/.ssh/config


.PHONY: uninstall
uninstall:
	\rm -rfv $(DESTDIR_LIB_VERSION)
	\rm -dv $(DESTDIR_LIB_ROOT) || true
	\rm -dv $(DESTDIR)/lib || true
	\rm -fv $(HOMEDIR)/.zshrc  || true
	\rm -fv $(HOMEDIR)/.kerberos/krb5.conf || true
	\rm -dv $(HOMEDIR)/.kerberos || true
	\rm -fv $(HOMEDIR)/.ssh/config || true
	\rm -dv $(HOMEDIR)/.ssh || true


$(HOMEDIR)/% : $(DESTDIR_LIB)/%
	install -dv $(dir $@)
	ln -sfhv $< $(dir $@)


$(DESTDIR_LIB)/% : %
	install -dv $(dir $@)
ifeq ($(VERSION),develop)
	ln -sfhv $(realpath $<) $(dir $@)
else
	install -v $< $@
endif


%/ :
	mkdir -p $@
