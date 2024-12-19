-- PART BASIC
vim.opt.showtabline = 2      -- Always show tab line
vim.opt.hidden = true        -- Allow switching buffers without saving
vim.opt.termguicolors = true -- make sure termguicolors is enabled
vim.opt.number = true
vim.opt.signcolumn = "yes"
vim.opt.expandtab = true
vim.opt.shiftwidth = 4
vim.opt.tabstop = 4
vim.opt.smartindent = true
vim.opt.clipboard = 'unnamedplus'

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

-- PART PLUGINS
require("lazy").setup({
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
    end,
  },
  {
    "catppuccin/nvim",
    name = "catppuccin",
    priority = 1000,
    config = function()
      require("catppuccin").setup({
        flavour = "macchiato",
        transparent_background = true,
        integrations = {
          treesitter = true,
          native_lsp = true,
          cmp = true,
          gitsigns = true,
          telescope = true,
          notify = true,
          mini = true,
        },
        color_overrides = {},
        custom_highlights = {},
      })

      -- Set the colorscheme
      vim.cmd.colorscheme("catppuccin")

      -- Ensure background transparency is applied
      vim.api.nvim_set_hl(0, "Normal", { bg = "NONE" })
      vim.api.nvim_set_hl(0, "NormalFloat", { bg = "NONE" })
    end,
  }
})

-- PART LSP
local lspconfig = require('lspconfig')
local capabilities = require('cmp_nvim_lsp').default_capabilities()
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

-- PART KEY MAPPINGS
local cmp = require('cmp')
local luasnip = require('luasnip')

cmp.setup({
  snippet = {
    expand = function(args)
      luasnip.lsp_expand(args.body)
    end,
  },
  mapping = cmp.mapping.preset.insert({
    ['<C-Space>'] = cmp.mapping.complete(),
    ['<CR>'] = cmp.mapping.confirm({ select = false }),
    ['<Tab>'] = cmp.mapping(function(fallback)
      if cmp.visible() then
        cmp.select_next_item({ behavior = cmp.SelectBehavior.Select })
      else
        fallback()
      end
    end, { 'i', 's' }),

    ['<C-d>'] = cmp.mapping.scroll_docs(-4),
    ['<C-f>'] = cmp.mapping.scroll_docs(4),
    ['<C-e>'] = cmp.mapping.abort(),
    ['<C-n>'] = cmp.mapping.select_next_item(),
    ['<C-p>'] = cmp.mapping.select_prev_item(),
  }),
  sources = {
    { name = 'nvim_lsp' },
    { name = 'luasnip' },
  },
})


vim.api.nvim_create_autocmd('LspAttach', {
  callback = function(args)
    local opts = { buffer = args.buf }

    vim.keymap.set('n', '\\f', vim.lsp.buf.format, opts)

    vim.keymap.set('n', 'gD', vim.lsp.buf.declaration, opts)
    vim.keymap.set('n', 'gd', vim.lsp.buf.definition, opts)
    -- vim.keymap.set('n', '<space>D', vim.lsp.buf.type_definition, opts)
    vim.keymap.set('n', 'gi', vim.lsp.buf.implementation, opts)
    vim.keymap.set('n', 'gr', vim.lsp.buf.references, opts)
    vim.keymap.set('n', '<space>rn', vim.lsp.buf.rename, opts)

    -- Document symbols
    vim.keymap.set('n', '<space>ds', vim.lsp.buf.document_symbol, opts)
    vim.keymap.set('n', '<space>ws', vim.lsp.buf.workspace_symbol, opts)

    -- Help
    vim.keymap.set('n', 'K', vim.lsp.buf.hover, opts)
    vim.keymap.set('n', '<C-k>', vim.lsp.buf.signature_help, opts)

    -- Code Action
    vim.keymap.set({ 'n', 'v' }, '<space>ca', vim.lsp.buf.code_action, opts)

    -- Diagnostic keymaps
    vim.keymap.set('n', '[d', vim.diagnostic.goto_prev, opts)
    vim.keymap.set('n', ']d', vim.diagnostic.goto_next, opts)
    vim.keymap.set('n', '<space>e', vim.diagnostic.open_float, opts)
    vim.keymap.set('n', '<space>q', vim.diagnostic.setloclist, opts)

    -- Language Server
    vim.keymap.set('n', '<space>rs', ':LspRestart<CR>', opts)
    vim.keymap.set('n', '<space>wa', vim.lsp.buf.add_workspace_folder, opts)
    vim.keymap.set('n', '<space>wr', vim.lsp.buf.remove_workspace_folder, opts)
    vim.keymap.set('n', '<space>wl', function()
      print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
    end, opts)
  end,
})

local keymaps = {
  { 'n', 'H',     '^',                { noremap = true } },
  { 'n', 'L',     '$',                { noremap = true } },
  { 'v', 'H',     '^',                { noremap = true } },
  { 'v', 'L',     '$',                { noremap = true } },
  { 'n', '\\x',   ':tabclose<CR>',    { noremap = true } },
  { 'n', '\\X',   ':q<CR>',           { noremap = true } },
  { 'n', '\\t',   ':tabnew<CR>',      { noremap = true, desc = 'New tab' } },
  { 'n', '<C-p>', ':tabnext<CR>',     { silent = true } },
  { 'n', '<C-n>', ':tabprevious<CR>', { silent = true } },
  { 'n', '\\wh',  ':tabmove -1<CR>',  { noremap = true, silent = true, desc = 'Move tab left' } },
  { 'n', '\\wl',  ':tabmove +1<CR>',  { noremap = true, silent = true, desc = 'Move tab right' } },
  { 'n', '\\wc',   ':tabonly<CR>',     { noremap = true, desc = 'Close other tabs' } },
}

for _, map in ipairs(keymaps) do
  vim.keymap.set(map[1], map[2], map[3], map[4])
end
