{ lib, config, pkgs, ... }:

let
  mylib = import ../utils.nix { inherit lib config; };
in {
  config = mylib.mkIfComputerHasPurpose "gaming" {
    environment = {
      systemPackages = with pkgs; [
        steam
        discord
        xboxdrv
      ];
    };

    hardware = {
      opengl = {
        driSupport32Bit = true;
        extraPackages32 = [ pkgs.pkgsi686Linux.libva ];
      };
    };
  };
}
