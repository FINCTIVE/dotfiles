local M = {}

function M.setup()
    require('telescope').setup {
        defaults = {
            extensions = {
                fzf = {}
            },
            mappings = {
                i = {
                    ["<esc>"] = require('telescope.actions').close
                },
            },
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
