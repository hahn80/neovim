-- lua/options.lua
vim.g.mapleader = " "

vim.g.loaded_netrw       = 1
vim.g.loaded_netrwPlugin = 1

-- defer clipboard to avoid startup delay
vim.schedule(function()
    vim.o.clipboard = "unnamedplus"
end)

vim.o.number          = true
vim.o.relativenumber  = true
vim.o.cursorline      = true
vim.o.expandtab       = true
vim.o.shiftwidth      = 4
vim.o.tabstop         = 4
vim.o.softtabstop     = 4
vim.o.smartindent     = true
vim.o.scrolloff       = 8
vim.o.wrap            = false
vim.o.hlsearch        = false
vim.o.incsearch       = true
vim.o.inccommand      = "split"    -- live preview of :s substitutions
vim.o.ignorecase      = true
vim.o.smartcase       = true
vim.o.termguicolors   = true
vim.o.signcolumn      = "yes"
vim.o.updatetime      = 50
vim.o.backup          = false
vim.o.swapfile        = false
vim.o.undofile        = true       -- persist undo history across sessions
vim.o.splitbelow      = true
vim.o.splitright      = true
vim.o.showmode        = false      -- lualine shows mode instead
vim.o.winborder       = "rounded"  -- rounded borders (Neovim 0.12)
vim.o.fillchars       = "eob: "   -- hide ~ at end of buffer
vim.o.pumheight       = 10
