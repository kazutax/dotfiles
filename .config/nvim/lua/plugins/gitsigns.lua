return {
  "lewis6991/gitsigns.nvim",
  event = { "BufReadPre", "BufNewFile" }, -- ファイルを開いた時だけ読み込み
  config = function()
    require("gitsigns").setup({
      signs = {
        add          = { text = "▎" },
        change       = { text = "▎" },
        delete       = { text = "" },
        topdelete    = { text = "" },
        changedelete = { text = "▎" },
        untracked    = { text = "▎" },
      },
      signcolumn = true,
      numhl = false,
      linehl = false,
      word_diff = false,

      current_line_blame = false, -- デフォはOFF（<leader>gbでトグル）
      current_line_blame_opts = {
        virt_text = true,
        virt_text_pos = "eol",
        delay = 300,
        ignore_whitespace = true,
      },
      current_line_blame_formatter = "<author>, <author_time:%Y-%m-%d> • <summary>",

      preview_config = {
        border = "rounded",
        style = "minimal",
        relative = "cursor",
        row = 1,
        col = 1,
      },

      on_attach = function(bufnr)
        local gs = package.loaded.gitsigns

        -- 移動（diff時はデフォルトの ]c/[c を優先）
        vim.keymap.set("n", "]c", function()
          if vim.wo.diff then return "]c" end
          vim.schedule(gs.next_hunk)
          return "<Ignore>"
        end, { expr = true, buffer = bufnr, desc = "Next hunk" })

        vim.keymap.set("n", "[c", function()
          if vim.wo.diff then return "[c" end
          vim.schedule(gs.prev_hunk)
          return "<Ignore>"
        end, { expr = true, buffer = bufnr, desc = "Prev hunk" })

        -- アクション
        vim.keymap.set({ "n", "v" }, "<leader>hs", ":Gitsigns stage_hunk<CR>",   { buffer = bufnr, desc = "Stage hunk" })
        vim.keymap.set({ "n", "v" }, "<leader>hr", ":Gitsigns reset_hunk<CR>",   { buffer = bufnr, desc = "Reset hunk" })
        vim.keymap.set("n", "<leader>hS", gs.stage_buffer,                       { buffer = bufnr, desc = "Stage buffer" })
        vim.keymap.set("n", "<leader>hu", gs.undo_stage_hunk,                    { buffer = bufnr, desc = "Undo stage hunk" })
        vim.keymap.set("n", "<leader>hR", gs.reset_buffer,                       { buffer = bufnr, desc = "Reset buffer" })
        vim.keymap.set("n", "<leader>hp", gs.preview_hunk,                       { buffer = bufnr, desc = "Preview hunk" })
        vim.keymap.set("n", "<leader>hb", gs.toggle_current_line_blame,          { buffer = bufnr, desc = "Toggle blame (line)" })
        vim.keymap.set("n", "<leader>hd", gs.diffthis,                           { buffer = bufnr, desc = "Diff against index" })
        vim.keymap.set("n", "<leader>hD", function() gs.diffthis("~") end,       { buffer = bufnr, desc = "Diff against last commit" })

        -- トグル各種
        vim.keymap.set("n", "<leader>gt", gs.toggle_signs,                       { buffer = bufnr, desc = "Toggle signs" })
        vim.keymap.set("n", "<leader>gw", gs.toggle_word_diff,                   { buffer = bufnr, desc = "Toggle word-diff" })

        -- hunk 選択（ビジュアル選択に便利）
        vim.keymap.set("o", "ih", ":<C-U>Gitsigns select_hunk<CR>", { buffer = bufnr, desc = "Inner hunk" })
        vim.keymap.set("x", "ih", ":<C-U>Gitsigns select_hunk<CR>", { buffer = bufnr, desc = "Inner hunk" })
      end,
    })

    -- TokyoNight でサイン色を少しだけ馴染ませたい場合（任意）
    -- pcall(function()
    --   local c = require("tokyonight.colors").setup()
    --   vim.api.nvim_set_hl(0, "GitSignsAdd",          { fg = c.git.add })
    --   vim.api.nvim_set_hl(0, "GitSignsChange",       { fg = c.git.change })
    --   vim.api.nvim_set_hl(0, "GitSignsDelete",       { fg = c.git.delete })
    -- end)
  end,
}

