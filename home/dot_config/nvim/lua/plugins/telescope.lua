local M = {}

local function filenameFirst(_, path)
    local tail = vim.fs.basename(path)
    local parent = vim.fs.dirname(path)
    if parent == "." then return tail end

    local cwd = vim.fn.getcwd()
    parent = parent:gsub("^" .. vim.pesc(cwd) .. "/", "")

    return string.format("%s -> %s", tail, parent)
end

function M.setup()
    require('telescope').setup {
        defaults = {
            extensions = {
                fzf = {}
            },
            mappings = {
                i = {
                    ["<esc>"] = require('telescope.actions').close,
                    ["<c-u>"] = false,
                },
            },
            path_display = filenameFirst,
            -- appearance
            layout_strategy = 'vertical',
            layout_config = {
                width = 100,
                preview_height = 0.4,
            },
            borderchars = { '─', '│', '─', '│', '┌', '┐', '┘', '└' },
        }
    }

    -- Load extensions
    require('telescope').load_extension("fzf")
    require('telescope').load_extension("ui-select")
end

return M
