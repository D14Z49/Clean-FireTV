#!/bin/bash
# Turns ADB Debugging off when you are done (closes port 5555 on your network).
# To turn it back on: Settings > My Fire TV > Developer Options > ADB Debugging.
source "$(dirname "$0")/common.sh"
S settings put global adb_enabled 0; echo "ADB Debugging turned off."
