local nmap = require("utils").nmap

nmap("<leader>wh", "<C-w>h", { desc = "Go to left window", remap = true })
nmap("<leader>wj", "<C-w>j", { desc = "Go to bottom window", remap = true })
nmap("<leader>wk", "<C-w>k", { desc = "Go to top window", remap = true })
nmap("<leader>wl", "<C-w>l", { desc = "Go to right window", remap = true })
nmap("<leader>w-", "<C-W>s", { desc = "Split window horizontally", remap = true })
nmap("<leader>w|", "<C-W>v", { desc = "Split window vertically", remap = true })
nmap("<leader>wd", "<C-W>c", { desc = "Delete window", remap = true })

-- See https://github.com/LazyVim/LazyVim/blob/25abbf546d564dc484cf903804661ba12de45507/lua/lazyvim/config/keymaps.lua#L7
vim.keymap.set({ "n", "x" }, "j", "v:count == 0 ? 'gj' : 'j'", { desc = "Down", expr = true, silent = true })
vim.keymap.set({ "n", "x" }, "k", "v:count == 0 ? 'gk' : 'k'", { desc = "Up", expr = true, silent = true })

-- See https://github.com/LazyVim/LazyVim/blob/25abbf546d564dc484cf903804661ba12de45507/lua/lazyvim/config/keymaps.lua#L84-L85
vim.keymap.set("v", "<", "<gv")
vim.keymap.set("v", ">", ">gv")

nmap("<Esc>", "<cmd>nohlsearch<CR>")

nmap("<leader>qq", vim.cmd.copen, { desc = "Open quickfix list" })

nmap("<leader>ca", vim.lsp.buf.code_action, { desc = "Code actions" })
nmap("<leader>cd", vim.lsp.buf.definition, { desc = "Go to definition" })
nmap("<leader>ch", vim.lsp.buf.references, { desc = "Find references & implementation" })
nmap("<leader>cr", vim.lsp.buf.rename, { desc = "Rename" })
nmap("<leader>cs", vim.lsp.buf.signature_help, { desc = "Show signature" })

nmap("<leader>dd", vim.diagnostic.open_float, { desc = "Show line diagnostics" })

nmap("gcd", "yygccp", { remap = true, desc = "Comment & duplicate line" })

vim.keymap.set("x", "/", "<Esc>/\\%V") --search within visual selection

nmap("<leader>L", "<cmd>Lazy<cr>", { desc = "Lazy" })

nmap("<leader>fy", function()
    local path = vim.api.nvim_buf_get_name(0)
    vim.fn.setreg("+", path)
    vim.notify("Yanked current file path to clipboard", vim.log.levels.INFO)
end, {
    desc = "Yank file path",
})

nmap("<leader>fY", function()
    local Path = require("plenary.path")
    local path = Path:new(vim.api.nvim_buf_get_name(0)):make_relative()
    vim.fn.setreg("+", path)
    vim.notify("Yanked current file path to clipboard", vim.log.levels.INFO)
end, {
    desc = "Yank file path (relative to project root)",
})
