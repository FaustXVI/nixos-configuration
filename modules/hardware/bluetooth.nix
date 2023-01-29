{ config, pkgs, lib, ... }:

let
  mylib = import ../utils.nix { inherit lib config; };
in {
  config = mylib.mkIfComputerIs "laptop" {
    environment = {
      systemPackages = with pkgs; [
        blueman
      ];
    };
    hardware = {
      bluetooth = {
        enable = true;
      };
    };
  };
}
