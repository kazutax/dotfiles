return {
  "windwp/nvim-autopairs",
  event = "InsertEnter",  -- 挿入モードになったとき読み込み
  config = function()
    local autopairs = require("nvim-autopairs")
    autopairs.setup({
      check_ts = true,              -- Treesitter 連携（構文を見て補完制御）
      ts_config = {
        lua = { "string" },         -- Luaの文字列内では自動補完しない
        javascript = { "template_string" },
        java = false,
      },
      fast_wrap = {
        map = "<M-e>",              -- Alt+e で括弧を素早く閉じる
        chars = { "{", "[", "(", '"', "'" },
        pattern = [=[[%'%"%>%]%)%}%,]]=],
        end_key = "$",
        keys = "qwertyuiopzxcvbnmasdfghjkl",
        check_comma = true,
        highlight = "PmenuSel",
        highlight_grey = "LineNr",
      },
    })

    -- cmp（補完プラグイン）を使っている場合の連携設定
    local cmp_ok, cmp = pcall(require, "cmp")
    if cmp_ok then
      local cmp_autopairs = require("nvim-autopairs.completion.cmp")
      cmp.event:on("confirm_done", cmp_autopairs.on_confirm_done())
    end
  end,
}

