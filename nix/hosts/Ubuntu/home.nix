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
   
   zellijConfig = import ./../../modules/zellij.nix {
      inherit pkgs;
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
         powerline-fonts

         python311

         pyright
         ruff
         
         tmux
         vim

      ];
      
      sessionVariables = {
         # EDITOR = "vim";
         EDITOR = "hx";
         # EDITOR = "nvim";
      };
   };
  
  imports = [
   helixConfig
   yaziConfig
   zshConfig
   zellijConfig
  ];

   programs = {
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
