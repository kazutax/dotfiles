return {
  "simeji/winresizer",
  keys = {
    { "<leader>ee", "<Cmd>WinResizerStartResize<CR>", desc = "Start Window Resize Mode" },
  },
  config = function()
    -- winresizerの設定
    vim.g.winresizer_enable = 1
    vim.g.winresizer_gui_enable = 0  -- GUI Vimでは使用しない（必要に応じて1に変更）
    vim.g.winresizer_finish_with_escape = 1  -- Escキーで終了
    vim.g.winresizer_vert_resize = 10  -- 左右のリサイズ幅
    vim.g.winresizer_horiz_resize = 3  -- 上下のリサイズ幅
    -- winresizer_start_keyは使用しない（lazy.nvimのkeysで設定）
    vim.g.winresizer_keycode_left = 104   -- hキー（左に拡張）
    vim.g.winresizer_keycode_right = 108  -- lキー（右に拡張）
    vim.g.winresizer_keycode_down = 0     -- jキー（無効化）
    vim.g.winresizer_keycode_up = 0       -- kキー（無効化）
    vim.g.winresizer_keycode_finish = 13  -- Enterキー（確定）
    vim.g.winresizer_keycode_cancel = 113 -- qキー（キャンセル）
  end,
}

