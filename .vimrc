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
filetype off
filetype plugin on
filetype plugin indent on
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

call vundle#end()
" END vundle

" START plugin config

" vim-go
let g:go_fmt_command = 'goimports' " format with goimports instead of gofmt
let g:go_highlight_functions = 1
let g:go_highlight_methods = 1
let g:go_highlight_structs = 1
let g:go_highlight_operators = 1
let g:go_highlight_build_constraints = 1

" ultisnips
"let g:UltiSnipsExpandTrigger='<Tab>'
"let g:UltiSnipsJumpForwardTrigger='<c-b>'
"let g:UltiSnipsJumpBackwardTrigger='<c-z>'

" END plugin config

" START plugin mapping
map <C-n> :NERDTreeToggle<CR>
" END plugin  mapping
