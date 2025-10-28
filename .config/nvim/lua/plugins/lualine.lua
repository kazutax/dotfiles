return {
  "nvim-lualine/lualine.nvim",
  dependencies = { "nvim-tree/nvim-web-devicons" },
  event = "VeryLazy",
  config = function()
    require("lualine").setup({
      options = {
        theme = "tokyonight-storm",  -- TokyoNightの配色を継承
        section_separators = { left = "", right = "" },
        component_separators = { left = "", right = "" },
        icons_enabled = true,
        globalstatus = true,   -- ステータスラインを全体に適用
        disabled_filetypes = { "NvimTree", "lazy", "toggleterm" },
      },
      sections = {
        lualine_a = { "mode" },
        lualine_b = { "branch", "diff", "diagnostics" },
        lualine_c = {
          {
            "filename",
            path = 1,       -- 相対パス表示 (0=ファイル名のみ, 2=絶対パス)
            symbols = { modified = "", readonly = "" },
          },
        },
        lualine_x = { "encoding", "fileformat", "filetype" },
        lualine_y = { "progress" },
        lualine_z = { "location" },
      },
      inactive_sections = {
        lualine_a = {},
        lualine_b = {},
        lualine_c = { "filename" },
        lualine_x = { "location" },
        lualine_y = {},
        lualine_z = {},
      },
      extensions = { "nvim-tree", "toggleterm", "quickfix" },
    })
  end,
}

