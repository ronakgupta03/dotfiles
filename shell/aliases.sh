# Shell Productivity Aliases & Helper Functions

# --- Navigation & Directory Listing ---
alias ..='cd ..'
alias ...='cd ../..'
alias ....='cd ../../..'

if command -v eza >/dev/null 2>&1; then
    alias ls='eza --icons'
    alias ll='eza -lh --icons --git'
    alias la='eza -lha --icons --git'
    alias tree='eza --tree --icons'
else
    alias ls='ls --color=auto'
    alias ll='ls -lah --color=auto'
    alias la='ls -A --color=auto'
    alias l='ls -CF --color=auto'
fi

# --- Git Shortcuts ---
alias g='git'
alias gs='git status'
alias gst='git status'
alias ga='git add'
alias gaa='git add --all'
alias gc='git commit'
alias gcm='git commit -m'
alias gco='git checkout'
alias gcb='git checkout -b'
alias gp='git push'
alias gl='git pull'
alias gd='git diff'
alias glog='git log --oneline --graph --decorate'

# --- Arch Linux Package Management ---
alias pacup='sudo pacman -Syu'
alias pacin='sudo pacman -S'
alias pacrem='sudo pacman -Rns'
alias pacsearch='pacman -Ss'
alias pacclean='sudo pacman -Sc && sudo pacman -Rns $(pacman -Qtdq 2>/dev/null)'

# --- Desktop & Session Helpers ---
alias swayreload='swaymsg reload'
alias waybar-restart='pkill waybar; waybar >/dev/null 2>&1 &'
alias wrap='warp'

# --- Safety Defaults ---
alias cp='cp -i'
alias mv='mv -i'
alias rm='rm -I'

# --- Productivity Functions ---

# Create directory and enter it immediately
mkcd() {
    mkdir -p "$1" && cd "$1" || return
}

# Navigate up N directories: up 3
up() {
    local count=${1:-1}
    local path=""
    while [ "$count" -gt 0 ]; do
        path="../$path"
        count=$((count - 1))
    done
    cd "$path" || return
}

# Extract archive by extension
extract() {
    if [ -f "$1" ]; then
        case "$1" in
            *.tar.bz2)   tar xjf "$1"     ;;
            *.tar.gz)    tar xzf "$1"     ;;
            *.bz2)       bunzip2 "$1"     ;;
            *.rar)       unrar x "$1"     ;;
            *.gz)        gunzip "$1"      ;;
            *.tar)       tar xf "$1"      ;;
            *.tbz2)      tar xjf "$1"     ;;
            *.tgz)       tar xzf "$1"     ;;
            *.zip)       unzip "$1"       ;;
            *.Z)         uncompress "$1"  ;;
            *.7z)        7z x "$1"        ;;
            *.tar.xz)    tar xf "$1"      ;;
            *.tar.zst)   unzstd -c "$1" | tar xf - ;;
            *)           echo "'$1' cannot be extracted via extract()" ;;
        esac
    else
        echo "'$1' is not a valid file"
    fi
}
