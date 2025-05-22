# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

# {inputs,pkgs,lib, config, ... }:
{inputs,pkgs,lib, ... }:
let 
  username = "adan";

in

{
   imports =
   [ # Include the results of the hardware scan.
      ./hardware-configuration.nix
      ./../../modules/common.nix
      inputs.home-manager.nixosModules.home-manager
   ];


   # Enable Flakes
   nix.settings.experimental-features = ["nix-command" "flakes"];

   # Bootloader.
   boot.loader.systemd-boot.enable = true;
   boot.loader.efi.canTouchEfiVariables = true;

   networking = {
      hostName = "nixos";
      # wireless.enable = true;
      # proxy.default = "http://user:password@proxy:port/";
      # proxy.noProxy = "127.0.0.1,localhost,internal.domain";
      networkmanager.enable = true;
      firewall.allowedTCPPorts = [ 
         22 
         2222
      ];
      # firewall.allowedUDPPorts = [ ... ];
      firewall.enable = false;
      # interfaces.enp1s0.useDHCP = true;
      # interfaces.wlp2s0.useDHCP = true;
   };


   # Set your time zone.
   time.timeZone = "America/Chicago";

   # Select internationalisation properties.
   i18n.defaultLocale = "en_US.UTF-8";

   i18n.extraLocaleSettings = {
      LC_ADDRESS = "en_US.UTF-8";
      LC_IDENTIFICATION = "en_US.UTF-8";
      LC_MEASUREMENT = "en_US.UTF-8";
      LC_MONETARY = "en_US.UTF-8";
      LC_NAME = "en_US.UTF-8";
      LC_NUMERIC = "en_US.UTF-8";
      LC_PAPER = "en_US.UTF-8";
      LC_TELEPHONE = "en_US.UTF-8";
      LC_TIME = "en_US.UTF-8";
   };

   # Define a user account. Don't forget to set a password with ‘passwd’.
   users.users.adan = {
      isNormalUser = true;
      description = "adan";
      extraGroups = [ "networkmanager" "wheel" ];
      shell = pkgs.zsh;
      # packages = with pkgs; [];
   };

   # Allow unfree packages
   nixpkgs.config.allowUnfree = true;

   # List packages installed in system profile. To search, run:
   # $ nix search wget
   environment.systemPackages = with pkgs; [
      killall
      zsh
      wget
      curl

      ghostty
      kitty

      waybar
      dunst
      libnotify
      swww
      rofi-wayland

      kdePackages.gwenview
      kdePackages.dolphin
      gnome-disk-utility

      wl-clipboard

      fastfetch

      firefox
      google-chrome

      protontricks
      protonup
   ];

   services = {
      openssh = {
         enable = true;
         ports = [
            22 
            2222
         ];
         settings = {
            UseDns = true;
            PasswordAuthentication = true;
            AllowUsers = null;
            X11Forwarding = true;
            PermitRootLogin = "prohibit-password";
         }
         ;
      };
      avahi = {
         enable = true;
         openFirewall = true;
         nssmdns4 = true;
         nssmdns6 = true;
         publish = {
            enable = true;
            userServices = true;
            addresses = true;
         };
      };
      xserver = {
         xkb = {
            layout = "us";
            variant = "";
         };
         enable = true;
         displayManager.gdm.enable = true;
         videoDrivers = [ "amdgpu" ];
      };
      displayManager = {
         autoLogin.enable = true;
         autoLogin.user = "adan";
      };
      udisks2.enable = true;
   };


   # This value determines the NixOS release from which the default
   # settings for stateful data, like file locations and database versions
   # on your system were taken. It‘s perfectly fine and recommended to leave
   # this value at the release version of the first install of this system.
   # Before changing this value read the documentation for this option
   # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
   system.stateVersion = "24.11"; # Did you read the comment?
   system.configurationRevision = inputs.self.rev or inputs.self.dirtyRev or null;

   fonts = {
      fontconfig.enable=true;
      packages = with pkgs; [
         nerd-fonts.symbols-only
         font-awesome
         noto-fonts
         nerd-fonts.mononoki
         nerd-fonts.jetbrains-mono
      ];
   };

   programs = {
      hyprland= {
         enable = true;
         xwayland.enable = true;
      };
      steam = {
         enable = true;
         gamescopeSession.enable = true;
      };
      zsh = {
         enable = true;
      };
   };

   environment.sessionVariables = {
      NIXOS_OZON_WL = 1;
      STEAM_EXTRA_COMPAT_TOOLS_PATHS = "/home/adan/.steam/root/compatibilitytools.d";
   };
  
   home-manager = {
      useGlobalPkgs = true;
      useUserPackages = true;
      verbose = true;

      users.${username} = import ./home.nix {
         inherit pkgs lib;
         system = "x86_64-linux";
         homeDirectory = "/home/${username}";
         inherit (inputs) Adan-nixvim;
      };
   };

}
