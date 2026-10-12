#!/bin/sh
# Desktop screenshot helper for Sway / Wayland

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

case "$1" in
    area)
        # Interactive region selection with slurp, optional annotation with swappy
        GEOM=$(slurp 2>/dev/null)
        [ -z "$GEOM" ] && exit 0
        grim -g "$GEOM" "$FILENAME"
        wl-copy < "$FILENAME"
        if command -v swappy >/dev/null 2>&1 && [ "$2" = "--edit" ]; then
            swappy -f "$FILENAME"
        else
            notify "$FILENAME"
        fi
        ;;
    full)
        # Capture all active outputs
        grim "$FILENAME"
        wl-copy < "$FILENAME"
        notify "$FILENAME"
        ;;
    window)
        # Capture focused Sway window
        if command -v swaymsg >/dev/null 2>&1 && command -v jq >/dev/null 2>&1; then
            GEOM=$(swaymsg -t get_tree | jq -r '.. | select(.focused? == true).rect | "\(.x),\(.y) \(.width)x\(.height)"')
            if [ -n "$GEOM" ]; then
                grim -g "$GEOM" "$FILENAME"
                wl-copy < "$FILENAME"
                notify "$FILENAME"
            else
                grim "$FILENAME"
                wl-copy < "$FILENAME"
                notify "$FILENAME"
            fi
        else
            grim "$FILENAME"
            wl-copy < "$FILENAME"
            notify "$FILENAME"
        fi
        ;;
    *)
        echo "Usage: $0 {area|full|window} [--edit]"
        exit 1
        ;;
esac
