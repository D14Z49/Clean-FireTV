#!/bin/bash
# GOOGLE TV ONLY (e.g. TCL). Installs Projectivy Launcher and makes it the REAL home screen:
# the Google TV launcher is disabled (reversible), so there is no ads screen and no delay on Home.
# Usage: bash scripts/06-google-tv-launcher.sh          -> install and switch
#        bash scripts/06-google-tv-launcher.sh restore  -> bring the Google TV home screen back
source "$(dirname "$0")/common.sh"
GTV=com.google.android.apps.tv.launcherx
SETUP=com.google.android.tungsten.setupwraith   # otherwise grabs the Home button once Google's launcher is gone
PROJ=com.spocky.projengmenu

if [ "$1" = "restore" ]; then
  S pm enable $GTV; S pm enable $SETUP
  S cmd package set-home-activity $GTV/.home.HomeActivity
  echo "Google TV home screen restored. Projectivy stays installed (uninstall it from Settings > Apps if you want)."
  exit
fi

S pm list packages $GTV | grep -q $GTV || { echo "This is not a Google TV ($GTV not found). On Fire TV use scripts/04-projectivy.sh."; exit 1; }

if ! S pm list packages $PROJ | grep -q $PROJ; then
  APK="$ROOT/.cache/projectivy.apk"; mkdir -p "$ROOT/.cache"
  URL=$(curl -fsSL https://api.github.com/repos/spocky/miproja1/releases/latest \
    | grep -o '"browser_download_url": *"[^"]*\.apk"' | head -1 | sed 's/.*"\(http[^"]*\)"/\1/')
  [ -z "$URL" ] && { echo "Could not find the APK on the releases page."; exit 1; }
  echo "Downloading $URL"; curl -fL -o "$APK" "$URL" || exit 1
  adb -s "$DEV" install -r "$APK" || exit 1
fi

ACT=$(S cmd package query-activities --brief -a android.intent.action.MAIN -c android.intent.category.HOME | grep "$PROJ" | head -1 | tr -d ' ')
[ -z "$ACT" ] && { echo "Projectivy home activity not found; nothing was disabled."; exit 1; }
S pm disable-user --user 0 $GTV; S pm disable-user --user 0 $SETUP
S cmd package set-home-activity "$ACT"
S input keyevent KEYCODE_HOME
echo
echo "Done: Home now opens Projectivy. ON THE TV, finish Projectivy's setup wizard."
echo "Settings: Projectivy's gear icon. Undo: bash scripts/06-google-tv-launcher.sh restore"
