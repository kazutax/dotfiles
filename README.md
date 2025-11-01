# 🧰 dotfiles setup guide

## 1. 前提環境
- macOS
- Homebrew インストール済み
- zsh を利用（bash は非対応）

---

## 2. 必要なフォント
```bash
brew tap homebrew/cask-fonts
brew install --cask font-meslo-lg-nerd-font
```

iTerm2 / Alacritty / Warp などのターミナルで **MesloLGL Nerd Font** を指定してください。

---

## 3. クローン & サブモジュール

```bash
mkdir -p ~/Git
cd ~/Git

# すべてのサブモジュールを含めてクローン
git clone --recursive https://github.com/kazutax/dotfiles.git
cd dotfiles
```

このリポジトリには以下のサブモジュールが含まれます：

- `.oh-my-zsh` … oh-my-zsh 本体  
- `zsh/custom/plugins/zsh-autosuggestions` … コマンド補完  
- `zsh/custom/plugins/zsh-syntax-highlighting` … 構文ハイライト  

他マシンでクローン後、サブモジュールを更新するには：

```bash
git submodule update --init --recursive
```

---

## 4. シンボリックリンク設定

```bash
cat <<'EOF' > ~/.zshrc
# load from dotfiles
if [ -f "$HOME/Git/dotfiles/zsh/common.zsh" ]; then
  source "$HOME/Git/dotfiles/zsh/common.zsh"
fi
EOF
```

反映して確認：

```bash
exec zsh
```

---

## 5. プロンプトテーマ

- テーマ: `cobalt2`
- 定義場所: `zsh/custom/themes/cobalt2.zsh-theme`

見た目が青基調のハイコントラストスタイルになればOKです。

---

## 6. Neovim 設定

設定は `~/.config/nvim` 以下に配置。  
初期設定は `init.lua` と `lua/` ディレクトリ配下で管理。

---

## 7. よくあるコマンド

### サブモジュールを最新化
```bash
git submodule update --remote --merge
```

### dotfiles の更新を反映
```bash
cd ~/Git/dotfiles
git pull --recurse-submodules
```

---

## 8. よくあるエラー

| 症状 | 対処 |
|------|------|
| **アイコンが□になる** | フォントが MesloLGM Nerd Font になっていない |
| **`.oh-my-zsh` が無いと言われる** | `git submodule update --init --recursive` を実行 |
| **プラグインが効かない** | `zsh/custom/plugins` のサブモジュール更新を確認 |
| **テーマが読み込まれない** | `$ZSH` パスが `~/Git/dotfiles/.oh-my-zsh` か確認 |
| **Neovim のツリーが開かない** | `ripgrep` / `fd` が未インストール → `brew install ripgrep fd` |

---

## 9. 更新時の注意

- `.oh-my-zsh` や `zsh/custom/plugins` はサブモジュールなので、`git pull` だけでは更新されません。
- 変更を試す前に `.zshrc` のバックアップを取っておくと安全です：

```bash
cp ~/.zshrc ~/.zshrc.bak.$(date +%Y%m%d-%H%M%S)
```

---

## 10. ライセンスとか

このリポジトリは **個人用 dotfiles** です。  
社内トークンや固有のパスなど、機密情報は含めないようにしてください。
