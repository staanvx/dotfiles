#!/usr/bin/env bash

state=$(defaults read ~/Library/Preferences/com.apple.HIToolbox.plist AppleSelectedInputSources | grep \
  "KeyboardLayout Name" | cut -f 2 -d "=" | tr -d ' ;."')

case "$state" in
  ABC)            state="EN" ;;
  Russian)        state="RU" ;;
  *)              state=""  ;;
esac

sketchybar --set "$NAME" label="${state}"

