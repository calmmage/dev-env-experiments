{
  description = "Darwin system flake";
  
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-unstable";
    darwin.url = "github:lnl7/nix-darwin";
    darwin.inputs.nixpkgs.follows = "nixpkgs";
    home-manager.url = "github:nix-community/home-manager";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";
  };

  outputs = { self, darwin, nixpkgs, home-manager }: {
    darwinConfigurations.Petrs-MacBook-Pro = darwin.lib.darwinSystem {
      system = "aarch64-darwin";
      modules = [ 
        ./src/darwin.nix
        home-manager.darwinModules.home-manager
        {
          home-manager.useGlobalPkgs = true;
          home-manager.useUserPackages = true;
          home-manager.users.petr = import ./src/home.nix;
        }
      ];
    };
  };
}