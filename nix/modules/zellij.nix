{ pkgs,... }:
{
  programs.zellij = {
         enable = true;
         enableZshIntegration = true;
         enableBashIntegration = true;
         package = pkgs.zellij;
         settings = {
            #built in themes
            # theme = "ansi" ;
            # theme = "ao" ;
            # theme = "atelier-sulphurpool" ;
            # theme = "ayu_mirage" ;
            # theme = "ayu_dark" ;
            # theme = "catppuccin-frappe" ;
            # theme = "catppuccin-macchiato" ;
            # theme = "cyber-noir" ;
            # theme = "blade-runner" ;
            # theme = "retro-wave" ;
            # theme = "dracula" ;
            # theme = "everforest-dark" ;
            # theme = "gruvbox-dark" ;
            # theme = "iceberg-dark" ;
            # theme = "kanagawa" ;
            # theme = "lucario" ;
            # theme = "menace" ;
            # theme = "molokai-dark" ;
            # theme = "night-owl" ;
            # theme = "nightfox" ;
            # theme = "nord" ;
            # theme = "one-half-dark" ;
            # theme = "onedark" ;
            # theme = "solarized-dark" ;
            # theme = "tokyo-night-dark" ;
            # theme = "tokyo-night-storm" ;
            # theme = "tokyo-night" ;
            # theme = "vesper" ;
            
            #Custom themes 
            theme = "adan";
         };
         themes = {
            adan = {
               themes = {
                  adan = {
                     text_unselected = {
                        base = 15;
                        background = 0;
                        emphasis_0 = 9;
                        emphasis_1 = 6;
                        emphasis_2 = 2;
                        emphasis_3 = 5;
                     };

                     text_selected = {
                        base = 15;
                        background = 8;
                        emphasis_0 = 9;
                        emphasis_1 = 6;
                        emphasis_2 = 2;
                        emphasis_3 = 5;
                     };

                     ribbon_unselected = {
                        base = 0;
                        background = 7;
                        emphasis_0 = 1;
                        emphasis_1 = 15;
                        emphasis_2 = 4;
                        emphasis_3 = 5;
                     };

                     ribbon_selected = {
                        base = 0;
                        background = 2;
                        emphasis_0 = 1;
                        emphasis_1 = 9;
                        emphasis_2 = 5;
                        emphasis_3 = 4;
                     };

                     table_title = {
                        base = 2;
                        background = 0;
                        emphasis_0 = 9;
                        emphasis_1 = 6;
                        emphasis_2 = 2;
                        emphasis_3 = 5;
                     };

                     table_cell_unselected = {
                        base = 15;
                        background = 0;
                        emphasis_0 = 9;
                        emphasis_1 = 6;
                        emphasis_2 = 2;
                        emphasis_3 = 5;
                     };

                     table_cell_selected = {
                        base = 15;
                        background = 8;
                        emphasis_0 = 9;
                        emphasis_1 = 6;
                        emphasis_2 = 2;
                        emphasis_3 = 5;
                     };

                     list_unselected = {
                        base = 15;
                        background = 0;
                        emphasis_0 = 9;
                        emphasis_1 = 6;
                        emphasis_2 = 2;
                        emphasis_3 = 5;
                     };

                     list_selected = {
                        base = 15;
                        background = 8;
                        emphasis_0 = 9;
                        emphasis_1 = 6;
                        emphasis_2 = 2;
                        emphasis_3 = 5;
                     };

                     frame_selected = {
                        base = 2;
                        background = 0;
                        emphasis_0 = 9;
                        emphasis_1 = 6;
                        emphasis_2 = 5;
                        emphasis_3 = 0;
                     };

                     frame_highlight = {
                        base = 9;
                        background = 0;
                        emphasis_0 = 5;
                        emphasis_1 = 9;
                        emphasis_2 = 9;
                        emphasis_3 = 9;
                     };

                     exit_code_success = {
                        base = 2;
                        background = 0;
                        emphasis_0 = 6;
                        emphasis_1 = 0;
                        emphasis_2 = 5;
                        emphasis_3 = 4;
                     };

                     exit_code_error = {
                        base = 1;
                        background = 0;
                        emphasis_0 = 3;
                        emphasis_1 = 0;
                        emphasis_2 = 0;
                        emphasis_3 = 0;
                     };

                     multiplayer_user_colors = {
                        player_1 = 5;
                        player_2 = 4;
                        player_3 = 0;
                        player_4 = 3;
                        player_5 = 6;
                        player_6 = 0;
                        player_7 = 1;
                        player_8 = 0;
                        player_9 = 0;
                        player_10 = 0;
                     };
                  };
               };
            };
         };
         attachExistingSession = false;

      };
}
