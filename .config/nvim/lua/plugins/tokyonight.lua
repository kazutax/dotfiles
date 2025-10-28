return {
  "folke/tokyonight.nvim",
  lazy = false,
  priority = 1000,
  opts = {
    style = "storm",
    transparent = true,
    terminal_colors = true,

    styles = {
      comments = { italic = false },
      keywords = { italic = false },
      functions = { italic = false },
      variables = { italic = false },
    },
  },
  config = function(_, opts)
    require("tokyonight").setup(opts)
    vim.cmd("colorscheme tokyonight")
  end,
}

