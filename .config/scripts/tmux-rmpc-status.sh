#!/bin/bash

state=$(rmpc status | jq -r '.state' | tr '[:upper:]' '[:lower:]')

case "$state" in
  play|playing)   printf " playing" ;;
  pause|paused)   printf " paused" ;;
  stop|stopped)   printf " stopped" ;;
  *)              printf ""  ;;
esac
