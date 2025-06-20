{ pkgs,... }:let
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


               {
                  name = "python";
                  scope = "source.python";
                  injection-regex = "python";
                  file-types = ["py" "pyi" "py3" "pyw" ".pythonstartup" ".pythonrc"];
                  shebangs = ["python"];
                  roots = ["."  "pyproject.toml"  "pyrightconfig.json"];
                  comment-token = "#";
                  language-servers = ["pyright" "ruff"];
                  indent = { tab-width = 4;  unit = "    "; };
                  auto-format = true;
                  formatter = {
                     command = "ruff";
                     args = ["format" "--stdin-filename" "dummy.py" "-"];
                  };
               }
               
            ];
            language-server = {
               pyright = {
                  command = "pyright-langserver";
                  args = ["--stdio"];
                  config = {
                     reportMissingTypeStubs = false;
                     python.analysis = {
                        typeCheckingMode = "basic";
                        autoImportCompletions = true;
                     };
                   };
               };
  
               ruff = {
                   command = "ruff";  # Note: changed from "ruff-lsp"
                   args = ["server" "--preview"];
                   config = {
                     settings = {};
                   };
               };
            };
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
                  hidden = true;
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
                  "C-y" = {
                     # Open the file(s) in the current window
                     y = ":sh zellij run -n Yazi -c -f -x 10% -y 10% --width 80% --height 80% -- bash -c 'paths=$(yazi --chooser-file=/dev/stdout); if [[ -n \"$paths\" ]]; then zellij action toggle-floating-panes; sleep 0.1; zellij action write 27; zellij action write-chars \":open $paths\"; zellij action write 13; else zellij action toggle-floating-panes; fi'";
                     # Open the file(s) in a vertical split
                     v = ":sh zellij run -n Yazi -c -f -x 10% -y 10% --width 80% --height 80% -- bash -c 'paths=$(yazi --chooser-file=/dev/stdout); if [[ -n \"$paths\" ]]; then zellij action toggle-floating-panes; sleep 0.1; zellij action write 27; zellij action write-chars \":vsplit $paths\"; zellij action write 13; else zellij action toggle-floating-panes; fi'";
                     # Open the file(s) in a horizontal split
                     h = ":sh zellij run -n Yazi -c -f -x 10% -y 10% --width 80% --height 80% -- bash -c 'paths=$(yazi --chooser-file=/dev/stdout); if [[ -n \"$paths\" ]]; then zellij action toggle-floating-panes; sleep 0.1; zellij action write 27; zellij action write-chars \":hsplit $paths\"; zellij action write 13; else zellij action toggle-floating-panes; fi'";
                  };
               };
            };
         };
         ignores = [];
         extraPackages = [];
      };
}
