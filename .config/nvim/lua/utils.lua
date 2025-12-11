local M = {}

M.run_after_minifiles_close = function(fn)
    require("mini.files").close()
    fn()
end

M.nmap = function(lhs, rhs, opts)
    vim.keymap.set("n", lhs, rhs, opts)
end

return M
