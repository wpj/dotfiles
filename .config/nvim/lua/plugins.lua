return {
    "andymass/vim-matchup",
    "browserslist/vim-browserslist",
    {
        "echasnovski/mini.comment",
        event = "VeryLazy",
        opts = {
            options = {
                custom_commentstring = function()
                    return require("ts_context_commentstring").calculate_commentstring() or vim.bo.commentstring
                end,
            },
        },
    },
    "echasnovski/mini.diff",
    {
        "echasnovski/mini.extra",
        opts = {},
    },
    {
        "echasnovski/mini.files",
        opts = {},
    },
    "echasnovski/mini-git",
    { "echasnovski/mini.icons", version = false, config = true },
    {
        "echasnovski/mini.indentscope",
        event = "VeryLazy",
        opts = function()
            return {
                symbol = "│",
                draw = {
                    animation = require("mini.indentscope").gen_animation.cubic({ duration = 10 }),
                },
            }
        end,
    },
    {
        "echasnovski/mini.pick",
        opts = function()
            return {
                mappings = {
                    send_all_to_quickfix = {
                        char = "<C-q>",
                        -- Send all items to the quickfix list (see
                        -- https://github.com/echasnovski/mini.nvim/discussions/1028).
                        func = function()
                            local mappings = require("mini.pick").get_picker_opts().mappings
                            vim.api.nvim_input(mappings.mark_all .. mappings.choose_marked)
                        end,
                    },
                },
            }
        end,
    },
    {
        "echasnovski/mini.pairs",
        event = "VeryLazy",
        opts = {},
    },
    {
        "echasnovski/mini.statusline",
        opts = {},
    },
    {
        "folke/flash.nvim",
        event = "VeryLazy",
        ---@type Flash.Config
        opts = {},
        -- stylua: ignore
        keys = {
            { "<s-cr>", mode = { "n", "x", "o" }, function() require("flash").jump() end, desc = "Flash" },
            { "<c-s>", mode = { "c" }, function() require("flash").toggle() end, desc = "Toggle Flash search" },
            { "<leader>nf", mode = { "n", "x", "o" }, function() require("flash").jump() end, desc = "Flash" },
            { "<leader>nF", mode = { "n", "x", "o" }, function() require("flash").treesitter() end, desc = "Flash treesitter" },
            { "<leader>nr", mode = "o", function() require("flash").remote() end, desc = "Remote Flash" },
            { "<leader>nR", mode = { "o", "x" }, function() require("flash").treesitter_search() end, desc = "Treesitter search" },
        },
    },
    {
        "folke/noice.nvim",
        event = "VeryLazy",
        opts = {
            cmdline = {
                view = "cmdline", -- Position cmdline at bottom
            },
            lsp = {
                override = {
                    ["vim.lsp.util.convert_input_to_markdown_lines"] = true,
                    ["vim.lsp.util.stylize_markdown"] = true,
                },
            },
            presets = {
                bottom_search = true, -- Position search cmdline at the bottom
            },
        },
        dependencies = {
            "MunifTanjim/nui.nvim",
            "rcarriga/nvim-notify",
        },
    },
    {
        "folke/snacks.nvim",
        priority = 1000,
        lazy = false,
        opts = {
            gitbrowse = {
                what = "permalink",
            },
        },
    },
    {
        "folke/trouble.nvim",
        opts = {},
        cmd = "Trouble",
    },
    {

        "folke/tokyonight.nvim",
        lazy = false,
        priority = 1000,
    },
    {
        "folke/which-key.nvim",
        event = "VeryLazy",
        init = function()
            vim.o.timeout = true
            vim.o.timeoutlen = 300
        end,
        opts = {
            preset = "helix",
            spec = {
                {
                    "<leader>c",
                    group = "code",
                    { "<leader>cd", "<cmd>lua vim.lsp.buf.definition()<cr>", desc = "Go to definition" },
                    { "<leader>ca", "<cmd> Lspsaga code_action<cr>", desc = "Code actions" }, -- nvimdev/lspsaga.nvim
                    { "<leader>cD", "<cmd> Lspsaga peek_definition<cr>", desc = "Preview definition" }, -- nvimdev/lspsaga.nvim
                    { "<leader>ce", "<cmd> Lspsaga show_line_diagnostics<cr>", desc = "Show line diagnostics" }, -- nvimdev/lspsaga.nvim
                    {
                        "<leader>ch",
                        function()
                            vim.lsp.buf.references()
                        end,
                        desc = "Find references & implementation",
                    },
                    { "<leader>cr", "<cmd> Lspsaga rename<cr>", desc = "Rename" },
                    { "<leader>cs", "<cmd> Lspsaga signature_help<cr>", desc = "Show signature" },
                    {
                        "<leader>cf",
                        function()
                            require("conform").format({ timeout_ms = 3000 })
                        end,
                        desc = "Format code",
                    },
                },

                {
                    "<leader>f",
                    group = "file",
                    {
                        "<leader>ff",
                        function()
                            require("mini.files").close()
                            require("mini.pick").builtin.files()
                        end,
                        desc = "Find file in project",
                    },
                    {
                        "<leader>fr",
                        function()
                            require("mini.files").close()
                            require("mini.extra").pickers.oldfiles()
                        end,
                        desc = "Search recent files",
                    },
                    {
                        "<leader>fy",
                        function()
                            local path = vim.api.nvim_buf_get_name(0)
                            vim.fn.setreg("+", path)
                            vim.notify("Yanked current file path to clipboard", vim.log.levels.INFO)
                        end,
                        desc = "Yank file path",
                    },
                    {
                        "<leader>fY",
                        function()
                            local Path = require("plenary.path")
                            local path = Path:new(vim.api.nvim_buf_get_name(0)):make_relative()
                            vim.fn.setreg("+", path)
                            vim.notify("Yanked current file path to clipboard", vim.log.levels.INFO)
                        end,
                        desc = "Yank file path (relative to project root)",
                    },
                },

                {
                    "<leader>g",
                    group = "git",
                    { "<leader>gg", "<cmd> Git<cr>", desc = "Git" }, -- tpope/vim-fugitive
                    {
                        "<leader>go",
                        function()
                            require("snacks").gitbrowse()
                        end,
                        mode = { "n", "v" },
                        desc = "Open git remote url",
                    },
                    {
                        "<leader>gy",
                        function()
                            require("snacks").gitbrowse({
                                open = function(url)
                                    vim.fn.setreg("+", url)
                                    vim.notify("Yanked " .. url .. " to system clipboard")
                                end,
                                notify = false,
                            })
                        end,
                        mode = { "n", "v" },
                        desc = "Yank git remote url",
                    },
                },

                {
                    "<leader>n",
                    group = "navigate",
                },

                {
                    "<leader>q",
                    group = "quickfix",
                    { "<leader>qq", vim.cmd.copen, desc = "Open quickfix list" },
                },

                {
                    "<leader>/",
                    function()
                        require("mini.files").close()
                        require("mini.pick").builtin.grep_live()
                    end,
                    desc = "Search project files",
                },
                {
                    "<leader><leader>",
                    function()
                        require("mini.files").close()
                        require("mini.pick").builtin.files()
                    end,
                    desc = "Find file in project",
                },
                {
                    "<leader>?",
                    function()
                        require("which-key").show()
                    end,
                    desc = "Show key bindings",
                },

                { "[d", "<cmd> Lspsaga diagnostic_jump_prev<cr>", desc = "Previous diagnostic" },
                { "]d", "<cmd> Lspsaga diagnostic_jump_next<cr>", desc = "Next diagnostic" },
                { "[q", vim.cmd.cprevious, desc = "Previous quickfix" },
                { "]q", vim.cmd.cnext, desc = "Next quickfix" },
                {
                    "-",
                    function()
                        require("mini.files").open(vim.api.nvim_buf_get_name(0), true)
                    end,
                    desc = "Open file browser",
                },
            },
        },
    },
    {
        "kevinhwang91/nvim-bqf",
        opts = {},
        ft = "qf",
    },
    {
        "JoosepAlviste/nvim-ts-context-commentstring",
        lazy = true,
        init = function()
            -- See https://github.com/JoosepAlviste/nvim-ts-context-commentstring/tree/b8ff464f2afc2000f6c72fa331a8fc090cb46b39
            vim.g.skip_ts_context_commentstring_module = true
        end,
        opts = {
            -- https://github.com/JoosepAlviste/nvim-ts-context-commentstring/wiki/Integrations#minicomment
            enable_autocmd = false,
        },
    },
    {
        "junegunn/rainbow_parentheses.vim",
        cmd = "RainbowParentheses",
    },
    {
        "junegunn/seoul256.vim",
        lazy = true,
    },
    {
        "lewis6991/gitsigns.nvim",
        event = "VeryLazy",
        dependencies = { "nvim-lua/plenary.nvim" },
        opts = {},
    },
    {
        "mattn/emmet-vim",
        ft = {
            "css",
            "html",
            "javascript",
            "javascriptreact",
            "jsx",
            "svelte",
            "tsx",
            "typescript",
            "typescriptreact",
            "vue",
        },
        init = function()
            vim.g.user_emmet_leader_key = "<C-Z>"
        end,
    },
    {
        "mfussenegger/nvim-lint",
        event = { "BufReadPre" },
        opts = {
            events = { "BufWritePost", "BufReadPost", "InsertLeave" },
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
                    lint.try_lint()
                end,
            })
        end,
    },
    {
        "neovim/nvim-lspconfig",
        dependencies = {
            -- neodev must be set up before lua_ls (https://github.com/folke/neodev.nvim/tree/80487e4f7bfa11c2ef2a1b461963db019aad6a73#-setup).
            "folke/neodev.nvim",
            "nvim-treesitter/nvim-treesitter",
        },
        config = function()
            vim.lsp.config("lua_ls", {
                settings = {
                    Lua = {
                        runtime = {
                            -- Tell the language server which version of Lua you're using
                            -- (most likely LuaJIT in the case of Neovim)
                            version = "LuaJIT",
                        },
                        workspace = {
                            -- Make lua_ls recognize vim config files.
                            library = vim.api.nvim_get_runtime_file("", true),
                            checkThirdParty = false,
                        },
                    },
                },
            })

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

            vim.lsp.config("volar", {
                on_new_config = function(new_config, new_root_dir)
                    local lib_path =
                        vim.fs.find("node_modules/typescript/lib", { path = new_root_dir, upward = true })[1]
                    if lib_path then
                        new_config.init_options.typescript.tsdk = lib_path
                    end
                end,
            })

            vim.lsp.enable({
                "gopls",
                "lua_ls",
                "ts_ls",
                "volar",
            })
        end,
    },
    {
        "nvimdev/lspsaga.nvim",
        event = "LspAttach",
        dependencies = {
            "nvim-treesitter/nvim-treesitter",
        },
        opts = {},
    },
    {
        "nvim-pack/nvim-spectre",
        dependencies = { "nvim-lua/plenary.nvim" },
    },
    {
        "nvim-treesitter/nvim-treesitter",
        build = ":TSUpdate",
        config = function()
            ---@diagnostic disable: missing-fields
            require("nvim-treesitter.configs").setup({
                ensure_installed = {
                    "bash",
                    "css",
                    "fish",
                    "go",
                    "graphql",
                    "html",
                    "javascript",
                    "json",
                    "lua",
                    "markdown",
                    "python",
                    "regex",
                    "rust",
                    "scss",
                    "svelte",
                    "toml",
                    "tsx",
                    "typescript",
                    "vue",
                    "yaml",
                },
                highlight = {
                    enable = true,
                },
            })
        end,
    },
    {
        "rcarriga/nvim-notify",
        lazy = true,
        opts = {
            stages = "static", -- Do not animate notifications.
            render = "minimal",
        },
    },
    {
        "saghen/blink.cmp",
        dependencies = { "rafamadriz/friendly-snippets" },
        version = "1.*",
        ---@module 'blink.cmp'
        ---@type blink.cmp.Config
        opts = {},
    },
    {
        "stevearc/conform.nvim",
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
                    typescript = { js_formatter },
                    typescriptreact = { js_formatter },
                    vue = { js_formatter },
                    yaml = { "prettier" },
                },
            }
        end,
    },
    {
        "tpope/vim-fugitive",
        cmd = { "Git" },
        dependencies = {
            "tpope/vim-rhubarb",
        },
    },
}
