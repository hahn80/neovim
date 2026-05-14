-- Git diff in sign column + hunk operations
--   ]c / [c          : next / prev hunk
--   <leader>hs / hr  : stage / reset hunk
--   <leader>hS / hR  : stage / reset buffer
--   <leader>hp       : preview hunk
--   <leader>hb       : blame line (full)
--   <leader>hd       : diff this vs HEAD~1
vim.pack.add({ { src = "https://github.com/lewis6991/gitsigns.nvim" } })

require("gitsigns").setup({
    attach_to_untracked = true,
    current_line_blame  = true,
    signs_staged_enable = true,
    on_attach = function(bufnr)
        local gs = require("gitsigns")

        local function map(mode, l, r, opts)
            opts = opts or {}
            opts.buffer = bufnr
            vim.keymap.set(mode, l, r, opts)
        end

        map("n", "]c", function()
            if vim.wo.diff then vim.cmd.normal({ "]c", bang = true })
            else gs.nav_hunk("next") end
        end, { desc = "Next hunk" })

        map("n", "[c", function()
            if vim.wo.diff then vim.cmd.normal({ "[c", bang = true })
            else gs.nav_hunk("prev") end
        end, { desc = "Prev hunk" })

        map("n", "<leader>hs", gs.stage_hunk,  { desc = "Stage hunk" })
        map("n", "<leader>hr", gs.reset_hunk,  { desc = "Reset hunk" })
        map("v", "<leader>hs", function()
            gs.stage_hunk({ vim.fn.line("."), vim.fn.line("v") })
        end, { desc = "Stage hunk" })
        map("v", "<leader>hr", function()
            gs.reset_hunk({ vim.fn.line("."), vim.fn.line("v") })
        end, { desc = "Reset hunk" })
        map("n", "<leader>hS", gs.stage_buffer, { desc = "Stage buffer" })
        map("n", "<leader>hR", gs.reset_buffer, { desc = "Reset buffer" })
        map("n", "<leader>hp", gs.preview_hunk, { desc = "Preview hunk" })
        map("n", "<leader>hb", function() gs.blame_line({ full = true }) end, { desc = "Blame line" })
        map("n", "<leader>hd", function() gs.diffthis("~") end, { desc = "Diff this ~" })
        map("n", "<leader>tb", gs.toggle_current_line_blame, { desc = "Toggle line blame" })
    end,
})
