# TODO

1.  Think about how to pull install version from the repo.
2.  Consider putting all the shared makefile recipes in another repo.
3.  Consider running a mock install before performing the actual install to mitigate silly errors
    that preventing install from completing and leaving a half-installed state.
4.  Consider updating the constants to include some of the ideas here: https://www.gnu.org/prep/standards/html_node/Directory-Variables.html
5.  The linux configuration assumes that bin files go into ~/.local/bin. Would be better if the installation destination was configurable.
