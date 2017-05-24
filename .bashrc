alias g=git
alias hig="history|grep"

## Colors?  Used for the prompt.
RED='\[\e[0;31m\]'
GREEN='\[\e[0;32m\]'
BYELLOW='\[\e[1;33m\]'
BWHITE='\[\e[1;37m\]'
GREEN='\[\e[0;32m\]'
BGREEN='\[\e[1;32m\]'
BGGREEN='\[\e[1;32m\]'

PROMPT_COMMAND=smile_prompt

# get current branch in git repo
function parse_git_branch() {
	BRANCH=`git branch 2> /dev/null | sed -e '/^[^*]/d' -e 's/* \(.*\)/\1/'`
	if [ ! "${BRANCH}" == "" ]
	then
		STAT=`parse_git_dirty`
		echo "[${BRANCH}${STAT}]"
	else
		echo ""
	fi
}

# get current status of git repo
function parse_git_dirty {
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

function smile_prompt {
	if [ "$?" -eq "0" ]; then
		#smiley
		SC="${GREEN}:)"
	else
		#frowney
		SC="${RED}:("
	fi
	if [ $UID -eq 0 ]; then
		#root user color
		UC="${RED}"
	else
		#normal user color
		UC="${BWHITE}"
	fi
	#hostname color
	HC="${BYELLOW}"

	#regular color
	RC="${BWHITE}"

	#default color
	DF='\[\e[0m\]'

	PS1="\n[\[\e[32m\]\u\[\e[m\]@\[\e[36m\]\h \W]\e[33m\]\`parse_git_branch\` \n${SC}${DF} $ "
}