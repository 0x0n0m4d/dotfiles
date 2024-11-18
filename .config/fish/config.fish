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

# neovim
set -gx PATH /opt/nvim-linux64/bin $PATH

# rust
set -gx PATH ~/.cargo/bin $PATH

# golang
set -gx GOPATH ~/go/
set -gx PATH $GOPATH/bin/ $PATH
source $GOPATH/pkg/mod/github.com/tomnomnom/gf@v0.0.0-20200618134122-dcd4c361f9f5/gf-completion.fish

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

# pnpm
set -gx PNPM_HOME "/home/d3m0n/.local/share/pnpm"
if not string match -q -- $PNPM_HOME $PATH
    set -gx PATH "$PNPM_HOME" $PATH
end

# bun
set --export BUN_INSTALL "$HOME/.bun"
set --export PATH $BUN_INSTALL/bin $PATH

# pyenv
set PYENV_ROOT $HOME/.pyenv
set -x PATH $PYENV_ROOT/shims $PYENV_ROOT/bin $PATH
pyenv rehash

# asdf
source ~/.asdf/asdf.fish

fish_add_path /home/d3m0n/.spicetify

export PATH="$PATH:/home/d3m0n/.local/bin"
