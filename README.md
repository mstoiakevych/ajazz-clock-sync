# 🕒 Ajazz Dock Clock Sync (macOS & Linux)

A lightweight, native background daemon that fixes the `00:00` clock issue on Ajazz wireless mouse smart docks (e.g., AJ179 Apex, AJ199, AJ159). 

Since Ajazz does not provide official software for macOS or Linux, the smart dock cannot synchronize the system time and gets stuck at `00:00`. This tool runs silently in the background, detects when your Ajazz 2.4G receiver is connected, and instantly pushes the current system time to the dock.

## ✨ Features
* **Universal Detection:** Automatically finds any Ajazz dock with "AJAZZ" and "2.4G" in its hardware name. No need to hardcode VIDs or PIDs.
* **Smart Syncing:** Pushes the time instantly upon physical connection and syncs periodically every 15 seconds to handle sleep/wake cycles perfectly.
* **Multi-Platform:**
  * **macOS:** Pure, native Swift binary using `IOKit`. 0% CPU footprint. No Python required.
  * **Linux:** Python-based daemon running as a `systemd` background service via `hidapi`.

---

## 🍏 macOS Installation

### 1. Download
Go to the [Releases](../../releases/latest) page and download `Ajazz-Clock-Sync-macOS.zip`. Extract the folder.

### 2. Bypass Apple Gatekeeper
Because this is an unsigned open-source tool downloaded from the internet, macOS will block it if you just double-click it.
* **Right-click** (or `Control` + Click) on `install.command`.
* Select **Open** from the context menu.
* A warning will appear, but it will now have an **Open** button. Click it.

*(Alternatively, open Terminal, type `xattr -cr `, drag the extracted folder into the terminal, hit Enter, and then double-click `install.command` normally).*

### 3. Grant USB Permissions (CRITICAL)
macOS strictly protects USB input devices. The daemon will not work until you grant it permission:
1. Go to **System Settings** -> **Privacy & Security** -> **Input Monitoring**.
2. Click the `+` button to add an application.
3. Press `Cmd + Shift + G` to open the "Go to Folder" prompt.
4. Enter `~/.ajazz-clock-sync/` and select the `ajazz_daemon` executable.
5. Unplug your Ajazz USB dock and plug it back in. The clock should now update!

### 🗑️ Uninstallation (macOS)
If you want to completely remove the fix from your Mac:
1. Open the folder you extracted from the zip file.
2. **Right-click** on `uninstall.command` and select **Open** (to bypass Gatekeeper).
3. The script will safely unload the background service and delete the `~/.ajazz-clock-sync` directory. You can then remove `ajazz_daemon` from your Input Monitoring settings.

---

## 🐧 Linux Installation

### Prerequisites
You need `python3` and `pip` installed on your system.
* Debian/Ubuntu: `sudo apt install python3 python3-pip python3-venv`
* Arch Linux: `sudo pacman -S python python-pip`

### 1. Download
Go to the [Releases](../../releases/latest) page and download `Ajazz-Clock-Sync-Linux.zip`. Extract the folder.

### 2. Install
Open a terminal in the extracted folder and run the installer with `sudo`:
```bash
chmod +x install.sh uninstall.sh
sudo ./install.sh
```

### 🗑️ Uninstallation (Linux)
To remove the daemon and all its associated files:
1. Open a terminal in the extracted folder.
2. Run the uninstaller with `sudo ./uninstall.sh`

This will stop the `systemd` service, disable it, and completely delete the `/opt/ajazz-clock-sync` folder.

---


## 🛠️ Edge Cases & Troubleshooting

* **macOS: The clock still says 00:00 after installation:**
  * Double-check the *Input Monitoring* permission. If `ajazz_daemon` is listed but toggled off, turn it on. If it's on but not working, select it, click `-` to remove it, and add it again.
  * Ensure the USB receiver is plugged directly into the Mac or a reliable USB hub.

* **"Linux: Python3 not found" error during install:**
  * macOS 12.3 and later no longer includes Python by default. Please install Python 3 from the official website or via Homebrew.

* **The dock screen goes to sleep and resets to 00:00 on wake:**
  * The daemon has a built-in 15-second timer. Simply wait up to 15 seconds after your PC wakes from sleep, and the time will automatically refresh.

* **Can it break my Ajazz Keyboard?**
  * No. The script specifically looks for devices containing "2.4G" in their name. If you have an Ajazz keyboard (e.g., AK820MAX), it will be safely ignored.

---
*Created with reverse-engineering love for the Mac/Linux gaming community. Feel free to open an issue or contribute!*