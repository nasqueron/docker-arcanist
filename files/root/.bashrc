# Autocompletion
source /opt/arcanist/support/shell/hooks/bash-completion.sh
source /opt/git-completion.bash

# Prompt - Git information
source /opt/git-prompt.sh
PS1='[\u@\h \W$(__git_ps1 " (%s)")]\$ '
GIT_PS1_SHOWDIRTYSTATE=1
GIT_PS1_SHOWUNTRACKEDFILES=1
GIT_PS1_SHOWUPSTREAM="auto"
GIT_PS1_SHOWCOLORHINTS=1
