#!/usr/bin/env bash

# Берём первую строку "KeyboardLayout Name = ...", вытаскиваем значение
layout="$(
  defaults read com.apple.HIToolbox AppleSelectedInputSources 2>/dev/null \
  | awk -F'= ' '/KeyboardLayout Name/ {gsub(/[;" ]/, "", $2); print $2; exit}'
)"

case "$layout" in
  ABC|U.S.)          label=" en" ;;
  Russian|Русская)   label=" ru" ;;
  *)                 label=""     ;;
esac

sketchybar --set "$NAME" label="$label"
