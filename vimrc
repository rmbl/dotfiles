" Disable autocomplpop for now
let g:acp_enableAtStartup = 0

let mapleader=","
let maplocalleader=",,"

set nocompatible

execute pathogen#infect()
syntax on
filetype plugin indent on
set omnifunc=syntaxcomplete#Complete

colorscheme hybrid

set smartindent
set autoindent
set smarttab
set tabstop=4
set shiftwidth=4
set expandtab
set number

set showcmd
set showmode
set hidden

set incsearch
set hlsearch

set nowrap
set ff=unix

if v:version >= 703
    " undo settings
    set undodir=~/.vim/undofiles
    set undofile
endif

set t_Co=256

" No error sounds
set noerrorbells
set novisualbell
set t_vb=
set tm=500

set encoding=utf8
set ffs=unix,dos,mac

set cursorline
hi clear CursorLine
hi CursorLineNR cterm=bold


" CtrlP
set wildignore+=*/tmp/*,*.so,*.swp,*.zip,*.class
let g:ctrlp_custom_ignore = '\v[\/]\.(git|hg|svn)$'
let g:ctrlp_max_files = 15000

" Airline
let g:airline_enable_branch = 1
let g:airline_enable_syntastic = 1
let g:airline_theme = 'tomorrow'
let g:airline_powerline_fonts = 1

" Syntastic
let g:syntastic_java_javac_config_file_enabled = 1

" Bindings
"   BufExplorer
map <C-b> :BufExplorer<CR>
"   NERDTree
map <C-f> :NERDTreeToggle<CR>
" TagList
map <C-t> :TagbarToggle<CR>

autocmd filetype svn,*commit* setlocal spell

autocmd FileType ruby,eruby,html
      \ set expandtab |
      \ set shiftwidth=2 |
      \ set softtabstop=2

