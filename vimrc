let mapleader=","
let maplocalleader=",,"

"set nocompatible

execute pathogen#infect()
syntax on
filetype plugin indent on

set background=dark
colorscheme molokai

" Set GUI only options
if has("gui_running")
    set guifont=Source\ Code\ Pro:h12
endif

set noexpandtab
set copyindent
set preserveindent
set smartindent
set autoindent
set smarttab
set tabstop=4
set shiftwidth=4
set expandtab

set nocp " fixes conemu problems?

set clipboard+=unnamed " Yanks go on clipboard insteads

" Hybrid number mode
set relativenumber
set number

set showcmd
set showmode
set showmatch
set hidden
set laststatus=2

set incsearch
set hlsearch

set nowrap
set ff=unix

" Enable mouse support
set mouse=a

if v:version >= 703
    " undo settings
    set undodir=~/.vim/undofiles
    set undofile
endif

" No error sounds
set noerrorbells
set novisualbell

set encoding=utf-8
set ffs=unix,dos,mac

set cursorline

set term=xterm
set t_Co=256
let &t_AB="\e[48;5%dm"
let &t_AF="\e[38;5%dm"
set vb t_vb=

" CtrlP
set wildmenu " Completion menu
set wildmode=list:longest
set wildignore+=*/tmp/*,*.so,*.swp,*.zip,*.class
let g:ctrlp_custom_ignore = '\v[\/]\.(git|hg|svn)$'
let g:ctrlp_max_files = 15000

" Syntastic
let g:syntastic_java_javac_config_file_enabled = 1

" Bindings
"   BufExplorer
map <C-b> :BufExplorer<CR>
"   NERDTree
map <C-f> :NERDTreeToggle<CR>
" TagList
map <C-t> :TagbarToggle<CR>

" Bind buffer switching to Ctrl+Tab
map <C-Tab> :bnext<CR>
map <C-S-Tab> :bprevious<CR>

" Add pastetoggle to paste without tag completion, etc
set pastetoggle=<F2>

autocmd filetype svn,*commit* setlocal spell

autocmd FileType ruby,eruby,html,coffee
      \ set expandtab |
      \ set shiftwidth=2 |
      \ set softtabstop=2

" Auto highlight trailing whitespace
highlight ExtraWhitespace ctermbg=red guibg=red
match ExtraWhitespace /\s\+$/
autocmd BufWinEnter * match ExtraWhitespace /\s\+$/
autocmd InsertEnter * match ExtraWhitespace /\s\+\%#\@<!$/
autocmd InsertLeave * match ExtraWhitespace /\s\+$/
autocmd BufWinLeave * call clearmatches()

" Strip trailing whitespace on save
fun! <SID>StripTrailingWhitespaces()
    let l = line(".")
    let c = col(".")
    %s/\s\+$//e
    call cursor(l, c)
endfun
autocmd FileType c,cpp,java,php,ruby,python autocmd BufWritePre <buffer> :call <SID>StripTrailingWhitespaces()
