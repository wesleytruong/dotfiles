return {
  {
    "sphamba/smear-cursor.nvim",
    opts = {
      -- smear_between_neighbor_lines = false,
      stiffness = 1,
      trailing_stiffness = 0.3,
      legacy_computing_symbols_support = true, -- removes shadow for transparent bgs
    },
  },
  {
    "karb94/neoscroll.nvim",
    opts = {
      duration_multiplier = 0.3,
    },
  }
}
