vim.g.mapleader = " "

local lazypath = vim.fn.stdpath "data" .. "/lazy/lazy.nvim"

-- Add mason to path
local mason_bin_path = vim.fn.stdpath "data" .. "/mason/bin"
local path = vim.env.PATH or ""

if not string.find(path, mason_bin_path, 1, true) then
  vim.env.PATH = mason_bin_path .. ":" .. path
end

if not vim.loop.fs_stat(lazypath) then
  local repo = "https://github.com/folke/lazy.nvim.git"
  vim.fn.system { "git", "clone", "--filter=blob:none", repo, "--branch=stable", lazypath }
end

vim.opt.rtp:prepend(lazypath)

local lazy_config = require "configs.lazy"

require("lazy").setup({
  { import = "plugins" },
}, lazy_config)

require "options"
require "autocmds"

vim.schedule(function()
  require "mappings"
end)
