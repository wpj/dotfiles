return {
    "folke/flash.nvim",
    ---@type Flash.Config
    opts = {},
        -- stylua: ignore
        keys = {
            { "<cr>", mode = { "n", "x", "o" }, function() require("flash").jump() end, desc = "Flash" },
            { "<c-s>", mode = { "c" }, function() require("flash").toggle() end, desc = "Toggle Flash search" },
        },
}
