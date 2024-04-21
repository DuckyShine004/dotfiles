local null_ls = require "null-ls"

local opts = {
  sources = {
    null_ls.builtins.diagnostics.pylint.with {
      extra_args = { "--max-line-length", "130" },
    },
  },
}

return opts
