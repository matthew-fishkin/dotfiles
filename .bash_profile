# Set up path
export PATH=/usr/local/mysql/bin:$PATH
export CLASSPATH=/usr/local/lib:$CLASSPATH

# mysql aliases
alias mysql=/usr/local/mysql/bin/mysql
alias mysqladmin=/usr/local/mysql/bin/mysqladmin

# Config alias to manage dotfiles in home directory
# usage: cfg status
alias cnfig='/usr/bin/git --git-dir=$HOME/.cfg/ --work-tree=$HOME'
cnfig config --local status.showUntrackedFiles no

# iTerm functions to use for badge
function iterm2_print_user_vars() {
  iterm2_set_user_var gitBranch $((git branch 2> /dev/null) | grep \* | cut -c3-)
  iterm2_set_user_var gitRepo $((git remote show origin 2> /dev/null) | grep "Fetch URL:" | cut -c14-)
}
test -e "${HOME}/.iterm2_shell_integration.bash" && source "${HOME}/.iterm2_shell_integration.bash"