set nocompatible 		" be iMproved, required
filetype off 			" required
set number
set splitbelow

call plug#begin('~/.config/nvim/plugged')
Plug 'morhetz/gruvbox' 
Plug 'preservim/nerdtree'
Plug 'ctrlpvim/ctrlp.vim'
Plug 'neoclide/coc.nvim', {'branch': 'release'} 
Plug 'rust-lang/rust.vim'
Plug 'tpope/vim-fugitive'
Plug 'nvim-lua/plenary.nvim'
Plug 'nvim-telescope/telescope.nvim'
Plug 'BurntSushi/ripgrep'
call plug#end()

colorscheme gruvbox
"map <silent> <C-n> :NERDTreeFocus<CR>
map <leader>b :NERDTreeFocus<CR>
noremap Y y$
nnoremap <leader>ff <cmd>Telescope find_files<cr>
command Term :split <bar> :term
tnoremap <leader><Esc> <C-\><C-n>
