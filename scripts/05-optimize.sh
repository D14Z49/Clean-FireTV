#!/bin/bash
# Animations at 0.5x + clears every app's cache. To restore normal animations: ANIM=1 bash scripts/05-optimize.sh
source "$(dirname "$0")/common.sh"
V="${ANIM:-0.5}"
before=$(S df /data | awk 'NR==2{print $4}')
for k in window_animation_scale transition_animation_scale animator_duration_scale; do S settings put global $k $V; done
echo "Animation scale: $V"
echo "Clearing caches (up to 1 minute)..."; S pm trim-caches 999999999999 >/dev/null
after=$(S df /data | awk 'NR==2{print $4}')
echo "Freed: $(( (after-before)/1024 )) MB  |  Free now: $(S df -h /data | awk 'NR==2{print $4}')"
