{ ... }:let
Wodzi = import ./helix_themes/Woods.nix;

in{
   programs.helix = {
         enable = true;
         themes = {
            Wodzi-theme = Wodzi;
            
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
            theme = "Wodzi-theme";
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
}
