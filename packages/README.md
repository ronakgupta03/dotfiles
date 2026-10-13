# Package Reproducibility & Manifests

Explicit package lists for bootstrapping and reproducing this Arch Linux desktop environment.

---

## Manifest Files

| File | Purpose | Count |
| :--- | :--- | :--- |
| **`pacman-packages.txt`** | Full snapshot of explicitly installed official Arch packages | 202 |
| **`aur-packages.txt`** | Explicitly installed Arch User Repository (AUR) packages | 22 |
| **`core-desktop.txt`** | Minimal required packages to boot and operate Sway + Waybar | ~30 |
| **`fonts-themes.txt`** | Required Nerd fonts and icon/cursor themes | ~7 |
| **`development.txt`** | Development toolchain, compilers, and CLI utilities | ~17 |
| **`optional-apps.txt`** | Graphical applications, media players, and extra tools | ~8 |

---

## Installation Commands

### 1. Minimal Desktop Setup (Core Only)

To install only the components needed for the Sway desktop, status bar, and fonts:

```bash
# Core desktop packages
sudo pacman -S --needed - < packages/core-desktop.txt

# Typography and themes
sudo pacman -S --needed - < packages/fonts-themes.txt
```

### 2. Developer Toolchain & Optional Applications

```bash
# Development utilities
sudo pacman -S --needed - < packages/development.txt

# Desktop applications
sudo pacman -S --needed - < packages/optional-apps.txt
```

### 3. Full System Replication

To reproduce the entire official and AUR package set on a new installation:

```bash
# Official Arch repositories
sudo pacman -S --needed - < packages/pacman-packages.txt

# Arch User Repository via yay
yay -S --needed - < packages/aur-packages.txt
```

---

## Updating Package Manifests

Whenever packages are added or removed, update the tracked lists with:

```bash
# Update official list
pacman -Qqen | sort > packages/pacman-packages.txt

# Update AUR list (excluding debug symbols)
pacman -Qqem | sort | grep -v '\-debug$' > packages/aur-packages.txt
```
