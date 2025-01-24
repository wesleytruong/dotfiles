return {
  {
    -- installs language servers
    "williamboman/mason.nvim",
    config = true
  },
  {
    -- communicates mason with nvim-lspconfig
    "williamboman/mason-lspconfig",
    dependencies = {
      "williamboman/mason.nvim"
    },
    opts = {
      ensure_installed = { "lua_ls" },
      automatic_installation = true,
    }
  },
  {
    -- allows to set up keybinds to navigate files with lang server features
    "neovim/nvim-lspconfig",
    dependencies = { 'saghen/blink.cmp' },
    opts = {
      servers = {
        lua_ls = {
          settings = {
            Lua = {
              diagnostics = {
                globals = {'vim'}
              }
            }
          }
        },
        clangd = {},
        pyright = {},
        gopls = {},
      }
    },
    config = function(_, opts)
      local lsp = require("lspconfig")
      for server, config in pairs(opts.servers) do
        config.capabilities = require('blink.cmp').get_lsp_capabilities(config.capabilities)
        lsp[server].setup(config)
      end

      vim.keymap.set('n','K', vim.lsp.buf.hover, {})
      vim.keymap.set('n', 'gd', vim.lsp.buf.definition, {})
      vim.keymap.set('n', 'td', vim.lsp.buf.type_definition, {})
      vim.keymap.set({ 'n', 'v' }, '<leader>ca', vim.lsp.buf.code_action, {})
    end
  },
  {
    'saghen/blink.cmp',
    version = '*',
    opts = {
      keymap = { preset = 'default' },
      sources = {
        default = { 'lsp', 'path', 'snippets', 'buffer' },
      },
    },
  }
}
