#!/bin/bash

# Workspace 3
swaymsg "workspace 3; layout splith"

# Obsidian (LEFT)
obsidian &
sleep 1

# Firefox 1 (PDFs)
firefox --new-window ~/Downloads/volume1.pdf &
sleep 1

firefox --new-tab ~/Downloads/volume2.pdf &
sleep 1

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
