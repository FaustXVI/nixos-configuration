{ mylib, pkgs, ... }:

{
  config = mylib.mkIfComputerHasPurpose "photo" {
    environment = {
      systemPackages = with pkgs; [
        gimp
        rawtherapee
        shotwell
      ];
    };
  };
}
