{ mylib, pkgs, ... }:

{
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
