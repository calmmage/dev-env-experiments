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

nix-channel --add https://github.com/LnL7/nix-darwin/archive/master.tar.gz darwin
nix-channel --add http://nixos.org/channels/nixpkgs-unstable nixpkgs

nix-channel --update
# Install Nix Darwin if not already installed
if ! command -v darwin-rebuild &> /dev/null; then
    echo -e "${BLUE}Installing nix-darwin...${NC}"
    nix-build https://github.com/LnL7/nix-darwin/archive/master.tar.gz -A installer
    ./result/bin/darwin-installer
fi

# Source the new environment
source /etc/static/bashrc
# Ensure darwin-rebuild is in PATH
export PATH=/run/current-system/sw/bin:$PATH

# Enable flakes
echo -e "${BLUE}Enabling flakes...${NC}"
mkdir -p ~/.config/nix
echo "experimental-features = nix-command flakes" >> ~/.config/nix/nix.conf

# Build the system using the local flake
echo -e "${BLUE}Building the system...${NC}"
# Ensure we're in the correct directory where flake.nix exists
SCRIPT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
cd "$SCRIPT_DIR"
darwin-rebuild switch --flake .#Petrs-MacBook-Pro || {
    echo -e "${RED}Failed to build system${NC}"
    exit 1
}

echo -e "${GREEN}Setup complete! You may need to restart your shell or computer for all changes to take effect.${NC}" 