return {
  "akinsho/bufferline.nvim",
  version = "*",
  dependencies = {
    "nvim-tree/nvim-web-devicons",
    "folke/tokyonight.nvim", -- ★ Tokyonight を依存にして順序を保証
  },
  event = "VeryLazy",
  config = function()
    -- --- Tokyonight 由来の配色を安全に取得 -----------------------------
    local highlights = {}
    local ok_groups, groups = pcall(require, "tokyonight.groups")
    if ok_groups then
      local ok_cfg, cfg = pcall(require, "tokyonight.config")
      -- Tokyonight の options が未初期化でも落ちないようにフォールバック
      local opts = (ok_cfg and cfg and cfg.options) or {
        style = "storm",       -- ★ あなたのメインが storm なので既定を storm に
        transparent = true,
        terminal_colors = true,
      }
      local ok_hl, hl = pcall(groups.setup, opts)
      if ok_hl and hl and hl.bufferline then
        highlights = hl.bufferline
      end
    end
    -- -------------------------------------------------------------------

    require("bufferline").setup({
      options = {
        mode = "buffers", -- "tabs" も可
        numbers = "none",
        diagnostics = "nvim_lsp",
        separator_style = "slant",
        show_close_icon = false,
        show_buffer_close_icons = true,
        always_show_bufferline = true,
        color_icons = true,
        indicator = { style = "underline" },
        offsets = {
          {
            filetype = "NvimTree",
            text = "File Explorer",
            highlight = "Directory",
            separator = true,
          },
        },
      },
      highlights = highlights, -- Tokyonight の配色を適用（安全に）
    })

    -- お好みのキーバインド
    vim.keymap.set("n", "<S-l>", "<cmd>BufferLineCycleNext<CR>", { desc = "Next buffer" })
    vim.keymap.set("n", "<S-h>", "<cmd>BufferLineCyclePrev<CR>", { desc = "Prev buffer" })
    vim.keymap.set("n", "<leader>bd", "<cmd>bdelete<CR>", { desc = "Close buffer" })
  end,
}

