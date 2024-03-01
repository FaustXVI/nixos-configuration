{ config, pkgs, ... }:

{
  imports =
    [
      ./desktop-home-hardware.nix
      ../modules
    ];
  xadetComputer = {
    type = "desktop";
    purposes = [ "home" "gaming" "youtube" "photo" "home-office" ];
  };

  services = {
    xserver = {
      dpi = 96;
      displayManager = {
        sessionCommands = ''
          xrandr --output DP-3 --mode 1920x1080 --output HDMI-0 --mode 2560x1080 --left-of DP-3 --primary &
        '';
      };
    };
  };

  system.stateVersion = "21.05";
  time.hardwareClockInLocalTime = true;
}
