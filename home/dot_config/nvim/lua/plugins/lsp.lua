local M = {}

function M.setup()
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

    -- LSP Keybindings
    vim.api.nvim_create_autocmd('LspAttach', {
        callback = function(args)
            local opts = { buffer = args.buf }

            -- Code navigation
            vim.keymap.set('n', '\\f', vim.lsp.buf.format, opts)
            vim.keymap.set('n', 'gD', vim.lsp.buf.declaration, opts)
            vim.keymap.set('n', 'gd', vim.lsp.buf.definition, opts)
            vim.keymap.set('n', '\\ri', vim.lsp.buf.implementation, opts)
            vim.keymap.set('n', '\\ru', vim.lsp.buf.references, opts)
            vim.keymap.set('n', '\\rn', vim.lsp.buf.rename, opts)

            -- Document symbols
            vim.keymap.set('n', '\\go', vim.lsp.buf.document_symbol, opts)

            -- Help
            vim.keymap.set('n', 'K', vim.lsp.buf.hover, opts)
            vim.keymap.set('n', '<C-k>', vim.lsp.buf.signature_help, opts)

            -- Code actions
            vim.keymap.set('n', '\\ca', vim.lsp.buf.code_action, opts)

            -- Diagnostics
            vim.keymap.set('n', '\\eN', vim.diagnostic.goto_prev, opts)
            vim.keymap.set('n', '\\en', vim.diagnostic.goto_next, opts)
            vim.keymap.set('n', '\\ee', vim.diagnostic.open_float, opts)

            -- Workspace
            vim.keymap.set('n', '\\wr', ':LspRestart<CR>', opts)
            vim.keymap.set('n', '\\wa', vim.lsp.buf.add_workspace_folder, opts)
            vim.keymap.set('n', '\\wr', vim.lsp.buf.remove_workspace_folder, opts)
            vim.keymap.set('n', '\\wl', function()
                print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
            end, opts)
        end,
    })
end

return M
