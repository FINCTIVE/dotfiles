local M = {}

-- UI
vim.opt.showtabline = 0      -- Never show tab line
vim.opt.termguicolors = true -- Enable true colors support
vim.opt.number = true        -- Show line numbers
vim.opt.signcolumn = "yes"   -- Always show sign column
vim.opt.cursorline = true
vim.opt.colorcolumn = "120"

-- Indentation
vim.opt.expandtab = true   -- Use spaces instead of tabs
vim.opt.shiftwidth = 4     -- Size of an indent
vim.opt.tabstop = 4        -- Number of spaces tabs count for
vim.opt.smartindent = true -- Insert indents automatically

function M.setup_theme()
    require("github-theme").setup({
        options = {
            transparent = true,
            styles = {
                keywords = "bold",
            },
        }
    })

    -- Set the colorscheme
    vim.cmd.colorscheme("github_dark_default")

    -- Custom colors
    vim.api.nvim_set_hl(0, "CursorLine", { bg = "#293036" })

    vim.api.nvim_set_hl(0, "StatusLine", { bg = "NONE" })
    vim.api.nvim_set_hl(0, "StatusLineNC", { bg = "NONE" })
    vim.api.nvim_set_hl(0, "Normal", { bg = "NONE" })
    vim.api.nvim_set_hl(0, "NormalFloat", { bg = "NONE" })

    vim.api.nvim_set_hl(0, "TelescopeBorder", { fg = "#333333" })
    vim.api.nvim_set_hl(0, 'TelescopeSelection', { bg = 'NONE' })

    -- Less colorful
    vim.api.nvim_set_hl(0, '@function', { link = 'Function' })
    vim.api.nvim_set_hl(0, '@function.call', { link = 'Function' })
    vim.api.nvim_set_hl(0, '@method', { link = 'Function' })

    vim.api.nvim_set_hl(0, '@variable', { link = 'Identifier' })
    vim.api.nvim_set_hl(0, '@variable.member', { link = 'Identifier' })
    vim.api.nvim_set_hl(0, '@constant', { link = 'Identifier' })
    vim.api.nvim_set_hl(0, '@field', { link = 'Identifier' })
    vim.api.nvim_set_hl(0, '@type', { link = 'Identifier' })
    vim.api.nvim_set_hl(0, '@property', { link = 'Identifier' })
    vim.api.nvim_set_hl(0, '@constructor', { link = 'Identifier' })
end

function M.setup_no_neck_pain()
    return {
        width = 120,
        buffers = {
            right = {
                enabled = false
            }
        }
    }
end

return M
