{ config, pkgs, ... }:

{
  environment = {
    systemPackages = with pkgs; [
      wget
      usbutils
      tree
      file
      zip
      unzip
      htop
    ];
  };
#  programs = {
#    dconf = {
#      enable = true;
#    };
#  };
}
