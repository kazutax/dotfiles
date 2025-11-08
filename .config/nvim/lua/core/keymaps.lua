vim.g.mapleader = " "
local map = vim.keymap.set
local opts = { noremap = true, silent = true }

map("n", "<leader>t", function()
  -- 現在の作業ディレクトリを取得
  local cwd = vim.fn.getcwd()
  -- 横分割（spは下に開く）
  vim.cmd("sp")
  -- 分割直後のウィンドウIDを取得（新しいウィンドウは既に下に開かれている）
  local new_win_id = vim.api.nvim_get_current_win()
  -- ウィンドウが確実に作成された後に高さを設定（少し待ってから）
  vim.defer_fn(function()
    -- 最低限の高さ（1行）に設定
    pcall(function()
      vim.api.nvim_win_set_height(new_win_id, 1)
    end)
  end, 10)
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
    -- ターミナルが開いた後にも高さを1行に再設定（確実に）
    pcall(function()
      local final_win = vim.api.nvim_get_current_win()
      vim.api.nvim_win_set_height(final_win, 1)
    end)
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

-- 現在のバッファを別のウィンドウに移動
local function move_buffer_to_window(direction)
  local current_win = vim.api.nvim_get_current_win()
  local current_buf = vim.api.nvim_get_current_buf()
  local target_win = nil
  
  -- 指定方向にウィンドウがあるか確認
  local wincmd_map = {
    left = "h",
    right = "l",
    up = "k",
    down = "j"
  }
  
  -- 指定方向にウィンドウがあるか確認
  local saved_win = vim.api.nvim_get_current_win()
  vim.cmd("wincmd " .. wincmd_map[direction])
  target_win = vim.api.nvim_get_current_win()
  vim.api.nvim_set_current_win(saved_win)
  
  -- 指定方向にウィンドウがなければ作成
  if target_win == current_win then
    if direction == "left" or direction == "right" then
      vim.cmd("vsplit")
    else
      vim.cmd("split")
    end
    -- 新しいウィンドウを取得
    local wins = vim.api.nvim_list_wins()
    for _, win in ipairs(wins) do
      if win ~= current_win then
        target_win = win
        break
      end
    end
    -- 元のウィンドウに戻る
    vim.api.nvim_set_current_win(current_win)
  end
  
  if target_win and target_win ~= current_win then
    -- 現在のバッファをターゲットウィンドウに移動
    vim.api.nvim_win_set_buf(target_win, current_buf)
    -- 元のウィンドウには別のバッファを表示（バッファリストから最初の有効なバッファ）
    local bufs = vim.api.nvim_list_bufs()
    local alt_buf = nil
    for _, buf in ipairs(bufs) do
      if buf ~= current_buf and vim.api.nvim_buf_is_valid(buf) and vim.bo[buf].buflisted then
        alt_buf = buf
        break
      end
    end
    -- 別のバッファが見つからない場合は空のバッファを表示
    if alt_buf then
      vim.api.nvim_win_set_buf(current_win, alt_buf)
    else
      vim.cmd("enew")
    end
    -- ターゲットウィンドウにフォーカスを移動
    vim.api.nvim_set_current_win(target_win)
  end
end

map("n", "<leader>mh", function() move_buffer_to_window("left") end, { desc = "Move buffer to left window" })
map("n", "<leader>mj", function() move_buffer_to_window("down") end, { desc = "Move buffer to bottom window" })
map("n", "<leader>mk", function() move_buffer_to_window("up") end, { desc = "Move buffer to top window" })
map("n", "<leader>ml", function() move_buffer_to_window("right") end, { desc = "Move buffer to right window" })

map("n", "<leader>c", function()
  require("Comment.api").toggle.linewise.current()
end, { desc = "Toggle comment" })

map("x", "<leader>c", function()
  local esc = vim.api.nvim_replace_termcodes("<ESC>", true, false, true)
  vim.api.nvim_feedkeys(esc, "nx", false)
  require("Comment.api").toggle.linewise(vim.fn.visualmode())
end, { desc = "Toggle comment (visual)" })


