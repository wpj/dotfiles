-- See https://github.com/LazyVim/LazyVim/blob/25abbf546d564dc484cf903804661ba12de45507/lua/lazyvim/config/keymaps.lua#L7
vim.keymap.set({ "n", "x" }, "j", "v:count == 0 ? 'gj' : 'j'", { desc = "Down", expr = true, silent = true })
vim.keymap.set({ "n", "x" }, "k", "v:count == 0 ? 'gk' : 'k'", { desc = "Up", expr = true, silent = true })

-- See https://github.com/LazyVim/LazyVim/blob/25abbf546d564dc484cf903804661ba12de45507/lua/lazyvim/config/keymaps.lua#L84-L85
vim.keymap.set("v", "<", "<gv")
vim.keymap.set("v", ">", ">gv")

vim.keymap.set("n", "<Esc>", "<cmd>nohlsearch<CR>")

vim.keymap.set("n", "<leader>qq", vim.cmd.copen, { desc = "Open quickfix list" })

vim.keymap.set("n", "<leader>ca", vim.lsp.buf.code_action, { desc = "Code actions" })
vim.keymap.set("n", "<leader>cd", vim.lsp.buf.definition, { desc = "Go to definition" })
vim.keymap.set("n", "<leader>ch", vim.lsp.buf.references, { desc = "Find references & implementation" })
vim.keymap.set("n", "<leader>cr", vim.lsp.buf.rename, { desc = "Rename" })
vim.keymap.set("n", "<leader>cs", vim.lsp.buf.signature_help, { desc = "Show signature" })

vim.keymap.set("n", "<leader>dd", vim.diagnostic.open_float, { desc = "Show line diagnostics" })

vim.keymap.set("n", "gcd", "yygccp", { remap = true, desc = "Comment & duplicate line" })

vim.keymap.set("x", "/", "<Esc>/\\%V") --search within visual selection

vim.keymap.set("n", "<leader>L", "<cmd>Lazy<cr>", { desc = "Lazy" })

vim.keymap.set("n", "<leader>fy", function()
    local path = vim.api.nvim_buf_get_name(0)
    vim.fn.setreg("+", path)
    vim.notify("Yanked current file path to clipboard", vim.log.levels.INFO)
end, {
    desc = "Yank file path",
})

vim.keymap.set("n", "<leader>fY", function()
    local Path = require("plenary.path")
    local path = Path:new(vim.api.nvim_buf_get_name(0)):make_relative()
    vim.fn.setreg("+", path)
    vim.notify("Yanked current file path to clipboard", vim.log.levels.INFO)
end, {
    desc = "Yank file path (relative to project root)",
})
