vim.api.nvim_create_autocmd("TextYankPost", {
    desc = "Highlight text on yank",
    group = vim.api.nvim_create_augroup("highlight_yank", { clear = true }),
    callback = function()
        vim.hl.on_yank({ higroup = "IncSearch", timeout = 700 })
    end,
})
