# Install Oh My Zsh
sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"

# Install zsh-autosuggestions
git clone https://github.com/zsh-users/zsh-autosuggestions ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions

gh auth login

# Check if gh is installed and install GitHub CLI Copilot extension
if command -v gh &> /dev/null; then
    if gh auth status &> /dev/null; then
        echo "Installing GitHub CLI Copilot extension..."
        gh extension install github/gh-copilot
    else
        echo "Please run 'gh auth login' first to authenticate with GitHub"
    fi
else
    echo "GitHub CLI (gh) is not installed. Please install it first."
fi

