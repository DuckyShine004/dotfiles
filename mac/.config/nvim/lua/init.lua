-- Settings
vim.opt.fillchars = { eob = " " }

-- Themes
require("themes/catppuccin")

-- Plugins
require("plugins/packer")
require("plugins/mason")
require("plugins/lsp")
require("plugins/cmp")
require("plugins/preview")
require("plugins/treesitter")
require("plugins/autotag")
require("plugins/null")
require("plugins/formatter")
require("plugins/emmet")
require("plugins/tree")
require("plugins/lualine")
require("plugins/telescope")
require("plugins/pair")
require("plugins/docs")
require("plugins/transparent")
require("plugins/indent")

-- Utilities
require("utilities/animate")
