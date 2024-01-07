# TODO

1.  Consider putting all the shared makefile recipes in another repo.
2.  Consider running a mock install before performing the actual install to mitigate silly errors
    that preventing install from completing and leaving a half-installed state.
3.  The linux configuration assumes that bin files go into ~/.local/bin. Would be better if the
    installation destination was configurable.
