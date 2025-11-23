vim.g.mapleader = " "
local map = vim.keymap.set
local opts = { noremap = true, silent = true }

map("n", "<leader>t", function()
  -- 現在の作業ディレクトリを取得
  local cwd = vim.fn.getcwd()
  -- 横分割
  vim.cmd("sp")
  -- 下に移動
  vim.cmd("wincmd J")
  -- ターミナルを開く（CWDを保持）
  vim.fn.termopen(vim.o.shell, {
    cwd = cwd,
  })
  -- ターミナルバッファの設定
  vim.cmd("setlocal noequalalways")
  -- ターミナルが開いた後に確実にターミナルモードに入る（オートコマンドの補完）
  vim.defer_fn(function()
    local buf = vim.api.nvim_get_current_buf()
    if vim.bo[buf].buftype == "terminal" then
      vim.cmd("startinsert")
    end
  end, 20)
end, { desc = "Open Terminal below" })
map('t', '<Esc><Esc>', [[<C-\><C-n>:q<CR>]], { noremap = true, silent = true, desc = "Close Terminal" })

map("n", "<leader>w", "<cmd>w<CR>", opts)
map("n", "<leader>q", "<cmd>q<CR>", opts)
map("n", "<leader>h", "<C-w>h", opts)
map("n", "<leader>j", "<C-w>j", opts)
map("n", "<leader>k", "<C-w>k", opts)
map("n", "<leader>l", "<C-w>l", opts)

map("n", "<leader>nh", ":nohl<CR>", { desc = "Clear search highlights" })

map("n", "<leader>sv", "<C-w>v", { desc = "Split window vertically" })
map("n", "<leader>sx", "<cmd>close<CR>", { desc = "Close current split window " })

map("n", "<leader>c", function()
  require("Comment.api").toggle.linewise.current()
end, { desc = "Toggle comment" })

map("x", "<leader>c", function()
  local esc = vim.api.nvim_replace_termcodes("<ESC>", true, false, true)
  vim.api.nvim_feedkeys(esc, "nx", false)
  require("Comment.api").toggle.linewise(vim.fn.visualmode())
end, { desc = "Toggle comment (visual)" })

-- Command + / でコメントアウト（ターミナルアプリの設定で Command + / を無効化する必要があります）
map("n", "<D-/>", function()
  require("Comment.api").toggle.linewise.current()
end, { desc = "Toggle comment" })

map("x", "<D-/>", function()
  local esc = vim.api.nvim_replace_termcodes("<ESC>", true, false, true)
  vim.api.nvim_feedkeys(esc, "nx", false)
  require("Comment.api").toggle.linewise(vim.fn.visualmode())
end, { desc = "Toggle comment (visual)" })


