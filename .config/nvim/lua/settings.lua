local opt = vim.opt

if vim.fn.executable("fish") then
    opt.shell = "fish"
end

opt.cmdheight = 2
opt.colorcolumn = "80"
opt.completeopt:remove("longest") -- nvm-cmp
opt.cursorline = true
opt.diffopt:append("vertical")
opt.expandtab = true -- Use spaces instead of tabs
if vim.fn.executable("rg") then
    opt.grepprg = "rg --vimgrep"
end
opt.ignorecase = true
opt.inccommand = "nosplit" -- Preview incremental substitute
opt.mouse = "a" -- Enable mouse mode
opt.number = true -- Show current line number
opt.pumblend = 10 -- Popup blend
opt.pumheight = 10 -- Max number of entries in a popup
opt.relativenumber = true -- Show relative line numvers
opt.scrolloff = 7 -- Lines of context when moving the cursor near the screen edge
opt.shiftwidth = 2 -- Indent size
opt.showmatch = true
opt.showmode = false -- Mode is shown in the status line
opt.sidescrolloff = 8 -- Side scroll context lines
opt.signcolumn = "yes" -- Prevents text shifts when lightbulb/other signs are shown
opt.smartcase = true
opt.smartindent = true -- Insert indents automatically
opt.softtabstop = 2
opt.splitbelow = true -- Put new windows below the current one
opt.splitright = true -- Put new windows to the right of the current one
opt.tabstop = 2 -- Number of spaces a tab is equivalent to
opt.title = true
opt.undofile = true
opt.virtualedit = "block" -- Move cursor anywhere in visual block mode.
opt.visualbell = true
opt.wildmenu = true
opt.wrap = false -- Disable line wrapping

-- files, backups, undo
opt.backup = false
opt.writebackup = false
opt.swapfile = false

vim.cmd("colorscheme tokyonight")

-- Highlight on yank
vim.api.nvim_create_autocmd("TextYankPost", {
    group = vim.api.nvim_create_augroup("highlight_yank", { clear = true }),
    callback = function()
        vim.highlight.on_yank({ higroup = "IncSearch", timeout = 700 })
    end,
})

vim.diagnostic.config({
    virtual_text = false,
})
