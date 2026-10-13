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

## Installation & Setup Guide

### 1. Prerequisites

Ensure your Arch Linux installation is updated and has `git` and `base-devel`:

```bash
sudo pacman -Syu --needed git base-devel
```

### 2. Clone Repository

```bash
git clone https://github.com/ronakgupta03/dotfiles.git ~/dotfiles
cd ~/dotfiles
```

### 3. Install Package Dependencies

Install the core desktop stack and required typography:

```bash
# Core desktop environment (Sway, Waybar, Mako, Rofi, Audio, Bluetooth)
sudo pacman -S --needed - < packages/core-desktop.txt

# Nerd fonts and icon themes
sudo pacman -S --needed - < packages/fonts-themes.txt

# (Optional) Developer CLI tools and applications
sudo pacman -S --needed - < packages/development.txt
sudo pacman -S --needed - < packages/optional-apps.txt
```

For AUR packages (e.g. `wlogout`, `swayfx-git`, `yay`):

```bash
yay -S --needed - < packages/aur-packages.txt
```

### 4. Deploy Dotfiles via Bootstrap Script

Always test in simulation mode first:

```bash
# Preview planned symlinks and backups without modifying filesystem
./install.sh --dry-run

# Execute deployment
./install.sh
```

> **Safety Guarantee**: `install.sh` automatically creates a timestamped backup in `~/.dotfiles_backup/<timestamp>/` before replacing any existing file or directory.

### 5. Machine-Specific Configuration

Configure displays and local shell secrets outside of version control:

```bash
# Set up your display configuration
cp templates/outputs.conf.example ~/.config/sway/outputs

# Set up local shell overrides and private API keys
cp templates/zshrc.local.example ~/.zshrc.local
```

### 6. Enable User Services & Launch

```bash
# Enable audio and desktop timers
systemctl --user enable --now pipewire wireplumber pipewire-pulse clean-cache.timer

# Enable system daemons
sudo systemctl enable --now NetworkManager bluetooth

# Start Sway session
sway
```

## Troubleshooting & Diagnostics

### 1. Sway & Display Issues

- **Nvidia GPU Launch Warning**:
  If using proprietary Nvidia drivers, launch Sway with the `--unsupported-gpu` flag:
  ```bash
  sway --unsupported-gpu
  ```
- **Syntax Validation**:
  Verify your configuration syntax without restarting the session:
  ```bash
  sway --unsupported-gpu -C -c ~/.config/sway/config
  ```
- **Display Not Detected**:
  Check available outputs and connector names:
  ```bash
  swaymsg -t get_outputs
  ```
  Update `~/.config/sway/outputs` or launch `nwg-displays`.

### 2. Audio & Media Issues

- **Audio Output Not Switching**:
  Check PipeWire/WirePlumber status:
  ```bash
  wpctl status
  wpctl set-default <SINK_ID>
  ```
- **Restart Audio Daemon**:
  ```bash
  systemctl --user restart pipewire wireplumber pipewire-pulse
  ```

### 3. Bluetooth Issues

- **"No default controller available"**:
  Ensure the Bluetooth service is active and unblocked:
  ```bash
  sudo systemctl start bluetooth
  rfkill unblock bluetooth
  ```

### 4. Status Bar (Waybar)

- **Restart Waybar Live**:
  ```bash
  pkill waybar && waybar >/dev/null 2>&1 &
  ```
- **Missing Icons or Glyphs**:
  Rebuild font cache if Nerd Font symbols appear as boxes:
  ```bash
  fc-cache -fv
  ```

### 5. Restoring Previous Configurations

If you need to revert any replaced files, restore them from your timestamped backup:

```bash
# View existing backup snapshots
ls -la ~/.dotfiles_backup/

# Restore a specific component
cp -r ~/.dotfiles_backup/<TIMESTAMP>/sway ~/.config/
```
