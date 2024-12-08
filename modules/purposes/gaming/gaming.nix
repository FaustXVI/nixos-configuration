{ mylib, pkgs, ... }:

{
  config = mylib.mkIfComputerHasPurpose "gaming" {
    environment = {
      systemPackages = with pkgs; [
        steam
        discord
        xboxdrv
      ];
    };

    hardware = {
      graphics = {
        enable32Bit = true;
        extraPackages32 = [ pkgs.pkgsi686Linux.libva ];
      };
    };
  };
}
