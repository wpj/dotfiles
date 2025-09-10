local function run_after_minifiles_close(fn)
    require("mini.files").close()
    fn()
end

return {
    {
        "andymass/vim-matchup",
        event = { "BufReadPost" },
    },
    "browserslist/vim-browserslist",
    {
        "folke/flash.nvim",
        ---@type Flash.Config
        opts = {},
        -- stylua: ignore
        keys = {
            { "<cr>", mode = { "n", "x", "o" }, function() require("flash").jump() end, desc = "Flash" },
            { "<c-s>", mode = { "c" }, function() require("flash").toggle() end, desc = "Toggle Flash search" },
        },
    },
    {
        "folke/lazydev.nvim",
        ft = "lua",
        opts = {
            library = {
                -- Load luvit types when the `vim.uv` word is found
                { path = "${3rd}/luv/library", words = { "vim%.uv" } },
            },
        },
    },
    {
        "folke/ts-comments.nvim",
        opts = {},
        event = "VeryLazy",
    },
    {
        "ibhagwan/fzf-lua",
        dependencies = { "nvim-mini/mini.icons" },
        opts = {
            defaults = { git_icons = false },
            files = {
                fzf_opts = {
                    ["--history"] = vim.fn.stdpath("data") .. "/fzf-lua-files-history",
                },
            },
            grep = {
                fzf_opts = {
                    ["--history"] = vim.fn.stdpath("data") .. "/fzf-lua-grep-history",
                },
            },
            keymap = {
                builtin = {
                    ["<C-/>"] = "toggle-help",
                    ["<C-_>"] = "toggle-preview",
                    ["<c-=>"] = "toggle-fullscreen",
                },
                fzf = {
                    ["ctrl-a"] = "select-all",
                    ["ctrl-q"] = "select-all+accept",
                },
            },
            oldfiles = {
                include_current_session = true,
            },
            winopts = {
                preview = { hidden = true },
            },
        },
        cmd = { "FzfLua" },
        keys = function()
            local fzf_lua = require("fzf-lua")

            return {
                {
                    "<leader>/",
                    function()
                        run_after_minifiles_close(fzf_lua.live_grep)
                    end,
                    desc = "Grep files",
                },
                {
                    "<leader><leader>",
                    function()
                        run_after_minifiles_close(fzf_lua.files)
                    end,
                    desc = "Find file in project",
                },
                {
                    "<leader>ff",
                    function()
                        run_after_minifiles_close(fzf_lua.files)
                    end,
                    desc = "Find file in project",
                },
                {
                    "<leader>fg",
                    function()
                        run_after_minifiles_close(fzf_lua.git_files)
                    end,
                    desc = "Find git files",
                },
                {
                    "<leader>fr",
                    function()
                        run_after_minifiles_close(fzf_lua.oldfiles)
                    end,
                    desc = "Find recent files",
                },
                {
                    "<leader>fc",
                    function()
                        fzf_lua.grep_visual()
                    end,
                    mode = { "v" },
                    desc = "Grep current visual selection",
                },
                {
                    "<leader>fc",
                    function()
                        fzf_lua.grep_cword()
                    end,
                    mode = { "n" },
                    desc = "Grep word under cursor",
                },
                {
                    "<leader>sc",
                    function()
                        fzf_lua.commands()
                    end,
                    desc = "Commands",
                },
                {
                    "<leader>sh",
                    function()
                        fzf_lua.helptags()
                    end,
                    desc = "Help",
                },
                {
                    "<leader>sk",
                    function()
                        fzf_lua.keymaps()
                    end,
                    desc = "Keymaps",
                },
            }
        end,
    },
    {
        "folke/snacks.nvim",
        keys = function()
            local snacks = require("snacks")
            return {
                {
                    "<leader>bd",
                    function()
                        snacks.bufdelete()
                    end,
                    desc = "Delete buffer",
                },
                {
                    "<leader>bo",
                    function()
                        snacks.bufdelete.other()
                    end,
                    desc = "Delete other buffers",
                },
                {
                    "<leader>gg",
                    function()
                        snacks.lazygit()
                    end,
                    desc = "Lazygit",
                },
                {
                    "<leader>gl",
                    function()
                        snacks.lazygit.log()
                    end,
                    desc = "Git log",
                },
                {
                    "<leader>gL",
                    function()
                        snacks.lazygit.log_file()
                    end,
                    desc = "Git log file",
                },
                {
                    "<leader>go",
                    function()
                        snacks.gitbrowse()
                    end,
                    mode = { "n", "v" },
                    desc = "Open git remote url",
                },
                {
                    "<leader>gy",
                    function()
                        snacks.gitbrowse({
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
            }
        end,
        priority = 1000,
        lazy = false,
        opts = {
            bigfile = {},
            gitbrowse = {
                what = "permalink",
            },
            input = {},
            image = {
                resolve = function(path, src)
                    if require("obsidian.api").path_is_note(path) then
                        return require("obsidian.api").resolve_image_path(src)
                    end
                end,
            },
            lazygit = {
                win = {
                    width = 0.95,
                    height = 0.95,
                },
            },
            notify = {},
            notifier = {},
            rename = {},
            statuscolumn = {
                left = { "mark", "sign" },
                right = { "fold" },
                folds = {
                    git_hl = true,
                    open = true,
                },
            },
        },
        config = function(_plugin, opts)
            local snacks = require("snacks")
            snacks.setup(opts)

            -- https://github.com/folke/snacks.nvim/blob/bc0630e43be5699bb94dadc302c0d21615421d93/docs/rename.md#minifiles
            vim.api.nvim_create_autocmd("User", {
                pattern = "MiniFilesActionRename",
                callback = function(event)
                    snacks.rename.on_rename_file(event.data.from, event.data.to)
                end,
            })
        end,
    },
    {
        "folke/todo-comments.nvim",
        event = "VeryLazy",
        dependencies = { "nvim-lua/plenary.nvim" },
        opts = {
            signs = false,
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
        "j-hui/fidget.nvim",
        opts = {},
    },
    {
        "kevinhwang91/nvim-bqf",
        opts = {},
        ft = "qf",
    },
    {
        "lewis6991/gitsigns.nvim",
        event = "VeryLazy",
        opts = {
            signcolumn = false,
            numhl = true,
        },
    },
    {
        "MagicDuck/grug-far.nvim",
        cmd = { "GrugFar" },
        opts = {},
        keys = {
            {
                "<leader>fR",
                function()
                    require("grug-far").open()
                end,
                desc = "Find and replace",
            },
        },
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
    },
    {
        "NeogitOrg/neogit",
        dependencies = {
            "nvim-lua/plenary.nvim",
            "sindrets/diffview.nvim",
            "ibhagwan/fzf-lua",
        },
        opts = {
            integrations = {
                diffview = true,
                fzf_lua = true,
            },
        },
        cmd = { "Neogit" },
        keys = {
            {
                "<leader>gG",
                function()
                    require("neogit").open()
                end,
                desc = "Git",
            },
        },
    },
    {
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
    },
    {
        "NMAC427/guess-indent.nvim",
        opts = {},
    },
    {
        "nvim-mini/mini.ai",
        opts = function()
            local gen_spec = require("mini.ai").gen_spec

            return {
                custom_textobjects = {
                    -- Function definition (needs treesitter queries with these captures)
                    F = gen_spec.treesitter({ a = "@function.outer", i = "@function.inner" }),
                },
            }
        end,
    },
    {
        "nvim-mini/mini.bracketed",
        opts = {
            diagnostic = {
                options = {
                    -- Disable diagnostic float in favor of
                    -- tiny-inline-diagnostic.
                    float = false,
                },
            },
        },
    },
    {
        "nvim-mini/mini.clue",
        event = "VeryLazy",
        opts = function()
            local miniclue = require("mini.clue")

            return {
                triggers = {
                    -- Leader triggers
                    { mode = "n", keys = "<Leader>" },
                    { mode = "x", keys = "<Leader>" },

                    -- Built-in completion
                    { mode = "i", keys = "<C-x>" },

                    -- `g` key
                    { mode = "n", keys = "g" },
                    { mode = "x", keys = "g" },

                    -- Marks
                    { mode = "n", keys = "'" },
                    { mode = "n", keys = "`" },
                    { mode = "x", keys = "'" },
                    { mode = "x", keys = "`" },

                    -- Registers
                    { mode = "n", keys = '"' },
                    { mode = "x", keys = '"' },
                    { mode = "i", keys = "<C-r>" },
                    { mode = "c", keys = "<C-r>" },

                    -- Window commands
                    { mode = "n", keys = "<C-w>" },

                    -- `z` key
                    { mode = "n", keys = "z" },
                    { mode = "x", keys = "z" },

                    -- Moving
                    { mode = "n", keys = "[" },
                    { mode = "n", keys = "]" },
                },
                clues = {
                    { mode = "n", keys = "<leader>b", desc = "+buffer" },
                    { mode = "n", keys = "<leader>c", desc = "+code" },
                    { mode = "n", keys = "<leader>d", desc = "+diagnostic" },
                    { mode = "n", keys = "<leader>f", desc = "+file/find" },
                    { mode = "n", keys = "<leader>g", desc = "+git" },
                    { mode = "x", keys = "<leader>g", desc = "+git" },
                    { mode = "n", keys = "<leader>n", desc = "+notes" },
                    { mode = "n", keys = "<leader>q", desc = "+quickfix" },
                    { mode = "n", keys = "<leader>s", desc = "+search" },
                    { mode = "n", keys = "<leader>w", desc = "+window" },
                    { mode = "n", keys = "[", desc = "+prev" },
                    { mode = "n", keys = "]", desc = "+next" },
                    { mode = "n", keys = "gz", desc = "+surround" },
                    miniclue.gen_clues.builtin_completion(),
                    miniclue.gen_clues.g(),
                    miniclue.gen_clues.marks(),
                    miniclue.gen_clues.registers(),
                    miniclue.gen_clues.windows(),
                    miniclue.gen_clues.z(),
                },
                window = {
                    delay = 250,
                    scroll_down = "<C-f>",
                    scroll_up = "<C-b>",
                    config = {
                        width = "auto",
                    },
                },
            }
        end,
    },
    -- FIX: Enable mini.diff (and remove gitsigns) when the snacks.statuscolumn
    -- integration can be made to show diagnostic signs with mini.diff enabled.
    {
        "nvim-mini/mini.diff",
        enabled = false,
        opts = {
            view = {
                style = "number",
            },
        },
    },
    {
        "nvim-mini/mini.files",
        opts = {},
        lazy = false,
        keys = {
            {
                "-",
                function()
                    require("mini.files").open(vim.api.nvim_buf_get_name(0), true)
                end,
                desc = "Open file browser",
            },
        },
        config = function(_plugin, opts)
            local minifiles = require("mini.files")
            minifiles.setup(opts)

            local files_grep = function(path)
                -- works only if cursor is on the valid file system entry
                local cur_entry_path = minifiles.get_fs_entry().path
                local cwd = vim.fs.dirname(cur_entry_path)

                vim.notify("cwd: " .. cwd)

                run_after_minifiles_close(function()
                    require("fzf-lua").live_grep({ cwd = cwd })
                end)
            end

            vim.api.nvim_create_autocmd("User", {
                pattern = "MiniFilesBufferCreate",
                callback = function(args)
                    vim.keymap.set("n", "fp", files_grep, { buffer = args.data.buf_id, desc = "Search in directory" })
                end,
            })
        end,
    },
    {
        "nvim-mini/mini-git",
        main = "mini.git",
        cmd = { "Git" },
        keys = {
            {
                "<leader>gb",
                "<cmd>vertical Git blame -- %<cr>",
                desc = "Git blame",
            },
            {
                "<leader>gs",
                function()
                    require("mini.git").show_at_cursor()
                end,
                mode = { "n", "x" },
                desc = "Show at cursor",
            },
        },
        config = function(_plugin, opts)
            local minigit = require("mini.git")
            minigit.setup(opts)

            -- https://github.com/nvim-mini/mini.nvim/blob/c665f30bb372c2ec8cfd61f7531098d3658b6634/doc/mini-git.txt#L90-L111
            local align_blame = function(au_data)
                if au_data.data.git_subcommand ~= "blame" then
                    return
                end

                -- Align blame output with source
                local win_src = au_data.data.win_source
                vim.wo.wrap = false
                vim.fn.winrestview({ topline = vim.fn.line("w0", win_src) })
                vim.api.nvim_win_set_cursor(0, { vim.fn.line(".", win_src), 0 })

                -- Bind both windows so that they scroll together
                vim.wo[win_src].scrollbind, vim.wo.scrollbind = true, true
            end

            local au_opts = { pattern = "MiniGitCommandSplit", callback = align_blame }
            vim.api.nvim_create_autocmd("User", au_opts)
        end,
    },
    { "nvim-mini/mini.icons", version = false, config = true },
    {
        "nvim-mini/mini.indentscope",
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
        "nvim-mini/mini.operators",
        opts = {},
    },
    {
        "nvim-mini/mini.statusline",
        config = function()
            local statusline = require("mini.statusline")
            statusline.setup()

            statusline.section_location = function()
                return "%2l:%-2v"
            end
        end,
    },
    {
        "nvim-mini/mini.surround",
        opts = {
            mappings = {
                add = "gza",
                delete = "gzd",
                find = "gzf",
                find_left = "gzF",
                highlight = "gzh",
                replace = "gzr",
                update_n_lines = "gzn",
            },
        },
    },
    {
        "nvim-lua/plenary.nvim",
        lazy = true,
    },
    {
        "nvim-treesitter/nvim-treesitter",
        event = { "VeryLazy" },
        build = ":TSUpdate",
        main = "nvim-treesitter.configs",
        dependencies = { "nvim-treesitter/nvim-treesitter-textobjects" },
        opts = {
            ensure_installed = {
                "bash",
                "css",
                "csv",
                "dockerfile",
                "fish",
                "git_config",
                "git_rebase",
                "gitattributes",
                "gitcommit",
                "gitignore",
                "go",
                "gomod",
                "gosum",
                "gowork",
                "graphql",
                "html",
                "javascript",
                "jsdoc",
                "json",
                "lua",
                "luadoc",
                "markdown",
                "markdown_inline",
                "python",
                "regex",
                "rust",
                "scss",
                "svelte",
                "toml",
                "tsx",
                "typescript",
                "vim",
                "vimdoc",
                "vue",
                "xml",
                "yaml",
            },
            auto_install = true,
            highlight = {
                enable = true,
                additional_vim_regex_highlighting = { "ruby" },
            },
            incremental_selection = {
                enable = true,
                keymaps = {
                    init_selection = "<C-space>",
                    node_incremental = "<C-space>",
                    scope_incremental = false,
                    node_decremental = "<bs>",
                },
            },
            indent = { enable = true, disable = { "ruby" } },
        },
    },
    {
        "obsidian-nvim/obsidian.nvim",
        version = "*",
        cmd = { "Obsidian" },
        keys = {
            {
                "<leader>n<leader>",
                "<cmd>Obsidian quick_switch<cr>",
                desc = "Quick switch",
            },
            {
                "<leader>n/",
                "<cmd>Obsidian search<cr>",
                desc = "Search notes",
            },
            {
                "<leader>nl",
                "<cmd>Obsidian backlinks<cr>",
                desc = "Backlinks",
            },
            {
                "<leader>nn",
                "<cmd>Obsidian new<cr>",
                desc = "Create new note",
            },
            {
                "<leader>nt",
                "<cmd>Obsidian today<cr>",
                desc = "Open today's daily note",
            },
        },
        ft = "markdown",
        ---@module 'obsidian'
        ---@type obsidian.config
        opts = {
            legacy_commands = false,
            picker = {
                name = "fzf-lua",
            },
            completion = {
                blink = true,
            },
            note_id_func = function(title)
                -- Create note IDs with a timestamp and a suffix.
                local suffix = ""
                if title ~= nil then
                    suffix = title:gsub(" ", "-"):gsub("[^A-Za-z0-9-]", ""):lower()
                else
                    -- If title is nil, add 4 random uppercase letters to the suffix.
                    for _ = 1, 4 do
                        suffix = suffix .. string.char(math.random(65, 90))
                    end
                end
                return os.date("%Y-%m-%d", os.time()) .. "-" .. suffix
            end,
            new_notes_location = "notes_subdir",
            notes_subdir = "notes",
            daily_notes = {
                folder = "journal",
            },
            workspaces = {
                {
                    name = "personal",
                    path = "~/Library/Mobile Documents/com~apple~CloudDocs/Documents/Obsidian Vaults/Personal",
                },
            },
        },
    },
    {
        "rachartier/tiny-inline-diagnostic.nvim",
        event = "VeryLazy",
        keys = function()
            return {
                {
                    "<leader>dt",
                    require("tiny-inline-diagnostic").toggle,
                    desc = "Toggle inline diagnostics",
                },
            }
        end,
        opts = {},
        priority = 1000,
    },
    {
        "saghen/blink.cmp",
        event = "VeryLazy",
        dependencies = { "rafamadriz/friendly-snippets" },
        version = "1.*",
        ---@module 'blink.cmp'
        ---@type blink.cmp.Config
        opts = {
            keymap = {
                preset = "default",
            },
            sources = {
                default = { "lazydev", "lsp", "path", "snippets", "buffer" },
                providers = {
                    lazydev = {
                        name = "LazyDev",
                        module = "lazydev.integrations.blink",
                        score_offset = 100,
                    },
                },
            },
            signature = {
                enabled = true,
            },
        },
    },
    {
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
    },
    {
        "windwp/nvim-autopairs",
        event = "InsertEnter",
        opts = {},
    },
}
