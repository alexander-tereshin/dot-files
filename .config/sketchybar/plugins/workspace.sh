#!/bin/sh

if [ "$SENDER" = "aerospace_workspace_change" ]; then
  sketchybar --set "$NAME" icon="$FOCUSED_WORKSPACE"
else
  # Initial load
  FOCUSED=$(aerospace list-workspaces --focused 2>/dev/null)
  if [ -n "$FOCUSED" ]; then
    sketchybar --set "$NAME" icon="$FOCUSED"
  fi
fi
