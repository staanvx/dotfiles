#!/bin/sh

CLR_5="0xff85dc85"
CLR_4="0xff85dc85"
CLR_3="0xffe3c78a"
CLR_2="0xffff5d5d"
CLR_1="0xffff5d5d"
CLR_AC="0xff85dc85"
CLR_CHRG="0xff85dc85"

ICON_8=" "
ICON_7=" "
ICON_6=" "
ICON_5=" "
ICON_4=" "
ICON_3=" "
ICON_2=" "
ICON_1=" "
ICON_PLUG=" "
ICON_CHRG=" "

raw="$(pmset -g batt | grep -Eo '[0-9]+%|charging|charged|discharging|AC Power' | tr '\n' ' ')"

pct="$(echo "$raw" | grep -Eo '[0-9]+%' | tr -d '%')"
state="$(pmset -g batt | awk -F '; *' 'NR==2{print tolower($2)}')"

icon="$ICON_1"
if   (( pct >= 88 )); then icon="$ICON_8"
elif (( pct >= 75 )); then icon="$ICON_7"
elif (( pct >= 63 )); then icon="$ICON_6"
elif (( pct >= 50 )); then icon="$ICON_5"
elif (( pct >= 38 )); then icon="$ICON_4"
elif (( pct >= 25 )); then icon="$ICON_3"
elif (( pct >= 13 )); then icon="$ICON_2"
else                       icon="$ICON_1"
fi

color="$CLR_1"
if   (( pct >= 81 )); then color="$CLR_5"
elif (( pct >= 61 )); then color="$CLR_4"
elif (( pct >= 41 )); then color="$CLR_3"
elif (( pct >= 21 )); then color="$CLR_2"
else                       color="$CLR_1"
fi

if ["$state" == "charging"]; then
  color="$CLR_CHRG"
  prefix="$ICON_CHRG"
elif ["$state" == "ac power"]; then
  color="$CLR_AC"
  prefix="$ICON_PLUG"
elif ["$state" == "charged"]; then
  color="$CLR_CHRG"
  prefix="$ICON_PLUG"
else
  prefix=""
fi

icon_str="${prefix}${icon}"

sketchybar --set "$NAME" \
  icon="BAT" \
  icon.color="$color" \
  label="${pct}%" \
  label.color="$color"
