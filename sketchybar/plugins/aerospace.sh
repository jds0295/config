#!/bin/bash

# make sure it's executable with:
# chmod +x ~/.config/sketchybar/plugins/aerospace.sh

if [ "$1" = "$FOCUSED_WORKSPACE" ]; then
    sketchybar --set $NAME background.drawing=on
    # sketchybar --set space.1 icon=3
else
    sketchybar --set $NAME background.drawing=off
fi

not_empty_spaces=$(aerospace list-workspaces --monitor all --empty no)

#don't show the space if it's empty
if [[ $not_empty_spaces == *"$1"* ]]; then
    sketchybar --set $NAME drawing=on
else
    sketchybar --set $NAME drawing=off
fi
