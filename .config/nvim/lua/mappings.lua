local map = vim.api.nvim_set_keymap
local default_opts = {noremap = true, silent = true}

map('', '<leader><leader>', '<cmd>Telescope find_files<cr>', default_opts)

-- Easier split navigation
map('n', '<C-J>', '<C-W><C-J>', default_opts)
map('n', '<C-K>', '<C-W><C-K>', default_opts)
map('n', '<C-L>', '<C-W><C-L>', default_opts)
map('n', '<C-H>', '<C-W><C-H>', default_opts)

