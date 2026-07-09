#!/usr/bin/env sh
set -eu

socket="${YDOTOOL_SOCKET:-/tmp/.ydotool_socket}"
export YDOTOOL_SOCKET="$socket"

notify() {
    notify-send -a hyprland -u low "Alternate paste unavailable" "$1" || true
}

sleep 0.5

if ! command -v ydotool >/dev/null 2>&1; then
    notify "ydotool is not installed."
    exit 0
fi

if [ ! -S "$socket" ]; then
    notify "ydotoold is not running. Enable ydotool.service first."
    exit 0
fi

tmp="$(mktemp)"
trap 'rm -f "$tmp"' EXIT

cliphist list | head -n 1 | cliphist decode >"$tmp"

if [ ! -s "$tmp" ]; then
    exit 0
fi

if ! ydotool type -d 1 -f "$tmp"; then
    notify "ydotool could not access $socket."
fi
