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


" =======
" Plugins
" =======
silent! if plug#begin('~/.vim/plugged')

if has('nvim')
	Plug 'Shougo/deoplete.nvim',  { 'do': ':UpdateRemotePlugins' }
end
let g:deoplete#enable_at_startup = 1

Plug 'airblade/vim-gitgutter'

Plug 'autozimu/LanguageClient-neovim',  { 'branch': 'next','do': 'bash install.sh' }
let g:LanguageClient_serverCommands = {
    \ 'rust': ['~/.cargo/bin/rustup', 'run', 'stable', 'rls'],
    \ }

Plug 'editorconfig/editorconfig-vim'
let g:EditorConfig_exclude_patterns = ['fugitive://.*', 'scp://.*']

Plug 'ervandew/supertab'
Plug 'fleischie/vim-styled-components', { 'for': ['javascript', 'javascript.jsx'] }
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

Plug 'sbdchd/neoformat'
let g:neoformat_try_formatprg = 1
nnoremap fmt :Neoformat<cr>

Plug 'sheerun/vim-polyglot'
let g:polyglot_disabled = ['javascript', 'javascript.jsx']

Plug 'Shougo/neosnippet.vim'
Plug 'Shougo/neosnippet-snippets'
Plug 'slashmili/alchemist.vim',         { 'for': 'elixir' }

Plug 'suan/vim-instant-markdown'
nnoremap mdp :InstantMarkdownPreview<cr>

Plug 'tpope/vim-commentary'
Plug 'tpope/vim-endwise'
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-repeat'
Plug 'tpope/vim-rhubarb'
Plug 'tpope/vim-surround'
Plug 'tpope/vim-unimpaired'

Plug 'vim-airline/vim-airline'
let g:airline_powerline_fonts = 1
let g:airline_theme = "luna"
let g:airline#extensions#ale#enabled = 1

Plug 'vim-airline/vim-airline-themes'

Plug 'w0rp/ale'
nmap <silent> <C-k> <Plug>(ale_previous_wrap)
nmap <silent> <C-j> <Plug>(ale_next_wrap)

call plug#end()
endif


" ========
" Mappings
" ========
let mapleader = ' '
let maplocalleader = ' '

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


" Enable omni completion.
autocmd FileType css setlocal omnifunc=csscomplete#CompleteCSS
autocmd FileType html,markdown setlocal omnifunc=htmlcomplete#CompleteTags
autocmd FileType javascript setlocal omnifunc=javascriptcomplete#CompleteJS
autocmd FileType python setlocal omnifunc=pythoncomplete#Complete
autocmd FileType xml setlocal omnifunc=xmlcomplete#CompleteTags

" Enable spellcheck
autocmd FileType markdown setlocal spell

" javascript
let g:javascript_plugin_jsdoc = 1
let g:javascript_plugin_flow = 1

" rust
let g:rustfmt_autosave = 1

" prettier
if executable("prettier")
  autocmd FileType javascript set formatprg=prettier\ --stdin
  autocmd FileType markdown set formatprg=prettier\ --parser\ markdown\ --stdin
endif

silent! colo seoul256
