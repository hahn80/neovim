-- Snacks: collection of small QoL plugins
--   <leader>bd   : delete buffer (preserves layout)
--   <leader>gb   : open file on GitHub/GitLab
--   <leader>lg   : lazygit
--   <leader>un   : dismiss notifications
--   <leader>tz   : zen mode
vim.pack.add({ { src = "https://github.com/folke/snacks.nvim" } })

require("snacks").setup({
    bigfile      = { enabled = true },
    bufdelete    = { enabled = true },
    gitbrowse    = { enabled = true },
    indent       = { enabled = true },
    input        = { enabled = true },
    lazygit      = { enabled = true },
    notifier     = { enabled = true, timeout = 3000 },
    scroll       = { enabled = true },
    statuscolumn = { enabled = true },
    words        = { enabled = true },
    zen          = { enabled = true },
})

local snacks = require("snacks")
vim.keymap.set("n", "<leader>bd", snacks.bufdelete.delete, { desc = "Delete buffer" })
vim.keymap.set("n", "<leader>gb", snacks.gitbrowse.open,   { desc = "Git browse" })
vim.keymap.set("n", "<leader>lg", snacks.lazygit.open,     { desc = "Lazygit" })
vim.keymap.set("n", "<leader>un", snacks.notifier.hide,    { desc = "Dismiss notifications" })
vim.keymap.set("n", "<leader>tz", snacks.zen.zen,          { desc = "Zen mode" })
