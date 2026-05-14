-- lua/keymaps.lua
-- Leader: <Space>
--
--   <C-n>        : toggle file tree (neo-tree)
--   gt / gT      : next / prev buffer
--   gb           : pick buffer with fzf-lua
--   <C-p>        : find file by name
--   <leader>sg   : live grep
--   <leader>sw   : grep word under cursor
--   <leader>yy   : copy relative file path to clipboard
--   <C-c>        : copy line / selection to clipboard
--   > / <        : indent / outdent selection (visual)
--   <leader>q    : close buffer
--   <Esc>        : clear search highlight
--   U            : redo
--   <Alt-j/k>    : move line(s) up/down
--   <leader>s    : search & replace word under cursor

local map = vim.keymap.set

-- Buffers
map("n", "gt", ":bn<CR>",  { noremap = true, silent = true })
map("n", "gT", ":bp<CR>",  { noremap = true, silent = true })

map("n", "<leader>q", function()
    local bufnr = vim.api.nvim_get_current_buf()
    local others = vim.tbl_filter(function(b)
        return vim.bo[b].buflisted and b ~= bufnr
    end, vim.api.nvim_list_bufs())
    if #others == 0 then
        vim.cmd("enew")
    else
        vim.cmd("bp")
    end
    vim.cmd("bd " .. bufnr)
end, { desc = "Close buffer" })

-- Clipboard
map("v", "<C-c>", '"+y')
map("n", "<C-c>", [[:lua vim.fn.setreg('+', vim.fn.getline('.'))<CR>]], { noremap = true, silent = true })

-- Indent / outdent keeps selection
map("v", ">", ">gv", { noremap = true })
map("v", "<", "<gv", { noremap = true })

-- Yank relative file path
map("n", "<leader>yy", function()
    local absolute = vim.api.nvim_buf_get_name(0)
    if absolute == "" then
        vim.notify("No file name", vim.log.levels.WARN)
        return
    end
    local git_root = vim.fs.root(0, ".git")
    local base = git_root or vim.uv.cwd()
    local path = base and vim.fn.fnamemodify(absolute, ":." .. base) or absolute
    if path:sub(1, 1) == "/" then
        path = vim.fn.fnamemodify(absolute, ":~")
    end
    vim.fn.setreg("+", path)
    vim.notify("Yanked: " .. path)
end, { desc = "Yank relative file path" })

-- Search
map("n", "<Esc>", vim.cmd.nohlsearch, { desc = "Clear search highlight" })
-- Keep n/N direction consistent regardless of / vs ?
map({ "n", "o", "x" }, "n", "'Nn'[v:searchforward].'zv'", { expr = true, desc = "Next search result" })
map({ "n", "o", "x" }, "N", "'nN'[v:searchforward].'zv'", { expr = true, desc = "Prev search result" })
-- Search & replace word under cursor
map("n", "<leader>s", [[:%s/\<<C-r><C-w>\>/<C-r><C-w>/Ig<Left><Left><Left>]],
    { desc = "Search & replace word under cursor", silent = false })

-- Undo / redo
map("n", "U", vim.cmd.redo, { desc = "Redo" })

-- Move lines up/down
map("n", "<A-j>", "<cmd>execute 'move .+' . v:count1<cr>==",               { desc = "Move line down" })
map("n", "<A-k>", "<cmd>execute 'move .-' . (v:count1 + 1)<cr>==",         { desc = "Move line up" })
map("i", "<A-j>", "<esc><cmd>m .+1<cr>==gi",                               { desc = "Move line down" })
map("i", "<A-k>", "<esc><cmd>m .-2<cr>==gi",                               { desc = "Move line up" })
map("v", "<A-j>", ":<C-u>execute \"'<,'>move '>+\" . v:count1<cr>gv=gv",   { desc = "Move selection down" })
map("v", "<A-k>", ":<C-u>execute \"'<,'>move '<-\" . (v:count1 + 1)<cr>gv=gv", { desc = "Move selection up" })
