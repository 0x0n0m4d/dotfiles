set fish_greeting

set -gx TERM xterm-256color

# Handy change dir shortcuts
abbr .. 'cd ..'
abbr ... 'cd ../..'
abbr .3 'cd ../../..'
abbr .4 'cd ../../../..'
abbr .5 'cd ../../../../..'

# Always mkdir a path (this doesn't inhibit functionality to make a single dir)
abbr mkdir 'mkdir -p'

set -gx EDITOR nvim

set -gx PATH bin $PATH
set -gx PATH ~/bin $PATH
set -gx PATH ~/.local/bin $PATH

# rust
set -gx PATH ~/.cargo/bin $PATH

# golang
set -gx GOPATH ~/go/
set -gx PATH $GOPATH/bin/ $PATH

# foundryup
set -gx PATH ~/.foundry/bin $PATH

# aliases
alias g git
alias gt 'git status'
alias ga 'git add'
alias gp 'git push'
alias gl 'git pull'
alias gc 'git commit'
command -qv nvim && alias vim nvim

# pyenv
set PYENV_ROOT $HOME/.pyenv
set -x PATH $PYENV_ROOT/shims $PYENV_ROOT/bin $PATH
pyenv rehash

export PATH="$PATH:/home/n0m4d/.local/bin"
