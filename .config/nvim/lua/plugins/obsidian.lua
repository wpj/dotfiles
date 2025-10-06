return {
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
        {
            "<leader>nw",
            "<cmd>Obsidian workspace<cr>",
            desc = "Open workspace picker",
        },
    },
    ft = "markdown",
    opts = function()
        ---@type obsidian.Workspace[]
        local workspaces = {}

        if vim.env.OBSIDIAN_WORK_VAULT_PATH ~= nil then
            table.insert(workspaces, {
                name = "work",
                path = vim.env.OBSIDIAN_WORK_VAULT_PATH,
            })
        end

        table.insert(workspaces, {
            name = "personal",
            path = "~/Library/Mobile Documents/iCloud~md~obsidian/Documents/Personal",
        })

        ---@module 'obsidian'
        ---@type obsidian.config
        return {
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
            workspaces = workspaces,
        }
    end,
}
