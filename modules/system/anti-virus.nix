{ config, pkgs, ... }:

{
  services = {
    clamav = {
      daemon. enable = true;
      updater.enable = true;
    };
  };
}
