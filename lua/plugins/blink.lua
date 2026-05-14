-- Autocompletion
vim.pack.add({
    { src = "https://github.com/Saghen/blink.cmp", version = vim.version.range("1.*") },
    { src = "https://github.com/rafamadriz/friendly-snippets" },
})

require("blink.cmp").setup({
    fuzzy      = { implementation = "lua" },
    keymap     = { preset = "super-tab", ["<CR>"] = { "accept", "fallback" } },
    completion = { documentation = { auto_show = true } },
    sources    = { default = { "lsp", "path", "snippets", "buffer" } },
    signature  = { enabled = true },
})
