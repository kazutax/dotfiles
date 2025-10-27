return {
  "nvim-telescope/telescope.nvim",
  version = "*",
  dependencies = { "nvim-lua/plenary.nvim" },

  keys = (function()
    -- 🔹 Telescope 起動前に通常ウィンドウへフォーカスを戻す関数
    local function goto_normal_window()
      for _, win in ipairs(vim.api.nvim_list_wins()) do
        local buf = vim.api.nvim_win_get_buf(win)
        local ft  = vim.bo[buf].filetype
        if ft ~= "NvimTree" and ft ~= "toggleterm" then
          vim.api.nvim_set_current_win(win)
          return
        end
      end
    end

    local tb = require("telescope.builtin")
    return {
      { "<leader>ff", function() goto_normal_window(); tb.find_files() end, desc = "Find Files" },
      { "<leader>fg", function() goto_normal_window(); tb.live_grep()  end, desc = "Live Grep (search text)" },
      { "<leader>fb", function() goto_normal_window(); tb.buffers()    end, desc = "List Buffers" },
      { "<leader>fh", function() goto_normal_window(); tb.help_tags()  end, desc = "Help Tags" },
    }
  end)(),

  opts = {
    defaults = {
      prompt_prefix     = "🔍 ",
      selection_caret   = "➤ ",
      path_display      = { "smart" },
      layout_config     = { prompt_position = "top" },
      sorting_strategy  = "ascending",

      -- 🔸 検索結果の開き先ウィンドウを制御
      get_selection_window = function()
        for _, win in ipairs(vim.api.nvim_list_wins()) do
          local buf = vim.api.nvim_win_get_buf(win)
          local ft  = vim.bo[buf].filetype
          if ft ~= "NvimTree" and ft ~= "toggleterm" then
            return win
          end
        end
        return 0 -- fallback
      end,
    },
  },
}

