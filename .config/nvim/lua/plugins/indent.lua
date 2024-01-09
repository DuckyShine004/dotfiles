local highlight = {
    "IblIndent"
}

require('ibl').setup {
    whitespace = {
        highlight = highlight,
        remove_blankline_trail = false,
    },
    scope = {enabled = false},
}

require('whitespace-nvim').setup {
    highlight = 'DiffDelete',
    ignored_filetypes = { 'TelescopePrompt', 'Trouble', 'help' },
    ignore_terminal = true,
}

