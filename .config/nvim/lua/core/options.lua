local o = vim.opt
o.number = true
o.relativenumber = false
o.clipboard = "unnamedplus"
o.ignorecase = true
o.smartcase = true
o.signcolumn = "yes"
o.termguicolors = true
o.updatetime = 200
o.swapfile = false
o.undofile = true
o.splitright = true
o.splitbelow = true
o.scrolloff = 4
o.wrap = false
o.tabstop = 4
o.shiftwidth = 4
o.expandtab = true
o.splitright = true
o.splitbelow = false

-- 不可視文字を表示
o.list = true

-- どんな記号で表示するか設定
o.listchars = {
  tab = "▸ ",      -- タブを ▸ とスペースで表示
  trail = "·",     -- 行末の余分なスペースを ·
  extends = "❯",   -- 折り返し記号（行が右に続くとき）
  precedes = "❮",  -- 折り返し記号（行が左に続くとき）
  space = "·",     -- 半角スペースを · で表示（好みで）
}

o.equalalways = false

