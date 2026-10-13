#!/bin/sh
# Syntax validation test runner for dotfiles

set -eu

REPO_ROOT="$(cd "$(dirname "$0")/.." && pwd)"
FAILURES=0

echo "==> Validating shell script syntax..."
for script in $(find "$REPO_ROOT" -type f -name "*.sh"); do
    if sh -n "$script" 2>/dev/null; then
        echo "[PASS] Shell syntax: ${script#$REPO_ROOT/}"
    else
        echo "[FAIL] Shell syntax error: ${script#$REPO_ROOT/}" >&2
        FAILURES=$((FAILURES + 1))
    fi
done

echo "==> Validating Zsh configuration syntax..."
if command -v zsh >/dev/null 2>&1; then
    if zsh -n "$REPO_ROOT/shell/zshrc" 2>/dev/null; then
        echo "[PASS] Zsh syntax: shell/zshrc"
    else
        echo "[FAIL] Zsh syntax error: shell/zshrc" >&2
        FAILURES=$((FAILURES + 1))
    fi
fi

echo "==> Validating Bash configuration syntax..."
if bash -n "$REPO_ROOT/shell/bashrc" 2>/dev/null; then
    echo "[PASS] Bash syntax: shell/bashrc"
else
    echo "[FAIL] Bash syntax error: shell/bashrc" >&2
    FAILURES=$((FAILURES + 1))
fi

echo "==> Validating JSON configuration files..."
if command -v jq >/dev/null 2>&1; then
    for json in $(find "$REPO_ROOT/waybar" -type f -name "*.json" -o -name "config"); do
        if [ "$(basename "$json")" != "config" ] && [ "${json##*.}" != "json" ]; then
            continue
        fi
        if jq . "$json" >/dev/null 2>&1; then
            echo "[PASS] JSON syntax: ${json#$REPO_ROOT/}"
        else
            echo "[FAIL] JSON syntax error: ${json#$REPO_ROOT/}" >&2
            FAILURES=$((FAILURES + 1))
        fi
    done
fi

echo "==> Total syntax validation failures: $FAILURES"
[ "$FAILURES" -eq 0 ]
