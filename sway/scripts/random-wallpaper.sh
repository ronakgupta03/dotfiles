#!/bin/bash

WALLPAPER_DIR="${WALLPAPER_DIR:-$HOME/Pictures/Wallpapers}"
[ -d "$WALLPAPER_DIR" ] || WALLPAPER_DIR="$HOME/Wallpapers"
[ -d "$WALLPAPER_DIR" ] || WALLPAPER_DIR="$HOME/Pictures"

# Pick a random image
WALLPAPER=$(find "$WALLPAPER_DIR" -type f \
  \( -iname "*.jpg" -o -iname "*.png" -o -iname "*.jpeg" -o -iname "*.webp" \) \
  | shuf -n 1)

# Set wallpaper
swww img "$WALLPAPER" \
  --transition-type any \
  --transition-duration 1
