#!/usr/bin/env bash

#TOPPROC=$(top -l 2 | grep -E "^CPU" | tail -1 | awk '{ print $3 + $5 }')

#LABEL=$(printf "%3.0f%%" "$TOPPROC")

#sketchybar --set "$NAME" label="$LABEL"

TOPPROC=$(top -l  2 | grep -E "^CPU" | tail -1 | awk '{ print $3 + $5"%" }' | cut -d "." -f1)

sketchybar --set $NAME label="$TOPPROC%"

