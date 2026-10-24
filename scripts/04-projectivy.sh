#!/bin/bash
# Installs Projectivy Launcher (from the author's official GitHub releases) and enables the
# accessibility service that lets it take over the Home button.
source "$(dirname "$0")/common.sh"
APK="$ROOT/.cache/projectivy.apk"; mkdir -p "$ROOT/.cache"
URL=$(curl -fsSL https://api.github.com/repos/spocky/miproja1/releases/latest \
  | grep -o '"browser_download_url": *"[^"]*\.apk"' | head -1 | sed 's/.*"\(http[^"]*\)"/\1/')
[ -z "$URL" ] && { echo "Could not find the APK on the releases page."; exit 1; }
echo "Downloading $URL"; curl -fL -o "$APK" "$URL" || exit 1
adb -s "$DEV" install -r "$APK" || exit 1
S settings put secure enabled_accessibility_services \
  com.spocky.projengmenu/com.spocky.projengmenu.services.ProjectivyAccessibilityService
S settings put secure accessibility_enabled 1
echo
echo "Installed. Now, ON THE TV:"
echo "  1. Open Projectivy (Apps) and finish the setup wizard."
echo "  2. Settings > General > turn on 'Override current launcher'."
echo "To undo: turn that option off, or: adb -s $DEV shell settings put secure enabled_accessibility_services null"
