local wezterm = require("wezterm")

local custom = wezterm.color.get_builtin_schemes()["Catppuccin Mocha"]

custom.background = "#0E1019"

return {
	-- Font configuration
	font = wezterm.font("JetBrainsMono Nerd Font"),
	font_size = 18.0,

	-- Theme and appearance
	color_schemes = {
		["OLEDppuccin"] = custom,
	},
	color_scheme = "OLEDppuccin",
	window_decorations = "RESIZE", -- Similar to hide_window_decorations in Kitty
	window_background_opacity = 0.85,
	macos_window_background_blur = 16,

	-- Behavior
	enable_wayland = false,
	enable_tab_bar = false,

	-- Keybindings
	keys = {
		-- Toggle fullscreen
		{ key = "f", mods = "SUPER|SHIFT", action = "ToggleFullScreen" },
		-- Reload configuration
		{ key = "r", mods = "SUPER|SHIFT", action = "ReloadConfiguration" },
		-- Close current tab
		{ key = "d", mods = "SUPER|SHIFT", action = wezterm.action({ CloseCurrentTab = { confirm = true } }) },
	},
}
