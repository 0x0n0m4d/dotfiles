set fish_greeting ""

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

# Rust
set -gx PATH ~/.cargo/bin $PATH

# foundryup
set -gx PATH ~/.foundry/bin $PATH

# aliases
alias g git
alias gt 'git status'
alias gd 'git diff'
alias ga 'git add'
alias gp 'git push'
alias gl 'git pull'
alias gc 'git commit'
command -qv nvim && alias vim nvim
