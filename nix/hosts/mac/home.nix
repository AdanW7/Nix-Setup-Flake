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

   zellijConfig = import ./../../modules/zellij.nix {
      inherit pkgs;
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
    # common modules configs
    yaziConfig
    helixConfig
    zshConfig
    zellijConfig
  ];

   programs = {
      # Let home-manager install and manage itself.
      home-manager.enable = true;
      
   };

   programs.opam = {
     enable = true;
     switch = {
       # Initializes and uses OCaml 5.1. – choose whichever version you prefer
       name = "ocaml-5.1.0";
       kind = "switch";  # or "local-switch" if using a project-local switch
       initOptions = ["--disable-sandboxing"];
     };
     # Optionally, install these packages after switch creation
     packages = [
       "dune"     # or any other packages you want available globally
     ];
   };
}
