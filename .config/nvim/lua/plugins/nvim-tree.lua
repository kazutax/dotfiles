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
  end,
}

