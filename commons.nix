# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, pkgs, ... }:

let
  sops-nix-version = "master";
  sops-nix-url = "https://github.com/Mic92/sops-nix/archive/${sops-nix-version}.tar.gz";
in {
  imports =
    [ # Include the results of the hardware scan.
    <home-manager/nixos>
    ./sops.nix
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
    autoUpgrade = {
      enable = true;
      dates = "13:00";
    };
  };

  nix = {
    gc = {
      dates = "weekly";
      automatic = true;
    };
    optimise = {
      dates = [ "weekly" ];
      automatic = true;
    };
  };

  hardware = {
    pulseaudio = {
      enable = true;
      support32Bit = true;
      package = pkgs.pulseaudioFull;
    };
  };
  boot = {
    supportedFilesystems = [ "ntfs" ];
    kernel.sysctl = {
      "kernel.sysrq" = 0;
    };
  };
}
