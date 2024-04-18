local lspconfig = require("lspconfig")

local function on_attach(client, bufnr)
	local bufopts = { noremap = true, silent = true, buffer = bufnr }

	-- if client.server_capabilities.semanticTokensProvider then
	-- 	-- Disable semantic tokens by setting the provider to nil
	-- 	client.server_capabilities.semanticTokensProvider = nil
	-- end

	if client.name == "tsserver" then
		client.server_capabilities.documentFormattingProvider = false
		client.server_capabilities.documentRangeFormattingProvider = false
	end
	vim.api.nvim_buf_set_keymap(
		bufnr,
		"n",
		"<leader>ca",
		"<cmd>lua vim.lsp.buf.code_action()<CR>",
		{ noremap = true, silent = true }
	)

	vim.keymap.set("n", "<leader>ck", vim.lsp.buf.signature_help, bufopts)
end

lspconfig.pyright.setup({ on_attach = on_attach })
lspconfig.tsserver.setup({ on_attach = on_attach })
lspconfig.lua_ls.setup({ on_attach = on_attach })
lspconfig.cmake.setup({ on_attach = on_attach })
lspconfig.texlab.setup({ on_attach = on_attach })
lspconfig.omnisharp.setup({ on_attach = on_attach })
lspconfig.jdtls.setup({ on_attach = on_attach })

lspconfig.clangd.setup({
	on_attach = on_attach,
	cmd = { "clangd", "--background-index", "--suggest-missing-includes" },
	filetypes = { "c", "cpp" }, -- Specify clangd for C files only
	capabilities = require("cmp_nvim_lsp").default_capabilities(vim.lsp.protocol.make_client_capabilities()),
	root_dir = function(fname)
		return lspconfig.util.root_pattern("compile_commands.json", ".git", ".clangd", "CMakeLists.txt")(fname)
			or vim.fn.getcwd()
	end,
})

-- lspconfig.ccls.setup({
-- 	on_attach = on_attach,
-- 	init_options = {
-- 		-- cache = {
-- 		--     directory = ".ccls-cache";
-- 		-- };
-- 		compilationDatabaseDirectory = "build",
-- 		index = {
-- 			threads = 0,
-- 		},
-- 		clang = {
-- 			resourceDir = "/usr/lib/llvm-18/lib/clang/18",
-- 			excludeArgs = { "-frounding-math" },
-- 			extraArgs = { "-std=c++17" },
-- 		},
-- 	},
-- 	filetypes = { "cpp", "cxx", "cc", "h", "hpp" },
-- 	capabilities = require("cmp_nvim_lsp").default_capabilities(vim.lsp.protocol.make_client_capabilities()),
-- 	root_dir = function(fname)
-- 		return lspconfig.util.root_pattern("compile_commands.json", ".ccls", "CMakeLists.txt", ".git")(fname)
-- 			or vim.fn.getcwd()
-- 	end,
-- })

vim.lsp.handlers["textDocument/publishDiagnostics"] = vim.lsp.with(vim.lsp.diagnostic.on_publish_diagnostics, {
	update_in_insert = false,
})
