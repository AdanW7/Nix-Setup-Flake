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

   outputs = inputs@{ nix-darwin, nixpkgs, ... }:
      # let
      #    systemDarwin = "aarch64-darwin";
      #    overlays = [
      #       (final: prev: {
      #          libfaketime = prev.libfaketime.overrideAttrs (old: {
      #             doCheck = false;
      #          });
      #       })
      #    ];
      # in
         {

      # Build darwin flake using:
      # $ darwin-rebuild switch --flake ~/.config/nix#Adans-MacBook-Air
      darwinConfigurations."Adans-MacBook-Air" = nix-darwin.lib.darwinSystem {
         system = "aarch64-darwin";
         # system = "systemDarwin";
         modules = [
            # ./hosts/macbook.nix
            ./hosts/mac/macbook.nix
            # {
            #   nixpkgs.overlays = overlays;
            # }
         ];
         specialArgs = { inherit inputs; };
      };

      # Build nixos flake using: adan-nixos-pc is an example hostName
      # $ sudo nixos-rebuild switch --flake ~/.config/nix#adan-nixos-pc
      nixosConfigurations."nixos" = nixpkgs.lib.nixosSystem {
         system = "x86_64-linux";
         modules = [
            # ./hosts/pc.nix
            ./hosts/nixos/configuration.nix
         ];
         specialArgs = { inherit inputs; };
      };

   };




}

