require("ibl").setup {
    indent = {
        -- char = "▎",
        char = "│",
    },
    exclude = {
        filetypes = {
            "lspinfo",
            "packer",
            "checkhealth",
            "help",
            "man",
            "dashboard",
            "git",
            "markdown",
            "text",
            "terminal",
            "NvimTree",
        },

        buftypes = {
            "terminal",
            "nofile",
            "quickfix",
            "prompt",
        },
    },
    scope = {
        show_start = false,
        show_end = false,
    },
}
