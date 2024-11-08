{ pkgs, ... }: {
  # Shell configuration
  programs.zsh.enable = true;
  
  # Enable Karabiner with full configuration
  services.karabiner-elements = {
    enable = true;
  };

  # Add system keyboard configuration
  system.keyboard = {
    enableKeyMapping = true;
    remapCapsLockToEscape = true;  # Optional, remove if you don't want this
  };

  # Add launchd configuration for Karabiner
  launchd.user.agents.karabiner = {
    serviceConfig = {
      Label = "org.pqrs.karabiner.karabiner_console_user_server";
      ProgramArguments = [
        "${pkgs.karabiner-elements}/bin/karabiner_console_user_server"
      ];
      RunAtLoad = true;
      KeepAlive = true;
    };
  };
} 