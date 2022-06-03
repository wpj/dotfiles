local M = {}

local map = function(mode, key, cmd)
	return vim.api.nvim_set_keymap(mode, key, cmd, { silent = true, noremap = true })
end

M.map = map

M.nmap = function(key, cmd)
	return map("n", key, cmd)
end

return M
