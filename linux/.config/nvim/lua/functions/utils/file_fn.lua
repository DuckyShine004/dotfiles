local M = {}

-- Change this to another extension, e.g., '.exe' on windows
-- Note that on UNIX systems, it will not generate the binary if debugging
local output_extension_for_ft = {
  cpp = ".exe",
}

function M.get_current_file()
  local file = vim.fn.expand "%"

  return vim.fn.shellescape(file)
end

function M.get_full_path(extension)
  local expanded_path = vim.fn.expand "%:p:h" .. "/" .. vim.fn.expand "%:t:r"
  vim.notify(expanded_path)

  return vim.fn.shellescape(expanded_path .. output_extension_for_ft[extension])
end

return M
