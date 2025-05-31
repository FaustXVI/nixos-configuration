{ mylib, pkgs, ... }:

{
  config = mylib.mkIfComputerHasPurpose "gaming" {
    environment = {
      systemPackages = with pkgs; [
        steam
        discord
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
