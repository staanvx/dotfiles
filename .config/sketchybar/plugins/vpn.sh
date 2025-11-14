#!/usr/bin/env bash

if netstat -rn | grep -qE "utun[0-9].*0/1|128.0/1"; then
    color="0xff00b35a"
    state="ON "
else
    color="0xfffc514e"
    state="OFF"
fi

sketchybar --set $NAME icon=󰒃  icon.color="$color" label="$state" label.color="$color"
