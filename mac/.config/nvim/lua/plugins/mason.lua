require("mason").setup({
	ensure_installed = { "debugpy", "codelldb" },
	ui = {
		icons = {
			package_installed = "✓",
			package_pending = "➜",
			package_uninstalled = "✗",
		},
	},
})

require("mason-lspconfig").setup({
	ensure_installed = { "pyright", "texlab", "tsserver", "lua_ls", "rust_analyzer", "clangd" },
	automatic_installation = true,
})
