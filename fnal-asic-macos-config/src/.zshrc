# constants
_ZSHRC_LOCAL=~/.zshrc_local

# aliases
alias ls='ls --color=always'
alias ll='ls -al'
alias kload='kinit -R || kinit -ft ~/.kerberos/$(whoami).keytab ${KRB_PRINCIPAL}; klist'
alias ssh='kload; ssh'

# path
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

# prompt
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
    local branch=$(parse_git_branch)
    if [[ ${branch} == "" ]]; then
        echo ""
    elif [[ ${branch} == "(no branch)" ]]; then
        echo "[$(parse_git_remote):$(parse_git_tag)]"
    else
        echo "[$(parse_git_remote):${branch}]"
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
