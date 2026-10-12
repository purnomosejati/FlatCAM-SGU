FlatCAM 8.4 ported to **Python 3.14 / PyQt5 / Shapely 2 / VisPy 0.17**, with ready-to-install builds.
Python 3 / macOS port and improvements by **Purnomo Sejati, Swiss German University**.
Based on FlatCAM by Juan Pablo Caram and the OpenGL visualizer fork by Denvi.

## Downloads

| Platform | File | How to install |
|---|---|---|
| Windows 10/11 (64-bit) | `FlatCAM-8.4-py3-Windows-x64-Setup.exe` | Run the installer. If SmartScreen warns, click **More info → Run anyway**. |
| macOS (Apple Silicon M1/M2/M3/M4) | `FlatCAM-8.4-py3-macOS-arm64.dmg` | Open the DMG, drag **FlatCAM** to **Applications**. First launch: **System Settings → Privacy & Security → Open Anyway**. |
| Linux x86_64 | `FlatCAM-8.4-py3-Linux-x86_64.AppImage` | `chmod +x FlatCAM-*.AppImage` then run it. Without FUSE: add `--appimage-extract-and-run`. |
| Linux x86_64 (folder) | `FlatCAM-8.4-py3-Linux-x86_64.tar.gz` | Extract and run `FlatCAM/FlatCAM`. |

A graphics driver with OpenGL 2.1 or newer is required.

## Changes from 8.4

- Runs on current Python, Qt and geometry libraries (Python 2 / PyQt4 / Shapely 1 no longer needed)
- Fixed path joining in toolpath optimisation and drill tool ordering
- Settings stored per platform (`%APPDATA%\FlatCAM-Denvi`, `~/Library/Application Support/FlatCAM-Denvi`, `~/.FlatCAM`)

The installers are not code-signed, so Windows and macOS show a warning on first launch.
