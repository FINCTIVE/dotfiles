return {
    -- LSP Configuration
    {
        "neovim/nvim-lspconfig",
        dependencies = {
            "hrsh7th/nvim-cmp",         -- Autocompletion plugin
            "hrsh7th/cmp-nvim-lsp",     -- LSP source for nvim-cmp
            "saadparwaiz1/cmp_luasnip", -- Snippets source
            "L3MON4D3/LuaSnip",         -- Snippets plugin
            "numToStr/Comment.nvim",
        },
        config = function()
            require("plugins.lsp").setup()
        end
    },
    {
        "pocco81/auto-save.nvim",
        opts = {
            trigger_events = { "FocusLost" },
        },
    },
    {
        "nvim-treesitter/nvim-treesitter",
        build = ":TSUpdate",
        config = function()
            require("plugins.treesitter").setup()
        end
    },
    {
        'nvim-telescope/telescope.nvim',
        tag = '0.1.8',
        dependencies = {
            'nvim-lua/plenary.nvim',
            {
                'nvim-telescope/telescope-fzf-native.nvim',
                build = 'make'
            }
        },
        config = function()
            require("plugins.telescope").setup()
        end
    },
    {
        "projekt0n/github-nvim-theme",
        lazy = false,
        priority = 1000,
        config = function()
            require("plugins.theme").setup()
        end
    },
    {
        "hrsh7th/nvim-cmp",
        config = function()
            require("plugins.cmp").setup()
        end
    }
}
