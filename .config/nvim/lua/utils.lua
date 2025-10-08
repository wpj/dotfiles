local M = {}

M.run_after_minifiles_close = function(fn)
    require("mini.files").close()
    fn()
end

return M
