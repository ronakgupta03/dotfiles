#!/bin/sh
# Dotfiles Installation & Bootstrap Script
# Safely links configurations with automated backup protection and dry-run preview

set -eu

DOTFILES_DIR="$(cd "$(dirname "$0")" && pwd)"
CONFIG_DIR="${XDG_CONFIG_HOME:-$HOME/.config}"
BIN_DIR="$HOME/.local/bin"
BACKUP_BASE="${HOME}/.dotfiles_backup"
TIMESTAMP="$(date +%Y%m%d_%H%M%S)"
BACKUP_DIR="$BACKUP_BASE/$TIMESTAMP"
BACKUP_CREATED=false
DRY_RUN=false

show_help() {
    cat <<EOF
Usage: $(basename "$0") [OPTIONS]

Options:
    -n, --dry-run    Simulate installation without modifying files or creating links
    -h, --help       Show this help message and exit

Description:
    Symlinks modular dotfiles from this repository into ~/.config and user home.
    If an existing file or directory is found, it is safely moved into a timestamped
    backup directory at ~/.dotfiles_backup/<timestamp>/ before linking.
EOF
}

# Parse command line options
for arg in "$@"; do
    case "$arg" in
        -n|--dry-run)
            DRY_RUN=true
            ;;
        -h|--help)
            show_help
            exit 0
            ;;
        *)
            echo "Error: unrecognized option '$arg'" >&2
            show_help >&2
            exit 1
            ;;
    esac
done

# Verify required core utilities
for cmd in ln mkdir readlink date mv; do
    if ! command -v "$cmd" >/dev/null 2>&1; then
        echo "Error: required utility '$cmd' is not available in PATH." >&2
        exit 1
    fi
done

if [ "$DRY_RUN" = true ]; then
    echo "==> Running in DRY-RUN mode (no files will be modified)"
fi
echo "==> Installing dotfiles from $DOTFILES_DIR"

# Ensure target directories exist
if [ "$DRY_RUN" = false ]; then
    mkdir -p "$CONFIG_DIR" "$CONFIG_DIR/shell" "$CONFIG_DIR/systemd/user" "$BIN_DIR"
fi

backup_if_needed() {
    target="$1"
    source="$2"

    if [ -e "$target" ] || [ -L "$target" ]; then
        # Already pointing to correct source link
        if [ -L "$target" ] && [ "$(readlink -f "$target")" = "$(readlink -f "$source")" ]; then
            return 0
        fi

        rel_path="${target#$HOME/}"
        dest_backup="$BACKUP_DIR/$rel_path"

        if [ "$DRY_RUN" = true ]; then
            echo "[DRY-RUN] Would backup $target -> $dest_backup"
            return 0
        fi

        if [ "$BACKUP_CREATED" = false ]; then
            mkdir -p "$BACKUP_DIR"
            BACKUP_CREATED=true
            echo "==> Created backup directory at $BACKUP_DIR"
        fi

        mkdir -p "$(dirname "$dest_backup")"
        echo "[BACKUP] Moving existing $target -> $dest_backup"
        mv "$target" "$dest_backup"
    fi
}

link_item() {
    src="$1"
    dst="$2"

    if [ ! -e "$src" ]; then
        echo "[WARN] Source path does not exist, skipping: $src" >&2
        return 0
    fi

    backup_if_needed "$dst" "$src"

    if [ "$DRY_RUN" = true ]; then
        echo "[DRY-RUN] Would link $src -> $dst"
    else
        echo "[LINK] $src -> $dst"
        ln -sf "$src" "$dst"
    fi
}

# 1. XDG Config directories
for dir in sway waybar alacritty kitty mako rofi wireplumber gtk-3.0 gtk-4.0; do
    if [ -d "$DOTFILES_DIR/$dir" ]; then
        link_item "$DOTFILES_DIR/$dir" "$CONFIG_DIR/$dir"
    fi
done

# 2. Shell configurations
[ -f "$DOTFILES_DIR/shell/zshrc" ] && link_item "$DOTFILES_DIR/shell/zshrc" "$HOME/.zshrc"
[ -f "$DOTFILES_DIR/shell/bashrc" ] && link_item "$DOTFILES_DIR/shell/bashrc" "$HOME/.bashrc"
[ -f "$DOTFILES_DIR/shell/aliases.sh" ] && link_item "$DOTFILES_DIR/shell/aliases.sh" "$CONFIG_DIR/shell/aliases.sh"

# 3. Systemd user units
if [ -d "$DOTFILES_DIR/systemd/user" ]; then
    for unit in "$DOTFILES_DIR/systemd/user"/*; do
        if [ -f "$unit" ]; then
            link_item "$unit" "$CONFIG_DIR/systemd/user/$(basename "$unit")"
        fi
    done
fi

# 4. Helper scripts
if [ -d "$DOTFILES_DIR/scripts" ]; then
    for script in "$DOTFILES_DIR/scripts"/*.sh; do
        if [ -f "$script" ]; then
            name="$(basename "$script" .sh)"
            link_item "$script" "$BIN_DIR/$name"
        fi
    done
fi

# 5. Root dotfiles
[ -f "$DOTFILES_DIR/.Xresources" ] && link_item "$DOTFILES_DIR/.Xresources" "$HOME/.Xresources"

if [ "$DRY_RUN" = true ]; then
    echo "==> Dry-run simulation finished cleanly."
elif [ "$BACKUP_CREATED" = true ]; then
    echo "==> Existing configuration backed up to: $BACKUP_DIR"
fi
echo "==> Done!"
