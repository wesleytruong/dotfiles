return {
    'goolord/alpha-nvim',
    dependencies = {
        'nvim-tree/nvim-web-devicons',
        'nvim-lua/plenary.nvim'
    },
    config = function ()
      -- require'alpha'.setup(require'alpha.themes.theta'.config)
      local dashboard = require("alpha.themes.dashboard")

      local ascii = require('fruitninjaking.lazy.ascii.ascii')

      dashboard.section.header.val = ascii['anime']

      dashboard.section.buttons.val = {
        dashboard.button("f", "󰺄  Find file", ":Telescope find_files <CR>"),
        dashboard.button("e", "  New file", ":ene <BAR> startinsert <CR>"),
        dashboard.button("r", "  Recently used files", ":Telescope oldfiles <CR>"),
        dashboard.button("t", "  Find text", ":Telescope live_grep <CR>"),
        dashboard.button("c", "  Configuration", ":cd ~/.config/nvim | Explore<CR>"),
        dashboard.button("q", "󰈆  Quit Neovim", ":qa<CR>"),
      }

      require('alpha').setup(dashboard.opts)
    end
};
