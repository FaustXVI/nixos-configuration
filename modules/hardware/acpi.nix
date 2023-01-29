{ lib, config, pkgs, ... }:

let
  mylib = import ../utils.nix { inherit lib config; };
in {
  config = mylib.mkIfComputerIs "laptop" {
    environment.systemPackages = with pkgs; [
      acpi
    ];

    services = {
      acpid = {
        enable = true;
      };
    };
  };

}
