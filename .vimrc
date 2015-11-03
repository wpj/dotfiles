syntax enable
set background=dark
set tabstop=2
" set ruler
set encoding=utf-8
set showmatch
set hlsearch

" set number
" set relativenumber

" START mapping
let mapleader = ','
" END mapping

" START vundle
set nocompatible
filetype off
filetype plugin indent on
filetype plugin on

set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()

Plugin 'VundleVim/Vundle.vim'
Plugin 'fatih/vim-go'
Plugin 'jiangmiao/auto-pairs'
Plugin 'tpope/vim-surround'
Plugin 'tpope/vim-fugitive'
Plugin 'mattn/emmet-vim'
Plugin 'bling/vim-airline'
Plugin 'scrooloose/nerdtree'
Plugin 'scrooloose/nerdcommenter'
Plugin 'kien/ctrlp.vim'
Plugin 'airblade/vim-gitgutter'        
Plugin 'Valloric/YouCompleteMe'

call vundle#end()
" END vundle

" START plugin config

" vim-go
let g:go_fmt_command = 'goimports' " format with goimports instead of gofmt

" END plugin config

" START plugin mapping
map <C-n> :NERDTreeToggle<CR>
" END plugin  mapping
