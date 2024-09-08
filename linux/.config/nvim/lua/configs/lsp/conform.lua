local options = {
  formatters_by_ft = {
    lua = { "stylua" },
    python = { "black" },
    css = { "prettier" },
    -- html = { "prettier" },
    java = { "google_java_formatter" },
    sql = { "sql_formatter" },
    mysql = { "sql_formatter" },
    cpp = { "clang_format" },
    sh = { "shfmt" },
    zsh = { "shfmt" },
    tex = { "latexindent" },
    json = { "prettier" },
    javascript = { "prettier" },
    typescript = { "prettier" },
    typescriptreact = { "prettier" },
  },

  format_on_save = {
    timeout_ms = 500,
    lsp_fallback = true,
  },
}

return options
