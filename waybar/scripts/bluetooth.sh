#!/bin/bash

case "$1" in
    toggle)
        if bluetoothctl show | grep -q "Powered: yes"; then
            bluetoothctl power off
        else
            bluetoothctl power on
        fi
        ;;
esac

if bluetoothctl show | grep -q "Powered: yes"; then
    echo '{"text":"󰂯","class":"on","tooltip":"Bluetooth: ON — click to turn OFF"}'
else
    echo '{"text":"󰂲","class":"off","tooltip":"Bluetooth: OFF — click to turn ON"}'
fi
