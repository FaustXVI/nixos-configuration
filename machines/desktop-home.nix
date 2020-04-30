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
      grub = {
        enable = true;
        device = "nodev";
        useOSProber = true;
        efiSupport = true;
      };
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
                    xrandr --output HDMI-0 --off --output DP-5 --mode 1920x1080 --output DP-2 --mode 2560x1080 --left-of DP-5 --primary &
                    ${pkgs.pasystray}/bin/pasystray &
        '';
      };
    };
  };
}
