# Instructions for AI coding assistants (Claude Code, Codex, Gemini CLI and similar)

The user wants to clean up their Amazon Fire TV Stick with this repository. Guide them end to end, **one step at a time**, in plain language. **Talk to the user in the language they write to you in.** For example, if they write in Portuguese, answer in Portuguese; `README.pt-BR.md` and `docs/pt-BR/` have translated texts you can reuse.

## Rules

1. **Never disable anything without showing the list and getting a "yes" from the user.** Everything uses `pm disable-user` (reversible). Never `pm uninstall` system apps.
2. **Never touch packages in `lists/do-not-touch.txt`.** `scripts/02-disable.sh` also skips them.
3. **Ask before applying `lists/alexa.txt`.** If the user has Echo devices or an Amazon smart home, do not apply it.
4. **Run the scripts from the repository root and pass the IP in `FIRE_IP`**, so nothing blocks on interactive prompts. Example: `FIRE_IP=192.168.0.50 bash scripts/01-diagnose.sh`.
5. `Cannot disable a protected package` is expected for some packages; Amazon protects them. Move on.
6. After each step, verify the result. Use `scripts/screenshot.sh` and look at the PNG whenever you need to see the TV.
7. If something stops working, re-enable it with `bash scripts/03-restore.sh PACKAGE_NAME`, or re-enable everything with `bash scripts/03-restore.sh`.

## Walkthrough

### 0. Prerequisites
- **Computer:** check `adb` (`command -v adb`). If missing, install it:
  - macOS: `brew install --cask android-platform-tools`
  - Linux: `sudo apt install adb`
  - Windows: Android Platform-Tools, or WSL
- **Fire Stick:** walk the user through it on the TV:
  1. Settings > My Fire TV > About: note the **model and Fire OS version**.
  2. Click the device name 7 times to unlock **Developer Options**.
  3. Developer Options: turn on **ADB Debugging** and **Apps from Unknown Sources**.
  4. About > Network: note the **IP address**.
- If the device runs **Vega OS** instead of Fire OS, stop: this method does not work there.

### 1. Diagnose
1. Run `FIRE_IP=<ip> bash scripts/01-diagnose.sh`. The user must accept **"Allow USB debugging?"** on the TV and tick "Always allow".
2. Read `report.txt` and cross-check it with the lists. Show the user only the packages that **exist** on their device.
3. Point out suspicious user-installed apps (sideloaded IPTV, duplicates) and ask whether they use them.

### 2. Ask the user, before disabling anything
- Do they use **Alexa, Echo devices or an Amazon smart home**? If not, offer `lists/alexa.txt`.
- Do they use **Amazon Kids, Amazon Music, Amazon Photos, or the Silk browser ("Internet")**?
- Do they use **Luna**? Warn that it only works in supported countries.
- Do they want to **replace the home screen** with Projectivy? Explain the trade-off in step 4.

### 3. Disable
- Recommended: `FIRE_IP=<ip> bash scripts/02-disable.sh lists/ads-telemetry.txt`
- Optional: copy the chosen lines from `lists/optional.txt` into `lists/mine.txt` (without the `#`) and run the same script with it.
- Then ask the user to **restart** (hold Select + Play/Pause for 5 s) and test Netflix, YouTube, Prime Video, voice search and Settings.

### 4. Ad-free home screen (optional)
- Run `FIRE_IP=<ip> bash scripts/04-projectivy.sh` and guide the user on the TV:
  1. Open Projectivy and finish the wizard.
  2. Settings > General > turn on **"Override current launcher"**.
  3. Optional: turn off the two "anonymous reports" toggles.
- **Tell the user three things:**
  - Pressing Home shows the Amazon screen for ~5 s before Projectivy takes over. This is a Fire OS limitation (Amazon's launcher is protected) and cannot be removed.
  - To reach **Fire TV Settings**, hold the Home button for 3 s.
  - To get the Amazon home screen back, just turn "Override current launcher" off.

### 5. Optimize
- `FIRE_IP=<ip> bash scripts/05-optimize.sh` sets animations to 0.5x and clears caches.
- From the menu (not possible over ADB):
  - Settings > Preferences > Privacy Settings: turn off all three toggles.
  - Preferences > Featured Content: turn off video and audio autoplay.
- Suggest DNS blocking on the router. See `docs/dns-blocking.md`.

### 6. Wrap up
- Run `bash scripts/disable-adb.sh` to close port 5555 on the network.
- Summarize what was disabled (`disabled.log`) and how to undo it.
- Remind the user that Amazon updates may re-enable packages. Re-running step 3 fixes it.

## Common problems
See `docs/troubleshooting.md`.
