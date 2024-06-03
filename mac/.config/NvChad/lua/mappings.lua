require "nvchad.mappings"

local cmd = require "functions.cmd"
local map = vim.keymap.set

-- General
map("n", ";", ":", { desc = "CMD enter command mode" })
map("i", "jk", "<ESC>")
map({ "n", "i", "v" }, "<C-s>", "<cmd>w<cr>")
map({ "n", "i", "v" }, "<C-q>", "<cmd>q<cr>")
map("n", "<leader>la", cmd.loadAllPlugins, { silent = true })

-- Text
map("v", "<leader>[", ">gv")
map("v", "<leader>]", "<gv")
map("v", "J", ":m '>+1<CR>gv=gv")
map("v", "K", ":m '<-2<CR>gv=gv")

-- Window
map("n", "<leader>hs", "<cmd>split<cr>")
map("n", "<leader>vs", "<cmd>vsplit<cr>")

-- Tree
map("n", "<leader>op", ":NvimTreeToggle<cr>", { silent = true })

-- Trouble
map("n", "<leader>ot", ":TroubleToggle<cr>", { silent = true })
