# constants
_ZSHRC_LOCAL=~/.zshrc_local
export KRB5_CONFIG=~/.kerberos/krb5.conf
export KRB5_KTNAME=~/.kerberos/$(whoami).keytab

# aliases
alias kload='/usr/bin/kinit -R || /usr/bin/kinit -ft ${KRB5_KTNAME} ${KRB5_PRINCIPAL}; /usr/bin/klist -v'
alias ll='ls -al'
alias ls='ls --color=always'

# paths
pathmunge () {
    case ":${PATH}:" in
        *:"$1":*)
            ;;
        *)
            export PATH=$1:${PATH}
            ;;
    esac
}
pathmunge ~/.local/bin
pathmunge .

#cron
cronmunge () {
    job=$1
    tag=$2

    cronjobs=$(crontab -l 2>/dev/null)
    case "$cronjobs" in
        *"$job $tag"*)
            ;;
        *)
            filtered=$(crontab -l 2>/dev/null || true | grep -v "$tag")
            (echo "$filtered"; echo "$job $tag") | crontab -
            ;;
    esac
}
cronmunge "0 */2 * * * /usr/bin/kinit -R || /usr/bin/kinit -ft $(realpath ${KRB5_KTNAME}) ${KRB5_PRINCIPAL}" "#TAG:kesrberos-tokens"

# kerberos
kload

# git
autoload -Uz compinit && compinit

function parse_git_branch () {
    git branch 2> /dev/null | sed -n -e 's/^\* \(.*\)/\1/p'
}

function parse_git_remote () {
   git remote -v 2> /dev/null | sed -n -e 's/origin\s*\(.*\:\)*\(.*\) .*(fetch).*/\2/p'
}

function parse_git_tag () {
    git describe --always 2> /dev/null
}

function parse_git_prompt () {
    local git_branch=$(parse_git_branch)
    if [[ ${git_branch} == "" ]]; then
        echo ""
    elif [[ ${git_branch} == "(no branch)" ]]; then
        echo "[$(parse_git_remote):$(parse_git_tag)$(parse_git_status)]"
    else
        echo "[$(parse_git_remote):${git_branch}$(parse_git_status)]"
    fi
}

function parse_git_status {
	local git_status=`git status 2>&1 | tee`
	local dirty=`echo -n "${git_status}" 2> /dev/null | grep "modified:" &> /dev/null; echo "$?"`
	local untracked=`echo -n "${git_status}" 2> /dev/null | grep "Untracked files" &> /dev/null; echo "$?"`
	local newfile=`echo -n "${git_status}" 2> /dev/null | grep "new file:" &> /dev/null; echo "$?"`
	local renamed=`echo -n "${git_status}" 2> /dev/null | grep "renamed:" &> /dev/null; echo "$?"`
	local deleted=`echo -n "${git_status}" 2> /dev/null | grep "deleted:" &> /dev/null; echo "$?"`
	local bits=''
	if [[ "${renamed}" == "0" ]]; then
		bits=">${bits}"
	fi
	if [[ "${newfile}" == "0" ]]; then
		bits="+${bits}"
	fi
	if [[ "${untracked}" == "0" ]]; then
		bits="?${bits}"
	fi
	if [[ "${deleted}" == "0" ]]; then
		bits="x${bits}"
	fi
	if [[ "${dirty}" == "0" ]]; then
		bits="!${bits}"
	fi
	if [[ ! "${bits}" == "" ]]; then
		echo " ${bits}"
	else
		echo ""
	fi
}

COLOR_DEF=$'%{\e[0m%}'
COLOR_USR=$'%{\e[38;5;243m%}'
COLOR_DIR=$'%{\e[38;5;197m%}'
COLOR_GIT=$'%{\e[38;5;022m%}'
setopt PROMPT_SUBST
export PROMPT='${COLOR_USR}%n ${COLOR_DIR}%1~ ${COLOR_GIT}$(parse_git_prompt)${COLOR_DEF} $ '

# local overrides
if [[ -f ${_ZSHRC_LOCAL} ]]; then
    source ${_ZSHRC_LOCAL}
fi
