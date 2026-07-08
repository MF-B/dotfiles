#!/usr/bin/env bash
set -euo pipefail

repo_root="$(cd -- "$(dirname -- "${BASH_SOURCE[0]}")/.." && pwd)"
backup_dir="$HOME/.dotfiles-backup-$(date +%Y%m%d-%H%M%S)"

install_path() {
    local rel="$1"
    local src="$repo_root/$rel"
    local dst="$HOME/$rel"

    if [[ ! -e "$src" ]]; then
        printf 'skip missing repo path: %s\n' "$rel" >&2
        return
    fi

    if [[ -e "$dst" || -L "$dst" ]]; then
        mkdir -p -- "$backup_dir/$(dirname -- "$rel")"
        cp -a -- "$dst" "$backup_dir/$rel"
    fi

    mkdir -p -- "$(dirname -- "$dst")"
    rm -rf -- "$dst"
    cp -a -- "$src" "$dst"
}

install_path ".config/hypr/hyprland.conf"
install_path ".config/hypr/variables.conf"
install_path ".config/hypr/hyprland"
install_path ".config/hypr/scheme"
install_path ".config/hypr/scripts"

install_path ".config/caelestia/shell.json"
install_path ".config/caelestia/hypr-vars.conf"
install_path ".config/caelestia/hypr-user.conf"
install_path ".config/caelestia/monitors/eDP-1/shell.json"

install_path ".config/foot/foot.ini"
install_path ".config/fish/config.fish"
install_path ".config/fish/functions/fish_greeting.fish"

install_path ".local/bin/caelestia-location"

if [[ -d "$backup_dir" ]]; then
    printf 'existing files backed up to %s\n' "$backup_dir"
fi

printf 'dotfiles installed into %s\n' "$HOME"
