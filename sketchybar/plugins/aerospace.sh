#!/bin/bash

# make sure it's executable with:
# chmod +x ~/.config/sketchybar/plugins/aerospace.sh

if [ "$1" = "$FOCUSED_WORKSPACE" ]; then
    sketchybar --set $NAME background.drawing=on
    # sketchybar --set space.1 icon=3
else
    sketchybar --set $NAME background.drawing=off
fi

# sketchybar --set space.1 icon=2

