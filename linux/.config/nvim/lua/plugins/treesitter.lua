require("nvim-treesitter.configs").setup({
	ensure_installed = { "cpp", "python", "c", "lua", "vim", "vimdoc", "query" },
	sync_install = false,
	auto_install = true,
	auto_tag = true,
	highlight = {
		enable = true,
		additional_vim_regex_highlighting = false,
	},
})
