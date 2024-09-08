local utils = require "heirline.utils"
local conditions = require "heirline.conditions"

local colors = {
  bright_bg = utils.get_highlight("Folded").bg,
  bright_fg = utils.get_highlight("Folded").fg,
  red = utils.get_highlight("DiagnosticError").fg,
  dark_red = utils.get_highlight("DiffDelete").bg,
  green = utils.get_highlight("String").fg,
  blue = utils.get_highlight("Function").fg,
  gray = utils.get_highlight("NonText").fg,
  orange = utils.get_highlight("Constant").fg,
  purple = utils.get_highlight("Statement").fg,
  cyan = utils.get_highlight("Special").fg,
  diag_warn = utils.get_highlight("DiagnosticWarn").fg,
  diag_error = utils.get_highlight("DiagnosticError").fg,
  diag_hint = utils.get_highlight("DiagnosticHint").fg,
  diag_info = utils.get_highlight("DiagnosticInfo").fg,
  git_del = utils.get_highlight("diffDeleted").fg,
  git_add = utils.get_highlight("diffAdded").fg,
  git_change = utils.get_highlight("diffChanged").fg,
}

local ViMode = {
  init = function(self)
    self.mode = vim.fn.mode(1) -- :h mode()
  end,
  static = {
    mode_names = { -- change the strings if you like it vvvvverbose!
      n = "N",
      no = "N?",
      nov = "N?",
      noV = "N?",
      ["no\22"] = "N?",
      niI = "Ni",
      niR = "Nr",
      niV = "Nv",
      nt = "Nt",
      v = "V",
      vs = "Vs",
      V = "V_",
      Vs = "Vs",
      ["\22"] = "^V",
      ["\22s"] = "^V",
      s = "S",
      S = "S_",
      ["\19"] = "^S",
      i = "I",
      ic = "Ic",
      ix = "Ix",
      R = "R",
      Rc = "Rc",
      Rx = "Rx",
      Rv = "Rv",
      Rvc = "Rv",
      Rvx = "Rv",
      c = "C",
      cv = "Ex",
      r = "...",
      rm = "M",
      ["r?"] = "?",
      ["!"] = "!",
      t = "T",
    },
    mode_colors = {
      n = "red",
      i = "green",
      v = "cyan",
      V = "cyan",
      ["\22"] = "cyan",
      c = "orange",
      s = "purple",
      S = "purple",
      ["\19"] = "purple",
      R = "orange",
      r = "orange",
      ["!"] = "red",
      t = "red",
    },
  },
  provider = function(self)
    return " %2(" .. self.mode_names[self.mode] .. "%)"
  end,
  hl = function(self)
    local mode = self.mode:sub(1, 1)
    return { fg = self.mode_colors[mode], bold = true }
  end,
  update = {
    "ModeChanged",
    pattern = "*:*",
    callback = vim.schedule_wrap(function()
      vim.cmd "redrawstatus"
    end),
  },
}

local WorkDir = {
  init = function(self)
    self.icon = (vim.fn.haslocaldir(0) == 1 and "l" or "g") .. " " .. " "
    local cwd = vim.fn.getcwd(0)
    self.cwd = vim.fn.fnamemodify(cwd, ":~")
  end,
  hl = { fg = "blue", bold = true },

  flexible = 1,

  {
    provider = function(self)
      local trail = self.cwd:sub(-1) == "/" and "" or "/"
      return self.icon .. self.cwd .. trail .. " "
    end,
  },
  {
    provider = function(self)
      local cwd = vim.fn.pathshorten(self.cwd)
      local trail = self.cwd:sub(-1) == "/" and "" or "/"
      return self.icon .. cwd .. trail .. " "
    end,
  },
  {
    provider = "",
  },
}

local FileNameBlock = {
  init = function(self)
    self.filename = vim.api.nvim_buf_get_name(0)
  end,
}

local FileIcon = {
  init = function(self)
    local filename = self.filename
    local extension = vim.fn.fnamemodify(filename, ":e")
    self.icon, self.icon_color = require("nvim-web-devicons").get_icon_color(filename, extension, { default = true })
  end,
  provider = function(self)
    return self.icon and (self.icon .. " ")
  end,
  hl = function(self)
    return { fg = self.icon_color }
  end,
}

local FileName = {
  init = function(self)
    self.lfilename = vim.fn.fnamemodify(self.filename, ":.")
    if self.lfilename == "" then
      self.lfilename = "[No Name]"
    end
  end,
  hl = { fg = utils.get_highlight("Directory").fg },

  flexible = 2,

  {
    provider = function(self)
      return self.lfilename
    end,
  },
  {
    provider = function(self)
      return vim.fn.pathshorten(self.lfilename)
    end,
  },
}

local FileFlags = {
  {
    condition = function()
      return vim.bo.modified
    end,
    provider = "[+]",
    hl = { fg = "green" },
  },
  {
    condition = function()
      return not vim.bo.modifiable or vim.bo.readonly
    end,
    provider = "",
  },
}

local FileNameModifer = {
  hl = function()
    if vim.bo.modified then
      -- use `force` because we need to override the child's hl foreground
      return { fg = "cyan", bold = true, force = true }
    end
  end,
}

FileNameBlock = utils.insert(
  FileNameBlock,
  FileIcon,
  utils.insert(FileNameModifer, FileName),
  FileFlags,
  { provider = "%<" } -- this means that the statusline is cut here when there's not enough space
)

local FileType = {
  provider = function()
    return string.upper(vim.bo.filetype)
  end,
  hl = { fg = utils.get_highlight("Type").fg, bold = true },
}

local Ruler = {
  provider = "%7(%l/%3L%):%2c %P",
}

local LSPActive = {
  condition = conditions.lsp_attached,
  update = { "LspAttach", "LspDetach" },

  provider = function()
    local names = {}
    for _, server in pairs(vim.lsp.get_active_clients { bufnr = 0 }) do
      table.insert(names, server.name)
    end
    return " " .. table.concat(names, " ")
  end,
  hl = { fg = "green", bold = true },
}

local Diagnostics = {
  condition = conditions.has_diagnostics,

  static = {
    error_icon = vim.fn.sign_getdefined("DiagnosticSignError")[1].text,
    warn_icon = vim.fn.sign_getdefined("DiagnosticSignWarn")[1].text,
    info_icon = vim.fn.sign_getdefined("DiagnosticSignInfo")[1].text,
    hint_icon = vim.fn.sign_getdefined("DiagnosticSignHint")[1].text,
  },

  init = function(self)
    self.errors = #vim.diagnostic.get(0, { severity = vim.diagnostic.severity.ERROR })
    self.warnings = #vim.diagnostic.get(0, { severity = vim.diagnostic.severity.WARN })
    self.hints = #vim.diagnostic.get(0, { severity = vim.diagnostic.severity.HINT })
    self.info = #vim.diagnostic.get(0, { severity = vim.diagnostic.severity.INFO })
  end,

  update = { "DiagnosticChanged", "BufEnter" },

  {
    provider = "",
  },
  {
    provider = function(self)
      -- 0 is just another output, we can decide to print it or not!
      return self.errors > 0 and (self.error_icon .. self.errors .. " ")
    end,
    hl = { fg = "diag_error" },
  },
  {
    provider = function(self)
      return self.warnings > 0 and (self.warn_icon .. self.warnings .. " ")
    end,
    hl = { fg = "diag_warn" },
  },
  {
    provider = function(self)
      return self.info > 0 and (self.info_icon .. self.info .. " ")
    end,
    hl = { fg = "diag_info" },
  },
  {
    provider = function(self)
      return self.hints > 0 and (self.hint_icon .. self.hints)
    end,
    hl = { fg = "diag_hint" },
  },
  {
    provider = "",
  },
}

local Git = {
  condition = conditions.is_git_repo,

  init = function(self)
    self.status_dict = vim.b.gitsigns_status_dict
    self.has_changes = self.status_dict.added ~= 0 or self.status_dict.removed ~= 0 or self.status_dict.changed ~= 0
  end,

  hl = { fg = "orange" },

  { -- git branch name
    provider = function(self)
      return " " .. self.status_dict.head
    end,
    hl = { bold = true },
  },
  -- You could handle delimiters, icons and counts similar to Diagnostics
  {
    condition = function(self)
      return self.has_changes
    end,
    provider = "(",
  },
  {
    provider = function(self)
      local count = self.status_dict.added or 0
      return count > 0 and ("+" .. count)
    end,
    hl = { fg = "git_add" },
  },
  {
    provider = function(self)
      local count = self.status_dict.removed or 0
      return count > 0 and ("-" .. count)
    end,
    hl = { fg = "git_del" },
  },
  {
    provider = function(self)
      local count = self.status_dict.changed or 0
      return count > 0 and ("~" .. count)
    end,
    hl = { fg = "git_change" },
  },
  {
    condition = function(self)
      return self.has_changes
    end,
    provider = ")",
  },
}

ViMode = utils.surround({ "", "" }, "bright_bg", { ViMode })

local Align = { provider = "%=" }
local Space = { provider = " " }

local Statusline = {
  ViMode,
  Space,
  FileNameBlock,
  Space,
  Git,
  Space,
  Diagnostics,
  Align,
  LSPActive,
  Space,
  FileType,
  Space,
  Ruler,
}

local options = {
  statusline = Statusline,
  opts = {
    colors = colors,
  },
}

return options
