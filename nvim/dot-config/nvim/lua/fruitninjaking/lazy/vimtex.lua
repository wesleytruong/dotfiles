return {
  "lervag/vimtex",
  lazy = false,     -- we don't want to lazy load VimTeX
  -- tag = "v2.15", -- uncomment to pin to a specific release
  init = function()
    -- VimTeX configuration goes here, e.g.
    vim.g.vimtex_view_method = "zathura"

    local opts = {}

    vim.keymap.set("n", "<leader>c", "<cmd>VimtexCompile<cr>", opts)
    vim.keymap.set("n", "<leader>p", "<cmd>VimtexView<cr>", opts)
    vim.keymap.set("n", "<leader>x", "<cmd>VimtexClean<cr>", opts)
  end
}
