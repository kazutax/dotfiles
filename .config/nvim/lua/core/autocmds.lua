local aug = vim.api.nvim_create_augroup("CoreAutocmds", { clear = true })
vim.api.nvim_create_autocmd("TextYankPost", {
  group = aug,
  callback = function() vim.highlight.on_yank() end,
})

-- ターミナルが開いたときに自動的にターミナルモードに入る
vim.api.nvim_create_autocmd("TermOpen", {
  group = aug,
  callback = function()
    vim.schedule(function()
      vim.cmd("startinsert")
    end)
  end,
})

-- ターミナルウィンドウにフォーカスが移ったときにも自動的にターミナルモードに入る
vim.api.nvim_create_autocmd("WinEnter", {
  group = aug,
  callback = function()
    if vim.bo.buftype == "terminal" and vim.api.nvim_get_mode().mode ~= "t" then
      vim.schedule(function()
        vim.cmd("startinsert")
      end)
    end
  end,
})

