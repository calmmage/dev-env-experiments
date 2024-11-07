#!/bin/bash

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

echo -e "${BLUE}Starting Nix Darwin setup...${NC}"

# Check if Nix is installed
if ! command -v nix-env &> /dev/null; then
    echo -e "${RED}Nix is not installed. Installing Nix...${NC}"
    curl -L https://nixos.org/nix/install | sh
    source /nix/var/nix/profiles/default/etc/profile.d/nix-daemon.sh
fi

# Check if Homebrew is installed
if ! command -v brew &> /dev/null; then
    echo -e "${BLUE}Installing Homebrew...${NC}"
    /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
fi

# Install Nix Darwin if not already installed
if ! command -v darwin-rebuild &> /dev/null; then
    echo -e "${BLUE}Installing nix-darwin...${NC}"
    nix-build https://github.com/LnL7/nix-darwin/archive/master.tar.gz -A installer
    ./result/bin/darwin-installer
fi

# Enable flakes
echo -e "${BLUE}Enabling flakes...${NC}"
mkdir -p ~/.config/nix
echo "experimental-features = nix-command flakes" >> ~/.config/nix/nix.conf

# Build the system
echo -e "${BLUE}Building the system...${NC}"
darwin-rebuild switch --flake .#Petrs-MacBook-Pro

echo -e "${GREEN}Setup complete! You may need to restart your shell or computer for all changes to take effect.${NC}" 