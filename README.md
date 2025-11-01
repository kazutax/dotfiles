# dotfiles (macOS)

個人用のシェル・Neovim・Zsh の設定一式。Git 管理したものをそのまま各マシンにリンクして使う想定。

---

## 1. 前提

- macOS (Apple Silicon / Intel)
- Xcode Command Line Tools
  ```bash
  xcode-select --install
  ```
- Homebrew
  ```bash
  /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
  ```

---

## 2. 必要な Homebrew

```bash
brew install git neovim ripgrep fd fzf
brew tap homebrew/cask-fonts
brew install --cask font-meslo-lg-nerd-font
```

- `neovim` … メイン
- `ripgrep` / `fd` … Telescope で使うので必須
- `fzf` … Zsh からも使う
- フォントは **MesloLGM Nerd Font** を想定（iTerm2 / Terminal のフォントで指定する）

---

## 3. クローン & サブモジュール

```bash
mkdir -p ~/Git
cd ~/Git
git clone https://github.com/kazutax/dotfiles.git
cd dotfiles

# oh-my-zsh をサブモジュールで取得
git submodule update --init --recursive
```

※ `.oh-my-zsh` はリポジトリ直下にサブモジュールとして入れてあるので、↑を必ず実行すること。

---

## 4. リンクするもの

基本は「ホームディレクトリにあるものが Git 配下を見る」ようにする。

```bash
# Neovim
mkdir -p ~/.config
ln -s ~/Git/dotfiles/.config/nvim ~/.config/nvim

# Zsh (既存がある場合は退避)
[ -f ~/.zshrc ] && mv ~/.zshrc ~/.zshrc.bak.$(date +%Y%m%d-%H%M%S)
cat <<'EOF' > ~/.zshrc
# dotfiles 版
export DOTFILES_DIR="$HOME/Git/dotfiles"
export ZSH="$DOTFILES_DIR/.oh-my-zsh"
source "$DOTFILES_DIR/zsh/common.zsh"
EOF
```

これで `~/.zshrc` は Git 管理された `zsh/common.zsh` を読む。`oh-my-zsh` もリポジトリ内を見に行く。

---

## 5. Neovim 初回起動

1. `nvim` を起動
2. Lazy.nvim が自動で立ち上がるのでインストールを待つ
3. 終わったら以下を実行

```vim
:Lazy sync
:TSUpdate
```

Treesitter のダウンロードまで終われば OK。

---

## 6. ターミナルのフォント設定

1. iTerm2 → Profiles → Text
2. Font: **MesloLGM Nerd Font** を選択
3. Powerline/glyph のダブり表示があるときは「Use built-in Powerline glyphs」をオフ
4. 再起動で Neovim のアイコンが全部出る

※ 他の端末でも同じフォントを入れれば崩れない。

---

## 7. よく変えるところ

- `~/.config/nvim/lua/plugins/` … プラグイン追加・トグル
- `zsh/custom/` … 自分用テーマ・補完など
- `.gitignore` … 各端末で生成されるファイルを増やしたいとき

変更したら普通に Git でコミット:

```bash
cd ~/Git/dotfiles
git status
git add ...
git commit -m "update: nvim/zsh config"
git push
```

---

## 8. よくあるエラー

- **アイコンが□になる** → フォントが MesloLGM Nerd Font になってない
- **`.oh-my-zsh` が無いと言われる** → `git submodule update --init --recursive` を忘れている
- **Neovim のツリーが開かない** → `ripgrep` / `fd` のインストール確認

---

## 9. ライセンスとか

個人用です。会社のトークンや固有のパスは入れないでください。
