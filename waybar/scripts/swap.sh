#!/bin/bash
cd ~/.config/waybar || exit

if [ -f config-bg ]; then
  mv config config.tmp
  mv config-bg config
  mv config.tmp config-bg

  mv style.css style.tmp
  mv style-bg.css style.css
  mv style.tmp style-bg.css
fi

pkill waybar
waybar &
