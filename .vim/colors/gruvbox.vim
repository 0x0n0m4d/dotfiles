" Name:         gruvboxed
" Last Change:  2026 Aug 07

set background=dark

hi clear
let g:colors_name = 'gruvbox'

let s:t_Co = has('gui_running') ? 16777216 : str2nr(&t_Co)
let s:tgc = has('termguicolors') && &termguicolors

let g:terminal_ansi_colors = ['#282828', '#cc241d', '#98971a', '#d79921', '#458588', '#b16286', '#689d6a', '#a89984', '#928374', '#fb4934', '#b8bb26', '#fabd2f', '#83a598', '#d3869b', '#8ec07c', '#ebdbb2']

hi! link CursorLineFold FoldColumn
hi! link CursorLineSign SignColumn
hi! link Define Identifier
hi! link Delimiter PreProc
hi! link Float Number
hi! link Label String
hi! link MessageWindow Pmenu
hi! link Number Constant
hi! link Operator PreProc
hi! link PopupNotification Todo
hi! link StatusLineTerm StatusLine
hi! link StatusLineTermNC StatusLineNC
hi! link StorageClass PreProc
hi! link Structure PreProc
hi! link TabPanel Normal
hi! link TabPanelFill Normal
hi! link Terminal Normal

hi Normal guifg=#ebdbb2 guibg=#282828 guisp=NONE gui=NONE ctermfg=223 ctermbg=235 cterm=NONE term=NONE
hi Added guifg=#b8bb26 guibg=NONE guisp=NONE gui=NONE ctermfg=142 ctermbg=NONE cterm=NONE term=NONE
hi Changed guifg=#fabd2f guibg=NONE guisp=NONE gui=NONE ctermfg=214 ctermbg=NONE cterm=NONE term=NONE
hi Character guifg=#d3869b guibg=NONE guisp=NONE gui=NONE ctermfg=175 ctermbg=NONE cterm=NONE term=NONE
hi ColorColumn guifg=NONE guibg=#504945 guisp=NONE gui=NONE ctermfg=NONE ctermbg=239 cterm=NONE term=reverse
hi Comment guifg=#7c6f64 guibg=NONE guisp=NONE gui=NONE ctermfg=245 ctermbg=NONE cterm=NONE term=bold
hi Conceal guifg=#a89984 guibg=NONE guisp=NONE gui=NONE ctermfg=246 ctermbg=NONE cterm=NONE term=NONE
hi Constant guifg=#d3869b guibg=NONE guisp=NONE gui=NONE ctermfg=175 ctermbg=NONE cterm=NONE term=NONE
hi CurSearch guifg=#b8bb26 guibg=#282828 guisp=NONE gui=reverse ctermfg=142 ctermbg=235 cterm=reverse term=reverse
hi CursorColumn guifg=NONE guibg=#3c3836 guisp=NONE gui=NONE ctermfg=NONE ctermbg=237 cterm=NONE term=NONE
hi CursorLine guifg=NONE guibg=#3c3836 guisp=NONE gui=NONE ctermfg=NONE ctermbg=237 cterm=NONE term=underline
hi CursorLineNr guifg=#fabd2f guibg=NONE guisp=NONE gui=bold ctermfg=214 ctermbg=NONE cterm=bold term=bold
hi Debug guifg=#fe8019 guibg=NONE guisp=NONE gui=NONE ctermfg=208 ctermbg=NONE cterm=NONE term=NONE
hi DiffAdd guifg=#b8bb26 guibg=NONE guisp=NONE gui=reverse ctermfg=142 ctermbg=NONE cterm=reverse term=reverse
hi DiffChange guifg=#458588 guibg=NONE guisp=NONE gui=reverse ctermfg=66 ctermbg=NONE cterm=reverse term=NONE
hi DiffDelete guifg=#cc241d guibg=NONE guisp=NONE gui=reverse ctermfg=124 ctermbg=NONE cterm=reverse term=reverse
hi DiffText guifg=#b16286 guibg=NONE guisp=NONE gui=reverse ctermfg=132 ctermbg=NONE cterm=reverse term=reverse
hi Directory guifg=#8ec07c guibg=NONE guisp=NONE gui=bold ctermfg=108 ctermbg=NONE cterm=bold term=NONE
hi EndOfBuffer guifg=#665c54 guibg=NONE guisp=NONE gui=NONE ctermfg=241 ctermbg=NONE cterm=NONE term=NONE
hi Error guifg=#fb4934 guibg=#282828 guisp=NONE gui=reverse ctermfg=167 ctermbg=235 cterm=reverse term=bold,reverse
hi ErrorMsg guifg=#fb4934 guibg=#282828 guisp=NONE gui=reverse ctermfg=167 ctermbg=235 cterm=reverse term=bold,reverse
hi FoldColumn guifg=#928374 guibg=NONE guisp=NONE gui=NONE ctermfg=245 ctermbg=NONE cterm=NONE term=NONE
hi Folded guifg=#bdae93 guibg=#3c3836 guisp=NONE gui=NONE ctermfg=248 ctermbg=237 cterm=NONE term=NONE
hi Function guifg=#b8bb26 guibg=NONE guisp=NONE gui=NONE ctermfg=142 ctermbg=NONE cterm=NONE term=NONE
hi Identifier guifg=#83a598 guibg=NONE guisp=NONE gui=NONE ctermfg=109 ctermbg=NONE cterm=NONE term=NONE
hi Ignore guifg=NONE guibg=NONE guisp=NONE gui=NONE ctermfg=NONE ctermbg=NONE cterm=NONE term=NONE
hi IncSearch guifg=#fe8019 guibg=#282828 guisp=NONE gui=reverse ctermfg=208 ctermbg=235 cterm=reverse term=bold,reverse,underline
hi LineNr guifg=#7c6f64 guibg=NONE guisp=NONE gui=NONE ctermfg=243 ctermbg=NONE cterm=NONE term=NONE
hi LineNrAbove guifg=#7c6f64 guibg=NONE guisp=NONE gui=NONE ctermfg=243 ctermbg=NONE cterm=NONE term=NONE
hi LineNrBelow guifg=#7c6f64 guibg=NONE guisp=NONE gui=NONE ctermfg=243 ctermbg=NONE cterm=NONE term=NONE
hi MatchParen guifg=NONE guibg=#fe8019 guisp=NONE gui=bold ctermfg=208 ctermbg=NONE cterm=bold term=bold
hi ModeMsg guifg=NONE guibg=NONE guisp=NONE gui=bold ctermfg=NONE ctermbg=NONE cterm=bold term=bold
hi MoreMsg guifg=#b8bb26 guibg=NONE guisp=NONE gui=NONE ctermfg=142 ctermbg=NONE cterm=NONE term=NONE
hi NonText guifg=#7c6f64 guibg=NONE guisp=NONE gui=NONE ctermfg=243 ctermbg=NONE cterm=NONE term=NONE
hi Pmenu guifg=NONE guibg=#504945 guisp=NONE gui=NONE ctermfg=NONE ctermbg=239 cterm=NONE term=reverse
hi PmenuExtra guifg=#bdae93 guibg=#504945 guisp=NONE gui=NONE ctermfg=248 ctermbg=239 cterm=NONE term=NONE
hi PmenuExtraSel guifg=#bdae93 guibg=#665c54 guisp=NONE gui=NONE ctermfg=248 ctermbg=241 cterm=NONE term=NONE
hi PmenuKind guifg=#fe8019 guibg=#504945 guisp=NONE gui=NONE ctermfg=208 ctermbg=239 cterm=NONE term=NONE
hi PmenuKindSel guifg=#fe8019 guibg=#665c54 guisp=NONE gui=NONE ctermfg=208 ctermbg=241 cterm=NONE term=NONE
hi PmenuMatch guifg=#fabd2f guibg=#504945 guisp=NONE gui=NONE ctermfg=214 ctermbg=239 cterm=NONE term=NONE
hi PmenuMatchSel guifg=#fabd2f guibg=#665c54 guisp=NONE gui=NONE ctermfg=214 ctermbg=241 cterm=NONE term=NONE
hi PmenuSbar guifg=NONE guibg=NONE guisp=NONE gui=NONE ctermfg=NONE ctermbg=NONE cterm=NONE term=reverse
hi PmenuSel guifg=NONE guibg=#665c54 guisp=NONE gui=NONE ctermfg=NONE ctermbg=241 cterm=NONE term=bold
hi PmenuThumb guifg=NONE guibg=#928374 guisp=NONE gui=NONE ctermfg=NONE ctermbg=245 cterm=NONE term=NONE
hi PreProc guifg=#8ec07c guibg=NONE guisp=NONE gui=NONE ctermfg=108 ctermbg=NONE cterm=NONE term=NONE
hi Question guifg=#fe8019 guibg=NONE guisp=NONE gui=NONE ctermfg=208 ctermbg=NONE cterm=NONE term=standout
hi QuickFixLine guifg=#282828 guibg=#83a598 guisp=NONE gui=NONE ctermfg=235 ctermbg=109 cterm=NONE term=NONE
hi Removed guifg=#cc241d guibg=NONE guisp=NONE gui=NONE ctermfg=124 ctermbg=NONE cterm=NONE term=NONE
hi Search guifg=#fabd2f guibg=#282828 guisp=NONE gui=reverse ctermfg=214 ctermbg=235 cterm=reverse term=reverse
hi SignColumn guifg=NONE guibg=NONE guisp=NONE gui=NONE ctermfg=NONE ctermbg=NONE cterm=NONE term=reverse
hi Special guifg=#fe8019 guibg=NONE guisp=NONE gui=NONE ctermfg=208 ctermbg=NONE cterm=NONE term=NONE
hi SpecialKey guifg=#7c6f64 guibg=NONE guisp=NONE gui=NONE ctermfg=243 ctermbg=NONE cterm=NONE term=bold
hi SpellBad guifg=NONE guibg=NONE guisp=#fb4934 gui=undercurl ctermfg=167 ctermbg=NONE cterm=underline term=underline
hi SpellCap guifg=NONE guibg=NONE guisp=#fabd2f gui=undercurl ctermfg=214 ctermbg=NONE cterm=underline term=underline
hi SpellLocal guifg=NONE guibg=NONE guisp=#8ec07c gui=undercurl ctermfg=108 ctermbg=NONE cterm=underline term=underline
hi SpellRare guifg=NONE guibg=NONE guisp=#d3869b gui=undercurl ctermfg=175 ctermbg=NONE cterm=underline term=underline
hi Statement guifg=#fb4934 guibg=NONE guisp=NONE gui=bold ctermfg=167 ctermbg=NONE cterm=bold term=NONE
hi StatusLine guifg=#d79921 guibg=#504945 guisp=NONE gui=NONE ctermfg=235 ctermbg=223 cterm=NONE term=bold,reverse
hi StatusLineNC guifg=#7c6f64 guibg=#504945 guisp=NONE gui=NONE ctermfg=235 ctermbg=246 cterm=NONE term=bold,underline
hi String guifg=#b8bb26 guibg=NONE guisp=NONE gui=NONE ctermfg=142 ctermbg=NONE cterm=NONE term=NONE
hi TabLine guifg=#d79921 guibg=#504945 guisp=NONE gui=NONE ctermfg=235 ctermbg=246 cterm=NONE term=bold,underline
hi TabLineFill guifg=#d79921 guibg=#504945 guisp=NONE gui=NONE ctermfg=235 ctermbg=246 cterm=NONE term=NONE
hi TabLineSel guifg=#282828 guibg=#d79921 guisp=NONE gui=bold ctermfg=235 ctermbg=223 cterm=bold term=bold,reverse
hi Title guifg=NONE guibg=NONE guisp=NONE gui=bold ctermfg=NONE ctermbg=NONE cterm=bold term=NONE
hi TitleBar guifg=#d79921 guibg=#504945 guisp=NONE gui=NONE ctermfg=223 ctermbg=239 cterm=NONE term=NONE
hi TitleBarNC guifg=#bdae93 guibg=#504945 guisp=NONE gui=NONE ctermfg=248 ctermbg=237 cterm=NONE term=NONE
hi Todo guifg=#fabd2f guibg=NONE guisp=NONE gui=bold ctermfg=214 ctermbg=NONE cterm=bold term=bold,reverse
hi ToolbarButton guifg=#665c54 guibg=#ebdbb2 guisp=NONE gui=bold,reverse ctermfg=241 ctermbg=223 cterm=bold,reverse term=bold,reverse
hi ToolbarLine guifg=NONE guibg=NONE guisp=NONE gui=NONE ctermfg=NONE ctermbg=NONE cterm=NONE term=reverse
hi Type guifg=#fabd2f guibg=NONE guisp=NONE gui=bold ctermfg=214 ctermbg=NONE cterm=bold term=NONE
hi Underlined guifg=#83a598 guibg=NONE guisp=NONE gui=underline ctermfg=109 ctermbg=NONE cterm=underline term=underline
hi VertSplit guifg=#504945 guibg=#504945 guisp=NONE gui=NONE ctermfg=243 ctermbg=243 cterm=NONE term=NONE
hi Visual guifg=#8ec07c guibg=#282828 guisp=NONE gui=reverse ctermfg=108 ctermbg=235 cterm=reverse term=reverse
hi VisualNOS guifg=#282828 guibg=#fe8019 guisp=NONE gui=NONE ctermfg=235 ctermbg=208 cterm=NONE term=NONE
hi WarningMsg guifg=#fb4934 guibg=NONE guisp=NONE gui=NONE ctermfg=167 ctermbg=NONE cterm=NONE term=standout
hi WildMenu guifg=#282828 guibg=#fabd2f guisp=NONE gui=bold ctermfg=235 ctermbg=214 cterm=bold term=bold
hi debugBreakpoint guifg=#282828 guibg=#fb4934 guisp=NONE gui=NONE ctermfg=235 ctermbg=167 cterm=NONE term=NONE
hi debugPC guifg=#282828 guibg=#83a598 guisp=NONE gui=NONE ctermfg=235 ctermbg=109 cterm=NONE term=NONE
hi htmlBold guifg=#ebdbb2 guibg=NONE guisp=NONE gui=bold ctermfg=223 ctermbg=NONE cterm=bold term=bold
hi htmlItalic guifg=#ebdbb2 guibg=NONE guisp=NONE gui=italic ctermfg=223 ctermbg=NONE cterm=underline term=underline
hi markdownH1Delimiter guifg=#fb4934 guibg=NONE guisp=NONE gui=NONE ctermfg=167 ctermbg=NONE cterm=NONE term=NONE
hi markdownH1 guifg=#fb4934 guibg=NONE guisp=NONE gui=NONE ctermfg=167 ctermbg=NONE cterm=NONE term=NONE
hi markdownH2Delimiter guifg=#fe8019 guibg=NONE guisp=NONE gui=NONE ctermfg=208 ctermbg=NONE cterm=NONE term=NONE
hi markdownH2 guifg=#fe8019 guibg=NONE guisp=NONE gui=NONE ctermfg=208 ctermbg=NONE cterm=NONE term=NONE
hi markdownH3Delimiter guifg=#fabd2f guibg=NONE guisp=NONE gui=NONE ctermfg=214 ctermbg=NONE cterm=NONE term=NONE
hi markdownH3 guifg=#fabd2f guibg=NONE guisp=NONE gui=NONE ctermfg=214 ctermbg=NONE cterm=NONE term=NONE
hi markdownH4Delimiter guifg=#b8bb26 guibg=NONE guisp=NONE gui=NONE ctermfg=142 ctermbg=NONE cterm=NONE term=NONE
hi markdownH4 guifg=#b8bb26 guibg=NONE guisp=NONE gui=NONE ctermfg=142 ctermbg=NONE cterm=NONE term=NONE
hi markdownH5Delimiter guifg=#8ec07c guibg=NONE guisp=NONE gui=NONE ctermfg=108 ctermbg=NONE cterm=NONE term=NONE
hi markdownH5 guifg=#8ec07c guibg=NONE guisp=NONE gui=NONE ctermfg=108 ctermbg=NONE cterm=NONE term=NONE
hi markdownH6Delimiter guifg=#83a598 guibg=NONE guisp=NONE gui=NONE ctermfg=109 ctermbg=NONE cterm=NONE term=NONE
hi markdownH6 guifg=#83a598 guibg=NONE guisp=NONE gui=NONE ctermfg=109 ctermbg=NONE cterm=NONE term=NONE
hi markdownCode guifg=#fabd2f guibg=#666611 guisp=NONE gui=NONE ctermfg=109 ctermbg=NONE cterm=NONE term=NONE

hi! link markdownCodeBlock markdownCode
hi! link markdownCodeDelimiter markdownCode

if has('gui_running') || s:tgc
  hi Cursor guifg=#282828 guibg=#ebdbb2 guisp=NONE gui=NONE cterm=NONE
  hi lCursor guifg=#282828 guibg=#b8bb26 guisp=NONE gui=NONE cterm=NONE
endif

if s:tgc || s:t_Co >= 256
  finish
endif

if s:t_Co >= 16
  hi Normal ctermfg=white ctermbg=black cterm=NONE
  hi Added ctermfg=darkgreen ctermbg=NONE cterm=NONE
  hi Changed ctermfg=darkyellow ctermbg=NONE cterm=NONE
  hi Character ctermfg=magenta ctermbg=NONE cterm=NONE
  hi ColorColumn ctermfg=black ctermbg=darkyellow cterm=NONE
  hi Comment ctermfg=darkgray ctermbg=NONE cterm=NONE
  hi Conceal ctermfg=darkgrey ctermbg=NONE cterm=NONE
  hi Constant ctermfg=magenta ctermbg=NONE cterm=NONE
  hi CurSearch ctermfg=green ctermbg=black cterm=reverse
  hi CursorColumn ctermfg=black ctermbg=darkyellow cterm=NONE
  hi CursorLine ctermfg=NONE ctermbg=NONE cterm=underline
  hi CursorLineNr ctermfg=yellow ctermbg=NONE cterm=bold
  hi Debug ctermfg=darkcyan ctermbg=NONE cterm=NONE
  hi DiffAdd ctermfg=darkgreen ctermbg=NONE cterm=reverse
  hi DiffChange ctermfg=darkblue ctermbg=NONE cterm=reverse
  hi DiffDelete ctermfg=darkred ctermbg=NONE cterm=reverse
  hi DiffText ctermfg=darkmagenta ctermbg=NONE cterm=reverse
  hi Directory ctermfg=cyan ctermbg=NONE cterm=bold
  hi EndOfBuffer ctermfg=darkgrey ctermbg=NONE cterm=NONE
  hi Error ctermfg=red ctermbg=black cterm=reverse
  hi ErrorMsg ctermfg=red ctermbg=black cterm=reverse
  hi FoldColumn ctermfg=darkgrey ctermbg=NONE cterm=NONE
  hi Folded ctermfg=black ctermbg=darkyellow cterm=NONE
  hi Function ctermfg=green ctermbg=NONE cterm=NONE
  hi Identifier ctermfg=blue ctermbg=NONE cterm=NONE
  hi Ignore ctermfg=NONE ctermbg=NONE cterm=NONE
  hi IncSearch ctermfg=yellow ctermbg=black cterm=reverse
  hi LineNr ctermfg=darkgrey ctermbg=NONE cterm=NONE
  hi LineNrAbove ctermfg=darkgrey ctermbg=NONE cterm=NONE
  hi LineNrBelow ctermfg=darkgrey ctermbg=NONE cterm=NONE
  hi MatchParen ctermfg=yellow ctermbg=NONE cterm=bold
  hi ModeMsg ctermfg=NONE ctermbg=NONE cterm=bold
  hi MoreMsg ctermfg=darkgreen ctermbg=NONE cterm=NONE
  hi NonText ctermfg=darkgrey ctermbg=NONE cterm=NONE
  hi Pmenu ctermfg=black ctermbg=gray cterm=NONE
  hi PmenuExtra ctermfg=darkgray ctermbg=gray cterm=NONE
  hi PmenuExtraSel ctermfg=black ctermbg=darkyellow cterm=NONE
  hi PmenuKind ctermfg=yellow ctermbg=gray cterm=NONE
  hi PmenuKindSel ctermfg=yellow ctermbg=darkyellow cterm=NONE
  hi PmenuMatch ctermfg=black ctermbg=gray cterm=bold
  hi PmenuMatchSel ctermfg=black ctermbg=darkyellow cterm=bold
  hi PmenuSbar ctermfg=NONE ctermbg=gray cterm=NONE
  hi PmenuSel ctermfg=black ctermbg=darkyellow cterm=NONE
  hi PmenuThumb ctermfg=gray ctermbg=black cterm=NONE
  hi PreProc ctermfg=cyan ctermbg=NONE cterm=NONE
  hi Question ctermfg=yellow ctermbg=NONE cterm=NONE
  hi QuickFixLine ctermfg=black ctermbg=blue cterm=NONE
  hi Removed ctermfg=darkred ctermbg=NONE cterm=NONE
  hi Search ctermfg=black ctermbg=yellow cterm=NONE
  hi SignColumn ctermfg=NONE ctermbg=NONE cterm=NONE
  hi Special ctermfg=yellow ctermbg=NONE cterm=bold
  hi SpecialKey ctermfg=darkgrey ctermbg=NONE cterm=bold
  hi SpellBad ctermfg=darkred ctermbg=NONE cterm=underline
  hi SpellCap ctermfg=darkyellow ctermbg=NONE cterm=underline
  hi SpellLocal ctermfg=darkcyan ctermbg=NONE cterm=underline
  hi SpellRare ctermfg=magenta ctermbg=NONE cterm=underline
  hi Statement ctermfg=red ctermbg=NONE cterm=bold
  hi StatusLine ctermfg=black ctermbg=gray cterm=NONE
  hi StatusLineNC ctermfg=black ctermbg=darkgray cterm=NONE
  hi String ctermfg=green ctermbg=NONE cterm=NONE
  hi TabLine ctermfg=green ctermbg=darkgray cterm=NONE
  hi TabLineFill ctermfg=black ctermbg=darkgray cterm=NONE
  hi TabLineSel ctermfg=black ctermbg=green cterm=bold
  hi Title ctermfg=NONE ctermbg=NONE cterm=bold
  hi TitleBar ctermfg=white ctermbg=black cterm=NONE
  hi TitleBarNC ctermfg=gray ctermbg=black cterm=NONE
  hi Todo ctermfg=yellow ctermbg=NONE cterm=bold
  hi ToolbarButton ctermfg=darkgray ctermbg=white cterm=bold,reverse
  hi ToolbarLine ctermfg=NONE ctermbg=NONE cterm=NONE
  hi Type ctermfg=yellow ctermbg=NONE cterm=bold
  hi Underlined ctermfg=blue ctermbg=NONE cterm=underline
  hi VertSplit ctermfg=darkgray ctermbg=darkgray cterm=NONE
  hi Visual ctermfg=cyan ctermbg=black cterm=reverse
  hi VisualNOS ctermfg=black ctermbg=yellow cterm=NONE
  hi WarningMsg ctermfg=red ctermbg=NONE cterm=NONE
  hi WildMenu ctermfg=black ctermbg=yellow cterm=bold
  hi debugBreakpoint ctermfg=black ctermbg=red cterm=NONE
  hi debugPC ctermfg=black ctermbg=blue cterm=NONE
  hi htmlBold ctermfg=white ctermbg=NONE cterm=bold
  hi htmlItalic ctermfg=white ctermbg=NONE cterm=underline
  hi markdownH1Delimiter ctermfg=red ctermbg=NONE cterm=NONE
  hi markdownH2Delimiter ctermfg=yellow ctermbg=NONE cterm=NONE
  hi markdownH3Delimiter ctermfg=darkyellow ctermbg=NONE cterm=NONE
  hi markdownH4Delimiter ctermfg=green ctermbg=NONE cterm=NONE
  hi markdownH5Delimiter ctermfg=cyan ctermbg=NONE cterm=NONE
  hi markdownH6Delimiter ctermfg=blue ctermbg=NONE cterm=NONE
  hi markdownHeadingDelimiter ctermfg=white ctermbg=NONE cterm=NONE
  finish
endif

if s:t_Co >= 8
  hi Normal ctermfg=gray ctermbg=black cterm=NONE
  hi Added ctermfg=darkgreen ctermbg=NONE cterm=NONE
  hi Changed ctermfg=darkyellow ctermbg=NONE cterm=NONE
  hi Character ctermfg=darkmagenta ctermbg=NONE cterm=NONE
  hi ColorColumn ctermfg=black ctermbg=darkyellow cterm=NONE
  hi Comment ctermfg=gray ctermbg=NONE cterm=bold
  hi Conceal ctermfg=gray ctermbg=NONE cterm=NONE
  hi Constant ctermfg=darkmagenta ctermbg=NONE cterm=NONE
  hi CurSearch ctermfg=black ctermbg=darkgreen cterm=NONE
  hi CursorColumn ctermfg=black ctermbg=darkyellow cterm=NONE
  hi CursorLine ctermfg=NONE ctermbg=NONE cterm=underline
  hi CursorLineNr ctermfg=darkyellow ctermbg=NONE cterm=bold
  hi Debug ctermfg=darkcyan ctermbg=NONE cterm=NONE
  hi DiffAdd ctermfg=darkgreen ctermbg=NONE cterm=reverse
  hi DiffChange ctermfg=darkblue ctermbg=NONE cterm=reverse
  hi DiffDelete ctermfg=darkred ctermbg=NONE cterm=reverse
  hi DiffText ctermfg=darkmagenta ctermbg=NONE cterm=reverse
  hi Directory ctermfg=darkcyan ctermbg=NONE cterm=bold
  hi EndOfBuffer ctermfg=gray ctermbg=NONE cterm=bold
  hi Error ctermfg=darkred ctermbg=gray cterm=bold,reverse
  hi ErrorMsg ctermfg=darkred ctermbg=gray cterm=bold,reverse
  hi FoldColumn ctermfg=gray ctermbg=NONE cterm=bold
  hi Folded ctermfg=black ctermbg=darkyellow cterm=NONE
  hi Function ctermfg=darkgreen ctermbg=NONE cterm=NONE
  hi Identifier ctermfg=darkblue ctermbg=NONE cterm=NONE
  hi Ignore ctermfg=NONE ctermbg=NONE cterm=NONE
  hi IncSearch ctermfg=black ctermbg=darkyellow cterm=NONE
  hi LineNr ctermfg=gray ctermbg=NONE cterm=bold
  hi LineNrAbove ctermfg=gray ctermbg=NONE cterm=bold
  hi LineNrBelow ctermfg=gray ctermbg=NONE cterm=bold
  hi MatchParen ctermfg=darkyellow ctermbg=NONE cterm=bold
  hi ModeMsg ctermfg=NONE ctermbg=NONE cterm=bold
  hi MoreMsg ctermfg=darkgreen ctermbg=NONE cterm=NONE
  hi NonText ctermfg=gray ctermbg=NONE cterm=bold
  hi Pmenu ctermfg=black ctermbg=gray cterm=NONE
  hi PmenuExtra ctermfg=black ctermbg=gray cterm=NONE
  hi PmenuExtraSel ctermfg=black ctermbg=darkyellow cterm=NONE
  hi PmenuKind ctermfg=darkyellow ctermbg=gray cterm=NONE
  hi PmenuKindSel ctermfg=darkyellow ctermbg=darkyellow cterm=NONE
  hi PmenuMatch ctermfg=black ctermbg=gray cterm=bold
  hi PmenuMatchSel ctermfg=black ctermbg=darkyellow cterm=bold
  hi PmenuSbar ctermfg=NONE ctermbg=gray cterm=NONE
  hi PmenuSel ctermfg=black ctermbg=darkyellow cterm=NONE
  hi PmenuThumb ctermfg=gray ctermbg=black cterm=NONE
  hi PreProc ctermfg=darkcyan ctermbg=NONE cterm=NONE
  hi Question ctermfg=darkyellow ctermbg=NONE cterm=NONE
  hi QuickFixLine ctermfg=black ctermbg=darkblue cterm=NONE
  hi Removed ctermfg=darkred ctermbg=NONE cterm=NONE
  hi Search ctermfg=black ctermbg=darkyellow cterm=NONE
  hi SignColumn ctermfg=NONE ctermbg=NONE cterm=NONE
  hi Special ctermfg=darkyellow ctermbg=NONE cterm=bold
  hi SpecialKey ctermfg=gray ctermbg=NONE cterm=bold
  hi SpellBad ctermfg=darkred ctermbg=gray cterm=reverse
  hi SpellCap ctermfg=darkblue ctermbg=gray cterm=reverse
  hi SpellLocal ctermfg=darkcyan ctermbg=black cterm=reverse
  hi SpellRare ctermfg=darkmagenta ctermbg=gray cterm=reverse
  hi Statement ctermfg=darkred ctermbg=NONE cterm=bold
  hi StatusLine ctermfg=gray ctermbg=black cterm=bold,reverse
  hi StatusLineNC ctermfg=gray ctermbg=black cterm=reverse
  hi String ctermfg=darkgreen ctermbg=NONE cterm=bold
  hi TabLine ctermfg=green ctermbg=gray cterm=NONE
  hi TabLineFill ctermfg=gray ctermbg=gray cterm=NONE
  hi TabLineSel ctermfg=black ctermbg=green cterm=bold
  hi Title ctermfg=NONE ctermbg=NONE cterm=bold
  hi TitleBar ctermfg=white ctermbg=black cterm=NONE
  hi TitleBarNC ctermfg=gray ctermbg=black cterm=NONE
  hi Todo ctermfg=gray ctermbg=NONE cterm=bold
  hi ToolbarButton ctermfg=gray ctermbg=black cterm=reverse
  hi ToolbarLine ctermfg=NONE ctermbg=NONE cterm=NONE
  hi Type ctermfg=darkyellow ctermbg=NONE cterm=bold
  hi Underlined ctermfg=darkblue ctermbg=NONE cterm=underline
  hi VertSplit ctermfg=gray ctermbg=gray cterm=NONE
  hi Visual ctermfg=black ctermbg=darkcyan cterm=NONE
  hi VisualNOS ctermfg=black ctermbg=darkcyan cterm=NONE
  hi WarningMsg ctermfg=darkred ctermbg=NONE cterm=NONE
  hi WildMenu ctermfg=black ctermbg=darkyellow cterm=NONE
  hi debugBreakpoint ctermfg=black ctermbg=darkred cterm=NONE
  hi debugPC ctermfg=black ctermbg=darkblue cterm=NONE
  hi htmlBold ctermfg=gray ctermbg=NONE cterm=bold
  hi htmlItalic ctermfg=gray ctermbg=NONE cterm=underline
  hi markdownH1Delimiter ctermfg=darkred ctermbg=NONE cterm=NONE
  hi markdownH2Delimiter ctermfg=darkyellow ctermbg=NONE cterm=NONE
  hi markdownH3Delimiter ctermfg=darkyellow ctermbg=NONE cterm=NONE
  hi markdownH4Delimiter ctermfg=darkgreen ctermbg=NONE cterm=NONE
  hi markdownH5Delimiter ctermfg=darkcyan ctermbg=NONE cterm=NONE
  hi markdownH6Delimiter ctermfg=darkblue ctermbg=NONE cterm=NONE
  hi markdownHeadingDelimiter ctermfg=gray ctermbg=NONE cterm=NONE
  finish
endif

if s:t_Co >= 0
  hi Cursor term=reverse
  hi CursorIM term=NONE
  hi CursorLineFold term=underline
  hi CursorLineSign term=underline
  hi Float term=NONE
  hi Number term=NONE
  hi StatusLineTerm term=bold,reverse
  hi StatusLineTermNC term=bold,underline
  hi Terminal term=NONE
  finish
endif

" vim: et ts=8 sw=2 sts=2
