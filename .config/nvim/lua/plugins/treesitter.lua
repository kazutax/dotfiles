return {
  "nvim-treesitter/nvim-treesitter",
  build = ":TSUpdate",
  cmd = { "TSInstall", "TSUpdate", "TSUninstall" },
  event = { "BufReadPost", "BufNewFile" },

  init = function()
    -- ① 新しいパーサ名 bigquery を登録
    local parser_config = require("nvim-treesitter.parsers").get_parser_configs()
    parser_config.bigquery = {
      install_info = {
        url = "https://github.com/takegue/tree-sitter-sql-bigquery",
        files = { "src/parser.c", "src/scanner.c" },
        branch = "main",
        use_git = true,  -- ← tarじゃなくgitで取る
      },
    }

    -- ② 「sqlファイルを開いたら bigquery パーサを使え」と教える
    vim.treesitter.language.register("bigquery", "sql")
  end,

  opts = {
    ensure_installed = {
      "lua", "vim", "bash", "python",
      -- "sql",  ← これ消す！ここにあるとまた公式sqlを取ろうとしてエラーになる
      "bigquery",  -- ← 代わりにこっち
      "json", "yaml", "markdown", "markdown_inline",
      "javascript", "typescript", "html", "css",
    },
    highlight = { enable = true },
    indent    = { enable = true },
    incremental_selection = {
      enable = true,
      keymaps = {
        init_selection    = "gnn",
        node_incremental  = "grn",
        scope_incremental = "grc",
        node_decremental  = "grm",
      },
    },
  },

  config = function(_, opts)
    require("nvim-treesitter.configs").setup(opts)
  end,
}
