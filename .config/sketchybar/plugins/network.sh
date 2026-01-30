#!/bin/sh

INTERFACE="en0"

# Get current bytes
BYTES_IN=$(netstat -ib | grep -e "$INTERFACE" -m 1 | awk '{print $7}')
BYTES_OUT=$(netstat -ib | grep -e "$INTERFACE" -m 1 | awk '{print $10}')

# Cache file
CACHE=/tmp/sketchybar_network

# Read previous values
if [ -f "$CACHE" ]; then
  PREV_IN=$(cat "$CACHE" | head -1)
  PREV_OUT=$(cat "$CACHE" | tail -1)
else
  PREV_IN=$BYTES_IN
  PREV_OUT=$BYTES_OUT
fi

# Save current values
echo "$BYTES_IN" > "$CACHE"
echo "$BYTES_OUT" >> "$CACHE"

# Calculate speed (bytes per second, update_freq=2)
DOWN=$(( (BYTES_IN - PREV_IN) / 2 ))
UP=$(( (BYTES_OUT - PREV_OUT) / 2 ))

# Format speed
format_speed() {
  local bytes=$1
  if [ $bytes -lt 0 ]; then
    echo "0 B/s"
  elif [ $bytes -lt 1024 ]; then
    echo "${bytes} B/s"
  elif [ $bytes -lt 1048576 ]; then
    echo "$(( bytes / 1024 )) KB/s"
  else
    echo "$(( bytes / 1048576 )).$(( (bytes % 1048576) / 104858 )) MB/s"
  fi
}

DOWN_FMT=$(format_speed $DOWN)
UP_FMT=$(format_speed $UP)

sketchybar --set "$NAME" label="↓$DOWN_FMT ↑$UP_FMT"
