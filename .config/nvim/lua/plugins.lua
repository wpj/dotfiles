local cmd = vim.cmd
local exists = vim.fn.exists
local g = vim.g
local fn = vim.fn
local opt = vim.opt
local map = vim.api.nvim_set_keymap

local default_mapping_opts = {noremap = true, silent = true}

local install_path = fn.stdpath('data')..'/site/pack/packer/start/packer.nvim'
if fn.empty(fn.glob(install_path)) > 0 then
  fn.system({
    'git',
    'clone',
    '--depth', '1',
    'https://github.com/wbthomason/packer.nvim',
    install_path,
  })
  cmd 'packadd packer.nvim'
end

require('packer').startup(function()
  use 'wbthomason/packer.nvim'

  use 'airblade/vim-rooter'
  use 'editorconfig/editorconfig-vim'
  use {
    'folke/trouble.nvim',
    requires = 'kyazdani42/nvim-web-devicons',
    config = function()
      require('trouble').setup({})
    end
  }
  use 'folke/tokyonight.nvim'
  use {
    'folke/which-key.nvim',
    config = function()
      require('which-key').setup({})
    end
  }
  use 'glepnir/lspsaga.nvim'
  use {
    'hoob3rt/lualine.nvim',
    requires = {'kyazdani42/nvim-web-devicons', opt = true},
    config = function() 
      require'lualine'.setup {
        options = {
          icons_enabled = true,
          theme = 'seoul256',
        },
      }
    end
  }
  use {
    'hrsh7th/nvim-cmp',
    requires = {
      'hrsh7th/cmp-nvim-lsp',
      'hrsh7th/vim-vsnip',
      'hrsh7th/cmp-buffer',
      'hrsh7th/cmp-nvim-lua',
    },
    config = function()
      local cmp = require('cmp')
      cmp.setup({
        -- auto-select the first completion
        completion = {
          completeopt = 'menu,menuone,noinsert',
        },
        mapping = {
          ['<C-y>'] = cmp.mapping.confirm({
            behavior = cmp.ConfirmBehavior.Replace,
            select = true,
          })
        },
        snippet = {
          expand = function(args)
            vim.fn['vsnip#anonymous'](args.body)
          end,
        },
        sources = {
          { name = 'nvim_lsp' },
          { name = 'nvim_lua' },
        },
      })
    end
  }
  use 'jiangmiao/auto-pairs'
  use 'jremmen/vim-ripgrep'
  use 'junegunn/rainbow_parentheses.vim'
  use 'junegunn/seoul256.vim'
  use 'justinmk/vim-dirvish'
  use {
    'lewis6991/gitsigns.nvim', requires = { 'nvim-lua/plenary.nvim' },
    config = function() require('gitsigns').setup() end
  }
  use 'liuchengxu/vista.vim'
  use 'mattn/emmet-vim'
  use {
    'neovim/nvim-lspconfig',
    config = function()
      local nvim_lsp = require('lspconfig')
      nvim_lsp.rls.setup{}
      -- nvim_lsp.denols.setup{}
      nvim_lsp.tsserver.setup{}


      -- map('n', 'K', ':Lspsaga hover_doc<cr>', default_opts)
      -- map('n', '<C-F>', '<cmd>lua require('lspsaga.action').smart_scroll_with_saga(1)<cr>', default_opts)
      -- map('n', '<C-B>', '<cmd>lua require('lspsaga.action').smart_scroll_with_saga(-1)<cr>', default_opts)

      -- map('n', 'gd', ':Lspsaga preview_definition<cr>', default_opts)
    end
  }
  use {
    'nvim-telescope/telescope.nvim',
    requires = { {'nvim-lua/plenary.nvim'} }
  }
  use {
    'nvim-treesitter/nvim-treesitter',
    run = ':TSUpdate'
  }
  use 'tpope/vim-commentary'
  use 'tpope/vim-endwise'
  use 'tpope/vim-repeat'
  use 'tpope/vim-unimpaired'
  use 'wellle/targets.vim'
end) 

map('n', 'K', '<cmd>lua vim.lsp.buf.hover()<cr>', default_mapping_opts)
map('n', 'gd', '<cmd>lua vim.lsp.buf.definition()<cr>', default_mapping_opts)
map('n', 'g0', '<cmd>lua vim.lsp.buf.document_symbol()<cr>', default_mapping_opts)
map('n', 'gf', '<cmd>lua vim.lsp.buf.formatting()<cr>', default_mapping_opts)

map("n", "gh", ":Lspsaga lsp_finder<cr>", default_mapping_opts)
map("n", "<leader>ca", ":Lspsaga code_action<cr>", default_mapping_opts)
map("n", "gs", ":Lspsaga signature_help<cr>", default_mapping_opts)
map("n", "gr", ":Lspsaga rename<cr>", default_mapping_opts)
map("n", "gD", ":Lspsaga preview_definition<cr>", default_mapping_opts)
map("n", "<leader>cd", ":Lspsaga show_line_diagnostics<cr>", default_mapping_opts)
map("n", "[d", ":Lspsaga diagnostic_jump_prev<cr>", default_mapping_opts)
map("n", "]d", ":Lspsaga diagnostic_jump_next<cr>", default_mapping_opts)
