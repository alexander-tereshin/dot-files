#!/bin/bash

# Handle aerospace workspace change events
# Called when workspace changes via: sketchybar --trigger aerospace_workspace_change FOCUSED_WORKSPACE=$AEROSPACE_FOCUSED_WORKSPACE

WORKSPACES="1 2 3 4 5 6 7 8 9 T"
DISPLAYS="1 2"

if [ "$SENDER" = "aerospace_workspace_change" ]; then
  for ws in $WORKSPACES; do
    for d in $DISPLAYS; do
      if [ "$ws" = "$FOCUSED_WORKSPACE" ]; then
        sketchybar --set space."$ws".d"$d" \
          icon.highlight=on \
          label.highlight=on \
          background.border_color=0xff181819
        sketchybar --set bracket."$ws".d"$d" background.border_color=0xff7f8490
      else
        sketchybar --set space."$ws".d"$d" \
          icon.highlight=off \
          label.highlight=off \
          background.border_color=0xff414550
        sketchybar --set bracket."$ws".d"$d" background.border_color=0xff414550
      fi
    done
  done
fi
