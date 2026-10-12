# Desktop Theme & Appearance Guide

Unified Tokyo Night dark desktop aesthetic across Wayland compositors, status bars, launchers, notifications, terminals, and GTK applications.

---

## Color Palette (Tokyo Night)

| Color Role | Hex Code | Purpose Across Desktop |
| :--- | :--- | :--- |
| **Background (Dark)** | `#1a1b26` | Waybar, Mako, Kitty, Rofi background, unfocused borders |
| **Background (Light)** | `#24283b` | Active container backgrounds, Waybar module accents |
| **Foreground / Text** | `#c0caf5` | Primary body text and active icons |
| **Accent Blue** | `#7aa2f7` | Focused Sway window borders, clock, network indicators |
| **Success Green** | `#9ece6a` | Active workspace indicators, battery charging, CPU normal |
| **Warning Yellow** | `#e0af68` | Warning temperatures, battery discharging, backlight |
| **Urgent Red** | `#f7768e` | Critical battery, thermal alarms, urgent window borders |
| **Accent Magenta** | `#bb9af7` | Media player indicators, memory consumption |
| **Accent Cyan** | `#7dcfff` | Workspace icons, disk usage, active focused indicators |
| **Subtle Gray** | `#565f89` | Inactive borders, calendar headers, muted labels |

---

## Typography

- **Primary Font**: `Iosevka Nerd Font` (Mono for terminal/status bar; regular for menus/notifications)
- **Waybar Size**: 14px
- **Terminal Size**: 16.0 (Alacritty) / 20.0 (Kitty)
- **Rofi Size**: 12pt
- **Mako Size**: 11pt

---

## Icons & Cursors

- **Icon Theme**: `Papirus-Dark` (used in Rofi app launcher and GTK file choosers)
- **Cursor Theme**: `WinSur-dark-cursors`
- **Cursor Size**: `28` (synchronized across Sway `seat0`, GTK 3, GTK 4, and `.Xresources` for XWayland)

---

## Application Theming Map

```
Component           Configuration Location              Theme Engine
──────────────────────────────────────────────────────────────────────────
Window Manager      sway/config.d/03_appearance.conf    Sway client borders & gaps
Status Bar          waybar/style.css                    GTK CSS & custom palette
Terminal (Primary)  alacritty/alacritty.toml            Alacritty TOML palette
Terminal (Second)   kitty/tokyonight.conf               Kitty theme includes
App Launcher        rofi/themes/tokyonight.rasi         Rofi RASI stylesheet
Notifications       mako/config                         Mako INI format
GTK 3 Applications  gtk-3.0/settings.ini                GTK settings (Dark mode)
GTK 4 Applications  gtk-4.0/settings.ini                GTK settings (Dark mode)
XWayland Legacy     .Xresources                         X11 resource database
```

---

## Required Packages

To reproduce this desktop appearance on a clean Arch Linux install:

```bash
# Fonts
sudo pacman -S ttf-iosevka-nerd

# Icons & Themes
sudo pacman -S papirus-icon-theme adwaita-icon-theme

# Desktop Components
sudo pacman -S mako rofi-wayland waybar sway
```
