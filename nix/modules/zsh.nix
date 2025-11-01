{ pkgs,lib, system, username, homeDirectory, ... }:let

   isDarwin = system == "aarch64-darwin";
   isLinux = system == "x86_64-linux";


in{

   programs.zsh = {
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

            # for some reason i have to hard code in the path for rebuild but nod needed for update
            # ndr = "sudo darwin-rebuild switch --flake ${homeDirectory}/.config/nix#Adans-MacBook-Air";
            ndr = "sudo darwin-rebuild switch --flake /Users/adan/.config/nix#Adans-MacBook-Air";

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
            main-home-switch = "home-manager switch --flake ~/.config/nix#adan@adan-pc";
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
            export VK_ICD_FILENAMES=/usr/local/share/vulkan/icd.d/MoltenVK_icd.json


            # Zsh plugins
            source ${pkgs.zsh-autosuggestions}/share/zsh-autosuggestions/zsh-autosuggestions.zsh
            source ${pkgs.zsh-syntax-highlighting}/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh

            # >>> conda initialize >>>
            # !! Contents within this block are managed by 'conda init' !!
            __conda_setup="$('/Users/${username}/miniconda3/bin/conda' 'shell.zsh' 'hook' 2> /dev/null)"
            if [ $? -eq 0 ]; then
               eval "$__conda_setup"
            else
               if [ -f "/Users/${username}/miniconda3/etc/profile.d/conda.sh" ]; then
                  . "/Users/${username}/miniconda3/etc/profile.d/conda.sh"
               else
                  # export PATH="/Users/adan/miniconda3/bin:$PATH"
                  export PATH="/Users/${username}/miniconda3/bin:$PATH"
               fi
            fi
            unset __conda_setup

         '')

         (lib.mkIf isLinux ''
            # Zsh plugins
            source ${pkgs.zsh-autosuggestions}/share/zsh-autosuggestions/zsh-autosuggestions.zsh
            source ${pkgs.zsh-syntax-highlighting}/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
         '')

      ];
   };
}
