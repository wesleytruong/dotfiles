return {
  -- {
  --   "tpope/vim-fugitive",
  --   config = function()
  --     vim.keymap.set("n", "<leader>gs", vim.cmd.Git)
  --
  --     local ThePrimeagen_Fugitive = vim.api.nvim_create_augroup("ThePrimeagen_Fugitive", {})
  --
  --     local autocmd = vim.api.nvim_create_autocmd
  --     autocmd("BufWinEnter", {
  --       group = ThePrimeagen_Fugitive,
  --       pattern = "*",
  --       callback = function()
  --         if vim.bo.ft ~= "fugitive" then
  --           return
  --         end
  --
  --         local bufnr = vim.api.nvim_get_current_buf()
  --         local opts = {buffer = bufnr, remap = false}
  --         vim.keymap.set("n", "<leader>p", function()
  --           vim.cmd.Git('push')
  --         end, opts)
  --
  --         -- rebase always
  --         vim.keymap.set("n", "<leader>P", function()
  --           vim.cmd.Git({'pull',  '--rebase'})
  --         end, opts)
  --
  --         -- NOTE: It allows me to easily set the branch i am pushing and any tracking
  --         -- needed if i did not set the branch up correctly
  --         vim.keymap.set("n", "<leader>t", ":Git push -u origin ", opts);
  --       end,
  --     })
  --
  --
  --     vim.keymap.set("n", "gu", "<cmd>diffget //2<CR>")
  --     vim.keymap.set("n", "gh", "<cmd>diffget //3<CR>")
  --   end
  -- }
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
      vim.keymap.set('n', '<leader>gp', gitsigns.preview_hunk, {})
      vim.keymap.set('n', '<leader>gb', function() gitsigns.blame_line{full=true} end)
    end
  }
}
