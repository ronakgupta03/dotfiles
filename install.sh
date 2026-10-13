#!/bin/sh
# Dotfiles Installation & Bootstrap Script

DOTFILES_DIR="$(cd "$(dirname "$0")" && pwd)"
CONFIG_DIR="${XDG_CONFIG_HOME:-$HOME/.config}"
BIN_DIR="$HOME/.local/bin"

echo "==> Installing dotfiles from $DOTFILES_DIR"

# Ensure target directories exist
mkdir -p "$CONFIG_DIR" "$CONFIG_DIR/shell" "$CONFIG_DIR/systemd/user" "$BIN_DIR"

link_item() {
    src="$1"
    dst="$2"
    echo "Linking $src -> $dst"
    ln -sf "$src" "$dst"
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
        [ -f "$unit" ] && link_item "$unit" "$CONFIG_DIR/systemd/user/$(basename "$unit")"
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

echo "==> Installation complete!"
