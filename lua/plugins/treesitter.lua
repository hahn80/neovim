-- Parser management via nvim-treesitter; highlighting via built-in vim.treesitter
vim.pack.add({ { src = "https://github.com/nvim-treesitter/nvim-treesitter" } })

vim.api.nvim_create_autocmd("VimEnter", {
    once = true,
    callback = function()
        local ok, err = pcall(function()
            require("nvim-treesitter").setup()
        end)
        if not ok then
            vim.notify("nvim-treesitter: " .. tostring(err), vim.log.levels.WARN)
        end
    end,
})

-- Built-in treesitter highlighting (uses parsers installed by nvim-treesitter)
vim.api.nvim_create_autocmd("FileType", {
    group = vim.api.nvim_create_augroup("native-treesitter", { clear = true }),
    callback = function(args)
        local buf = args.buf
        if vim.bo[buf].buftype ~= "" then return end
        local lang = vim.treesitter.language.get_lang(args.match)
        if not lang then return end
        if not pcall(vim.treesitter.query.get, lang, "highlights") then return end
        pcall(vim.treesitter.start, buf, lang)
    end,
    desc = "Enable built-in treesitter highlighting",
})
