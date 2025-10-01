set fish_greeting
set -Ua fish_features no-keyboard-protocols

set -Ux TERM xterm-256color

# Handy change dir shortcuts
abbr .. 'cd ..'
abbr ... 'cd ../..'
abbr .3 'cd ../../..'
abbr .4 'cd ../../../..'
abbr .5 'cd ../../../../..'

# Always mkdir a path (this doesn't inhibit functionality to make a single dir)
abbr mkdir 'mkdir -p'

set -gx EDITOR nvim

# python
set PYENV_ROOT $HOME/.pyenv
set -gx PATH $PATH $PYENV_ROOT/shims $PYENV_ROOT/bin
pyenv rehash

# rust
set -gx PATH $PATH $HOME/.cargo/bin

# golang
set -gx GOROOT /usr/local/go/
set -gx GOPATH $HOME/go/
set -gx PATH $PATH $GOPATH/bin/

set -gx PATH $HOME/.local/bin $PATH
# aliases
alias g git
alias gt 'git status'
alias ga 'git add'
alias gp 'git push'
alias gl 'git pull'
alias gc 'git commit'
command -qv nvim && alias vim nvim
