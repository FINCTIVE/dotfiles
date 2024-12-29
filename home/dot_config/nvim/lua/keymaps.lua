local M = {}

M.arrow_opts = {
    leader_key = ';',        -- Recommended to be a single key
    buffer_leader_key = 'm', -- Per Buffer Mappings
}

function M.setup()
    -- Basic navigation
    vim.keymap.set('n', 'H', '^', { noremap = true })
    vim.keymap.set('n', 'L', '$', { noremap = true })
    vim.keymap.set('v', 'H', '^', { noremap = true })
    vim.keymap.set('v', 'L', '$', { noremap = true })

    -- buffer management
    vim.keymap.set('n', '<leader>x', ':bd<CR>', { noremap = true })
    vim.keymap.set('n', '<leader>X', ':bd!<CR>', { noremap = true })
    vim.keymap.set('n', '<leader>Q', ':qa!<CR>', { noremap = true })
    vim.keymap.set('n', '<leader>t', ':tabnew<CR>', { noremap = true, desc = 'New tab' })
    vim.keymap.set('n', '<C-p>', ':bnext<CR>', { noremap = true, silent = true })
    vim.keymap.set('n', '<C-n>', ':bprevious<CR>', { noremap = true, silent = true })
    vim.keymap.set('n', '<leader>z', ':NoNeckPain<CR>', { noremap = true, silent = true })

    vim.keymap.set('n', '<leader>w', function()
        vim.wo.wrap = not vim.wo.wrap
    end, { noremap = true, silent = true, desc = 'Toggle word wrap' })

    -- special keymaps
    vim.keymap.set('n', '<leader>q', function()
        vim.cmd('cclose')
        vim.cmd('lclose')
        vim.cmd('pclose')
        vim.cmd('only') -- Close all other windows
    end, { noremap = true, silent = true })

    -- telescope
    local telescope = require('telescope.builtin')
    vim.keymap.set('n', '<leader>gb', telescope.buffers, { noremap = true })
    vim.keymap.set('n', '<leader>gg', telescope.find_files, { noremap = true })
    vim.keymap.set('n', '<leader>gr', telescope.oldfiles, { noremap = true })
    vim.keymap.set('n', '<leader>gs', telescope.live_grep, { noremap = true })
    vim.keymap.set('n', '<leader>gh', telescope.help_tags, { noremap = true })
    vim.keymap.set('n', '<leader>go', function()
        telescope.lsp_document_symbols({ symbol_width = 0.7 })
    end, { noremap = true })
    vim.keymap.set('n', '<leader>ru', telescope.lsp_references, { noremap = true })
    vim.keymap.set('n', '<leader>ri', telescope.lsp_implementations, { noremap = true })
    vim.keymap.set('n', '<leader>ee', telescope.diagnostics, { noremap = true })

    vim.keymap.set('n', '<leader>ss', telescope.git_status, { noremap = true })

    vim.keymap.set('n', '<leader>fc', telescope.commands, { noremap = true })

    -- gitsigns
    local gitsigns = require('gitsigns')
    vim.keymap.set('n', '<leader>ej', function()
        if vim.wo.diff then
            vim.cmd.normal({ ']c', bang = true })
        else
            gitsigns.nav_hunk('next')
        end
    end, { noremap = true })

    vim.keymap.set('n', '<leader>eJ', function()
        if vim.wo.diff then
            vim.cmd.normal({ '[c', bang = true })
        else
            gitsigns.nav_hunk('prev')
        end
    end, { noremap = true })

    vim.keymap.set('n', '<leader>sd', function() gitsigns.diffthis('HEAD') end, { noremap = true })
    vim.keymap.set('n', '<leader>sh', gitsigns.stage_hunk, { noremap = true })
    vim.keymap.set('n', '<leader>sr', gitsigns.reset_hunk, { noremap = true })
    vim.keymap.set('n', '<leader>sR', gitsigns.reset_buffer, { noremap = true })
    vim.keymap.set('n', '<leader>so', gitsigns.toggle_deleted, { noremap = true })
    vim.keymap.set('n', '<leader>sb', gitsigns.blame_line, { noremap = true })

    -- files
    vim.keymap.set('n', '<leader>gf', ':Oil<CR>', { noremap = true })
end

-- LSP-specific keymaps
-- Triggered via LSP config callback
function M.setup_lsp_keymaps(bufnr)
    -- Code navigation
    vim.keymap.set('n', '<leader>f', vim.lsp.buf.format, { noremap = true, buffer = bufnr })
    vim.keymap.set('n', 'gD', vim.lsp.buf.declaration, { noremap = true, buffer = bufnr })
    vim.keymap.set('n', 'gd', vim.lsp.buf.definition, { noremap = true, buffer = bufnr })
    vim.keymap.set('n', '<leader>rn', vim.lsp.buf.rename, { noremap = true, buffer = bufnr })

    -- Help
    vim.keymap.set('n', 'K', vim.lsp.buf.hover, { noremap = true, buffer = bufnr })
    vim.keymap.set('n', '<C-k>', vim.lsp.buf.signature_help, { noremap = true, buffer = bufnr })

    -- Code actions
    vim.keymap.set('n', '<leader>ca', vim.lsp.buf.code_action, { noremap = true, buffer = bufnr })

    -- Diagnostics
    vim.keymap.set('n', '<leader>eN', vim.diagnostic.goto_prev, { noremap = true, buffer = bufnr })
    vim.keymap.set('n', '<leader>en', vim.diagnostic.goto_next, { noremap = true, buffer = bufnr })
    vim.keymap.set('n', '<leader>el', vim.diagnostic.open_float, { noremap = true, buffer = bufnr })

    -- Workspace
    vim.keymap.set('n', '<leader>wr', ':LspRestart<CR>', { noremap = true, buffer = bufnr })
    vim.keymap.set('n', '<leader>wa', vim.lsp.buf.add_workspace_folder, { noremap = true, buffer = bufnr })
    vim.keymap.set('n', '<leader>wr', vim.lsp.buf.remove_workspace_folder, { noremap = true, buffer = bufnr })
    vim.keymap.set('n', '<leader>wl', function()
        print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
    end, { noremap = true, buffer = bufnr })
end

return M
