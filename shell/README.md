# Shell & Terminal Configuration

Modular shell environments for Zsh and Bash paired with Alacritty and Kitty terminal emulators.

---

## Architecture & Security

- **Primary Shell**: Zsh with Oh-My-Zsh, Powerlevel10k, `zsh-autosuggestions`, and `zsh-syntax-highlighting`.
- **Secondary Shell**: Bash with matching history controls and alias integration.
- **Local Secret Isolation**: Sensitive API tokens (`GEMINI_API_KEY`, `OPENROUTER_API_KEY`, etc.) and workstation-specific variables must reside in `~/.zshrc.local` or `~/.bashrc.local`. These files are ignored by git and automatically sourced on shell launch.

---

## Productivity Aliases & Shortcuts

### Navigation & Listing

| Command / Alias | Action |
| :--- | :--- |
| `..`, `...`, `....` | Navigate 1, 2, or 3 directories up |
| `mkcd <dir>` | Create directory tree and immediately `cd` into it |
| `up <n>` | Navigate up `n` directories (`up 3` $\rightarrow$ `cd ../../..`) |
| `ls`, `ll`, `la` | Modern file listing via `eza` (icons, git status) or colored `ls` fallback |
| `tree` | Directory tree via `eza --tree --icons` |

### Git Workflow

| Alias | Full Command | Description |
| :--- | :--- | :--- |
| `gs` / `gst` | `git status` | Show working tree status |
| `ga` | `git add` | Stage files |
| `gaa` | `git add --all` | Stage all repository changes |
| `gc` | `git commit` | Commit staged changes |
| `gcm "<msg>"` | `git commit -m "<msg>"` | Fast commit with message |
| `gco <branch>` | `git checkout <branch>` | Switch branch or checkout path |
| `gcb <branch>` | `git checkout -b <branch>` | Create and switch to new branch |
| `gp` | `git push` | Push commits to remote |
| `gl` | `git pull` | Fetch and pull remote changes |
| `gd` | `git diff` | Show file diffs |
| `glog` | `git log --oneline --graph --decorate` | Compact decorated commit graph |

### Arch Linux Package Management

| Alias | Command | Purpose |
| :--- | :--- | :--- |
| `pacup` | `sudo pacman -Syu` | Perform full system upgrade |
| `pacin <pkg>` | `sudo pacman -S <pkg>` | Install package |
| `pacrem <pkg>` | `sudo pacman -Rns <pkg>` | Remove package and unneeded dependencies |
| `pacsearch <query>` | `pacman -Ss <query>` | Search remote package repositories |
| `pacclean` | Cache & orphan cleanup | Remove pacman cache and orphan packages |

### Desktop & Environment

| Alias / Function | Description |
| :--- | :--- |
| `swayreload` | Reload Sway window manager live |
| `waybar-restart` | Restart Waybar status bar |
| `extract <archive>` | Universal unpacker supporting `.tar.gz`, `.tar.bz2`, `.zip`, `.7z`, `.rar`, `.tar.xz`, `.tar.zst` |

---

## Terminal Emulators

- **Alacritty** (`~/.config/alacritty/alacritty.toml`): Primary window manager terminal with 60% opacity, Wayland background blur, and Iosevka Nerd Font.
- **Kitty** (`~/.config/kitty/kitty.conf`): Secondary terminal with full Tokyo Night colorscheme, powerline tab bars, and utility bindings.
