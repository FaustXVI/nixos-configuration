{ config, pkgs, ... }:

{
  hardware = {
    opengl = {
      enable = true;
    };
  };
  environment = {
    systemPackages = with pkgs; [
      dmenu
      i3status
      i3lock
      libnotify
      gnome3.adwaita-icon-theme
      dunst
      arandr
      autorandr
      udiskie
      pasystray
      gnome.nautilus
    ];
  };
  services = {
    udisks2 = {
      enable = true;
    };
      displayManager = {
        defaultSession = "none+i3";
      };
    xserver = {
      enable = true;
      windowManager = {
        i3 = {
          enable = true;
        };
      };
      desktopManager = {
        wallpaper = {
          mode = "max";
        };
      };
      displayManager = {
        sessionCommands = ''
          ${pkgs.networkmanagerapplet}/bin/nm-applet &
          ${pkgs.udiskie}/bin/udiskie -a -t -n -F &
          ${pkgs.pasystray}/bin/pasystray &
        '';
        lightdm = {
          enable = true;
        };
      };
    };
  };
}
