require("formatter").setup({
	filetype = {
		python = {
			function()
				return {
					exe = "black",
					args = { "-" },
					stdin = true,
				}
			end,
		},
		cs = {
			function()
				return {
					exe = "dotnet-format",
					args = { "--include", vim.api.nvim_buf_get_name(0) },
					stdin = false,
				}
			end,
		},
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
