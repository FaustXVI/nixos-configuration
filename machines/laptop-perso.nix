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
    system.stateVersion = "21.05";
  }
