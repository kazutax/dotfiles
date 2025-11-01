return {
  "sphamba/smear-cursor.nvim",
  event = "VeryLazy",
  config = function()
    require("smear_cursor").setup({
      -- 好みで調整
      stiffness = 0.3,
      trailing = true,
      smear_length = 6,
    })
  end,
}

