" Set python version
let g:python3_host_prog = substitute(system('pyenv which python'), '\n\+$', '', '')

" Enable line numbers
set number

" Enable syntax highlighting
syntax enable

" Set tab to 4 spaces
set tabstop=4
set shiftwidth=4
set expandtab

" Python specific settings
au BufNewFile,BufRead *.py
    \ set tabstop=4 |
    \ set softtabstop=4 |
    \ set shiftwidth=4 |
    \ set textwidth=79 |
    \ set expandtab |
    \ set autoindent |
    \ set fileformat=unix

" Specify Plugin Manager
call plug#begin('~/.config/nvim/plugged')

" Python linter and formatter
Plug 'junegunn/vim-plug'
Plug 'davidhalter/jedi-vim'
Plug 'psf/black'
Plug 'ycm-core/YouCompleteMe'
Plug 'scrooloose/nerdtree'
Plug 'sheerun/vim-polyglot'
Plug 'dense-analysis/ale'
Plug 'tpope/vim-fugitive'
Plug 'puremourning/vimspector'
Plug 'vim-airline/vim-airline'
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }


" Initialize plugin system
call plug#end()

