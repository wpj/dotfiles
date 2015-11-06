syntax enable
set background=dark
set tabstop=2
set smartindent
set shiftwidth=2
" set ruler
set encoding=utf-8
set showmatch
set hlsearch
set nocompatible
set autoread " read changes to file made externally
set wildmenu
set backspace=indent,eol,start " make backspace function as it should
set so=7 " set 7 lines to the cursor when moving vertically
set cmdheight=2 " height of command bar
set hidden " hides buffers when they're abandoned
set mat=2 " blink matching brackets for 2/10 second
set clipboard=unnamed " enable copying to OSX clipboard

" files, backups, undo
set nobackup
set nowb
set noswapfile

filetype off
" set number
" set relativenumber

" START mapping
let mapleader = ','
inoremap jk <ESC>
" END mapping

" START vundle
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()

Plugin 'VundleVim/Vundle.vim'
Plugin 'SirVer/ultisnips'
Plugin 'honza/vim-snippets'
Plugin 'jiangmiao/auto-pairs'
Plugin 'tpope/vim-surround'
Plugin 'tpope/vim-fugitive'
Plugin 'mattn/emmet-vim'
Plugin 'bling/vim-airline'
Plugin 'scrooloose/nerdtree'
Plugin 'scrooloose/nerdcommenter'
Plugin 'kien/ctrlp.vim'
Plugin 'airblade/vim-gitgutter'        
Plugin 'fatih/vim-go'
Plugin 'ervandew/supertab'
"Plugin 'Valloric/YouCompleteMe'
Plugin 'Shougo/neocomplete.vim'

call vundle#end()
filetype plugin on
filetype plugin indent on
" END vundle

" START plugin config

" NERDTree
let NERDTreeShowHidden=1

" vim-go
let g:go_fmt_command = 'goimports' " format with goimports instead of gofmt
let g:go_highlight_functions = 1
let g:go_highlight_methods = 1
let g:go_highlight_structs = 1
let g:go_highlight_operators = 1
let g:go_highlight_build_constraints = 1

" YCM
"let g:ycm_key_list_select_completion = ['<C-n>', '<Down>']
"let g:ycm_key_list_previous_completion = ['<C-p>', '<Up>']
"let g:SuperTabDefaultCompletionType = '<C-n>'

" neocomplete
let g:neocomplete#enable_at_startup = 1

" ultisnips
let g:UltiSnipsExpandTrigger='<tab>'
let g:UltiSnipsJumpForwardTrigger='<tab>'
let g:UltiSnipsJumpBackwardTrigger='<s-tab>'

" END plugin config

" START plugin mapping
map <C-n> :NERDTreeToggle<CR>
" END plugin  mapping
