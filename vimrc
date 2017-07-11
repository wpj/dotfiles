" ==============
" Basic settings
" ==============
syntax enable
set nu
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


" =======
" Plugins
" =======
silent! if plug#begin('~/.vim/plugged')

if has('nvim')
	Plug 'Shougo/deoplete.nvim',  { 'do': ':UpdateRemotePlugins' }
end
Plug 'honza/vim-snippets'
Plug 'jiangmiao/auto-pairs'
Plug 'ervandew/supertab'
Plug 'tpope/vim-surround'
Plug 'tpope/vim-repeat'
Plug 'tpope/vim-fugitive'
Plug 'editorconfig/editorconfig-vim'
if v:version >= 703
	Plug 'SirVer/ultisnips'
	Plug 'mhinz/vim-signify'
endif

Plug 'mattn/emmet-vim'
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'tpope/vim-vinegar'
Plug 'tpope/vim-endwise'
Plug 'scrooloose/nerdcommenter'
Plug 'junegunn/fzf',            { 'dir': '~/.fzf', 'do': './install --all' }
Plug 'junegunn/fzf.vim'
Plug 'junegunn/rainbow_parentheses.vim'
Plug 'junegunn/vim-easy-align', { 'on': ['<Plug>(EasyAlign)', 'EasyAlign'] }
Plug 'junegunn/goyo.vim'
Plug 'junegunn/limelight.vim'
Plug 'junegunn/seoul256.vim'
Plug 'airblade/vim-gitgutter'
Plug 'majutsushi/tagbar'
Plug 'easymotion/vim-easymotion'
Plug 'osyo-manga/vim-over'
Plug 'suan/vim-instant-markdown'
Plug 'sbdchd/neoformat'

" Linting
Plug 'scrooloose/syntastic'
Plug 'mtscout6/syntastic-local-eslint.vim'
Plug 'sindresorhus/vim-xo'

" language extensions
Plug 'sheerun/vim-polyglot'
Plug 'plasticboy/vim-markdown', { 'for': 'markdown' }
Plug 'racer-rust/vim-racer', { 'for': 'rust' }
Plug 'slashmili/alchemist.vim', { 'for': 'elixir' }

call plug#end()
endif


" ========
" Mappings
" ========
let mapleader = ' '
let maplocalleader = ' '
inoremap jk <ESC>
nnoremap fmt :Neoformat<cr>

" buffers
nnoremap ]b :bnext<cr>
nnoremap [b :bprev<cr>

" tabs
nnoremap ]t :tabn<cr>
nnoremap [t :tabp<cr>

" circular window navigation
nnoremap <tab>   <c-w>w
nnoremap <S-tab> <c-w>W

" <tab> / <s-tab> / <c-v><tab> | super-duper-tab
function! s:can_complete(func, prefix)
	if empty(a:func) || call(a:func, [1, '']) < 0
		return 0
	endif
	let result = call(a:func, [0, matchstr(a:prefix, '\k\+$')])
	return !empty(type(result) == type([]) ? result : result.words)
endfunction

function! s:super_duper_tab(k, o)
	if pumvisible()
		return a:k
	endif

	let line = getline('.')
	let col = col('.') - 2
	if line[col] !~ '\k\|[/~.]'
		return a:o
	endif

	let prefix = expand(matchstr(line[0:col], '\S*$'))
	if prefix =~ '^[~/.]'
		return "\<c-x>\<c-f>"
	endif
	if s:can_complete(&omnifunc, prefix)
		return "\<c-x>\<c-o>"
	endif
	if s:can_complete(&completefunc, prefix)
		return "\<c-x>\<c-u>"
	endif
	return a:k
endfunction

" ===========
" Color theme
" ===========
let g:seoul256_background = 235
silent! colo seoul256


" =============
" Plugin config
" =============

" deoplete
let g:deoplete#enable_at_startup = 1

inoremap <silent> <CR> <C-r>=<SID>select_completion()<CR>
function! s:select_completion() abort
  return pumvisible() ? deoplete#close_popup() : "\<CR>"
endfunction

" vim-go
let g:go_highlight_functions = 1
let g:go_highlight_methods = 1
let g:go_highlight_structs = 1
let g:go_highlight_operators = 1
let g:go_highlight_build_constraints = 1

" ultisnips
if has_key(g:plugs, 'ultisnips')
	" UltiSnips will be loaded only when tab is first pressed in insert mode
	if !exists(':UltiSnipsEdit')
		inoremap <silent> <Plug>(tab) <c-r>=plug#load('ultisnips')?UltiSnips#ExpandSnippet():''<cr>
		imap <tab> <Plug>(tab)
	endif

  let g:SuperTabDefaultCompletionType = "<c-n>"

	function! SuperTab(m)
		return s:super_duper_tab(a:m == 'n' ? "\<c-n>" : "\<c-p>",
						\ a:m == 'n' ? "\<tab>" : "\<s-tab>")
	endfunction
else
	inoremap <expr> <tab>   <SID>super_duper_tab("\<c-n>", "\<tab>")
	inoremap <expr> <s-tab> <SID>super_duper_tab("\<c-p>", "\<s-tab>")
endif

" tagbar
map <Leader>tt <esc>:TagbarToggle<cr>

" editorconfig
let g:EditorConfig_exclude_patterns = ['fugitive://.*', 'scp://.*']

" Enable omni completion.
autocmd FileType css setlocal omnifunc=csscomplete#CompleteCSS
autocmd FileType html,markdown setlocal omnifunc=htmlcomplete#CompleteTags
autocmd FileType javascript setlocal omnifunc=javascriptcomplete#CompleteJS
autocmd FileType python setlocal omnifunc=pythoncomplete#Complete
autocmd FileType xml setlocal omnifunc=xmlcomplete#CompleteTags

" Enable spellcheck
autocmd FileType markdown setlocal spell

" vim-jsx
let g:jsx_ext_required = 0

" nerdcommenter
let NERDSpaceDelims=1
let g:NERDDefaultAlign = 'left'

" fzf
map <C-p> :FZF<CR>

" airline
let g:airline_powerline_fonts = 1
let g:airline_theme = "luna"

" easy-align
xmap ga <Plug>(EasyAlign)
nmap ga <Plug>(EasyAlign)

" syntastic
let g:syntastic_javascript_checkers = ['eslint', 'xo']

" markdown
let g:vim_markdown_folding_disabled = 1
let g:vim_markdown_new_list_item_indent = 0 " disable auto-indent in lists
let g:instant_markdown_autostart = 0

" javascript
let g:javascript_plugin_jsdoc = 1

" rust
let g:rustfmt_autosave = 1

" prettier
if executable("prettier")
  autocmd FileType javascript set formatprg=prettier\ --stdin\ --single-quote
endif

" neoformat
let g:neoformat_try_formatprg = 1
