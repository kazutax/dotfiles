return {
  "akinsho/toggleterm.nvim",
  version = "*",
  lazy = false,
  keys = {
    { "<C-`>", "<cmd>ToggleTerm direction=horizontal<CR>", desc = "Toggle terminal (bottom)" },
    { "<leader>t", "<cmd>ToggleTerm direction=horizontal<CR>", desc = "Toggle terminal (bottom)" },
  },
  opts = {
    size = 12,
    direction = "horizontal",
    shade_terminals = true,
    persist_size = true,
    start_in_insert = true,
    close_on_exit = true,
  },
  config = function(_, opts)
    require("toggleterm").setup(opts)
  end,
}

