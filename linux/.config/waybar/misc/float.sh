#!/usr/bin/env bash

pkill waybar

sleep 0.2

waybar -c ~/.config/waybar/misc/config-float.jsonc &
