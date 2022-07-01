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
"set conceallevel=2 " hides _ and * in markdown files
set nofoldenable    " disable folding
set relativenumber
" set rnu! toggle relative numbers
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
"Plug 'neoclide/coc.nvim', {'branch': 'release'}
Plug 'preservim/nerdtree'
Plug 'Xuyuanp/nerdtree-git-plugin'
Plug 'airblade/vim-gitgutter'
Plug 'ctrlpvim/ctrlp.vim'
Plug 'rust-lang/rust.vim'
Plug 'tpope/vim-fugitive'
Plug 'nvim-lua/plenary.nvim'
Plug 'nvim-telescope/telescope.nvim'
Plug 'lfv89/vim-interestingwords'
" auto complete ------
Plug 'neovim/nvim-lspconfig'
Plug 'hrsh7th/cmp-nvim-lsp'
Plug 'hrsh7th/cmp-buffer'
Plug 'hrsh7th/cmp-path'
Plug 'hrsh7th/cmp-cmdline'
Plug 'hrsh7th/nvim-cmp'
" ------------
call plug#end()

lua require('og-miller')

let g:gitgutter_terminal_reports_focus=0

" GENERAL VIMPROVEMENTS ---------------------- 
" copy highlighted to global clipboard
vnoremap <leader>c "*y
" yank to end of line
noremap Y y$
nnoremap "" "0p
" de is awkward to press, but it puts cursor in better positon
" to paste word in place of deleted word, than dw does.
"nnoremap dw de
nnoremap + <esc>o+ 

" GREP / SEARCH -------------------------------
" open grep in ready position
nnoremap <Space>g q:<insert>grep '' packages/**/*.{ts,tsx} --exclude=\*.d.ts<esc>F'<insert>
 
" NAVIGATION ----------------------------------
" use Ctrl o (in insert mode) to create new line and indent - for fn body
inoremap <C-o> <Enter><Esc><S-o> 
" auto enter :b for faster buffer search
nnoremap :ls :ls<CR>:b<Space>
" use backspace to go to previous buffer 
nnoremap <Space><BS> :bp<CR>
" use enter to go to previous buffer
" //TODO: this breaks when entering a file
" from quickfix list, so choose something better
nnoremap <leader><BS> :bn<CR>
 
" briefly highlight yanked text
augroup highlight_yank
    autocmd!
    au TextYankPost * silent! lua vim.highlight.on_yank { higroup='IncSearch', timeout=200 }
augroup END
" close quickfix faster (for when got to definition opens quickfix)
nnoremap <leader><Esc> :cclose<cr>
" open quickfix faster
nnoremap <leader><Enter> :copen 20<cr>

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
      \ 'colorscheme': 'tender',
      \ 'active': {
      \   'left': [ [ 'mode', 'paste','gitbranch' ]],
      \   'right': [ [ 'readonly', 'relativepath', 'modified' ] ],
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
" remove .js from search, TODO: make this work in 'custom-ignore' section
"let g:ctrlp_user_command = 'find %s -type f | grep -v ".js"'
" Ignore some folders and files for CtrlP indexing
let g:ctrlp_custom_ignore = {
  \ 'dir':  '\.git$\|\.yardoc\|dist-es\|lib\|node_modules\|log\|tmp$',
  \ 'file': '\.so$\|\.dat$|\.DS_Store$|\.js$'
  \ }

if (has("termguicolors"))
set termguicolors
endif

" COLORSCHEMES 
" specific cursorline setting for 'slateDark' colorscheme
"hi CursorLine term=bold cterm=bold guibg=#333333
"let g:onedark_config = {
"    \ 'style': 'warm',
"\}
colorscheme tender 
" specific cursorline setting for 'slateDark' colorscheme
"hi CursorLine term=bold cterm=bold guibg=#333333
" specific cursorline setting for 'anderson' colorscheme
hi CursorLine term=bold cterm=bold guibg=#4c4c4c

" NERDTREE   
"map <silent> <C-n> :NERDTreeFocus<CR>
map <leader>b :NERDTreeFocus<CR>
let NERDTreeQuitOnOpen=1

" TELESCOPE 
nnoremap <leader>f <cmd>Telescope find_files<cr>

"autocomplete temporary solution 
"TODO: try to find auto-suggestions in :h autocomplete
inoremap kk <C-x><C-o>
" this stops an empty 'scratch' buffer opening when you select an option
set completeopt=menu,menuone

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

