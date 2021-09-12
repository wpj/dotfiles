local cmd = vim.cmd
local fn = vim.fn
local g = vim.g
local opt = vim.opt

if fn.executable("fish") then
  vim.opt.shell = "fish"
end

g.mapleader = ' '
g.loaded_netrwPlugin = 1 -- no netrw
g.netrw_dirhistmax = 0 -- no netrwhist

opt.number = true
opt.relativenumber = true
opt.visualbell = true
opt.cursorline = true
opt.expandtab = true
opt.shiftwidth = 2
opt.softtabstop = 2
opt.autoindent = true
opt.wrap = false
opt.title = true
opt.encoding = 'utf-8'
opt.lazyredraw = true
opt.showmatch = true
opt.hlsearch = true
opt.mouse = 'a'
opt.incsearch = true
opt.inccommand = 'nosplit'
opt.startofline = false
opt.autoread = true
opt.wildmenu = true
opt.backspace = {'indent', 'eol', 'start'}
opt.so = 7                     
opt.splitbelow = true
opt.splitright = true
opt.ignorecase = true
opt.smartcase = true
opt.hlsearch = false
opt.showmode = false
opt.cmdheight = 2             
opt.hidden = true
opt.mat = 2
opt.diffopt:append('vertical')

-- nvim-cmp
-- opt.completeopt = {'menuone', 'noselect'}
opt.completeopt:remove('longest')


if fn.exists('+termguicolors') == 1 then
  opt.termguicolors = true
end

-- filetype plugin indent on

opt.textwidth = 0

opt.colorcolumn = '80'

-- files, backups, undo
opt.backup = false
opt.writebackup = false
opt.swapfile = false

-- permanent undo
-- opt.undodir = '~/.nvimdid'
-- opt.undofile = true

-- ------------
-- color scheme
-- ------------
-- g.tokyonight_style = "night"
-- g.tokyonight_italic_functions = true
-- g.tokyonight_sidebars = { "qf", "vista_kind", "terminal", "packer" }
-- opt.background = 'dark'

cmd[[colorscheme seoul256]]
cmd('syntax enable')

g.user_emmet_leader_key = '<C-Z>'

cmd[[
augroup highlight_yank
    autocmd!
    au TextYankPost * silent! lua vim.highlight.on_yank{higroup="IncSearch", timeout=700}
augroup END
]]
