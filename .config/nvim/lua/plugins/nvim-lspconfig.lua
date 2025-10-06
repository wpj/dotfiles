return {
    "neovim/nvim-lspconfig",
    config = function()
        local global_pnpm_root_directory = "~/Library/pnpm/global/5/node_modules"

        -- Use project-local typescript installation if available, fallback to global install
        -- assumes typescript installed globally w/ pnpm
        vim.lsp.config("ts_ls", {
            init_options = {
                plugins = {
                    {
                        name = "@vue/typescript-plugin",
                        location = vim.fn.expand(global_pnpm_root_directory .. "/@vue/typescript-plugin"),
                        languages = { "javascript", "typescript", "vue" },
                    },
                },
            },
            filetypes = {
                "javascript",
                "typescript",
                "vue",
            },
        })

        vim.lsp.enable({
            "gopls",
            "lua_ls",
            "ts_ls",
        })
    end,
}
