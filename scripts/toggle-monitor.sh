#!/bin/sh

# === CONFIG ===
MONITOR_NAME="HDMI-A-2"
ENABLED_CONFIG="monitor=HDMI-A-2,preferred,auto,1"
DISABLED_CONFIG="monitor=HDMI-A-2,disable"
CONFIG_FILE="$HOME/.config/hypr/hyprland.conf"
TMP_FILE="/tmp/hyprland_toggle_monitor.bak"

# === FUNCTION ===
# Get current state from hyprctl
CURRENT_STATE=$(hyprctl monitors | grep -A4 "$MONITOR_NAME")

if echo "$CURRENT_STATE" | grep -q "enabled: yes"; then
    echo "Disabling $MONITOR_NAME..."
    sed -i "s/^monitor=$MONITOR_NAME.*/$DISABLED_CONFIG/" "$CONFIG_FILE"
else
    echo "Enabling $MONITOR_NAME..."
    sed -i "s/^monitor=$MONITOR_NAME.*/$ENABLED_CONFIG/" "$CONFIG_FILE"
fi

# Reload Hyprland
hyprctl reload

