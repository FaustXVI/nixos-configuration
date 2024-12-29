{ config, pkgs, ... }:

{
  environment = {
    systemPackages = with pkgs; [
      wget
      usbutils
      file
      zip
      unzip
      psmisc
      ncdu
    ];
  };
}
