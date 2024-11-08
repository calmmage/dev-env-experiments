{ pkgs, lib, ... }:

{
  # Machine-specific Darwin configuration
  networking = {
    computerName = "mbpr1619";
    hostName = "mbpr1619";
    localHostName = "mbpr1619";
  };

  # Machine-specific home-manager configuration
  home-manager.users.luchoh = { pkgs, lib, ... }: {
    # Add personal machine specific packages here
    home.packages = with pkgs; [ flac cuetools ffmpeg exiftool testdisk ];

    # Machine-specific VSCode extensions
    programs.vscode = {
      userSettings = { };
      extensions = with pkgs.vscode-extensions;
        [
          # Add any mbpr1619-specific VSCode extensions here
        ];
    };

    # Add any personal machine specific configurations here
    programs.git.extraConfig = {
      user.email = lib.mkForce "luchoh69@gmail.com";
    };
  };

  # Machine-specific Homebrew configuration
  homebrew.casks = [ "xld" "balenaetcher" "whatsapp" ];

  homebrew.brews = [ "rtorrent" "dcraw" ];
}
