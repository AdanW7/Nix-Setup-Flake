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

  system.stateVersion = "23.05";

  nix.settings.experimental-features = "nix-command flakes";


  home-manager.useGlobalPkgs = true;
  home-manager.useUserPackages = true;
  home-manager.users.adan = import ../home.nix {
    inherit pkgs lib;
    system = "x86_64-linux";
    homeDirectory = "/home/${username}";
  };

  programs.zsh.enable = true;

}
