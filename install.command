#!/bin/bash

echo "🕒 Installing Ajazz Mac Clock Fix..."
echo "========================================="

# Navigate to the script directory
cd "$(dirname "$0")"

# Check if Python3 is installed
if ! command -v python3 &> /dev/null; then
    echo "❌ Error: Python3 not found! Please install Python first."
    exit 1
fi

# Install required hidapi library
echo "📦 Installing dependencies..."
pip3 install hidapi --break-system-packages --user 2>/dev/null || pip3 install hidapi --user

# Create a hidden directory for the script and copy it
INSTALL_DIR="$HOME/.ajazz-mac-fix"
mkdir -p "$INSTALL_DIR"
cp ajazz_daemon.py "$INSTALL_DIR/ajazz_daemon.py"

# Get the absolute path to Python3
PYTHON_PATH=$(which python3)

# Create the launchd configuration file (plist)
PLIST_PATH="$HOME/Library/LaunchAgents/com.ajazz.clocksync.plist"

cat <<EOF > "$PLIST_PATH"
<?xml version="1.0" encoding="UTF-8"?>
<!DOCTYPE plist PUBLIC "-//Apple//DTD PLIST 1.0//EN" "http://www.apple.com/DTDs/PropertyList-1.0.dtd">
<plist version="1.0">
<dict>
    <key>Label</key>
    <string>com.ajazz.clocksync</string>
    <key>ProgramArguments</key>
    <array>
        <string>$PYTHON_PATH</string>
        <string>$INSTALL_DIR/ajazz_daemon.py</string>
    </array>
    <key>RunAtLoad</key>
    <true/>
    <key>KeepAlive</key>
    <true/>
</dict>
</plist>
EOF

# Load and start the background service
echo "⚙️ Setting up macOS background service..."
launchctl unload "$PLIST_PATH" 2>/dev/null
launchctl load "$PLIST_PATH"

echo "========================================="
echo "✅ Successfully installed!"
echo "The service is now running in the background. The clock will update automatically when the dock is connected."
echo ""
echo "⚠️ IMPORTANT: macOS may block USB access by default."
echo "If the clock doesn't update, please go to:"
echo "System Settings -> Privacy & Security -> Input Monitoring"
echo "and grant permission to 'Python' or 'Terminal'."
echo "========================================="
read -p "Press Enter to close this window..."