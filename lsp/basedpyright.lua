---@type vim.lsp.Config
return {
    cmd          = { "basedpyright-langserver", "--stdio" },
    filetypes    = { "python" },
    root_markers = { "pyrightconfig.json", "pyproject.toml", "setup.py", "setup.cfg", ".git" },
    before_init  = function(_, config)
        local python = vim.env.VIRTUAL_ENV and (vim.env.VIRTUAL_ENV .. "/bin/python")
            or vim.fn.exepath("python3")
            or "python"
        config.settings.python = { pythonPath = python }
    end,
    settings     = {
        basedpyright = {
            analysis = {
                typeCheckingMode = "standard",
                diagnosticMode  = "openFilesOnly",
                inlayHints      = {
                    callArgumentNames = true,
                },
            },
        },
    },
}
