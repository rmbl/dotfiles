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

" Set GUI only options
if has("gui_running")
    set guifont=Source\ Code\ Pro\ for\ Powerline:h12
endif

set smartindent
set autoindent
set smarttab
set tabstop=4
set shiftwidth=4
set expandtab

" Hybrid number mode
set relativenumber
set number

set showcmd
set showmode
set hidden

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
set t_vb=
set t_Co=256
set tm=500
if &term =~ '256color'
      " Disable Background Color Erase (BCE) so that color schemes
      " work properly when Vim is used inside tmux and GNU screen.
      " See also http://snk.tuxfamily.org/log/vim-256color-bce.html
      set t_ut=
endif
set encoding=utf8
set ffs=unix,dos,mac

set cursorline

" CtrlP
set wildignore+=*/tmp/*,*.so,*.swp,*.zip,*.class
let g:ctrlp_custom_ignore = '\v[\/]\.(git|hg|svn)$'
let g:ctrlp_max_files = 15000

" Airline
let g:airline_enable_branch = 1
let g:airline_enable_syntastic = 1
let g:airline_enable_tagbar = 0
"let g:airline_theme = 'powerlineish'
let g:airline_theme = 'murmur'
let g:airline_powerline_fonts = 1
let g:airline#extensions#tabline#enabled = 1

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
if executable('coffeetags')
  let g:tagbar_type_coffee = {
        \ 'ctagsbin' : 'coffeetags',
        \ 'ctagsargs' : '',
        \ 'kinds' : [
        \ 'f:functions',
        \ 'o:object',
        \ ],
        \ 'sro' : ".",
        \ 'kind2scope' : {
        \ 'f' : 'object',
        \ 'o' : 'object',
        \ }
        \ }
endif
