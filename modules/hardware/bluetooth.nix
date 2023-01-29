{ config, pkgs, lib, mylib, ... }:

{
  config = mylib.mkIfComputerIs "laptop" {
    hardware = {
      bluetooth = {
        enable = true;
      };
    };
  };
}
