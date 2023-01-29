{ lib, config, pkgs, ... }:

let
  mylib = import ../utils.nix { inherit lib config; };
in {
  config = mylib.mkIfComputerHasPurpose "work" {
    environment = {
      systemPackages = with pkgs; [
        slack
      ];
    };
  };

}
