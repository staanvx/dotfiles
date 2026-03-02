#!/usr/bin/env bash

if [ "$1" = "$FOCUSED_WORKSPACE" ]; then
  sketchybar --set $NAME background.color=0xff7fdbca label.color=0xff000000
else
  sketchybar --set $NAME background.color=0xff000000 label.color=0xffacb4c2
fi
