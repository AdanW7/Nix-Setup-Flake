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

}
