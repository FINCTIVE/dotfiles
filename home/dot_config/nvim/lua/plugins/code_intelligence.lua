local M = {}

function M.setup_lua_snip()
    require('luasnip').setup({
        exit_roots = false,
    })
    require("luasnip.loaders.from_vscode").lazy_load()
    require('keymaps').setup_luasnip_keymaps()
end

function M.setup_completion()
    local cmp = require('cmp')
    ---@diagnostic disable-next-line: missing-fields
    cmp.setup({
        mapping = require('keymaps').setup_completion_keymaps(),
        snippet = {
            expand = function(args)
                require('luasnip').lsp_expand(args.body)
            end,
        },
        sources = {
            { name = 'luasnip' },
            { name = 'nvim_lsp' },
            { name = 'buffer' },
            { name = 'path' },
            { name = 'cmdline' },
            { name = 'nvim_lua' },
        },
        preselect = cmp.PreselectMode.None, -- Do not use LSP pre-select result.
    })
end

function M.setup_lsp()
    local lspconfig = require('lspconfig')
    local capabilities = require('cmp_nvim_lsp').default_capabilities()

    -- Configure gopls
    lspconfig.gopls.setup {
        capabilities = capabilities,
        settings = {
            gopls = {
                analyses = {
                    unusedparams = true,
                },
                staticcheck = true,
            },
        },
    }

    -- Configure Lua LSP
    lspconfig.lua_ls.setup {
        capabilities = capabilities,
        settings = {
            Lua = {
                runtime = {
                    version = 'LuaJIT',
                },
                diagnostics = {
                    globals = { 'vim' },
                },
                workspace = {
                    library = vim.api.nvim_get_runtime_file("", true),
                    checkThirdParty = false,
                },
                telemetry = {
                    enable = false,
                },
            },
        },
    }

    -- config
    vim.diagnostic.config({
        virtual_text = false, -- Disables inline diagnostics text
    })

    -- LSP Keybindings
    vim.api.nvim_create_autocmd('LspAttach', {
        callback = function(args)
            require('keymaps').setup_lsp_keymaps(args.buf)
        end,
    })

    vim.api.nvim_create_user_command('LspWorkspaces', function()
        local new_buf = vim.api.nvim_create_buf(true, true)
        vim.api.nvim_buf_set_lines(new_buf, 0, -1, false, vim.tbl_map(tostring, vim.lsp.buf.list_workspace_folders()))
        vim.api.nvim_command('split')
        vim.api.nvim_win_set_buf(0, new_buf)
    end, {})
end

vim.opt.foldmethod = "expr"
vim.opt.foldexpr = "nvim_treesitter#foldexpr()"
vim.opt.foldenable = true
vim.opt.foldlevel = 12

function M.setup_treesitter()
    require("nvim-treesitter.configs").setup({
        highlight = {
            enable = true,
            additional_vim_regex_highlighting = false,
        },
        indent = { enable = true },
        ensure_installed = { "json", "yaml", "xml", "git_rebase", "gitcommit", "gitattributes", "diff" },
        sync_install = false,
        auto_install = true,
        ignore_install = {},
        modules = {},
        update_strategy = "lockfile",
    })
end

return M
