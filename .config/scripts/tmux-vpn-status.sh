#!/bin/bash

if netstat -rn | grep -qE "utun[0-9].*0/1|128.0/1"; then
    printf "#[fg=#8cc85f]󰒃 on #[default]"
else
    printf "#[fg=#ffcc66]󰒃 off#[default]"
fi
