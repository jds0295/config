#!/usr/bin/env bash
set -euo pipefail

# -------------------
# SSH connections
# -------------------
# Count established SSH sessions
ssh_count=$(who | grep -c "pts/") || ssh_count=0

# -------------------
# SMB connections
# -------------------
# Use sudo NOPASSWD smbstatus
# Make sure your sudoers rule allows:
# james ALL=(root) NOPASSWD: /run/current-system/sw/bin/smbstatus --json
smb_count=0
# if json=$(sudo /run/current-system/sw/bin/smbstatus --json 2>/dev/null); then
#   # Count active sessions
#   smb_count=$(echo "$json" | jq '.sessions | length')
# fi

# -------------------
# Output JSON for Waybar
# -------------------
# printf '{"text":"󰣀 %d | 󰢋 %d"}' \
#   "$ssh_count" "$smb_count"

printf '{"text":" %d | 󰢋 %d","tooltip":"SSH connections: %d\\nSMB connections: %d","class":"%s"}' \
  "$ssh_count" "$smb_count" \
  "$ssh_count" "$smb_count" \
  "$([ "$smb_count" -gt 0 ] && echo active || echo idle)"

