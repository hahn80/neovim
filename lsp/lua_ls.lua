---@type vim.lsp.Config
return {
    cmd = { "lua-language-server" },
    filetypes = { "lua" },
    root_markers = { ".luarc.json", ".luarc.jsonc", "stylua.toml", ".git" },
    settings = {
        Lua = {
            runtime = {
                version = "LuaJIT",
                path = { "?/init.lua", "lua/?.lua", "lua/?/init.lua" },
            },
            diagnostics = {
                globals = { "vim" },
            },
            workspace = {
                checkThirdParty = false,
                library = vim.list_extend(
                    { vim.env.VIMRUNTIME .. "/lua" },
                    vim.fn.glob(vim.fn.stdpath("data") .. "/site/pack/*/opt/*/lua", false, true)
                ),
            },
            format = { enable = false },
            telemetry = { enable = false },
        },
    },
}
