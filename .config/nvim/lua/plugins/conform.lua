return {
    "stevearc/conform.nvim",
    cmd = { "ConformInfo" },
    keys = {
        {
            "<leader>cf",
            function()
                require("conform").format({ timeout_ms = 3000 })
            end,
            desc = "Format code",
        },
    },
    opts = function()
        local js_formatter = "prettier"
        if vim.env.NVIM_USE_PRETTIER_ESLINT ~= nil then
            js_formatter = "prettiereslint"
        end

        return {
            formatters = {
                prettiereslint = function(bufnr)
                    local util = require("conform.util")
                    ---@type conform.FileFormatterConfig
                    return {
                        command = util.from_node_modules("prettier-eslint"),
                        meta = {
                            url = "https://github.com/prettier/prettier-eslint",
                            description = "Format code with prettier+eslint",
                        },
                        args = { "--stdin", "--stdin-filepath", "$FILENAME" },
                        cwd = util.root_file({
                            -- https://prettier.io/docs/en/configuration.html
                            ".prettierrc",
                            ".prettierrc.json",
                            ".prettierrc.yml",
                            ".prettierrc.yaml",
                            ".prettierrc.json5",
                            ".prettierrc.js",
                            ".prettierrc.cjs",
                            ".prettierrc.toml",
                            "prettier.config.js",
                            "prettier.config.cjs",

                            -- https://eslint.org/docs/latest/use/configure/configuration-files
                            ".eslintrc",
                            ".eslintrc.js",
                            ".eslintrc.cjs",
                            ".eslintrc.yaml",
                            ".eslintrc.yml",
                            ".eslintrc.json",

                            "package.json",
                        }),
                    }
                end,
            },
            formatters_by_ft = {
                css = { "prettier" },
                fish = { "fish_indent" },
                go = { "gofmt" },
                html = { "prettier" },
                javascript = { js_formatter },
                javascriptreact = { js_formatter },
                json = { "prettier" },
                less = { "prettier" },
                lua = { "stylua" },
                markdown = { "prettier" },
                scss = { "prettier" },
                svelte = { "prettier" },
                toml = { "taplo" },
                typescript = { js_formatter },
                typescriptreact = { js_formatter },
                vue = { js_formatter },
                yaml = { "prettier" },
            },
        }
    end,
}
