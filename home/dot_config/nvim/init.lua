-- opt
vim.opt.hidden = true             -- Allow switching buffers without saving
vim.opt.clipboard = 'unnamedplus' -- Use system clipboard

-- Bootstrap lazy.nvim
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
    vim.fn.system({
        "git",
        "clone",
        "--filter=blob:none",
        "https://github.com/folke/lazy.nvim.git",
        "--branch=stable",
        lazypath,
    })
end
vim.opt.rtp:prepend(lazypath)

-- Initialize plugins
require("lazy").setup(require("plugins"))

-- Load keymaps
require("keymaps").setup()
