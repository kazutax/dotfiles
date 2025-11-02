return {
  "RRethy/vim-illuminate",
  event = { "BufReadPost", "BufNewFile" },
  config = function()
    require("illuminate").configure({
      providers = {
        "lsp",           -- LSPからシンボル情報を取得
        "treesitter",    -- 構文ベース（補完的に）
        "regex",         -- フォールバック
      },
      delay = 200,         -- ハイライトまでの遅延(ms)
      filetypes_denylist = {
        "NvimTree",
        "TelescopePrompt",
        "alpha",
        "lazy",
        "mason",
        "help",
      },
      under_cursor = true, -- カーソル下もハイライト
    })
  end,
}

