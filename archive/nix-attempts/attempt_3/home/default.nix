{ config, pkgs, ... }: {
  imports = [
    ./packages.nix
    ./programs
  ];

  home = {
    username = "petr";
    homeDirectory = "/Users/petr";
    stateVersion = "23.11";
  };

  # Let Home Manager manage itself
  programs.home-manager.enable = true;
} 