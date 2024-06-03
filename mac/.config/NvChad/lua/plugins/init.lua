return {
  {
    "stevearc/conform.nvim",
    -- event = 'BufWritePre', -- uncomment for format on save
    config = function()
      require "configs.conform"
    end,
  },

  {
    "tpope/vim-dadbod",
  },

  {
    "kristijanhusak/vim-dadbod-ui",
    init = function()
      return require "configs.ui.dadbodui"
    end,
  },

  {
    "kristijanhusak/vim-dadbod-completion",
  },

  {
    "folke/trouble.nvim",
    dependencies = { "nvim-tree/nvim-web-devicons" },
  },

  {
    "gelguy/wilder.nvim",
    config = function()
      return require "configs.ui.wilder"
    end,
  },

  {
    "roxma/nvim-yarp",
  },

  {
    "roxma/vim-hug-neovim-rpc",
  },

  {
    "nvimdev/dashboard-nvim",
    event = "VimEnter",
    config = function()
      require "configs.ui.dashboard"
    end,
    dependencies = { { "nvim-tree/nvim-web-devicons" } },
  },

  {
    "jose-elias-alvarez/null-ls.nvim",
    ft = { "python" },
    opts = function()
      return require "configs.lsp.null-ls"
    end,
  },

  {
    "mfussenegger/nvim-jdtls",
  },

  {
    "neovim/nvim-lspconfig",
    config = function()
      require("nvchad.configs.lspconfig").defaults()
      require "configs.lsp.lspconfig"
    end,
  },

  {
    "hrsh7th/cmp-cmdline",
    config = function()
      require "nvchad.configs.lspconfig"
    end,
  },

  {
    "williamboman/mason.nvim",
    opts = {
      ensure_installed = {
        "lua-language-server",
        "stylua",
        "html-lsp",
        "css-lsp",
        "prettier",
      },
    },
  },

  {
    "nvim-treesitter/nvim-treesitter",
    opts = {
      ensure_installed = {
        "vim",
        "lua",
        "vimdoc",
        "html",
        "css",
      },
    },
  },
}
