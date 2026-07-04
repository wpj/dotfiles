vim.pack.add({ 'https://github.com/nvim-mini/mini.misc' })
local safely = require('mini.misc').safely
local now = function(f) safely('now', f) end
local later = function(f) safely('later', f) end

local Utils = require("utils")
local nmap, run_after_minifiles_close = Utils.nmap, Utils.run_after_minifiles_close

now(function()
    vim.pack.add({ 'https://github.com/andymass/vim-matchup' })
end)

now(function()
    vim.pack.add({ 'https://github.com/browserslist/vim-browserslist' })
end)

now(function()
    vim.pack.add({ { src = 'https://github.com/catppuccin/nvim', name = 'catppuccin' } })
    vim.cmd("colorscheme catppuccin-mocha")
end)

later(function()
    vim.pack.add({ 'https://github.com/folke/flash.nvim' })

    vim.keymap.set({ "n", "x", "o" }, "<cr>", function()
        require("flash").jump()
    end, { desc = "Flash" })

    vim.keymap.set("c", "<c-s>", function()
        require("flash").toggle()
    end, { desc = "Toggle Flash search" })
end)

now(function()
    vim.pack.add({ 'https://github.com/folke/snacks.nvim' })

    local snacks = require("snacks")
    snacks.setup({
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
    })

    nmap("<leader>bd", function()
        snacks.bufdelete()
    end, { desc = "Delete buffer" })
    nmap("<leader>bo", function()
        snacks.bufdelete.other()
    end, { desc = "Delete other buffers" })
    nmap("<leader>gg", function()
        snacks.lazygit()
    end, { desc = "Lazygit" })
    nmap("<leader>gl", function()
        snacks.lazygit.log()
    end, { desc = "Git log" })
    nmap("<leader>gL", function()
        snacks.lazygit.log_file()
    end, { desc = "Git log file" })
    vim.keymap.set({ "n", "v" }, "<leader>go", function()
        snacks.gitbrowse()
    end, { desc = "Open git remote url" })
    vim.keymap.set({ "n", "v" }, "<leader>gy", function()
        snacks.gitbrowse({
            open = function(url)
                vim.fn.setreg("+", url)
                vim.notify("Yanked " .. url .. " to system clipboard")
            end,
            notify = false,
        })
    end, { desc = "Yank git remote url" })

    -- https://github.com/folke/snacks.nvim/blob/bc0630e43be5699bb94dadc302c0d21615421d93/docs/rename.md#minifiles
    vim.api.nvim_create_autocmd("User", {
        pattern = "MiniFilesActionRename",
        callback = function(event)
            snacks.rename.on_rename_file(event.data.from, event.data.to)
        end,
    })
end)

later(function()
    vim.pack.add({ 'https://github.com/folke/todo-comments.nvim' })
    require("todo-comments").setup({ signs = false })
end)

later(function()
    vim.pack.add({ 'https://github.com/folke/trouble.nvim' })
    require("trouble").setup()
end)

later(function()
    vim.pack.add({ 'https://github.com/folke/ts-comments.nvim' })
    require("ts-comments").setup()
end)

later(function()
    -- depends on mini.icons, which is added in its own now() block above
    vim.pack.add({ 'https://github.com/ibhagwan/fzf-lua' })

    local fzf_lua = require("fzf-lua")

    fzf_lua.setup({
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
    })

    nmap("<leader>/", function()
        run_after_minifiles_close(fzf_lua.live_grep)
    end, { desc = "Grep files" })

    nmap("<leader><leader>", function()
        run_after_minifiles_close(fzf_lua.files)
    end, { desc = "Find file in project" })

    nmap("<leader>ff", function()
        run_after_minifiles_close(fzf_lua.files)
    end, { desc = "Find file in project" })

    nmap("<leader>fg", function()
        run_after_minifiles_close(fzf_lua.git_files)
    end, { desc = "Find git files" })

    nmap("<leader>fr", function()
        run_after_minifiles_close(fzf_lua.oldfiles)
    end, { desc = "Find recent files" })

    vim.keymap.set("v", "<leader>fc", function()
        fzf_lua.grep_visual()
    end, { desc = "Grep current visual selection" })

    nmap("<leader>fc", function()
        fzf_lua.grep_cword()
    end, { desc = "Grep word under cursor" })

    nmap("<leader>sc", function()
        fzf_lua.commands()
    end, { desc = "Commands" })

    nmap("<leader>sh", function()
        fzf_lua.helptags()
    end, { desc = "Help" })

    nmap("<leader>sk", function()
        fzf_lua.keymaps()
    end, { desc = "Keymaps" })
end)

now(function()
    vim.pack.add({ 'https://github.com/j-hui/fidget.nvim' })
    require("fidget").setup({})
end)

now(function()
    vim.pack.add({ 'https://github.com/kevinhwang91/nvim-bqf' })
end)

later(function()
    vim.pack.add({ 'https://github.com/lewis6991/gitsigns.nvim' })

    require("gitsigns").setup({
        signcolumn = false,
        numhl = true,
    })
end)

later(function()
    vim.pack.add({ 'https://github.com/MagicDuck/grug-far.nvim' })

    nmap("<leader>fR", function()
        require("grug-far").open()
    end, { desc = "Find and replace" })
end)

now(function()
    vim.pack.add({ 'https://github.com/NMAC427/guess-indent.nvim' })
end)

later(function()
    vim.pack.add({ 'https://github.com/folke/lazydev.nvim' })

    require("lazydev").setup({
        library = {
            -- Load luvit types when the `vim.uv` word is found
            { path = "${3rd}/luv/library", words = { "vim%.uv" } },
        },
    })
end)

now(function()
    vim.pack.add({ 'https://github.com/nvim-lua/plenary.nvim' })
end)

later(function()
    vim.pack.add({ 'https://github.com/nvim-mini/mini.ai' })

    local gen_spec = require("mini.ai").gen_spec

    require("mini.ai").setup({
        custom_textobjects = {
            -- Function definition (needs treesitter queries with these captures)
            F = gen_spec.treesitter({ a = "@function.outer", i = "@function.inner" }),
        },
    })
end)

later(function()
    vim.pack.add({ 'https://github.com/nvim-mini/mini.bracketed' })

    require("mini.bracketed").setup({
        diagnostic = {
            options = {
                -- Disable diagnostic float in favor of
                -- tiny-inline-diagnostic.
                float = false,
            },
        },
    })
end)

later(function()
    vim.pack.add({ 'https://github.com/nvim-mini/mini.clue' })

    local miniclue = require("mini.clue")

    miniclue.setup({
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
    })
end)

-- FIX: Enable mini.diff (and remove gitsigns) when the snacks.statuscolumn
-- integration can be made to show diagnostic signs with mini.diff enabled.

now(function()
    vim.pack.add({ 'https://github.com/nvim-mini/mini.files' })

    local minifiles = require("mini.files")

    nmap("-", function()
        minifiles.open(vim.api.nvim_buf_get_name(0), true)
    end, { desc = "Open file browser" })

    local yank_path = function()
        local path = (minifiles.get_fs_entry() or {}).path
        if path == nil then
            return vim.notify("Cursor is not on valid entry")
        end
        vim.fn.setreg(vim.v.register, path)
    end

    local grep_files = function()
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
            local b = args.data.buf_id
            nmap("fp", grep_files, { buffer = b, desc = "Search in directory" })
            nmap("gy", yank_path, { buffer = b, desc = "Yank path" })
        end,
    })
end)

later(function()
    vim.pack.add({ { src = 'https://github.com/nvim-mini/mini-git', name = 'mini.git' } })

    nmap("<leader>gb", "<cmd>vertical Git blame -- %<cr>", { desc = "Git blame" })
    vim.keymap.set({ "n", "x" }, "<leader>gs", function()
        require("mini.git").show_at_cursor()
    end, { desc = "Show at cursor" })

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
end)

now(function()
    vim.pack.add({ 'https://github.com/nvim-mini/mini.icons' })
end)

later(function()
    vim.pack.add({ 'https://github.com/nvim-mini/mini.indentscope' })

    require("mini.indentscope").setup({
        symbol = "│",
        draw = {
            animation = require("mini.indentscope").gen_animation.cubic({ duration = 10 }),
        },
    })
end)

later(function()
    vim.pack.add({ 'https://github.com/nvim-mini/mini.operators' })
    require("mini.operators").setup()
end)

now(function()
    vim.pack.add({ 'https://github.com/nvim-mini/mini.statusline' })

    local statusline = require("mini.statusline")

    local function active_content()
        local mode, mode_hl = statusline.section_mode({ trunc_width = 120 })
        local git = statusline.section_git({ trunc_width = 40 })
        local diff = statusline.section_diff({ trunc_width = 75 })
        local diagnostics = statusline.section_diagnostics({ trunc_width = 75 })
        local lsp = statusline.section_lsp({ trunc_width = 75 })
        local filename = statusline.section_filename({ trunc_width = 140 })
        local fileinfo = statusline.section_fileinfo({ trunc_width = 120 })
        local location = "%2l:%-2v"
        local search = statusline.section_searchcount({ trunc_width = 75 })

        return statusline.combine_groups({
            { hl = mode_hl, strings = { mode } },
            { hl = "MiniStatuslineDevinfo", strings = { git, diff, diagnostics, lsp } },
            "%<", -- Mark general truncate point
            { hl = "MiniStatuslineFilename", strings = { filename } },
            "%=", -- End left alignment
            { hl = "MiniStatuslineFileinfo", strings = { fileinfo } },
            { hl = mode_hl, strings = { search, location } },
        })
    end

    statusline.setup({ content = { active = active_content, inactive = nil } })
end)

later(function()
    vim.pack.add({ 'https://github.com/nvim-mini/mini.surround' })

    require("mini.surround").setup({
        mappings = {
            add = "gza",
            delete = "gzd",
            find = "gzf",
            find_left = "gzF",
            highlight = "gzh",
            replace = "gzr",
            update_n_lines = "gzn",
        },
    })
end)

now(function()
    local BLINK_VERSION = "v1.8.0"

    vim.pack.add({ 'https://github.com/rafamadriz/friendly-snippets' })
    vim.pack.add({ { src = 'https://github.com/saghen/blink.cmp', version = BLINK_VERSION } })

    require("blink.cmp").setup({
        fuzzy = {
            prebuilt_binaries = {
                download = true,
                force_version = BLINK_VERSION,
            },
        },
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
    })
end)

later(function()
    vim.pack.add({ 'https://github.com/stevearc/conform.nvim' })

    local js_formatter = "prettier"
    if vim.env.NVIM_USE_PRETTIER_ESLINT ~= nil then
        js_formatter = "prettiereslint"
    end

    require("conform").setup({
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
    })

    nmap("<leader>cf", function()
        require("conform").format({ timeout_ms = 3000 })
    end, { desc = "Format code" })
end)

later(function()
    vim.pack.add({ 'https://github.com/windwp/nvim-autopairs' })
    require("nvim-autopairs").setup()
end)

later(function()
    vim.pack.add({ 'https://github.com/mfussenegger/nvim-lint' })

    local lint = require("lint")

    nmap("<leader>cl", lint.try_lint, { desc = "Lint file" })

    lint.linters_by_ft = {
        javascript = { "eslint" },
        javascriptreact = { "eslint" },
        svelte = { "eslint" },
        typescript = { "eslint" },
        typescriptreact = { "eslint" },
        vue = { "eslint" },
    }

    vim.api.nvim_create_autocmd({ "BufEnter", "BufWritePost", "InsertLeave" }, {
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
end)

now(function()
    vim.pack.add({ 'https://github.com/neovim/nvim-lspconfig' })

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
end)

later(function()
    vim.pack.add({ 'https://github.com/nvim-treesitter/nvim-treesitter' })
    vim.pack.add({ 'https://github.com/nvim-treesitter/nvim-treesitter-textobjects' })

    require('nvim-treesitter').install({
        "bash", "css", "csv", "dockerfile", "fish", "git_config", "git_rebase",
        "gitattributes", "gitcommit", "gitignore", "go", "gomod", "gosum", "gowork",
        "graphql", "html", "javascript", "jsdoc", "json", "lua", "luadoc", "markdown",
        "markdown_inline", "python", "regex", "rust", "scss", "svelte", "toml",
        "tsx", "typescript", "vim", "vimdoc", "vue", "xml", "yaml",
    })

    -- Highlighting is handled natively by Neovim 0.12+.
    -- Indentation is disabled for ruby (matches previous config).
    vim.api.nvim_create_autocmd('FileType', {
        callback = function(args)
            if args.match ~= 'ruby' then
                vim.bo.indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
            end
        end,
    })
end)

later(function()
    vim.pack.add({ 'https://github.com/obsidian-nvim/obsidian.nvim' })

    ---@type obsidian.Workspace[]
    local workspaces = {}

    if vim.env.OBSIDIAN_WORKSPACES ~= nil then
        local workspace_config = vim.json.decode(vim.env.OBSIDIAN_WORKSPACES)
        for name, path in pairs(workspace_config) do
            table.insert(workspaces, {
                name = name,
                path = path,
            })
        end
    end

    require("obsidian").setup({
        legacy_commands = false,
        picker = {
            name = "fzf-lua",
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
        workspaces = workspaces,
    })

    nmap("<leader>n<leader>", "<cmd>Obsidian quick_switch<cr>", { desc = "Quick switch" })
    nmap("<leader>n/", "<cmd>Obsidian search<cr>", { desc = "Search notes" })
    nmap("<leader>nl", "<cmd>Obsidian backlinks<cr>", { desc = "Backlinks" })
    nmap("<leader>nn", "<cmd>Obsidian new<cr>", { desc = "Create new note" })
    nmap("<leader>nt", "<cmd>Obsidian today<cr>", { desc = "Open today's daily note" })
    nmap("<leader>nw", "<cmd>Obsidian workspace<cr>", { desc = "Open workspace picker" })
end)

later(function()
    vim.pack.add({ 'https://github.com/rachartier/tiny-inline-diagnostic.nvim' })

    nmap("<leader>dt", require("tiny-inline-diagnostic").toggle, {
        desc = "Toggle inline diagnostics",
    })
end)
