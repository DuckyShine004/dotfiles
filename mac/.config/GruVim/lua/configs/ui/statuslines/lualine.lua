local status, lualine = pcall(require, "lualine")
local gruvbox = require "lualine.themes.gruvbox"

if not status then
  return
end

local hide_in_width = function()
  return vim.fn.winwidth(0) > 80
end

local function get_filename()
  local filename = vim.fn.expand "%:t"

  if string.find(filename, "zsh") then
    return "zsh"
  end

  return filename
end

local function get_root()
  local path = vim.fn.getcwd()
  local segments = {}

  for segment in string.gmatch(path, "[^/]+") do
    table.insert(segments, segment)
  end

  return segments[#segments] or "Root"
end

local function get_filename_icon()
  local filename = get_filename()

  if filename == "" or filename == nil then
    return "", ""
  end

  local extension = vim.fn.expand "%:e"
  local icon, icon_color = require("nvim-web-devicons").get_icon_color(filename, extension)

  if not icon == nil then
    return icon, icon_color
  end

  return "", "#ebdbb2"
end

local mode_colors = {
  n = { fg = "#fb4934", bg = "#3c3836", gui = "bold" },
  i = { fg = "#b8bb26", bg = "#3c3836", gui = "bold" },
  v = { fg = "#fe8019", bg = "#3c3836", gui = "bold" },
  [""] = { fg = "#fe8019", bg = "#3c3836", gui = "bold" },
  V = { fg = "#fe8019", bg = "#3c3836", gui = "bold" },
  c = { fg = "#d3869b", bg = "#3c3836", gui = "bold" },
  T = { fg = "#fb4934", bg = "#3c3836", gui = "bold" },
  t = { fg = "#fb4934", bg = "#3c3836", gui = "bold" },
}

gruvbox.normal.c.bg = "NONE"
gruvbox.visual.c.bg = "NONE"
gruvbox.insert.c.bg = "NONE"
gruvbox.command.c.bg = "NONE"

local diff = {
  "diff",
  colored = false,
  symbols = { added = " ", modified = " ", removed = " " }, -- changes diff symbols
  cond = hide_in_width,
}

local mode = {
  "mode",
  separator = { left = "", right = " " },

  fmt = function(str)
    -- return " " .. " " .. string.sub(str, 1, 1)
    -- True evil mode
    return " " .. " " .. string.sub(str, 1, 1)
  end,

  color = function()
    local m = vim.fn.mode()
    if mode_colors[m] then
      return mode_colors[m]
    else
      return { fg = "#ffffff", bg = "#000000", gui = "bold" }
    end
  end,

  padding = { left = 0, right = 0 },
}

local filetype = {
  get_filename_icon,

  color = function()
    local _, icon_color = get_filename_icon()
    return { fg = icon_color, bg = "NONE" }
  end,

  file_status = true,
  path = 0,
  padding = { left = 0, right = 1 },
}

local filename = {
  get_filename,
  color = { bg = "NONE" },
  padding = { left = 0, right = 1 },
}

local branch = {
  "branch",
  icons_enabled = true,
  icon = "",
  color = { bg = "NONE", fg = "#fabd2f" },
  padding = { 0, 1 },
}

local root = {
  get_root,
  padding = { left = 1, right = 1 },
  color = { bg = "#1d2021", fg = "#ebdbb2" },
}

local location = {
  "location",
  left_padding = 2,
  separator = { left = "" },
}

local diagnostic = {
  "diagnostics",
  sources = { "nvim_diagnostic" },
  symbols = {
    error = " ",
    warn = " ",
    info = " ",
    hint = " ",
  },
  color = { bg = "NONE" },
  always_visible = false,
}

local directory_icon = {
  function()
    return " "
  end,
  separator = { left = "" },
  color = { bg = "#fb4934", fg = "#1d2021", gui = "bold" },
  padding = { left = 0.5 },
}

local text_icon = {
  function()
    return " "
  end,
  separator = { left = "" },
  color = { bg = "#b8bb26", fg = "#1d2021", gui = "bold" },
  padding = { left = 0.5 },
}

local progress = {
  function()
    return "%p %%"
  end,
  color = { bg = "#1d2021", fg = "#b8bb26" },
}

lualine.setup {
  options = {
    icons_enabled = true,
    theme = gruvbox,
    component_separators = { left = "", right = "" },
    section_separators = { left = "", right = "" },
    disabled_filetypes = {
      statusline = {},
      winbar = {},
    },
    ignore_focus = {},
    always_divide_middle = true,
    globalstatus = true,
    refresh = {
      statusline = 1000,
      tabline = 1000,
      winbar = 1000,
    },
  },
  sections = {
    lualine_a = { mode },
    lualine_b = { filetype, filename, branch },
    lualine_c = { diff },
    lualine_x = { diagnostic },
    lualine_y = { directory_icon, root, text_icon, progress },
    lualine_z = {},
  },
  inactive_sections = {
    lualine_a = { mode },
    lualine_b = {},
    lualine_c = { filename },
    lualine_x = { location },
    lualine_y = {},
    lualine_z = {},
  },
  tabline = {},
  winbar = {},
  inactive_winbar = {},
  extensions = {},
}
