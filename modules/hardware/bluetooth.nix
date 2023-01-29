{ config, pkgs, lib, ... }:

let
  mylib = import ../utils.nix { inherit lib config; };
in {
  config = mylib.mkIfComputerIs "laptop" {
    hardware = {
      bluetooth = {
        enable = true;
      };
    };
  };
}
