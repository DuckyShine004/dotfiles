local alpha = require('alpha')
local dashboard = require('alpha.themes.dashboard')

local custom_header = {
    "░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░███████████████▓░░░░░░░░░",
    "░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░▒▒▓████████████▓▓▓▓▒▒▒░░░░░░",
    "░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░▒███▓▓▓▒▒▒▒▒▒▒▒▒▒▒▒▓██▓░░░░░░",
    "░░░░░░░░░░░░░░░░░░░░░░░░░░░░▒██▓▓▓▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▓██▓░░░",
    "░░░░░░░░░░░░░░░░░░░░░░░░░░░░▓██▓▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▓███░░░",
    "░░░░░░░░░░░░░░░░░░░░░░░░░▓██▓▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▓███░░░",
    "░░░░░░░░░░░░░░░░░░░░░░░░░▓█████▓▒▒▒██▓░░░▓██▒▒▒▒▒▒▓██▓▒▒▒▓▓▓",
    "░░░░░░░░░░░░░░░░░░░░░░░░░▓█████▓▒▒▒███░░░███▓▒▒▒▒▒▓██▓░░░███",
    "░░░░░░░░░░░░░░░░░░░░░░░░░▓██▓▒▒▓██▓░░░████████████▓░░▒██████",
    "░░░░░░░░░░░░░░░░░░░░░░░░░▓██▓▒▒▒▓▓▓▓▓▓████████████▓▓▓▓██████",
    "░░░░░░░░░░░░░░░░░░░░░░░░░▓██▓▒▒▒▒▒▒██████████▓▓▓▓▓██████████",
    "░░░░░░░░░░░░░░░░░░░█████████▓▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▓████████▓▓▓▓███",
    "░░░░░░░░░░░░░░░░▒▒▒▓▓▓▓▓▓▓▓▓▓▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓",
    "░░░░░░░░░░░░░░░░███▒▒▒▒▒▒▒▒▒▒▓▓▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▓▓▓▓███░░░",
    "░░░░░░░░░░░░░▓▓▓▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▓███░░░",
    "░░░░░░░░░░░░▒██▓▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▓███░░░",
    "░░░██████████▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▓▓▓███",
    "▓▓▓▓▓▓▓▓▓▓▓▓▓▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▓███",
    "███▓▓▓▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▓███",
    "███▓▒▒▒▒▒▒▒▒▓██████▒▒▒▒▒▒▒▓▓▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▓███",
    "▓▓▓▓▓▓▒▒▒▒▒▒▒▓▓▓▓▓▓▓▓▓▓▓▓▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▓███",
    "░░░███▓▒▒▒▒▒▒▒▒▒▒▒▒██████▓▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▓███",
    "░░░░░░▓██▓▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▓▓▓███░░░",
    "░░░░░░▒▓▓▓▓▓▓▓▓▓▓▓▓▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▓▓▓▓▓▓▓▓▓▓░░░",
    "░░░░░░░░░▓█████████▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▓▓▓▓▓▓██████▓░░░░░░",
    "░░░░░░░░░░▒▒▒▒▒▒███████████████████████████████▒▒▒▒▒▒░░░░░░░",
    "░░░░░░░░░░░░░░░░███████████████████████████████▒░░░░░░░░░░░░",
    "░░░░░░░░░░░░░░░░█████████▒░░░░░░░░░░░░█████████▒░░░░░░░░░░░░"
}

dashboard.section.header.val = custom_header

alpha.setup(dashboard.config)


