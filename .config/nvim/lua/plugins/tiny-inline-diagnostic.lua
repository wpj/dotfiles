return {
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
}
