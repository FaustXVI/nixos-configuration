{ config, pkgs, ... }:

{
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
