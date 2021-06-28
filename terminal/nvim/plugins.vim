" ~/.config/nvim/vim-plug/plugins.vim

syntax on
set modeline
set expandtab
set tabstop=4
set shiftwidth=4
set exrc " .vimrc in local project dir
set secure
autocmd BufRead,BufNewFile * set signcolumn=yes
autocmd FileType tagbar,nerdtree set signcolumn=no
set foldmethod=indent
set nofoldenable
set number relativenumber
set diffopt+=vertical

" auto-install vim-plug
if empty(glob('~/.config/nvim/autoload/plug.vim'))
  silent !curl -fLo ~/.config/nvim/autoload/plug.vim --create-dirs
    \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  "autocmd VimEnter * PlugInstall
  "autocmd VimEnter * PlugInstall | source $MYVIMRC
endif

call plug#begin('~/.config/nvim/autoload/plugged')

    " Better Syntax Support
    Plug 'sheerun/vim-polyglot'
    " File Explorer
    Plug 'scrooloose/NERDTree'
    " Auto pairs for '(' '[' '{'
    Plug 'jiangmiao/auto-pairs'
    " Fancy status bar and tab line for Vim
    Plug 'vim-airline/vim-airline'
    " Material theme
    Plug 'kaicataldo/material.vim', { 'branch': 'main' }
    " Syntax checker
    "Plug 'vim-syntastic/syntastic'
    " For vscode capabilities and yaml lint
    Plug 'neoclide/coc.nvim', {'branch': 'release'}
    " Ale syntax
    Plug 'dense-analysis/ale'

call plug#end()

" Auto open NERDTree in vim
au VimEnter *  NERDTree
"let g:NERDTreeWinSize=25
let NERDTreeShowHidden=1
"let g:NERDTreeWinPos = "left"
"let g:floaterm_keymap_toggle = '<F12>'
"let g:floaterm_height=0.3

" Yaml lint with Syntastic
"let g:syntastic_yaml_checkers = ['yamllint']

" Ale syntax
"-- ALE --
hi clear ALEErrorSign
hi clear ALEWarningSign
let g:ale_echo_msg_format = '[%linter%] %s [%severity%]'
hi Error    ctermfg=204 ctermbg=NONE guifg=#ff5f87 guibg=NONE
hi Warning  ctermfg=178 ctermbg=NONE guifg=#D7AF00 guibg=NONE
hi ALEError ctermfg=204 guifg=#ff5f87 ctermbg=52 guibg=#5f0000 cterm=undercurl gui=undercurl
hi link ALEErrorSign    Error
hi link ALEWarningSign  Warning

let g:ale_linters = {
            \ 'python': ['pylint'],
            \ 'yaml': ['yamllint']
            \}
let g:ale_fixers = {
            \ '*': ['remove_trailing_lines', 'trim_whitespace'],
            \ 'python': ['autopep8'],
            \ 'yaml': ['yamlfix']
            \}
let g:ale_fix_on_save = 1

"Theme
let g:material_terminal_italics = 1
let g:material_theme_style = 'ocean'

" Let airline use the material theme above
let g:airline_theme = 'material'
colorscheme material
let g:airline#extensions#tabline#enabled = 1


" For Neovim 0.1.3 and 0.1.4 - https://github.com/neovim/neovim/pull/2198
if (has('nvim'))
  let $NVIM_TUI_ENABLE_TRUE_COLOR = 1
endif

" For Neovim > 0.1.5 and Vim > patch 7.4.1799 - https://github.com/vim/vim/commit/61be73bb0f965a895bfb064ea3e55476ac175162
" Based on Vim patch 7.4.1770 (`guicolors` option) - https://github.com/vim/vim/commit/8a633e3427b47286869aa4b96f2bfc1fe65b25cd
" https://github.com/neovim/neovim/wiki/Following-HEAD#20160511
if (has('termguicolors'))
  set termguicolors
endif
