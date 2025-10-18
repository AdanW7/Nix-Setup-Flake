{ inputs, pkgs, lib, ... }:
let 
  username = "adan";

in
{
  imports = [
    ./../../modules/common.nix
    ./../../modules/programming.nix
    inputs.home-manager.darwinModules.home-manager
  ];

  nixpkgs.hostPlatform = "aarch64-darwin";

 # System configuration
  system.stateVersion = 6;
  system.configurationRevision = inputs.self.rev or inputs.self.dirtyRev or null;
  nix.settings.experimental-features = "nix-command flakes";

 # Home Manager configuration
   home-manager = {
      useGlobalPkgs = true;
      useUserPackages = true;
      verbose = true;
      users.${username} = import ./home.nix {
         inherit pkgs lib;
         system = "aarch64-darwin";
         username = username;
         homeDirectory = "/Users/${username}";
         # inherit (inputs) Adan-nixvim;
      };
   };
  programs.zsh.enable = true;
}
