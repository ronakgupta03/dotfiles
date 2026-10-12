#!/bin/sh
# Brightness control helper with desktop notifications
# Dependencies: brightnessctl, notify-send (optional)

set -eu

if ! command -v brightnessctl >/dev/null 2>&1; then
    echo "Error: brightnessctl is required but not installed." >&2
    exit 1
fi

STEP="${2:-5%}"

get_brightness() {
    brightnessctl -m 2>/dev/null | cut -d, -f4 | tr -d '%' || echo "0"
}

notify_brightness() {
    if command -v notify-send >/dev/null 2>&1; then
        percent=$(get_brightness)
        notify-send -t 1500 \
            -h string:x-canonical-private-synchronous:brightness \
            -h int:value:"$percent" \
            -a "System" \
            "Brightness: ${percent}%"
    fi
}

case "${1:-}" in
    up)
        brightnessctl set "+${STEP}" -q
        notify_brightness
        ;;
    down)
        brightnessctl set "${STEP}-" -q
        notify_brightness
        ;;
    set)
        if [ -n "${2:-}" ]; then
            brightnessctl set "$2" -q
            notify_brightness
        else
            echo "Error: brightness level value required for 'set'." >&2
            exit 1
        fi
        ;;
    get)
        get_brightness
        ;;
    -h|--help|help)
        echo "Usage: $(basename "$0") {up|down|set <val>|get} [step]"
        exit 0
        ;;
    *)
        echo "Usage: $(basename "$0") {up|down|set <val>|get} [step]" >&2
        exit 1
        ;;
esac
