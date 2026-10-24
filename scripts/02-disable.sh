#!/bin/bash
# Disables (pm disable-user, fully reversible) the packages in one or more lists.
# Usage: bash scripts/02-disable.sh lists/ads-telemetry.txt [more lists...]
source "$(dirname "$0")/common.sh"
[ $# -eq 0 ] && { echo "Pass at least one list, e.g. lists/ads-telemetry.txt"; exit 1; }
LOG="$ROOT/disabled.log"
for list in "$@"; do
  [ -f "$list" ] || { echo "List not found: $list"; continue; }
  echo "== $list"
  packages "$list" | while read -r p; do
    if packages "$ROOT/lists/do-not-touch.txt" | grep -qx "$p"; then echo "   $p => SKIPPED (in do-not-touch.txt)"; continue; fi
    r=$(S pm disable-user --user 0 "$p" | head -1)
    echo "   $p => $r"
    echo "$r" | grep -q "disabled-user" && echo "$p" >> "$LOG"
  done
done
[ -f "$LOG" ] && sort -u "$LOG" -o "$LOG"
echo "Done. Restart the Fire Stick (hold Select + Play/Pause for 5 s). To undo: bash scripts/03-restore.sh"
