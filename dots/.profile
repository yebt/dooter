alias nv="nvim"
alias sudo="sudo "
alias ls="ls --color=auto"
alias rgr="ranger"
alias x="exa"


export PATH=~/.npm-global/bin:$PATH
export PATH=~/.local/bin:$PATH

#export DOCKER_HOST=unix:///run/user/1000/podman/podman.sock 
export DOCKER_HOST=unix://$XDG_RUNTIME_DIR/podman/podman.sock # activate with system

# in us mode key
#xmodmap ~/.Xmodmap
