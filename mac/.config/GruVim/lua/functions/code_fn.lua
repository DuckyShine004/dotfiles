local M = {}

local file_fn = require "functions.utils.file_fn"

local floaterm_cmd = "FloatermNew --name=Terminal --title=Terminal "
local readline_cmd = ";echo Press ENTER to exit ; read"

local flags = {
  "g++ -o ",
  "g++ -std=c++17 -Wall -Wextra -Wshadow -D_GLIBCXX_ASSERTIONS -DDEBUG -fmax-errors=2 -o ",
  "(Exit)",
}

local function get_python_cmd()
  return "python3 " .. file_fn.get_current_file()
end

local function get_cpp_cmd()
  local cur = file_fn.get_current_file()
  local exe = file_fn.get_full_path "cpp"
  local msg = "g++ flags:\\n"
  local opt = 0

  for i, flag in ipairs(flags) do
    msg = msg .. i .. ": " .. flag .. "\\n"
  end

  vim.cmd('echo "' .. msg .. '"')

  while not opt or opt <= 0 or opt > #flags do
    local choice = vim.fn.input("Select g++ flag (1-" .. #flags .. "): ")

    if choice then
      opt = tonumber(choice)
    end
  end

  if opt == #flags then
    return nil
  end

  return flags[opt] .. exe .. " " .. cur .. " && " .. exe
end

local function get_tex_cmd()
  vim.cmd ":VimtexCompile"

  return nil
end

local get_cmd_for_ft = {
  python = {
    get_python_cmd,
  },
  cpp = {
    get_cpp_cmd,
  },
  tex = {
    get_tex_cmd,
  },
}

function M.runCode()
  local filetype = vim.bo.filetype

  if not get_cmd_for_ft[filetype] then
    vim.notify("Cannot run code for filetype: " .. filetype, vim.log.levels.INFO)
  else
    vim.cmd "w"

    local cmd = get_cmd_for_ft[filetype][1]()

    if cmd ~= "" and cmd ~= nil then
      vim.cmd(floaterm_cmd .. cmd .. readline_cmd)
    end
  end
end

return M
