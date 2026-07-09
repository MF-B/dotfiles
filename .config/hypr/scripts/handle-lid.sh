#!/usr/bin/env sh
set -eu

internal="${HYPR_LID_INTERNAL_MONITOR:-eDP-1}"
mode="${HYPR_LID_INTERNAL_MODE:-preferred}"
position="${HYPR_LID_INTERNAL_POSITION:-auto}"
scale="${HYPR_LID_INTERNAL_SCALE:-1}"
action="${1:-}"

case "$action" in
close)
    if ! command -v jq >/dev/null 2>&1; then
        exit 0
    fi

    external_count="$(
        hyprctl monitors -j 2>/dev/null |
            jq --arg internal "$internal" '[.[] | select((.disabled | not) and .name != $internal)] | length'
    )"

    if [ "${external_count:-0}" -gt 0 ]; then
        hyprctl keyword monitor "$internal, disable" >/dev/null
    fi
    ;;
open)
    hyprctl keyword monitor "$internal, $mode, $position, $scale" >/dev/null
    ;;
*)
    printf 'usage: %s close|open\n' "$0" >&2
    exit 2
    ;;
esac
