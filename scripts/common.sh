#!/bin/bash
# Shared helpers. The Fire Stick IP comes from FIRE_IP, from the .fire_ip file (saved on first run),
# or is asked interactively. Find it at: Settings > My Fire TV > About > Network.
ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"

[ -z "$FIRE_IP" ] && [ -f "$ROOT/.fire_ip" ] && FIRE_IP=$(cat "$ROOT/.fire_ip")
if [ -z "$FIRE_IP" ]; then
  read -p "Fire Stick IP address (e.g. 192.168.0.50): " FIRE_IP
  [ -z "$FIRE_IP" ] && exit 1
fi
echo "$FIRE_IP" > "$ROOT/.fire_ip"
DEV="${FIRE_IP%:5555}:5555"

command -v adb >/dev/null || { echo "adb not found. macOS: brew install --cask android-platform-tools | Linux: sudo apt install adb"; exit 1; }
adb connect "$DEV" >/dev/null 2>&1; sleep 2
adb -s "$DEV" get-state >/dev/null 2>&1 || { echo "Cannot reach $DEV. Turn on 'ADB Debugging' on the TV and accept the prompt on screen."; exit 1; }

# </dev/null is required: without it 'adb shell' swallows stdin and 'while read' loops stop after the first item
S() { adb -s "$DEV" shell "$@" </dev/null 2>&1 | tr -d '\r'; }

# Reads a package list, ignoring comments (#) and blank lines
packages() { sed 's/#.*//' "$1" | tr -d ' \t\r' | grep -v '^$'; }
