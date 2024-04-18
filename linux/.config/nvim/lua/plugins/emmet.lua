vim.g.user_emmet_settings = {
	["javascript.jsx"] = {
		["extends"] = "jsx",
	},
}

vim.api.nvim_set_keymap("v", "<leader>wr", "<Plug>(emmet-wrap-with-abbreviation)", { noremap = true })
