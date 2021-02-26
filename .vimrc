set shell=/bin/bash

let mapleader = ' '
let maplocalleader = ' '

" ==============
" Basic settings
" ==============
syntax enable
set nu rnu
set number relativenumber
set visualbell
set cursorline
set expandtab
" set tabstop=2
set shiftwidth=2
set softtabstop=2
set autoindent
" set smartindent
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

if has('nvim')
  set diffopt+=vertical          " Force diff to use vertical split
endif

if exists('+termguicolors')
  let &t_8f = "\<Esc>[38;2;%lu;%lu;%lum"
  let &t_8b = "\<Esc>[48;2;%lu;%lu;%lum"
  set termguicolors
endif
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

" permanent undo
set undodir=~/.vimdid
set undofile

silent! if plug#begin('~/.vim/plugged')

Plug 'airblade/vim-gitgutter'
Plug 'airblade/vim-rooter'

Plug 'editorconfig/editorconfig-vim'
let g:EditorConfig_exclude_patterns = ['fugitive://.*', 'scp://.*']

Plug 'itchyny/lightline.vim'
let g:lightline = {
      \ 'colorscheme': 'seoul256',
      \ }

Plug 'jremmen/vim-ripgrep'
Plug 'jiangmiao/auto-pairs'

Plug 'junegunn/fzf',                    { 'dir': '~/.fzf', 'do': './install --all' }
Plug 'junegunn/fzf.vim'
map <Leader><Leader> :FZF<CR>
imap <c-x><c-f> <plug>(fzf-complete-path)

Plug 'junegunn/rainbow_parentheses.vim'
Plug 'junegunn/seoul256.vim'
Plug 'justinmk/vim-dirvish'
Plug 'jxnblk/vim-mdx-js'
Plug 'machakann/vim-highlightedyank'
" Plug 'machakann/vim-sandwich'
Plug 'mattn/emmet-vim'
let g:user_emmet_leader_key='<C-Z>'

Plug 'mxw/vim-jsx',                     { 'for': ['jsx'] }
let g:jsx_ext_required = 0

Plug 'nathanaelkane/vim-indent-guides'

Plug 'othree/es.next.syntax.vim',       { 'for': ['javascript', 'jsx'] }
Plug 'othree/yajs.vim',                 { 'for': ['javascript', 'jsx'] }

Plug 'plasticboy/vim-markdown',         { 'for': 'markdown' }
let g:vim_markdown_folding_disabled = 1
let g:vim_markdown_new_list_item_indent = 0 " disable auto-indent in lists
let g:instant_markdown_autostart = 0

let prettier_filetypes = ['javascript', 'jsx', 'typescript', 'tsx', 'css', 'less', 'scss', 'json', 'graphql', 'markdown', 'vue', 'yaml', 'html', 'svelte']
Plug 'prettier/vim-prettier', {
  \ 'do': 'yarn install',
  \ 'for': prettier_filetypes }
autocmd FileType javascript,jsx,typescript,tsx,css,less,scss,json,graphql,markdown,vue,yaml,html,svelte nmap <Leader>cf <Plug>(Prettier)

Plug 'sheerun/vim-polyglot'
let g:polyglot_disabled = ['javascript', 'jsx']

Plug 'slashmili/alchemist.vim',         { 'for': 'elixir' }
Plug 'tpope/vim-commentary'
Plug 'tpope/vim-endwise'
Plug 'tpope/vim-repeat'
Plug 'tpope/vim-unimpaired'
Plug 'wellle/targets.vim'

call plug#end()
endif


" ========
" Mappings
" ========

" Easier split navigation
nnoremap <C-J> <C-W><C-J>
nnoremap <C-K> <C-W><C-K>
nnoremap <C-L> <C-W><C-L>
nnoremap <C-H> <C-W><C-H>

" Enable spellcheck
autocmd FileType markdown setlocal spell

" markdown preview
if executable("vmd")
  autocmd FileType markdown nnoremap mdp :!vmd <C-r>=shellescape(expand('%'), 1)<cr> &<cr>
endif

" javascript
let g:javascript_plugin_jsdoc = 1

" rust
let g:rustfmt_autosave = 1

" set color scheme
colo seoul256
set background=dark
