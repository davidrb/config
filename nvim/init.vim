call plug#begin()
Plug 'tpope/vim-sensible'
Plug 'scrooloose/syntastic'
Plug 'valloric/youcompleteme'
Plug 'ctrlpvim/ctrlp.vim'
Plug 'tpope/vim-projectionist'
Plug 'tpope/vim-fugitive'
Plug 'airblade/vim-gitgutter'
Plug 'tpope/vim-fireplace'
Plug 'kien/rainbow_parentheses.vim'
call plug#end()

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

au VimEnter * RainbowParenthesesToggle
au Syntax * RainbowParenthesesLoadRound
au Syntax * RainbowParenthesesLoadSquare
au Syntax * RainbowParenthesesLoadBraces

set cc=81
highlight ColorColumn ctermbg=black
