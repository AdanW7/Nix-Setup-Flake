{ pkgs, lib, system, homeDirectory,Adan-nixvim, ... }: 
let
  isDarwin = system == "aarch64-darwin";
  isLinux = system == "x86_64-linux";
  username = "adan";

  tex = pkgs.texlive.combine {
    inherit (pkgs.texlive) scheme-full;
    };

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
         tex

      ];

      sessionVariables = {
         # Make the flake’s nvim first in $PATH:
         PATH   = "${nixvim}/bin:${pkgs.lib.makeBinPath [ pkgs.coreutils ]}:$PATH";
         # And for any $EDITOR-aware tool:
         EDITOR = "nvim";

         CC = "clang";
         CXX = "clang++";
         CPLUS_INCLUDE_PATH = "${pkgs.libcxx.dev}/include/c++/v1";
      };
   };
  
  imports = [
  ];

   programs = {
        # Let home-manager install and manage itself.

      home-manager.enable = true;

      zsh = {
         enable = true;

         syntaxHighlighting.enable = true;
         oh-my-zsh = {
            enable = true;
            theme = "agnoster";
            plugins = [
               "git"
               "colored-man-pages"
               "colorize"
               "pip"
               "python"
               "brew"
               "extract"
               "npm"
               "node"
               "history"
            ];
         };

         shellAliases = lib.mkMerge [
            (lib.mkIf isDarwin {
               ll = "ls -l";
               la = "ls -la";
               # ndi = "nix run nix-darwin --extra-experimental-features 'nix-command flakes' -- switch --flake ~/.config/nix";
               # ndr = "darwin-rebuild switch --flake ~/.config/nix#Adans-MacBook-Air";
               ndr = "darwin-rebuild switch --flake ${homeDirectory}/.config/nix#Adans-MacBook-Air";
               nixgc = "nix-collect-garbage -d && nix store optimise";
               ndu = "nix flake update --flake ${homeDirectory}/.config/nix";
               nix-c-dev = "nix develop github:AdanW7/nix_C_dev_flake --impure --no-write-lock-file --command $SHELL";

            })
            (lib.mkIf isLinux {
               ll = "ls -l";
               la = "ls -la";
               nixgc = "nix-collect-garbage -d && nix store optimise";
               nixsysrebuild ="sudo nixos-rebuild switch --flake ${homeDirectory}/.config/nix#nixos";
               nixsysupdate = "nix flake update --flake ${homeDirectory}/.config/nix";
               nixdelgen="sudo nix-env --delete-generations +2 --profile /nix/var/nix/profiles/system";
               nix-c-dev = "nix develop github:AdanW7/nix_C_dev_flake --impure --no-write-lock-file --command $SHELL";
            })
         ];

         initContent  = lib.mkMerge [

            # Mac-specific init
            (lib.mkIf isDarwin ''
              # Exports
              # export PATH="$PATH:/Users/adan/.local/bin"
              export PATH="$PATH:/Users/${username}/.local/bin"
              export PATH="$PATH:/opt/homebrew/bin"
              export PKG_CONFIG_PATH="$(brew --prefix)/lib/pkgconfig:$PKG_CONFIG_PATH"


              # Zsh plugins
              source ${pkgs.zsh-autosuggestions}/share/zsh-autosuggestions/zsh-autosuggestions.zsh
              source ${pkgs.zsh-syntax-highlighting}/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh

              # >>> conda initialize >>>
              # !! Contents within this block are managed by 'conda init' !!
              # __conda_setup="$('/Users/adan/miniconda3/bin/conda' 'shell.zsh' 'hook' 2> /dev/null)"
              __conda_setup="$('/Users/${username}/miniconda3/bin/conda' 'shell.zsh' 'hook' 2> /dev/null)"
              if [ $? -eq 0 ]; then
                  eval "$__conda_setup"
              else
                  # if [ -f "/Users/adan/miniconda3/etc/profile.d/conda.sh" ]; then
                  if [ -f "/Users/${username}/miniconda3/etc/profile.d/conda.sh" ]; then
                      # . "/Users/adan/miniconda3/etc/profile.d/conda.sh"
                      . "/Users/${username}/miniconda3/etc/profile.d/conda.sh"
                  else
                      # export PATH="/Users/adan/miniconda3/bin:$PATH"
                      export PATH="/Users/${username}/miniconda3/bin:$PATH"
                  fi
              fi
              unset __conda_setup
            '')

            # Linux-specific init
            (lib.mkIf isLinux ''
               # Zsh plugins
               source ${pkgs.zsh-autosuggestions}/share/zsh-autosuggestions/zsh-autosuggestions.zsh
               source ${pkgs.zsh-syntax-highlighting}/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
            '')
         ];
      };
   };

}
