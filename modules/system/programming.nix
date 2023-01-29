{ config, pkgs, ... }:

{
  environment = {
    systemPackages = with pkgs; [
      git
      gnumake
      automake
      gcc
    ];
  };
}
