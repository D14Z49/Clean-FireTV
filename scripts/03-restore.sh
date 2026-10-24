#!/bin/bash
# Re-enables everything 02-disable.sh disabled (disabled.log), or a single package.
# Usage: bash scripts/03-restore.sh                -> re-enable everything
#        bash scripts/03-restore.sh com.amazon.x   -> re-enable just that one
source "$(dirname "$0")/common.sh"
LOG="$ROOT/disabled.log"
if [ -n "$1" ]; then S pm enable "$1"; exit; fi
[ -f "$LOG" ] || { echo "Nothing to restore ($LOG not found)."; exit 0; }
while read -r p; do echo "   $p => $(S pm enable "$p")"; done < "$LOG"
mv "$LOG" "$LOG.restored"
echo "Everything re-enabled. Restart the Fire Stick."
