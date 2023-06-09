#!/usr/bin/env bash

(
    set -x
    ktutil -k ~/.kerberos/jfreden.keytab add -p jfreden@FNAL.GOV -e aes256-cts-hmac-sha1-96 -V 1
)
