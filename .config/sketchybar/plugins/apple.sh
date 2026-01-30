#!/bin/sh

export LANG=en_US.UTF-8

# Get system info
MACOS=$(sw_vers -productVersion)
UPTIME=$(uptime | sed 's/.*up //' | sed 's/,.*//' | xargs)
DISK=$(df -H / | awk 'NR==2 {print $3 "/" $2 " (" $5 ")"}')
IP=$(ipconfig getifaddr en0 2>/dev/null || echo "No IP")

sketchybar --set apple.macos label="macOS $MACOS" \
           --set apple.uptime label="$UPTIME" \
           --set apple.disk label="$DISK" \
           --set apple.ip label="$IP"
