let g:syntastic_cpp_compiler_options='-std=c++14 -Wall'
let g:ycm_show_diagnostics_ui = 0

set nowrap
set clipboard+=unnamedplus
set ruler

set nu
set rnu

set backupdir=~/.config/nvim/backup//
set directory=~/.config/nvim/swap//
set undodir=~/.config/nvim/undo//

set expandtab
set shiftwidth=2
set softtabstop=2

syntax on

call plug#begin()
Plug 'tpope/vim-sensible'
Plug 'scrooloose/syntastic'
Plug 'valloric/youcompleteme'
Plug 'ctrlpvim/ctrlp.vim'
Plug 'tpope/vim-projectionist'
Plug 'tpope/vim-fugitive'
call plug#end()
