return {
  "nvim-tree/nvim-tree.lua",
  lazy = false,
  dependencies = { "nvim-tree/nvim-web-devicons" },
  keys = {
    { "<leader>e", "<cmd>NvimTreeToggle<CR>", desc = "Toggle file explorer" },
  },
  config = function()
    require("nvim-tree").setup({
      view = { width = 36 },
      renderer = {
        indent_markers = { enable = true },
        highlight_git = true,
        icons = {
          show = { file = true, folder = true, folder_arrow = true, git = true },
          glyphs = {
            default = "",
            symlink = "",
            folder = { default = "", open = "", empty = "", empty_open = "", symlink = "" },
            git = { unstaged = "", staged = "", unmerged = "", renamed = "", untracked = "", deleted = "", ignored = "" },
          },
        },
      },
      filters = { dotfiles = false },
      git = { enable = true, ignore = false },
      sync_root_with_cwd = true,
      update_focused_file = { enable = true, update_root = true },
      actions = { change_dir = { enable = true, restrict_above_cwd = false } },
    })

    -- nvim-treeが開かれたときにカラーテーマのハイライトを確実に適用
    local function refresh_nvim_tree_highlights()
      -- カラーテーマが設定されている場合のみ実行
      if vim.g.colors_name then
        -- nvim-tree関連のハイライトグループを明示的に再適用
        -- カラーテーマを再適用することで、nvim-treeのハイライトも確実に読み込まれる
        vim.cmd("colorscheme " .. vim.g.colors_name)
        
        -- nightfoxなどの透過設定を再適用（存在する場合）
        local ok = pcall(function()
          vim.api.nvim_set_hl(0, "NvimTreeNormal", { bg = "none" })
          vim.api.nvim_set_hl(0, "NvimTreeNormalNC", { bg = "none" })
        end)
      end
    end

    -- nvim-treeが開かれたときにハイライトを適用
    vim.api.nvim_create_autocmd({ "BufEnter", "WinEnter" }, {
      pattern = "NvimTree_*",
      callback = function()
        vim.schedule(function()
          refresh_nvim_tree_highlights()
        end)
      end,
    })
  end,
}

