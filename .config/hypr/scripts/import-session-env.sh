#!/usr/bin/env sh
set -eu

vars="WAYLAND_DISPLAY DISPLAY XDG_CURRENT_DESKTOP XDG_SESSION_TYPE XDG_SESSION_DESKTOP HYPRLAND_INSTANCE_SIGNATURE XDG_DATA_DIRS PATH YDOTOOL_SOCKET"

dbus-update-activation-environment --systemd $vars || true
systemctl --user import-environment $vars || true
systemctl --user restart \
    xdg-desktop-portal-hyprland.service \
    xdg-desktop-portal-gtk.service \
    xdg-desktop-portal.service \
    flatpak-portal.service || true
