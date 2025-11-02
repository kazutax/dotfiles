return {
  -- snippet engine
  {
    "l3mon4d3/luasnip",
    version = "v2.*",
    build = "make install_jsregexp", -- 正規表現拡張（任意だが推奨）
    dependencies = {
      "rafamadriz/friendly-snippets",
    },
    config = function()
      local ls = require("luasnip")
      -- vscode形式 & lua形式の両方をロード
      require("luasnip.loaders.from_vscode").lazy_load()
      require("luasnip.loaders.from_lua").lazy_load({
        paths = { vim.fn.stdpath("config") .. "/lua/snippets" },
      })

      ls.config.set_config({
        history = true,
        updateevents = "textchanged,textchangedi",
        enable_autosnippets = true,
      })

      -- キーマップ
      vim.keymap.set({ "i", "s" }, "<tab>", function()
        return ls.expand_or_jumpable() and "<plug>luasnip-expand-or-jump" or "<tab>"
      end, { expr = true, silent = true })

      vim.keymap.set({ "i", "s" }, "<s-tab>", function()
        ls.jump(-1)
      end, { silent = true })

      vim.keymap.set({ "i", "s" }, "<c-l>", function()
        if ls.choice_active() then
          ls.change_choice(1)
        end
      end, { silent = true })
    end,
  },

  -- nvim-cmp 側で snippet 展開を LuaSnip に委譲
  {
    "hrsh7th/nvim-cmp",
    dependencies = { "saadparwaiz1/cmp_luasnip" },
    opts = function(_, opts)
      -- ① opts 自体が nil の場合に備える
      opts = opts or {}

      -- ② sources がなければ作る ← これが今回の本題
      opts.sources = opts.sources or {}

      -- ③ snippet ハンドラを設定
      opts.snippet = {
        expand = function(args)
          require("luasnip").lsp_expand(args.body)
        end,
      }

      -- ④ sources に LuaSnip を足す
      table.insert(opts.sources, { name = "luasnip" })

      return opts
    end,
  },
}

