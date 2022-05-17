"tender set nocompatible 		" be iMproved, required
filetype off 			" required
set wrap linebreak nolist       " wrap line on full words
set number
set splitbelow
set mouse=a
set ignorecase
set smartcase
set encoding=utf-8
set tabstop=4
set shiftwidth=4
set expandtab
set cursorline
set so=999 " keep cursor in middle of page
set conceallevel=2 " hides _ and * in markdown files

" Plugins -------------------

call plug#begin('~/.config/nvim/plugged')
Plug 'neovim/nvim-lspconfig'
Plug 'navarasu/onedark.nvim'
Plug 'shaunsingh/nord.nvim'
Plug 'EdenEast/nightfox.nvim'
Plug 'sonph/onehalf', { 'rtp': 'vim' }
Plug 'tanvirtin/monokai.nvim'
Plug 'vim-scripts/SlateDark'
Plug 'itchyny/lightline.vim' 
Plug 'gilgigilgil/anderson.vim' " harmonious lightline themes: Tomorrow_Night / seoul256
Plug 'overcache/NeoSolarized'
Plug 'jacoborus/tender.vim'
Plug 'preservim/nerdtree'
Plug 'Xuyuanp/nerdtree-git-plugin'
Plug 'airblade/vim-gitgutter'
Plug 'ctrlpvim/ctrlp.vim'
Plug 'rust-lang/rust.vim'
Plug 'tpope/vim-fugitive'
Plug 'nvim-lua/plenary.nvim'
Plug 'nvim-telescope/telescope.nvim'
Plug 'lfv89/vim-interestingwords'

call plug#end()

lua require('og-miller')

let g:gitgutter_terminal_reports_focus=0

" GENERAL VIMPROVEMENTS ---------------------- 
" copy highlighted to global clipboard
vnoremap <leader>c "*y
" yank to end of line
noremap Y y$

" NAVIGATION ----------------------------------
" use Ctrl o (in insert mode) to create new line and indent - for fn body
inoremap <C-o> <Enter><Esc><S-o> 
" auto enter :b for faster buffer search
nnoremap :ls :ls<CR>:b<Space>
" briefly highlight yanked text
augroup highlight_yank
    autocmd!
    au TextYankPost * silent! lua vim.highlight.on_yank { higroup='IncSearch', timeout=200 }
augroup END
" close quickfix faster (for when got to definition opens quickfix)
nnoremap <leader><Esc> :cclose<cr>

" Abbreviations ------------------------------
ab :tick: ✓
ab :box: [ ] 
ab :dot: •
ab :?: ¿
" todolist
ab :to: <cmd>:r ~/.config/nvim/text/todo.txt<CR><Esc>2j$ :startinsert!
nnoremap <C-y> mm$F[<space>r✓<esc>`mll
nnoremap <C-n> mn$F[<space>r<space><esc>`nhh 

" toggle cursor to stay in middle of page
command Moff :set so=1
command Mon :set so=999
" remove search highlights on escape
nnoremap <silent> <ESC> :noh<CR>

" TYPESCRIPT ------------------------------
" see: https://pragmaticpineapple.com/ultimate-vim-typescript-setup/
"nmap <silent> gd <Plug>(coc-definition)
"nmap <silent> gy <Plug>(coc-type-definition)
"nmap <silent> gi <Plug>(coc-implementation)
"nmap <silent> gr <Plug>(coc-references)


" RUST ------------------------------------
" format on save
let g:rustfmt_autosave = 1
"syntax enable
filetype plugin indent on

" LIGHTLINE -------------------------------
"let g:lightline = { 'colorscheme':'tender' }
syntax enable
"removes the duplicated 'insert / 'normal' mode etc under status bar 
set noshowmode 
set statusline+=%F
let g:lightline = {
      \ 'colorscheme': 'Tomorrow_Night',
      \ 'active': {
      \   'left': [ [ 'mode', 'paste' ]],
      \   'right': [ [ 'gitbranch', 'readonly', 'filename', 'modified' ] ],
      \ },
      \ 'component_function': {
      \   'gitbranch': 'FugitiveHead'
      \ },
      \ }

" COLORSCHEMES 
"let g:lightline = { 'colorscheme':'tender' }




"CTRLp
" open recently viewed files list - deprecated, use buffer list  :ls :b
nnoremap <leader>r :CtrlPMRUFiles<cr>  
let g:ctrlp_custom_ignore = 'node_modules\|DS_Store\|git'

if (has("termguicolors"))
set termguicolors
endif

" COLORSCHEMES 
" specific cursorline setting for 'slateDark' colorscheme
"hi CursorLine term=bold cterm=bold guibg=#333333
"let g:onedark_config = {
"    \ 'style': 'warm',
"\}
colorscheme anderson 
" specific cursorline setting for 'slateDark' colorscheme
"hi CursorLine term=bold cterm=bold guibg=#333333
" specific cursorline setting for 'anderson' colorscheme
hi CursorLine term=bold cterm=bold guibg=#4c4c4c

" NERDTREE   
"map <silent> <C-n> :NERDTreeFocus<CR>
map <leader>b :NERDTreeFocus<CR>

" TELESCOPE 
nnoremap <leader>f <cmd>Telescope find_files<cr>
" below is currently not working - maybe burntsushi / ripgrep issue?
nnoremap <leader>fg <cmd>Telescope live_grep<cr>

" INTEGRATED TERMINAL 
command Term :split <bar> :term
nnoremap <leader>t :split <bar> :term<cr>
" easier split screen navigation
nnoremap <C-h> <C-w>h
nnoremap <C-j> <C-w>j
nnoremap <C-k> <C-w>k
nnoremap <C-l> <C-w>l
" On split screen, make left side smaller by 20 (opening nerdtree resets to middle)
nnoremap <leader>< <C-W>20<
nnoremap <leader>> <C-W>20>
nnoremap <leader>- <C-W>10-
nnoremap <leader>= <C-W>10+

