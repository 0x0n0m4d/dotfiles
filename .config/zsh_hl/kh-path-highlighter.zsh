# Highlight the command word when it is an EXISTING file or directory.
# zsh-syntax-highlighting paints those red like a typo, because they are not
# commands. Missing paths stay red (the "main" highlighter already does that).
#
# Load AFTER zsh-syntax-highlighting, then enable it:
#   source ~/.config/zsh/existing-highlighter.zsh
#   ZSH_HIGHLIGHT_HIGHLIGHTERS=(main existing)

typeset -gA ZSH_HIGHLIGHT_STYLES
: ${ZSH_HIGHLIGHT_STYLES[existing-path]:=fg=blue}   # change the color here

_zsh_highlight_highlighter_existing_predicate() {
  _zsh_highlight_buffer_modified
}

_zsh_highlight_highlighter_existing_paint() {
  local -a words
  words=(${(z)BUFFER})
  (( $#words )) || return

  local word=$words[1]
  local lead=${BUFFER%%[^[:space:]]*}      # leading blanks before the word
  local start=$#lead
  local end=$(( start + $#word ))

  # a real command, alias, function or builtin keeps the main highlighter's color
  local bare=${(Q)word}
  (( $+commands[$bare] || $+aliases[$bare] || $+functions[$bare] || $+builtins[$bare] )) && return

  local file=$bare
  [[ $file == '~'* ]] && file=${file/#\~/$HOME}
  # executable files are already green ("command"); only paint what zsh calls an error
  if [[ -d $file || ( -e $file && ! -x $file ) ]]; then
    _zsh_highlight_add_highlight $start $end existing-path
  fi
}
