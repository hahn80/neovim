-- lua/autocmds.lua
local group = vim.api.nvim_create_augroup("user", {})

-- Restore cursor position when reopening a file
vim.api.nvim_create_autocmd("BufReadPost", {
    group = group,
    callback = function(args)
        local bufnr = args.buf
        if vim.bo[bufnr].filetype == "gitcommit" or vim.b[bufnr].last_loc then return end
        vim.b[bufnr].last_loc = true
        local mark = vim.api.nvim_buf_get_mark(bufnr, '"')
        local line_count = vim.api.nvim_buf_line_count(bufnr)
        if mark[1] > 0 and mark[1] <= line_count then
            pcall(vim.api.nvim_win_set_cursor, 0, mark)
        end
    end,
    desc = "Restore cursor position on open",
})

-- Auto-create missing parent directories on save
vim.api.nvim_create_autocmd("BufWritePre", {
    group = group,
    callback = function(args)
        if args.match:match("^%w%w+:[\\/][\\/]") then return end
        local file = vim.uv.fs_realpath(args.match) or args.match
        vim.fn.mkdir(vim.fn.fnamemodify(file, ":p:h"), "p")
    end,
    desc = "Auto-create parent dirs on save",
})

-- Flash yanked region
vim.api.nvim_create_autocmd("TextYankPost", {
    group = group,
    callback = function()
        vim.hl.on_yank({ higroup = "IncSearch", timeout = 400 })
    end,
    desc = "Highlight yanked text",
})

-- Equalize split sizes when terminal is resized
vim.api.nvim_create_autocmd("VimResized", {
    group = group,
    callback = function()
        local current_tab = vim.fn.tabpagenr()
        vim.cmd("tabdo wincmd =")
        vim.cmd("tabnext " .. current_tab)
    end,
    desc = "Equalize splits on resize",
})

-- Dim cursorline and relativenumber in unfocused windows
local ui_group = vim.api.nvim_create_augroup("user.ui", {})

vim.api.nvim_create_autocmd({ "CmdlineEnter", "FocusLost", "InsertEnter", "WinLeave" }, {
    group = ui_group,
    callback = function()
        if vim.bo.buftype ~= "" then return end
        vim.wo.relativenumber = false
        vim.wo.cursorline = false
    end,
    desc = "Dim UI in unfocused windows",
})

vim.api.nvim_create_autocmd({ "BufEnter", "CmdlineLeave", "FocusGained", "InsertLeave", "WinEnter" }, {
    group = ui_group,
    callback = function()
        if vim.bo.buftype ~= "" then return end
        vim.wo.number = true
        vim.wo.relativenumber = true
        vim.wo.cursorline = true
    end,
    desc = "Restore UI in focused windows",
})
