vim.o.breakindent = true
vim.o.cmdheight = 1
vim.o.colorcolumn = "80"
vim.o.confirm = true
vim.o.cursorline = true
vim.opt.diffopt:append("vertical")
vim.o.ignorecase = true
vim.o.inccommand = "nosplit" -- Preview incremental substitute
vim.o.mouse = "a" -- Enable mouse mode
vim.o.number = true -- Show current line number
vim.o.pumblend = 10 -- Popup blend
vim.o.pumheight = 10 -- Max number of entries in a popup
vim.o.scrolloff = 7 -- Lines of context when moving the cursor near the screen edge
vim.o.showmatch = true
vim.o.showmode = false -- Mode is shown in the status line
vim.o.sidescrolloff = 8 -- Side scroll context lines
vim.o.signcolumn = "yes" -- Prevents text shifts when lightbulb/other signs are shown
vim.o.smartcase = true
vim.o.splitbelow = true -- Put new windows below the current one
vim.o.splitright = true -- Put new windows to the right of the current one
vim.o.timeoutlen = 300
vim.o.title = true
vim.o.undofile = true
vim.o.updatetime = 250
vim.o.virtualedit = "block" -- Move cursor anywhere in visual block mode.
vim.o.visualbell = true
vim.o.wildmenu = true
vim.o.wrap = false -- Disable line wrapping

vim.schedule(function()
    if vim.fn.executable("fish") then
        vim.o.shell = "fish"
    end

    if vim.fn.executable("rg") then
        vim.o.grepprg = "rg --vimgrep"
    end
end)

-- files, backups, undo
vim.o.backup = false
vim.o.writebackup = false
vim.o.swapfile = false

vim.diagnostic.config({
    virtual_text = false,
})

-- ufo-style folding
-- NOTE: snacks.nvim's statuscolumn plugin must be enabled for this to work.
vim.o.foldenable = true
vim.o.foldlevel = 99
vim.o.foldmethod = "expr"
vim.o.foldexpr = "v:lua.vim.treesitter.foldexpr()"
vim.o.foldtext = ""
vim.o.foldcolumn = "0"
vim.opt.fillchars:append({ fold = " " })
