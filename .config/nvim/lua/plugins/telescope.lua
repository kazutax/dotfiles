return {
  "nvim-telescope/telescope.nvim",
  version = "*",
  dependencies = { "nvim-lua/plenary.nvim" },

  -- 使うときだけ読み込む（起動直後のエラー回避）
  cmd = "Telescope",
  keys = {
    { "<leader>ff", function() require("telescope.builtin").find_files() end, desc = "Find Files" },
    { "<leader>fg", function() require("telescope.builtin").live_grep()  end, desc = "Live Grep"  },
    { "<leader>fb", function() require("telescope.builtin").buffers()    end, desc = "Buffers"    },
    { "<leader>fh", function() require("telescope.builtin").help_tags()  end, desc = "Help Tags"  },
  },

  opts = {
    defaults = {
      prompt_prefix = "🔍 ",
      selection_caret = "➤ ",
      path_display = { "smart" },
      layout_config = { prompt_position = "top" },
      sorting_strategy = "ascending",

      -- 検索コマンド
      vimgrep_arguments = {
        "rg", "--color=never", "--no-heading", "--with-filename",
        "--line-number", "--column", "--smart-case",
      },

      -- ★ 検索結果を右ペインへ（toggleterm/NvimTreeは除外）
      get_selection_window = function()
        local wins = vim.api.nvim_list_wins()
        for _, win in ipairs(wins) do
          local buf = vim.api.nvim_win_get_buf(win)
          local ft = vim.bo[buf].filetype
          if ft ~= "NvimTree" and ft ~= "toggleterm" then
            return win
          end
        end
        return 0
      end,
    },
  },

  config = function(_, opts)
    -- ここは telescope 本体が読み込まれた後に実行されるので require OK
    require("telescope").setup(opts)
  end,
}

