return {
  "EdenEast/nightfox.nvim",
  lazy = false,
  priority = 1000,
  config = function()
    require("nightfox").setup({
      options = {
        transparent = true,
        terminal_colors = true,
        dim_inactive = false,
        styles = {
          comments = "italic",
          keywords = "bold",
          types = "italic,bold",
        },
      },
    })

    -- 安全に適用（存在しない名前で落ちないように pcall）
    local ok = pcall(vim.cmd.colorscheme, "nordfox")
    if ok then
      -- 透過をより徹底（必要に応じて）
      vim.api.nvim_set_hl(0, "Normal",        { bg = "none" })
      vim.api.nvim_set_hl(0, "NormalNC",      { bg = "none" })
      vim.api.nvim_set_hl(0, "NormalFloat",   { bg = "none" })
      vim.api.nvim_set_hl(0, "FloatBorder",   { bg = "none" })
      vim.api.nvim_set_hl(0, "SignColumn",    { bg = "none" })
      vim.api.nvim_set_hl(0, "NvimTreeNormal",{ bg = "none" })
      vim.api.nvim_set_hl(0, "NvimTreeNormalNC",{ bg = "none" })
    end
  end,
}

