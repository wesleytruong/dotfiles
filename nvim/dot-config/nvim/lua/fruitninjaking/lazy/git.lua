return {
  {
    "folke/snacks.nvim",
    opts = {
      gitbrowse = {
        what = "file",
      },
    },
    keys = {
      { "gh", function() Snacks.gitbrowse.open() end, mode = { "n", "x" }, desc = "Open line in GitHub" },
      { "gH", function() Snacks.gitbrowse.open({ what = "permalink" }) end, mode = { "n", "x" }, desc = "Open permalink in GitHub" },
    },
  },
  {
    "kdheepak/lazygit.nvim",
    lazy = true,
    cmd = {
        "LazyGit",
        "LazyGitConfig",
        "LazyGitCurrentFile",
        "LazyGitFilter",
        "LazyGitFilterCurrentFile",
    },
    -- optional for floating window border decoration
    dependencies = {
        "nvim-lua/plenary.nvim",
    },
    -- setting the keybinding for LazyGit with 'keys' is recommended in
    -- order to load the plugin when the command is run for the first time
    keys = {
        { "<leader>lg", "<cmd>LazyGit<cr>", desc = "LazyGit" }
    }
  },
  {
    'lewis6991/gitsigns.nvim',
    config = function()
      require('gitsigns').setup()
      local gitsigns = require('gitsigns')
      vim.keymap.set('n', '<leader>gp', gitsigns.preview_hunk, { desc = "Preview hunk"})
      vim.keymap.set('n', '<leader>gb', function() gitsigns.blame_line{full=true} end, { desc = "Git blame"})
    end
  },
  {
    "sindrets/diffview.nvim",
    keys = {
      {
        '<leader>gd', "<cmd>DiffviewOpen<cr>", desc = "DiffviewOpen"
      },
      { '<leader>dh', "<cmd>DiffviewFileHistory %<cr>", desc = "Diffview Current File's History"},
    },
    opts = {
      default_args = {
        DiffviewOpen = { "--untracked-files=normal" },
      },
      keymaps = {
        view = { { "n", "q", "<cmd>DiffviewClose<cr>", { desc = "Close Diffview" } } },
        file_panel = { { "n", "q", "<cmd>DiffviewClose<cr>", { desc = "Close Diffview" } } },
        file_history_panel = { { "n", "q", "<cmd>DiffviewClose<cr>", { desc = "Close Diffview" } } },
      },
    },
  },
  {
    "NeogitOrg/neogit",
    lazy = true,
    dependencies = {
      "nvim-lua/plenary.nvim",
      "sindrets/diffview.nvim",
      "folke/snacks.nvim",
    },
    cmd = "Neogit",
    keys = {
      { "<leader>ng", "<cmd>Neogit<cr>", desc = "Show Neogit UI" }
    }
  }
}
