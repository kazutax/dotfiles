return {
  -- Snippet engine
  {
    "L3MON4D3/LuaSnip",
    version = "v2.*",
    build = "make install_jsregexp", -- 正規表現拡張（任意だが推奨）
    dependencies = {
      "rafamadriz/friendly-snippets",
    },
    config = function()
      local ls = require("luasnip")
      -- VSCode形式 & Lua形式の両方をロード
      require("luasnip.loaders.from_vscode").lazy_load()
      require("luasnip.loaders.from_lua").lazy_load({ paths = { vim.fn.stdpath("config") .. "/lua/snippets" } })

      ls.config.set_config({
        history = true,
        updateevents = "TextChanged,TextChangedI",
        enable_autosnippets = true,
      })

      -- キーマップ（Tabで展開/ジャンプ、Shift-Tabで戻る、Ctrl-lで次候補）
      vim.keymap.set({ "i", "s" }, "<Tab>", function()
        return ls.expand_or_jumpable() and "<Plug>luasnip-expand-or-jump" or "<Tab>"
      end, { expr = true, silent = true })
      vim.keymap.set({ "i", "s" }, "<S-Tab>", function() ls.jump(-1) end, { silent = true })
      vim.keymap.set({ "i", "s" }, "<C-l>", function() if ls.choice_active() then ls.change_choice(1) end end, { silent = true })
    end,
  },

  -- nvim-cmp 側で snippet 展開を LuaSnip に委譲
  {
    "hrsh7th/nvim-cmp",
    dependencies = { "saadparwaiz1/cmp_luasnip" },
    opts = function(_, opts)
      opts.snippet = {
        expand = function(args) require("luasnip").lsp_expand(args.body) end,
      }
      table.insert(opts.sources, { name = "luasnip" })
      return opts
    end,
  },
}

