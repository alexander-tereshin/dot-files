#!/bin/sh

# Handle aerospace workspace change events
# FOCUSED_WORKSPACE is passed from aerospace via the event trigger

if [ "$SENDER" = "aerospace_workspace_change" ]; then
  WORKSPACES="1 2 3 4 5 6 7 8 9 T"

  for sid in $WORKSPACES; do
    if [ "$sid" = "$FOCUSED_WORKSPACE" ]; then
      sketchybar --set space."$sid" background.drawing=on icon.highlight=on
    else
      sketchybar --set space."$sid" background.drawing=off icon.highlight=off
    fi
  done
fi
