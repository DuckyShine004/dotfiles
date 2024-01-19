local timer = nil
local row, col, lines, bufnr, max_row
local animation_running = false
local saved_cursor_style

local function set_cursor_style(style)
    vim.cmd("set guicursor=" .. style)
end

local function restore_cursor_style()
    if saved_cursor_style then
        set_cursor_style(saved_cursor_style)
    end
end

local function disable_lsp_diagnostics()
    vim.diagnostic.disable(bufnr)
end

local function enable_lsp_diagnostics()
    vim.diagnostic.enable(bufnr)
end

local function animate_step()
    if not animation_running then
        timer:stop()
        timer:close()
        restore_cursor_style()
        vim.cmd('w')
        enable_lsp_diagnostics()
        return
    end

    if row > max_row then
        timer:stop()
        timer:close()
        restore_cursor_style()
        vim.cmd('w')
        animation_running = false
        enable_lsp_diagnostics()
        return
    end

    local line = lines[row]

    if col <= #line then
        local char = line:sub(col, col)
        vim.api.nvim_buf_set_text(bufnr, row - 1, col - 1, row - 1, col - 1, {char})
        col = col + 1
    else
        row = row + 1
        col = 1
        if row <= max_row then
            vim.api.nvim_buf_set_lines(bufnr, row - 1, row - 1, false, {""})
        end
    end
end

function animate_text()
    if timer and not timer:is_closing() then
        timer:stop()
        timer:close()
    end

    saved_cursor_style = vim.o.guicursor
    set_cursor_style("a:hor20")

    bufnr = vim.api.nvim_get_current_buf()
    disable_lsp_diagnostics()
    lines = vim.api.nvim_buf_get_lines(bufnr, 0, -1, false)
    max_row = #lines
    row, col = 1, 1

    -- Clear the buffer
    vim.api.nvim_buf_set_lines(bufnr, 0, -1, false, {})
    animation_running = true;

    timer = vim.loop.new_timer()
    timer:start(0, 50, vim.schedule_wrap(animate_step))
end

function animate_stop()
    if not animation_running then
        return
    end

    animation_running = false
    enable_lsp_diagnostics()

    -- Stop the timer
    if timer and not timer:is_closing() then
        timer:stop()
        timer:close()
    end

    -- Complete the insertion of the remaining text
    for i = row, max_row do
        local line = lines[i]
        vim.api.nvim_buf_set_lines(bufnr, i - 1, i, false, {line})
    end

    restore_cursor_style()
    vim.cmd('w')
    animation_running = false
    enable_lsp_diagnostics()
end

vim.cmd([[ command! AnimateText lua animate_text() ]])
vim.cmd([[ command! AnimateStop lua animate_stop() ]])
