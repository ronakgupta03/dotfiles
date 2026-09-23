# Dotfiles

Personal configuration repository for Arch Linux, built around a Sway Wayland desktop environment.

## Overview

This repository maintains modular, reproducible configurations for my daily driver desktop workflow. The configuration prioritizes lightweight, keyboard-driven Wayland utilities with unified styling.

## System Profile

- **OS**: Arch Linux x86_64
- **Window Manager**: Sway (Wayland compositor)
- **Status Bar**: Waybar
- **Terminal Emulator**: Kitty / Alacritty
- **Application Launcher**: Rofi
- **Notification Daemon**: Mako
- **Shell**: Bash / Zsh
- **Audio Server**: PipeWire / WirePlumber

## Repository Structure

```
dotfiles/
├── sway/       # Sway window manager configurations and keybindings
├── waybar/     # Waybar status bar layouts, custom modules, and CSS
├── kitty/      # Terminal configuration and color schemes
├── rofi/       # App launcher and menu themes
├── mako/       # Notification daemon styling and rules
├── scripts/    # Desktop helper utilities (brightness, audio, screenshots)
├── systemd/    # User-level systemd service definitions and timers
└── packages/   # Explicit package manifests (Pacman and AUR)
```

## Setup & Development

Configurations in this repository are managed modularly and linked to `~/.config/` or system paths. Detailed installation automation and bootstrap instructions will be integrated as development progresses.
