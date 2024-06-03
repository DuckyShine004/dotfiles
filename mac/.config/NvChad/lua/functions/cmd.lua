local M = {}

function M.loadAllPlugins()
  vim.cmd "Lazy load all"
  vim.notify("All plugins loaded!", vim.log.levels.INFO)
end

return M
