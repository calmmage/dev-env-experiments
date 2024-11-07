# darwin.nix

{ pkgs, ... }: 

{
    # Enable Homebrew
    homebrew = {
      enable = true;
      onActivation = {
        autoUpdate = true;
        cleanup = "zap"; # Removes all unmanaged packages
      };
      brews = [
        # CLI tools through homebrew if needed
      ];
      casks = [
        "slack"
        "jetbrains-toolbox"
        "pycharm"
        "cursor"
      ];
    };

    # List packages installed in system profile. To search by name, run:
    # $ nix-env -qaP | grep wget
    # System packages
    environment.systemPackages = with pkgs; [
      vim
      git
    ];

    # Auto upgrade nix package and the daemon service.
    services.nix-daemon.enable = true;
    services.karabiner-elements.enable = true;
    # nix.package = pkgs.nix;

    # Necessary for using flakes on this system.
    nix.settings.experimental-features = "nix-command flakes";

    # Create /etc/zshrc that loads the nix-darwin environment.
    programs.zsh.enable = true;  # default shell on catalina
    # programs.fish.enable = true;

    # Used for backwards compatibility, please read the changelog before changing.
    # $ darwin-rebuild changelog
    system.stateVersion = 4;

    # The platform the configuration will be used on.
    nixpkgs.hostPlatform = "aarch64-darwin";

    users.users.petr = {
        name = "petr";
        home = "/Users/petr";
    };
}