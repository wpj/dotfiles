return {
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
}
