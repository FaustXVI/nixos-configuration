{ mylib, config, pkgs, ... }:

{
  config = mylib.mkIfComputerHasPurpose "3dPrinting" {
    environment = {
      systemPackages = with pkgs; [
        freecad-wayland
      ];
    };
  };

}
