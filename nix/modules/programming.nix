{ pkgs, ... }: {
   environment.systemPackages = with pkgs; [
      gnumake

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

      marksman #markdown
      nixd #/nix lang

      # nimlangserver

      cargo
      rustc 
      rust-analyzer
      rustfmt

      typescript-language-server

      gleam

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
      ruff #python
      pyright

      taplo-lsp #toml

   ];
}
