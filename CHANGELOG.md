# Changelog

All notable changes to this project are documented in this file.

The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.0.0/),
and this project adheres to [Semantic Versioning](https://semver.org/spec/v2.0.0.html).

## [1.0.0] - 2026-10-13

### Added
- **Sway Compositor**:
  - Modular configuration architecture partitioned into `sway/config.d/` (`variables`, `output`, `input`, `appearance`, `autostart`, `keybindings`, `workspaces`).
  - Tokyo Night theme with window borders, title bar paddings, and inner/outer gaps.
  - Complete keybinding documentation in `sway/README.md`.
- **Status Bar (Waybar)**:
  - Custom modules for hardware temperature (`scripts/cpu_temp.sh`), Bluetooth power toggle (`scripts/bluetooth.sh`), system uptime, and updates.
  - Tokyo Night GTK CSS stylesheet with pill modules, urgent battery alerts, and theme variants (`theme-2` through `theme-4`).
- **Desktop Helpers (`scripts/`)**:
  - `brightness.sh`: OSD-integrated display brightness adjustment with step controls.
  - `volume.sh`: WirePlumber / PipeWire sink and microphone volume and mute toggles.
  - `screenshot.sh`: Area, fullscreen, and window screen capture via `grim`, `slurp`, and `swappy`.
  - `clipboard.sh`: Interactive clipboard history browser via `cliphist` and `rofi`.
- **Shell & Terminals**:
  - Zsh configuration with Powerlevel10k, Oh-My-Zsh, syntax highlighting, and autosuggestions.
  - Bash configuration with identical history controls and lesspipe integration.
  - `shell/aliases.sh` featuring navigation helpers (`..`, `mkcd`, `up`), modern `eza` listings, Git shortcuts, and universal `extract`.
  - Alacritty configuration with 60% opacity and Wayland blur.
  - Kitty configuration with full Tokyo Night color scheme and powerline tab bars.
- **Audio, Bluetooth & Network Integration**:
  - WirePlumber BlueZ configuration enabling high-definition SBC-XQ and mSBC codecs.
  - Desktop Bluetooth integration with Blueman applet and `blueman-manager`.
  - NetworkManager integration with `nmtui` Waybar hook and safe MAC address randomization templates.
- **Systemd User Units**:
  - `cameractrlsd.service` restoring hardware camera parameters on graphical session startup.
  - `clean-cache.timer` and `clean-cache.service` for automated weekly thumbnail maintenance.
  - `sway-session.target` bounding compositor user units to `graphical-session.target`.
- **Package Manifests**:
  - Explicit official Arch Linux packages list (`packages/pacman-packages.txt`).
  - Explicit AUR foreign packages list (`packages/aur-packages.txt`).
  - Categorized manifests for `core-desktop`, `fonts-themes`, `development`, and `optional-apps`.
- **Bootstrap Automation (`install.sh`)**:
  - Safe deployment script symlinking XDG and home dotfiles.
  - Automated timestamped backup protection in `~/.dotfiles_backup/`.
  - Non-destructive dry-run simulation mode (`-n` / `--dry-run`).
- **Testing & Quality Assurance**:
  - Automated path verification suite (`tests/test_paths.sh`).
  - Automated syntax test runner (`tests/test_syntax.sh`).

### Changed
- **Portability Refactoring**:
  - Eradicated all hard-coded usernames and machine-specific paths from Rofi themes and Sway scripts.
  - Parameterized wallpaper directories with fallback hierarchies.
  - Added template configurations for displays (`templates/outputs.conf.example`) and local environments (`templates/zshrc.local.example`).

### Security
- Isolated personal API keys and workstation secrets outside version control via `~/.zshrc.local` and `~/.bashrc.local`.
- Hardened `.gitignore` against SSH/GPG keys, cloud credentials, Wi-Fi configuration profiles, browser databases, and history logs.
- Added safe configuration templates (`.env.example`, `templates/secrets.env.example`).
- Completed repository-wide security audits confirming zero leaked secrets.
