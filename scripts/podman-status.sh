#!/usr/bin/env bash

# Ensure podman exists
if ! command -v podman >/dev/null 2>&1; then
  echo '{"text":"Podman","tooltip":"Podman not installed","class":"error","percentage":50}'
  exit 0
fi

# Container counts
running=$(podman ps -q 2>/dev/null | wc -l)
total=$(podman ps -aq 2>/dev/null | wc -l)

# Lists
running_names=$(podman ps --format '{{.Names}}' 2>/dev/null)
stopped_names=$(podman ps -a --filter status=exited --format '{{.Names}}' 2>/dev/null)
images=$(podman images -q 2>/dev/null | wc -l)

# Podman info (lightweight)
if podman info >/dev/null 2>&1; then
  state="running"
  percentage="100"
  class="running"
else
  state="stopped"
  percentage="0"
  class="stopped"
fi

tooltip=$(
  printf "Podman: %s\n\n" "$state"
  printf "Containers: %s running / %s total\n" "$running" "$total"
  printf "Images: %s\n\n" "$images"

  printf "Running:\n"
  if [ -n "$running_names" ]; then
    printf "%s\n" "$running_names"
  else
    printf "None\n"
  fi

  printf "\nStopped:\n"
  if [ -n "$stopped_names" ]; then
    printf "%s\n" "$stopped_names"
  else
    printf "None\n"
  fi
)

jq -nc \
  --arg text "$running/$total" \
  --arg tooltip "$tooltip" \
  --arg class "$class" \
  --argjson percentage "$percentage" \
  '{text:$text, tooltip:$tooltip, class:$class, percentage:$percentage}'
