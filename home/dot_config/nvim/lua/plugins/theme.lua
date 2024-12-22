local M = {}

function M.setup()
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

    -- Ensure background transparency is applied
    vim.api.nvim_set_hl(0, "Normal", { bg = "NONE" })
    vim.api.nvim_set_hl(0, "NormalFloat", { bg = "NONE" })
end

return M
