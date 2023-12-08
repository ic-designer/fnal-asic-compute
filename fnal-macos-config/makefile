DESTDIR=~/.local
HOMEDIR=~
VERSION:=0.1.0


DESTDIR_LIB:=$(DESTDIR)/lib/fnal-macos-config/fnal-macos-config-$(VERSION)

.PHONY: install
install: \
		$(DESTDIR_LIB)/.zshrc \
		$(DESTDIR_LIB)/.kerberos/krbtools-keytab \
		$(DESTDIR_LIB)/.kerberos/krb5.conf \
		$(DESTDIR_LIB)/.ssh/config \
		$(HOMEDIR)/.zshrc \
		$(HOMEDIR)/.kerberos/krb5.conf \
		$(HOMEDIR)/.kerberos/krbtools-keytab \
		$(HOMEDIR)/.ssh/config


.PHONY: uninstall
uninstall:
	\rm -rfv $(DESTDIR)/lib/fnal-macos-config/fnal-macos-config-$(VERSION)
	\rm -dv $(DESTDIR)/lib/fnal-macos-config || true
	\rm -dv $(DESTDIR)/lib || true
	\rm -fv $(HOMEDIR)/.zshrc  || true
	\rm -fv $(HOMEDIR)/.kerberos/krb5.conf || true
	\rm -dv $(HOMEDIR)/.kerberos || true
	\rm -fv $(HOMEDIR)/.ssh/config || true
	\rm -dv $(HOMEDIR)/.ssh || true


$(HOMEDIR)/% : $(DESTDIR_LIB)/%
	install -dv $(dir $@)
	install -Tv $< $@

$(DESTDIR_LIB)/% : %
	install -dv $(dir $@)
	ln -sfrTv $< $@

%/ :
	mkdir -p $@
