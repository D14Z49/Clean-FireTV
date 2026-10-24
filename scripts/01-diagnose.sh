#!/bin/bash
# READ-ONLY diagnostic. Saves report.txt in the project folder.
source "$(dirname "$0")/common.sh"
OUT="$ROOT/report.txt"
{
  echo "=== DEVICE ==="; S getprop ro.product.model; S getprop ro.build.version.name
  echo; echo "=== CURRENT LAUNCHER ==="; S cmd package resolve-activity -a android.intent.action.MAIN -c android.intent.category.HOME | grep packageName | head -1
  echo; echo "=== SYSTEM PACKAGES ==="; S pm list packages -s | sort
  echo; echo "=== USER-INSTALLED PACKAGES ==="; S pm list packages -3 | sort
  echo; echo "=== ALREADY DISABLED ==="; S pm list packages -d | sort
  echo; echo "=== STORAGE AND MEMORY ==="; S df -h /data; S cat /proc/meminfo | head -3
} > "$OUT"
echo "Report saved to $OUT"
