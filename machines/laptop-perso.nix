{ config, pkgs, ... }:

{
  imports =
    [
      ../hardware-configuration.nix
      ../modules/hardware/laptop.nix
      ../modules/home.nix
    ];

    system.stateVersion = "21.05";
  }
