return {
  "zbirenbaum/copilot.lua",
  cmd = "Copilot",
  event = "InsertEnter",
  config = function()
    require("copilot").setup({
      suggestion = {
        auto_trigger = true,
        keymap = {
          accept = "<C-y>"
        }
      }
    })
  end,
}

  -- {
  --   "zbirenbaum/copilot-cmp",
  --   event = "InsertEnter",
  --   config = function () require("copilot_cmp").setup() end,
  --   dependencies = {
  --     "zbirenbaum/copilot.lua",
  --     cmd = "Copilot",
  --     config = function()
  --       require("copilot").setup({
  --         suggestion = { enabled = false },
  --         panel = { enabled = false },
  --       })
  --     end,
  --   },
  -- },
  -- {
  --   'hrsh7th/nvim-cmp',
  --   dependencies = {
  --     'hrsh7th/cmp-nvim-lsp',
  --     "zbirenbaum/copilot-cmp",
  --   },
  --   opts = {
  --     sources = {
  --       { name = 'copilot' },
  --       -- { name = 'nvim_lsp' },
  --     }
  --   }
  -- }
-- }
