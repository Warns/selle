call plug#begin()
Plug 'dense-analysis/ale'
Plug 'preservim/nerdtree'
Plug 'sheerun/vim-polyglot'
Plug 'ayu-theme/ayu-vim'
Plug 'ghifarit53/tokyonight-vim'
Plug 'wadackel/vim-dogrun'
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'voldikss/vim-floaterm'
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'
Plug 'tpope/vim-commentary'
Plug 'glepnir/oceanic-material'
call plug#end() 

set showmatch
set autowriteall
set autoindent
set fileformat=unix
set backspace=indent,eol,start
set complete=.,w,b,u
set hlsearch
set incsearch

" Ignore compiled files
set wildignore=*.o,*~,*.pyc
if has("win16") || has("win32")
    set wildignore+=*/.git/*,*/.hg/*,*/.svn/*,*/.DS_Store
else
    set wildignore+=.git\*,.hg\*,.svn\*
endif

" Automatically source the Vimrc file on save.
augroup autosourcing
    autocmd!
    autocmd BufWritePost .vimrc source %
augroup END

" Auto open NERDTree in vim
au VimEnter *  NERDTree
:let g:NERDTreeWinSize=25
let NERDTreeShowHidden=1
let g:NERDTreeWinPos = "right"
let g:floaterm_keymap_toggle = '<F12>'
let g:floaterm_height=0.3

set background=dark
:set nocompatible
:set wildmode=full
:set tabstop=2
:set shiftwidth=2
:set number
:set incsearch
:set backspace=start,eol,indent
:highlight LineNr ctermfg=DarkGrey
autocmd FileType yaml setlocal ts=2 sts=2 sw=2 expandtab
let g:indentLine_color_term = 239
let g:indentLine_char = '┊'


