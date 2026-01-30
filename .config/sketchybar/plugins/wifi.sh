#!/bin/sh

WIFI_STATUS=$(ifconfig en0 2>/dev/null | grep "status: active")

if [ -n "$WIFI_STATUS" ]; then
  sketchybar --set "$NAME" icon=󰖩 label.drawing=off
else
  sketchybar --set "$NAME" icon=󰖪 label.drawing=off
fi
