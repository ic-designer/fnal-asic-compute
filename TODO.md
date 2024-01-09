# TODO

1.  Consider running a mock install before performing the actual install to mitigate silly errors
    that preventing install from completing and leaving a half-installed state.
2.  The linux configuration assumes that bin files go into ~/.local/bin. Would be better if the
    installation destination was configurable similar to LIBDIR and PREFIX
3.  There is a potential issue/limitation with the MacOS configuration source files that relies on
    hard coded paths relative to the home direcory. When make install is ran, the HOMEDIR variable
    can be defined differently than ~, so hardcoded paths on the source files will be different.
    (It may be easiest to just make this a limiation and throw a warning when HOMEDIR is different
    than HOME)
