{ config, pkgs, ... }:

{
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
    shellInit = ''
      gpg-connect-agent /bye
      export SSH_AUTH_SOCK=$(gpgconf --list-dirs agent-ssh-socket)
    '';
  };
  services = {
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
        defaultSession = "none+i3";
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
