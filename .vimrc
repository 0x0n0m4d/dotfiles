" General Config
syntax on
color gruvbox
set termguicolors

hi Visual cterm=reverse gui=reverse ctermfg=NONE ctermbg=NONE guifg=NONE guibg=NONE

set guicursor=a:block-Cursor/lCursor-blinkwait200-blinkon200-blinkoff200

set encoding=utf-8
set fileencoding=utf-8
set title
set smartindent
set hlsearch
set nobackup
set showcmd
set cmdheight=1
set laststatus=3
set expandtab
set shell=zsh
set ignorecase
set smarttab
set breakindent
set shiftwidth=4
set tabstop=4
set wrap
set relativenumber
set scrolloff=10
set splitbelow
set splitright
set splitkeep=cursor
set clipboard=unnamedplus
set nofixendofline
set cursorline

let g:clipboard = {
\   'name': 'xclip',
\   'copy': {
\      '+': 'xclip -selection clipboard',
\      '*': 'xclip -selection primary',
\   },
\   'paste': {
\      '+': 'xclip -selection clipboard -o',
\      '*': 'xclip -selection primary -o',
\   },
\   'cache_enabled': 1,
\ }

set list listchars=tab:>\ ,trail:+,eol:$,nbsp:%

let g:netrw_bufsettings = 'noma nomod nobl nowrap ro'
let g:netrw_no_history = 1

" Keybinds
let mapleader = " "

nnoremap <C-s> :w<CR>
nnoremap <C-'> :q<CR>
nnoremap <C-q> :q!<CR>
nnoremap <C-n> :x<CR>
nnoremap \/ :noh<CR>
nnoremap x "_x
nnoremap dw vb"_d
nnoremap c "_c
nnoremap <C-a> gg<S-v>G
nnoremap + <C-a>
nnoremap - <C-x>
nnoremap <leader>d. :Explore<CR>
nnoremap <leader>dv :Vexplore<CR>
nnoremap <leader>dh :Hexplore<CR>
nnoremap <leader>dt :Texplore<CR>
nnoremap <leader>nv :vnew<CR>
nnoremap <leader>nh :new<CR>
nnoremap <leader>nt :tabnew<CR>
nnoremap <leader>w_ <C-w>_
nnoremap <leader>w\| <C-w>\|
nnoremap <leader>w= <C-w>=

"" Tabs
nnoremap tx :tabclose<CR>
nnoremap <tab> :tabnext<CR>
nnoremap <S-tab> :tabprevious<CR>
nnoremap tp :-tabmove<CR>
nnoremap tn :+tabmove<CR>
nnoremap t\| :vsplit<CR>
nnoremap t' :split<CR>
nnoremap ts <C-w>T
nnoremap \h <C-w>h
nnoremap \l <C-w>l
nnoremap \j <C-w>j
nnoremap \k <C-w>k
nnoremap \H <C-w>>
nnoremap \L <C-w><
nnoremap \K <C-w>+
nnoremap \J <C-w>-

"" Insert
inoremap <C-CR> <C-o>o
inoremap <C-S-CR> <C-o>O
