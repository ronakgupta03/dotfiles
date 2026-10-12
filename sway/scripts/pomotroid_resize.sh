#!/bin/bash

# Focus Pomotroid
swaymsg '[app_id="pomotroid"] focus'

# Shrink height (equivalent to ↓ key)
swaymsg 'resize shrink height 200 px'
