local M = {}

function M.setup()
    require("nvim-treesitter.configs").setup({
        highlight = {
            enable = true,
            additional_vim_regex_highlighting = false,
        },
        indent = { enable = true },
        ensure_installed = {
            "lua",
            "python",
            "javascript",
            "typescript",
            "json",
            "html",
            "css",
            "go",
        },
    })
end

return M
