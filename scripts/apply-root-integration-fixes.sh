#!/usr/bin/env bash
set -euo pipefail

if [[ "$(id -u)" -ne 0 ]]; then
    printf 'Run this script as root, for example: sudo %s\n' "$0" >&2
    exit 1
fi

target_user="${SUDO_USER:-}"
if [[ -z "$target_user" && -n "${PKEXEC_UID:-}" ]]; then
    target_user="$(getent passwd "$PKEXEC_UID" | cut -d: -f1)"
fi
target_user="${target_user:-mf1bzz}"

repo_root="$(cd -- "$(dirname -- "${BASH_SOURCE[0]}")/.." && pwd)"
target_home="$(getent passwd "$target_user" | cut -d: -f6)"
target_uid="$(id -u "$target_user")"
target_gid="$(id -g "$target_user")"
swappy_open="$repo_root/.local/bin/swappy-open"

if [[ ! -f "$swappy_open" ]]; then
    swappy_open="$target_home/.local/bin/swappy-open"
fi

install -D -m 0755 "$swappy_open" /usr/local/bin/swappy-open

if [[ -f /usr/share/applications/swappy.desktop ]]; then
    desktop-file-edit \
        --set-key=Exec \
        --set-value="/usr/local/bin/swappy-open %F" \
        /usr/share/applications/swappy.desktop
    update-desktop-database /usr/share/applications || true
fi

mkdir -p /etc/systemd/system/ydotool.service.d
cat >/etc/systemd/system/ydotool.service.d/10-user-socket.conf <<EOF
[Service]
ExecStart=
ExecStart=/usr/bin/ydotoold --socket-own=${target_uid}:${target_gid} --socket-perm=0600
EOF

systemctl daemon-reload
systemctl enable --now ydotool.service
systemctl restart ydotool.service

printf 'Updated swappy.desktop and ydotool.service for %s.\n' "$target_user"
