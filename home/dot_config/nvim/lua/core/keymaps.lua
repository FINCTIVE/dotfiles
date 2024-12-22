local M = {}

-- Helper function for setting keymaps
local function map(mode, lhs, rhs, opts)
    local options = { noremap = true }
    if opts then options = vim.tbl_extend('force', options, opts) end
    vim.keymap.set(mode, lhs, rhs, options)
end

-- Basic navigation
map('n', 'H', '^')
map('n', 'L', '$')
map('v', 'H', '^')
map('v', 'L', '$')

-- Tab management
map('n', '\\x', ':q<CR>')
map('n', '\\Xx', ':q!<CR>')
map('n', '\\Xa', ':qa!<CR>')
map('n', '\\t', ':tabnew<CR>', { desc = 'New tab' })
map('n', '<C-p>', ':tabnext<CR>', { silent = true })
map('n', '<C-n>', ':tabprevious<CR>', { silent = true })
map('n', '\\wh', ':tabmove -1<CR>', { silent = true, desc = 'Move tab left' })
map('n', '\\wl', ':tabmove +1<CR>', { silent = true, desc = 'Move tab right' })
map('n', '\\wc', ':tabonly<CR>', { desc = 'Close other tabs' })

-- special keymaps
vim.keymap.set('n', '\\q', function()
    vim.cmd('cclose')
    vim.cmd('lclose')
    vim.cmd('pclose')
end, { silent = true })


return M
