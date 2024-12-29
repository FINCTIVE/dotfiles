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
            require("plugins.code_intelligence").setup_lsp()
        end
    },
    {
        "folke/lazydev.nvim",
        ft = "lua", -- only load on lua files
        opts = {
            library = {
                -- See the configuration section for more details
                -- Load luvit types when the `vim.uv` word is found
                { path = "${3rd}/luv/library", words = { "vim%.uv" } },
            },
        },
    },
    {
        "hrsh7th/nvim-cmp",
        config = function()
            require("plugins.code_intelligence").setup_completion()
        end
    },
    {
        "nvim-treesitter/nvim-treesitter",
        build = ":TSUpdate",
        config = function()
            require("plugins.code_intelligence").setup_treesitter()
        end
    },
    -- Editor
    {
        'nvim-telescope/telescope.nvim',
        tag = '0.1.8',
        dependencies = {
            'nvim-lua/plenary.nvim',
            {
                'nvim-telescope/telescope-fzf-native.nvim',
                build = 'make'
            },
            'nvim-telescope/telescope-ui-select.nvim'
        },
        config = function()
            require("plugins.telescope").setup()
        end
    },
    {
        "otavioschwanck/arrow.nvim",
        opts = function()
            return require("keymaps").arrow_opts
        end
    },
    {
        "pocco81/auto-save.nvim",
        opts = {
            trigger_events = { "FocusLost" },
        },
    },
    {
        'lewis6991/gitsigns.nvim',
        config = function()
            require('gitsigns').setup()
        end
    },
    -- Theme
    {
        "projekt0n/github-nvim-theme",
        lazy = false,
        priority = 1000,
        config = function()
            require("plugins.theme").setup_theme()
        end
    },
    {
        "shortcuts/no-neck-pain.nvim",
        version = "*",
        opts = function()
            return require("plugins.theme").setup_no_neck_pain()
        end
    },

    -- File
    {
        "stevearc/oil.nvim",
        opts = {},
        config = function()
            require("plugins.file").setup_oil()
        end,
    }
}
