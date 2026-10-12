#!/bin/bash

# start daemon if not running
pgrep swww-daemon > /dev/null || swww-daemon &

# small delay to ensure daemon is ready
sleep 0.2

IMG=$(fd -t f . ~/Wallpapers | shuf -n 1)

swww img "$IMG" --transition-type wipe --transition-duration 0.75

