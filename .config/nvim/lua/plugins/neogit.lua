return {
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
}
