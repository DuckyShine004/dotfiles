local function auto_group(name, opts)
  return vim.api.nvim_create_augroup(name, opts)
end

local function auto_command(event, opts)
  vim.api.nvim_create_autocmd(event, opts)
end

local groups = {
  file_type_group = auto_group("FileTypeGroup", { clear = true }),
  loading_group = auto_group("LoadingGroup", { clear = true }),
}

local function set_opts(shiftwidth, tabstop, softtabstop)
  vim.opt_local.shiftwidth = shiftwidth
  vim.opt_local.tabstop = tabstop
  vim.opt_local.softtabstop = softtabstop
end

auto_command("FileType", {
  group = groups.file_type_group,
  pattern = "dbout",
  callback = function()
    vim.wo.foldenable = false
  end,
})

auto_command("FileType", {
  group = groups.file_type_group,
  pattern = { "html", "css", "lua" },
  callback = function()
    set_opts(2, 2, 2)
  end,
})

auto_command("FileType", {
  group = groups.file_type_group,
  pattern = { "javascript", "javascriptreact", "typescript", "typescriptreact", "json", "python" },
  callback = function()
    set_opts(4, 4, 4)
  end,
})
