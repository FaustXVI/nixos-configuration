{ config, pkgs, ... }:

{
  imports =
    [
      ../hardware-configuration.nix
      ../modules
    ];

    xadetComputer = {
      type = "laptop";
      purposes = [ "home" ];
    };
    services = {
      xserver = {
        dpi = 150;
      };
    };
    system.stateVersion = "21.05";
  }
