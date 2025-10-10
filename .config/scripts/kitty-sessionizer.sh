#!/usr/bin/env bash

set -euo pipefail

SESSIONS_DIR="${1:-$HOME/.config/kitty/sessions}"

shopt -s nullglob

#mapfile -t files < <(printf '%s\n' "$SESSIONS_DIR"/*)

mapfile -t files < <(find "$SESSIONS_DIR" -type f -name '*.kitty-session' | sort)

((${#files[@]})) || exit 0

pick="$(printf '%s\n' "${files[@]}" |
    sed "s|^$HOME/.config/kitty/||" |
    sk --prompt='GO to > ' --margin 10% --color=dark,matched:#00FF00,current:#ff5189,current_bg:#000000,prompt:#36c692)"

[ -n "$pick" ] || exit 0

kitty @ action goto_session "$pick"
