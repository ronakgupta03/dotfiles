#!/bin/sh
# Clipboard management helper for Wayland / Sway using cliphist and rofi
# Dependencies: cliphist, rofi, wl-copy

set -eu

if ! command -v cliphist >/dev/null 2>&1; then
    echo "Error: cliphist is required but not installed." >&2
    exit 1
fi

ROFI_THEME="${HOME}/.config/rofi/clipboard.rasi"
ROFI_ARGS="-dmenu -p Clipboard"

if [ -f "$ROFI_THEME" ]; then
    ROFI_ARGS="$ROFI_ARGS -theme $ROFI_THEME"
fi

case "${1:-}" in
    manage)
        if ! command -v rofi >/dev/null 2>&1 || ! command -v wl-copy >/dev/null 2>&1; then
            echo "Error: rofi and wl-copy are required to manage clipboard." >&2
            exit 1
        fi
        # Select and copy from history
        cliphist list | rofi $ROFI_ARGS | cliphist decode | wl-copy
        ;;
    delete)
        if ! command -v rofi >/dev/null 2>&1; then
            echo "Error: rofi is required to select items for deletion." >&2
            exit 1
        fi
        cliphist list | rofi $ROFI_ARGS -p "Delete Item" | cliphist delete
        ;;
    wipe)
        cliphist wipe
        if command -v notify-send >/dev/null 2>&1; then
            notify-send -a "Clipboard" "Clipboard History Cleared"
        fi
        ;;
    -h|--help|help)
        echo "Usage: $(basename "$0") {manage|delete|wipe}"
        exit 0
        ;;
    *)
        echo "Usage: $(basename "$0") {manage|delete|wipe}" >&2
        exit 1
        ;;
esac
