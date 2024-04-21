local M = {}
local root_path = vim.fn.stdpath "config" .. "/lua/"
local theme_path = root_path .. "themes/"

function M.loadAllPlugins()
  -- vim.notify("Applying colorscheme...", vim.log.levels.INFO)
  --
  -- -- Delay for the colorscheme to load first
  -- vim.defer_fn(function()
  --   vim.cmd "Lazy load gruvbox"
  --   vim.notify("Colorscheme applied!", vim.log.levels.INFO)
  --   vim.cmd("source " .. theme_path .. "gruvbox.lua")
  --
  --   -- Load the rest of the plugins in prioritized order
  --   vim.defer_fn(function()
  --     vim.cmd "Lazy load all"
  --     vim.notify("All plugins loaded!", vim.log.levels.INFO)
  --   end, 2000)
  -- end, 500)
  vim.cmd "Lazy load all"
  vim.notify("All plugins loaded!", vim.log.levels.INFO)
end

function M.syncAllPlugins()
  vim.cmd "Lazy sync"
  vim.notify "All plugins synced!"
end

return M
