return {
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
}
