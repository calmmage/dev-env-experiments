{ pkgs, ... }: {
  # here go the darwin preferences and config items
  programs.zsh.enable = true;
  environment = {
    shells = [ pkgs.bash pkgs.zsh ];
    loginShell = pkgs.zsh;
    systemPackages = [ pkgs.coreutils ];
    systemPath = [ "/opt/homebrew/bin" ];
    pathsToLink = [ "/Applications" ];
  };
  nix = {
    settings = { trusted-users = [ "root" "petr"]; };
    extraOptions = ''
      experimental-features = nix-command flakes
    '';
  };
  system = {
    keyboard.enableKeyMapping = true;
    keyboard.remapCapsLockToEscape = false;
    stateVersion = 4;
    defaults = {
      finder = {
        AppleShowAllExtensions = true;
        _FXShowPosixPathInTitle = true;
        FXPreferredViewStyle = "Nlsv";
      };
      NSGlobalDomain = {
        AppleInterfaceStyle = "Dark";
        AppleInterfaceStyleSwitchesAutomatically = true;
        AppleShowAllExtensions = true;
        InitialKeyRepeat = 14;
        KeyRepeat = 1;
        AppleShowAllFiles = true;
        NSNavPanelExpandedStateForSaveMode = true;
        "com.apple.mouse.tapBehavior" = 1;
      };
      dock = {
        autohide = true;
        largesize = 64;
      };
    };
  };
  networking = {
    # computerName = "mbpr1619";
    # hostName = "mbpr1619";
    # localHostName = "mbpr1619";
  };

  security.pam.enableSudoTouchIdAuth = false;
  # fonts.fontDir.enable = true; # DANGER
  fonts.packages = [ (pkgs.nerdfonts.override { fonts = [ "Meslo" ]; }) ];
  services = { nix-daemon = { enable = true; }; };

  documentation.enable = false;

  nixpkgs.config.allowUnfree = true;

  homebrew = {
    enable = true;
    caskArgs.no_quarantine = true;
    global.brewfile = true;
    onActivation = {
      autoUpdate = true;
      cleanup = "zap"; # Removes all unmanaged packages
    };
    masApps = { };
    brews = [
      # CLI tools through homebrew if needed
      "poetry"
      "gh"
      "ripgrep"
    ];

    casks = [
      "raycast"
      "sourcetree"
      "google-chrome"
      "dropbox"
      "adobe-creative-cloud"
      "setapp"
      "mitmproxy"
      "slack"
      "jetbrains-toolbox"
      "pycharm"
      "cursor"
      "warp"
      "raycast"
      "telegram"
      "docker"
      "bartender"
      "rectangle"
      "obsidian"
      "notion"
      "chatgpt"
    ];
    brews = [ "sonar-scanner" ];
  };
}
