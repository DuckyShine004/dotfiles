local options = {
  formatters_by_ft = {
    lua = { "stylua" },
    python = { "black" },
    -- css = { "prettier" },
    -- html = { "prettier" },
    sql = { "sql_formatter" },
    mysql = { "sql_formatter" },
    cpp = { "clang_format" },
    sh = { "shfmt" },
    zsh = { "shfmt" },
    tex = { "latexindent" },
  },

  format_on_save = {
    timeout_ms = 500,
    lsp_fallback = true,
  },
}

return options
