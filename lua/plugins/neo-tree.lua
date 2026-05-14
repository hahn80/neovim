-- Left file tree  →  <C-n>
vim.pack.add({
    { src = "https://github.com/nvim-lua/plenary.nvim" },
    { src = "https://github.com/nvim-tree/nvim-web-devicons" },
    { src = "https://github.com/MunifTanjim/nui.nvim" },
    { src = "https://github.com/nvim-neo-tree/neo-tree.nvim" },
})

-- Redirect :q to previous window instead of closing neo-tree
vim.api.nvim_create_autocmd("FileType", {
    pattern  = "neo-tree",
    callback = function()
        vim.cmd("cnoreabbrev <buffer> q wincmd p")
    end,
})

-- Keep neo-tree width fixed after closing windows or tabs
vim.api.nvim_create_autocmd({ "TabClosed", "BufDelete" }, {
    callback = function()
        vim.schedule(function()
            for _, win in ipairs(vim.api.nvim_list_wins()) do
                if vim.bo[vim.api.nvim_win_get_buf(win)].filetype == "neo-tree" then
                    vim.api.nvim_win_set_width(win, 30)
                    break
                end
            end
        end)
    end,
})

vim.api.nvim_create_autocmd("VimEnter", {
    once = true,
    callback = function()
        local ok, err = pcall(function()
            require("neo-tree").setup({
                close_if_last_window = false,
                window = {
                    position = "left",
                    width    = 30,
                    mappings = {
                        ["q"]          = "noop",
                        ["<leader>yy"] = function(state)
                            local path = state.tree:get_node():get_id()
                            local rel = vim.fn.fnamemodify(path, ":.")
                            if rel:sub(1, 1) == "/" then
                                rel = vim.fn.fnamemodify(path, ":~")
                            end
                            vim.fn.setreg("+", rel)
                            vim.notify("Yanked: " .. rel)
                        end,
                    },
                },
                filesystem = {
                    follow_current_file    = { enabled = true },
                    hide_dotfiles          = false,
                    use_libuv_file_watcher = true,
                },
            })
            vim.cmd("Neotree show")
        end)
        if not ok then
            vim.notify("neo-tree: " .. tostring(err), vim.log.levels.WARN)
        end
    end,
})

vim.keymap.set("n", "<C-n>", "<cmd>Neotree toggle<cr>", { desc = "Toggle file tree" })
