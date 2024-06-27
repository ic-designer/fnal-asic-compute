# constants
_BASHRC_LOCAL=~/.bashrc_local
export TRASH=${HOME}/.local/share/Trash

# includes
source ~/.git-parse.bash
source ~/.git-completion.bash

# aliases
alias grep='grep --color=auto'
alias ls='ls -h --color=auto'
alias ll='ls -al'
alias mv='mv -i'
alias rm="deprecate_rm"
alias del='\mkdir -p ${TRASH}; \mv --backup=t -t ${TRASH} $@'

# config
if xhost >/dev/null 2>&1; then
	xset -b r
    xset r on
fi

# paths
pathmunge () {
    case ":${PATH}:" in
        *:"$1":*)
            ;;
        *)
            PATH=$1:${PATH}
            ;;
    esac
}
pathmunge /asic/cad/vscode/VSCode-linux-x64/bin
pathmunge ~/.local/bin
pathmunge .

if [[ -d $PYENV_ROOT ]]; then
	command -v pyenv >/dev/null || pathmunge $PYENV_ROOT/bin
	eval "$(pyenv init -)"
	eval "$(pyenv virtualenv-init -)"
fi

# Change the power management screen sessing
gsettings set org.gnome.desktop.session idle-delay 600 > /dev/null 2>&1
gsettings set org.gnome.desktop.screensaver lock-delay 0 > /dev/null 2>&1

# Improve usability of Cadence tools
gsettings set org.cinnamon.desktop.keybindings.wm switch-group [] > /dev/null 2>&1
gsettings set org.gnome.desktop.wm.keybindings switch-group [] > /dev/null 2>&1
gsettings set org.gnome.desktop.wm.keybindings switch-group-backwards [] > /dev/null 2>&1


# Provide depracation warning with bad return code
function deprecate_rm() {
	echo "bash: rm: use 'del' command instead."
	alias del
	echo ""
	return 2
}


COLOR_DEF=$'\[\e[0m\]'
COLOR_USR=$'\[\e[38;5;243m\]'
COLOR_DIR=$'\[\e[38;5;208m\]'
COLOR_GIT=$'\[\e[38;5;022m\]'
export PS1="[\!] ${COLOR_USR}\u@\h ${COLOR_GIT}\$(git_parse_prompt)${COLOR_DIR}\W${COLOR_DEF} -: "

# local overrides
if [[ -f ${_BASHRC_LOCAL} ]]; then
    source ${_BASHRC_LOCAL}
fi
