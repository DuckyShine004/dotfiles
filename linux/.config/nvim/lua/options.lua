local o = vim.o
local wo = vim.wo
local opt = vim.opt
local cmd = vim.cmd

o.clipboard = "unnamed,unnamedplus"
o.completeopt = "noinsert,menuone,noselect"
o.ttimeoutlen = 0
o.hidden = true
o.swapfile = false
o.encoding = "utf-8"
o.mouse = "a"
o.tabstop = 4
o.shiftwidth = 4
o.expandtab = true
o.autoindent = true
o.smarttab = true
o.showmode = false
o.autoread = true

wo.number = true
wo.relativenumber = true
wo.cursorline = true

opt.guicursor = "n-v-i-c:block-Cursor"
opt.fillchars = { eob = " " }
opt.termguicolors = true

cmd "filetype plugin indent on"
cmd "syntax on"
