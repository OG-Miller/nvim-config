set nocompatible 		" be iMproved, required
filetype off 			" required

if executable("rg")
    set grepprg=rg\ --vimgrep\ --no-heading
    set grepformat=%f:%l:%c:%m,%f:%l:%m
endif
" this starts the file unfolded
" zi toggles between foldenabled / nofoldenabled
set nofoldenable
set foldmethod=indent
set autoread
set nowrap linebreak nolist       " wrap line on full words
set number
set splitbelow
set splitright
set mouse=a
"set ignorecase
"set smartcase
set encoding=utf-8
set tabstop=2
set shiftwidth=2
set expandtab
set cursorline
set so=999 " keep cursor in middle of page
set hls ic
"set relativenumber
nnoremap <leader>r :bufdo set rnu! <cr>
"set rnu! (toggle relative numbers)
"
" Plugins -------------------
packadd cfilter

call plug#begin('~/.config/nvim/plugged')
Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}
Plug 'nvim-treesitter/nvim-treesitter-context'
Plug 'lukas-reineke/indent-blankline.nvim'
Plug 'neovim/nvim-lspconfig'
Plug 'navarasu/onedark.nvim'
Plug 'shaunsingh/nord.nvim'
Plug 'EdenEast/nightfox.nvim'
Plug 'sonph/onehalf', { 'rtp': 'vim' }
Plug 'tanvirtin/monokai.nvim'
Plug 'vim-scripts/SlateDark'
" Lualine & Dev Icons ---
Plug 'nvim-lualine/lualine.nvim'
Plug 'kyazdani42/nvim-web-devicons'
" Lualine & Dev Icons ---
" Plug 'itchyny/lightline.vim' 
Plug 'gilgigilgil/anderson.vim' " harmonious lightline themes: Tomorrow_Night / seoul256
Plug 'overcache/NeoSolarized'
Plug 'jacoborus/tender.vim'
Plug 'projekt0n/github-nvim-theme'
"Plug 'neoclide/coc.nvim', {'branch': 'release'}
Plug 'preservim/nerdtree'
Plug 'Xuyuanp/nerdtree-git-plugin'
Plug 'airblade/vim-gitgutter'
Plug 'ctrlpvim/ctrlp.vim'
Plug 'rust-lang/rust.vim'
Plug 'tpope/vim-fugitive'
Plug 'nvim-lua/plenary.nvim'
" auto complete ------
Plug 'neovim/nvim-lspconfig'
Plug 'hrsh7th/cmp-nvim-lsp'
Plug 'hrsh7th/cmp-buffer'
Plug 'hrsh7th/cmp-path'
Plug 'hrsh7th/cmp-cmdline'
Plug 'hrsh7th/nvim-cmp'
" snippet engine
Plug 'hrsh7th/cmp-vsnip'
Plug 'hrsh7th/vim-vsnip'
" ------------
call plug#end()

lua require('og-miller')

let g:gitgutter_terminal_reports_focus=0

" GENERAL VIMPROVEMENTS ---------------------- 
nnoremap :reload :source $MYVIMRC<CR>
" copy highlighted to global clipboard
vnoremap <leader>c "*y
" yank to end of line
noremap Y y$
nnoremap "" "0p
nnoremap + <esc>o+ 
" briefly highlight yanked text
augroup highlight_yank
    autocmd!
    au TextYankPost * silent! lua vim.highlight.on_yank { higroup='IncSearch', timeout=200 }
augroup END

" GREP / SEARCH -------------------------------
" immediate grep word under cursor
" old grep pattern: nnoremap <Space>G viwy q:<insert>grep! '' packages/**/*.{ts,tsx} <esc>2F'p<CR>
"
" this searches for .ts files only(removes .d.ts, keeps tsx), to add another file type use -tjs, to
" remove a file type use -Tjs etc.
 nnoremap <Space>G viwy q:<insert>grep! '' -tts <esc>2F'p<CR>
" open grep in ready position
nnoremap <Space>g q:<insert>grep! -i '' -tts<esc>F'<insert>
" step to next quickfix item 
nnoremap <leader>] :cnext<CR>
" step to previous quickfix item 
nnoremap <leader>[ :cprev<CR>

" NAVIGATION ----------------------------------
" use Ctrl o (in insert mode) to create new line and indent - for fn body
inoremap <C-o> <Enter><Esc><S-o><tab>
" niko's buffer navigation suggestion
"nnoremap <leader>q :echo execute('ls t')->split("\n")[:10]->join("\n")<cr>:buffer<space>
" auto enter :buffer for buffer search (with t flag for 'order by Time')
nnoremap :ls :ls t<CR>:b <Space>
"nnoremap <leader>q :echo execute('ls t')->split("\n")[:10]->join("\n")<cr>:buffer<space>
" ---------------------------------------------

" MARKS ----------------------------------
" auto enter marks list ready to select one or just esc to peek
nnoremap :lm :<C-u>marks<CR>:normal! `
"
" close quickfix faster (for when got to definition opens quickfix)
nnoremap <leader><Esc> :cclose<cr>
" open quickfix faster
nnoremap <leader><Enter> :copen 20<cr>
" filter out schemas eg :no schemas
nnoremap :no :Cfilter!  
" keep only schemas eg :only schemas
nnoremap :only :Cfilter 

" SPEAR----WIP ------------------------------------->
" todo: make invisible to jumplist
" todo: remove duplicates 

"nnoremap <leader>c :call bufexists('SPEAR')<cr>
"nnoremap <leader>c :call appendbufline('SPEAR', line(), ['some', 'text'])

func AddFileToSpear()
    :keepjumps e SPEAR | r !echo # 
    :setlocal buftype=nofile 
    :setlocal nobuflisted
    :setlocal bufhidden 
    ":w
    :e# 
    echo '--spear-->'
    echo ''
endfunc
nnoremap <leader>f :call AddFileToSpear()<cr>
"nnoremap <silent> <leader>D :edit ./SPEAR<cr>
func OpenSpear()
    ":keepjumps exe ":edit ./SPEAR"
    :exe "keepjumps :edit ./SPEAR"
   " :setlocal buftype=
    :setlocal nobuflisted
    :setlocal bufhidden=hide
endfunc
nnoremap <silent> <leader>F :keepjumps :call OpenSpear()<cr>
" --------------------------------------------------------------------->
" toggle text wrap
nnoremap <leader>w :set wrap!<cr> 

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
" format file
" nnoremap :fmt <cmd>lua vim.lsp.buf.formatting()<CR>

" RUST ------------------------------------
" format on save
let g:rustfmt_autosave = 1
"syntax enable
filetype plugin indent on


" WINBAR/STATUS BAR (at top of windows) use this with neovim 0.8 or higher
" set statusline+=%F
set winbar=%t

 set laststatus=3
 "hi WinBar guibg=#036EDB
 "hi WinBar guifg=#036EDB
 hi WinBar guifg=#fcb814

" " LIGHTLINE -------------------------------
" "let g:lightline = { 'colorscheme':'tender' }
" syntax enable
" "removes the duplicated 'insert / 'normal' mode etc under status bar 
" set noshowmode 
" set statusline+=%F
" let g:lightline = {
"       \ 'colorscheme': 'nord',
"       \ 'active': {
"       \   'left': [ [ 'mode', 'paste','gitbranch' ]],
"       \   'right': [ [ 'relativepath', 'modified' ] ],
"       \ },
"       \ 'component_function': {
"       \   'gitbranch': 'FugitiveHead'
"       \ },
"       \ }
 
" COLORSCHEMES 
"let g:lightline = { 'colorscheme':'tender' }
 
" INDENT-BLANKLINE
"below only required if you want something other than the thin line
"let g:indent_blankline_char_list = ['|']
"let g:indent_blankline_use_treesitter = v:true
"
" added this to keep showing lines when unfolding (previously they were gone)
" don't know if this fixed it, keep an eye on it
let g:indent_blankline_show_foldtext = v:false


" commenting (h for hide)
vnoremap <C-h> o0<C-v><S-i>//<space><esc> 
" uncommenting (y is above h)
vnoremap <C-y> :s/\/\/ /<CR>

"CTRLp ------------------------------------------------
" Use ripgrep
"if executable("rg")
"    set grepprg=rg\ --color=never
"    let g:ctrlp_user_command = 'rg %s --files --color=never --glob ""'
"    let g:ctrlp_use_caching = 0
"else
"    let g:ctrl_clear_cache_on_exit = 0 
"endif

" Ignore some folders and files for CtrlP indexing
let g:ctrlp_custom_ignore = 'node_modules\|DS_Store\|git\|lib\|dist'
" Show dotfiles
let g:ctrlp_show_hidden = 1
" Search by filename (as opposed to full path) as the default
" ( use <C-b> to switch between modes )
let g:ctrlp_by_filename = 1
"/CTRLp ------------------------------------------------

if (has("termguicolors"))
set termguicolors
endif




" COLORSCHEMES 
" specific cursorline setting for 'slateDark' colorscheme
"hi CursorLine term=bold cterm=bold guibg=#333333
"let g:onedark_config = {
"    \ 'style': 'warm',
"\}

" colorscheme tender 
"require('github-theme').setup()


" specific cursorline setting for 'slateDark' colorscheme
"hi CursorLine term=bold cterm=bold guibg=#333333
" specific cursorline setting for 'anderson' colorscheme
"hi CursorLine term=bold cterm=bold guibg=#4c4c4c

" NERDTREE   
"map <silent> <C-n> :NERDTreeFocus<CR>
" show bookmarks list at top of nerdTree
"let NERDTreeShowBookmarks=1
map <silent> <leader>b :NERDTreeFocus<CR>
let NERDTreeQuitOnOpen=3
" find current file in the NerdTree
nnoremap :nf :NERDTreeFind<CR>
" refresh file tree
nnoremap :nr :NERDTreeRefreshRoot<CR>

" AUTOCOMPLETE ------------------------------------------
" Set completeopt to have a better completion experience
set completeopt=menuone,noinsert,noselect
let g:completion_enable_auto_popup = 0

" INTEGRATED TERMINAL 
command Term :split <bar> :term
"nnoremap <leader>t :split <bar> :term<cr>
" easier split screen navigation
nnoremap <C-h> <C-w>h
nnoremap <C-j> <C-w>j
nnoremap <C-k> <C-w>k
nnoremap <C-l> <C-w>l
" On split screen, make left side smaller by 20 (opening nerdtree resets to middle)
nnoremap <leader>< <C-W>50<
nnoremap <leader>> <C-W>50>
nnoremap <leader>- <C-W>10-
nnoremap <leader>= <C-W>=
