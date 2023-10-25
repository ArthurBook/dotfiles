" Initialize vim-plug
call plug#begin('~/.vim/plugged')

" Plugins
Plug 'junegunn/vim-plug'
Plug 'ycm-core/YouCompleteMe'
Plug 'scrooloose/nerdtree'
Plug 'sheerun/vim-polyglot'
Plug 'dense-analysis/ale'
Plug 'tpope/vim-fugitive'
Plug 'puremourning/vimspector'
Plug 'vim-airline/vim-airline'
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }

call plug#end()

" Your other settings

