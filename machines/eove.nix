# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, pkgs, ... }:

{
  imports =
    [ # Include the results of the hardware scan.
    ../commons.nix
    ../luks.nix
  ];

  boot = {
    kernelPackages = pkgs.linuxPackages_latest;
    loader = {
      systemd-boot = {
        enable = true;
      };
      efi = {
        canTouchEfiVariables = true; 
      };
    };
    kernelParams = [ "acpi_osi=linux" "module_blacklist=hid_sensor_hub" ];
  };
  services = {
    xserver = {
      dpi = 96;
    };
    printing = {
      enable = true;
      drivers = [ pkgs.gutenprint ];
    };
  };
  hardware = {
    bluetooth = {
      enable = true;
    };
  };
  programs.light.enable = true;
}
