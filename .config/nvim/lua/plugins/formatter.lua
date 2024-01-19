require("formatter").setup({
	filetype = {
		tex = {
			function()
				return {
					exe = "latexindent",
					args = { "-w", "-c=/tmp", "-b" },
					stdin = false,
				}
			end,
		},
		lua = {
			-- Use stylua
			function()
				return {
					exe = "stylua", -- Make sure stylua is in your PATH
					args = { "--search-parent-directories", "-" },
					stdin = true,
				}
			end,
		},
	},
})

-- Keybinding for formatting in Neovim
vim.api.nvim_set_keymap("n", "<leader>fl", ":Format<CR>", { noremap = true, silent = true })
