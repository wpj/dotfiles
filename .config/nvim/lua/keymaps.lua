vim.keymap.set("n", "<Esc>", "<cmd>nohlsearch<CR>")

vim.keymap.set("n", "<leader>qq", vim.cmd.copen, { desc = "Open quickfix list" })

vim.keymap.set("n", "<leader>ca", vim.lsp.buf.code_action, { desc = "Code actions" })
vim.keymap.set("n", "<leader>cd", vim.lsp.buf.definition, { desc = "Go to definition" })
vim.keymap.set("n", "<leader>ch", vim.lsp.buf.references, { desc = "Find references & implementation" })
vim.keymap.set("n", "<leader>cr", vim.lsp.buf.rename, { desc = "Rename" })
vim.keymap.set("n", "<leader>cs", vim.lsp.buf.signature_help, { desc = "Show signature" })

vim.keymap.set("n", "<leader>dd", vim.diagnostic.open_float, { desc = "Show line diagnostics" })


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
