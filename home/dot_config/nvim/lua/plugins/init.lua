return {
    -- Code Intelligence
    {
        "neovim/nvim-lspconfig",
        config = function()
            require("plugins.code_intelligence").setup_lsp()
        end
    },
    {
        "L3MON4D3/LuaSnip",
        dependencies = { "rafamadriz/friendly-snippets" },
        config = function()
            require("plugins.code_intelligence").setup_lua_snip()
        end
    },
    {
        "hrsh7th/nvim-cmp",
        dependencies = {
            'hrsh7th/cmp-nvim-lsp',
            'hrsh7th/cmp-buffer',
            'hrsh7th/cmp-path',
            'hrsh7th/cmp-cmdline',
            'hrsh7th/cmp-nvim-lua',
            'saadparwaiz1/cmp_luasnip',
        },
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
    {
        "folke/lazydev.nvim", -- setup lua lsp for neovim config
        ft = "lua",
        opts = {
            library = {
                { path = "${3rd}/luv/library", words = { "vim%.uv" } },
            },
        },
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
        "numToStr/Comment.nvim", -- Type "gc" or "gcc" to comment.
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
    {
        "j-hui/fidget.nvim",
        opts = require("plugins.theme").fidget_opts,
    },
    {
        "m4xshen/smartcolumn.nvim",
        opts = require("plugins.theme").smart_column_opts,
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
