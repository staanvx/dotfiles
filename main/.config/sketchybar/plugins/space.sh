#!/bin/sh

#sketchybar --set "$NAME" background.drawing="$SELECTED"
if [ $SELECTED = true ]; then
  sketchybar --set $NAME background.drawing=on \
                         background.color=0xffff00ff \
                         label.color=0xff000000 \
                         icon.color=0xff000000
else
  sketchybar --set $NAME background.drawing=off \
                         label.color=0xffffffff \
                         icon.color=0xffffffff
fi
