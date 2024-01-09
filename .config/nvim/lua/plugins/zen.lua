require("zen-mode").setup {
    window = {
        width = 0.75,
        height = 1,
        options = {
            signcolumn = "yes",
            number = false,
            relativenumber = false,
        },
    },
    plugins = {
        twilight = { enabled = true },
    },
}

require("twilight").setup {
    dimming = {
        alpha = 0.25,
    },
    context = 10,
}
