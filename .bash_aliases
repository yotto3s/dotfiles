alias la="ls -a"
alias lt="ls -t"

if [[ $(command -v exa) ]]; then
    alias e='exa --icons'
    alias l=e
    alias ls=e
    alias ea='exa -a --icons'
    alias la=ea
    alias ee='exa -aal --icons'
    alias ll=ee
    alias et='exa -T -L 3 -a -I "node_modules|.git|.chache" --icons'
    alias lt=et
    alias eta='exa -T -a -I "node_modules|.git|.cache" --color=always --icons |less -r'
    alias lta=eta
fi

if [[ $(command -v eza) ]]; then
    alias e='eza --icons'
    alias l=e
    alias ls=e
    alias ea='eza -a --icons'
    alias la=ea
    alias ee='eza -aal --icons'
    alias ll=ee
    alias et='eza -T -L 3 -a -I "node_modules|.git|.chache" --icons'
    alias lt=et
    alias eta='eza -T -a -I "node_modules|.git|.cache" --color=always --icons |less -r'
    alias lta=eta
fi

if [[ $(command -v dust) ]]; then
    alias du=dust
fi

# if [[ $(command -v bat) ]]; then
    # alias cat=bat
# fi

# if [[ $(command -v fd) ]]; then
#    alias find=fd
# fi

if [[ $(command -v duf) ]]; then
    alias df=duf
fi

if [[ $(command -v procs) ]]; then
    alias ps=procs
fi

if [[ $(command -v bottom) ]]; then
    alias top=bottom
fi

if [[ -e ${HOME}/.local/bin/nvim ]]; then
    alias nvim=${HOME}/.local/bin/nvim
fi
