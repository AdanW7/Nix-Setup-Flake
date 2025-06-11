
{ pkgs, ... }:
{
   programs.yazi = {
      enable = true;
      enableZshIntegration = true;
      shellWrapperName = "y";

      settings = {
         mgr = {
            ratio = [#Manager layout by ratio, 3-element array.
               1 # left -> 1/8
               4 # middle -> 4/8
               3 # right -> 3/8
            ];
            sort_by = "natural";# File sorting method.
            sort_sensitive = true; #Sort case-sensitively.
            sort_reverse = false;# Display files in reverse order.
            sort_dir_first = true;#Display directories first.
            linemode = "none";#Line mode: display information associated with the file on the right side of the file list row.

            show_hidden = true;# show hidden files
            show_symlink = true; #Show the path of the symlink file point to, after the filename.
         };
   
         preview = {
            wrap = "yes";
            image_filter = "lanczos3"; #The filter used on image downscaling, lanczos3 is hightest quality but slowest
            image_quality = 90;#Quality on pre-caching images, range 50-90., higher range = better quality but slower
            ueberzug_scale = 1;#ueberzug_scale (Float): Ueberzug image scaling ratio, scale>1 for enlargement, scale<1 for reduction.
            ueberzug_offset = [0 0 0 0];# ueberzug_offset (float) ([x, y, width, height]):
            tab_size = 2;#The width of a tab character (\t) in spaces.
            max_width = 600;# Maximum preview width for images
            max_height = 900;#Maximum preview height for images
            cache_dir = "";
            image_delay = 30;# Wait for at least the specified milliseconds before starting to send image preview data to the terminal.
         };
         # tasks = {};
         # opener = {};
         input = {
            cursor_blink = true;
         };
      };

      keymap = {
         # input.prepend_keymap = [
         #    { run = "close"; on = [ "<C-q>" ]; }
         #    { run = "close --submit"; on = [ "<Enter>" ]; }
         #    { run = "escape"; on = [ "<Esc>" ]; }
         #    { run = "backspace"; on = [ "<Backspace>" ]; }
         # ];
         # mgr.prepend_keymap = [
         #    { run = "escape"; on = [ "<Esc>" ]; }
         #    { run = "quit"; on = [ "q" ]; }
         #    { run = "close"; on = [ "<C-q>" ]; }
         # ];
      };

      theme = {
         flavor = {
            light = "monokai-vibrant";
            dark = "monokai-vibrant";
            # light = "moonfly";
            # dark = "moonfly";
            # light = "ayu-dark";
            # dark = "ayu-dark";
         };
         tabs = {
            inactive = { fg = "#f2b5a7"; bg = "#505557" ;};
            active   = { fg="#505557"; bg = "#f2b5a7"; bold = true; underline = true; };
            sep_inner = { open = ""; close = ""; };
            sep_outer = { open = ""; close = ""; };
         };
         mgr = {
            border_style = {fg="#505557";};
      
         };
   
         status = {
            sep_left = { open = ""; close = ""; };
            sep_right = { open = ""; close = ""; };
         };
         mode = {
            normal_main = { fg ="#505557";bg = "#5de6a8"; bold = true; };
            normal_alt  = { fg = "#5de6a8"; bg = "#505557"; };

            # Select mode
            select_main = { fg ="#505557";bg = "#FF6961"; bold = true; };
            select_alt  = { fg = "#FF6961"; bg = "#505557"; };

            # Unset mode
            unset_main = { fg ="#505557";bg = "red"; bold = true; };
            unset_alt  = { fg = "red"; bg = "#505557"; };
         };
         filetype = {
            rules = [
               { mime = "image/*"; fg = "#FFD945"; }
               { mime = "{audio,video}/*"; fg = "#eb5086"; }

               { mime = "application/{,g}zip"; fg = "#FF3F4F"; }
               { mime = "application/x-{tar,bzip*,7z-compressed,xz,rar}"; fg = "#FF3F4F"; }
               { mime = "application/{pdf,doc,rtf,vnd.*}"; fg = "#24b3f0"; }

               { name = "*.sh"; is = "exec"; fg = "#f2d75e"; }  # exec .sh
               { name = "*.sh"; fg = "#f26fe1"; } # non-exec .sh

               #archives
               { name = "*.tar"; fg = "#FF3F4F"; }           # TAR archives (red)
               { name = "*.xz"; fg = "#FF3F4F"; }            # XZ compressed (red)
               { name = "*.dmg"; fg = "#007aff"; }           # macOS disk images (blue)
               { name = "*.deb"; fg = "#a80030"; }           # Debian packages (red)
               { name = "*.rpm"; fg = "#ee0000"; }           # RPM packages (red)

               # programming languages
               { name = "*.zig"; fg = "#F7A41D"; }
               { name = "*.{h,hpp}"; fg = "#9976bf"; }# C headers
               { name = "*.{c,cpp}"; fg = "#6c9cf8"; } # C files
               { name = "*.py"; fg = "#3776ab"; }     # Python (official blue)
               { name = "*.rs"; fg = "#ce422b"; }     # Rust (official orange-red)
               { name = "*.js"; fg = "#f7df1e"; }     # JavaScript (yellow)
               { name = "*.ts"; fg = "#3178c6"; }     # TypeScript (blue)
               { name = "*.go"; fg = "#00add8"; }     # Go (cyan)
               { name = "*.java"; fg = "#ed8b00"; }   # Java (orange)
               { name = "*.rb"; fg = "#cc342d"; }     # Ruby (red)
               { name = "*.php"; fg = "#777bb4"; }    # PHP (purple)
               { name = "*.swift"; fg = "#fa7343"; }  # Swift (orange)
               { name = "*.kt"; fg = "#7f52ff"; }     # Kotlin (purple)
               { name = "*.nix"; fg = "#7ebae4"; }           # Nix (light blue)
      
               # Web/Config Files:
               { name = "*.{html,htm}"; fg = "#e34f26"; }    # HTML (orange)
               { name = "*.css"; fg = "#1572b6"; }           # CSS (blue)
               { name = "*.wasm"; fg = "#654ff0"; }          # WebAssembly (purple)
               { name = "*.{json,jsonc}"; fg = "#ffd500"; }  # JSON (yellow)
               { name = "*.{yml,yaml}"; fg = "#cb171e"; }    # YAML (red)
               { name = "*.toml"; fg = "#9c4221"; }          # TOML (brown)
               { name = "*.xml"; fg = "#0060ac"; }           # XML (blue)
               { name = "*.lock"; fg = "#6c7086"; }          # Lock files (grey)

               #Data/Config:
               { name = "*.csv"; fg = "#217346"; }           # CSV (green)
               { name = "*.log"; fg = "#6c7086"; }           # Log files (grey)
               { name = "*.ini"; fg = "#d4af37"; }           # INI config (gold)
               { name = "*.conf"; fg = "#d4af37"; }          # Config files (gold)

               #Text/Documentation:
               { name = "*.{md,markdown}"; fg = "#083fa1"; } # Markdown (blue)
               { name = "*.txt"; fg = "#89e051"; }           # Text files (green)
               { name = "*.tex"; fg = "#3d6117"; }           # LaTeX (dark green)                  

               #System/Build Files:
               { name = "Makefile"; fg = "#427819"; }        # Makefiles (green)
               { name = "Dockerfile*"; fg = "#2496ed"; }     # Docker (blue)
               { name = "*.cmake"; fg = "#064f8c"; }         # CMake (dark blue)

               # System/Hidden Files:
               { name = ".env*"; fg = "#ecd53f"; }           # Environment files (yellow)
               { name = ".git*"; fg = "#f14e32"; }           # Git files (red)
         
               #misc
               { name = "*/"; fg = "#5de6a8"; } # folders
               { name = "*"; is = "orphan"; fg = "#FF3F4F"; }
               { name = "*"; is = "exec"; fg = "#f2d75e"; } #executable files


            ];
         };
      };

      flavors = {
         ayu-dark = fetchTarball {
           url = "https://github.com/kmlupreti/ayu-dark.yazi/archive/refs/heads/main.tar.gz";
           sha256 = "sha256-RY6MYxXSj2+dYojbM/v44XY/2oVcVkO+EaOHZSwyk34="; # fill in
         };
         moonfly = fetchTarball{
            url ="https://github.com/tkapias/moonfly.yazi/archive/refs/heads/main.tar.gz";
            sha256 = "sha256-9K2e+wodG3XOdcKgPJA4fYZCXZylWRTRM1IHrc+I7bw=";
         };
         monokai-vibrant = fetchTarball{
            url ="https://github.com/sanjinso/monokai-vibrant.yazi/archive/refs/heads/main.tar.gz";
            sha256 = "sha256-f3IaeDJ4gZf5glk4RIVQ1/DqH0ON2Sv5UzGvdAnLEbw=";
         };
      };
      
      initLua = ''
        -- enable username and hostname at tope left of screen before directory
        if Header and Header.children_add then
          Header:children_add(function()
            if ya.target_family() ~= "unix" then
              return ""
            end
            return ui.Span(ya.user_name() .. "@" .. ya.host_name() .. ":"):fg("blue")
          end, 500, Header.LEFT)
        end
        --Show symlink in status bar
        Status:children_add(function(self)
         	local h = self._current.hovered
         	if h and h.link_to then
         		return " -> " .. tostring(h.link_to)
         	else
         		return ""
         	end
         end, 3300, Status.LEFT)
      '';
      package = pkgs.yazi;
   };
}
