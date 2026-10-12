#!/bin/sh
# Brightness control helper with desktop notifications

STEP="${2:-5%}"

get_brightness() {
    brightnessctl -m | cut -d, -f4 | tr -d '%'
}

notify_brightness() {
    local percent
    percent=$(get_brightness)
    if command -v notify-send >/dev/null 2>&1; then
        notify-send -t 1500 \
            -h string:x-canonical-private-synchronous:brightness \
            -h int:value:"$percent" \
            -a "System" \
            "Brightness: ${percent}%"
    fi
}

case "$1" in
    up)
        brightnessctl set "+${STEP}" -q
        notify_brightness
        ;;
    down)
        brightnessctl set "${STEP}-" -q
        notify_brightness
        ;;
    set)
        if [ -n "$2" ]; then
            brightnessctl set "$2" -q
            notify_brightness
        fi
        ;;
    get)
        get_brightness
        ;;
    *)
        echo "Usage: $0 {up|down|set <val>|get} [step]"
        exit 1
        ;;
esac
