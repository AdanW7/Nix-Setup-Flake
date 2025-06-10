{ pkgs, lib, system, homeDirectory,Adan-nixvim, ... }: 
let
  isDarwin = system == "aarch64-darwin";
  username = "adan";

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
         EDITOR = "nvim";
         # EDITOR = "hx";

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

      yazi = {
         enable = true;
         enableZshIntegration = true;
         # shellWrapperName = "y";

         settings = {
            mgr = {
               ratio = [
                  1
                  4
                  3
               ];
               sort_by = "natural";
               sort_sensitive = true;
               sort_reverse = false;
               sort_dir_first = true;
               linemode = "none";

               show_hidden = true;
               show_symlink = true;
            };
            
            # preview = {}:
            # tasks = {};
            keymap = {};
            theme = {};
            yazi = {};
         };
         flavors = {};
         initLua = null;
         package = pkgs.yazi;
      };
      helix = {
         enable = true;
         themes = {
            everblush_transparent = {
               "attribute" = { fg = "blue"; };
              "comment" = { fg = "comment"; modifiers = [ "italic" ]; };
              "constant" = { fg = "cyan"; };
              "constant.builtin.boolean" = { fg = "cyan"; };
              "constant.character" = { fg = "blue"; };
              "constant.numeric.float" = { fg = "black-light"; };
              "constant.builtin" = { fg = "blue"; };
              "constant.numeric" = { fg = "yellow"; };
              "constructor" = { fg = "blue"; };
              "function" = { fg = "red"; };
              "function.builtin" = { fg = "cyan-light"; };
              "function.macro" = { fg = "green"; };
              "function.method" = { fg = "blue-light"; };
              "keyword" = { fg = "blue"; };
              "keyword.function" = { fg = "blue"; };
              "keyword.operator" = { fg = "blue-light"; };
              "keyword.control.conditional" = { fg = "red"; };
              "keyword.control.import" = { fg = "red-light"; };
              "keyword.control.return" = { fg = "blue"; };
              "keyword.control.repeat" = { fg = "yellow-light"; };
              "keyword.control.exception" = { fg = "black-light"; };
              "label" = { fg = "blue"; };
              "namespace" = { fg = "red-light"; };
              "operator" = { fg = "white"; };
              # "parameter.reference" = { fg = "red-light"; };
              # "property" = { fg = "red"; };
              "punctuation.bracket" = { fg = "white"; };
              "punctuation.delimiter" = { fg = "white"; };
              "punctuation.special" = { fg = "white"; };
              "string" = { fg = "green"; };
              "string.escape" = { fg = "blue"; };
              "string.regex" = { fg = "green"; };
              "string.special" = { fg = "blue"; };
              "string.special.symbol" = { fg = "red"; };
              "tag" = { fg = "blue"; };
              "type" = { fg = "yellow"; };
              "type.builtin" = { fg = "yellow"; };
              "variable" = { fg = "white"; };
              "variable.builtin" = { fg = "blue"; };
              "variable.parameter" = { fg = "red"; };
              "variable.other.member" = { fg = "red"; };

              "diff.plus" = { fg = "blue"; };
              "diff.delta" = { fg = "magenta"; };
              "diff.minus" = { fg = "red"; };

              "ui.background" = { fg = "foreground"; bg = "none"; };
              "ui.cursor" = { modifiers = [ "reversed" ]; };
              "ui.cursorline.primary" = { bg = "cursorline"; };
              "ui.help" = { fg = "foreground"; bg = "contrast"; };
              "ui.linenr" = { fg = "comment"; };
              "ui.linenr.selected" = { fg = "foreground"; };
              "ui.menu" = { fg = "foreground"; bg = "contrast"; };
              "ui.menu.selected" = { bg = "black"; };
              "ui.popup" = { fg = "foreground"; bg = "contrast"; };
              "ui.selection" = { bg = "black"; };
              "ui.selection.primary" = { bg = "black"; };
              "ui.statusline" = { fg = "foreground"; bg = "background"; };
              "ui.statusline.inactive" = { fg = "foreground"; bg = "background"; };
              "ui.statusline.normal" = { fg = "white"; bg = "background"; };
              "ui.statusline.insert" = { fg = "blue"; bg = "background"; };
              "ui.statusline.select" = { fg = "magenta"; bg = "background"; };
              "ui.text" = { fg = "foreground"; };
              "ui.text.focus" = { fg = "blue"; };
              "ui.virtual.ruler" = { bg = "cursorline"; };
              "ui.virtual.whitespace" = { fg = "comment"; };
              "ui.virtual.wrap" = { fg = "comment"; };
              "ui.virtual.indent-guide" = { fg = "comment"; };
              "ui.virtual.inlay-hint" = { fg = "comment"; };
              "ui.window" = { fg = "black"; };

              "error" = { fg = "red"; };
              "hint" = { fg = "green"; };
              "warning" = { fg = "yellow"; };
              "info" = { fg = "blue"; };

              "diagnostic.error" = { underline = { style = "curl"; color = "red"; }; };
              "diagnostic.warning" = { underline = { style = "curl"; color = "yellow"; }; };
              "diagnostic.info" = { underline = { style = "curl"; color = "blue"; }; };
              "diagnostic.hint" = { underline = { style = "curl"; color = "green"; }; };
              "diagnostic.unnecessary" = { modifiers = [ "dim" ]; };
              "diagnostic.deprecated" = { modifiers = [ "crossed_out" ]; };
              "special" = { fg = "red-light"; };

              "markup.heading" = { fg = "blue"; modifiers = [ "bold" ]; };
              "markup.list" = { fg = "cyan"; };
              "markup.bold" = { fg = "magenta"; modifiers = [ "bold" ]; };
              "markup.italic" = { fg = "yellow"; modifiers = [ "italic" ]; };
              "markup.strikethrough" = { modifiers = [ "crossed_out" ]; };
              "markup.link.url" = { fg = "green"; };
              "markup.link.text" = { fg = "black-light"; };
              "markup.quote" = { fg = "yellow"; modifiers = [ "italic" ]; };
              "markup.raw" = { fg = "cyan"; };

              palette = {
                black = "#232a2d";
                red = "#e57474";
                green = "#8ccf7e";
                yellow = "#e5c76b";
                blue = "#67b0e8";
                magenta = "#c47fd5";
                cyan = "#6cbfbf";
                white = "#b3b9b8";
                black-light = "#2d3437";
                red-light = "#ef7e7e";
                green-light = "#96d988";
                yellow-light = "#f4d67a";
                blue-light = "#71baf2";
                magenta-light = "#ce89df";
                cyan-light = "#67cbe7";
                white-light = "#bdc3c2";
                comment = "#404749";
                contrast = "#161d1f";
                background = "#141b1e";
                foreground = "#dadada";
                cursorline = "#2c3333";
              };
            };
            
         };
         languages = {
            language = [
               {
                  name = "zig";
                  auto-format = true;
               }
            ];
         };
         settings = {
            theme = "everblush_transparent";
            editor = {

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
