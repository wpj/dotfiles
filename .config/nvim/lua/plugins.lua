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
			require("which-key").setup({})
		end,
	})
	use({
		"glepnir/lspsaga.nvim",
		config = function()
			local nmap = require("utils").nmap
			nmap("gh", ":Lspsaga lsp_finder<cr>")
			nmap("<leader>ca", ":Lspsaga code_action<cr>")
			nmap("gs", ":Lspsaga signature_help<cr>")
			nmap("gr", ":Lspsaga rename<cr>")
			nmap("gD", ":Lspsaga preview_definition<cr>")
			nmap("<leader>cd", ":Lspsaga show_line_diagnostics<cr>")
			nmap("[d", ":Lspsaga diagnostic_jump_prev<cr>")
			nmap("]d", ":Lspsaga diagnostic_jump_next<cr>")
		end,
	})
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

			local nmap = require("utils").nmap
			nmap("K", "<cmd>lua vim.lsp.buf.hover()<cr>")
			nmap("gd", "<cmd>lua vim.lsp.buf.definition()<cr>")
			nmap("g0", "<cmd>lua vim.lsp.buf.document_symbol()<cr>")
			nmap("gf", "<cmd>lua vim.lsp.buf.formatting()<cr>")
		end,
	})
	use({
		"nvim-telescope/telescope.nvim",
		requires = { { "nvim-lua/plenary.nvim" } },
		config = function()
			require("utils").nmap("<leader>/", "<cmd>Telescope live_grep<cr>")
			require("utils").map("", "<leader><leader>", "<cmd>Telescope find_files<cr>")
		end,
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
	use({
		"prettier/vim-prettier",
		run = "yarn install",
		ft = {
			"css",
			"graphql",
			"html",
			"javascript",
			"javascriptreact",
			"json",
			"less",
			"markdown",
			"scss",
			"svelte",
			"typescript",
			"typescriptreact",
			"vue",
			"yaml",
		},
		config = function()
			require("utils").nmap("<leader>cf", ":Prettier<cr>")
		end,
	})
	use("tpope/vim-endwise")
	use({
		"tpope/vim-fugitive",
		config = function()
			require("utils").nmap("<leader>gg", ":Git<cr>")
		end,
	})
	use("tpope/vim-repeat")
	use("tpope/vim-rhubarb")
	use("tpope/vim-unimpaired")
	use("wellle/targets.vim")
end)
