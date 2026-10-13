#!/bin/sh
# Path verification test suite for dotfiles
# Verifies that all installation sources, configurations, and internal links exist.

set -eu

REPO_ROOT="$(cd "$(dirname "$0")/.." && pwd)"
ERRORS=0

log_pass() { echo "[PASS] $1"; }
log_fail() { echo "[FAIL] $1" >&2; ERRORS=$((ERRORS + 1)); }

echo "==> Verifying installation source paths..."

# 1. Config directories
for dir in sway waybar alacritty kitty mako rofi wireplumber gtk-3.0 gtk-4.0; do
    if [ -d "$REPO_ROOT/$dir" ]; then
        log_pass "Directory exists: $dir"
    else
        log_fail "Directory missing: $dir"
    fi
done

# 2. Shell configurations
for file in shell/zshrc shell/bashrc shell/aliases.sh .Xresources .env.example; do
    if [ -f "$REPO_ROOT/$file" ]; then
        log_pass "Shell/Root file exists: $file"
    else
        log_fail "Shell/Root file missing: $file"
    fi
done

# 3. Helper scripts
for script in brightness.sh volume.sh screenshot.sh clipboard.sh; do
    if [ -f "$REPO_ROOT/scripts/$script" ]; then
        log_pass "Script exists: scripts/$script"
    else
        log_fail "Script missing: scripts/$script"
    fi
done

# 4. Systemd units
for unit in cameractrlsd.service clean-cache.service clean-cache.timer sway-session.target; do
    if [ -f "$REPO_ROOT/systemd/user/$unit" ]; then
        log_pass "Systemd unit exists: systemd/user/$unit"
    else
        log_fail "Systemd unit missing: systemd/user/$unit"
    fi
done

# 5. Sway modules
for module in 00_variables.conf 01_output.conf 02_input.conf 03_appearance.conf 04_autostart.conf 05_keybindings.conf 06_workspaces.conf; do
    if [ -f "$REPO_ROOT/sway/config.d/$module" ]; then
        log_pass "Sway module exists: sway/config.d/$module"
    else
        log_fail "Sway module missing: sway/config.d/$module"
    fi
done

# 6. Waybar helper scripts
for script in bluetooth.sh cpu_temp.sh swap.sh; do
    if [ -f "$REPO_ROOT/waybar/scripts/$script" ]; then
        log_pass "Waybar script exists: waybar/scripts/$script"
    else
        log_fail "Waybar script missing: waybar/scripts/$script"
    fi
done

# 7. Package manifests
for manifest in pacman-packages.txt aur-packages.txt core-desktop.txt fonts-themes.txt development.txt optional-apps.txt; do
    if [ -f "$REPO_ROOT/packages/$manifest" ]; then
        log_pass "Package manifest exists: packages/$manifest"
    else
        log_fail "Package manifest missing: packages/$manifest"
    fi
done

echo "==> Total path failures: $ERRORS"
[ "$ERRORS" -eq 0 ]
