local cmd_fn = require "functions.cmd_fn"
local code_fn = require "functions.code_fn"

local map = vim.keymap.set

-- General
map("n", ";", ":", { desc = "CMD enter command mode" })
map({ "n", "i", "v" }, "<C-s>", "<cmd>w<cr>")
map({ "n", "i", "v" }, "<C-q>", "<cmd>q<cr>")
map("i", "<C-H>", "<C-w>", { desc = "Delete previous word in insert mode" })
map("n", "<leader>ls", cmd_fn.syncAllPlugins, { silent = true })
map("n", "<leader>la", cmd_fn.loadAllPlugins, { silent = true })

-- Text
map("n", "<C-a>", "ggVG")
map("v", "[", ">gv")
map("v", "]", "<gv")
map("v", "J", ":m '>+1<CR>gv=gv")
map("v", "K", ":m '<-2<CR>gv=gv")
map({ "n", "v" }, "<leader>/", ":Commentary<cr>", { silent = true })

-- Window
map("n", "<leader>hs", "<cmd>split<cr>")
map("n", "<leader>vs", "<cmd>vsplit<cr>")
map("n", "<leader>mh", "<C-w>h", { silent = true })
map("n", "<leader>mj", "<C-w>j", { silent = true })
map("n", "<leader>mk", "<C-w>k", { silent = true })
map("n", "<leader>ml", "<C-w>l", { silent = true })
map("n", "<leader>wh", "<cmd>vertical resize +5<cr>", { silent = true })
map("n", "<leader>wj", "<cmd>resize -5<cr>", { silent = true })
map("n", "<leader>wk", "<cmd>resize +5<cr>", { silent = true })
map("n", "<leader>wl", "<cmd>vertical resize -5<cr>", { silent = true })

-- Tree
-- map("n", "<leader>op", ":NvimTreeToggle<cr>", { silent = true })
map("n", "<leader>op", ":Neotree toggle<cr>", { silent = true })
map("n", "<leader>bf", ":Neotree filesystem<cr>", { silent = true })
map("n", "<leader>bb", ":Neotree buffers<cr>", { silent = true })

-- Telescope
map("n", "<leader>fw", "<cmd>Telescope live_grep<CR>", { desc = "Telescope Live grep" })
map("n", "<leader>fb", "<cmd>Telescope buffers<CR>", { desc = "Telescope Find buffers" })
map("n", "<leader>fh", "<cmd>Telescope help_tags<CR>", { desc = "Telescope Help page" })
map("n", "<leader>ma", "<cmd>Telescope marks<CR>", { desc = "Telescope Find marks" })
map("n", "<leader>fo", "<cmd>Telescope oldfiles<CR>", { desc = "Telescope Find oldfiles" })
map("n", "<leader>fz", "<cmd>Telescope current_buffer_fuzzy_find<CR>", { desc = "Telescope Find in current buffer" })
map("n", "<leader>cm", "<cmd>Telescope git_commits<CR>", { desc = "Telescope Git commits" })
map("n", "<leader>gt", "<cmd>Telescope git_status<CR>", { desc = "Telescope Git status" })
map("n", "<leader>pt", "<cmd>Telescope terms<CR>", { desc = "Telescope Pick hidden term" })
map("n", "<leader>th", "<cmd>Telescope themes<CR>", { desc = "Telescope Nvchad themes" })
map("n", "<leader>ff", "<cmd>Telescope find_files<cr>", { desc = "Telescope Find files" })
map(
  "n",
  "<leader>fa",
  "<cmd>Telescope find_files follow=true no_ignore=true hidden=true<CR>",
  { desc = "Telescope Find all files" }
)

-- Float terminal
map("n", "<leader>tf", ":FloatermToggle<cr>")
map("n", "<leader>th", ":ToggleTerm size=10 direction=horizontal<cr>")
map("n", "<C-b>", code_fn.runCode, { silent = false })

-- Trouble
map("n", "<leader>td", ":Trouble diagnostics<cr>", { silent = true })

-- Transparency
map("n", "tt", ":TransparentToggle<cr>", { silent = true })
