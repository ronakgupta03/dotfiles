#!/bin/sh
# Audio volume and mute control helper with desktop notifications
# Dependencies: wpctl (WirePlumber) or pactl (PipeWire/PulseAudio), notify-send (optional)

set -eu

AUDIO_BACKEND=""
if command -v wpctl >/dev/null 2>&1; then
    AUDIO_BACKEND="wpctl"
elif command -v pactl >/dev/null 2>&1; then
    AUDIO_BACKEND="pactl"
else
    echo "Error: neither wpctl nor pactl found. Audio backend unavailable." >&2
    exit 1
fi

STEP="${2:-5%}"

get_volume() {
    if [ "$AUDIO_BACKEND" = "wpctl" ]; then
        vol=$(wpctl get-volume @DEFAULT_AUDIO_SINK@ 2>/dev/null | awk '{print int($2 * 100)}')
        echo "${vol:-0}"
    else
        vol=$(pactl get-sink-volume @DEFAULT_SINK@ 2>/dev/null | awk '/Volume:/ {print $5}' | head -n1 | tr -d '%')
        echo "${vol:-0}"
    fi
}

is_muted() {
    if [ "$AUDIO_BACKEND" = "wpctl" ]; then
        wpctl get-volume @DEFAULT_AUDIO_SINK@ 2>/dev/null | grep -q "\[MUTED\]"
    else
        pactl get-sink-mute @DEFAULT_SINK@ 2>/dev/null | grep -q "yes"
    fi
}

notify_volume() {
    if ! command -v notify-send >/dev/null 2>&1; then
        return
    fi

    percent=$(get_volume)
    if is_muted; then
        notify-send -t 1500 \
            -h string:x-canonical-private-synchronous:volume \
            -a "System" \
            -i "audio-volume-muted" \
            "Volume: Muted"
    else
        notify-send -t 1500 \
            -h string:x-canonical-private-synchronous:volume \
            -h int:value:"$percent" \
            -a "System" \
            -i "audio-volume-high" \
            "Volume: ${percent}%"
    fi
}

notify_mic() {
    if ! command -v notify-send >/dev/null 2>&1; then
        return
    fi

    mic_muted=false
    if [ "$AUDIO_BACKEND" = "wpctl" ]; then
        wpctl get-volume @DEFAULT_AUDIO_SOURCE@ 2>/dev/null | grep -q "\[MUTED\]" && mic_muted=true
    else
        pactl get-source-mute @DEFAULT_SOURCE@ 2>/dev/null | grep -q "yes" && mic_muted=true
    fi

    if [ "$mic_muted" = true ]; then
        notify-send -t 1500 \
            -h string:x-canonical-private-synchronous:mic \
            -a "System" \
            -i "microphone-sensitivity-muted" \
            "Microphone: Muted"
    else
        notify-send -t 1500 \
            -h string:x-canonical-private-synchronous:mic \
            -a "System" \
            -i "microphone-sensitivity-high" \
            "Microphone: Active"
    fi
}

case "${1:-}" in
    up)
        if [ "$AUDIO_BACKEND" = "wpctl" ]; then
            wpctl set-volume -l 1.0 @DEFAULT_AUDIO_SINK@ "${STEP}+"
        else
            pactl set-sink-volume @DEFAULT_SINK@ "+${STEP}"
        fi
        notify_volume
        ;;
    down)
        if [ "$AUDIO_BACKEND" = "wpctl" ]; then
            wpctl set-volume @DEFAULT_AUDIO_SINK@ "${STEP}-"
        else
            pactl set-sink-volume @DEFAULT_SINK@ "-${STEP}"
        fi
        notify_volume
        ;;
    mute)
        if [ "$AUDIO_BACKEND" = "wpctl" ]; then
            wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle
        else
            pactl set-sink-mute @DEFAULT_SINK@ toggle
        fi
        notify_volume
        ;;
    mic-mute)
        if [ "$AUDIO_BACKEND" = "wpctl" ]; then
            wpctl set-mute @DEFAULT_AUDIO_SOURCE@ toggle
        else
            pactl set-source-mute @DEFAULT_SOURCE@ toggle
        fi
        notify_mic
        ;;
    get)
        get_volume
        ;;
    is-muted)
        if is_muted; then echo "yes"; else echo "no"; fi
        ;;
    -h|--help|help)
        echo "Usage: $(basename "$0") {up|down|mute|mic-mute|get|is-muted} [step]"
        exit 0
        ;;
    *)
        echo "Usage: $(basename "$0") {up|down|mute|mic-mute|get|is-muted} [step]" >&2
        exit 1
        ;;
esac
