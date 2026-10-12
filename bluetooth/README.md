# Desktop Bluetooth Configuration

Bluetooth audio and device management for Sway on Arch Linux.

---

## Architecture

- **Stack**: BlueZ (`systemd` system service `bluetooth.service`)
- **Audio Routing**: PipeWire + WirePlumber (`wireplumber.service`)
- **System Tray Applet**: `blueman-applet`
- **Device Management**: `blueman-manager` (GUI) and `bluetoothctl` (CLI)
- **Status Bar Integration**: `waybar/scripts/bluetooth.sh`

---

## WirePlumber High-Definition Codecs

WirePlumber is configured to negotiate high-fidelity Bluetooth audio profiles automatically:

- **SBC-XQ (eXtra Quality)**: Dual-channel high-bitrate SBC audio codec.
- **mSBC (modified SBC)**: Wideband speech codec for Bluetooth headsets (HFP/HSP).
- **A2DP Roles**: Both Sink and Source roles enabled in `wireplumber/wireplumber.conf.d/51-bluez.conf`.

---

## Blueman Desktop Preferences

Configured via `gsettings` (`org.blueman.general`):

```bash
# Hide unnamed Bluetooth advertising devices
gsettings set org.blueman.general hide-unnamed true

# Enable desktop notifications for device pairing and connect events
gsettings set org.blueman.general notification-daemon true

# Statusbar and toolbar presentation
gsettings set org.blueman.general show-statusbar true
gsettings set org.blueman.general show-toolbar false
```

---

## Desktop Keybindings & Controls

- **Waybar Click**: Click the Bluetooth icon on the top status bar to toggle adapter power (`bluetoothctl power on/off`).
- **Sway Shortcut**: `$mod + m` opens the Bluetooth manager.
