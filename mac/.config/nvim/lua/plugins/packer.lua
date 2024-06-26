-- Specify the path for Packer
vim.cmd([[packadd packer.nvim]])

return require("packer").startup(function()
	-- Packer settings
	use("wbthomason/packer.nvim") -- Packer can manage itself

	-- Telescope
	use({
		"nvim-telescope/telescope.nvim",
		tag = "0.1.5",
		requires = { { "nvim-lua/plenary.nvim" } },
	})

	use({
		"catppuccin/nvim",
		as = "catppuccin",
	})

	-- Colorscheme
	-- use({
	-- 	"rose-pine/neovim",
	-- 	as = "rose-pine",
	-- })

	-- use({
	-- 	"pineapplegiant/spaceduck",
	-- 	branch = "main",
	-- })

	-- Treesitter
	use("nvim-treesitter/nvim-treesitter", { run = ":TSUpdate" })
	use("nvim-treesitter/playground")

	-- LaTeX
	use("lervag/vimtex")

	-- Tree
	use({
		"nvim-tree/nvim-tree.lua",
		requires = {
			"nvim-tree/nvim-web-devicons", -- optional
		},
	})

	-- Mason and LSP
	use("williamboman/mason.nvim")
	use("williamboman/mason-lspconfig.nvim")
	use("neovim/nvim-lspconfig")
	use("onsails/lspkind-nvim")
	use({
		"rmagatti/goto-preview",
		config = function()
			require("goto-preview").setup({})
		end,
	})

	-- Autocompletion
	use("hrsh7th/nvim-cmp")
	use("hrsh7th/cmp-nvim-lsp")
	use("hrsh7th/cmp-nvim-lua")
	use("hrsh7th/cmp-buffer")
	use("hrsh7th/cmp-path")
	use("hrsh7th/cmp-cmdline")
	use("hrsh7th/cmp-emoji")
	use("windwp/nvim-autopairs")
	use("tpope/vim-surround")
	use("mattn/emmet-vim")
	use("windwp/nvim-ts-autotag")

	-- Formatters
	use("rhysd/vim-clang-format")
	use("mhartington/formatter.nvim")
	use({
		"jose-elias-alvarez/null-ls.nvim",
		requires = { "nvim-lua/plenary.nvim" },
	})

	-- Snippets
	use("L3MON4D3/LuaSnip")
	use("saadparwaiz1/cmp_luasnip")

	-- Commenting
	use("tpope/vim-commentary")
	use("numToStr/Comment.nvim")
	use("danymat/neogen")

	-- Utilities
	use("xiyaowong/transparent.nvim")
	use("voldikss/vim-floaterm")
	use("folke/zen-mode.nvim")
	use("folke/trouble.nvim")

	-- Statuslines
	use({
		"nvim-lualine/lualine.nvim",
		requires = { "nvim-tree/nvim-web-devicons", opt = true },
	})

	-- use({
	-- 	"rebelot/heirline.nvim",
	-- })

	-- Indent
	use("lukas-reineke/indent-blankline.nvim")

	-- Markdown
	use({
		"iamcco/markdown-preview.nvim",
		run = "cd app && npm install",
	})
end)
