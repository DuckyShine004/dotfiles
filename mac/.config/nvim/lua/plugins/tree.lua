require("nvim-tree").setup({
	git = {
		ignore = false,
	},
	filters = {
		dotfiles = false,
		custom = {},
		exclude = {},
	},
	renderer = {
		indent_markers = {
			enable = true,
			icons = {
				corner = "└",
				edge = "│",
				item = "│",
				bottom = "─",
				none = " ",
			},
		},
	},
})
