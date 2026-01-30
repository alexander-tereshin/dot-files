#!/bin/sh

# Toggle calendar popup
if [ "$SENDER" = "mouse.clicked" ]; then
  sketchybar --set "$NAME" popup.drawing=toggle
fi
