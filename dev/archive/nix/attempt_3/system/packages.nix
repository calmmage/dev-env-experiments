{ pkgs, ... }: {
  # Enable Homebrew
  homebrew = {
    enable = true;
    onActivation = {
      autoUpdate = true;
      cleanup = "zap";
    };
    taps = [
      "homebrew/cask"
      "homebrew/cask-versions"
    ];
    brews = [
      # CLI tools through homebrew if needed
    ];
    casks = [
      "slack"
      "jetbrains-toolbox"
      "pycharm-ce"
      "cursor"
    ];
  };

  # System packages
  environment.systemPackages = with pkgs; [
    vim
    git
    coreutils
    curl
    wget
  ];
} 