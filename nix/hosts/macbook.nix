{ inputs, pkgs, lib,Adan-nixvim, ... }:
let 
  username = "adan";

in
{
  imports = [
    ../modules/common.nix
    inputs.home-manager.darwinModules.home-manager
  ];

  nixpkgs.hostPlatform = "aarch64-darwin";

  system.stateVersion = 6;
  system.configurationRevision = inputs.self.rev or inputs.self.dirtyRev or null;

  nix.settings.experimental-features = "nix-command flakes";

  #change to macbook username as needed

  home-manager.useGlobalPkgs = true;
  home-manager.useUserPackages = true;
  home-manager.verbose = true;
  home-manager.users.${username} = import ../home.nix {
    inherit pkgs lib;
    system = "aarch64-darwin";
    homeDirectory = "/Users/${username}";
    Adan-nixvim = inputs.Adan-nixvim;  # Pass the nixvim input here
  };

  programs.zsh.enable = true;

}
