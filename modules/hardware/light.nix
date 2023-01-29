{ lib, config, pkgs, mylib, ... }:

{
  config = mylib.mkIfComputerIs "laptop" {
    programs.light.enable = true;
  };
}
