---@type LazyConfig
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
    {
        "echasnovski/mini.files",
        opts = {},
    },
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
        "echasnovski/mini.pairs",
        event = "VeryLazy",
        opts = {},
    },
    "editorconfig/editorconfig-vim",
    {
        "folke/trouble.nvim",
        cmd = { "Trouble", "TroubleToggle" },
        dependencies = { "nvim-tree/nvim-web-devicons" },
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
                            require("telescope.builtin").find_files()
                        end,
                        desc = "Find file in project",
                    }, -- nvim-telescope/telescope.nvim
                    {
                        "<leader>fr",
                        function()
                            require("mini.files").close()
                            require("telescope.builtin").oldfiles()
                        end,
                        desc = "Search recent files",
                    }, -- nvim-telescope/telescope.nvim
                    {
                        "<leader>fy",
                        function()
                            local path = vim.api.nvim_buf_get_name(0)
                            vim.fn.setreg("+", path)
                        end,
                        desc = "Yank the path of the current file",
                    },
                },

                {
                    "<leader>g",
                    group = "git",
                    { "<leader>gg", "<cmd> Git<cr>", desc = "Git" }, -- tpope/vim-fugitive
                },

                {
                    "<leader>/",
                    function()
                        require("mini.files").close()
                        require("telescope").extensions.live_grep_args.live_grep_args()
                    end,
                    desc = "Search project files",
                },
                {
                    "<leader><leader>",
                    function()
                        require("mini.files").close()
                        require("telescope.builtin").find_files()
                    end,
                    desc = "Find file in project",
                }, -- nvim-telescope/telescope.nvim
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
        "hrsh7th/nvim-cmp",
        event = "InsertEnter",
        dependencies = {
            "neovim/nvim-lspconfig",
            "hrsh7th/cmp-nvim-lsp",
            "hrsh7th/cmp-buffer",
            "hrsh7th/cmp-path",
            "hrsh7th/cmp-cmdline",
            "hrsh7th/cmp-nvim-lua",
            {
                "dcampos/nvim-snippy",
                dependencies = {
                    "honza/vim-snippets",
                },
            },
            "dcampos/cmp-snippy",
        },
        config = function()
            local cmp = require("cmp")
            cmp.setup({
                -- auto-select the first completion
                completion = {
                    completeopt = "menu,menuone,noinsert",
                },
                mapping = cmp.mapping.preset.insert({
                    ["<C-b>"] = cmp.mapping.scroll_docs(-4),
                    ["<C-f>"] = cmp.mapping.scroll_docs(4),
                    ["<C-Space>"] = cmp.mapping.complete(),
                    ["<C-e>"] = cmp.mapping.abort(),
                    ["<C-y>"] = cmp.mapping.confirm({ select = true }),
                }),
                snippet = {
                    expand = function(args)
                        require("snippy").expand_snippet(args.body) -- For `snippy` users.
                    end,
                },
                sources = cmp.config.sources({
                    { name = "nvim_lsp" },
                    { name = "snippy" },
                }, {
                    { name = "buffer" },
                }),
            })

            cmp.setup.cmdline({ "/", "?" }, {
                mapping = cmp.mapping.preset.cmdline(),
                sources = {
                    { name = "buffer" },
                },
            })
        end,
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
        "williamboman/mason.nvim",
        config = true,
    },
    {

        "williamboman/mason-lspconfig.nvim",
        opts = {
            ensure_installed = {
                "gopls",
                "lua_ls",
                "stylelint_lsp",
                "tsserver",
                "volar",
            },
        },
    },
    {
        "neovim/nvim-lspconfig",
        dependencies = {
            {
                "hrsh7th/cmp-nvim-lsp",
                -- neodev must be set up before lua_ls (https://github.com/folke/neodev.nvim/tree/80487e4f7bfa11c2ef2a1b461963db019aad6a73#-setup).
                "folke/neodev.nvim",
                opts = {},
            },
        },
        config = function()
            local nvim_lsp = require("lspconfig")
            local capabilities = require("cmp_nvim_lsp").default_capabilities()

            local on_attach = function(_client, bufnr)
                vim.api.nvim_create_autocmd("CursorHold", {
                    buffer = bufnr,
                    callback = function()
                        local opts = {
                            focusable = false,
                            close_events = { "BufLeave", "CursorMoved", "InsertEnter", "FocusLost" },
                            border = "rounded",
                            source = "always",
                            prefix = " ",
                            scope = "cursor",
                        }
                        vim.diagnostic.open_float(nil, opts)
                    end,
                })
            end

            -- Use project-local typescript installation if available, fallback to global install
            -- assumes typescript installed globally w/ nvm
            local function get_typescript_server_path(root_dir)
                local global_ts = nvim_lsp.util.path.join(
                    vim.fn.stdpath("data"),
                    "mason",
                    "packages",
                    "typescript-language-server",
                    "node_modules",
                    "typescript",
                    "lib"
                )

                local project_ts = ""
                local function check_dir(path)
                    project_ts = nvim_lsp.util.path.join(path, "node_modules", "typescript", "lib")
                    if nvim_lsp.util.path.exists(project_ts) then
                        return path
                    end
                end
                if nvim_lsp.util.search_ancestors(root_dir, check_dir) then
                    return project_ts
                else
                    return global_ts
                end
            end

            local servers = {
                lua_ls = {
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
                },
                rls = {},
                tsserver = {},
                svelte = {},
                volar = {
                    on_new_config = function(new_config, new_root_dir)
                        new_config.init_options.typescript.tsdk = get_typescript_server_path(new_root_dir)
                    end,
                },
                gopls = {},
            }

            for server, opts in pairs(servers) do
                local base_options = {
                    capabilities = capabilities,
                    on_attach = on_attach,
                }
                local options = vim.tbl_deep_extend("force", base_options, opts)

                nvim_lsp[server].setup(options)
            end
        end,
    },
    {
        "nvimdev/lspsaga.nvim",
        event = "LspAttach",
        dependencies = {
            "nvim-tree/nvim-web-devicons",
            "nvim-treesitter/nvim-treesitter",
        },
        opts = {},
    },
    {
        "nvim-lualine/lualine.nvim",
        event = "VeryLazy",
        dependencies = { "nvim-tree/nvim-web-devicons" },
        opts = {},
    },
    {
        "nvim-pack/nvim-spectre",
        dependencies = { "nvim-lua/plenary.nvim" },
    },
    {
        "nvim-telescope/telescope.nvim",
        dependencies = {
            "nvim-lua/plenary.nvim",
            {
                "nvim-telescope/telescope-live-grep-args.nvim",
                version = "^1.0.0",
            },
        },
        opts = {
            defaults = {
                mappings = {
                    i = {
                        ["<C-j>"] = "cycle_history_next",
                        ["<C-k>"] = "cycle_history_prev",
                    },
                },
            },
            pickers = {
                find_files = {
                    hidden = true,
                },
                live_grep = {
                    additional_args = function()
                        return { "--hidden" }
                    end,
                },
            },
        },
        config = function(_, opts)
            local telescope = require("telescope")

            telescope.setup(opts)
            telescope.load_extension("live_grep_args")
        end,
    },
    {
        "nvim-treesitter/nvim-treesitter",
        build = ":TSUpdate",
        config = function()
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
    "tpope/vim-endwise",
    {
        "tpope/vim-fugitive",
        cmd = { "Git", "GBrowse" },
        dependencies = {
            "tpope/vim-rhubarb",
        },
    },
    "tpope/vim-repeat",
    "wellle/targets.vim",
}
