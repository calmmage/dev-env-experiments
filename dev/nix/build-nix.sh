#!/bin/bash

# Exit on error
set -e

echo "🚀 Building and applying Nix configuration..."

# Check if nix daemon is running
if ! pgrep nix-daemon > /dev/null; then
    echo "⚠️  Nix daemon is not running. Attempting to start it..."
    if [[ $(uname) == "Darwin" ]]; then
        sudo launchctl load /Library/LaunchDaemons/org.nixos.nix-daemon.plist
    else
        sudo systemctl start nix-daemon.service
    fi
    # Wait a moment for the daemon to start
    sleep 2
fi

# Check if we're on Darwin (macOS)
if [[ $(uname) == "Darwin" ]]; then
    echo "🔄 Rebuilding darwin-rebuild..."
    darwin-rebuild switch --flake .#default
else
    echo "🔄 Rebuilding nixos-rebuild..."
    sudo nixos-rebuild switch --flake .#default
fi

echo "✅ Nix configuration applied successfully!" 