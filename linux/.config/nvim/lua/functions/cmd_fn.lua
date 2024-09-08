local M = {}

function M.loadAllPlugins()
  vim.cmd "Lazy load all"
  vim.notify("All plugins loaded!", vim.log.levels.INFO)
  local lazypath = vim.fn.stdpath "data" .. "/lazy/lazy.nvim"
  vim.notify(lazypath, vim.log.levels.INFO)
end

function M.syncAllPlugins()
  vim.cmd "Lazy sync"
  vim.notify "All plugins synced!"
end

return M
