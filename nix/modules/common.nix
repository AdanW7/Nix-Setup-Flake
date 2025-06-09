{ pkgs, ... }: {
   environment.systemPackages = with pkgs; [
      vim

      git-credential-manager
      git

      # ghostty #currenly broken

      yazi
   ];
}
