# ~/.zshrc file for zsh interactive shells.
# see /usr/share/doc/zsh/examples/zshrc for examples

setopt autocd              # change directory just by typing its name
#setopt correct            # auto correct mistakes
setopt interactivecomments # allow comments in interactive mode
setopt magicequalsubst     # enable filename expansion for arguments of the form ‘anything=expression’
setopt nonomatch           # hide error message if there is no match for the pattern
setopt notify              # report the status of background jobs immediately
setopt numericglobsort     # sort filenames numerically when it makes sense
setopt promptsubst         # enable command substitution in prompt

WORDCHARS=${WORDCHARS//\/} # Don't consider certain characters part of the word

# hide EOL sign ('%')
PROMPT_EOL_MARK=""

# configure key keybindings
bindkey -v                                        # emacs key bindings
bindkey ' ' magic-space                           # do history expansion on space
bindkey '^U' backward-kill-line                   # ctrl + U
bindkey '^[[3;5~' kill-word                       # ctrl + Supr
bindkey '^[[3~' delete-char                       # delete
bindkey '^[[1;5C' forward-word                    # ctrl + ->
bindkey '^[[1;5D' backward-word                   # ctrl + <-
bindkey '^[[5~' beginning-of-buffer-or-history    # page up
bindkey '^[[6~' end-of-buffer-or-history          # page down
bindkey '^[[H' beginning-of-line                  # home
bindkey '^[[F' end-of-line                        # end
bindkey '^[[Z' undo                               # shift + tab undo last action

# enable completion features
autoload -Uz compinit
compinit -d ~/.cache/zcompdump
zstyle ':completion:*:*:*:*:*' menu select
zstyle ':completion:*' auto-description 'specify: %d'
zstyle ':completion:*' completer _expand _complete
zstyle ':completion:*' format 'Completing %d'
zstyle ':completion:*' group-name ''
zstyle ':completion:*' list-colors ''
zstyle ':completion:*' list-prompt %SAt %p: Hit TAB for more, or the character to insert%s
zstyle ':completion:*' matcher-list 'm:{a-zA-Z}={A-Za-z}'
zstyle ':completion:*' rehash true
zstyle ':completion:*' select-prompt %SScrolling active: current selection at %p%s
zstyle ':completion:*' use-compctl false
zstyle ':completion:*' verbose true
zstyle ':completion:*:kill:*' command 'ps -u $USER -o pid,%cpu,tty,cputime,cmd'

# History configurations
HISTFILE=~/.zsh_history
HISTSIZE=1000
SAVEHIST=1000
setopt hist_expire_dups_first # delete duplicates first when HISTFILE size exceeds HISTSIZE
setopt hist_ignore_dups       # ignore duplicated commands history list
setopt hist_ignore_space      # ignore commands that start with space
setopt hist_verify            # show command with history expansion to user before running it
#setopt share_history         # share command history data

# force zsh to show the complete history
alias history="history 0"

# configure `time` format
TIMEFMT=$'\nreal\t%E\nuser\t%U\nsys\t%S\ncpu\t%P'

# make less more friendly for non-text input files, see lesspipe(1)
#[ -x /usr/bin/lesspipe ] && eval "$(SHELL=/bin/sh lesspipe)"

# set variable identifying the chroot you work in (used in the prompt below)
if [ -z "${debian_chroot:-}" ] && [ -r /etc/debian_chroot ]; then
    debian_chroot=$(cat /etc/debian_chroot)
fi

# set a fancy prompt (non-color, unless we know we "want" color)
case "$TERM" in
    xterm-color|*-256color) color_prompt=yes;;
esac

# uncomment for a colored prompt, if the terminal has the capability; turned
# off by default to not distract the user: the focus in a terminal window
# should be on the output of commands, not on the prompt
force_color_prompt=yes

if [ -n "$force_color_prompt" ]; then
    if [ -x /usr/bin/tput ] && tput setaf 1 >&/dev/null; then
        # We have color support; assume it's compliant with Ecma-48
        # (ISO/IEC-6429). (Lack of such support is extremely rare, and such
        # a case would tend to support setf rather than setaf.)
        color_prompt=yes
    else
        color_prompt=
    fi
fi

git_branch() {
    res=$(git rev-parse --abbrev-ref HEAD 2>/dev/null)
    if [ -n "$res" ]; then
        echo "(%B%F{#cc3900}$res%b%F{reset})"
    fi
}

virtual_env() {
    if [[ -n $VIRTUAL_ENV ]]; then
        echo "(%B%F{11}$(basename $VIRTUAL_ENV)%b%f)"
    fi
}

cmd_time() {
    if [[ $elapsed -gt 0 ]]; then
        echo " ${elapsed}s"
    fi
}

VI_MODE_INDICATOR="(%F{yellow}i%f)"

function zvm_after_select_vi_mode() {
    case $ZVM_MODE in
        $ZVM_MODE_NORMAL)
            VI_MODE_INDICATOR="(%F{blue}n%f)"
            ;;
        $ZVM_MODE_INSERT)
            VI_MODE_INDICATOR="(%F{yellow}i%f)"
            ;;
        $ZVM_MODE_VISUAL)
            VI_MODE_INDICATOR="(%F{magenta}v%f)"
            ;;
        $ZVM_MODE_VISUAL_LINE)
            VI_MODE_INDICATOR="(%F{magenta}V%f)"
            ;;
        $ZVM_MODE_REPLACE)
            VI_MODE_INDICATOR="(%F{red}r%f)"
            ;;
    esac

    zle && zle .reset-prompt
}

configure_prompt() {
    prompt_symbol=㉿
    # Skull emoji for root terminal
    #[ "$EUID" -eq 0 ] && prompt_symbol=💀
    case "$PROMPT_ALTERNATIVE" in
        twoline)
            PROMPT=$'%F{%(#.blue.green)}┌──${debian_chroot:+($debian_chroot)─}${VIRTUAL_ENV:+($(basename $VIRTUAL_ENV))─}(%B%F{%(#.red.blue)}%n'$prompt_symbol$'%m%b%F{%(#.blue.green)})-[%B%F{reset}%(6~.%-1~/…/%4~.%5~)%b%F{%(#.blue.green)}]\n└─%B%(#.%F{red}#.%F{blue}$)%b%F{reset} '
            # Right-side prompt with exit codes and background processes
            ;;
        oneline)
            PROMPT=$'$(virtual_env)%B%F{1}%n%b%F{reset}${VI_MODE_INDICATOR}%B%F{2}%m%b%F{reset}:%B%F{4}%1~%b%F{reset}$(git_branch)%(#.#.$) '
            RPROMPT=$'%(?.. %? %F{red}%B⨯%b%F{reset})%(1j. %j %F{yellow}%B⚙%b%F{reset}.)$(cmd_time)'
            ;;
        backtrack)
            PROMPT=$'${debian_chroot:+($debian_chroot)}${VIRTUAL_ENV:+($(basename $VIRTUAL_ENV))}%B%F{red}%n㉿%m%b%F{reset}:%B%F{blue}%~%b%F{reset}%(#.#.$) '
            RPROMPT=
            ;;
    esac
    unset prompt_symbol
}

# The following block is surrounded by two delimiters.
# These delimiters must not be modified. Thanks.
# START KALI CONFIG VARIABLES
PROMPT_ALTERNATIVE=oneline
NEWLINE_BEFORE_PROMPT=no
# STOP KALI CONFIG VARIABLES

if [ "$color_prompt" = yes ]; then
    # override default virtualenv indicator in prompt
    VIRTUAL_ENV_DISABLE_PROMPT=1

    configure_prompt

    # enable syntax-highlighting
    if [ -f /usr/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh ]; then
        . /usr/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
        ZSH_HIGHLIGHT_HIGHLIGHTERS=(main brackets pattern)
        ZSH_HIGHLIGHT_STYLES[default]=none
        ZSH_HIGHLIGHT_STYLES[unknown-token]=fg=1
        ZSH_HIGHLIGHT_STYLES[reserved-word]=fg=6,bold
        ZSH_HIGHLIGHT_STYLES[suffix-alias]=fg=4,underline
        ZSH_HIGHLIGHT_STYLES[global-alias]=fg=4,bold
        ZSH_HIGHLIGHT_STYLES[precommand]=fg=4,underline
        ZSH_HIGHLIGHT_STYLES[commandseparator]=fg=5,bold
        ZSH_HIGHLIGHT_STYLES[autodirectory]=fg=4,underline
        ZSH_HIGHLIGHT_STYLES[path]=fg=4,bold
        ZSH_HIGHLIGHT_STYLES[path_pathseparator]=
        ZSH_HIGHLIGHT_STYLES[path_prefix_pathseparator]=
        ZSH_HIGHLIGHT_STYLES[globbing]=fg=4,bold
        ZSH_HIGHLIGHT_STYLES[history-expansion]=fg=blue,bold
        ZSH_HIGHLIGHT_STYLES[command-substitution]=none
        ZSH_HIGHLIGHT_STYLES[command-substitution-delimiter]=fg=3,bold
        ZSH_HIGHLIGHT_STYLES[process-substitution]=none
        ZSH_HIGHLIGHT_STYLES[process-substitution-delimiter]=fg=3,bold
        ZSH_HIGHLIGHT_STYLES[single-hyphen-option]=fg=6
        ZSH_HIGHLIGHT_STYLES[double-hyphen-option]=fg=6
        ZSH_HIGHLIGHT_STYLES[back-quoted-argument]=none
        ZSH_HIGHLIGHT_STYLES[back-quoted-argument-delimiter]=fg=4,bold
        ZSH_HIGHLIGHT_STYLES[single-quoted-argument]=fg=6
        ZSH_HIGHLIGHT_STYLES[double-quoted-argument]=fg=6
        ZSH_HIGHLIGHT_STYLES[dollar-quoted-argument]=fg=6
        ZSH_HIGHLIGHT_STYLES[rc-quote]=fg=3
        ZSH_HIGHLIGHT_STYLES[dollar-double-quoted-argument]=fg=5,bold
        ZSH_HIGHLIGHT_STYLES[back-double-quoted-argument]=fg=5,bold
        ZSH_HIGHLIGHT_STYLES[back-dollar-quoted-argument]=fg=5,bold
        ZSH_HIGHLIGHT_STYLES[assign]=fg=5
        ZSH_HIGHLIGHT_STYLES[redirection]=fg=6,bold
        ZSH_HIGHLIGHT_STYLES[comment]=fg=7,bold
        ZSH_HIGHLIGHT_STYLES[named-fd]=none
        ZSH_HIGHLIGHT_STYLES[numeric-fd]=fg=2,bold
        ZSH_HIGHLIGHT_STYLES[arg0]=fg=2,bold
        ZSH_HIGHLIGHT_STYLES[bracket-error]=fg=1,bold
        ZSH_HIGHLIGHT_STYLES[bracket-level-1]=fg=blue,bold
        ZSH_HIGHLIGHT_STYLES[bracket-level-2]=fg=green,bold
        ZSH_HIGHLIGHT_STYLES[bracket-level-3]=fg=magenta,bold
        ZSH_HIGHLIGHT_STYLES[bracket-level-4]=fg=yellow,bold
        ZSH_HIGHLIGHT_STYLES[bracket-level-5]=fg=cyan,bold
        ZSH_HIGHLIGHT_STYLES[cursor-matchingbracket]=standout
    fi
else
    PROMPT='${debian_chroot:+($debian_chroot)}%n@%m:%~%(#.#.$) '
fi
unset color_prompt force_color_prompt

toggle_oneline_prompt(){
    if [ "$PROMPT_ALTERNATIVE" = oneline ]; then
        PROMPT_ALTERNATIVE=twoline
    else
        PROMPT_ALTERNATIVE=oneline
    fi
    configure_prompt
    zle reset-prompt
}
zle -N toggle_oneline_prompt
bindkey ^P toggle_oneline_prompt

# If this is an xterm set the title to user@host:dir
case "$TERM" in
xterm*|rxvt*|Eterm|aterm|kterm|gnome*|alacritty)
    TERM_TITLE=$'\e]0;${debian_chroot:+($debian_chroot)}${VIRTUAL_ENV:+($(basename $VIRTUAL_ENV))}%n@%m: %~\a'
    ;;
*)
    ;;
esac

preexec() {
    timer=${timer:-$SECONDS}
}

precmd() {
    # Print the previously configured title
    print -Pnr -- "$TERM_TITLE"

    # Print a new line before the prompt, but only if it is not the first line
    if [ "$NEWLINE_BEFORE_PROMPT" = yes ]; then
        if [ -z "$_NEW_LINE_BEFORE_PROMPT" ]; then
            _NEW_LINE_BEFORE_PROMPT=1
        else
            print ""
        fi
    fi

    if [ $timer ]; then
        elapsed=$((SECONDS - timer))
        unset timer
    fi
}

# enable color support of ls, less and man, and also add handy aliases
if [ -x /usr/bin/dircolors ]; then
    test -r ~/.dircolors && eval "$(dircolors -b ~/.dircolors)" || eval "$(dircolors -b)"
    export LS_COLORS="$LS_COLORS:ow=30;44:" # fix ls color for folders with 777 permissions

    alias ls='ls --color=auto'
    #alias dir='dir --color=auto'
    #alias vdir='vdir --color=auto'

    alias grep='grep --color=auto'
    alias fgrep='fgrep --color=auto'
    alias egrep='egrep --color=auto'
    alias diff='diff --color=auto'
    alias ip='ip --color=auto'

    export LESS_TERMCAP_mb=$'\E[1;31m'     # begin blink
    export LESS_TERMCAP_md=$'\E[1;36m'     # begin bold
    export LESS_TERMCAP_me=$'\E[0m'        # reset bold/blink
    export LESS_TERMCAP_so=$'\E[01;33m'    # begin reverse video
    export LESS_TERMCAP_se=$'\E[0m'        # reset reverse video
    export LESS_TERMCAP_us=$'\E[1;32m'     # begin underline
    export LESS_TERMCAP_ue=$'\E[0m'        # reset underline

    # Take advantage of $LS_COLORS for completion as well
    zstyle ':completion:*' list-colors "${(s.:.)LS_COLORS}"
    zstyle ':completion:*:*:kill:*:processes' list-colors '=(#b) #([0-9]#)*=0=01;31'
fi

# enable auto-suggestions based on the history
if [ -f /usr/share/zsh-autosuggestions/zsh-autosuggestions.zsh ]; then
    . /usr/share/zsh-autosuggestions/zsh-autosuggestions.zsh
    # change suggestion color
    ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE='fg=#999'
fi

# enable command-not-found if installed
if [ -f /etc/zsh_command_not_found ]; then
    . /etc/zsh_command_not_found
fi

export EDITOR='nvim'
# aliases
alias ll='eza -laB --group -s extension --icons=always --group-directories-first'
alias tree='eza -la -s extension --icons=always -T'
alias v='nvim'
alias cal='ncal -b'
alias cat='batcat --theme "gruvbox-dark" -p'
alias xcp='xclip -sel c'
alias clipui='copyq show "&clipboard"'
alias cl='copyq select 0'
alias icat='kitten icat'
alias cha='cha -V'

math() {
    bc -l <<< "$@"
}

jwtd() {
    jq -R 'split(".") | .[0],.[1] | @base64d | fromjson' <<<$1
    echo -e "\nSignature: $(awk -F. '{print $3}' <<<$1)"
}

# path
export PATH=$HOME/.local/share/gem/ruby/3.3.0/bin:$PATH
export PATH=$HOME/.cargo/bin:$PATH
export PATH=/usr/local/go/bin:$PATH
export PATH=$HOME/go/bin:$PATH

# zig
export PATH=/opt/zig:$PATH

# Better vim
ZVM_CURSOR_STYLE_ENABLED=false
source $HOME/.config/zsh-vi-mode/zsh-vi-mode.plugin.zsh
ZVM_VI_HIGHLIGHT_BACKGROUND=default
ZVM_VI_HIGHLIGHT_FOREGROUND=default
ZVM_VI_HIGHLIGHT_EXTRASTYLE=standout

# pnpm
export PNPM_HOME="/home/n0m4d/.local/share/pnpm"
case ":$PATH:" in
  *":$PNPM_HOME:"*) ;;
  *) export PATH="$PNPM_HOME:$PATH" ;;
esac

# nim
export CHA_LIBEXEC_DIR="/usr/local/libexec/chawan"
export PATH=$PATH:/home/n0m4d/.nimble/bin

# man
export MANPAGER="batcat -plman --theme 'gruvbox-dark'"

# kitty
autoload -Uz edit-command-line
zle -N edit-command-line
function kitty_scrollback_edit_command_line() {
  local VISUAL='/home/n0m4d/.local/share/nvim/lazy/kitty-scrollback.nvim/scripts/edit_command_line.sh'
  zle edit-command-line
  zle kill-whole-line
}
zle -N kitty_scrollback_edit_command_line
