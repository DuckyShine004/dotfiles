local wilder = require "wilder"

-- local config = {
--   modes = { ":", "/", "?" },
-- }
--
-- local highlighters = {
--   wilder.pcre2_highlighter(),
--   wilder.basic_highlighter(),
-- }
--
-- wilder.setup(config)
--
-- wilder.set_option(
--   "renderer",
--   wilder.popupmenu_renderer(wilder.popupmenu_palette_theme {
--     -- 'single', 'double', 'rounded' or 'solid'
--     -- can also be a list of 8 characters, see :h wilder#popupmenu_palette_theme() for more details
--     border = "rounded",
--     max_height = "75%", -- max height of the palette
--     min_height = 0, -- set to the same as 'max_height' for a fixed height window
--     prompt_position = "top", -- 'top' or 'bottom' to set the location of the prompt
--     reverse = 0, -- set to 1 to reverse the order of the list, use in combination with 'prompt_position'
--     highlighter = highlighters,
--     highlights = {
--       accent = wilder.make_hl("WilderAccent", "Pmenu", { { a = 1 }, { a = 1 }, { foreground = "#f4468f" } }),
--     },
--   })
-- )

-- wilder.set_option(
--   "renderer",
--   wilder.popupmenu_renderer(wilder.popupmenu_border_theme {
--     -- pumblend = 10,
--     highlighters = highlighters,
--     highlights = {
--       -- border = "Normal",
--       accent = wilder.make_hl("WilderAccent", "Pmenu", { { a = 1 }, { a = 1 }, { foreground = "#ffffff" } }),
--     },
--     -- border = "rounded",
--     reverse = 0,
--   })
-- )