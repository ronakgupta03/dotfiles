#!/bin/bash

# start daemon if not running
pgrep swww-daemon > /dev/null || swww-daemon &

# small delay to ensure daemon is ready
sleep 0.2

WALLPAPER_DIR="${WALLPAPER_DIR:-$HOME/Pictures/Wallpapers}"
[ -d "$WALLPAPER_DIR" ] || WALLPAPER_DIR="$HOME/Wallpapers"
[ -d "$WALLPAPER_DIR" ] || WALLPAPER_DIR="$HOME/Pictures"

if command -v fd >/dev/null 2>&1; then
    IMG=$(fd -t f . "$WALLPAPER_DIR" 2>/dev/null | shuf -n 1)
else
    IMG=$(find "$WALLPAPER_DIR" -type f \( -iname "*.jpg" -o -iname "*.png" -o -iname "*.jpeg" -o -iname "*.webp" \) 2>/dev/null | shuf -n 1)
fi

[ -n "$IMG" ] && swww img "$IMG" --transition-type wipe --transition-duration 0.75

