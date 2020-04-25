# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, pkgs, ... }:

{
  imports =
    [ # Include the results of the hardware scan.
    <home-manager/nixos>
    ./hardware-configuration.nix
    ./keyboard.nix
    ./acpi.nix
    ./network.nix
    ./gui.nix
    ./users.nix
    ./system-packages.nix
    ./virtualisation.nix
    ./yubikey.nix
  ];

  i18n = {
    defaultLocale = "en_US.UTF-8";
  };

  console = {
    font = "Lat2-Terminus16";
    keyMap = "fr";
  };

  time.timeZone = "Europe/Paris";

  system = {
    stateVersion = "20.03";
    autoUpgrade = {
      enable = true;
      dates = "13:00";
    };
  };

  nixpkgs = {
    config = {
      allowUnfree = true;
    };
  };

  hardware = {
    pulseaudio = {
      enable = true;
      support32Bit = true;
      package = pkgs.pulseaudioFull;
    };
  };
  boot.kernel.sysctl = {
    "kernel.sysrq" = 0;
    };
    }
