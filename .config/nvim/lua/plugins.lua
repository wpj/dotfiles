local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
    vim.fn.system({
        "git",
        "clone",
        "--filter=blob:none",
        "https://github.com/folke/lazy.nvim.git",
        "--branch=stable", -- latest stable release
        lazypath,
    })
end
vim.opt.rtp:prepend(lazypath)

require("lazy").setup({
    "andymass/vim-matchup",
    "browserslist/vim-browserslist",
    {
        "echasnovski/mini.comment",
        event = "VeryLazy",
        opts = {
            options = {
                custom_commentstring = function()
                    return require("ts_context_commentstring.internal").calculate_commentstring()
                        or vim.bo.commentstring
                end,
            },
        },
    },
    {
        "echasnovski/mini.pairs",
        event = "VeryLazy",
        opts = {},
    },
    "editorconfig/editorconfig-vim",
    {
        "folke/neodev.nvim",
        opts = {},
    },
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
        config = function()
            local wk = require("which-key")

            wk.setup({})

            wk.register({
                c = {
                    name = "code",

                    d = { "<cmd>lua vim.lsp.buf.definition()<cr>", "Go to definition" },

                    -- glepnir/lspsaga.nvim
                    a = { "<cmd> Lspsaga code_action<cr>", "Code actions" },
                    D = { "<cmd> Lspsaga peek_definition<cr>", "Preview definition" },
                    e = { "<cmd> Lspsaga show_line_diagnostics<cr>", "Show line diagnostics" },
                    h = { "<cmd> Lspsaga lsp_finder<cr>", "Find references" },
                    r = { "<cmd> Lspsaga rename<cr>", "Rename" },
                    s = { "<cmd> Lspsaga signature_help<cr>", "Show signature" },

                    -- stevearc/conform.nvim
                    f = { "<cmd>lua require('conform').format()<cr>", "Format code" },
                },

                f = {
                    name = "file",

                    -- nvim-telescope/telescope.nvim
                    f = { "<cmd>Telescope find_files<cr>", "Find file in project" },
                    r = { "<cmd>Telescope oldfiles<cr>", "Search recent files" },
                },

                -- tpope/vim-fugitive
                g = {
                    name = "git",
                    g = { "<cmd> Git<cr>", "Git" },
                },

                -- nvim-telescope/telescope.nvim
                ["/"] = { "<cmd>Telescope live_grep<cr>", "Search project files" },
                ["<leader>"] = { "<cmd>Telescope find_files<cr>", "Find file in project" },

                ["?"] = { "<cmd> WhichKey<cr>", "Show key bindings" },
            }, { prefix = "<leader>" })

            wk.register({
                -- glepnir/lspsaga.nvim
                ["[d"] = { "<cmd> Lspsaga diagnostic_jump_prev<cr>", "Previous diagnostic" },
                ["]d"] = { "<cmd> Lspsaga diagnostic_jump_next<cr>", "Next diagnostic" },

                -- stevearc/oil.nvim
                ["-"] = { "<cmd>Oil<cr>", "Open file browser" },

                -- nvim-telescope/telescope.nvim
                ["<C-j>"] = require("telescope.actions").cycle_history_next,
                ["<C-k>"] = require("telescope.actions").cycle_history_prev,
            })
        end,
    },
    {
        "glepnir/lspsaga.nvim",
        lazy = true,
        branch = "main",
        event = "LspAttach",
        dependencies = {
            "nvim-tree/nvim-web-devicons",
            "nvim-treesitter/nvim-treesitter",
        },
        opts = {},
    },
    {
        "hrsh7th/nvim-cmp",
        event = "InsertEnter",
        dependencies = {
            "hrsh7th/cmp-nvim-lsp",
            "hrsh7th/vim-vsnip",
            "hrsh7th/cmp-buffer",
            "hrsh7th/cmp-nvim-lua",
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
                        vim.fn["vsnip#anonymous"](args.body)
                    end,
                },
                sources = cmp.config.sources({
                    { name = "nvim_lsp" },
                    { name = "vsnip" },
                }, {
                    { name = "buffer" },
                }),
            })
        end,
    },
    {
        "JoosepAlviste/nvim-ts-context-commentstring",
        lazy = true,
        opts = {},
    },
    {
        "jose-elias-alvarez/null-ls.nvim",
        event = "LspAttach",
        config = function()
            require("null-ls").setup({
                sources = {
                    require("null-ls").builtins.diagnostics.eslint,
                },
            })
        end,
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
        "lukas-reineke/indent-blankline.nvim",
        event = "VeryLazy",
        opts = {
            indent = {
                char = "│",
            },
        },
        main = "ibl",
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
    },
    {
        "neovim/nvim-lspconfig",
        dependencies = {
            "folke/neodev.nvim",
        },
        config = function()
            local nvim_lsp = require("lspconfig")

            local servers = {
                lua_ls = {
                    settings = {
                        Lua = {
                            workspace = {
                                checkThirdParty = false,
                            },
                        },
                    },
                },
                rls = {},
                tsserver = {},
                svelte = {},
                vuels = {},
                gopls = {},
            }

            for server, opts in pairs(servers) do
                -- neodev must be set up before lua_ls (https://github.com/folke/neodev.nvim/tree/80487e4f7bfa11c2ef2a1b461963db019aad6a73#-setup).
                if server == "lua_ls" then
                    require("neodev").setup({})
                end

                nvim_lsp[server].setup(opts)
            end
        end,
    },
    {
        "nvim-lualine/lualine.nvim",
        event = "VeryLazy",
        dependencies = { "nvim-tree/nvim-web-devicons" },
        opts = {},
    },
    {
        "nvim-telescope/telescope.nvim",
        dependencies = { "nvim-lua/plenary.nvim" },
    },
    {
        "nvim-treesitter/nvim-treesitter",
        build = ":TSUpdate",
        config = function()
            require("nvim-treesitter.configs").setup({
                context_commentstring = {
                    enable = true,
                    enable_autocmd = false,
                },
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
            if vim.env.nvim_use_prettier_eslint ~= nil then
                js_formatter = "prettiereslint"
            end

            return {
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
        "stevearc/oil.nvim",
        opts = {},
        dependencies = { "nvim-tree/nvim-web-devicons" },
    },
    "tpope/vim-endwise",
    {
        "tpope/vim-fugitive",
        cmd = "Git",
        dependencies = {
            "tpope/vim-rhubarb",
        },
    },
    "tpope/vim-repeat",
    "wellle/targets.vim",
}, {
    install = {
        colorscheme = { "tokyonight", "habamax" },
    },
})
