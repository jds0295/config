#!/usr/bin/env bash

# Helper to color based on temperature
color() {
    local temp=$1
    # Remove + and °C
    temp=${temp//[+°C]/}
    # Convert to integer (round down)
    temp=${temp%.*}

    if [ "$temp" -ge 85 ]; then
        echo "#ff5555"  # red
    elif [ "$temp" -ge 70 ]; then
        echo "#f1fa8c"  # yellow
    else
        echo "#50fa7b"  # green
    fi
}

# CPU temps
cpu_temps=($(sensors | awk '/Core [0-9]+:/ {print $3+0}'))
cpu_avg=0
for t in "${cpu_temps[@]}"; do cpu_avg=$((cpu_avg+t)); done
cpu_avg=$((cpu_avg/${#cpu_temps[@]}))
cpu_color=$(color $cpu_avg)

# NVMe
nvme_temp=$(sensors | awk '/nvme-pci/ {flag=1} flag && /Composite/ {print $2; exit}')
nvme_color=$(color $nvme_temp)

# Wi-Fi
wifi_temp=$(sensors | awk '/iwlwifi/ {flag=1} flag && /temp1/ {print $2; exit}')
wifi_color=$(color $wifi_temp)

# ACPI/system
acpi_temp=$(sensors | awk '/acpitz/ {flag=1} flag && /temp1/ {print $2; exit}')
acpi_color=$(color $acpi_temp)

# GPU
if command -v nvidia-smi &> /dev/null; then
    gpu_temp=$(nvidia-smi --query-gpu=temperature.gpu --format=csv,noheader,nounits)
    gpu_color=$(color $gpu_temp)
else
    gpu_temp="N/A"
    gpu_color="#f8f8f2"
fi

# Output in waybar markup
tooltip=$(
  printf "<span color='%s'>CPU: %s°C</span>\n" "$cpu_color" "$cpu_avg"
  printf "<span color='%s'>NVMe: %s°C</span>\n" "$nvme_color" "$nvme_temp"
  printf "<span color='%s'>Wi-Fi: %s°C</span>\n" "$wifi_color" "$wifi_temp"
  printf "<span color='%s'>SYS: %s°C</span>\n" "$acpi_color" "$acpi_temp"
  printf "<span color='%s'>GPU: %s°C</span>\n" "$gpu_color" "$gpu_temp"
)

class="ok"
percentage="100"
jq -nc \
  --arg text "$cpu_avg" \
  --arg tooltip "$tooltip" \
  --arg class "$class" \
  --argjson percentage "$percentage" \
  '{text:$text, tooltip:$tooltip, class:$class, percentage:$percentage}'
