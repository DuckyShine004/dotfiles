return {
  {
    "nvim-lua/plenary.nvim",
  },

  {
    "xiyaowong/transparent.nvim",
  },

  {
    "vhyrro/luarocks.nvim",
    priority = 9999, -- Very high priority is required, luarocks.nvim should run as the first plugin in your config.
    config = true,
  },

  {
    "nvim-neorg/neorg",
    dependencies = { "luarocks.nvim" },
    lazy = false, -- Disable lazy loading as some `lazy.nvim` distributions set `lazy = true` by default
    version = "*", -- Pin Neorg to the latest stable release
    opts = function()
      return require "configs.neorg"
    end,
    config = true,
  },

  {
    "goolord/alpha-nvim",
    event = "VimEnter",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    config = function()
      require "configs.ui.dashboard.alpha"
    end,
  },

  {
    "folke/trouble.nvim",
    opts = function()
      return require "configs.ui.trouble"
    end,
  },

  {
    "voldikss/vim-floaterm",
  },

  {
    "akinsho/toggleterm.nvim",
    version = "*",
    -- config = function()
    --   require "configs.ui.toggleterm"
    -- end,
    config = true,
  },

  {
    "iamcco/markdown-preview.nvim",
    cmd = { "MarkdownPreviewToggle", "MarkdownPreview", "MarkdownPreviewStop" },
    build = "cd app && yarn install",
    init = function()
      vim.g.mkdp_filetypes = { "markdown" }
    end,
    ft = { "markdown" },
  },

  {
    "lervag/vimtex",
    lazy = false, -- we don't want to lazy load VimTeX
    init = function()
      vim.g.vimtex_view_method = "skim"
      vim.g.vimtex_compiler_method = "latexmk"
      vim.g.vimtex_quickfix_mode = 0
      vim.g.vimtex_compiler_latexmk = {
        continuous = 1,
        callback = 1,
        build_dir = "",
        background = 1,
        view = 1,
        hooks = {},
      }
    end,
  },

  {
    "nvim-tree/nvim-tree.lua",
    event = "UiEnter",
    priority = 1000,
    dependencies = { "nvim-tree/nvim-web-devicons" },
    opts = function()
      return require "configs.ui.nvimtree"
    end,
    config = function(_, opts)
      require("nvim-tree").setup(opts)
    end,
  },

  {
    "jose-elias-alvarez/null-ls.nvim",
    ft = { "python" },
    opts = function()
      return require "configs.lsp.null-ls"
    end,
  },

  {
    "tpope/vim-dadbod",
  },

  {
    "kristijanhusak/vim-dadbod-ui",
    -- init = function()
    --   return require "configs.ui.dadbodui"
    -- end,
  },

  {
    "kristijanhusak/vim-dadbod-completion",
  },

  {
    "stevearc/conform.nvim",
    opts = require "configs.lsp.conform",
    config = function(_, opts)
      require("conform").setup(opts)
    end,
  },

  {
    "ellisonleao/gruvbox.nvim",
    -- event = "UiEnter",
    priority = 1000,
    name = "gruvbox",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    config = function()
      require "themes.gruvbox"
    end,
  },

  -- Could not get this plugin to work
  -- {
  --   "rebelot/heirline.nvim",
  --   opts = function()
  --     return require "configs.ui.statuslines.heirline"
  --   end,
  --   config = function(_, opts)
  --     require("heirline").setup(opts)
  --   end,
  -- },
  {
    "norcalli/nvim-colorizer.lua",
    config = function()
      require("colorizer").setup()
    end,
  },

  {
    "nvim-lualine/lualine.nvim",
    event = "UiEnter",
    priority = 999,
    dependencies = { "nvim-tree/nvim-web-devicons" },
    config = function()
      require "configs.ui.statuslines.lualine"
    end,
  },

  {
    "nvimdev/lspsaga.nvim",
    config = function()
      require "configs.ui.saga"
    end,
    dependencies = {
      "nvim-treesitter/nvim-treesitter",
      "nvim-tree/nvim-web-devicons",
    },
  },

  {
    "williamboman/mason-lspconfig.nvim",
  },

  {
    "neovim/nvim-lspconfig",
    event = "User FilePost",
    config = function()
      require "configs.lsp.lspconfig"
    end,
  },

  -- load luasnips + cmp related in insert mode only
  {
    "hrsh7th/nvim-cmp",
    event = "InsertEnter",
    dependencies = {
      -- lsp
      {
        "onsails/lspkind-nvim",
      },

      {
        -- snippet plugin
        "L3MON4D3/LuaSnip",
        dependencies = "rafamadriz/friendly-snippets",
        opts = { history = true, updateevents = "TextChanged,TextChangedI" },
        config = function(_, opts)
          require("luasnip").config.set_config(opts)
          require "configs.lsp.luasnip"
        end,
      },

      -- autopairing of (){}[] etc
      {
        "windwp/nvim-autopairs",
        opts = {
          fast_wrap = {},
          disable_filetype = { "TelescopePrompt", "vim" },
        },
        config = function(_, opts)
          require("nvim-autopairs").setup(opts)

          -- setup cmp for autopairs
          local cmp_autopairs = require "nvim-autopairs.completion.cmp"
          require("cmp").event:on("confirm_done", cmp_autopairs.on_confirm_done())
        end,
      },

      -- cmdline
      {
        "hrsh7th/cmp-cmdline",
      },

      -- cmp sources plugins
      {
        "saadparwaiz1/cmp_luasnip",
        "hrsh7th/cmp-nvim-lua",
        "hrsh7th/cmp-nvim-lsp",
        "hrsh7th/cmp-buffer",
        "hrsh7th/cmp-path",
      },
    },
    opts = function()
      return require "configs.lsp.cmp"
    end,
    config = function(_, opts)
      require("cmp").setup(opts)
    end,
  },

  {
    "tpope/vim-commentary",
  },

  {
    "williamboman/mason.nvim",
    opts = function()
      return require "configs.ui.mason"
    end,
    config = function(_, opts)
      require("mason").setup(opts)

      vim.api.nvim_create_user_command("MasonInstallAll", function()
        if opts.ensure_installed and #opts.ensure_installed > 0 then
          vim.cmd("MasonInstall " .. table.concat(opts.ensure_installed, " "))
        end
      end, {})
    end,
  },

  {
    "nvim-treesitter/nvim-treesitter",
    event = { "BufReadPost", "BufNewFile" },
    cmd = { "TSInstall", "TSBufEnable", "TSBufDisable", "TSModuleInfo" },
    build = ":TSUpdate",
    opts = function()
      return require "configs.lsp.treesitter"
    end,
    config = function(_, opts)
      require("nvim-treesitter.configs").setup(opts)
    end,
  },

  {
    "lukas-reineke/indent-blankline.nvim",
    event = "User FilePost",

    config = function()
      require "configs.ui.indent"
    end,
  },

  {
    "nvim-telescope/telescope.nvim",
    dependencies = { "nvim-treesitter/nvim-treesitter" },
    cmd = "Telescope",
    opts = function()
      return require "configs.ui.telescope"
    end,
    config = function(_, opts)
      local telescope = require "telescope"
      telescope.setup(opts)
    end,
  },
}
