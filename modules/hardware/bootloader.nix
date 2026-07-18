{ config, pkgs, ... }:

{
  services.fwupd.enable = true;
  boot = {
    tmp.cleanOnBoot = true;
    loader = {
      systemd-boot = {
        enable = true;
      };
      efi = {
        canTouchEfiVariables = true;
      };
    };
  };
}
