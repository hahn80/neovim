-- Auto-format on save
-- Requires formatters installed on your system:
--   Python : pip install ruff
--   C/C++  : sudo apt install clang-format
--   JS/TS  : npm install -g prettier
--   Lua    : cargo install stylua
vim.pack.add({ { src = "https://github.com/stevearc/conform.nvim" } })

require("conform").setup({
    format_on_save = function(bufnr)
        if vim.g.disable_autoformat or vim.b[bufnr].disable_autoformat then return end
        return { timeout_ms = 500, lsp_format = "fallback" }
    end,
    formatters_by_ft = {
        python          = { "ruff_format" },
        c               = { "clang_format" },
        cpp             = { "clang_format" },
        javascript      = { "prettier" },
        typescript      = { "prettier" },
        javascriptreact = { "prettier" },
        typescriptreact = { "prettier" },
        java            = { "google_java_format" },
        lua             = { "stylua" },
        markdown        = { "prettier" },
    },
})

vim.o.formatexpr = "v:lua.require'conform'.formatexpr()"

vim.keymap.set("n", "<leader>f", function()
    require("conform").format({ async = true, lsp_format = "fallback" })
end, { desc = "Format buffer" })

vim.api.nvim_create_user_command("Format", function()
    require("conform").format({ async = true, lsp_format = "fallback" })
end, { desc = "Format buffer" })

vim.api.nvim_create_user_command("FormatDisable", function(args)
    if args.bang then
        vim.b.disable_autoformat = true  -- buffer-local
    else
        vim.g.disable_autoformat = true  -- global
    end
end, { desc = "Disable autoformat-on-save", bang = true })

vim.api.nvim_create_user_command("FormatEnable", function()
    vim.b.disable_autoformat = false
    vim.g.disable_autoformat = false
end, { desc = "Re-enable autoformat-on-save" })
