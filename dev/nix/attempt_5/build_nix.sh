#!/bin/bash

# Make the script exit on any error
set -e

echo "🔄 Updating flake..."
nix flake update

echo "🛠 Rebuilding system..."
darwin-rebuild switch --flake .#Petrs-MacBook-Pro.local

echo "✅ System rebuild complete!"