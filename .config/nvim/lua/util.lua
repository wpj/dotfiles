local M = {}

M.map = function(keys, action, opts)
    vim.keymap.set(opts.mode or "n", keys, action, { desc = opts.desc })
end

return M
