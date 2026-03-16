# 🕒 Ajazz Mouse Mac Clock Fix

A lightweight, background daemon for macOS that fixes the `00:00` clock issue on Ajazz wireless mouse dock screens (e.g., AJ179 Apex, AJ199, AJ159).

Since there is no official Ajazz software for macOS, the smart dock cannot synchronize the system time and gets stuck at `00:00`. This script runs silently in the background, detects when your Ajazz 2.4G receiver is connected, and instantly pushes the current macOS system time to the dock.

## ✨ Features
* **Universal:** Automatically finds any Ajazz dock with "AJAZZ" and "2.4G" in its hardware name. No need to hardcode VIDs or PIDs!
* **Plug-and-Play:** Updates the clock instantly when you plug in the dock or switch your USB hub to your Mac.
* **Zero CPU Impact:** Uses a lightweight `launchd` background service that sleeps when not needed.

## 📋 Requirements
* **macOS** (Tested on Intel and Apple Silicon M1/M2/M3)
* **Python 3** installed. (You can download it from [python.org](https://www.python.org/downloads/macos/) or install via Homebrew: `brew install python`).

## 🚀 Installation (1-Click Method)

1. Download this repository (Click **Code** -> **Download ZIP**) and extract it.
2. Double-click the `install.command` file.
3. The script will automatically install dependencies (`hidapi`) and set up a macOS background service.

### ⚠️ CRITICAL STEP: macOS Permissions
macOS strictly protects USB input devices to prevent keyloggers. **The script will not work until you grant it permission!**

1. Go to **System Settings** -> **Privacy & Security** -> **Input Monitoring**.
2. Click the `+` button to add an application.
3. Press `Cmd + Shift + G` to open the "Go to Folder" prompt.
4. Enter the path to your Python executable (usually `/usr/bin/python3`, `/usr/local/bin/python3`, or `/opt/homebrew/bin/python3` depending on your setup). Alternatively, toggle the switch for `Terminal` / `iTerm`.
5. Unplug your Ajazz USB dock and plug it back in. The clock should now update!

## 🗑️ Uninstallation
If you want to remove the fix, simply double-click the `uninstall.command` file. It will safely stop the background service and remove all associated files.

## 🛠️ Edge Cases & Troubleshooting

* **The clock still says `00:00` after installation:**
  * 99% of the time, this is an **Input Monitoring** permission issue (see Critical Step above). 
  * Ensure the USB receiver is plugged directly into the Mac or a reliable USB hub.

* **I switch my USB hub between Windows and Mac, and the clock freezes:**
  * When you switch the hub, give macOS ~2-3 seconds to recognize the USB device. The daemon checks for hardware changes every 3 seconds. It will update automatically.

* **"Python3 not found" error during install:**
  * macOS 12.3 and later no longer includes Python by default. Please install Python 3 from the official website or via Homebrew.

* **Can it break my Ajazz Keyboard?**
  * No. The script specifically looks for devices containing "2.4G" in their name. If you have an Ajazz keyboard (e.g., AK820MAX), it will be safely ignored.

---
*Created with reverse-engineering love for the Mac gaming community. Feel free to open an issue or contribute!*