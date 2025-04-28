{ inputs, pkgs, lib, ... }:
let 
  username = "adan";

in
{
  imports = [
    ../modules/common.nix
    inputs.home-manager.nixosModules.home-manager
  ];

   nixpkgs.hostPlatform = "x86_64-linux";

 # System configuration
   system.stateVersion = "23.05";
   system.configurationRevision = inputs.self.rev or inputs.self.dirtyRev or null;
   nix.settings.experimental-features = "nix-command flakes";


 # Home Manager configuration
   home-manager = {
      useGlobalPkgs = true;
      useUserPackages = true;
      verbose = true;

      users.${username} = import ../home.nix {
         inherit pkgs lib;
         system = "x86_64-linux";
         homeDirectory = "/home/${username}";
         inherit (inputs) Adan-nixvim;
      };
   };
  programs.zsh.enable = true;

}
