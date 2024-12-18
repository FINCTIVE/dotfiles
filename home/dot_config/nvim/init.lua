-- Basic Neovim settings
vim.opt.number = true         -- Show line numbers
vim.opt.expandtab = true      -- Use spaces instead of tabs
vim.opt.shiftwidth = 4
vim.opt.tabstop = 4
vim.opt.smartindent = true
vim.opt.syntax = 'on'         -- Enable syntax highlighting
vim.opt.clipboard = 'unnamedplus' -- Use system clipboard

local keymaps = {
  -- Normal mode
  {'n', 'H', '^', {noremap = true}},  
  {'n', 'L', '$', {noremap = true}},
  -- Visual mode
  {'v', 'H', '^', {noremap = true}},
  {'v', 'L', '$', {noremap = true}}
}
for _, map in ipairs(keymaps) do
  vim.keymap.set(map[1], map[2], map[3], map[4])
end

-- Install package manager
-- https://github.com/folke/lazy.nvim
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable",
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)

-- Configure plugins
require("lazy").setup({
  -- LSP Configuration
  {
    "neovim/nvim-lspconfig",
    dependencies = {
      "hrsh7th/nvim-cmp",         -- Autocompletion plugin
      "hrsh7th/cmp-nvim-lsp",     -- LSP source for nvim-cmp
      "saadparwaiz1/cmp_luasnip", -- Snippets source
      "L3MON4D3/LuaSnip",         -- Snippets plugin
    },
  },
})

-- LSP settings
local lspconfig = require('lspconfig')
local capabilities = require('cmp_nvim_lsp').default_capabilities()

-- Configure gopls
lspconfig.gopls.setup{
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

-- Setup nvim-cmp for autocompletion
local cmp = require('cmp')
local luasnip = require('luasnip')

cmp.setup({
  snippet = {
    expand = function(args)
      luasnip.lsp_expand(args.body)
    end,
  },
  mapping = cmp.mapping.preset.insert({
    -- Ctrl+Space to trigger completion menu
    ['<C-Space>'] = cmp.mapping.complete(),
    
    -- Enter to confirm completion
    ['<CR>'] = cmp.mapping.confirm({ select = false }),
    
    -- Tab to select the first item
    ['<Tab>'] = cmp.mapping(function(fallback)
      if cmp.visible() then
        cmp.select_next_item({ behavior = cmp.SelectBehavior.Select })
      else
        fallback()
      end
    end, { 'i', 's' }),
    
    -- Navigate through docs
    ['<C-d>'] = cmp.mapping.scroll_docs(-4),
    ['<C-f>'] = cmp.mapping.scroll_docs(4),
    
    -- Escape to close completion menu
    ['<C-e>'] = cmp.mapping.abort(),
    
    -- Up/Down to navigate through completion items
    ['<C-n>'] = cmp.mapping.select_next_item(),
    ['<C-p>'] = cmp.mapping.select_prev_item(),
  }),
  sources = {
    { name = 'nvim_lsp' },
    { name = 'luasnip' },
  },
})


-- Key mappings for LSP functionality
vim.api.nvim_create_autocmd('LspAttach', {
  callback = function(args)
    local opts = { buffer = args.buf }
    
    vim.keymap.set('n', 'gD', vim.lsp.buf.declaration, opts)
    vim.keymap.set('n', 'gd', vim.lsp.buf.definition, opts)
    vim.keymap.set('n', 'K', vim.lsp.buf.hover, opts)
    vim.keymap.set('n', 'gi', vim.lsp.buf.implementation, opts)
    vim.keymap.set('n', '<C-k>', vim.lsp.buf.signature_help, opts)
    vim.keymap.set('n', '<space>wa', vim.lsp.buf.add_workspace_folder, opts)
    vim.keymap.set('n', '<space>wr', vim.lsp.buf.remove_workspace_folder, opts)
    vim.keymap.set('n', '<space>wl', function()
      print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
    end, opts)
    vim.keymap.set('n', '<space>D', vim.lsp.buf.type_definition, opts)
    vim.keymap.set('n', '<space>rn', vim.lsp.buf.rename, opts)
    vim.keymap.set({ 'n', 'v' }, '<space>ca', vim.lsp.buf.code_action, opts)
    vim.keymap.set('n', 'gr', vim.lsp.buf.references, opts)
  end,
})
