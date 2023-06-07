# load completions
if [ -f /etc/bash_completion ]; then
  source /etc/bash_completion
fi
if [ -f /usr/share/bash-completion/bash_completion ]; then
  source /usr/share/bash-completion/bash_completion
fi
# load profile
source ~/.profile
# laod fzf 
[ -f ~/.fzf.bash ] && source ~/.fzf.bash
