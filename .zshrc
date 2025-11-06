source /opt/homebrew/share/zsh-autosuggestions/zsh-autosuggestions.zsh

source /opt/homebrew/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh

source /opt/homebrew/opt/zsh-fast-syntax-highlighting/share/zsh-fast-syntax-highlighting/fast-syntax-highlighting.plugin.zsh

if [[ -n $SSH_CONNECTION ]]; then
  export EDITOR='vim'
else
  export EDITOR='nvim'
fi

export FZF_DEFAULT_OPTS="$FZF_DEFAULT_OPTS \
  --color bg:#011627 \
  --color bg+:#0e293f \
  --color border:#2c3043 \
  --color fg:#acb4c2 \
  --color fg+:#d6deeb \
  --color gutter:#0e293f \
  --color header:#82aaff \
  --color hl+:#f78c6c \
  --color hl:#f78c6c \
  --color info:#ecc48d \
  --color marker:#f78c6c \
  --color pointer:#ff5874 \
  --color prompt:#82aaff \
  --color spinner:#21c7a8
"

alias vim="nvim"

alias doom="~/.config/emacs/bin/doom"

alias ls="eza --icons"

alias ll="eza -la --icons --git"

alias cat="bat"

alias cd="z"

alias lg="lazygit"

export PATH="/opt/homebrew/opt/postgresql@17/bin:$PATH"
export PATH="$HOME/.local/share/bob/nvim-bin:$PATH"

eval "$(zoxide init zsh)"
eval "$(starship init zsh)"

cal
