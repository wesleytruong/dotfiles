local ascii = require('fruitninjaking.lazy.ascii.ascii')

return {
  "folke/snacks.nvim",
  priority = 1000,
  lazy = false,
  ---@type snacks.Config
  opts = {
    picker = {
      sources = {
        lsp_definitions = { focus = "list" },
        lsp_references = { focus = "list" },
        lsp_type_definitions = { focus = "list" },
      },
    },
    image = {
      img_dirs = { "img", "images", "assets", "static", "public", "media", "attachments" },
      math = { enabled = false },
    },
    dashboard = {
      enabled = true,
      preset = {
        header = table.concat(ascii['pika'], "\n"),
        keys = {
          -- { icon = "󰺄 ", key = "f", desc = "Find File", action = ":lua Snacks.picker.files()" },
          { icon = " ", key = "e", desc = "New File", action = ":ene | startinsert" },
          -- { icon = " ", key = "s", desc = "Resume Last File", action = ":lua vim.cmd('e ' .. vim.v.oldfiles[1])" },
          -- { icon = "", key = "r", desc = "Recent Files", action = ":lua Snacks.picker.recent()" },
          { icon = " ", key = "g", desc = "Neogit", action = "<cmd>Neogit<cr>"},
          -- { icon = " ", key = "s", desc = "Grep Search", action = ":lua Snacks.picker.grep()" },
          { icon = " ", key = "c", desc = "Config", action = ":cd ~/.config/nvim | Explore" },
          { icon = "󰈆 ", key = "q", desc = "Quit", action = ":qa" },
        },
      },
      sections = {
        { section = "header" },
        { section = "keys", gap = 1, padding = 2 },
        { icon = " ", title = "Recent Files", section = "recent_files", indent = 2, padding = 2 },
        { section = "startup" },
      },
    },
  },
  keys = {
    {"<leader>fs", function() Snacks.picker.buffers() end, desc = "Buffers" },
    {"<leader>ps", function() Snacks.picker.grep() end, desc = "Grep" },
    {"<leader>pf", function() Snacks.picker.files() end, desc = "Find Files" },
    {"<leader>vh", function() Snacks.picker.help() end, desc = "Vim Help" },
    -- LSP
    { "gd", function() Snacks.picker.lsp_definitions() end, desc = "Goto Definition" },
    { "gr", function() Snacks.picker.lsp_references() end, nowait = true, desc = "References" },
    { "td", function() Snacks.picker.lsp_type_definitions() end, desc = "Goto Type Definition" },
    -- Misc
    { "<leader>cc", function() Snacks.picker.colorschemes({
      preview = "",
      confirm = function(picker, item)
        picker:close()
        if item then
          picker.preview.state.colorscheme = nil
          vim.schedule(function()
            vim.cmd("colorscheme " .. item.text)
            local file_path = vim.fn.expand("~/.config/nvim/lua/fruitninjaking/colors.lua")
            local file, err = io.open(file_path, "w")
            if file then
              file:write("vim.cmd('colorscheme " .. item.text .. "')")
              file:close()
            else
              print("Error writing to file: " .. (err or "unkown error"))
            end
          end)
        end
      end
    }) end, desc = "Colorschemes" },
  }
}
