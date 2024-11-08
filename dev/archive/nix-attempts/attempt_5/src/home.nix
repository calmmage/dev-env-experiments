{ config, pkgs, ... }:

{
  home.stateVersion = "24.05";  # Please read the comment before changing.

  # The home.packages option allows you to install Nix packages into your
  # environment.
  home.packages = with pkgs; [
    git
    # Add more user packages here
  ];

  # Enable home-manager
  programs.home-manager.enable = true;
} 