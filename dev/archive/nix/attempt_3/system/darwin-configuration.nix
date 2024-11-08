{ pkgs, ... }: {
  imports = [
    ./packages.nix
    ./programs
  ];

  # Basic configuration
  networking.hostName = "Petrs-MacBook-Pro";
  networking.computerName = "Petrs-MacBook-Pro";
  
  # Enable Nix daemon
  services.nix-daemon.enable = true;
  nix.settings.experimental-features = [ "nix-command" "flakes" ];

  # System-wide preferences
  system = {
    defaults = {
      dock = {
        autohide = true;
        orientation = "bottom";
        showhidden = true;
        mineffect = "scale";
      };
      finder = {
        AppleShowAllExtensions = true;
        _FXShowPosixPathInTitle = true;
      };
      NSGlobalDomain = {
        AppleShowAllExtensions = true;
        InitialKeyRepeat = 15;
        KeyRepeat = 2;
      };
    };
    keyboard = {
      enableKeyMapping = true;
    };
    stateVersion = 4;
  };

  # The platform the configuration will be used on
  nixpkgs.hostPlatform = "aarch64-darwin";

  # User configuration
  users.users.petr = {
    name = "petr";
    home = "/Users/petr";
  };
} 