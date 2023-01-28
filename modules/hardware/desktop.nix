# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, pkgs, ... }:

{
  imports =
    [ # Include the results of the hardware scan.
    ./keyboard.nix
    ./network.nix
    ./gui.nix
    ./virtualisation.nix
    ./yubikey.nix
    ./luks.nix
    ./time.nix
    ./sound.nix
    ./ntfs.nix
    ./power-button.nix
    ./printing.nix
    ./bootloader.nix
  ];
}
