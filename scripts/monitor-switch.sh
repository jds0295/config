#!/usr/bin/env bash

CONFIG_DIR="$HOME/.config/hypr"
CONFIG_FILE="$CONFIG_DIR/monitors.conf"

SINGLE_MONITOR="# single monitor configuration
monitor=HDMI-A-2,disabled
monitor=DP-1,1920x1080@60,0x0,1"

DUAL_MONITOR="# dual monitor configuration
monitor=HDMI-A-2,1920x1080,0x0,1
monitor=DP-1,1920x1080,1920x0,1"

case "$1" in
  single)
    echo "$SINGLE_MONITOR" > "$CONFIG_FILE"
    ;;
  dual)
    echo "$DUAL_MONITOR" > "$CONFIG_FILE"
    ;;
  *)
    echo "Usage: $0 {single|dual}"
    exit 1
    ;;
esac

# Reload Hyprland or your compositor
hyprctl reload

