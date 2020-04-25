{ config, pkgs, ... }:

{
  environment = {
    systemPackages = with pkgs; [
      dmenu
      i3status
      i3lock
      libnotify
      gnome3.defaultIconTheme
      dunst
    ];
    shellInit = ''
      gpg-connect-agent /bye
      export SSH_AUTH_SOCK=$(gpgconf --list-dirs agent-ssh-socket)
    '';
  };
  services = {
    xserver = {
      enable = true;
      synaptics = {
        enable = true;
        twoFingerScroll = true;
        tapButtons = true;
      };
      windowManager = {
        i3 = {
          enable = true;
        };
      };
      desktopManager = {
        wallpaper = {
          mode = "center";
        };
      };
      displayManager = {
        defaultSession = "none+i3";
        sessionCommands = ''
                    ${pkgs.networkmanagerapplet}/bin/nm-applet &
                    ${pkgs.udiskie}/bin/udiskie -a -t -n -F &
        '';
        lightdm = {
          enable = true;
        };
      };
    };
  };
}
