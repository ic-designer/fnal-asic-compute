# .bashrc for jfreden@fnal.gov

# Setup Trash
export TRASH=${HOME}/.local/share/Trash
export PYENV_ROOT=${HOME}/.local/lib/pyenv

# Aliases
alias grep='grep --color=auto'
alias ls='ls -h --color=auto'
alias ll='ls -al'
alias mv='mv -i'
alias rm="deprecate_rm"
alias del='\mkdir -p ${TRASH}; \mv --backup=t -t ${TRASH} $@'

# Paths
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

# get current branch in git repo
function parse_git_prompt() {
    local branch=$(parse_git_branch)
    if [[ ! ${branch} == "" ]]; then
        echo "[$(parse_git_remote):${branch}] "
    else
        echo ""
    fi
}

function parse_git_branch() {
	git branch 2> /dev/null | sed -e '/^[^*]/d' -e 's/* \(.*\)/\1/'
}

function parse_git_remote() {
	git remote -v 2> /dev/null | sed -n -e 's/origin\s*\(.*\:\)*\(.*\) .*(fetch).*/\2/p'
}

# get current status of git repo
function parse_git_status {
	status=`git status 2>&1 | tee`
	dirty=`echo -n "${status}" 2> /dev/null | grep "modified:" &> /dev/null; echo "$?"`
	untracked=`echo -n "${status}" 2> /dev/null | grep "Untracked files" &> /dev/null; echo "$?"`
	ahead=`echo -n "${status}" 2> /dev/null | grep "Your branch is ahead of" &> /dev/null; echo "$?"`
	newfile=`echo -n "${status}" 2> /dev/null | grep "new file:" &> /dev/null; echo "$?"`
	renamed=`echo -n "${status}" 2> /dev/null | grep "renamed:" &> /dev/null; echo "$?"`
	deleted=`echo -n "${status}" 2> /dev/null | grep "deleted:" &> /dev/null; echo "$?"`
	bits=''
	if [ "${renamed}" == "0" ]; then
		bits=">${bits}"
	fi
	if [ "${ahead}" == "0" ]; then
		bits="*${bits}"
	fi
	if [ "${newfile}" == "0" ]; then
		bits="+${bits}"
	fi
	if [ "${untracked}" == "0" ]; then
		bits="?${bits}"
	fi
	if [ "${deleted}" == "0" ]; then
		bits="x${bits}"
	fi
	if [ "${dirty}" == "0" ]; then
		bits="!${bits}"
	fi
	if [ ! "${bits}" == "" ]; then
		echo " ${bits}"
	else
		echo ""
	fi
}


COLOR_DEF=$'\[\e[0m\]'
COLOR_USR=$'\[\e[38;5;243m\]'
COLOR_DIR=$'\[\e[38;5;197m\]'
COLOR_GIT=$'\[\e[38;5;022m\]'
export PS1="[\!] ${COLOR_USR}\u@\h ${COLOR_GIT}\$(parse_git_prompt)${COLOR_DIR}\W${COLOR_DEF} -: "
