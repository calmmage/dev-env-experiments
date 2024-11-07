{ pkgs, ... }: {
  # Shell configuration
  programs.zsh.enable = true;
  
  # Enable Karabiner
  services.karabiner-elements.enable = true;
} 