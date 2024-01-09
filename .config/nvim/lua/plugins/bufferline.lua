require("bufferline").setup {
    options = {
        close_command = "bdelete! %d",
        right_mouse_command = "bdelete! %d",
        left_mouse_command = "buffer %d",
        middle_mouse_command = nil,
        show_buffer_close_icons = true,
        show_close_icon = false,
        separator_style = "slant",
    },
}
