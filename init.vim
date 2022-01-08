set nocompatible 		" be iMproved, required
filetype off 			" required
set number

call plug#begin('~/.config/nvim/plugged')
Plug 'morhetz/gruvbox' 
Plug 'preservim/nerdtree'
Plug 'ctrlpvim/ctrlp.vim'
Plug 'neoclide/coc.nvim', {'branch': 'release'} 
Plug 'rust-lang/rust.vim'
Plug 'tpope/vim-fugitive'
call plug#end()

colorscheme gruvbox
map <silent> <C-n> :NERDTreeFocus<CR>
