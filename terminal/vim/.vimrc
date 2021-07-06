set noswapfile
syntax on
" Relative line numbers
set number relativenumber
highlight LineNr term=bold cterm=NONE ctermfg=DarkGrey ctermbg=NONE gui=NONE guifg=DarkGrey guibg=NONE
"
set nocompatible
" Normal and insert mode style
:autocmd InsertEnter,InsertLeave * set cul!
hi CursorLine term=bold cterm=bold ctermbg=Black

let data_dir = has('nvim') ? stdpath('data') . '/site' : '~/.vim'
if empty(glob(data_dir . '/autoload/plug.vim'))
  silent execute '!curl -fLo '.data_dir.'/autoload/plug.vim --create-dirs  https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'
  autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif

call plug#begin()
  Plug 'preservim/nerdtree'
  " Fancy status bar and tab line for Vim
  Plug 'vim-airline/vim-airline'
  Plug 'sheerun/vim-polyglot'
  Plug 'hashivim/vim-terraform'
call plug#end()


" NERDTree
" Auto open NERDTree in vim
au VimEnter *  NERDTree
:let g:NERDTreeWinSize=25
let NERDTreeShowHidden=1
let g:NERDTreeWinPos = "left"
let g:floaterm_keymap_toggle = '<F12>'
nnoremap <C-t> :NERDTreeToggle<CR>

"Theme
set termguicolors

"colorscheme tokyonight

" remap ESC to jj for speed!
:imap jj <Esc>
