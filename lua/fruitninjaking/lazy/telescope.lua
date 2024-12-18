return {
  {
    "nvim-telescope/telescope.nvim",

    tag = "0.1.6",

    dependencies = {
      "nvim-lua/plenary.nvim",
      "andrew-george/telescope-themes",
      {
        'nvim-telescope/telescope-fzf-native.nvim',
        build = 'make',
      },
      "nvim-telescope/telescope-ui-select.nvim",
    },

    config = function()
      local builtin = require('telescope.builtin')
      vim.keymap.set('n', '<leader>cc', function()
        vim.cmd('Lazy load all')
        -- builtin.colorscheme({ enable_preview = true })
        vim.cmd('Telescope themes')
      end)
      vim.keymap.set('n', '<leader>pf', builtin.find_files, {})
      vim.keymap.set('n', '<c-p>', builtin.git_files, {})
      vim.keymap.set('n', '<leader>pws', function()
        local word = vim.fn.expand("<cword>")
        builtin.grep_string({ search = word })
      end)
      vim.keymap.set('n', '<leader>bs', require('telescope.builtin').current_buffer_fuzzy_find, {})
      vim.keymap.set('n', '<leader>fs', function()
        require('telescope.builtin').live_grep({
          search_dirs = { vim.fn.expand('%:p') },
        })
      end, {})
      vim.keymap.set('n', '<leader>ps', function()
        builtin.grep_string({ search = vim.fn.input("grep > ") })
      end)
      vim.keymap.set('n', '<leader>vh', builtin.help_tags, {})
      vim.keymap.set('n', 'gd', builtin.lsp_definitions, {})
      vim.keymap.set('n', 'gr', builtin.lsp_references, {})
      require("telescope").setup({
        extensions = {
          ["ui-select"] = {
            require("telescope.themes").get_dropdown {
            }
          },
          fzf = {},
          themes = {
            enable_live_preview = true,
            persist = {
              path = vim.fn.stdpath("config") .. "/lua/fruitninjaking/colors.lua"
            }
          }
        }
      })
      require('telescope').load_extension('fzf')
      require("telescope").load_extension("ui-select")
    end
  },
}
