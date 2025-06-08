{ pkgs, ... }: {
   environment.systemPackages = with pkgs; [
      vim
      gnumake

      git-credential-manager
      git

      zig
      zls
      lldb_20

      clang-tools     
      cmake           
      libcxx          


      bash-language-server

      texlab
      bibtex-tidy

      nil

      cargo
      rustc 
      rust-analyzer
      rustfmt

      typescript-language-server

      # gleam

      # go
      # gopls

      vscode-langservers-extracted
      jdt-language-server

      # kotlin
      # kotlin-language-server

      lua-language-server

      # ocaml
      ruff

      taplo-lsp

   ];
}
