local map = require("util").map

vim.keymap.set('n', '<Esc>', '<cmd>nohlsearch<CR>')

map("<leader>qq", vim.cmd.copen, { desc = "Open quickfix list" })

map("<leader>ca", vim.lsp.buf.code_action, { desc = "Code actions" })
map("<leader>cd", vim.lsp.buf.definition, { desc = "Go to definition" })
map("<leader>ch", vim.lsp.buf.references, { desc = "Find references & implementation" })
map("<leader>cr", vim.lsp.buf.rename, { desc = "Rename" })
map("<leader>cs", vim.lsp.buf.signature_help, { desc = "Show signature" })

map("<leader>dd", vim.diagnostic.open_float, { desc = "Show line diagnostics" })

map("<leader>fy", function()
    local path = vim.api.nvim_buf_get_name(0)
    vim.fn.setreg("+", path)
    vim.notify("Yanked current file path to clipboard", vim.log.levels.INFO)
end, {
    desc = "Yank file path",
})

map("<leader>fY", function()
    local Path = require("plenary.path")
    local path = Path:new(vim.api.nvim_buf_get_name(0)):make_relative()
    vim.fn.setreg("+", path)
    vim.notify("Yanked current file path to clipboard", vim.log.levels.INFO)
end, {
    desc = "Yank file path (relative to project root)",
})
