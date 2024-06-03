local on_attach = require("nvchad.configs.lspconfig").on_attach
local on_init = require("nvchad.configs.lspconfig").on_init
local capabilities = require("nvchad.configs.lspconfig").capabilities

local lspconfig = require "lspconfig"

lspconfig.pyright.setup {
  on_init = on_init,
  on_attach = on_attach,
  capabilities = capabilities,
  filetypes = { "python" },
}

-- lspconfig.sqls.setup {
--   on_init = on_init,
--   on_attach = on_attach,
--   capabilities = capabilities,
-- }

lspconfig.clangd.setup {
  on_init = on_init,
  on_attach = function(client, bufnr)
    client.server_capabilities.signatureHelpProvider = false
    on_attach(client, bufnr)
  end,
  capabilities = capabilities,
}
