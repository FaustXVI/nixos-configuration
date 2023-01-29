{ lib, config, pkgs, ... }:

let
  mylib = import ../utils.nix { inherit lib config; };
in {
  config = mylib.mkIfComputerHasPurpose "photo" {
    environment = {
      systemPackages = with pkgs; [
        gimp
        rawtherapee
        shotwell
      ];
    };
  };
}
