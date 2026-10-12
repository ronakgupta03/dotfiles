#!/bin/sh

temp=$(sensors | awk '/Package id 0/ {gsub(/[+°C]/,""); print int($4)}')

if [ "$temp" -ge 80 ]; then
  class="critical"
elif [ "$temp" -ge 60 ]; then
  class="warning"
else
  class="normal"
fi

echo "{\"text\":\"$temp°C\",\"percentage\":$temp,\"class\":\"$class\"}"

