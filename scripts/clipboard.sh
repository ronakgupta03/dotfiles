#!/bin/sh
# Clipboard management helper for Wayland / Sway using cliphist and rofi

ROFI_THEME="${HOME}/.config/rofi/clipboard.rasi"
ROFI_ARGS="-dmenu -p Clipboard"

if [ -f "$ROFI_THEME" ]; then
    ROFI_ARGS="$ROFI_ARGS -theme $ROFI_THEME"
fi

case "$1" in
    manage)
        # Select and copy from history
        cliphist list | rofi $ROFI_ARGS | cliphist decode | wl-copy
        ;;
    delete)
        # Interactive item deletion
        cliphist list | rofi $ROFI_ARGS -p "Delete Item" | cliphist delete
        ;;
    wipe)
        # Wipe all clipboard history
        if command -v notify-send >/dev/null 2>&1; then
            notify-send -a "Clipboard" "Clipboard History Cleared"
        fi
        cliphist wipe
        ;;
    *)
        echo "Usage: $0 {manage|delete|wipe}"
        exit 1
        ;;
esac
