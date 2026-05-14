-- File & text search
--   <C-p>        : find file by name
--   <leader>sg   : live grep
--   <leader>sw   : grep word under cursor
--   <leader>sb   : pick open buffer
--   <leader>sh   : help tags
--   <leader>sk   : keymaps
--   <leader>.    : resume last search
vim.pack.add({ { src = "https://github.com/ibhagwan/fzf-lua" } })

require("fzf-lua").setup({
    "max-perf",
    winopts = { preview = { default = "builtin" } },
    files   = { hidden = true },
    grep    = { hidden = true },
    lsp     = { code_actions = { previewer = false } },
})

require("fzf-lua").register_ui_select()

local fzf = require("fzf-lua")
vim.keymap.set("n", "<C-p>",      fzf.files,      { desc = "Find file" })
vim.keymap.set("n", "<leader>sg", fzf.live_grep,  { desc = "Live grep" })
vim.keymap.set("n", "<leader>sw", fzf.grep_cword, { desc = "Grep word" })
vim.keymap.set("n", "<leader>sb", fzf.buffers,    { desc = "Pick buffer" })
vim.keymap.set("n", "<leader>sh", fzf.helptags,   { desc = "Help tags" })
vim.keymap.set("n", "<leader>sk", fzf.keymaps,    { desc = "Keymaps" })
vim.keymap.set("n", "<leader>.",  fzf.resume,     { desc = "Resume last search" })
