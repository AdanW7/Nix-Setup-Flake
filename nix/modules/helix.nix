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
               auto-format = true;
               comment-token = "#";
               file-types = [ "py" "pyi" "py3" "pyw" ".pythonstartup" ".pythonrc" ];
               injection-regex = "python";
               language-servers = [ "pyright" "ruff" "scls" ];
               name = "python";
               roots = [ "." "pyproject.toml" "pyrightconfig.json" ];
               scope = "source.python";
               shebangs = [ "python" ];
               formatter = {
                 command = "ruff";
                 args = [ "format" "--stdin-filename" "dummy.py" "-" ];
               };
               indent = {
                 tab-width = 4;
                 unit = "    ";
               };
             }
             {
               name = "markdown";
               scope = "source.md";
               file-types = [ "md" "markdown" "mkd" "mdwn" "mdown" "markdn" "mdtxt" "mdtext" "workbook" ];
               roots = [ ".marksman.toml" ];
               language-servers = [ "marksman" "scls" ];
               indent = {
                 tab-width = 4;
                 unit = " ";
               };
               block-comment-tokens = {
                 start = "<!--";
                 end = "-->";
               };
             }
             {
               name = "markdown.inline";
               scope = "source.md.inline";
               file-types = [ ];
               language-servers = [ "marksman" "scls" ];
               indent = {
                 tab-width = 4;
                 unit = " ";
               };
               block-comment-tokens = {
                 start = "<!--";
                 end = "-->";
               };
             }
           ];

           language-server = {
             pyright = {
               command = "pyright-langserver";
               args = [ "--stdio" ];
               config = {
                 reportMissingTypeStubs = false;
                 python.analysis = {
                   typeCheckingMode = "basic";
                   autoImportCompletions = true;
                 };
               };
             };

             ruff = {
               command = "ruff";
               args = [ "server" "--preview" ];
               config = {
                 settings = {
                   line-length = 120;
                   exclude = [
                     ".bzr"
                     ".direnv"
                     ".eggs"
                     ".git"
                     ".git-rewrite"
                     ".hg"
                     ".ipynb_checkpoints"
                     ".mypy_cache"
                     ".nox"
                     ".pants.d"
                     ".pyenv"
                     ".pytest_cache"
                     ".pytype"
                     ".ruff_cache"
                     ".svn"
                     ".tox"
                     ".venv"
                     ".vscode"
                     "__pypackages__"
                     "_build"
                     "buck-out"
                     "build"
                     "dist"
                     "node_modules"
                     "site-packages"
                     "venv"
                   ];
                   indent-width = 4;
                   target-version = "py311";
                   lint = {
                     preview = true;
                     fixable = [ "ALL" ];
                     unfixable = [ "B" ];
                     ignore = [ "E501" "F403" "F405" ];
                     select = [ "E4" "E7" "E9" "F" "B" ];
                   };
                   format = {
                     preview = true;
                     quote-style = "single";
                     indent-style = "space";
                     skip-magic-trailing-comma = false;
                     line-ending = "auto";
                   };
                 };
               };
             };

             scls = {
               command = "simple-completion-language-server";
               config = {
                 max_completion_items = 100;
                 feature_words = true;
                 feature_snippets = true;
                 snippets_first = true;
                 snippets_inline_by_word_tail = false;
                 feature_unicode_input = false;
                 feature_paths = false;
                 feature_citations = false;
               };
             };

             marksman = {
               command = "marksman";
               args = [ "server" ];
             };
           };
         };
         settings = {
           theme = "Wodzi-theme";

           editor = {
             bufferline = "always";
             color-modes = true;
             line-number = "absolute";
             mouse = false;
             end-of-line-diagnostics = "hint";

             inline-diagnostics = {
               cursor-line = "error";
             };

             auto-save = {
               focus-lost = true;
               after-delay = {
                 enable = true;
                 timeout = 1500;
               };
             };

             cursor-shape = {
               insert = "bar";
               normal = "block";
               select = "block";
             };

             file-picker = {
               hidden = true;
             };

             indent-guides = {
               render = true;
               character = "╎";
               skip-levels = 1;
             };

             lsp = {
               display-inlay-hints = false;
             };

             statusline = {
               center = [ "file-name" "read-only-indicator" ];
               left = [ "mode" "file-modification-indicator" "total-line-numbers" ];
               right = [
                 "diagnostics"
                 "selections"
                 "register"
                 "position"
                 "file-encoding"
                 "file-line-ending"
                 "file-type"
               ];
               separator = "│";
               mode = {
                 insert = "INSERT";
                 normal = "NORMAL";
                 select = "SELECT";
               };
             };

             whitespace = {
               characters = {
                 nbsp = "⍽";
                 newline = "⏎";
                 nnbsp = "␣";
                 space = "·";
                 tab = "→";
                 tabpad = "·";
               };

               render = {
                 nbsp = "none";
                 newline = "none";
                 nnbsp = "none";
                 space = "all";
                 tab = "all";
               };
             };
           };

           keys = {
             normal = {
               esc = [ "collapse_selection" "keep_primary_selection" ];

               "C-y" = {
                 y = ":sh zellij run -n Yazi -c -f -x 10% -y 10% --width 80% --height 80% -- bash -c 'paths=$(yazi --chooser-file=/dev/stdout); if [[ -n \"$paths\" ]]; then zellij action toggle-floating-panes; sleep 0.1; zellij action write 27; zellij action write-chars \":open $paths\"; zellij action write 13; else zellij action toggle-floating-panes; fi'";
                 v = ":sh zellij run -n Yazi -c -f -x 10% -y 10% --width 80% --height 80% -- bash -c 'paths=$(yazi --chooser-file=/dev/stdout); if [[ -n \"$paths\" ]]; then zellij action toggle-floating-panes; sleep 0.1; zellij action write 27; zellij action write-chars \":vsplit $paths\"; zellij action write 13; else zellij action toggle-floating-panes; fi'";
                 h = ":sh zellij run -n Yazi -c -f -x 10% -y 10% --width 80% --height 80% -- bash -c 'paths=$(yazi --chooser-file=/dev/stdout); if [[ -n \"$paths\" ]]; then zellij action toggle-floating-panes; sleep 0.1; zellij action write 27; zellij action write-chars \":hsplit $paths\"; zellij action write 13; else zellij action toggle-floating-panes; fi'";
               };

               "C-g" = [
                 ":new"
                 ":insert-output lazygit"
                 ":buffer-close!"
                 ":redraw"
               ];
             };
           };
         };
         ignores = [];
         extraPackages = [];
      };
}
