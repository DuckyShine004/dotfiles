local myFileTypes = vim.api.nvim_create_augroup("MyFileTypes", { clear = true })

local function set_opts(shiftwidth, tabstop, softtabstop)
  vim.opt_local.shiftwidth = shiftwidth
  vim.opt_local.tabstop = tabstop
  vim.opt_local.softtabstop = softtabstop
end

vim.api.nvim_create_autocmd("FileType", {
  group = myFileTypes,
  pattern = { "html", "css", "lua" },
  callback = function()
    set_opts(2, 2, 2)
  end,
})

vim.api.nvim_create_autocmd("FileType", {
  group = myFileTypes,
  pattern = { "javascript", "javascriptreact", "typescript", "typescriptreact", "json", "python" },
  callback = function()
    set_opts(4, 4, 4)
  end,
})
