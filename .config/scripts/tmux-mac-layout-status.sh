#!/bin/bash

state=$(defaults read ~/Library/Preferences/com.apple.HIToolbox.plist AppleSelectedInputSources | grep \
  "KeyboardLayout Name" | cut -f 2 -d "=" | tr -d ' ;."')

case "$state" in
  ABC)            printf " en" ;;
  Russian)        printf " ru" ;;
  *)              printf ""  ;;
esac
