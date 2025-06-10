{ pkgs, lib, system, homeDirectory,Adan-nixvim, ... }: 
let
  isDarwin = system == "aarch64-darwin";
  username = "adan";
  Woods = import ./../../modules/helix_themes/Woods.nix;
  yaziConfig = import ./../../modules/yazi.nix;

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
  ];

   programs = {
        # Let home-manager install and manage itself.

      home-manager.enable = true;

      # yazi = {
      #    enable = true;
      #    enableZshIntegration = true;
      #    shellWrapperName = "y";

      #    settings = {
      #       mgr = {
      #          ratio = [#Manager layout by ratio, 3-element array.
      #             1 # left -> 1/8
      #             4 # middle -> 4/8
      #             3 # right -> 3/8
      #          ];
      #          sort_by = "natural";# File sorting method.
      #          sort_sensitive = true; #Sort case-sensitively.
      #          sort_reverse = false;# Display files in reverse order.
      #          sort_dir_first = true;#Display directories first.
      #          linemode = "none";#Line mode: display information associated with the file on the right side of the file list row.

      #          show_hidden = true;# show hidden files
      #          show_symlink = true; #Show the path of the symlink file point to, after the filename.
      #       };
            
      #       preview = {
      #          wrap = "yes";
      #          image_filter = "catmull-rom"; #The filter used on image downscaling, lanczos3 is hightest quality but slowest
      #          image_quality = 75;#Quality on pre-caching images, range 50-90., higher range = better quality but slower
      #          ueberzug_scale = 1;#ueberzug_scale (Float): Ueberzug image scaling ratio, scale>1 for enlargement, scale<1 for reduction.
      #          ueberzug_offset = [0 0 0 0];# ueberzug_offset (float) ([x, y, width, height]):
      #          tab_size = 2;#The width of a tab character (\t) in spaces.
      #          max_width = 600;# Maximum preview width for images
      #          max_height = 900;#Maximum preview height for images
      #          cache_dir = "";
      #          image_delay = 30;# Wait for at least the specified milliseconds before starting to send image preview data to the terminal.
      #       };
      #       # tasks = {};
      #       # opener = {};
      #       input = {
      #          cursor_blink = true;
      #       };
      #    };

      #    keymap = {
      #       # input.prepend_keymap = [
      #       #    { run = "close"; on = [ "<C-q>" ]; }
      #       #    { run = "close --submit"; on = [ "<Enter>" ]; }
      #       #    { run = "escape"; on = [ "<Esc>" ]; }
      #       #    { run = "backspace"; on = [ "<Backspace>" ]; }
      #       # ];
      #       # mgr.prepend_keymap = [
      #       #    { run = "escape"; on = [ "<Esc>" ]; }
      #       #    { run = "quit"; on = [ "q" ]; }
      #       #    { run = "close"; on = [ "<C-q>" ]; }
      #       # ];
      #    };

      #    theme = {
      #       flavor = {
      #          light = "monokai-vibrant";
      #          dark = "monokai-vibrant";
      #          # light = "moonfly";
      #          # dark = "moonfly";
      #          # light = "ayu-dark";
      #          # dark = "ayu-dark";
      #       };
      #       tabs = {
      #          inactive = { fg = "#f2b5a7"; bg = "#505557" ;};
      #          active   = { fg="#505557"; bg = "#f2b5a7"; bold = true; underline = true; };
      #          sep_inner = { open = ""; close = ""; };
      #          sep_outer = { open = ""; close = ""; };
      #       };
      #       mgr = {
      #          border_style = {fg="#505557";};
               
      #       };
            
      #       status = {
      #          sep_left = { open = ""; close = ""; };
      #          sep_right = { open = ""; close = ""; };
      #       };
      #       mode = {
      #          normal_main = { fg ="#505557";bg = "#5de6a8"; bold = true; };
      #          normal_alt  = { fg = "#5de6a8"; bg = "#505557"; };

      #          # Select mode
      #          select_main = { fg ="#505557";bg = "#FF6961"; bold = true; };
      #          select_alt  = { fg = "#FF6961"; bg = "#505557"; };

      #          # Unset mode
      #          unset_main = { fg ="#505557";bg = "red"; bold = true; };
      #          unset_alt  = { fg = "red"; bg = "#505557"; };
      #       };
      #       filetype = {
      #          rules = [
      #             { mime = "image/*"; fg = "#FFD945"; }
      #             { mime = "{audio,video}/*"; fg = "#eb5086"; }

      #             { mime = "application/{,g}zip"; fg = "#FF3F4F"; }
      #             { mime = "application/x-{tar,bzip*,7z-compressed,xz,rar}"; fg = "#FF3F4F"; }
      #             { mime = "application/{pdf,doc,rtf,vnd.*}"; fg = "#24b3f0"; }

      #             { name = "*.sh"; is = "exec"; fg = "#f2d75e"; }  # exec .sh
      #             { name = "*.sh"; fg = "#f26fe1"; } # non-exec .sh

      #             #archives
      #             { name = "*.tar"; fg = "#FF3F4F"; }           # TAR archives (red)
      #             { name = "*.xz"; fg = "#FF3F4F"; }            # XZ compressed (red)
      #             { name = "*.dmg"; fg = "#007aff"; }           # macOS disk images (blue)
      #             { name = "*.deb"; fg = "#a80030"; }           # Debian packages (red)
      #             { name = "*.rpm"; fg = "#ee0000"; }           # RPM packages (red)

      #             # programming languages
      #             { name = "*.zig"; fg = "#F7A41D"; }
      #             { name = "*.{h,hpp}"; fg = "#9976bf"; }# C headers
      #             { name = "*.{c,cpp}"; fg = "#6c9cf8"; } # C files
      #             { name = "*.py"; fg = "#3776ab"; }     # Python (official blue)
      #             { name = "*.rs"; fg = "#ce422b"; }     # Rust (official orange-red)
      #             { name = "*.js"; fg = "#f7df1e"; }     # JavaScript (yellow)
      #             { name = "*.ts"; fg = "#3178c6"; }     # TypeScript (blue)
      #             { name = "*.go"; fg = "#00add8"; }     # Go (cyan)
      #             { name = "*.java"; fg = "#ed8b00"; }   # Java (orange)
      #             { name = "*.rb"; fg = "#cc342d"; }     # Ruby (red)
      #             { name = "*.php"; fg = "#777bb4"; }    # PHP (purple)
      #             { name = "*.swift"; fg = "#fa7343"; }  # Swift (orange)
      #             { name = "*.kt"; fg = "#7f52ff"; }     # Kotlin (purple)
      #             { name = "*.nix"; fg = "#7ebae4"; }           # Nix (light blue)
               
      #             # Web/Config Files:
      #             { name = "*.{html,htm}"; fg = "#e34f26"; }    # HTML (orange)
      #             { name = "*.css"; fg = "#1572b6"; }           # CSS (blue)
      #             { name = "*.wasm"; fg = "#654ff0"; }          # WebAssembly (purple)
      #             { name = "*.{json,jsonc}"; fg = "#ffd500"; }  # JSON (yellow)
      #             { name = "*.{yml,yaml}"; fg = "#cb171e"; }    # YAML (red)
      #             { name = "*.toml"; fg = "#9c4221"; }          # TOML (brown)
      #             { name = "*.xml"; fg = "#0060ac"; }           # XML (blue)
      #             { name = "*.lock"; fg = "#6c7086"; }          # Lock files (grey)

      #             #Data/Config:
      #             { name = "*.csv"; fg = "#217346"; }           # CSV (green)
      #             { name = "*.log"; fg = "#6c7086"; }           # Log files (grey)
      #             { name = "*.ini"; fg = "#d4af37"; }           # INI config (gold)
      #             { name = "*.conf"; fg = "#d4af37"; }          # Config files (gold)

      #             #Text/Documentation:
      #             { name = "*.{md,markdown}"; fg = "#083fa1"; } # Markdown (blue)
      #             { name = "*.txt"; fg = "#89e051"; }           # Text files (green)
      #             { name = "*.tex"; fg = "#3d6117"; }           # LaTeX (dark green)                  

      #             #System/Build Files:
      #             { name = "Makefile"; fg = "#427819"; }        # Makefiles (green)
      #             { name = "Dockerfile*"; fg = "#2496ed"; }     # Docker (blue)
      #             { name = "*.cmake"; fg = "#064f8c"; }         # CMake (dark blue)

      #             # System/Hidden Files:
      #             { name = ".env*"; fg = "#ecd53f"; }           # Environment files (yellow)
      #             { name = ".git*"; fg = "#f14e32"; }           # Git files (red)
                  
      #             #misc
      #             { name = "*/"; fg = "#5de6a8"; } # folders
      #             { name = "*"; is = "orphan"; fg = "#FF3F4F"; }
      #             { name = "*"; is = "exec"; fg = "#f2d75e"; } #executable files


      #          ];
      #       };
      #    };

      #    flavors = {
      #       ayu-dark = fetchTarball {
      #         url = "https://github.com/kmlupreti/ayu-dark.yazi/archive/refs/heads/main.tar.gz";
      #         sha256 = "sha256-RY6MYxXSj2+dYojbM/v44XY/2oVcVkO+EaOHZSwyk34="; # fill in
      #       };
      #       moonfly = fetchTarball{
      #          url ="https://github.com/tkapias/moonfly.yazi/archive/refs/heads/main.tar.gz";
      #          sha256 = "sha256-9K2e+wodG3XOdcKgPJA4fYZCXZylWRTRM1IHrc+I7bw=";
      #       };
      #       monokai-vibrant = fetchTarball{
      #          url ="https://github.com/sanjinso/monokai-vibrant.yazi/archive/refs/heads/main.tar.gz";
      #          sha256 = "sha256-f3IaeDJ4gZf5glk4RIVQ1/DqH0ON2Sv5UzGvdAnLEbw=";
      #       };
      #    };
      #    initLua = null;
      #    package = pkgs.yazi;
      # };

      helix = {
         enable = true;
         themes = {
            Woods = Woods;
            
         };
         languages = {
            language = [
               {
                  name = "zig";
                  auto-format = true;
               }
               {
                  name = "rust";
                  auto-format = false;
               }
            ];
         };
         settings = {
            theme = "Woods";
            editor = {
               color-modes = true;
               line-number = "absolute";
               mouse = false;
               bufferline = "always";

               cursor-shape = {
                  insert = "bar";
                  normal = "block";
                  select = "block";
               };

               file-picker = {
                  hidden = false;
               };

               lsp = {
                  display-inlay-hints = false;
               };

               auto-save = {
                  after-delay = {
                     enable = true;
                     timeout = 3000;
                  };
                  focus-lost = true;
               };

               statusline = {
                  left = ["mode" "file-modification-indicator" "total-line-numbers"];
                  center = ["file-name" "read-only-indicator"];
                  right = ["diagnostics" "selections" "register" "position" "file-encoding" "file-line-ending" "file-type"];
                  separator = "│";
                  mode.normal = "NORMAL";
                  mode.insert = "INSERT";
                  mode.select = "SELECT";

               };

               whitespace = {
                  render = {
                     space = "all";
                     tab = "all";
                     nbsp = "none";
                     nnbsp = "none";
                     newline = "none";
                  };

                  characters = {
                     space = "·";
                     nbsp = "⍽";
                     nnbsp = "␣";
                     tab = "→";
                     newline = "⏎";
                     tabpad = "·";# Tabs will look like "→···" (depending on tab width)
                  };
               };
               indent-guides = {
                  render = true;
                  character = "╎"; # Some characters that work well: "╎" "▏", "┆", "┊", "⸽"
                  skip-levels = 1;
               };
            };
            keys = {
               normal = {
                  esc = ["collapse_selection" "keep_primary_selection"];
               };
            };
         };
         ignores = [];
         extraPackages = [];
      };

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

               # for some reason i have to hard code in the path for rebuild but nod needed for update
               # ndr = "sudo darwin-rebuild switch --flake ${homeDirectory}/.config/nix#Adans-MacBook-Air";
               ndr = "sudo darwin-rebuild switch --flake /Users/adan/.config/nix#Adans-MacBook-Air";

               nixgc = "nix-collect-garbage -d && nix store optimise";
               ndu = "nix flake update --flake ${homeDirectory}/.config/nix";
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

         ];
      };
   };

}
