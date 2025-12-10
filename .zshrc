source /opt/homebrew/share/zsh-autosuggestions/zsh-autosuggestions.zsh

source /opt/homebrew/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh

source /opt/homebrew/opt/zsh-fast-syntax-highlighting/share/zsh-fast-syntax-highlighting/fast-syntax-highlighting.plugin.zsh

if [[ -n $SSH_CONNECTION ]]; then
  export EDITOR='vim'
else
  export EDITOR='nvim'
fi

export FZF_DEFAULT_OPTS=" \
--color=bg+:#313244,bg:#1E1E2E,spinner:#F5E0DC,hl:#F38BA8 \
--color=fg:#CDD6F4,header:#F38BA8,info:#CBA6F7,pointer:#F5E0DC \
--color=marker:#B4BEFE,fg+:#CDD6F4,prompt:#CBA6F7,hl+:#F38BA8 \
--color=selected-bg:#45475A \
--color=border:#6C7086,label:#CDD6F4"

bindkey -e

alias vim="nvim"

alias doom="~/.config/emacs/bin/doom"

alias ls="eza --icons"

alias ll="eza -la --icons --git"

alias cat="bat"

alias cd="z"

alias lg="lazygit"

alias la="~/.config/scripts/launcher.sh"

export PATH="/opt/homebrew/opt/postgresql@17/bin:$PATH"
export PATH="$HOME/.local/share/bob/nvim-bin:$PATH"

eval "$(zoxide init zsh)"
eval "$(starship init zsh)"

source <(fzf --zsh)

autoload -Uz add-zsh-hook

# Команды, для которых хотим менять заголовок
typeset -ga KITTY_TITLE_CMDS
KITTY_TITLE_CMDS=(
  nvim vim
  ssh mosh
  htop top btop btm
  less more man
  ranger yazi lf
  tig gitui lazygit
  rmpc
)

# Перед выполнением команды — если она из списка, ставим её в title
_kitty_title_preexec() {
  emulate -L zsh
  local cmd=${1%% *}   # первое слово команды

  local c
  for c in $KITTY_TITLE_CMDS; do
    if [[ $cmd == $c ]]; then
      print -Pn "\e]0;${cmd}\a"
      return
    fi
  done

  # для остальных команд ничего не делаем → никакого мигания
}

# Когда возвращаемся на промпт — ставим "zsh" или директорию
_kitty_title_precmd() {
  emulate -L zsh
  # вариант 1: просто zsh
  print -Pn '\e]0;zsh\a'
  # вариант 2: показать cwd
  # print -Pn '\e]0;%~\a'
}

add-zsh-hook preexec _kitty_title_preexec
add-zsh-hook precmd  _kitty_title_precmd
