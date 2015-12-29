# Autocompletion
source /opt/arcanist/resources/shell/bash-completion
source /opt/git-completion.bash
source /etc/bash_completion.d/mercurial
source /etc/bash_completion.d/subversion

# Prompt - Git information
source /etc/bash_completion.d/git-prompt 
PS1='[\u@\h \W$(__git_ps1 " (%s)")]\$ '
GIT_PS1_SHOWDIRTYSTATE=1
GIT_PS1_SHOWUNTRACKEDFILES=1
GIT_PS1_SHOWUPSTREAM="auto"
GIT_PS1_SHOWCOLORHINTS=1
