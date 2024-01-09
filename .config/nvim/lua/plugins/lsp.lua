local lspconfig = require('lspconfig')

lspconfig.pyright.setup{}
lspconfig.tsserver.setup{}
lspconfig.lua_ls.setup{}

lspconfig.clangd.setup({
    on_attach = function(client, bufnr)
    end,
    flags = {
        debounce_text_changes = 150,
    }
})

vim.lsp.handlers["textDocument/publishDiagnostics"] = vim.lsp.with(
  vim.lsp.diagnostic.on_publish_diagnostics, {
    -- Keep diagnostics visible while in insert mode
    update_in_insert = true,
  }
)
