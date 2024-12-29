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

-- tmp fix
-- https://github.com/neovim/neovim/issues/31675#issuecomment-2558405042
vim.hl = vim.highlight

function M.setup_theme()
    require("github-theme").setup({
        options = {
            transparent = true,
            styles = {
                keywords = "bold",
            },
        }
    })

    -- Follow the system theme(mac os)
    local handle = io.popen('defaults read -g AppleInterfaceStyle 2>/dev/null')
    local is_dark = true
    if handle then
        is_dark = handle:read("*a"):match("Dark") ~= nil
        handle:close()
    end
    vim.cmd.colorscheme(is_dark and "github_dark_default" or "github_light_default")

    -- Custom Colors

    -- telescope
    vim.api.nvim_set_hl(0, "TelescopeTitle", { link = "LineNr" })
    vim.api.nvim_set_hl(0, "TelescopeBorder", { fg = vim.api.nvim_get_hl(0, { name = "CursorLine" }).bg })
    vim.api.nvim_set_hl(0, 'TelescopeSelection', { bg = 'NONE' })

    -- tree-sitter
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

    -- overwrite theme colors
    vim.api.nvim_set_hl(0, "StatusLine", { bg = "NONE" })
    vim.api.nvim_set_hl(0, "StatusLineNC", { bg = "NONE" })
    vim.api.nvim_set_hl(0, "Normal", { bg = "NONE" })
    vim.api.nvim_set_hl(0, "NormalFloat", { bg = "NONE" })

    if is_dark then
        local bg_color = "#21262d" -- match github dark theme
        vim.api.nvim_set_hl(0, "CursorLine", { bg = bg_color })
    end
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
