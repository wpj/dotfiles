return {
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
}
