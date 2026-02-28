#!/usr/bin/env bash

set -euo pipefail

dirs=(
  "/Applications"
  "$HOME/Applications"
  "/System/Applications"
)

files=()

for d in "${dirs[@]}"; do
  [[ -d "$d" ]] || continue

  while IFS= read -r -d '' p; do
    files+=("$p")
  done < <(find -L "$d" -maxdepth 1 -mindepth 1 -name '*.app' ! -name '.*' -print0 2>/dev/null)
done

(( ${#files[@]} )) || exit 0

pick="$(printf '%s\n' "${files[@]}" |
        sort |
        sed "s|^$HOME|~|" |
        fzf --prompt='open > ' --margin=5% --layout=reverse)"

[ -n "$pick" ] || exit 0

[[ "$pick" == "~"* ]] && pick="${pick/#\~/$HOME}"

open "$pick"
