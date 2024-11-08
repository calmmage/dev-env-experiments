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
        largesize = 128;
        magnification = true;
        # tilesize = 36;
        expose-group-apps = true;
        mru-spaces = false; # disable reordering spaces automatically based on recent usage (I hate them chaotically reordering)
        minimize-to-application = true; # minimize to application instead separate windows
      };
      WindowManager = {
        EnableTopTilingByEdgeDrag = false;
        EnableTilingByEdgeDrag = false;
        EnableTilingOptionAccelerator = false;
      };
    };
    activationScripts.postActivation.text = ''
      # Allow Karabiner-Elements to receive keyboard events
      /usr/bin/sudo /usr/bin/security authorizationdb write system.privilege.taskport allow
    '';
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
      "poetry"
      "ripgrep"
      "sonar-scanner"
    ];

    casks = [
      # Development
      "docker"
      "jetbrains-toolbox"
      "pycharm"
      "sourcetree"
      "github"
      "launchcontrol"
      "warp"
      "mitmproxy"
      "cursor"
      "shottr"
      "karabiner-elements"
      "sublime-text"
      
      # Browsers & Communication
      "google-chrome"
      "slack"
      "telegram"

      # Productivity & Utils
      "raycast"
      "rectangle"
      "bartender"
      "dropbox"
      "setapp"
      "obsidian"
      "notion"
      "chatgpt"

      # Creative
      "adobe-creative-cloud"
    ];
  };
}
