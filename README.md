# Clean-FireTV

**English** · [Português (Brasil)](README.pt-BR.md)

**Your Fire TV Stick without ads, without tracking, and faster.** No root, nothing deleted, and a one-command undo.

- Disables Amazon's **tracking, advertising and telemetry**: content recognition, the advertising ID, the service that uploads your Wi-Fi passwords, and more.
- Optionally replaces the banner-filled home screen with a **clean one** ([Projectivy Launcher](https://github.com/spocky/miproja1)).
- Makes the system **snappier**: faster animations and cleared caches.
- **Keeps** Alexa, voice search, Netflix, YouTube, Prime Video and Settings working.

Everything runs over Wi-Fi with ADB using `pm disable-user`. **No system app is uninstalled**, and every change can be undone with `scripts/03-restore.sh`.

---

## Easiest way: with an AI assistant

If you use **Claude Code**, Codex, Gemini CLI or any assistant with terminal access, just say:

> Clone https://github.com/proteus49/Clean-FireTV and follow AGENTS.md to clean up my Fire TV Stick.

The assistant reads [`AGENTS.md`](AGENTS.md) and walks you through everything step by step, **asking what you use before it disables anything**.

## Manual way

### 1. Prepare the Fire Stick
1. **Settings > My Fire TV > About:** click the device name 7 times.
2. **Developer Options:** turn on **ADB Debugging** and **Apps from Unknown Sources**.
3. **About > Network:** write down the **IP address**.

### 2. Install ADB on your computer
| System | Command |
|---|---|
| macOS | `brew install --cask android-platform-tools` |
| Linux | `sudo apt install adb` |
| Windows | [Platform-Tools](https://developer.android.com/tools/releases/platform-tools) or WSL |

### 3. Run the scripts (computer on the same Wi-Fi)
```bash
git clone https://github.com/proteus49/Clean-FireTV && cd Clean-FireTV

bash scripts/01-diagnose.sh                       # read-only; asks for the IP, saves report.txt
bash scripts/02-disable.sh lists/ads-telemetry.txt  # recommended
bash scripts/04-projectivy.sh                     # optional: clean home screen
bash scripts/05-optimize.sh                       # 0.5x animations + cache cleanup
bash scripts/disable-adb.sh                       # when you are done
```
On the first connection, accept **"Allow USB debugging?"** on the TV.

## Lists

| File | Who it is for |
|---|---|
| [`lists/ads-telemetry.txt`](lists/ads-telemetry.txt) | **Everyone.** Ads, tracking and telemetry. |
| [`lists/optional.txt`](lists/optional.txt) | Amazon Kids, Music, Photos, Silk, Luna. Remove the `#` only on what you want gone. |
| [`lists/alexa.txt`](lists/alexa.txt) | **Only if you do NOT use Echo devices or an Amazon smart home.** |
| [`lists/do-not-touch.txt`](lists/do-not-touch.txt) | Packages that **must not** be disabled, plus the ones Amazon protects. |

## Home screen (Projectivy): what to expect
Fire OS **blocks** replacing the launcher. Projectivy intercepts the Home button instead, so:
- pressing Home shows Amazon's screen for **~5 seconds** before Projectivy takes over;
- **Fire TV Settings** are reached by **holding Home for 3 s**;
- to get Amazon's home screen back, turn off **"Override current launcher"** in Projectivy's settings.

## Undo
```bash
bash scripts/03-restore.sh                       # re-enable everything
bash scripts/03-restore.sh com.amazon.example    # re-enable one package
```

## Tested on
| Device | Fire OS | Result |
|---|---|---|
| Fire TV Stick 3rd gen (AFTSSS) | 7.7.1.7 | Recommended list applied; Alexa, Netflix, YouTube and Prime Video working after restart |

Tested another model? Open an *issue* or a *pull request* with the model, Fire OS version, and which packages worked or failed.

## More
- [Network-wide DNS blocking](docs/dns-blocking.md)
- [Troubleshooting](docs/troubleshooting.md)

## Credits
- Created and maintained by **[Proteus49](https://github.com/proteus49)**.
- Part of the telemetry list was cross-checked against the Fire TV Stick Lite 2020 list from [cleanyourtv](https://github.com/Gathin23/cleanyourtv) (MIT).
- [Projectivy Launcher](https://github.com/spocky/miproja1) by spocky. It is not redistributed here; the script downloads it from the author's official releases.

## Disclaimer
Use at your own risk. The scripts only disable packages reversibly, but Amazon updates may change behavior. This is an independent project, not affiliated with Amazon.

[MIT](LICENSE) License © 2026 Proteus49.
