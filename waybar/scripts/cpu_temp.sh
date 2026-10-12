#!/bin/sh

temp=""

# 1. Try sysfs hwmon directly for AMD (k10temp) or Intel (coretemp)
for f in /sys/class/hwmon/hwmon*/temp1_input; do
    if [ -r "$f" ]; then
        raw=$(cat "$f" 2>/dev/null)
        if [ -n "$raw" ] && [ "$raw" -gt 0 ] 2>/dev/null; then
            temp=$((raw / 1000))
            break
        fi
    fi
done

# 2. Fallback to sensors command
if [ -z "$temp" ] && command -v sensors >/dev/null 2>&1; then
    temp=$(sensors 2>/dev/null | awk '/(Package id 0|Tctl|temp1):/ {gsub(/[+°C]/,""); print int($2 ? $2 : $4); exit}')
fi

# 3. Fallback to generic thermal zone
if [ -z "$temp" ] && [ -r /sys/class/thermal/thermal_zone0/temp ]; then
    raw=$(cat /sys/class/thermal/thermal_zone0/temp 2>/dev/null)
    if [ -n "$raw" ]; then
        temp=$((raw / 1000))
    fi
fi

# 4. Safe fallback if sensors unavailable
if [ -z "$temp" ] || ! [ "$temp" -eq "$temp" ] 2>/dev/null; then
    echo '{"text":"N/A","percentage":0,"class":"unknown"}'
    exit 0
fi

if [ "$temp" -ge 80 ]; then
    class="critical"
elif [ "$temp" -ge 60 ]; then
    class="warning"
else
    class="normal"
fi

echo "{\"text\":\"${temp}°C\",\"percentage\":${temp},\"class\":\"${class}\"}"
