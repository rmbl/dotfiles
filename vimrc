let mapleader=","
let maplocalleader=",,"

set nocompatible

execute pathogen#infect()
syntax on
filetype plugin indent on

set background=dark
colorscheme gruvbox

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

"set nocp " fixes conemu problems?

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

set wrap
set linebreak
set nolist
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

if !has('nvim')
    set term=xterm-256color
    set t_Co=256
    "let &t_AB="\e[48;5%dm"
    "let &t_AF="\e[38;5%dm"
    set t_AB=[48;5;%dm
    set t_AF=[38;5;%dm
    set vb t_vb=
endif

" CtrlP
set wildmenu " Completion menu
set wildmode=list:longest
set wildignore+=*/tmp/*,*.so,*.swp,*.zip,*.class
let g:ctrlp_custom_ignore = '\v[\/](\.(git|hg|svn)|vendor|node_modules)$'
let g:ctrlp_max_files = 15000

" Syntastic
let g:syntastic_java_javac_config_file_enabled = 1
let g:syntastic_php_phpcs_args = "--report=csv --standard=PSR2"

let g:phpcomplete_index_composer_command = 'composer'

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


" LIGHTLINE CONFIGURATION
set noshowmode
let g:lightline = {
      \ 'colorscheme': 'gruvbox',
      \ 'active': {
      \   'left': [ [ 'mode', 'paste' ], [ 'fugitive', 'filename' ], ['ctrlpmark'] ],
      \   'right': [ [ 'syntastic', 'lineinfo' ], ['percent'], [ 'fileformat', 'fileencoding', 'filetype' ] ]
      \ },
	  \ 'component': {
	  \   'lineinfo': ' %3l:%-2v',
	  \ },
      \ 'component_function': {
      \   'fugitive': 'MyFugitive',
      \   'filename': 'MyFilename',
      \   'fileformat': 'MyFileformat',
      \   'filetype': 'MyFiletype',
      \   'fileencoding': 'MyFileencoding',
      \   'mode': 'MyMode',
      \   'ctrlpmark': 'CtrlPMark',
      \ },
      \ 'component_expand': {
      \   'syntastic': 'SyntasticStatuslineFlag',
      \   'buffers': 'lightline#bufferline#buffers',
      \ },
      \ 'component_type': {
      \   'syntastic': 'error',
      \   'buffers': 'tabsel',
      \ },
      \ 'tabline': {
      \   'left': [['buffers']],
      \   'right': [['close']],
      \ }
      \}

let g:lightline.separator = {
	\   'left': "\uE0B4", 'right': "\uE0B6"
  \}
let g:lightline.subseparator = {
	\   'left': "\uE0B5", 'right': "\uE0B7"
  \}

let g:lightline#bufferline#enable_devicons = 1
let g:lightline#bufferline#unicode_symbols = 1
set showtabline=2  " Show tabline
set guioptions-=e  " Don't use GUI tabline

function! MyModified()
  return &ft =~ 'help' ? '' : &modified ? '+' : &modifiable ? '' : '-'
endfunction

function! MyReadonly()
  return &ft !~? 'help' && &readonly ? 'RO' : ''
endfunction

function! MyFilename()
  let fname = expand('%:t')
  return fname == 'ControlP' ? g:lightline.ctrlp_item :
        \ fname == '__Tagbar__' ? g:lightline.fname :
        \ fname =~ '__Gundo\|NERD_tree' ? '' :
        \ ('' != MyReadonly() ? MyReadonly() . ' ' : '') .
        \ ('' != fname ? fname : '[No Name]') .
        \ ('' != MyModified() ? ' ' . MyModified() : '')
endfunction

function! MyFugitive()
  try
    if expand('%:t') !~? 'Tagbar\|Gundo\|NERD' && exists('*fugitive#head')
      let mark = ''  " edit here for cool mark
      let _ = fugitive#head()
      return strlen(_) ? mark._ : ''
    endif
  catch
  endtry
  return ''
endfunction

function! MyFileformat()
  return winwidth(0) > 70 ? &fileformat : ''
endfunction

function! MyFiletype()
  return winwidth(0) > 70 ? (strlen(&filetype) ? &filetype : 'no ft') : ''
endfunction

function! MyFileencoding()
  return winwidth(0) > 70 ? (strlen(&fenc) ? &fenc : &enc) : ''
endfunction

function! MyMode()
  let fname = expand('%:t')
  return fname == '__Tagbar__' ? 'Tagbar' :
        \ fname == 'ControlP' ? 'CtrlP' :
        \ fname == '__Gundo__' ? 'Gundo' :
        \ fname == '__Gundo_Preview__' ? 'Gundo Preview' :
        \ fname =~ 'NERD_tree' ? 'NERDTree' :
        \ winwidth(0) > 60 ? lightline#mode() : ''
endfunction

function! CtrlPMark()
  if expand('%:t') =~ 'ControlP'
    call lightline#link('iR'[g:lightline.ctrlp_regex])
    return lightline#concatenate([g:lightline.ctrlp_prev, g:lightline.ctrlp_item
          \ , g:lightline.ctrlp_next], 0)
  else
    return ''
  endif
endfunction

let g:ctrlp_status_func = {
  \ 'main': 'CtrlPStatusFunc_1',
  \ 'prog': 'CtrlPStatusFunc_2',
  \ }

function! CtrlPStatusFunc_1(focus, byfname, regex, prev, item, next, marked)
  let g:lightline.ctrlp_regex = a:regex
  let g:lightline.ctrlp_prev = a:prev
  let g:lightline.ctrlp_item = a:item
  let g:lightline.ctrlp_next = a:next
  return lightline#statusline(0)
endfunction

function! CtrlPStatusFunc_2(str)
  return lightline#statusline(0)
endfunction

let g:tagbar_status_func = 'TagbarStatusFunc'

function! TagbarStatusFunc(current, sort, fname, ...) abort
    let g:lightline.fname = a:fname
  return lightline#statusline(0)
endfunction

augroup AutoSyntastic
  autocmd!
  autocmd BufWritePost *.c,*.cpp call s:syntastic()
augroup END
function! s:syntastic()
  SyntasticCheck
  call lightline#update()
endfunction

