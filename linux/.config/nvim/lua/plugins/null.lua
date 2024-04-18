local null_ls = require("null-ls")
local augroup = vim.api.nvim_create_augroup("LspFormatting", {})

null_ls.setup({
	sources = {
		-- Python
		null_ls.builtins.diagnostics.pylint.with({
			extra_args = { "--max-line-length", "110" }, -- Example: customizing Pylint with extra arguments
		}),

		-- Web development
		null_ls.builtins.formatting.prettier.with({
			filetypes = { "javascript", "javascriptreact" },
		}),

		-- Java
		null_ls.builtins.formatting.google_java_format,
	},

	on_attach = function(client, bufnr)
		if client.supports_method("textDocument/formatting") then
			vim.api.nvim_clear_autocmds({ group = augroup, buffer = bufnr })
			vim.api.nvim_create_autocmd("BufWritePre", {
				group = augroup,
				buffer = bufnr,
				callback = function()
					vim.lsp.buf.format()
				end,
			})
		end
	end,
})
