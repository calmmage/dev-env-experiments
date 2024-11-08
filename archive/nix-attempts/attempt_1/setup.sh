#!/bin/bash

set -e  # Exit on error

# Colors for output
GREEN='\033[0;32m'
NC='\033[0m'

echo -e "${GREEN}Starting Nix Darwin setup...${NC}"

# Get current user and hostname
CURRENT_USER=$(whoami)
HOSTNAME=$(scutil --get LocalHostName)

# Replace placeholders in configuration files
echo -e "${GREEN}Updating configuration files with current user ($CURRENT_USER) and hostname ($HOSTNAME)...${NC}"
sed -i '' "s/your-username/$CURRENT_USER/g" flake.nix darwin.nix home.nix
sed -i '' "s/your-hostname/$HOSTNAME/g" flake.nix

# Initialize and build nix-darwin
echo -e "${GREEN}Building initial configuration...${NC}"
nix run nix-darwin --experimental-feature nix-command --experimental-feature flakes -- switch --flake .

echo -e "${GREEN}Setup complete! You can now use 'darwin-rebuild switch --flake .' to rebuild your configuration${NC}" 