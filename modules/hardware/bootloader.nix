{ config, pkgs, ... }:

{
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
