{ pkgs, lib, system, username,homeDirectory, ... }: 
let

   yaziConfig = import ./../../modules/yazi.nix {
      inherit pkgs;
   };

   helixConfig = import ./../../modules/helix.nix {
      inherit pkgs;
   };

   zshConfig = import ./../../modules/zsh.nix {
      inherit pkgs;
      inherit lib;
      inherit system;
      inherit username;
      inherit homeDirectory;
   };

in
{

   home = {
      username = username;
      homeDirectory = lib.mkForce homeDirectory;
      stateVersion = "23.05";

      packages = with pkgs; [
         git
         # git-credential-manager

         tmux
         vim

      ];

      sessionVariables = {
         # Make the flake’s nvim first in $PATH:
         # PATH   = "${nixvim}/bin:${pkgs.lib.makeBinPath [ pkgs.coreutils ]}:$PATH";
         # And for any $EDITOR-aware tool:
         EDITOR = "vim";
         # EDITOR = "nvim";

         # CC = "clang";
         # CXX = "clang++";
         # CPLUS_INCLUDE_PATH = "${pkgs.libcxx.dev}/include/c++/v1";
      };
   };
  
  imports = [
   helixConfig
   yaziConfig
   zshConfig
  ];

   programs = {
      home-manager.enable = true;

   };

}
