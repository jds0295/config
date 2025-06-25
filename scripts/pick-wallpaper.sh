#!/usr/bin/env bash

# WALLPAPER_DIR="${HOME}/Pictures/wallpapers"
WALLPAPER_DIR="/mnt/red/rescue from ubuntu/Wallpaper-Bank/wallpapers"
CHOICE=$(find "$WALLPAPER_DIR" -type f \( -iname "*.jpg" -o -iname "*.png" -o -iname "*.jpeg" \) | sort | wofi --dmenu --insensitive --prompt "Pick a wallpaper:")

if [[ -n "$CHOICE" ]]; then
  swww img "$CHOICE" --transition-type any
  wal -i "$CHOICE" -n --cols16
  tmux source-file ~/.config/tmux/tmux.conf
  cat ~/.config/starship.toml ~/.cache/wal/colors-starship.toml > ~/.config/starship-colored.toml
  export STARSHIP_CONFIG = ~/.config/starship-colored.toml
  # starship
  notify-send "Wallpaper set" "$(basename "$CHOICE")" -i "$CHOICE"
fi

