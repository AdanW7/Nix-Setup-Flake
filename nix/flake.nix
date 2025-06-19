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

   outputs = inputs@{ nix-darwin, nixpkgs, ... }:{

      # Build darwin flake using:
      # $ darwin-rebuild switch --flake ~/.config/nix#Adans-MacBook-Air
      darwinConfigurations."Adans-MacBook-Air" = nix-darwin.lib.darwinSystem {
         system = "aarch64-darwin";
         modules = [
            ./hosts/mac/macbook.nix
         ];
         specialArgs = { inherit inputs; };
      };

      # Build nixos flake using: adan-nixos-pc is an example hostName
      # $ sudo nixos-rebuild switch --flake ~/.config/nix#adan-nixos-pc
      nixosConfigurations."nixos" = nixpkgs.lib.nixosSystem {
         system = "x86_64-linux";
         modules = [
            ./hosts/nixos/configuration.nix
         ];
         specialArgs = { inherit inputs; };
      };

      homeConfigurations."adan@adan-pc" =

     let
      username = "adan";  # Change this to your WSL username
      system = "x86_64-linux";
    in
    inputs.home-manager.lib.homeManagerConfiguration {
      pkgs = nixpkgs.legacyPackages.${system};
      modules = [
        (import ./hosts/Ubuntu/home.nix {
          inherit (nixpkgs.legacyPackages.${system}) pkgs lib;
          inherit system username;
          homeDirectory = "/home/${username}";
          inherit inputs;
        })
      ];
      extraSpecialArgs = { inherit inputs; };
    };


   };
}

