#!/usr/bin/env bash

state=$(rmpc status | jq -r '.state' 2>/dev/null | tr '[:upper:]' '[:lower:]')

label=""
icon=""

case "$state" in
  play|playing)
    label="playing"
    ;;
  pause|paused)
    label="paused "
    ;;
  stop|stopped)
    label="stopped"
    ;;
  *)
    label=""
    ;;
esac

sketchybar --set "$NAME" icon="$icon" label="$label"
