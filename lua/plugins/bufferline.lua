-- Buffer tabs at the top  →  gt / gT / gb
vim.pack.add({ { src = "https://github.com/akinsho/nvim-bufferline.lua" } })

local function safe_close(bufnr)
    local listed = vim.tbl_filter(function(b)
        return vim.bo[b].buflisted and b ~= bufnr
    end, vim.api.nvim_list_bufs())
    if #listed == 0 then
        -- Ensure a real window stays open so neo-tree never becomes the last window
        local target = nil
        for _, win in ipairs(vim.api.nvim_list_wins()) do
            local ft = vim.bo[vim.api.nvim_win_get_buf(win)].filetype
            if ft ~= "neo-tree" and ft ~= "NvimTree" then
                target = win
                break
            end
        end
        if target then
            vim.api.nvim_win_call(target, function() vim.cmd("enew") end)
        else
            vim.cmd("vsplit | enew")
        end
    end
    vim.api.nvim_buf_delete(bufnr, { force = true })
end

require("bufferline").setup({
    options = {
        mode            = "buffers",
        separator_style = "thin",
        close_command       = safe_close,
        right_mouse_command = safe_close,
        middle_mouse_command = safe_close,
        name_formatter = function(buf)
            if buf.name == "" then return "Menu" end
        end,
        offsets = {
            { filetype = "NvimTree", text = "File Explorer", text_align = "center", separator = true },
        },
    },
})
