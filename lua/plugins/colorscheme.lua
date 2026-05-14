vim.pack.add({ { src = "https://github.com/catppuccin/nvim.git", name = "catppuccin" } })

local hour = tonumber(os.date("%H"))
local flavor = (hour >= 18 or hour < 6) and "catppuccin-mocha" or "catppuccin-latte"
vim.cmd.colorscheme(flavor)
