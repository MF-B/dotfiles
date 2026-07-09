#!/usr/bin/env bash
set -euo pipefail

repo_root="$(cd -- "$(dirname -- "${BASH_SOURCE[0]}")/.." && pwd)"

copy_file() {
    local rel="$1"
    local src="$HOME/$rel"
    local dst="$repo_root/$rel"

    if [[ ! -e "$src" ]]; then
        printf 'skip missing file: %s\n' "$rel" >&2
        return
    fi

    mkdir -p -- "$(dirname -- "$dst")"
    cp -a -- "$src" "$dst"
}

copy_dir() {
    local rel="$1"
    local src="$HOME/$rel"
    local dst="$repo_root/$rel"

    if [[ ! -d "$src" ]]; then
        printf 'skip missing dir: %s\n' "$rel" >&2
        return
    fi

    rm -rf -- "$dst"
    mkdir -p -- "$(dirname -- "$dst")"
    cp -a -- "$src" "$dst"
}

copy_file ".config/hypr/hyprland.conf"
copy_file ".config/hypr/variables.conf"
copy_dir ".config/hypr/hyprland"
copy_dir ".config/hypr/scheme"
copy_dir ".config/hypr/scripts"

rm -f -- "$repo_root/.config/hypr/hyprland/animations.conf.bak"
rm -f -- "$repo_root/.config/hypr/scheme/current.conf"

copy_file ".config/caelestia/shell.json"
copy_file ".config/caelestia/hypr-vars.conf"
copy_file ".config/caelestia/hypr-user.conf"
copy_file ".config/caelestia/monitors/eDP-1/shell.json"

copy_file ".config/foot/foot.ini"
copy_file ".config/fish/config.fish"
copy_file ".config/fish/functions/fish_greeting.fish"

copy_file ".local/share/applications/swappy.desktop"
copy_file ".local/bin/swappy-open"

printf 'dotfiles refreshed from %s\n' "$HOME"
