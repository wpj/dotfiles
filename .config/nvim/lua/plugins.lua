-- NOTE: Because packer precompiles config/setup functions, variables must be
-- declared within the scope of those functions.

local install_path = vim.fn.stdpath("data") .. "/site/pack/packer/start/packer.nvim"
if vim.fn.empty(vim.fn.glob(install_path)) > 0 then
	vim.fn.system({
		"git",
		"clone",
		"--depth",
		"1",
		"https://github.com/wbthomason/packer.nvim",
		install_path,
	})
	vim.cmd("packadd packer.nvim")
end

require("packer").startup(function()
	use("wbthomason/packer.nvim")

	use("airblade/vim-rooter")

	use({
		"b3nj5m1n/kommentary",
		config = function()
			local kommentary_config = require("kommentary.config")

			kommentary_config.configure_language("rust", {
				prefer_single_line_comments = true,
			})

			kommentary_config.configure_language("less", {
				prefer_multi_line_comments = true,
			})

			local update_commentstring = require("ts_context_commentstring.internal").update_commentstring

			local update_commentstring_languages = {
				"html",
				"javascriptreact",
				"svelte",
				"typescriptreact",
				"vue",
			}
			for _, lang in ipairs(update_commentstring_languages) do
				-- See https://github.com/JoosepAlviste/nvim-ts-context-commentstring/blob/88343753dbe81c227a1c1fd2c8d764afb8d36269/README.md#kommentary.
				kommentary_config.configure_language(lang, {
					single_line_comment_string = "auto",
					multi_line_comment_strings = "auto",
					hook_function = update_commentstring,
				})
			end
		end,
	})

	use("editorconfig/editorconfig-vim")
	use({
		"folke/trouble.nvim",
		requires = "kyazdani42/nvim-web-devicons",
		config = function()
			require("trouble").setup({})
		end,
	})
	use("folke/tokyonight.nvim")
	use({
		"folke/which-key.nvim",
		config = function()
			local wk = require("which-key")

			wk.setup({})

			wk.register({
				c = {
					name = "code",

          d = { "<cmd>lua vim.lsp.buf.definition()<cr>", "Go to definition" },
          
					-- glepnir/lspsaga.nvim
					a = { "<cmd> Lspsaga code_action<cr>", "Code actions" },
					D = { "<cmd> Lspsaga preview_definition<cr>", "Preview definition" },
					e = { "<cmd> Lspsaga show_line_diagnostics<cr>", "Show line diagnostics" },
          h = { "<cmd> Lspsaga lsp_finder<cr>", "Find references" },
					r = { "<cmd> Lspsaga rename<cr>", "Rename" },
					s = { "<cmd> Lspsaga signature_help<cr>", "Show signature" },

					-- mhartington/formatter.nvim
					f = { "<cmd> Format<cr>", "Format code" },
				},

				-- nvim-telescope/telescope.nvim
				["/"] = { "<cmd>Telescope live_grep<cr>", "Search project files" },
				["<leader>"] = { "<cmd>Telescope find_files<cr>", "Find file in project" },

        -- tpope/vim-fugitive
        g = {
          name = "git",
          g = { "<cmd> Git<cr>", "Git" },
        }
			}, { prefix = "<leader>" })

			-- glepnir/lspsaga.nvim
			wk.register({
				["[d"] = { "<cmd> Lspsaga diagnostic_jump_prev<cr>", "Previous diagnostic" },
				["]d"] = { "<cmd> Lspsaga diagnostic_jump_next<cr>", "Next diagnostic" },
			})
		end,
	})
	use("glepnir/lspsaga.nvim")
	use({
		"hoob3rt/lualine.nvim",
		requires = { "kyazdani42/nvim-web-devicons", opt = true },
		config = function()
			require("lualine").setup({
				options = {
					icons_enabled = true,
					theme = "seoul256",
				},
			})
		end,
	})
	use({
		"hrsh7th/nvim-cmp",
		requires = {
			"hrsh7th/cmp-nvim-lsp",
			"hrsh7th/vim-vsnip",
			"hrsh7th/cmp-buffer",
			"hrsh7th/cmp-nvim-lua",
		},
		config = function()
			local cmp = require("cmp")
			cmp.setup({
				-- auto-select the first completion
				completion = {
					completeopt = "menu,menuone,noinsert",
				},
				mapping = cmp.mapping.preset.insert({
					["<C-b>"] = cmp.mapping.scroll_docs(-4),
					["<C-f>"] = cmp.mapping.scroll_docs(4),
					["<C-Space>"] = cmp.mapping.complete(),
					["<C-e>"] = cmp.mapping.abort(),
					["<C-y>"] = cmp.mapping.confirm({ select = true }),
				}),
				snippet = {
					expand = function(args)
						vim.fn["vsnip#anonymous"](args.body)
					end,
				},
				sources = cmp.config.sources({
					{ name = "nvim_lsp" },
					{ name = "vsnip" },
				}, {
					{ name = "buffer" },
				}),
			})
		end,
	})
	use("jiangmiao/auto-pairs")
	use("JoosepAlviste/nvim-ts-context-commentstring")
	use({
		"jose-elias-alvarez/null-ls.nvim",
		config = function()
			require("null-ls").setup({
				sources = {
					require("null-ls").builtins.diagnostics.eslint,
				},
			})
		end,
	})
	use("jremmen/vim-ripgrep")
	use("junegunn/rainbow_parentheses.vim")
	use("junegunn/seoul256.vim")
	use("justinmk/vim-dirvish")
	use({
		"lewis6991/gitsigns.nvim",
		requires = { "nvim-lua/plenary.nvim" },
		config = function()
			require("gitsigns").setup()
		end,
	})
	use("liuchengxu/vista.vim")
	use("mattn/emmet-vim")
	use({
		"mhartington/formatter.nvim",
		config = function()
			local prettier = require("formatter.filetypes.javascript").prettier
			local prettiereslint = require("formatter.filetypes.javascript").prettiereslint

			local js_formatter
			if vim.env.NVIM_USE_PRETTIER_ESLINT ~= nil then
				js_formatter = require("formatter.filetypes.javascript").prettiereslint
			else
				js_formatter = require("formatter.filetypes.javascript").prettier
			end

			require("formatter").setup({
				filetype = {
					css = { prettier },
					html = { prettier },
					javascript = { js_formatter },
					javascriptreact = { js_formatter },
					json = { prettier },
					less = { prettier },
					lua = { require("formatter.filetypes.lua").stylua },
					markdown = { prettier },
					scss = { prettier },
					svelte = { prettier },
					typescript = { js_formatter },
					typescriptreact = { js_formatter },
					vue = { js_formatter },
					yaml = { prettier },
				},
			})
		end,
	})
	use({
		"neovim/nvim-lspconfig",
		config = function()
			local nvim_lsp = require("lspconfig")

			local enabled_servers = {
				"rls",
				"tsserver",
				"svelte",
				"vuels",
				"gopls",
			}

			for _, server in ipairs(enabled_servers) do
				nvim_lsp[server].setup({})
			end
		end,
	})
	use({
		"nvim-telescope/telescope.nvim",
		requires = { { "nvim-lua/plenary.nvim" } },
	})
	use({
		"nvim-treesitter/nvim-treesitter",
		run = ":TSUpdate",
		config = function()
			require("nvim-treesitter.configs").setup({
				context_commentstring = {
					enable = true,
					enable_autocmd = false,
				},
				ensure_installed = {
					"bash",
					"css",
					"fish",
					"go",
					"graphql",
					"html",
					"javascript",
					"json",
					"lua",
					"markdown",
					"python",
					"rust",
					"scss",
					"svelte",
					"toml",
					"tsx",
					"typescript",
					"vue",
					"yaml",
				},
				highlight = {
					enable = true,
				},
			})
		end,
	})
	use("tpope/vim-endwise")
	use("tpope/vim-fugitive")
	use("tpope/vim-repeat")
	use("tpope/vim-rhubarb")
	use("tpope/vim-unimpaired")
	use("wellle/targets.vim")
end)
