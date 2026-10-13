# Machine-Specific Configuration & Portability Guide

How to customize and adapt these dotfiles across different machines and hardware configurations.

---

## 1. Monitor & Display Layout

Sway output configurations depend on your specific GPU, display connector names (`eDP-1`, `HDMI-A-1`, `DP-1`), resolutions, and scaling preferences.

### Discovering Displays
Run the following command while in Sway to list active display connectors:

```bash
swaymsg -t get_outputs
```

### Applying Custom Outputs
Copy the provided template:

```bash
cp templates/outputs.conf.example ~/.config/sway/outputs
```

Edit `~/.config/sway/outputs` with your monitor names, resolution, and desired scaling factor (e.g., `scale 1.0` for 1080p, `scale 1.25` for HiDPI). Alternatively, open `nwg-displays` (`$mod + Shift + d`) to arrange displays graphically.

---

## 2. Secrets & Machine Environment Overrides

Workstation-specific environment variables and API keys must **never** be added to version-controlled files (`zshrc`, `bashrc`).

### Setting Up Local Environment
Copy the provided template to your home directory:

```bash
cp templates/zshrc.local.example ~/.zshrc.local
```

`~/.zshrc.local` (and `~/.bashrc.local`) is automatically sourced at the end of shell initialization and is ignored by git.

Use it for:
- Personal API keys (`GEMINI_API_KEY`, `OPENROUTER_API_KEY`, etc.)
- GPU hardware acceleration flags (e.g. `LIBVA_DRIVER_NAME=nvidia`, `WLR_NO_HARDWARE_CURSORS=1`)
- Custom machine-specific `PATH` adjustments

---

## 3. Audio & Hardware Sinks

If your machine has multiple soundcards, set your preferred default sink:

```bash
# List available audio devices
wpctl status

# Set default sink by ID
wpctl set-default <ID>
```

---

## 4. Camera Daemon (`cameractrlsd`)

If you use `cameractrlsd.service`, ensure the `cameractrls` tool is cloned in `~/cameractrls`:

```bash
git clone https://github.com/soyersoyer/cameractrls.git ~/cameractrls
systemctl --user enable --now cameractrlsd.service
```
If you do not require camera parameter restoration, you can safely skip this service.
