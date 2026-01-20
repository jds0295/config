#!/usr/bin/env bash
# WALLPAPER_DIR="${HOME}/Pictures/wallpapers"
WALLPAPER_DIR="/mnt/red/rescue from ubuntu/Wallpaper-Bank/wallpapers"

CHOICE=$(find "$WALLPAPER_DIR" -type f \( -iname "*.jpg" -o -iname "*.png" -o -iname "*.jpeg" \) | sort | (pidof wofi ||wofi --dmenu --insensitive --prompt "Pick a wallpaper:"))
# CHOICE=$(find "$WALLPAPER_DIR" -type f \( -iname "*.jpg" -o -iname "*.png" -o -iname "*.jpeg" \) |
#   sort |
#   wofi --dmenu --insensitive --prompt "Pick a wallpaper:")


if [[ -n "$CHOICE" ]]; then
  swww img "$CHOICE" --transition-type random
  # swww img "$CHOICE" --outputs "$ACTIVE_MONITOR"
  wal -i "$CHOICE" -n --cols16
  pkill waybar; waybar &
  tmux source-file ~/.config/tmux/tmux.conf

  cat ~/.config/starship.toml ~/.cache/wal/colors-starship.toml > ~/.config/starship-colored.toml
  export STARSHIP_CONFIG=~/.config/starship-colored.toml
  sleep 1.00
  notify-send "Wallpaper set" "$(basename "$CHOICE")" -h string:image-path:"$CHOICE" --expire-time=5000
fi
