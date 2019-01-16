let mapleader = ' '
let maplocalleader = ' '

" ==============
" Basic settings
" ==============
syntax enable
set nu rnu
set number relativenumber
set background=dark
set visualbell
set expandtab
set tabstop=2
set shiftwidth=2
set softtabstop=2
set autoindent
set smartindent
set nowrap
set title
set encoding=utf-8
set lazyredraw
set showmatch
set hlsearch
set mouse=a
set incsearch
if has('nvim')                 " enable live substitution in neovim
  set inccommand=nosplit
endif
set nostartofline
set nocompatible
set autoread                   " read changes to file made externally
set wildmenu
set backspace=indent,eol,start " make backspace function as it should
set so=7                       " set 7 lines to the cursor when moving vertically
set splitbelow
set splitright
set ignorecase
set smartcase
set nohlsearch
set noshowmode
set cmdheight=2                " height of command bar
set hidden                     " hides buffers when they're abandoned
set mat=2                      " blink matching brackets for 2/10 second
set clipboard=unnamedplus      " enable copying to system clipboard
set diffopt+=vertical          " Force diff to use vertical split
filetype plugin indent on

" 80 chars/line
set textwidth=0
if exists('&colorcolumn')
  set colorcolumn=80
endif

" files, backups, undo
set nobackup
set nowb
set noswapfile

silent! if plug#begin('~/.vim/plugged')

" neovim plugins
" ==============

if has('nvim')
  Plug 'autozimu/LanguageClient-neovim', {
      \ 'branch': 'next',
      \ 'do': 'bash install.sh',
      \ }
  let g:LanguageClient_serverCommands = {
      \ 'javascript': ['javascript-typescript-stdio'],
      \ 'typescript': ['javascript-typescript-stdio'],
      \ 'rust': ['~/.cargo/bin/rustup', 'run', 'stable', 'rls'],
      \ }

  Plug 'Shougo/deoplete.nvim',  { 'do': ':UpdateRemotePlugins' }
else
  Plug 'Shougo/deoplete.nvim'
  Plug 'roxma/nvim-yarp'
  Plug 'roxma/vim-hug-neovim-rpc'
endif

let g:deoplete#enable_at_startup = 1

" vim plugins
" ===========

Plug 'airblade/vim-gitgutter'

Plug 'editorconfig/editorconfig-vim'
let g:EditorConfig_exclude_patterns = ['fugitive://.*', 'scp://.*']

Plug 'fleischie/vim-styled-components', { 'for': ['javascript', 'javascript.jsx'] }

Plug 'itchyny/lightline.vim'
let g:lightline = {
      \ 'colorscheme': 'seoul256',
      \ }

Plug 'jremmen/vim-ripgrep'
Plug 'jiangmiao/auto-pairs'

Plug 'junegunn/fzf',                    { 'dir': '~/.fzf', 'do': './install --all' }
Plug 'junegunn/fzf.vim'
map <Leader>p :FZF<CR>

Plug 'junegunn/rainbow_parentheses.vim'

Plug 'junegunn/seoul256.vim'
let g:seoul256_background = 235

Plug 'junegunn/vim-easy-align',         { 'on': ['<Plug>(EasyAlign)', 'EasyAlign'] }
xmap ga <Plug>(EasyAlign)
nmap ga <Plug>(EasyAlign)

Plug 'justinmk/vim-dirvish'
Plug 'jxnblk/vim-mdx-js'
Plug 'machakann/vim-highlightedyank'

Plug 'majutsushi/tagbar'
map <Leader>tt <esc>:TagbarToggle<cr>

Plug 'mattn/emmet-vim'

Plug 'mxw/vim-jsx',                     { 'for': ['javascript.jsx'] }
let g:jsx_ext_required = 0

Plug 'nathanaelkane/vim-indent-guides'
Plug 'othree/es.next.syntax.vim',       { 'for': ['javascript', 'javascript.jsx'] }
Plug 'othree/yajs.vim',                 { 'for': ['javascript', 'javascript.jsx'] }

Plug 'plasticboy/vim-markdown',         { 'for': 'markdown' }
let g:vim_markdown_folding_disabled = 1
let g:vim_markdown_new_list_item_indent = 0 " disable auto-indent in lists
let g:instant_markdown_autostart = 0

Plug 'racer-rust/vim-racer',            { 'for': 'rust' }
" let g:racer_experimental_completer = 1

Plug 'sbdchd/neoformat'
nnoremap fmt :Neoformat<cr>

Plug 'sheerun/vim-polyglot'
let g:polyglot_disabled = ['javascript', 'javascript.jsx']

Plug 'Shougo/neosnippet.vim'
imap <C-k> <Plug>(neosnippet_expand_or_jump)
smap <C-k> <Plug>(neosnippet_expand_or_jump)
xmap <C-k> <Plug>(neosnippet_expand_target)

Plug 'Shougo/neosnippet-snippets'
Plug 'slashmili/alchemist.vim',         { 'for': 'elixir' }
Plug 'tpope/vim-commentary'
Plug 'tpope/vim-endwise'
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-repeat'
Plug 'tpope/vim-rhubarb'
Plug 'tpope/vim-surround'
Plug 'tpope/vim-unimpaired'

Plug 'w0rp/ale'
nmap <silent> <C-k> <Plug>(ale_previous_wrap)
nmap <silent> <C-j> <Plug>(ale_next_wrap)

call plug#end()
endif


" ========
" Mappings
" ========

" buffers
nnoremap ]b :bnext<cr>
nnoremap [b :bprev<cr>

" tabs
nnoremap ]t :tabn<cr>
nnoremap [t :tabp<cr>

" circular window navigation
nnoremap <tab>   <c-w>w
nnoremap <S-tab> <c-w>W

" Enable spellcheck
autocmd FileType markdown setlocal spell

" markdown preview
if executable("vmd")
  autocmd FileType markdown nnoremap mdp :!vmd <C-r>=shellescape(expand('%'), 1)<cr> &<cr>
endif

" javascript
let g:javascript_plugin_jsdoc = 1
let g:javascript_plugin_flow = 1

" rust
let g:rustfmt_autosave = 1

silent! colo seoul256

vnoremap <C-j> :m '>+1<CR>gv=gv
vnoremap <C-k> :m '<-2<CR>gv=gv
