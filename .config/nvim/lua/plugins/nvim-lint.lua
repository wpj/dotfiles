return {
    "mfussenegger/nvim-lint",
    event = { "BufReadPre", "BufNewFile" },
    keys = {
        {
            "<leader>cl",
            function()
                require("lint").try_lint()
            end,
            desc = "Lint file",
        },
    },
    opts = {
        events = { "BufEnter", "BufWritePost", "InsertLeave" },
        linters_by_ft = {
            javascript = { "eslint" },
            javascriptreact = { "eslint" },
            svelte = { "eslint" },
            typescript = { "eslint" },
            typescriptreact = { "eslint" },
            vue = { "eslint" },
        },
    },
    config = function(_, opts)
        local lint = require("lint")

        lint.linters_by_ft = opts.linters_by_ft

        vim.api.nvim_create_autocmd(opts.events, {
            group = vim.api.nvim_create_augroup("nvim-lint", { clear = true }),
            callback = function()
                -- Only run the linter in buffers that you can modify in order to
                -- avoid superfluous noise, notably within the handy LSP pop-ups that
                -- describe the hovered symbol using Markdown.
                if vim.bo.modifiable then
                    lint.try_lint()
                end
            end,
        })
    end,
}
