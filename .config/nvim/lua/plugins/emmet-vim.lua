return {
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
}
