local cmp = require("cmp")

cmp.setup({
	snippet = {
		expand = function(args)
			require("luasnip").lsp_expand(args.body)
		end,
	},
	window = {
		completion = {
			border = "rounded",
			winhighlight = "Normal:CmpNormal,FloatBorder:CmpNormal,Search:None",
			-- winhighlight = "Normal:CmpNormal",
		},
		documentation = {
			border = { "╭", "─", "╮", "│", "╯", "─", "╰", "│" },
		},
	},
	mapping = cmp.mapping.preset.insert({
		["<Tab>"] = cmp.mapping.select_next_item(),
		["<S-Tab>"] = cmp.mapping.select_prev_item(),
		["<CR>"] = cmp.mapping.confirm({ select = true }),
	}),
	sources = cmp.config.sources({
		{ name = "nvim_lsp" },
		{ name = "luasnip" },
		{ name = "buffer" },
		{ name = "emoji" },
	}),
	formatting = {
		format = require("lspkind").cmp_format({ with_text = true, maxwidth = 50 }),
	},
})
