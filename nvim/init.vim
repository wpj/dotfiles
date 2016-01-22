syntax enable
set background=dark
set tabstop=2
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
set completeopt-=preview " disable scratch preview on autocompletion

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

call plug#begin('~/.config/nvim/plugged')
Plug 'SirVer/ultisnips'
Plug 'honza/vim-snippets'
Plug 'jiangmiao/auto-pairs'
Plug 'tpope/vim-surround'
Plug 'tpope/vim-fugitive'
Plug 'mattn/emmet-vim'
Plug 'itchyny/lightline.vim'
Plug 'tpope/vim-vinegar'
Plug 'scrooloose/nerdcommenter'
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
Plug 'junegunn/fzf.vim'
Plug 'junegunn/rainbow_parentheses.vim'
Plug 'junegunn/goyo.vim'
Plug 'junegunn/limelight.vim'
Plug 'junegunn/seoul256.vim'
Plug 'airblade/vim-gitgutter'
Plug 'fatih/vim-go'
Plug 'Shougo/deoplete.nvim'
Plug 'majutsushi/tagbar'
Plug 'pangloss/vim-javascript'
Plug 'mxw/vim-jsx'
call plug#end()

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
"let g:ycm_key_list_select_completion = ['<C-n>', '<Down>']
"let g:ycm_key_list_previous_completion = ['<C-p>', '<Up>']
"let g:SuperTabDefaultCompletionType = '<C-n>'

" ultisnips
" ========
"let g:UltiSnipsExpandTrigger='<tab>'
"let g:UltiSnipsJumpForwardTrigger='<tab>'
"let g:UltiSnipsJumpBackwardTrigger='<s-tab>'

" tagbar
" ======
map <Leader>tt <esc>:TagbarToggle<cr>

" neocomplete
" ===========

" Disable AutoComplPop.
let g:acp_enableAtStartup = 0
let g:neocomplete#enable_at_startup = 1
let g:neocomplete#enable_smart_case = 1
let g:neocomplete#sources#syntax#min_keyword_length = 3
let g:neocomplete#lock_buffer_name_pattern = '\*ku\*'

" Define dictionary.
let g:neocomplete#sources#dictionary#dictionaries = {
    \ 'default' : '',
    \ 'vimshell' : $HOME.'/.vimshell_hist',
    \ 'scheme' : $HOME.'/.gosh_completions'
    \ }

" Define keyword.
if !exists('g:neocomplete#keyword_patterns')
    let g:neocomplete#keyword_patterns = {}
endif
let g:neocomplete#keyword_patterns['default'] = '\h\w*'

" Plugin key-mappings.
inoremap <expr><C-g>     neocomplete#undo_completion()
inoremap <expr><C-l>     neocomplete#complete_common_string()

" Recommended key-mappings.
" <CR>: close popup and save indent.
inoremap <silent> <CR> <C-r>=<SID>my_cr_function()<CR>
function! s:my_cr_function()
  "return (pumvisible() ? "\<C-y>" : "" ) . "\<CR>"
  " For no inserting <CR> key.
	return pumvisible() ? "\<C-y>" : "\<CR>"
endfunction
" <TAB>: completion.
inoremap <expr><TAB>  pumvisible() ? "\<C-n>" : "\<TAB>"
" <C-h>, <BS>: close popup and delete backword char.
inoremap <expr><C-h> neocomplete#smart_close_popup()."\<C-h>"
inoremap <expr><BS> neocomplete#smart_close_popup()."\<C-h>"
" Close popup by <Space>.
"inoremap <expr><Space> pumvisible() ? "\<C-y>" : "\<Space>"

" AutoComplPop like behavior.
"let g:neocomplete#enable_auto_select = 1

" Enable omni completion.
autocmd FileType css setlocal omnifunc=csscomplete#CompleteCSS
autocmd FileType html,markdown setlocal omnifunc=htmlcomplete#CompleteTags
autocmd FileType javascript setlocal omnifunc=javascriptcomplete#CompleteJS
autocmd FileType python setlocal omnifunc=pythoncomplete#Complete
autocmd FileType xml setlocal omnifunc=xmlcomplete#CompleteTags

" Enable heavy omni completion.
if !exists('g:neocomplete#sources#omni#input_patterns')
  let g:neocomplete#sources#omni#input_patterns = {}
endif
"let g:neocomplete#sources#omni#input_patterns.php = '[^. \t]->\h\w*\|\h\w*::'
"let g:neocomplete#sources#omni#input_patterns.c = '[^.[:digit:] *\t]\%(\.\|->\)'
"let g:neocomplete#sources#omni#input_patterns.cpp = '[^.[:digit:] *\t]\%(\.\|->\)\|\h\w*::'

" vim-indent-guides
let g:indent_guides_enable_on_vim_startup = 0

" vim-jsx
let g:jsx_ext_required = 0

" nerdcommenter
" =============
let NERDSpaceDelims=1

" fzf
" ===
map <C-p> :FZF<CR>
