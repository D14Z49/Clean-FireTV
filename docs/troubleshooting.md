# Troubleshooting

| Problem | Fix |
|---|---|
| **I can't find Fire TV Settings** (with Projectivy) | Hold the **Home** button for 3 s > Settings. |
| **I want to restart** | Hold **Select + Play/Pause** for 5 s. Or `adb -s IP:5555 reboot`. |
| **Home shows Amazon's screen for a few seconds** | Expected. Amazon's launcher is protected, and Projectivy takes over right after. |
| **I want Amazon's home screen back** | In Projectivy: Settings > General > turn off "Override current launcher". |
| **"Cannot disable a protected package"** | Amazon protects that package. Nothing to do without root; use DNS blocking. |
| **The script stopped at the first package** | Make sure you are using this repo's scripts. `adb shell` inside loops needs `</dev/null`. |
| **Something stopped working** | `bash scripts/03-restore.sh PACKAGE` re-enables one package; `bash scripts/03-restore.sh` re-enables everything. |
| **Luna doesn't work** | Luna is only available in some countries. Not caused by the cleanup. |
| **Alexa on my Echo no longer controls the TV** | You applied `lists/alexa.txt`. Restore its packages. |
| **Echo is no longer the TV's speaker** | `bash scripts/03-restore.sh com.amazon.audiohome` |
| **"Cannot reach IP:5555"** | Check the IP, turn on ADB Debugging and accept the prompt on the TV. The computer must be on the same network. |
| **An Amazon update undid everything** | Run `scripts/02-disable.sh` again with the same lists. |
| **Screenshot is black** | Netflix and other DRM apps block screen capture. Expected. |
