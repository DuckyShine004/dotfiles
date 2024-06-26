local conditions = require("heirline.conditions")
local heirline = require("heirline")

local utils = require("heirline.utils")

local Space = { provider = " " }
local colors = {
	bright_bg = utils.get_highlight("Folded").bg,
	bright_fg = utils.get_highlight("Folded").fg,
	red = utils.get_highlight("DiagnosticError").fg,
	-- dark_red = utils.get_highlight("DiffDelete").bg,
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
	-- git_del = utils.get_highlight("diffDeleted").fg,
	-- git_add = utils.get_highlight("diffAdded").fg,
	-- git_change = utils.get_highlight("diffChanged").fg,
}

heirline.load_colors(colors)

local ViMode = {
	-- get vim current mode, this information will be required by the provider
	-- and the highlight functions, so we compute it only once per component
	-- evaluation and store it as a component attribute
	init = function(self)
		self.mode = vim.fn.mode(1) -- :h mode()

		-- execute this only once, this is required if you want the ViMode
		-- component to be updated on operator pending mode
		if not self.once then
			vim.api.nvim_create_autocmd("ModeChanged", {
				pattern = "*:*o",
				command = "redrawstatus",
			})
			self.once = true
		end
	end,
	-- Now we define some dictionaries to map the output of mode() to the
	-- corresponding string and color. We can put these into `static` to compute
	-- them at initialisation time.
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
		return "%1(" .. self.mode_names[self.mode] .. "%)"
	end,
	-- Same goes for the highlight. Now the foreground will change according to the current mode.
	hl = function(self)
		local mode = self.mode:sub(1, 1) -- get only the first mode character
		return { fg = self.mode_colors[mode], bold = true }
	end,
	-- Re-evaluate the component only on ModeChanged event!
	-- This is not required in any way, but it's there, and it's a small
	-- performance improvement.
	update = {
		"ModeChanged",
	},
}

local FileNameBlock = {
	-- let's first set up some attributes needed by this component and it's children
	init = function(self)
		self.filename = vim.api.nvim_buf_get_name(0)
	end,
}

local FileIcon = {
	init = function(self)
		local filename = self.filename
		local extension = vim.fn.fnamemodify(filename, ":e")
		self.icon, self.icon_color =
			require("nvim-web-devicons").get_icon_color(filename, extension, { default = true })
	end,
	provider = function(self)
		return self.icon and (self.icon .. " ")
	end,
	hl = function(self)
		return { fg = self.icon_color }
	end,
}

local FileName = {
	provider = function(self)
		-- first, trim the pattern relative to the current directory. For other
		-- options, see :h filename-modifers
		local filename = vim.fn.fnamemodify(self.filename, ":.")
		if filename == "" then
			return "[No Name]"
		end
		-- now, if the filename would occupy more than 1/4th of the available
		-- space, we trim the file path to its initials
		-- See Flexible Components section below for dynamic truncation
		if not conditions.width_percent_below(#filename, 0.5) then
			filename = vim.fn.pathshorten(filename)
		end
		return filename
	end,
	hl = { fg = utils.get_highlight("Directory").fg },
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
		provider = "",
		hl = { fg = "orange" },
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

-- let's add the children to our FileNameBlock component
FileNameBlock = utils.insert(
	FileNameBlock,
	FileIcon,
	utils.insert(FileNameModifer, FileName), -- a new table where FileName is a child of FileNameModifier
	FileFlags,
	{ provider = "%<" } -- this means that the statusline is cut here when there's not enough space
)

local Ruler = {
	-- %l = current line number
	-- %L = number of lines in the buffer
	-- %c = column number
	-- %P = percentage through file of displayed window
	provider = "%7(%l/%3L%):%2c %P",
}

local Diagnostics = {

	condition = conditions.has_diagnostics,

	static = {
		-- these require something...
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
}

local WorkDir = {
	provider = function()
		local icon = (vim.fn.haslocaldir(0) == 1 and "l" or "g") .. " " .. " "
		local cwd = vim.fn.getcwd(0)
		cwd = vim.fn.fnamemodify(cwd, ":~")
		if not conditions.width_percent_below(#cwd, 0.25) then
			cwd = vim.fn.pathshorten(cwd)
		end
		local trail = cwd:sub(-1) == "/" and "" or "/"
		return icon .. cwd .. trail
	end,
	hl = { fg = "blue", bold = true },
}

local Align = { provider = "%=" }
-- ViMode = utils.surround({ "", "" }, "bright_bg", { ViMode })

local DefaultStatusline = {
	ViMode,
	Space,
	FileNameBlock,
	Space,
	Align,
	Align,
	-- DAPMessages,
	-- LSPActive,
	Space,
	Diagnostics,
	Space,
	-- LSPMessages,
	Space,
	Ruler,
}

local FileType = {
	provider = function()
		return string.upper(vim.bo.filetype)
	end,
	hl = { fg = utils.get_highlight("Type").fg, bold = true },
}
--
local InactiveStatusline = {
	condition = conditions.is_not_active,
	FileNameBlock,
	Align,
}

local SpecialStatusline = {
	condition = function()
		return conditions.buffer_matches({
			buftype = { "nofile", "prompt", "help", "quickfix" },
			filetype = { "^git.*", "fugitive" },
		})
	end,

	FileType,
	Space,
	Align,
}

local StatusLine = {

	hl = function()
		if conditions.is_active() then
			return "StatusLine"
		else
			return "StatusLineNC"
		end
	end,

	-- the first statusline with no condition, or which condition returns true is used.
	-- think of it as a switch case with breaks to stop fallthrough.
	fallthrough = false,

	SpecialStatusline,
	InactiveStatusline,
	DefaultStatusline,
}

local Winbar = { { provider = "»" }, Space }
local TabLine = {}

heirline.setup({
	statusline = StatusLine,
	tabline = TabLine,
})
