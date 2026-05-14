-- lua/autoloader.lua
-- Automatically loads every file in lua/plugins/ alphabetically.
-- To disable a plugin: delete or rename its file.
local plugins_dir = vim.fn.stdpath("config") .. "/lua/plugins"
local files = vim.fn.glob(plugins_dir .. "/*.lua", false, true)
table.sort(files)
for _, file in ipairs(files) do
    local name = vim.fn.fnamemodify(file, ":t:r")
    local ok, err = pcall(require, "plugins." .. name)
    if not ok then
        vim.notify("Error loading plugin '" .. name .. "':\n" .. err, vim.log.levels.ERROR)
    end
end
