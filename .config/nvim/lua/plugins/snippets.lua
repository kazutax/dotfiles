return {
  -- snippet engine
  {
    "l3mon4d3/luasnip",
    version = "v2.*",
    build = "make install_jsregexp", -- 正規表現拡張（任意だが推奨）
    dependencies = {
      "rafamadriz/friendly-snippets", -- vscode形式のスニペット集
      "saadparwaiz1/cmp_luasnip", -- nvim-cmp との統合
    },
    config = function()
      local ls = require("luasnip")
      
      -- vscode形式 & lua形式の両方をロード
      -- friendly-snippets (デフォルトのスニペット集)
      require("luasnip.loaders.from_vscode").lazy_load()
      
      -- カスタムのvscode形式JSONスニペットを読み込む
      -- ファイル形式: ~/.config/nvim/snippets/{filetype}.json
      local custom_snippets_path = vim.fn.stdpath("config") .. "/snippets"
      
      -- カスタムスニペットディレクトリを読み込む
      -- lazy_loadではなく、明示的に読み込む
      local loader = require("luasnip.loaders.from_vscode")
      
      -- スニペットを読み込む（すべてのファイルタイプ）
      pcall(function()
        loader.load({ paths = { custom_snippets_path } })
      end)
      
      -- ファイルタイプ変更時にスニペットを読み込む
      vim.api.nvim_create_autocmd("FileType", {
        pattern = "*",
        callback = function()
          pcall(function()
            loader.load({ paths = { custom_snippets_path } })
          end)
        end,
      })
      
      -- バッファに入ったときにもスニペットを読み込む（再オープン時も対応）
      vim.api.nvim_create_autocmd("BufEnter", {
        pattern = "*",
        callback = function()
          local ft = vim.bo.filetype
          if ft and ft ~= "" then
            pcall(function()
              loader.load({ paths = { custom_snippets_path } })
            end)
          end
        end,
      })
      
      -- バッファを読み込んだときにもスニペットを読み込む
      vim.api.nvim_create_autocmd("BufRead", {
        pattern = "*",
        callback = function()
          local ft = vim.bo.filetype
          if ft and ft ~= "" then
            pcall(function()
              loader.load({ paths = { custom_snippets_path } })
            end)
          end
        end,
      })
      
      -- デバッグ用: スニペットが読み込まれたか確認
      vim.api.nvim_create_user_command("ReloadSnippets", function()
        loader.load({ paths = { custom_snippets_path } })
        print("Snippets reloaded from: " .. custom_snippets_path)
      end, {})
      
      -- デバッグ用: スニペット一覧を表示
      vim.api.nvim_create_user_command("ListSnippets", function()
        local ft = vim.bo.filetype
        local snippets = ls.get_snippets(ft)
        print("Filetype: " .. ft)
        if snippets then
          local count = 0
          for _, snippet in pairs(snippets) do
            count = count + 1
            local name = snippet.name or snippet.trigger or "unknown"
            print("  " .. count .. ": " .. tostring(name))
          end
          print("Total: " .. count .. " snippets")
        else
          print("No snippets found for " .. ft)
        end
      end, {})
      
      -- Lua形式のスニペットを読み込む
      require("luasnip.loaders.from_lua").lazy_load({
        paths = { vim.fn.stdpath("config") .. "/lua/snippets" },
      })

      ls.config.set_config({
        history = true,
        updateevents = "textchanged,textchangedi",
        enable_autosnippets = true,
      })

      -- キーマップ（補完メニューが表示されている場合はcmpが処理するため、ここでは設定しない）
      -- cmp側でTab/Shift+Tabを処理するため、LuaSnipのキーマップは補完メニュー非表示時のみ動作する

      vim.keymap.set({ "i", "s" }, "<C-l>", function()
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

      -- ② sources がなければ作る
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
    config = function(_, opts)
      local cmp = require("cmp")
      local luasnip = require("luasnip")
      
      -- mapping を設定（補完メニュー表示時は補完の選択を優先）
      opts.mapping = opts.mapping or cmp.mapping.preset.insert({
        ["<Tab>"] = cmp.mapping(function(fallback)
          if cmp.visible() then
            -- 補完メニューが表示されている場合、次の候補を選択
            cmp.select_next_item()
          elseif luasnip.expand_or_jumpable() then
            -- スニペットが展開可能な場合、展開またはジャンプ
            luasnip.expand_or_jump()
          else
            fallback()
          end
        end, { "i", "s" }),
        
        ["<S-Tab>"] = cmp.mapping(function(fallback)
          if cmp.visible() then
            -- 補完メニューが表示されている場合、前の候補を選択
            cmp.select_prev_item()
          elseif luasnip.jumpable(-1) then
            -- スニペット内でジャンプ可能な場合、前の位置へ
            luasnip.jump(-1)
          else
            fallback()
          end
        end, { "i", "s" }),
        
        ["<CR>"] = cmp.mapping(function(fallback)
          if cmp.visible() then
            -- 補完メニューが表示されている場合
            local entry = cmp.get_selected_entry()
            if entry then
              -- 候補が選択されている場合、確定
              cmp.confirm({ select = false })
            else
              -- 候補が選択されていない場合、閉じて通常の改行
              cmp.close()
              fallback()
            end
          else
            -- 補完メニューが表示されていない場合、通常のEnter動作
            fallback()
          end
        end, { "i", "s" }),
      })
      
      cmp.setup(opts)

      -- 補完確定時にスニペットを自動展開
      cmp.event:on("confirm_done", function(event)
        local entry = event.entry
        -- luasnipソースから選択された場合
        if entry and entry.source.name == "luasnip" then
          vim.schedule(function()
            local completion_item = entry:get_completion_item()
            local trigger = completion_item.label or entry.completion_item.label
            
            if trigger then
              -- 少し待ってからスニペットを展開
              vim.defer_fn(function()
                -- 現在のカーソル位置と行を取得
                local cursor = vim.api.nvim_win_get_cursor(0)
                local line = vim.api.nvim_get_current_line()
                local col = cursor[2] + 1  -- 0-indexed to 1-indexed
                
                -- カーソル位置から左側のテキストを取得
                local line_before_cursor = line:sub(1, col)
                
                -- トリガー名がカーソル位置に一致するか確認
                local trigger_match = line_before_cursor:match(trigger:gsub("[%-%.%+%*%?%^%$%(%)%[%]%%]", "%%%0") .. "$")
                
                if trigger_match then
                  -- トリガー名全体を削除
                  local trigger_len = #trigger
                  local new_col = math.max(0, col - trigger_len)
                  
                  -- トリガー名を削除
                  local new_line = line:sub(1, new_col) .. line:sub(col + 1)
                  vim.api.nvim_set_current_line(new_line)
                  vim.api.nvim_win_set_cursor(0, { cursor[1], new_col })
                  
                  -- 少し待ってからトリガー名を再挿入してスニペットを展開
                  vim.defer_fn(function()
                    -- トリガー名を挿入
                    vim.api.nvim_feedkeys(
                      vim.api.nvim_replace_termcodes(trigger, true, false, true),
                      "i",
                      false
                    )
                    
                    -- スニペットを展開
                    vim.defer_fn(function()
                      if luasnip.expand_or_jumpable() then
                        luasnip.expand_or_jump()
                      end
                    end, 50)
                  end, 20)
                else
                  -- トリガー名が見つからない場合は直接展開を試みる
                  vim.defer_fn(function()
                    if luasnip.expand_or_jumpable() then
                      luasnip.expand_or_jump()
                    end
                  end, 10)
                end
              end, 10)
            end
          end)
        end
      end)
    end,
  },
}

