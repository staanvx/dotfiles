#!/bin/bash

state=$(rmpc status | jq -r '.state' | tr '[:upper:]' '[:lower:]')

case "$state" in
  play|playing)   printf "" ;;
  pause|paused)   printf "" ;;
  stop|stopped)   printf "" ;;
  *)              printf ""  ;;
esac
