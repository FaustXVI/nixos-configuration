{ config, pkgs, ... }:

{
  imports =
    [
      ../hardware-configuration.nix
      ../modules/hardware/laptop.nix
      ../modules/home.nix
    ];

    services = {
      xserver = {
        dpi = 150;
      };
    };
    system.stateVersion = "21.05";
  }
