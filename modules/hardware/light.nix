{ lib, config, pkgs, ... }:

let
  mylib = import ../utils.nix { inherit lib config; };
in {
  config = mylib.mkIfComputerIs "laptop" {
    programs.light.enable = true;
  };
}
