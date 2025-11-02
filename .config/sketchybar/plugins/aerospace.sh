#!/usr/bin/env bash

if [ "$1" = "$FOCUSED_WORKSPACE" ]; then
  sketchybar --set $NAME label.color=0xffff00ff
else
  sketchybar --set $NAME label.color=0xffffffff
fi
