return {
  "lukas-reineke/indent-blankline.nvim",
  main = "ibl", -- ★ 新しいバージョンでは ibl 名で呼び出す
  event = { "BufReadPost", "BufNewFile" },
  opts = {
    indent = {
      char = "│", -- インデント線の文字（例："▏", "│", "┆" など）
      tab_char = "│",
    },
    scope = {
      enabled = true,
      show_start = false,
      show_end = false,
    },
    whitespace = {
      remove_blankline_trail = true,
    },
  },
  config = function(_, opts)
    require("ibl").setup(opts)
  end,
}

