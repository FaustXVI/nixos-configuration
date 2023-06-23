{ config, pkgs, ... }:

{
  users.groups.plugdev.members = [ "xadet" ];
  services = {
    udev = {
      extraRules = ''
        SUBSYSTEM=="usb", ATTR{idVendor}=="18d1", MODE="0666", GROUP="plugdev"
      '';
    };
  };
}
