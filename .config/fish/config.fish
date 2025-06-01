set fish_greeting
set -Ua fish_features no-keyboard-protocols

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
set -gx PATH $PATH ~/.cargo/bin

# golang
set -gx GOPATH ~/go/
set -gx PATH $PATH $GOPATH/bin/

# foundryup
set -gx PATH $PATH ~/.foundry/bin

# aliases
alias g git
alias gt 'git status'
alias ga 'git add'
alias gp 'git push'
alias gl 'git pull'
alias gc 'git commit'
command -qv nvim && alias vim nvim

# Virus Total
set -gx VT_APIKEY ba6f75cfca4f9a6cf8cd15a620ffaf6ed57efec588f32200b4e9123e0ce4dbd0

# pyenv
set PYENV_ROOT $HOME/.pyenv
set -gx PATH $PATH $PYENV_ROOT/shims $PYENV_ROOT/bin
pyenv rehash

export PATH="$PATH:/home/n0m4d/.local/bin"
