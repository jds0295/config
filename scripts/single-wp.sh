
#!/usr/bin/env bash

# WALLPAPER_DIR="${HOME}/Pictures/wallpapers"
WALLPAPER_DIR="/mnt/red/rescue from ubuntu/Wallpaper-Bank/wallpapers"
CHOICE=$(find "$WALLPAPER_DIR" -type f \( -iname "*.jpg" -o -iname "*.png" -o -iname "*.jpeg" \) | sort | wofi --dmenu --insensitive --prompt "Pick a wallpaper:")

if [[ -n "$CHOICE" ]]; then

  ACTIVE_MONITOR=$(hyprctl monitors -j | jq -r '.[] | select(.focused == true) | .name')

  if [[ -z "$ACTIVE_MONITOR" ]]; then
    notify-send "Error" "Could not detect active monitor."
    exit 1
  fi

  swww img "$CHOICE" --transition-type random --outputs "$ACTIVE_MONITOR"

  sleep 1.00
  notify-send "Wallpaper set" "$(basename "$CHOICE")" -h string:image-path:"$CHOICE" --expire-time=5000
fi

