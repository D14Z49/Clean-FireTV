#!/bin/bash
# Takes a screenshot of the TV (handy when asking for help). Saves screenshot.png in the project folder.
source "$(dirname "$0")/common.sh"
S screencap -p /sdcard/screenshot.png >/dev/null
adb -s "$DEV" pull /sdcard/screenshot.png "$ROOT/screenshot.png" >/dev/null && S rm /sdcard/screenshot.png >/dev/null
echo "Saved to $ROOT/screenshot.png (Netflix and other DRM apps show up black)"
