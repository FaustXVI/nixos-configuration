{ config, pkgs, ... }:

{
  imports =
    [
      ../hardware-configuration.nix
      ../modules/hardware/laptop.nix
      ../modules/work.nix
    ];

    services = {
      xserver = {
        dpi = 96;
        videoDrivers = [ "nvidia" ];
        displayManager = {
          sessionCommands = ''
                    xrandr --output DP-3 --mode 1920x1080 --output HDMI-0 --mode 2560x1080 --left-of DP-3 --primary &
          '';
        };
      };
    };

    system.stateVersion = "21.05";
  }
