-- Status bar
vim.pack.add({ { src = "https://github.com/nvim-lualine/lualine.nvim" } })

require("lualine").setup({
    options  = { theme = "auto" },
    sections = {
        lualine_a = { "mode" },
        lualine_b = { "branch", "diff" },
        lualine_c = { { "filename", path = 1 } },
        lualine_x = { "filetype" },
        lualine_y = { "progress" },
        lualine_z = { "location" },
    },
})
