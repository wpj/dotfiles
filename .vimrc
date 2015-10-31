syntax enable
set background=dark
set tabstop=2
" set ruler
set encoding=utf-8
set showmatch
set hlsearch

" set number
" set relativenumber

" START vundle
set nocompatible
filetype off
filetype plugin indent on
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()

Plugin 'VundleVim/Vundle.vim'
Plugin 'fatih/vim-go'
Plugin 'jiangmiao/auto-pairs'
Plugin 'tpope/vim-surround'
Plugin 'mattn/emmet-vim'
Plugin 'bling/vim-airline'
Plugin 'scrooloose/nerdtree'
Plugin 'scrooloose/nerdcommenter'
Plugin 'kien/ctrlp.vim'
Plugin 'airblade/vim-gitgutter'        

call vundle#end()
" END vundle


" To ignore plugin indent changes, instead use:
" filetype plugin on

" vim-go
let g:go_fmt_command = 'goimports' " format with goimports instead of gofmt
