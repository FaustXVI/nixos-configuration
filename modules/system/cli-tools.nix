{ config, pkgs, ... }:

{
  environment = {
    systemPackages = with pkgs; [
      entr
      wget
      usbutils
      tree
      file
      zip
      unzip
      htop
      psmisc
    ];
  };
}
