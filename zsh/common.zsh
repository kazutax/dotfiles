# oh-my-zsh の場所を dotfiles 側に固定
if [ -d "$HOME/Git/dotfiles/.oh-my-zsh" ]; then
  export ZSH="$HOME/Git/dotfiles/.oh-my-zsh"
elif [ -d "$HOME/git/dotfiles/.oh-my-zsh" ]; then
  export ZSH="$HOME/git/dotfiles/.oh-my-zsh"
fi

# ここがポイント：自前のテーマ・プラグイン置き場
export ZSH_CUSTOM="$HOME/Git/dotfiles/zsh/custom"

# 使うテーマ
ZSH_THEME="cobalt2"

plugins=(git)

if [ -d "$ZSH" ]; then
  source "$ZSH/oh-my-zsh.sh"
fi
