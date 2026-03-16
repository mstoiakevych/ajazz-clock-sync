#!/bin/bash

echo "🗑️ Uninstalling Ajazz Mac Clock Fix..."
echo "========================================="

PLIST_PATH="$HOME/Library/LaunchAgents/com.ajazz.clocksync.plist"
INSTALL_DIR="$HOME/.ajazz-mac-fix"

# Stop and remove the launchd service
if [ -f "$PLIST_PATH" ]; then
    launchctl unload "$PLIST_PATH" 2>/dev/null
    rm "$PLIST_PATH"
    echo "✅ Background service stopped and removed."
fi

# Delete the script folder
if [ -d "$INSTALL_DIR" ]; then
    rm -rf "$INSTALL_DIR"
    echo "✅ Script files removed."
fi

echo "========================================="
echo "Done! Ajazz Mac Clock Fix has been completely removed from your system."
read -p "Press Enter to close this window..."