local M = {}

-- Declare a global function to retrieve the current directory
function _G.get_oil_winbar()
    local dir = require("oil").get_current_dir()
    if dir then
        return vim.fn.fnamemodify(dir, ":~")
    else
        -- If there is no current directory (e.g. over ssh), just show the buffer name
        return vim.api.nvim_buf_get_name(0)
    end
end

function M.setup_oil()
    require("oil").setup({
        default_file_explorer = true,
        delete_to_trash = true,
        use_default_keymaps = true,
        win_options = {
            number = true,
            signcolumn = "yes",
            winbar = "%!v:lua.get_oil_winbar()",
        },
        keymaps = {
            ["<CR>"] = { "actions.select", mode = "n" },
            ["h"] = { "actions.parent", mode = "n" },
            ["l"] = { "actions.select", mode = "n" },
            ["L"] = { "actions.select", mode = "n", opts = { tab = true } },
            ["q"] = { "actions.close", mode = "n" },
            ["<C-p>"] = "actions.preview",
            ["<C-l>"] = "actions.refresh",
            ["."] = { "actions.toggle_hidden", mode = "n" },
            ["?"] = { "actions.show_help", mode = "n" },
        },
    })
end

return M
