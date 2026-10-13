# Systemd User Services & Timers

User-level systemd service definitions, timers, and Wayland session targets for Arch Linux.

---

## Overview

Unlike system services (managed by root via `systemctl`), user services run within the `systemd --user` session under the unprivileged user context. These units automatically start on login and tie into the Wayland desktop lifecycle.

---

## Unit Architecture

```
systemd/user/
├── cameractrlsd.service   # Camera parameter restoration daemon
├── clean-cache.service    # Oneshot thumbnail/cache maintenance worker
├── clean-cache.timer      # Weekly scheduler for cache maintenance
└── sway-session.target    # Wayland session target binding graphical units
```

---

## Core Desktop Services

### 1. CameraCtrls Daemon (`cameractrlsd.service`)
- **Purpose**: Restores hardware camera exposure, gain, and color parameters upon login.
- **Target**: Bound to `graphical-session.target`.
- **Command**: `%h/cameractrls/cameractrlsd.py`

### 2. User Cache Maintenance (`clean-cache.timer` & `clean-cache.service`)
- **Purpose**: Prevents disk bloat by removing cached thumbnails (`~/.cache/thumbnails/`) older than 30 days.
- **Trigger**: Runs weekly with persistent catches for missed wakeups.

### 3. Sway Session Target (`sway-session.target`)
- **Purpose**: Provides a standard target for user units that depend on an active Sway compositor session.
- **Binding**: Binds to `graphical-session.target`.

---

## Audio Subsystem Integration

The user audio stack is managed by systemd user sockets and services:

```bash
# Verify audio unit status
systemctl --user status pipewire wireplumber pipewire-pulse

# Restart audio subsystem if required
systemctl --user restart pipewire wireplumber pipewire-pulse
```

---

## CLI Management Reference

```bash
# Enable and start a user service
systemctl --user enable --now cameractrlsd.service

# Enable the weekly cache cleanup timer
systemctl --user enable --now clean-cache.timer

# List active user timers and schedules
systemctl --user list-timers

# Inspect service logs
journalctl --user -u cameractrlsd.service -f
```
