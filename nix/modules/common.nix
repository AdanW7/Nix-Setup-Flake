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

      #dart
      # haskell-language-server

      bash-language-server

      texlab
      bibtex-tidy

      marksman
      nixd
      # nimlangserver

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
      #ols
      # odin-dev
      ruff

      taplo-lsp

   ];
}
