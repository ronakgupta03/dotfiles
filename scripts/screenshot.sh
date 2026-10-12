#!/bin/sh
# Desktop screenshot helper for Sway / Wayland
# Dependencies: grim, wl-copy, slurp (for area), swappy (optional)

set -eu

if ! command -v grim >/dev/null 2>&1; then
    echo "Error: grim is required for screenshots but not installed." >&2
    exit 1
fi

SAVE_DIR="${XDG_PICTURES_DIR:-$HOME/Pictures}/Screenshots"
mkdir -p "$SAVE_DIR"

TIMESTAMP=$(date +"%Y%m%d_%H%M%S")
FILENAME="$SAVE_DIR/screenshot_${TIMESTAMP}.png"

notify() {
    if command -v notify-send >/dev/null 2>&1; then
        notify-send -t 3000 \
            -a "Screenshot" \
            -i "$1" \
            "Screenshot Captured" \
            "Saved to $(basename "$1") and copied to clipboard."
    fi
}

copy_to_clipboard() {
    if command -v wl-copy >/dev/null 2>&1; then
        wl-copy < "$1"
    fi
}

case "${1:-}" in
    area)
        if ! command -v slurp >/dev/null 2>&1; then
            echo "Error: slurp is required for area selection." >&2
            exit 1
        fi
        GEOM=$(slurp 2>/dev/null || true)
        [ -z "$GEOM" ] && exit 0

        grim -g "$GEOM" "$FILENAME"
        copy_to_clipboard "$FILENAME"

        if [ "${2:-}" = "--edit" ] && command -v swappy >/dev/null 2>&1; then
            swappy -f "$FILENAME"
        else
            notify "$FILENAME"
        fi
        ;;
    full)
        grim "$FILENAME"
        copy_to_clipboard "$FILENAME"
        notify "$FILENAME"
        ;;
    window)
        GEOM=""
        if command -v swaymsg >/dev/null 2>&1 && command -v jq >/dev/null 2>&1; then
            GEOM=$(swaymsg -t get_tree 2>/dev/null | jq -r '.. | select(.focused? == true).rect | "\(.x),\(.y) \(.width)x\(.height)" 2>/dev/null' || true)
        fi

        if [ -n "$GEOM" ]; then
            grim -g "$GEOM" "$FILENAME"
        else
            grim "$FILENAME"
        fi
        copy_to_clipboard "$FILENAME"
        notify "$FILENAME"
        ;;
    -h|--help|help)
        echo "Usage: $(basename "$0") {area|full|window} [--edit]"
        exit 0
        ;;
    *)
        echo "Usage: $(basename "$0") {area|full|window} [--edit]" >&2
        exit 1
        ;;
esac
