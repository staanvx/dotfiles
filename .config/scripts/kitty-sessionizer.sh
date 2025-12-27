#!/usr/bin/env bash

set -euo pipefail

SESSIONS_DIR="${1:-$HOME/.local/share/kitty/sessions}"

shopt -s nullglob

#mapfile -t files < <(printf '%s\n' "$SESSIONS_DIR"/*)

mapfile -t files < <(find "$SESSIONS_DIR" -type f -name '*.kitty-session' | sort)

((${#files[@]})) || exit 0

pick="$(printf '%s\n' "${files[@]}" |
    sed -e "s|^$SESSIONS_DIR/||" -e "s|\.kitty-session$||" |
    fzf --prompt='GO to > ' --margin 10%)"

[ -n "$pick" ] || exit 0

kitty @ action goto_session "$SESSIONS_DIR/$pick.kitty-session"
