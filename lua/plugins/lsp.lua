-- Native LSP (Neovim 0.12+)
-- Server configs live in lsp/<name>.lua and are auto-discovered below.

vim.lsp.config("*", {
    root_markers = { ".git" },
    capabilities = {
        workspace = {
            fileOperations = { didRename = true, willRename = true },
        },
    },
})

local servers = vim.iter(vim.api.nvim_get_runtime_file("lsp/*.lua", true))
    :map(function(path)
        return vim.fs.basename(path):match("^(.-)%.lua$")
    end)
    :totable()
vim.lsp.enable(servers)

vim.diagnostic.config({
    severity_sort = true,
    signs = {
        text = {
            [vim.diagnostic.severity.ERROR] = "",
            [vim.diagnostic.severity.WARN]  = "",
            [vim.diagnostic.severity.INFO]  = "",
            [vim.diagnostic.severity.HINT]  = "",
        },
    },
    virtual_text = { spacing = 2 },
    float = { border = "rounded" },
})

vim.api.nvim_create_autocmd("LspAttach", {
    group = vim.api.nvim_create_augroup("user.lsp", {}),
    callback = function(args)
        local client = vim.lsp.get_client_by_id(args.data.client_id)
        if not client then return end
        local buf = args.buf

        local map = function(lhs, rhs, desc)
            vim.keymap.set("n", lhs, rhs, { buffer = buf, desc = desc })
        end

        map("K",           vim.lsp.buf.hover,       "LSP hover")
        map("gd",          vim.lsp.buf.definition,  "Go to definition")
        map("gD",          vim.lsp.buf.declaration, "Go to declaration")
        map("gi",          vim.lsp.buf.implementation, "Go to implementation")
        map("gr",          vim.lsp.buf.references,  "Go to references")
        map("<leader>rn",  vim.lsp.buf.rename,      "Rename symbol")
        map("<leader>ca",  vim.lsp.buf.code_action, "Code action")
        map("<leader>e",   vim.diagnostic.open_float, "Show diagnostic")
        map("[d", function() vim.diagnostic.jump({ count = -1 }) end, "Prev diagnostic")
        map("]d", function() vim.diagnostic.jump({ count =  1 }) end, "Next diagnostic")
    end,
    desc = "Set LSP keymaps on attach",
})
