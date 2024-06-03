local modules = {
  ["core.defaults"] = {},
  ["core.completion"] = { config = { engine = "nvim-cmp", name = "[Norg]" } },
  ["core.integrations.nvim-cmp"] = {},
  ["core.concealer"] = {},
  ["core.keybinds"] = {
    config = {
      default_keybinds = true,
      neorg_leader = "<Leader><Leader>",
    },
  },
  ["core.dirman"] = {
    config = {
      workspaces = {
        Notes = "~/Nextcloud/Notes",
        Work = "~/Nextcloud/Work",
      },
    },
  },
}

local opts = {
  load = modules,
}

return opts
