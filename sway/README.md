# Sway Configuration & Keybindings

Sway window manager setup configured with Tokyo Night styling, gap aesthetics, and modular configuration includes.

## Modifier Key

- **`$mod`** = `Super` (Windows Key)

---

## Keybinding Reference

### Applications & Launchers

| Shortcut | Action | Description |
| :--- | :--- | :--- |
| `$mod + Return` | Terminal | Launches default terminal (`alacritty`) |
| `$mod + d` | App Launcher | Application launcher via `rofi -show drun` |
| `$mod + e` | File Manager | File manager (`nemo`) |
| `$mod + b` | Web Browser | Web browser (`firefox`) |
| `$mod + m` | Bluetooth | Terminal Bluetooth TUI (`bluetuith`) |
| `$mod + v` | Clipboard History | Rofi clipboard manager (`cliphist`) |
| `$mod + s` | Emoji Picker | Rofi emoji selector |

### Window Management & Focus

| Shortcut | Action | Description |
| :--- | :--- | :--- |
| `$mod + Shift + q` | Close Window | Kill focused window |
| `$mod + Shift + c` | Reload Config | Reload Sway configuration |
| `$mod + Arrow` | Move Focus | Move focus left, down, up, or right |
| `$mod + Shift + Arrow` | Move Window | Move focused container |
| `$mod + f` | Fullscreen | Toggle fullscreen mode |
| `$mod + Shift + Space` | Floating Toggle | Toggle floating state for focused window |
| `$mod + Space` | Focus Mode | Toggle focus between tiling and floating |
| `$mod + Shift + -` | Scratchpad Move | Move container to scratchpad |
| `$mod + -` | Scratchpad Show | Show/cycle scratchpad windows |

### Layout & Modes

| Shortcut | Action | Description |
| :--- | :--- | :--- |
| `$mod + p` | Split Horizontal | Set horizontal split for next window |
| `$mod + o` | Split Vertical | Set vertical split for next window |
| `$mod + Shift + s` | Stacking Layout | Switch layout to stacking |
| `$mod + r` | Resize Mode | Enter resize mode (`Escape` or `Return` to exit) |

### Workspaces

| Shortcut | Action | Description |
| :--- | :--- | :--- |
| `$mod + [1-0]` | Switch Workspace | Switch to workspace 1 through 10 |
| `$mod + Shift + [1-0]` | Move to Workspace | Move active container to workspace 1 through 10 |

### Screenshots & Media

| Shortcut | Action | Description |
| :--- | :--- | :--- |
| `Print` | Interactive Screenshot | Area selection via `grim` + `slurp` piped to `swappy` |
| `Shift + Print` | Fullscreen Screenshot | Saves full screen capture to `~/Pictures` |
| `Ctrl + Print` | Flameshot | Launch Flameshot GUI |
| `XF86AudioRaiseVolume` | Volume Up | Increase default sink volume by 5% |
| `XF86AudioLowerVolume` | Volume Down | Decrease default sink volume by 5% |
| `XF86AudioMute` | Volume Mute | Toggle sink mute |
| `XF86AudioMicMute` | Mic Mute | Toggle microphone mute |
| `XF86MonBrightnessUp` | Brightness Up | Increase display brightness by 5% |
| `XF86MonBrightnessDown` | Brightness Down | Decrease display brightness by 5% |

### System & Session

| Shortcut | Action | Description |
| :--- | :--- | :--- |
| `$mod + Shift + t` / `Ctrl + Shift + l` | Lock Screen | Lock session with `swaylock` |
| `$mod + Shift + e` | Logout Menu | Display logout / session menu (`wlogout`) |
| `$mod + Shift + d` | Display Settings | Open `nwg-displays` monitor manager |
| `Ctrl + Alt + Delete` | Power Bar | Open `nwg-bar` power action bar |

---

## Configuration Architecture

```
sway/
├── config                   # Entry point (includes config.d/*)
├── config.d/
│   ├── 00_variables.conf    # Modifiers and application variables
│   ├── 01_output.conf       # Monitor output rules and lid switch behavior
│   ├── 02_input.conf        # Touchpad and pointer configuration
│   ├── 03_appearance.conf   # Tokyo Night colors, borders, gaps, font
│   ├── 04_autostart.conf    # Background daemons and desktop services
│   ├── 05_keybindings.conf  # Keybinds, modes, and media keys
│   └── 06_workspaces.conf   # Workspace bindings and monitor assignments
└── README.md                # Keybinding documentation
```
