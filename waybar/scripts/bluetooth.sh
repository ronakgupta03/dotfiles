#!/bin/bash

# Check if bluetoothctl utility is installed
if ! command -v bluetoothctl >/dev/null 2>&1; then
    echo '{"text":"󰂲","class":"disabled","tooltip":"Bluetooth: bluetoothctl not installed"}'
    exit 0
fi

ctrl_status=$(bluetoothctl show 2>&1)

# Check if Bluetooth hardware controller is available
if echo "$ctrl_status" | grep -qi "No default controller available"; then
    echo '{"text":"󰂲","class":"unavailable","tooltip":"Bluetooth: No adapter found"}'
    exit 0
fi

case "$1" in
    toggle)
        if echo "$ctrl_status" | grep -q "Powered: yes"; then
            bluetoothctl power off >/dev/null 2>&1
        else
            bluetoothctl power on >/dev/null 2>&1
        fi
        exit 0
        ;;
esac

# Check power and connection state
if echo "$ctrl_status" | grep -q "Powered: yes"; then
    connected_device=$(bluetoothctl devices Connected 2>/dev/null | head -n 1 | cut -d ' ' -f 3-)
    if [ -n "$connected_device" ]; then
        echo "{\"text\":\"󰂱\",\"class\":\"connected\",\"tooltip\":\"Bluetooth: Connected to $connected_device\"}"
    else
        echo '{"text":"󰂯","class":"on","tooltip":"Bluetooth: ON (No device connected) — click to turn OFF"}'
    fi
else
    echo '{"text":"󰂲","class":"off","tooltip":"Bluetooth: OFF — click to turn ON"}'
fi
