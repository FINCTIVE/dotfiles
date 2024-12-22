local M = {}

function M.setup()
    require('telescope').setup {
        defaults = {
            extensions = {
                fzf = {}
            },
            layout_config = {
                vertical = { width = 0.9 }
            },
            mappings = {
                i = {
                    ["<CR>"] = function(bufnr)
                        require("telescope.actions").select_tab(bufnr)
                    end
                },
            }
        }
    }

    -- Load extensions
    require('telescope').load_extension("fzf")

    -- Set keymaps
    local builtin = require('telescope.builtin')
    vim.keymap.set('n', '<leader>gg', builtin.oldfiles, {})
    -- vim.keymap.set('n', '<leader>gg', builtin.find_files, {})
    vim.keymap.set('n', '<leader>gs', builtin.live_grep, {})
    vim.keymap.set('n', '<leader>gh', builtin.help_tags, {})
end

return M
