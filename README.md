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

## Desktop Architecture Overview

The environment is designed as a lightweight, keyboard-driven Wayland desktop built around modular system utilities:

```
┌────────────────────────────────────────────────────────────────────────┐
│                       Sway Compositor (Wayland)                        │
├─────────────────┬───────────────────┬──────────────────────────────────┤
│   Waybar (Top)  │   Rofi Launcher   │       Mako Notifications         │
│  System status, │   App launcher,   │   Tokyo Night notification popup │
│  workspaces,    │   clipboard,      │   with urgency border routing    │
│  volume, battery│   power menu      │                                  │
├─────────────────┴───────────────────┴──────────────────────────────────┤
│                          Terminal & Shell                              │
│   • Alacritty (Primary, 60% opacity + blur)                            │
│   • Kitty (Secondary, full Tokyo Night theme)                          │
│   • Zsh + Powerlevel10k + Oh-My-Zsh                                    │
├────────────────────────────────────────────────────────────────────────┤
│                          Audio & Hardware                              │
│   • PipeWire + WirePlumber (Bluetooth SBC-XQ / mSBC HD codecs)         │
│   • Brightnessctl & pactl/wpctl synchronous OSD helpers                │
│   • NetworkManager & Blueman applets                                   │
├────────────────────────────────────────────────────────────────────────┤
│                       Session Lifecycle                                │
│   • Systemd user targets (graphical-session.target, sway-session)      │
│   • Background daemons (swww, cliphist, autotiling, polkit-qt6)        │
└────────────────────────────────────────────────────────────────────────┘
```

### Layer Interactions

1. **Compositor & Window Management**: Sway handles window layout, tiling, gaps, margins, and keybindings. Modular includes in `sway/config.d/` separate concern areas.
2. **Status & Feedback**: Waybar polls system metrics directly from Linux `/sys/class/` hwmon and PipeWire IPC, falling back gracefully if hardware or network is offline.
3. **User Input & Workflow**: Keybindings trigger lightweight standalone POSIX scripts in `scripts/` which manage state changes and send low-latency notification feedback via `notify-send`.
4. **Theme Cohesion**: The Tokyo Night color palette is uniformly defined across Sway window borders, Waybar GTK CSS, Rofi themes, Mako notifications, and terminal emulators.
