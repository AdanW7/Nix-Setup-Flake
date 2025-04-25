{
  description = "Adans cross platform system flake";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-unstable";
    
    nix-darwin.url = "github:nix-darwin/nix-darwin/master";
    nix-darwin.inputs.nixpkgs.follows = "nixpkgs";

    home-manager.url = "github:nix-community/home-manager";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";
    
    Adan-nixvim.url = "github:AdanW7/nixvim";
  };

  outputs = inputs@{ self, nix-darwin, nixpkgs,home-manager,Adan-nixvim, ... }:{
  
    # Build darwin flake using:
    # $ darwin-rebuild switch --flake ~/.config/nix#Adans-MacBook-Air
    darwinConfigurations."Adans-MacBook-Air" = nix-darwin.lib.darwinSystem {
      system = "aarch64-darwin";
      modules = [
        ./hosts/macbook.nix
      ];
      specialArgs = { inherit inputs; };
    };

    # Build nixos flake using: adan-nixos-pc is an example hostName
    # $ sudo nixos-rebuild switch --flake ~/.config/nix#adan-nixos-pc
    nixosConfigurations."adan-nixos-pc" = nixpkgs.lib.nixosSystem {
      system = "x86_64-linux";
      modules = [
        ./hosts/pc.nix
      ];
      specialArgs = { inherit inputs; };
    };

  };
}

