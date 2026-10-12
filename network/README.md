# Network Configuration & Integration

Network management workflow for Sway on Arch Linux using NetworkManager.

---

## Security Notice

NetworkManager connection profiles (`/etc/NetworkManager/system-connections/`) contain sensitive Wi-Fi PSK passwords, 802.1x enterprise certificates, and VPN tokens. They must **never** be committed to public dotfiles.

---

## Desktop Components & Workflow

- **Backend Daemon**: `NetworkManager.service`
- **System Tray**: `nm-applet --indicator` (autostarted via `sway/config.d/04_autostart.conf`)
- **Interactive TUI**: `nmtui` (triggered on click from the Waybar `network` module)
- **Status Bar Module**: `waybar` displays active SSID and signal strength for Wi-Fi, interface name for Ethernet, and `Disconnected` status.

---

## Quick CLI Reference

```bash
# List available Wi-Fi access points
nmcli device wifi list

# Connect to a network
nmcli device wifi connect "SSID_NAME" password "PASSPHRASE"

# Check active connections
nmcli connection show --active

# Monitor network state live
nmcli monitor
```
