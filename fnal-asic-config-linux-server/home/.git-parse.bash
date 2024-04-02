# get current branch in git repo
function git_parse_prompt() {
    local branch=$(parse_git_branch)
    if [[ ! ${branch} == "" ]]; then
        echo "[$(parse_git_remote):${branch}$(parse_git_status)] "
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
	local git_status=`git status 2>&1 | tee`
	local dirty=`echo -n "${git_status}" 2> /dev/null | grep "modified:" &> /dev/null; echo "$?"`
	local untracked=`echo -n "${git_status}" 2> /dev/null | grep "Untracked files" &> /dev/null; echo "$?"`
	local newfile=`echo -n "${git_status}" 2> /dev/null | grep "new file:" &> /dev/null; echo "$?"`
	local renamed=`echo -n "${git_status}" 2> /dev/null | grep "renamed:" &> /dev/null; echo "$?"`
	local deleted=`echo -n "${git_status}" 2> /dev/null | grep "deleted:" &> /dev/null; echo "$?"`
	local bits=''
	if [ "${renamed}" == "0" ]; then
		bits=">${bits}"
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
