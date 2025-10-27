return {
  "nvim-treesitter/nvim-treesitter",
  build = ":TSUpdate",           -- プラグイン更新時に構文データも更新
  event = { "BufReadPost", "BufNewFile" },

  opts = {
    -- 解析を有効にしたい言語（必要に応じて追加OK）
    ensure_installed = {
      "lua", "vim", "bash", "python", "sql",
      "json", "yaml", "markdown", "markdown_inline",
      "javascript", "typescript", "html", "css",
    },

    highlight = { enable = true },    -- 構文ハイライト
    indent    = { enable = true },    -- インデント自動調整

    incremental_selection = {         -- 構文単位で選択範囲を拡張できる
      enable = true,
      keymaps = {
        init_selection    = "gnn",    -- 現在位置から選択開始
        node_incremental  = "grn",    -- 段階的に範囲拡大
        scope_incremental = "grc",
        node_decremental  = "grm",    -- 段階的に縮小
      },
    },
  },

  config = function(_, opts)
    require("nvim-treesitter.configs").setup(opts)
  end,
}

