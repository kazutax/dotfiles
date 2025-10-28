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

    -- 🧭 移動ショートカット（便利！）
    vim.keymap.set("n", "<A-n>", function()
      require("illuminate").next_reference({ wrap = true })
    end, { desc = "Next reference (same word)" })

    vim.keymap.set("n", "<A-p>", function()
      require("illuminate").next_reference({ reverse = true, wrap = true })
    end, { desc = "Prev reference (same word)" })
  end,
}

