{ config, pkgs, ... }:

{
  environment.systemPackages = [
    pkgs.jnv
    pkgs.sig
  ];
  programs = {
    bash = {
      completion = {
        enable = true;
      };
    };
    fish = {
      enable = true;
    };
  };
}
