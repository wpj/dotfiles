local function run_after_minifiles_close(fn)
    require("mini.files").close()
    fn()
end

return {
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
}
