{ pkgs, ... }: {
   environment.systemPackages = with pkgs; [
      vim

      git-credential-manager
      git

      ghostty

      yazi
   ];
}
