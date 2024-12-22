-- UI
vim.opt.showtabline = 2      -- Always show tab line
vim.opt.termguicolors = true -- Enable true colors support
vim.opt.number = true        -- Show line numbers
vim.opt.signcolumn = "yes"   -- Always show sign column

-- Indentation
vim.opt.expandtab = true   -- Use spaces instead of tabs
vim.opt.shiftwidth = 4     -- Size of an indent
vim.opt.tabstop = 4        -- Number of spaces tabs count for
vim.opt.smartindent = true -- Insert indents automatically

-- Behavior
vim.opt.hidden = true             -- Allow switching buffers without saving
vim.opt.clipboard = 'unnamedplus' -- Use system clipboard

return {}
