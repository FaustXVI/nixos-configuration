{ config, pkgs, ... }:

{
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
}
