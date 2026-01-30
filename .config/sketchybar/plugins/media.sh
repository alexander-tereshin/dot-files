#!/bin/sh

export LANG=en_US.UTF-8

SPOTIFY_PLAYING=$(osascript -e 'tell application "System Events" to (name of processes) contains "Spotify"' 2>/dev/null)
MUSIC_PLAYING=$(osascript -e 'tell application "System Events" to (name of processes) contains "Music"' 2>/dev/null)

STATE="paused"
TRACK=""
ARTIST=""

if [ "$SPOTIFY_PLAYING" = "true" ]; then
  STATE=$(osascript -e 'tell application "Spotify" to player state as string' 2>/dev/null)
  if [ "$STATE" = "playing" ]; then
    TRACK=$(osascript -e 'tell application "Spotify" to name of current track as string' 2>/dev/null)
    ARTIST=$(osascript -e 'tell application "Spotify" to artist of current track as string' 2>/dev/null)
  fi
elif [ "$MUSIC_PLAYING" = "true" ]; then
  STATE=$(osascript -e 'tell application "Music" to player state as string' 2>/dev/null)
  if [ "$STATE" = "playing" ]; then
    TRACK=$(osascript -e 'tell application "Music" to name of current track as string' 2>/dev/null)
    ARTIST=$(osascript -e 'tell application "Music" to artist of current track as string' 2>/dev/null)
  fi
fi

if [ "$STATE" = "playing" ] && [ -n "$TRACK" ]; then
  sketchybar --set "$NAME" icon="♫" label="$ARTIST - $TRACK" drawing=on
else
  sketchybar --set "$NAME" drawing=off
fi
