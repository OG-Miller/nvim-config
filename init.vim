set nocompatible 		" be iMproved, required
filetype off 			" required
if executable("rg")
    set grepprg=rg\ --vimgrep\ --no-heading
    set grepformat=%f:%l:%c:%m,%f:%l:%m
endif
" this starts the file unfolded
" zi toggles between foldenabled / nofoldenabled
set foldmethod=indent
set foldexpr=nvim_treesitter#foldexpr()
set nofoldenable
set rnu
set autoread
set nowrap linebreak nolist       " wrap line on full words
set number
set splitbelow
set splitright
set noscrollbind
set mouse=a
"set ignorecase
"set smartcase
set encoding=utf-8
set shiftwidth=2
set tabstop=1
set expandtab
set cursorline
set so=999 " keep cursor in middle of page
set hls ic
"set relativenumber on all buffers 
"nnoremap <leader>r :bufdo set rnu! <cr>
"toggle relative numbers
nnoremap <leader>r :set rnu!<cr>
"
" Plugins -------------------
packadd cfilter
call plug#begin('~/.config/nvim/plugged')
Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}
Plug 'nvim-treesitter/nvim-treesitter-context'
Plug 'lukas-reineke/indent-blankline.nvim'
Plug 'neovim/nvim-lspconfig'
Plug 'shaunsingh/nord.nvim'
Plug 'navarasu/onedark.nvim'
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
Plug 'ThePrimeagen/harpoon'
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


" Add a sign with text "*" and highlight the current line
let s:sign_added = 0

if !exists('s:sample_sign_defined')
  sign define sample_sign text=* texthl=Search
  let s:sample_sign_defined = 1
endif

function! ToggleSignAndHighlight()
  if s:sign_added
    sign unplace *
    execute 'match none'
  else
    execute 'sign place 123 line=' . line('.') . ' name=sample_sign file=' . expand('%:p')
    execute 'match Search /\%' . line('.') . 'l/'
  endif
  let s:sign_added = !s:sign_added
endfunction

nnoremap <leader>s :call ToggleSignAndHighlight()<CR>

" GENERAL VIMPROVEMENTS ---------------------- 
" stop uppercase V typo from slowing you down
nnoremap :Vs :vs  
nnoremap <leader>t :tabnew<CR>
nnoremap :reload :source $MYVIMRC<CR>
" copy highlighted to global clipboard
"vnoremap <leader>c "*y
" yank visual selection to global clipboard. Will keep the above version
" around too until I get used to it
vnoremap y "*y
" yank to end of line
noremap Y y$
nnoremap "" "0p
nnoremap + <esc>o+ 


" auto reload file when it has been changed outside of the buffer.
" The autocmd! clears all previously defined auto commands in the active group
" so that they are not duplicated when you source the file again.
augroup AUTOMATIONS
     autocmd!
     autocmd CursorMoved * silent! checktime
augroup END


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
 nnoremap <Space>G viwy q:<insert>grep! '' <esc>2F'p<CR>
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
" split screen & go to definition
nnoremap <leader>d :vs<cr>  <cmd>lua vim.lsp.buf.definition()<CR>

" MARKS ----------------------------------
" auto enter marks list ready to select one or just esc to peek
nnoremap :lm :<C-u>marks<CR>:normal! `
"
" TODO: close location list (eg tsserver error list) make mapping for :lclose
" make function that checks if quickfix or location list is open, and closes
" the correct one
nnoremap <leader>q <Esc> :lclose<cr>
" close quickfix faster (for when got to definition opens quickfix)
nnoremap <leader><Esc> :cclose<cr>
" open quickfix faster
nnoremap <leader><Enter> :copen 20<cr><C-w>J
" filter out schemas eg :no schemas
nnoremap :no :Cfilter!  
" keep only schemas eg :only schemas
nnoremap :only :Cfilter 

" PRETTIER format current file
nnoremap <space>p :silent !npx prettier -w %<cr>

" HARPOON -----------------------------
nnoremap <leader>h :lua require("harpoon.mark").add_file()<cr>
nnoremap <silent> <leader>a :lua require("harpoon.ui").toggle_quick_menu()<cr>

" SPEAR----WIP ------------------------------------->
" todo: make invisible to jumplist
" todo: remove duplicates 

"nnoremap <leader>c :call bufexists('SPEAR')<cr>
"nnoremap <leader>c :call appendbufline('SPEAR', line(), ['some', 'text'])

" func AddFileToSpear()
"     :keepjumps e SPEAR | r !echo # 
"     :setlocal buftype=nofile 
"     :setlocal nobuflisted
"     :setlocal bufhidden 
"     ":w
"     :e# 
"     echo '--spear-->'
"     echo ''
" endfunc
" nnoremap <leader>f :call AddFileToSpear()<cr>
" "nnoremap <silent> <leader>D :edit ./SPEAR<cr>
" func OpenSpear()
"     ":keepjumps exe ":edit ./SPEAR"
"     :exe "keepjumps :edit ./SPEAR"
"    " :setlocal buftype=
"     :setlocal nobuflisted
"     :setlocal bufhidden=hide
" endfunc
" nnoremap <silent> <leader>F :keepjumps :call OpenSpear()<cr>
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
" replace + list item with ✓ 
nnoremap <C-y> mm$F+r✓<esc>`mll

" toggle cursor to stay in middle of page
command Moff :set so=1
command Mon :set so=999
" remove search highlights on escape
nnoremap <silent> <ESC> :noh<CR>


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


" added this to keep showing lines when unfolding (previously they were gone)
" don't know if this fixed it, keep an eye on it
let g:indent_blankline_show_foldtext = v:false
nnoremap <leader>z :set foldlevel=0<cr>

" commenting (h for hide)
vnoremap <C-h> o0<C-v><S-i>//<space><esc> 
" uncommenting (y is above h)
vnoremap <C-y> :s/\/\/ /<CR>

"CTRLp ------------------------------------------------
let g:ctrlp_max_files=0
let g:ctrlp_height = 20
let g:ctrlp_match_window = 'bottom,order:btt,min:3,max:10,results:10'

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

" NERDTREE   
" temp fix nvim 9.0 half screen issue
" this opens a one line menu rather than bottom half of screen
" alternative is to just ctrl +/- to resize a little
let g:NERDTreeMinimalMenu=1
let g:NERDTreeWinSize=60
let NERDTreeQuitOnOpen=3
map <silent> <leader>b :NERDTreeFocus<CR>
" find current file in the NerdTree
nnoremap :nf :NERDTreeFind<CR>
" refresh file tree
nnoremap :nr :NERDTreeRefreshRoot<CR>

" AUTOCOMPLETE ------------------------------------------
" Set completeopt to have a better completion experience
set completeopt=menuone,noinsert,noselect
let g:completion_enable_auto_popup = 0

" SPLIT SCREEN navigation
nnoremap <C-h> <C-w>h
nnoremap <C-j> <C-w>j
nnoremap <C-k> <C-w>k
nnoremap <C-l> <C-w>l
" On split screen, increase selected screen size by 50 etc
nnoremap <leader>< <C-W>50<
nnoremap <leader>> <C-W>50>
" On split screen, make panes equal sized
nnoremap <leader>= <C-W>=
