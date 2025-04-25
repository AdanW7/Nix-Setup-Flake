{ pkgs, ... }: {
  environment.systemPackages = with pkgs; [
    # nvim
    vim
    git
  ];
}
