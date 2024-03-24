# TODO

-   Consider running a mock install before performing the actual install to mitigate silly errors
    that preventing install from completing and leaving a half-installed state.
-   There is a potential issue/limitation with the MacOS configuration source files that relies on
    hard coded paths relative to the home direcory. When make install is ran, the HOMEDIR variable
    can be defined differently than ~, so hardcoded paths on the source files will be different.
    (It may be easiest to just make this a limiation and throw a warning when HOMEDIR is different
    than HOME). For instance, in `home/.zshrc`, `export KRB5_CONFIG=~/.kerberos/krb5.conf` is a hard
    coded path.
-   BUG: If `.zshrc` file already exists, the installer is not able to overwrite the file with the
    correct symbolic link
-   Should Linux and MacOS configurations both be in this repo?
