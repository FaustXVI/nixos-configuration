{ config, pkgs, ... }:

{
  environment = {
    systemPackages = with pkgs; [
        dysk
        zellij
    ];
  };
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
