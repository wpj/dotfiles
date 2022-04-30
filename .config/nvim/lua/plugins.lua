-- NOTE: Because packer precompiles config/setup functions, variables must be
-- declared within the scope of those functions.

local install_path = vim.fn.stdpath('data')..'/site/pack/packer/start/packer.nvim'
if vim.fn.empty(vim.fn.glob(install_path)) > 0 then
  vim.fn.system({
    'git',
    'clone',
    '--depth', '1',
    'https://github.com/wbthomason/packer.nvim',
    install_path,
  })
  vim.cmd 'packadd packer.nvim'
end

require('packer').startup(function()
  use 'wbthomason/packer.nvim'

  use 'airblade/vim-rooter'

  use {
    'b3nj5m1n/kommentary',
    config = function()
      require('kommentary.config').configure_language('rust', {
          prefer_single_line_comments = true,
      })
    end
  }

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
  use {
    'glepnir/lspsaga.nvim',
    config = function()
      local nmap = require('utils').nmap
      nmap("gh", ":Lspsaga lsp_finder<cr>")
      nmap("<leader>ca", ":Lspsaga code_action<cr>")
      nmap("gs", ":Lspsaga signature_help<cr>")
      nmap("gr", ":Lspsaga rename<cr>")
      nmap("gD", ":Lspsaga preview_definition<cr>")
      nmap("<leader>cd", ":Lspsaga show_line_diagnostics<cr>")
      nmap("[d", ":Lspsaga diagnostic_jump_prev<cr>")
      nmap("]d", ":Lspsaga diagnostic_jump_next<cr>")
    end
  }
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

      local enabled_servers = {
        'rls',
        'tsserver',
        'svelte',
        'vuels',
        'gopls'
      }

      for _, server in ipairs(enabled_servers) do
        nvim_lsp[server].setup{}
      end

      local nmap = require('utils').nmap
      nmap('K', '<cmd>lua vim.lsp.buf.hover()<cr>')
      nmap('gd', '<cmd>lua vim.lsp.buf.definition()<cr>')
      nmap('g0', '<cmd>lua vim.lsp.buf.document_symbol()<cr>')
      nmap('gf', '<cmd>lua vim.lsp.buf.formatting()<cr>')
    end
  }
  use {
    'nvim-telescope/telescope.nvim',
    requires = { {'nvim-lua/plenary.nvim'} },
    config = function()
      require('utils').nmap('<leader>/', '<cmd>Telescope live_grep<cr>')
      require('utils').map('', '<leader><leader>', '<cmd>Telescope find_files<cr>')
    end
  }
  use {
    'nvim-treesitter/nvim-treesitter',
    run = ':TSUpdate',
    config = function()
      require'nvim-treesitter.configs'.setup {
        ensure_installed = {
          'bash',
          'css',
          'fish',
          'go',
          'graphql',
          'html',
          'javascript',
          'json',
          'lua',
          'markdown',
          'python',
          'rust',
          'scss',
          'svelte',
          'toml',
          'tsx',
          'typescript',
          'vue',
          'yaml',
        },
        highlight = {
          enable = true,
        },
      }
    end,
  }
  use {
    'prettier/vim-prettier',
    run = 'yarn install',
    ft = {'javascript',  'javascriptreact', 'typescript', 'typescriptreact', 'css', 'less', 'scss', 'json', 'graphql', 'markdown', 'vue', 'svelte', 'yaml', 'html'},
    config = function()
      require('utils').nmap('<leader>cf', ':Prettier<cr>')
    end
  }
  use 'tpope/vim-endwise'
  use {
    'tpope/vim-fugitive',
    config = function()
      require('utils').nmap('<leader>gg', ':Git<cr>')
    end
  }
  use 'tpope/vim-repeat'
  use 'tpope/vim-unimpaired'
  use 'wellle/targets.vim'
end) 
