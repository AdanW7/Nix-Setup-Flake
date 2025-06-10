{ pkgs, lib, system, username,homeDirectory,Adan-nixvim, ... }: 
let
  # isLinux = system == "x86_64-linux";

  tex = pkgs.texlive.combine {
    inherit (pkgs.texlive) scheme-full;
    };

   inherit (Adan-nixvim.packages.${system}) nixvim;

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
      homeDirectory = lib.mkForce homeDirectory;
      stateVersion = "23.05";

      packages = with pkgs; [
         tex
         clang-tools     # includes clangd, clang-tidy, clang++
         cmake           # to generate compile_commands.json
         libcxx          # C++ standard library headers
         gnumake
         nixvim
         git
         git-credential-manager

         cargo
         rustc 
         rust-analyzer
         rustfmt

         zig
         zls

         openssl
         pkg-config

         # steam
         # protonup
         # gamemode
         tmux
         # tmux-sessionizer

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
   helixConfig
   yaziConfig
   zshConfig
  ];

   programs = {
        # Let home-manager install and manage itself.

      home-manager.enable = true;

      # steam = {
      #    enable = true;
      #    gamescopeSession.enable = true;
      # };
      # gamemode = {
      #    enable = true;
      # };

      # zsh = {
      #    enable = true;

      #    syntaxHighlighting.enable = true;
      #    oh-my-zsh = {
      #       enable = true;
      #       theme = "agnoster";
      #       plugins = [
      #          "git"
      #          "colored-man-pages"
      #          "colorize"
      #          "pip"
      #          "python"
      #          "brew"
      #          "extract"
      #          "npm"
      #          "node"
      #          "history"
      #       ];
      #    };

      #    shellAliases = lib.mkMerge [
      #       (lib.mkIf isLinux {
      #          ll = "ls -l";
      #          la = "ls -la";
      #          nixgc = "nix-collect-garbage -d && nix store optimise";
      #          nixsysrebuild ="sudo nixos-rebuild switch --flake ${homeDirectory}/.config/nix#nixos";
      #          nixsysupdate = "nix flake update --flake ${homeDirectory}/.config/nix";
      #          nixdelgen="sudo nix-env --delete-generations +2 --profile /nix/var/nix/profiles/system";
      #          nix-c-dev = "nix develop github:AdanW7/nix_C_dev_flake --impure --no-write-lock-file --command $SHELL";
      #       })
      #    ];

      #    initContent  = lib.mkMerge [

      #       # Linux-specific init
      #       (lib.mkIf isLinux ''
      #          # Zsh plugins
      #          source ${pkgs.zsh-autosuggestions}/share/zsh-autosuggestions/zsh-autosuggestions.zsh
      #          source ${pkgs.zsh-syntax-highlighting}/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
      #       '')
      #    ];
      # };
   };

}
