{ pkgs, lib, system, username,homeDirectory,Adan-nixvim, ... }: 
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

  # tex = pkgs.texlive.combine {
  #   inherit (pkgs.texlive) scheme-full;
  #   };

   inherit (Adan-nixvim.packages.${system}) nixvim;


in
{

   home = {
      homeDirectory = lib.mkForce homeDirectory;
      stateVersion = "23.05";

      packages = with pkgs; [
         nixvim
         openssl
         pkg-config
         # tex

      ];

      sessionVariables = {
         # Make the flake’s nvim first in $PATH:
         PATH   = "${nixvim}/bin:${pkgs.lib.makeBinPath [ pkgs.coreutils ]}:$PATH";
         # And for any $EDITOR-aware tool:
         # EDITOR = "nvim";
         EDITOR = "hx";

         CC = "clang";
         CXX = "clang++";
         CPLUS_INCLUDE_PATH = "${pkgs.libcxx.dev}/include/c++/v1";
      };
   };
  
  imports = [
    yaziConfig
    helixConfig
    zshConfig
  ];

   programs = {
      # Let home-manager install and manage itself.
      home-manager.enable = true;
   };

}
