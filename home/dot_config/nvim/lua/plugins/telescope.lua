local M = {}

function M.setup()
    require('telescope').setup {
        defaults = {
            extensions = {
                fzf = {}
            },
            layout_strategy = 'vertical',
            layout_config = {
                width = 0.9,
                height = 0.9,
                preview_height = 0.6,
            },
            borderchars = {
                "─", "│", "─", "│", "┌", "┐", "┘", "└"
            },
            mappings = {
                i = {
                    ["<esc>"] = require('telescope.actions').close
                },
            },
        }
    }

    -- Load extensions
    require('telescope').load_extension("fzf")
    require('telescope').load_extension("ui-select")
end

return M
