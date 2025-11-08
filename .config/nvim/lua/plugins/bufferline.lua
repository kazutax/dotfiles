return {
  "akinsho/bufferline.nvim",
  version = "*",
  dependencies = {
    "nvim-tree/nvim-web-devicons",
    -- "folke/tokyonight.nvim", -- ← あってもいいけど必須じゃないようにした
  },
  event = "VeryLazy",
  config = function()
    -- Tokyonight があれば色をもらう（なくても落ちない）
    local highlights = {}
    local ok_groups, groups = pcall(require, "tokyonight.groups")
    if ok_groups then
      local ok_cfg, cfg = pcall(require, "tokyonight.config")
      local opts = (ok_cfg and cfg and cfg.options) or {
        style = "storm",
        transparent = true,
        terminal_colors = true,
      }
      local ok_hl, hl = pcall(groups.setup, opts)
      if ok_hl and hl and hl.bufferline then
        highlights = hl.bufferline
      end
    end

    require("bufferline").setup({
      options = {
        mode = "buffers",
        numbers = "none",
        diagnostics = "nvim_lsp",

        -- ★ VSCode/BigQuery っぽくフラットに
        separator_style = "thin", -- ← "none" でもOK
        show_buffer_close_icons = false, -- 通常は出さず
        show_close_icon = false,

        -- ★ タブにマウス乗せたら ✕ を出す
        hover = {
          enabled = true,
          delay = 150,
          reveal = { "close" },
        },

        always_show_bufferline = true,
        color_icons = true,
        indicator = {
          style = "underline", -- VSCodeっぽい「下線だけ」
        },

        -- 左に NvimTree があるときの余白
        offsets = {
          {
            filetype = "NvimTree",
            text = "File Explorer",
            highlight = "Directory",
            separator = true,
          },
        },

        -- ちょいコンパクトにしてVSCode寄せ
        max_name_length = 22,
        tab_size = 18,
      },
      highlights = highlights,
    })

    --  移動ショートカット
    vim.keymap.set("n", "<S-l>", "<cmd>BufferLineCycleNext<CR>", { desc = "Next buffer" })
    vim.keymap.set("n", "<S-h>", "<cmd>BufferLineCyclePrev<CR>", { desc = "Prev buffer" })
    vim.keymap.set("n", "<Left>", "<cmd>BufferLineCyclePrev<CR>", { desc = "Prev buffer" })
    vim.keymap.set("n", "<Right>", "<cmd>BufferLineCycleNext<CR>", { desc = "Next buffer" })
    vim.keymap.set("n", "<leader>bd", "<cmd>bdelete<CR>", { desc = "Close buffer" })
  end,
}

