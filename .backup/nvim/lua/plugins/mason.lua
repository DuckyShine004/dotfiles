require("mason").setup({
    ensure_installed = { "debugpy", "codelldb" },
    ui = {
        icons = {
            package_installed = "✓",
            package_pending = "➜",
            package_uninstalled = "✗"
        }
    }
})

require("mason-lspconfig").setup({
    ensure_installed = { "pyright", "tsserver", "lua_ls", "rust_analyzer", "clangd"},
    automatic_installation = true,
})

require("mason-nvim-dap").setup({
    ensure_installed = { "python", "codelldb" }
})
