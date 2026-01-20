#!/usr/bin/env bash

CHOICE=$(hyprctl clients -j | jq -r '
  .[] |
  select(.mapped == true) |
  "\(.address) | ws:\(.workspace.id) | \(.class) | \(.title)"
' | sort | (pidof wofi || wofi --dmenu --insensitive --prompt "Pick a window:"))

if [[ -n "$CHOICE" ]]; then
  ADDR=$(printf "%s" "$CHOICE" | awk '{print $1}')

  # Focus the window
  hyprctl dispatch focuswindow address:$ADDR

  # Optional: also pull it to current workspace (uncomment if you want)
  # hyprctl dispatch movetoworkspace current,address:$ADDR
fi
