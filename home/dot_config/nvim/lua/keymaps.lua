local M = {}

M.arrow_opts = {
    leader_key = '\\m',
    buffer_leader_key = 'm',
}

vim.api.nvim_create_autocmd('FileType', {
    pattern = 'qf',
    callback = function()
        vim.keymap.set('n', '<CR>', function()
            local line = vim.fn.line('.')
            vim.cmd('cclose')
            vim.cmd(line .. 'cc')
        end, { buffer = true, noremap = true, silent = true })

        vim.keymap.set('n', '<Esc>', function()
            vim.cmd('cclose')
        end, { buffer = true, noremap = true, silent = true })
    end,
})

function M.setup()
    M.setup_command()
    local telescope = require('telescope.builtin')

    -- key
    vim.keymap.set('n', 'H', '^', { noremap = true })
    vim.keymap.set('n', 'L', '$', { noremap = true })
    vim.keymap.set('v', 'H', '^', { noremap = true })
    vim.keymap.set('v', 'L', '$', { noremap = true })

    -- buffer
    vim.keymap.set('n', '<leader>x', ':bd<CR>', { noremap = true })
    vim.keymap.set('n', '<leader>X', ':bd!<CR>', { noremap = true })
    vim.keymap.set('n', '<leader>Q', ':qa!<CR>', { noremap = true })
    vim.keymap.set('n', '<leader>t', ':tabnew<CR>', { noremap = true, desc = 'New tab' })
    vim.keymap.set('n', '<C-p>', ':bprevious<CR>', { noremap = true, silent = true })
    vim.keymap.set('n', '<C-n>', ':bnext<CR>', { noremap = true, silent = true })

    -- quickfix
    vim.keymap.set('n', '<leader>c', '<cmd>copen<CR>', { noremap = true })
    vim.keymap.set('n', '[c', '<cmd>cprevious<CR>', { noremap = true })
    vim.keymap.set('n', ']c', '<cmd>cnext<CR>', { noremap = true })

    -- editor
    vim.keymap.set('n', '<leader>q', function()
        vim.cmd('cclose')
        vim.cmd('lclose')
        vim.cmd('pclose')
        vim.cmd('only') -- Close all other windows
    end, { noremap = true, silent = true })

    vim.keymap.set('n', '<leader>w', function()
        vim.wo.wrap = not vim.wo.wrap
    end, { noremap = true, silent = true, desc = 'Toggle word wrap' })


    -- git
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

    -- apperence
    vim.keymap.set('n', '<leader>z', ':NoNeckPain<CR>', { noremap = true, silent = true })

    -- tools
    vim.keymap.set('n', '<leader>gb', telescope.buffers, { noremap = true })
    vim.keymap.set('n', '<leader>gf', ':Oil<CR>', { noremap = true })
    local find_files_with_hidden = function() telescope.find_files({ hidden = true, no_ignore = true }) end
    vim.keymap.set('n', '<leader>gG', find_files_with_hidden, { noremap = true })
    vim.keymap.set('n', '<leader>gg', telescope.find_files, { noremap = true })
    vim.keymap.set('n', '<leader>gr', function() telescope.oldfiles({ only_cwd = true }) end, { noremap = true })
    vim.keymap.set('n', '<leader>gs', telescope.live_grep, { noremap = true })
    vim.keymap.set('n', '<leader>go', function()
        telescope.lsp_document_symbols({ symbol_width = 0.7 })
    end, { noremap = true })

    vim.keymap.set('n', '<leader>ss', telescope.git_status, { noremap = true })

    vim.keymap.set('n', '<leader>fh', telescope.help_tags, { noremap = true })
    vim.keymap.set('n', '<leader>fc', telescope.commands, { noremap = true })
    vim.keymap.set('n', '<leader>frc', telescope.command_history, { noremap = true })
    vim.keymap.set('n', '<leader>frq', telescope.quickfixhistory, { noremap = true })
    vim.keymap.set('n', '<leader>frj', telescope.jumplist, { noremap = true })
    vim.keymap.set('n', '<leader>frs', telescope.search_history, { noremap = true })
end

-- LSP-specific keymaps
-- Triggered via LSP config callback
function M.setup_lsp_keymaps(bufnr)
    vim.keymap.set('n', '<leader>f', vim.lsp.buf.format, { noremap = true, buffer = bufnr })

    vim.keymap.set('n', 'K', vim.lsp.buf.hover, { noremap = true, buffer = bufnr })
    vim.keymap.set('n', '<C-k>', vim.lsp.buf.signature_help, { noremap = true, buffer = bufnr })

    vim.keymap.set('n', 'gD', vim.lsp.buf.declaration, { noremap = true, buffer = bufnr })
    vim.keymap.set('n', 'gd', vim.lsp.buf.definition, { noremap = true, buffer = bufnr })

    vim.keymap.set('n', '<leader>rn', vim.lsp.buf.rename, { noremap = true, buffer = bufnr })
    vim.keymap.set('n', '<leader>ru', vim.lsp.buf.references, { noremap = true, buffer = bufnr })
    vim.keymap.set('n', '<leader>ri', vim.lsp.buf.implementation, { noremap = true })
    vim.keymap.set('n', '<leader>ra', vim.lsp.buf.code_action, { noremap = true, buffer = bufnr })

    vim.keymap.set('n', '<leader>ee', function()
        vim.diagnostic.setqflist({ open = true })
    end, { noremap = true, buffer = bufnr })
    vim.keymap.set('n', '<leader>eE', function()
        vim.diagnostic.setqflist({ severity = vim.diagnostic.severity.ERROR })
    end, { noremap = true, buffer = bufnr })

    vim.keymap.set('n', '<leader>eN', vim.diagnostic.goto_prev, { noremap = true, buffer = bufnr })
    vim.keymap.set('n', '<leader>en', vim.diagnostic.goto_next, { noremap = true, buffer = bufnr })
    vim.keymap.set('n', '<leader>el', vim.diagnostic.open_float, { noremap = true, buffer = bufnr })
end

function M.setup_command()
    -- Create a command CopyPath that copies absolute path to clipboard
    vim.api.nvim_create_user_command('CopyPath', function()
        local path = vim.fn.expand('%:p')
        vim.fn.setreg('+', path)
        print('Copied: ' .. path)
    end, { desc = 'Copy absolute path to clipboard' })

    -- Copy relative path
    vim.api.nvim_create_user_command('CopyRelPath', function()
        local path = vim.fn.expand('%')
        vim.fn.setreg('+', path)
        print('Copied: ' .. path)
    end, { desc = 'Copy relative path to clipboard' })

    -- Copy filename only
    vim.api.nvim_create_user_command('CopyFileName', function()
        local path = vim.fn.expand('%:t')
        vim.fn.setreg('+', path)
        print('Copied: ' .. path)
    end, { desc = 'Copy filename to clipboard' })

    -- Copy folder path
    vim.api.nvim_create_user_command('CopyFolderPath', function()
        local path = vim.fn.expand('%:p:h')
        vim.fn.setreg('+', path)
        print('Copied: ' .. path)
    end, { desc = 'Copy folder path to clipboard' })
end

function M.setup_luasnip_keymaps()
    local luasnip = require('luasnip')
    vim.keymap.set({ "i", "s" }, "<C-j>", function() luasnip.jump(1) end, { silent = true })
    vim.keymap.set({ "i", "s" }, "<C-k>", function() luasnip.jump(-1) end, { silent = true })
end

function M.setup_completion_keymaps()
    local cmp = require('cmp')
    return cmp.mapping.preset.insert({
        ['<C-n>'] = cmp.mapping.select_next_item(),
        ['<Tab>'] = cmp.mapping.select_next_item(),
        ['<C-p>'] = cmp.mapping.select_prev_item(),
        ['<S-Tab>'] = cmp.mapping.select_prev_item(),

        ['<CR>'] = cmp.mapping.confirm({ select = true }),
        ['<C-e>'] = cmp.mapping.abort(),

        ['<C-d>'] = cmp.mapping.scroll_docs(-4),
        ['<C-f>'] = cmp.mapping.scroll_docs(4),
    })
end

return M
