# dotfiles – Neovim Setup (macOS)

任意のマシンで **Neovim 環境を再現**するための手順です。  
（Lazy.nvim、Telescope、nvim-tree、LuaSnip、Treesitter、Nightfox、ToggleTerm、indent-blankline など）

## 0. 前提

- macOS（Apple Silicon / Intel どちらでもOK）
- Homebrew  
  ```bash
  /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
  ```

## 1. 必須ツールのインストール

```bash
brew install git neovim ripgrep fd
```

- `ripgrep (rg)`: Telescope の `live_grep` に必須  
- `fd`: Telescope の `find_files` を高速化（無くても可だが推奨）

## 2. リポジトリをクローン

```bash
mkdir -p ~/git
cd ~/git
git clone https://github.com/<YOUR_GITHUB_USERNAME>/dotfiles.git
```

> SSH を使う場合：  
> `git clone git@github.com:<YOUR_GITHUB_USERNAME>/dotfiles.git`

## 3. シンボリックリンクを張る

Neovim の設定を `~/.config/nvim` にリンクします。

```bash
mkdir -p ~/.config
ln -s ~/git/dotfiles/.config/nvim ~/.config/nvim
```

> すでに `~/.config/nvim` が存在する場合は、バックアップしてからリンク：
> ```bash
> mv ~/.config/nvim ~/.config/nvim.bak.$(date +%Y%m%d-%H%M%S)
> ln -s ~/git/dotfiles/.config/nvim ~/.config/nvim
> ```

## 4. Neovim を初回起動 → プラグイン同期

Neovim を起動して Lazy.nvim が自動セットアップされるのを確認後、以下を実行：

```vim
:Lazy sync
:TSUpdate
```

- `:Lazy sync` … プラグインのインストール/更新  
- `:TSUpdate` … Treesitter パーサのダウンロード/更新

## 5. よく使うキーバインド（抜粋）

**ファイラー（nvim-tree）**
- `Space e` … 開閉（必要に応じて `~/git` をルートにする専用マップもあり）
- ツリー内移動：`j/k`、開く：`<CR>`、新規：`a`、削除：`d`、リネーム：`r`

**検索（Telescope）**
- `Space ff` … ファイル検索  
- `Space fg` … テキスト検索（ripgrep）  
- `Space fb` … バッファ一覧  
- `Space fh` … ヘルプ

**ターミナル（toggleterm）**
- `` Ctrl + ` `` または `Space t` … 開閉

**スニペット（LuaSnip）**
- 展開：`<Tab>`（出ないときは `Ctrl-k`）  
- 次/前プレースホルダ：`Tab` / `Shift-Tab`

## 6. スニペット（配置と動作）

自作スニペットの配置パス：  
```
~/.config/nvim/lua/snippets/
  ├─ all.lua
  ├─ sql.lua        ← BigQuery 用（例：withq, scast, rown）
  └─ python.lua …等
```

編集後の反映は **Neovim 再起動**が手っ取り早いです。  
（または `:lua require('luasnip.loaders.from_lua').lazy_load()`）

## 7. テーマ（Nightfox）

- デフォルトは `nordfox`（透明度ON）  
- 変更する場合は `lua/plugins/nightfox.lua` の `colorscheme` を書き換えて `:Lazy sync` → 再起動  
- 透明感をさらに出すなら iTerm2 側で **Transparency 10–15%** + **Blur** を推奨

## 8. トラブルシューティング

- **Telescope の検索が動かない** → `ripgrep`/`fd` インストール確認（`rg --version`, `fd --version`）  
- **Treesitter のハイライトが効かない** → `:TSUpdate` 実行  
- **スニペットが展開しない**  
  - `:verbose imap <Tab>` で Tab のマップ競合を確認  
  - `:lua print(pcall(require,'luasnip'))` が `true` か確認  
  - `:set filetype?` が `sql` など適切か確認（`filetype_extend` 済ならOK）

## 9. iTerm2 など外部ツールの設定（任意）

- **最大化/フルスクリーン**：iTerm2 側で「起動時にフルスクリーン」設定  
- **フォント**：JetBrains Mono / SFMono Nerd Font など絵文字/アイコン対応推奨  
- **透明度/ブラー**：テーマ透明と併用で良い感じに

## 10. 更新・運用

- プラグイン更新：` :Lazy sync `  
- 依存ツール更新：`brew upgrade`  
- 設定を変えたらコミット＆プッシュ：
  ```bash
  cd ~/git/dotfiles
  git add .config/nvim
  git commit -m "tweak: update nvim config"
  git push
  ```

---

### ライセンス / 注意
- このリポジトリの設定は個人用途向けです。社内コード等は含めないでください。  
- もしチーム共有用にする場合は、個人依存（ユーザー名、絶対パス、トークンなど）を排除すること。

---


