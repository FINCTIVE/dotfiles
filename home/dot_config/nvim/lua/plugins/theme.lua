local M = {}

-- UI
vim.opt.showtabline = 0      -- Never show tab line
vim.opt.termguicolors = true -- Enable true colors support
vim.opt.number = true        -- Show line numbers
vim.opt.signcolumn = "yes"   -- Always show sign column
vim.opt.cursorline = true

-- Indentation
vim.opt.expandtab = true   -- Use spaces instead of tabs
vim.opt.shiftwidth = 4     -- Size of an indent
vim.opt.tabstop = 4        -- Number of spaces tabs count for
vim.opt.smartindent = true -- Insert indents automatically

-- tmp fix
-- https://github.com/neovim/neovim/issues/31675#issuecomment-2558405042
vim.hl = vim.highlight

local function change_color(color, darkness_factor, saturation_factor)
    -- Extract RGB components
    local r = bit.band(bit.rshift(color, 16), 0xFF)
    local g = bit.band(bit.rshift(color, 8), 0xFF)
    local b = bit.band(color, 0xFF)

    -- Calculate average for grayscale
    local avg = (r + g + b) / 3

    -- Interpolate between original color and grayscale based on saturation_factor
    -- saturation_factor = 1.0 keeps original color, 0.0 makes it grayscale
    r = math.floor((r * saturation_factor + avg * (1 - saturation_factor)) * darkness_factor)
    g = math.floor((g * saturation_factor + avg * (1 - saturation_factor)) * darkness_factor)
    b = math.floor((b * saturation_factor + avg * (1 - saturation_factor)) * darkness_factor)

    -- Combine back into a color and format as hex string
    return string.format('#%06x', bit.bor(
        bit.lshift(r, 16),
        bit.lshift(g, 8),
        b
    ))
end

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

    -- tree-sitter(vscode-like)
    -- specify color
    vim.api.nvim_set_hl(0, '@variable.parameter', { link = 'Type' })
    vim.api.nvim_set_hl(0, '@type', { link = 'Function' })

    -- use less colors
    vim.api.nvim_set_hl(0, '@function', { link = 'Function' })
    vim.api.nvim_set_hl(0, '@function.call', { link = 'Function' })
    vim.api.nvim_set_hl(0, '@method', { link = 'Function' })
    vim.api.nvim_set_hl(0, '@constructor', { link = 'Function' })
    vim.api.nvim_set_hl(0, '@variable', { link = 'Identifier' })
    vim.api.nvim_set_hl(0, '@variable.member', { link = 'Identifier' })
    vim.api.nvim_set_hl(0, '@constant', { link = 'Identifier' })
    vim.api.nvim_set_hl(0, '@field', { link = 'Identifier' })
    vim.api.nvim_set_hl(0, '@property', { link = 'Identifier' })

    -- overwrite theme colors
    vim.api.nvim_set_hl(0, "StatusLine", { bg = "NONE" })
    vim.api.nvim_set_hl(0, "StatusLineNC", { bg = "NONE" })
    vim.api.nvim_set_hl(0, "Normal", { bg = "NONE" })
    vim.api.nvim_set_hl(0, "NormalFloat", { bg = "NONE" })

    if is_dark then
        local visual_hl = vim.api.nvim_get_hl(0, { name = 'Visual' })
        local hint_bg = change_color(visual_hl.bg, 0.8, 0.3)

        vim.api.nvim_set_hl(0, "CursorLine", { bg = hint_bg })
        vim.api.nvim_set_hl(0, "ColorColumn", { bg = hint_bg })
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

M.fidget_opts = {
    progress = {
        display = {
            done_icon = "[done]"
        }
    },
    notification = {
        window = {
            winblend = 0, -- bg = NONE
        }
    },
}

M.smart_column_opts = {
    colorcolumn = "120",
}

return M
