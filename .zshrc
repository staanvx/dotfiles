ZINIT_HOME="${XDG_DATA_HOME:-${HOME}/.local/share}/zinit/zinit.git"
[ ! -d $ZINIT_HOME ] && mkdir -p "$(dirname $ZINIT_HOME)"
[ ! -d $ZINIT_HOME/.git ] && git clone https://github.com/zdharma-continuum/zinit.git "$ZINIT_HOME"
source "${ZINIT_HOME}/zinit.zsh"


zinit light zsh-users/zsh-syntax-highlighting
zinit light zsh-users/zsh-completions
zinit light zsh-users/zsh-autosuggestions
zinit light Aloxaf/fzf-tab

# Load completions
autoload -Uz compinit && compinit -C

eval "$(starship init zsh)"

# Keybindings
bindkey -e
bindkey '^p' history-search-backward
bindkey '^n' history-search-forward

# History
HISTSIZE=5000
HISTFILE=~/.zsh_history
SAVEHIST=$HISTSIZE
HISTDUP=erase
setopt appendhistory
setopt sharehistory
setopt hist_ignore_space
setopt hist_ignore_all_dups
setopt hist_save_no_dups
setopt hist_ignore_dups
setopt hist_find_no_dups

# Completion styling
zstyle ':completion:*' matcher-list 'm:{a-z}={A-Za-z}'
zstyle ':completion:*' list-colors "${(s.:.)LS_COLORS}"
zstyle ':completion:*' menu no
zstyle ':fzf-tab:complete:cd:*' fzf-preview 'ls --color $realpath'
zstyle ':fzf-tab:complete:__zoxide_z:*' fzf-preview 'ls --color $realpath'

# TokyoNight theme
export FZF_DEFAULT_OPTS="$FZF_DEFAULT_OPTS \
  --highlight-line \
  --color=bg+:#283457 \
  --color=border:#27a1b9 \
  --color=fg:#c0caf5 \
  --color=gutter:#16161e \
  --color=header:#ff9e64 \
  --color=hl+:#2ac3de \
  --color=hl:#2ac3de \
  --color=info:#545c7e \
  --color=marker:#ff007c \
  --color=pointer:#ff007c \
  --color=prompt:#2ac3de \
  --color=query:#c0caf5:regular \
  --color=scrollbar:#27a1b9 \
  --color=separator:#ff9e64 \
  --color=spinner:#ff007c \
"

alias vim="nvim"alias vim="nvim"

alias doom="~/.config/emacs/bin/doom"

alias ls="eza --icons"

alias ll="eza -la --icons --git"

alias cat="bat"

alias cd="z"

alias lg="lazygit"

alias la="~/.config/scripts/launcher.sh"

alias lofi='mpv --no-video https://youtu.be/4xDzrJKXOOY'

export PATH="/opt/homebrew/opt/postgresql@17/bin:$PATH"
export PATH="$HOME/.local/share/bob/nvim-bin:$PATH"

export PATH="$HOME/.local/share/bob/nvim-bin:$PATH"
source <(fzf --zsh)
eval "$(zoxide init --cmd cd zsh)"

ksave() {
  kitty @ action save_as_session --relocatable "$PWD/$(basename "$PWD").kitty-session"
}

eval "$(zoxide init zsh)"
eval "$(starship init zsh)"

source <(fzf --zsh)

autoload -Uz add-zsh-hook

typeset -ga KITTY_TITLE_CMDS
KITTY_TITLE_CMDS=(
  nvim vim emacs
  ssh mosh
  htop top btop btm
  less more man
  ranger yazi lf
  tig gitui lazygit
  rmpc
)

_kitty_title_preexec() {
  emulate -L zsh
  local cmd=${1%% *}

  local c
  for c in $KITTY_TITLE_CMDS; do
    if [[ $cmd == $c ]]; then
      print -Pn "\e]0;${cmd}\a"
      return
    fi
  done

}

_kitty_title_precmd() {
  emulate -L zsh
  print -Pn '\e]0;zsh\a'
  # print -Pn '\e]0;%~\a'
}

add-zsh-hook preexec _kitty_title_preexec
add-zsh-hook precmd  _kitty_title_precmd
