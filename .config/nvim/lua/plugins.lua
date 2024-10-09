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
        "echasnovski/mini.pairs",
        event = "VeryLazy",
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
                -- override markdown rendering so that **cmp** and other plugins use **Treesitter**
                override = {
                    ["vim.lsp.util.convert_input_to_markdown_lines"] = true,
                    ["vim.lsp.util.stylize_markdown"] = true,
                    ["cmp.entry.get_documentation"] = true, -- requires hrsh7th/nvim-cmp
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
                            local notify = require("notify")
                            local path = vim.api.nvim_buf_get_name(0)
                            vim.fn.setreg("+", path)
                            notify("Yanked current file path to clipboard", "info")
                        end,
                        desc = "Yank file path",
                    },
                    {
                        "<leader>fY",
                        function()
                            local notify = require("notify")
                            local Path = require("plenary.path")
                            local path = Path:new(vim.api.nvim_buf_get_name(0)):make_relative()
                            vim.fn.setreg("+", path)
                            notify("Yanked current file path to clipboard", "info")
                        end,
                        desc = "Yank file path (relative to project root)",
                    },
                },

                {
                    "<leader>g",
                    group = "git",
                    { "<leader>gg", "<cmd> Git<cr>", desc = "Git" }, -- tpope/vim-fugitive
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
        dependencies = {
            "neovim/nvim-lspconfig",
            "hrsh7th/cmp-nvim-lsp",
            -- neodev must be set up before lua_ls (https://github.com/folke/neodev.nvim/tree/80487e4f7bfa11c2ef2a1b461963db019aad6a73#-setup).
            "folke/neodev.nvim",
        },
        config = function()
            local lspconfig = require("lspconfig")
            local mason_lspconfig = require("mason-lspconfig")

            local options_with_defaults = function(options)
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

                local default_options = {
                    capabilities = capabilities,
                    on_attach = on_attach,
                }

                return vim.tbl_extend("error", default_options, options)
            end

            local default_setup = function(server)
                lspconfig[server].setup(options_with_defaults({}))
            end

            mason_lspconfig.setup({
                handlers = {
                    default_setup,
                    lua_ls = function()
                        lspconfig.lua_ls.setup(options_with_defaults({
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
                        }))
                    end,
                    tsserver = function()
                        local global_pnpm_root_directory = "~/Library/pnpm/global/5/node_modules"
                        -- Use project-local typescript installation if available, fallback to global install
                        -- assumes typescript installed globally w/ nvm
                        lspconfig.tsserver.setup(options_with_defaults({
                            init_options = {
                                plugins = {
                                    {
                                        name = "@vue/typescript-plugin",
                                        location = vim.fn.expand(
                                            global_pnpm_root_directory .. "/@vue/typescript-plugin"
                                        ),
                                        languages = { "javascript", "typescript", "vue" },
                                    },
                                },
                            },
                            filetypes = {
                                "javascript",
                                "typescript",
                                "vue",
                            },
                        }))
                    end,
                    volar = function()
                        local function get_typescript_server_path(root_dir)
                            local global_ts = lspconfig.util.path.join(
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
                                project_ts = lspconfig.util.path.join(path, "node_modules", "typescript", "lib")
                                if lspconfig.util.path.exists(project_ts) then
                                    return path
                                end
                            end
                            if lspconfig.util.search_ancestors(root_dir, check_dir) then
                                return project_ts
                            else
                                return global_ts
                            end
                        end

                        lspconfig.volar.setup(options_with_defaults({
                            on_new_config = function(new_config, new_root_dir)
                                new_config.init_options.typescript.tsdk = get_typescript_server_path(new_root_dir)
                            end,
                        }))
                    end,
                },
                ensure_installed = {
                    "gopls",
                    "lua_ls",
                    "stylelint_lsp",
                    "tsserver",
                    "volar",
                },
            })
        end,
    },
    "neovim/nvim-lspconfig",
    {
        "nvimdev/lspsaga.nvim",
        event = "LspAttach",
        dependencies = {
            "nvim-treesitter/nvim-treesitter",
        },
        opts = {},
    },
    {
        "nvim-lualine/lualine.nvim",
        event = "VeryLazy",
        opts = {
            sections = {
                lualine_y = {
                    {
                        "searchcount",
                        maxcount = 9999,
                        timeout = 500,
                    },
                    "progress",
                },
            },
        },
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
        opts = function()
            local mappings = {
                ["<C-j>"] = "cycle_history_next",
                ["<C-k>"] = "cycle_history_prev",
                ["<C-p>"] = require("telescope.actions.layout").toggle_preview,
            }

            return {
                defaults = {
                    path_display = { "filename_first" },
                    mappings = {
                        i = mappings,
                        n = mappings,
                    },
                    layout_config = {
                        horizontal = {
                            -- Workaround for setting 100% width.
                            width = { padding = 0 },
                            preview_width = 0.33,
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
            }
        end,
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
