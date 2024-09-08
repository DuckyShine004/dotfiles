local options = {
  close_if_last_window = false, -- do not close neo-tree if it is the last window
  popup_border_style = "rounded",
  enable_git_status = true,
  enable_diagnostics = false, -- This disables diagnostics in neo-tree
  source_selector = {
    winbar = true,
  },
  sources = {
    "filesystem", -- for file explorer
    "buffers", -- for buffer list
    "document_symbols",
    -- "git_status", -- for git changes
  },
  default_component_configs = {
    indent = {
      indent_size = 2,
      padding = 1, -- space between icon and text
      with_markers = true,
      indent_marker = "│",
      last_indent_marker = "└",
      highlight = "NeoTreeIndentMarker",
      with_expanders = nil, -- if nil and file nesting is enabled, will enable expanders
      expander_collapsed = "",
      expander_expanded = "",
      expander_highlight = "NeoTreeExpander",
    },
    icon = {
      folder_closed = "",
      folder_open = "",
      folder_empty = "",
      folder_empty_open = "",
      default = "󰈚",
      highlight = "NeoTreeFileIcon",
    },
    git_status = {
      symbols = { -- change these to the icons you like
        added = "✓",
        modifed = "",
        deleted = "",
        renamed = "➜",
        untracked = "★",
        ignored = "◌",
        unstaged = "✗",
        staged = "✓",
        conflict = "",
      },
    },
  },
  window = {
    width = 30,
    -- mappings = {
    --   ["<CR>"] = "open",
    --   ["S"] = "open_split",
    --   ["s"] = "open_vsplit",
    --   ["C"] = "close_node",
    --   ["<BS>"] = "navigate_up",
    --   ["."] = "set_root",
    -- },
  },
  filesystem = {
    filtered_items = {
      visible = false, -- hide dotfiles
      hide_dotfiles = false,
      hide_gitignored = false,
      hide_by_name = {
        "node_modules",
      },
    },
    follow_current_file = {
      enabled = true,
    },
    use_libuv_file_watcher = true,
    filsystem_watchers = {
      enabled = true,
      debounce_delay = 50,
    },
  },
  git_status = {
    window = {
      position = "float",
    },
  },
}

return options
