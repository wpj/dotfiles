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
set shiftwidth=2
set softtabstop=2
set autoindent
set nowrap
set title
set encoding=utf-8
set lazyredraw
set showmatch
set hlsearch
set mouse=a
set incsearch
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
