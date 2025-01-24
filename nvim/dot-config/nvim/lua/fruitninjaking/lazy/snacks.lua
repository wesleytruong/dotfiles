return {
  "folke/snacks.nvim",
  ---@type snacks.Config
  opts = {
    picker = {},
  },
  keys = {
    -- Find
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
            local file, err = io.open("lua/fruitninjaking/colors.lua", "w")
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
