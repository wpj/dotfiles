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
    "airblade/vim-rooter",
    "andymass/vim-matchup",
    {
        "b3nj5m1n/kommentary",
        config = function()
            local kommentary_config = require("kommentary.config")

            kommentary_config.configure_language("less", {
                prefer_multi_line_comments = true,
            })

            local single_line_comment_languages = {
                "go",
                "javascript",
                "javascriptreact",
                "lua",
                "rust",
                "svelte",
                "typescript",
                "typescriptreact",
                "vue",
            }
            for _, lang in ipairs(single_line_comment_languages) do
                kommentary_config.configure_language(lang, {
                    prefer_single_line_comments = true,
                })
            end

            local update_commentstring = require("ts_context_commentstring.internal").update_commentstring

            local update_commentstring_languages = {
                "html",
                "javascriptreact",
                "svelte",
                "typescriptreact",
                "vue",
            }
            for _, lang in ipairs(update_commentstring_languages) do
                -- See https://github.com/JoosepAlviste/nvim-ts-context-commentstring/blob/88343753dbe81c227a1c1fd2c8d764afb8d36269/README.md#kommentary.
                kommentary_config.configure_language(lang, {
                    single_line_comment_string = "auto",
                    multi_line_comment_strings = "auto",
                    hook_function = update_commentstring,
                })
            end
        end,
    },
    "browserslist/vim-browserslist",
    "editorconfig/editorconfig-vim",
    {
        "folke/trouble.nvim",
        dependencies = { "nvim-tree/nvim-web-devicons" },
        config = true,
    },
    {

        "folke/tokyonight.nvim",
        lazy = false,
        priority = 1000,
        config = function()
            vim.cmd([[colorscheme tokyonight]])
        end,
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

                    -- mhartington/formatter.nvim
                    f = { "<cmd> Format<cr>", "Format code" },
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

            -- glepnir/lspsaga.nvim
            wk.register({
                ["[d"] = { "<cmd> Lspsaga diagnostic_jump_prev<cr>", "Previous diagnostic" },
                ["]d"] = { "<cmd> Lspsaga diagnostic_jump_next<cr>", "Next diagnostic" },
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
        config = true,
        dependencies = {
            "nvim-tree/nvim-web-devicons",
            "nvim-treesitter/nvim-treesitter",
        },
    },
    {
        "hoob3rt/lualine.nvim",
        dependencies = { "nvim-tree/nvim-web-devicons" },
        config = function()
            require("lualine").setup({
                options = {
                    icons_enabled = true,
                    theme = "tokyonight",
                },
            })
        end,
    },
    {
        "hrsh7th/nvim-cmp",
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
    "jiangmiao/auto-pairs",
    "JoosepAlviste/nvim-ts-context-commentstring",
    {
        "jose-elias-alvarez/null-ls.nvim",
        config = function()
            require("null-ls").setup({
                sources = {
                    require("null-ls").builtins.diagnostics.eslint,
                },
            })
        end,
    },
    "jremmen/vim-ripgrep",
    "junegunn/rainbow_parentheses.vim",
    "junegunn/seoul256.vim",
    "justinmk/vim-dirvish",
    {
        "lewis6991/gitsigns.nvim",
        dependencies = { "nvim-lua/plenary.nvim" },
        config = true,
    },
    "liuchengxu/vista.vim",
    "mattn/emmet-vim",
    {
        "mhartington/formatter.nvim",
        config = function()
            local prettier = require("formatter.filetypes.javascript").prettier
            local prettiereslint = require("formatter.filetypes.javascript").prettiereslint

            local js_formatter
            if vim.env.NVIM_USE_PRETTIER_ESLINT ~= nil then
                js_formatter = require("formatter.filetypes.javascript").prettiereslint
            else
                js_formatter = require("formatter.filetypes.javascript").prettier
            end

            require("formatter").setup({
                filetype = {
                    css = { prettier },
                    go = { require("formatter.filetypes.go").gofmt },
                    html = { prettier },
                    javascript = { js_formatter },
                    javascriptreact = { js_formatter },
                    json = { prettier },
                    less = { prettier },
                    lua = { require("formatter.filetypes.lua").stylua },
                    markdown = { prettier },
                    scss = { prettier },
                    svelte = { prettier },
                    typescript = { js_formatter },
                    typescriptreact = { js_formatter },
                    vue = { js_formatter },
                    yaml = { prettier },
                },
            })
        end,
    },
    {
        "neovim/nvim-lspconfig",
        config = function()
            local nvim_lsp = require("lspconfig")

            local enabled_servers = {
                "lua_ls",
                "rls",
                "tsserver",
                "svelte",
                "vuels",
                "gopls",
            }

            for _, server in ipairs(enabled_servers) do
                nvim_lsp[server].setup({})
            end
        end,
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
    "tpope/vim-endwise",
    "tpope/vim-fugitive",
    "tpope/vim-repeat",
    "tpope/vim-rhubarb",
    "tpope/vim-unimpaired",
    "wellle/targets.vim",
}, {
    install = {
        colorscheme = { "seoul256", "habamax" },
    },
})
