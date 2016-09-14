syntax enable
set background=dark
set tabstop=2
set autoindent
set smartindent
set shiftwidth=2
set nowrap
set title
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
" set completeopt-=preview " disable scratch preview on autocompletion

" files, backups, undo
set nobackup
set nowb
set noswapfile

filetype off
" set number
" set relativenumber

" START mapping
let mapleader = ' '
let maplocalleader = ' '
inoremap jk <ESC>
" END mapping

" Plugins
silent! if plug#begin('~/.config/nvim/plugged')
Plug 'SirVer/ultisnips'
Plug 'honza/vim-snippets'
Plug 'jiangmiao/auto-pairs'
Plug 'ervandew/supertab'
Plug 'tpope/vim-surround'

Plug 'tpope/vim-fugitive'
if v:version >= 703
  Plug 'mhinz/vim-signify'
endif

Plug 'mattn/emmet-vim'
Plug 'vim-airline/vim-airline'
Plug 'tpope/vim-vinegar'
Plug 'tpope/vim-endwise'
Plug 'scrooloose/nerdcommenter'
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
Plug 'junegunn/fzf.vim'
Plug 'junegunn/rainbow_parentheses.vim'
Plug 'junegunn/goyo.vim'
Plug 'junegunn/limelight.vim'
Plug 'junegunn/seoul256.vim'
Plug 'airblade/vim-gitgutter'
Plug 'majutsushi/tagbar'
Plug 'easymotion/vim-easymotion'
Plug 'osyo-manga/vim-over'
Plug 'scrooloose/syntastic'

" language extensions
Plug 'elixir-lang/vim-elixir'
Plug 'slashmili/alchemist.vim'
Plug 'pangloss/vim-javascript'
Plug 'mxw/vim-jsx'
Plug 'fatih/vim-go'
Plug 'elixir-lang/vim-elixir'
Plug 'honza/dockerfile.vim'
call plug#end()
endif

" ===========
" color theme
" ===========
let g:seoul256_background = 235
colo seoul256

" =============
" plugin config
" =============

" vim-go
" ======
"let g:go_fmt_command = 'goimports' " format with goimports instead of gofmt
let g:go_highlight_functions = 1
let g:go_highlight_methods = 1
let g:go_highlight_structs = 1
let g:go_highlight_operators = 1
let g:go_highlight_build_constraints = 1

" YCM
" ===
let g:ycm_key_list_select_completion = ['<C-n>', '<Down>']
let g:ycm_key_list_previous_completion = ['<C-p>', '<Up>']
let g:SuperTabDefaultCompletionType = '<C-n>'

" ultisnips
" ========
let g:UltiSnipsExpandTrigger='<tab>'
let g:UltiSnipsJumpForwardTrigger='<tab>'
let g:UltiSnipsJumpBackwardTrigger='<s-tab>'

" tagbar
" ======
map <Leader>tt <esc>:TagbarToggle<cr>

" Enable omni completion.
autocmd FileType css setlocal omnifunc=csscomplete#CompleteCSS
autocmd FileType html,markdown setlocal omnifunc=htmlcomplete#CompleteTags
autocmd FileType javascript setlocal omnifunc=javascriptcomplete#CompleteJS
autocmd FileType python setlocal omnifunc=pythoncomplete#Complete
autocmd FileType xml setlocal omnifunc=xmlcomplete#CompleteTags

" vim-jsx
let g:jsx_ext_required = 0

" nerdcommenter
" =============
let NERDSpaceDelims=1

" fzf
" ===
map <C-p> :FZF<CR>

" airline
let g:airline_powerline_fonts = 1
