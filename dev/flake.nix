{
  description = "Unified Configuration for NixOS and MacOS";

  nixConfig = {
    extra-substituters = [
      "https://nixpkgs-python.cachix.org"
      "https://devenv.cachix.org"
      "https://cache.nixos.org"
      "https://nix-community.cachix.org"
    ];
    extra-trusted-public-keys = [
      "nixpkgs-python.cachix.org-1:hxjI7pFxTyuTHn2NkvWCrAUcNZLNS3ZAvfYNuYifcEU="
      "devenv.cachix.org-1:w1cLUi8dv3hnoSPGAuibQv+f9TZLr6cv/Hm9XgU50cw="
      "cache.nixos.org-1:6NCHdD59X431o0gWypbMrAURkbJ16ZPMQFGspcDShjY="
      "nix-community.cachix.org-1:mB9FSh9qf2dCimDSUo8Zy7bkq5CX+/rkCWyvRCYg3Fs="
    ];
  };
  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-24.05";
    nixpkgs-unstable.url = "github:nixos/nixpkgs/nixpkgs-unstable";
    home-manager = {
      url = "github:nix-community/home-manager/release-24.05";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    darwin = {
      url = "github:LnL7/nix-darwin/master";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    homebrew-bundle = {
      url = "github:homebrew/homebrew-bundle";
      flake = false;
    };
    homebrew-core = {
      url = "github:homebrew/homebrew-core";
      flake = false;
    };
    homebrew-cask = {
      url = "github:homebrew/homebrew-cask";
      flake = false;
    };
    flake-utils.url = "github:numtide/flake-utils";
  };

  outputs = { self, nixpkgs, nixpkgs-unstable, home-manager, darwin, flake-utils
    , ... }@inputs:
    let
      inherit (flake-utils.lib) eachSystemMap;
      isDarwin = system:
        (builtins.elem system inputs.nixpkgs.lib.platforms.darwin);
      homePrefix = system: if isDarwin system then "/Users" else "/home";
      defaultSystems = [ "aarch64-darwin" "x86_64-darwin" ];

      overlay-unstable = final: prev: {
        unstable = nixpkgs-unstable.legacyPackages.${prev.system};
        devenv = nixpkgs-unstable.legacyPackages.${prev.system}.devenv;
        mysql = nixpkgs-unstable.legacyPackages.${prev.system}.mysql;
      };

      mkDarwinConfig = { system, hostname, username }:
        darwin.lib.darwinSystem {
          inherit system;
          modules = [
            ({ pkgs, ... }: {
              nixpkgs.overlays = [ overlay-unstable ];
              nixpkgs.config.allowUnfree = true;
              users.users.${username}.home = "/Users/${username}";
            })
            ./modules/darwin
            (./. + "/${hostname}.nix")
            home-manager.darwinModules.home-manager
            {
              home-manager.useGlobalPkgs = true;
              home-manager.useUserPackages = true;
              home-manager.users.${username} = import ./modules/home-manager;
              home-manager.extraSpecialArgs = { inherit hostname; };
            }
          ];
        };
    in {
      darwinConfigurations = {
        mbpr1619 = mkDarwinConfig {
          system = "x86_64-darwin";
          hostname = "mbpr1619";
          username = "luchoh";
        };
        bflhair = mkDarwinConfig {
          system = "aarch64-darwin";
          hostname = "bflhair";
          username = "lucho.hristov";
        };
      };
    };
}
