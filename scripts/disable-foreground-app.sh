#!/bin/bash
# Shows which app is open on the TV right now and, after confirmation, disables it (reversible).
# Useful to find the package behind a stubborn tile. Critical packages are protected.
# Pass -y to skip the confirmation (non-interactive use).
source "$(dirname "$0")/common.sh"
FG=$(S dumpsys activity activities | grep -m1 ResumedActivity | grep -o '[a-z][a-z0-9_.]*/[A-Za-z0-9_.$]*' | head -1)
PKG=${FG%%/*}
echo "App on screen: ${FG:-none}"
[ -z "$PKG" ] && exit 1
packages "$ROOT/lists/do-not-touch.txt" | grep -qx "$PKG" && { echo "This package is in do-not-touch.txt. Nothing done."; exit 1; }
if [ "$1" != "-y" ]; then read -p "Disable $PKG? [y/N] " r; [ "$r" = "y" ] || exit 0; fi
S am force-stop "$PKG" >/dev/null
r=$(S pm disable-user --user 0 "$PKG" | head -1); echo "$PKG => $r"
echo "$r" | grep -q "disabled-user" && echo "$PKG" >> "$ROOT/disabled.log"
