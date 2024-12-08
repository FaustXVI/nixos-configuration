{ config, pkgs, ... }:

{
  hardware = {
    graphics = {
      enable = true;
    };
  };
  environment = {
    systemPackages = with pkgs; [
      dmenu
      i3status
      i3lock
      libnotify
      adwaita-icon-theme
      dunst
      arandr
      autorandr
      udiskie
      pasystray
      nautilus
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
