# ============================================
# common.zsh  (loaded from your ~/.zshrc など)
# ============================================

# dotfiles の場所
DOTFILES_DIR="$HOME/Git/dotfiles"

# oh-my-zsh (サブモジュール)
export ZSH="$DOTFILES_DIR/.oh-my-zsh"
export ZSH_CUSTOM="$DOTFILES_DIR/zsh/custom"
ZSH_THEME="cobalt2"

# oh-my-zsh 標準プラグイン
plugins=(
  git
  history-substring-search
)

# oh-my-zsh 本体を読む
if [ -f "$ZSH/oh-my-zsh.sh" ]; then
  source "$ZSH/oh-my-zsh.sh"
else
  echo "[warn] oh-my-zsh.sh が見つかりません: $ZSH/oh-my-zsh.sh"
fi

# ------------------------------------------------
# 外部プラグイン（dotfiles 側で submodule 管理するやつ）
#   git submodule add https://github.com/zsh-users/zsh-autosuggestions.git \
#     zsh/custom/plugins/zsh-autosuggestions
#   git submodule add https://github.com/zsh-users/zsh-syntax-highlighting.git \
#     zsh/custom/plugins/zsh-syntax-highlighting
# ------------------------------------------------
ZSH_EXTRA_PLUGINS_DIR="$DOTFILES_DIR/zsh/custom/plugins"

# autosuggestions
if [ -f "$ZSH_EXTRA_PLUGINS_DIR/zsh-autosuggestions/zsh-autosuggestions.zsh" ]; then
  source "$ZSH_EXTRA_PLUGINS_DIR/zsh-autosuggestions/zsh-autosuggestions.zsh"
  # (必要なら) 候補を受け入れるキーを変える例：
  # bindkey '^ ' autosuggest-accept
else
  echo "[info] zsh-autosuggestions はまだありません"
fi

# syntax-highlighting は最後に読むのが鉄則
if [ -f "$ZSH_EXTRA_PLUGINS_DIR/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh" ]; then
  source "$ZSH_EXTRA_PLUGINS_DIR/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh"
else
  echo "[info] zsh-syntax-highlighting はまだありません"
fi

# ------------------------------------------------
# 好きなエイリアスとか
# ------------------------------------------------
alias ll='ls -la'
alias gs='git status'

# 履歴設定（お好みで）
HISTSIZE=10000
SAVEHIST=10000
HISTFILE="$HOME/.zsh_history"
setopt share_history
setopt hist_ignore_dups
setopt hist_reduce_blanks

