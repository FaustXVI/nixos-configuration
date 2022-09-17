# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, pkgs, ... }:

{
  imports =
    [ # Include the results of the hardware scan.
    ../commons.nix
    ../gaming.nix
    ../luks.nix
    ../nas.nix
    ../home-printer.nix
  ];


  boot = {
    loader = {
      systemd-boot = {
        enable = true;
      };
      efi = {
        canTouchEfiVariables = true;
      };
    };
  };

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
}
