"tender set nocompatible 		" be iMproved, required
filetype off 			" required
set wrap linebreak nolist       " wrap line on full words
set number
set splitbelow

call plug#begin('~/.config/nvim/plugged')
" themes
Plug 'tanvirtin/monokai.nvim'
Plug 'itchyny/lightline.vim' 
"Plug 'overcache/NeoSolarized'
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

let g:gitgutter_terminal_reports_focus=0

" GENERAL VIMPROVEMENTS ---------------------- 
" copy highlighted to global clipboard
vnoremap <leader>c "*y
set encoding=utf-8
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

" Abbreviations ------------------------------
ab :tick: ✓
ab :box: [ ] 
ab :dot: •
ab :?: ¿
" todolist
ab :to: <cmd>:r ~/.config/nvim/text/todo.txt<CR><Esc>2j$ :startinsert!
nnoremap <C-y> mm$F[<space>r✓<esc>`mll
nnoremap <C-n> mn$F[<space>r<space><esc>`nhh 

set tabstop=4
set shiftwidth=4
set expandtab
set cursorline
" keep cursor in middle of page
set so=999
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
      \ 'colorscheme': 'wombat',
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
"syntax enable

"CTRLp
" open recently viewed files list - deprecated, use buffer list  :ls :b
nnoremap <leader>r :CtrlPMRUFiles<cr>  
let g:ctrlp_custom_ignore = 'node_modules\|DS_Store\|git'

if (has("termguicolors"))
 set termguicolors
endif

" COLORSCHEMES 
colorscheme monokai
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
" use this to escape integrated terminal once
"you figure out how to escape from terminal mode
tnoremap <leader><Esc> <C-\><C-n>:q<cr>
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

