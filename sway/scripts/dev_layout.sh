#!/bin/bash

# Workspace 3
swaymsg "workspace 3; layout splith"

# Obsidian (LEFT)
obsidian &
sleep 1

# Firefox 1
if [ -f "$HOME/Downloads/volume1.pdf" ]; then
    firefox --new-window "$HOME/Downloads/volume1.pdf" &
else
    firefox --new-window &
fi
sleep 1

if [ -f "$HOME/Downloads/volume2.pdf" ]; then
    firefox --new-tab "$HOME/Downloads/volume2.pdf" &
    sleep 1
fi

# Resize right area
swaymsg "resize set width 85 ppt"

# Split RIGHT into 2 (LEFT-RIGHT)
swaymsg "splith"

# Firefox 2 (WhatsApp)
firefox --new-window &
sleep 1

# Balance both firefox windows
swaymsg "resize set width 50 ppt"

# Go back to parent (SAFE instead of focus left)
swaymsg "focus parent"
swaymsg "focus left"

# Create vertical split on left
swaymsg "splitv"

# Move to bottom container SAFELY
swaymsg "focus child"
swaymsg "focus down"

# Open Pomotroid
pomotroid --disable-gpu --disable-software-rasterizer --no-sandbox
sleep 1

# Toggle floating → tiled
swaymsg "floating toggle"
