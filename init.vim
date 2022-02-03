set nocompatible 		" be iMproved, required
filetype off 			" required
set number
set splitbelow


call plug#begin('~/.config/nvim/plugged')
Plug 'jacoborus/tender.vim'
Plug 'itchyny/lightline.vim'
"Plug 'morhetz/gruvbox' 
Plug 'preservim/nerdtree'
Plug 'ctrlpvim/ctrlp.vim'
Plug 'neoclide/coc.nvim', {'branch': 'release'} 
Plug 'rust-lang/rust.vim'
Plug 'tpope/vim-fugitive'
Plug 'nvim-lua/plenary.nvim'
Plug 'nvim-telescope/telescope.nvim'
Plug 'BurntSushi/ripgrep'
Plug 'iberianpig/ranger-explorer.vim'
Plug 'lfv89/vim-interestingwords'
call plug#end()

" GENERAL VIMPROVEMENTS  
noremap Y y$
 " noremap <leader>/ :s/^/// /

" COLORSCHEMES 
let g:lightline = { 'colorscheme': 'tender' }

syntax enable
colorscheme tender

"if (has("termguicolors"))
" set termguicolors
"endif

"colorscheme lightline 

" NERDTREE   
"map <silent> <C-n> :NERDTreeFocus<CR>
map <leader>b :NERDTreeFocus<CR>

" TELESCOPE 
nnoremap <leader>ff <cmd>Telescope find_files<cr>

" INTEGRATED TERMINAL 
command Term :split <bar> :term
"tnoremap <leader><Esc> <C-\><C-n> use this to escape integrated terminal once
"you figure out how to escape from terminal mode

" RANGER 
let g:ranger_explorer_keymap_edit    = '<C-o>'
let g:ranger_explorer_keymap_tabedit = '<C-t>'
let g:ranger_explorer_keymap_split   = '<C-s>'
let g:ranger_explorer_keymap_vsplit  = '<C-v>'


nnoremap <silent><Leader>n :RangerOpenCurrentFile<CR>
nnoremap <silent><Leader>c :RangerOpenCurrentDir<CR>
nnoremap <silent><Leader>f :RangerOpenProjectRootDir<CR>
		
"COC - auto completion 

" use <tab> for trigger completion and navigate to the next complete item
function! s:check_back_space() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~ '\s'
endfunction

inoremap <silent><expr> <Tab>
      \ pumvisible() ? "\<C-n>" :
      \ <SID>check_back_space() ? "\<Tab>" :
      \ coc#refresh()
