local M = {}

-- Helper function for setting keymaps
local function map(mode, lhs, rhs, opts)
    local options = { noremap = true }
    if opts then options = vim.tbl_extend('force', options, opts) end -- todo: what is this
    -- todo2: gitsigns will pass buffer, there is none
    vim.keymap.set(mode, lhs, rhs, options)
end

M.arrow_opts = {
    leader_key = ';',        -- Recommended to be a single key
    buffer_leader_key = 'm', -- Per Buffer Mappings
}

function M.setup()
    -- Basic navigation
    map('n', 'H', '^')
    map('n', 'L', '$')
    map('v', 'H', '^')
    map('v', 'L', '$')

    -- buffer management
    map('n', '<leader>x', ':bd<CR>')
    map('n', '<leader>X', ':bd!<CR>')
    map('n', '<leader>Q', ':qa!<CR>')
    map('n', '<leader>t', ':tabnew<CR>', { desc = 'New tab' })
    map('n', '<C-p>', ':bnext<CR>', { silent = true })
    map('n', '<C-n>', ':bprevious<CR>', { silent = true })
    map('n', '<leader>z', ':NoNeckPain<CR>', { silent = true })

    vim.keymap.set('n', '<leader>w', function()
        vim.wo.wrap = not vim.wo.wrap
    end, { noremap = true, silent = true, desc = 'Toggle word wrap' })

    -- special keymaps
    vim.keymap.set('n', '<leader>q', function()
        vim.cmd('cclose')
        vim.cmd('lclose')
        vim.cmd('pclose')
        vim.cmd('only') -- Close all other windows
    end, { silent = true })

    -- telescope
    local telescope = require('telescope.builtin')
    map('n', '<leader>gb', telescope.buffers)
    map('n', '<leader>gg', telescope.find_files)
    map('n', '<leader>gr', telescope.oldfiles)
    map('n', '<leader>gs', telescope.live_grep)
    map('n', '<leader>gh', telescope.help_tags)
    map('n', '<leader>go', function()
        telescope.lsp_document_symbols({ symbol_width = 0.7 })
    end)
    map('n', '<leader>ru', telescope.lsp_references)
    map('n', '<leader>ri', telescope.lsp_implementations)
    map('n', '<leader>ee', telescope.diagnostics)

    map('n', '<leader>ss', telescope.git_status)

    map('n', '<leader>fc', telescope.commands)

    -- gitsigns
    local gitsigns = require('gitsigns')
    map('n', '<leader>ej', function()
        if vim.wo.diff then
            vim.cmd.normal({ ']c', bang = true })
        else
            gitsigns.nav_hunk('next')
        end
    end)

    map('n', '<leader>eJ', function()
        if vim.wo.diff then
            vim.cmd.normal({ '[c', bang = true })
        else
            gitsigns.nav_hunk('prev')
        end
    end)

    map('n', '<leader>sd', function() gitsigns.diffthis('HEAD') end)
    map('n', '<leader>sh', gitsigns.stage_hunk)
    map('n', '<leader>sr', gitsigns.reset_hunk)
    map('n', '<leader>sR', gitsigns.reset_buffer)
    map('n', '<leader>so', gitsigns.toggle_deleted)
    map('n', '<leader>sb', gitsigns.blame_line)

    -- files
    map('n', '<leader>gf', ':Oil<CR>', {})
end

-- LSP-specific keymaps
-- Triggered via LSP config callback
function M.setup_lsp_keymaps(bufnr)
    local opts = { buffer = bufnr }

    -- Code navigation
    map('n', '<leader>f', vim.lsp.buf.format, opts)
    map('n', 'gD', vim.lsp.buf.declaration, opts)
    map('n', 'gd', vim.lsp.buf.definition, opts)
    map('n', '<leader>rn', vim.lsp.buf.rename, opts)

    -- Help
    map('n', 'K', vim.lsp.buf.hover, opts)
    map('n', '<C-k>', vim.lsp.buf.signature_help, opts)

    -- Code actions
    map('n', '<leader>ca', vim.lsp.buf.code_action, opts)

    -- Diagnostics
    map('n', '<leader>eN', vim.diagnostic.goto_prev, opts)
    map('n', '<leader>en', vim.diagnostic.goto_next, opts)
    map('n', '<leader>el', vim.diagnostic.open_float, opts)

    -- Workspace
    map('n', '<leader>wr', ':LspRestart<CR>', opts)
    map('n', '<leader>wa', vim.lsp.buf.add_workspace_folder, opts)
    map('n', '<leader>wr', vim.lsp.buf.remove_workspace_folder, opts)
    map('n', '<leader>wl', function()
        print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
    end, opts)
end

return M
